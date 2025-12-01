Return-Path: <stable+bounces-197806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B175C96FA9
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 12:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0F9134737E
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 11:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8015B258CDF;
	Mon,  1 Dec 2025 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m36sn1fl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3372B2D73B0;
	Mon,  1 Dec 2025 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588578; cv=none; b=HEeSPWwZrWTCoKfgQWxciepAZIgoUdgBaHd0WWH6zlfKBB7i3O7lyt91p19Me2hQUqCVkLHbmE7XySTdw4OhQoYlUU59uUNdpE23b4ZnlS/UI7gA0rxyCZHwVWbXsmiZpK05hw0JNsWxDLJsOqhcKCgFz+jlP8AYSQvL9v+q1iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588578; c=relaxed/simple;
	bh=EA721z1+yPlZpmo4jelYQSwf52dWN4RXsasO4tx7cIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B66eTFdyuAcrDdiR6fZKwHDk+HhTVH30Pdhi5Y4//fRaAtpxsgugvom1jdhR7tEW+eYkP0AJB0sMkcYuziKtoqHlYX9Nd3rBwrHW/XuXlUTdlLocot/6lSFApfmrKd9ljyoZ3OmKw8ZzzTYBcu5HEw/Y+L95i//QyrEv+lNMYI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m36sn1fl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC7DC4CEF1;
	Mon,  1 Dec 2025 11:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764588578;
	bh=EA721z1+yPlZpmo4jelYQSwf52dWN4RXsasO4tx7cIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m36sn1flWZGWAceGrc/PkNoxxKnfipgts8HJBn9btR9QC8VrVItX6a9bURo+6V3jl
	 3LjytMDTGqBkGS5iS5fiHXa+ubQhmPPCDdJyNNIUbAFyeQEjoNcwgjGpwbnIDMNyJ2
	 A/GLtrAvn5j4UZvZhVDH5pvCvmMbw/oDIcWyPZuI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Olga Kornievskaia <okorniev@redhat.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 098/187] NFSv4: handle ERR_GRACE on delegation recalls
Date: Mon,  1 Dec 2025 12:23:26 +0100
Message-ID: <20251201112244.780402058@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201112241.242614045@linuxfoundation.org>
References: <20251201112241.242614045@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Olga Kornievskaia <okorniev@redhat.com>

[ Upstream commit be390f95242785adbf37d7b8a5101dd2f2ba891b ]

RFC7530 states that clients should be prepared for the return of
NFS4ERR_GRACE errors for non-reclaim lock and I/O requests.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 44770bb9017d5..7a4d7158c55f2 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7315,10 +7315,10 @@ int nfs4_lock_delegation_recall(struct file_lock *fl, struct nfs4_state *state,
 		return err;
 	do {
 		err = _nfs4_do_setlk(state, F_SETLK, fl, NFS_LOCK_NEW);
-		if (err != -NFS4ERR_DELAY)
+		if (err != -NFS4ERR_DELAY && err != -NFS4ERR_GRACE)
 			break;
 		ssleep(1);
-	} while (err == -NFS4ERR_DELAY);
+	} while (err == -NFS4ERR_DELAY || err == -NFSERR_GRACE);
 	return nfs4_handle_delegation_recall_error(server, state, stateid, fl, err);
 }
 
-- 
2.51.0




