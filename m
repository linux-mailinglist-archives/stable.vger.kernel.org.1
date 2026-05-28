Return-Path: <stable+bounces-255554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDQjN/OjGGrClggAu9opvQ
	(envelope-from <stable+bounces-255554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:22:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1EC5F87A5
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8314C318186B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481D53F870F;
	Thu, 28 May 2026 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n71fZqY6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A5633F5BE;
	Thu, 28 May 2026 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999239; cv=none; b=rVnjtRFPPlazEhjFLsylYiBNLqdwig0MwIvj96nPYsUxM/N/KMZqOImJlwWOEn5YNt0YPLEBIVcshcZGZDuEcW3A2Umv8kdzjdWOgzKbw7ZOZYfLlf8nKGZ4APP58p/aoGA4QaHaHaZ05ivbMvEBCKeLQSprsTH2km8gIcD8hAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999239; c=relaxed/simple;
	bh=egoPgRTZ3HnE9OueR6YgmesBmYkAA++SpETfHtL/n94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHOu639wyKesKZfMRU1JWUlYrSvX10gXs0myn2r+r3T20flK1z14OK7wFxdEFl2viJG5MJ/VyRLc5c7BdvnuN9KrXvl18ZNH4fS/dZbrcutHWuRQVyBDzDxADpCqiT6MHiLYxYLMfeFfWRskONQEoYv6/q2JI/21vrXqa90kpU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n71fZqY6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775CA1F000E9;
	Thu, 28 May 2026 20:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999238;
	bh=qtPPyCkyo+2PlptNFJo2HQv3v3krPxpB6TRogkUxAy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n71fZqY6X0RUVG42Jy65d9uIBoA1kXf5WhrI3XKXxyxHzaLqfU9wsrnLk3R2nMxUI
	 +5PqtbodM9SV2EzToAFxRcNQvf8SaZT+vze0O3jNodtJ8+GRu7yR35B0I8bsrlBUD7
	 myFw6KpOt3KBNAsGtJEcVfeyFyUJxnc8cr2/YiHU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Junyi Liu <moss80199@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 457/461] ksmbd: fix durable reconnect error path file lifetime
Date: Thu, 28 May 2026 21:49:46 +0200
Message-ID: <20260528194700.769634233@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,microsoft.com];
	TAGGED_FROM(0.00)[bounces-255554-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4C1EC5F87A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junyi Liu <moss80199@gmail.com>

[ Upstream commit 3515503322f4819277091839eed46b695096aca5 ]

After a durable reconnect succeeds, ksmbd_reopen_durable_fd() republishes
the same ksmbd_file into the session volatile-id table. If smb2_open()
then takes a later error path, cleanup first calls ksmbd_fd_put(work, fp)
and then unconditionally calls ksmbd_put_durable_fd(dh_info.fp).

In this case fp and dh_info.fp are the same object. The first put drops the
reconnect lookup reference, but the final durable put can run
__ksmbd_close_fd(NULL, fp). Because the final close is not session-aware,
it can free the file object without removing the volatile-id entry that was
just published into the session table.

Use the session-aware put for the final reconnect drop when the reconnect
had already succeeded and the error path is cleaning up the republished
file. Earlier reconnect failures, before fp is assigned to dh_info.fp, keep
using the durable-only put path.

Fixes: 1baff47b81f9 ("ksmbd: fix use-after-free in smb2_open during durable reconnect")
Signed-off-by: Junyi Liu <moss80199@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index c3c7688f0fa80..3a8a739c025fb 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3803,8 +3803,19 @@ int smb2_open(struct ksmbd_work *work)
 		ksmbd_debug(SMB, "Error response: %x\n", rsp->hdr.Status);
 	}
 
-	if (dh_info.reconnected)
-		ksmbd_put_durable_fd(dh_info.fp);
+	if (dh_info.reconnected) {
+		/*
+		 * If reconnect succeeded, fp was republished in the
+		 * session file table.  On a later error, ksmbd_fd_put()
+		 * above drops the session reference; drop the durable
+		 * lookup reference through the same session-aware path so
+		 * final close removes the volatile id before freeing fp.
+		 */
+		if (rc && fp == dh_info.fp)
+			ksmbd_fd_put(work, dh_info.fp);
+		else
+			ksmbd_put_durable_fd(dh_info.fp);
+	}
 
 	kfree(name);
 	kfree(lc);
-- 
2.53.0




