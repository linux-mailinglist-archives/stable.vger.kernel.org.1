Return-Path: <stable+bounces-199470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C7CCA0036
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 17:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01F19300095C
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 16:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A9735BDDB;
	Wed,  3 Dec 2025 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OATzdd43"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF1233E36A;
	Wed,  3 Dec 2025 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779904; cv=none; b=Ugi7ofy6AfTA2qpcBqdLtUBg9+PvunKPmma2ef5XPNqDGepbvdQijEZlGsfGViqluAzMbiWND1Z8OjDaoUGoLH9xnIm8OR3GzWIW4utSpbuKqFcgDHq0dMtTkBo9sAsNzWvQGROzI0V26Rcy3f/HgPHsPryIAdvqGAeSYJsmK38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779904; c=relaxed/simple;
	bh=YuutO9no87joUamNLX3hgFkeV71TaZwIprJU1T1TdaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVStltO83YaGoqrQdITIWDLj/5oQ8cpsH3ua8XY6V9SY1tp3yH/9cAMNQrf3D1psyYvoUXOFubZSy8nGDqXsie9QwZ269jAgeUK8FyEUdy8Qr8PT+ZVfzi0G27SX4sq/3zqbqScPzECYK1MdIdgyBX6IWggEqF7OoPwlIyv4eYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OATzdd43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DDCC4CEF5;
	Wed,  3 Dec 2025 16:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764779904;
	bh=YuutO9no87joUamNLX3hgFkeV71TaZwIprJU1T1TdaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OATzdd431RiwuwvaZD0kkAhYl8bBVTf0qRmVsYU70pGnQIJ+L3qZE5C1zCFWLmF0D
	 cSIGrT+Td9ofpQGsyeYF2jXk78W+LtiruPkxaCkrXcSvmQp2IcBEDoWNWEugNgf3yU
	 GQXLFR9iS+slsFqRI2lFjOWl50Pkg7EBdYZoXFMI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joshua Rogers <linux@joshua.hu>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 398/568] ksmbd: close accepted socket when per-IP limit rejects connection
Date: Wed,  3 Dec 2025 16:26:40 +0100
Message-ID: <20251203152455.268985788@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152440.645416925@linuxfoundation.org>
References: <20251203152440.645416925@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joshua Rogers <linux@joshua.hu>

commit 98a5fd31cbf72d46bf18e50b3ab0ce86d5f319a9 upstream.

When the per-IP connection limit is exceeded in ksmbd_kthread_fn(),
the code sets ret = -EAGAIN and continues the accept loop without
closing the just-accepted socket. That leaks one socket per rejected
attempt from a single IP and enables a trivial remote DoS.

Release client_sk before continuing.

This bug was found with ZeroPath.

Cc: stable@vger.kernel.org
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/transport_tcp.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -282,8 +282,11 @@ static int ksmbd_kthread_fn(void *p)
 			}
 		}
 		up_read(&conn_list_lock);
-		if (ret == -EAGAIN)
+		if (ret == -EAGAIN) {
+			/* Per-IP limit hit: release the just-accepted socket. */
+			sock_release(client_sk);
 			continue;
+		}
 
 skip_max_ip_conns_limit:
 		if (server_conf.max_connections &&



