Return-Path: <stable+bounces-224366-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOBNAcAEsGlAegIAu9opvQ
	(envelope-from <stable+bounces-224366-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:47:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B2024B882
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDAEC3094B7B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6DD38E114;
	Tue, 10 Mar 2026 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvRZBDZ+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D110387562;
	Tue, 10 Mar 2026 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142062; cv=none; b=EJVOQTNL2dV23rZrUiSwWG2TafGjtntTjSUKMaWMgcVNL1O0hbkfCvV2Qg3v+xa8Qg5H2ArtWybMLY8UxzzKzV4bnYxuMENWrVhCjkL0CRgH41vrX63fRd7AgUt609Ii9fE3ac+Q09fVXgZ3TZWEC5w76awUaQ9J6BWC+O7N+1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142062; c=relaxed/simple;
	bh=A1hCgKFnypW4LK2yCvcoAw4KxK75MGEbbJkD/m4TcoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBasGEJAWDgE+lqlaxNx7yH1Z9cghzp2uPA/03Z7vV2LEpjYtIzdUnpKcAPBiA2BJTCESm4kfGuaRn2c0RkVvi73+tSUAZgvqn33Trz/P1GKshgM/BHx9KjAdnd2EvnR1088UoJJnEO5YDpBLnhg+1Ldh9ZZEeZFjRgAwPCF13s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvRZBDZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1545C19423;
	Tue, 10 Mar 2026 11:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142061;
	bh=A1hCgKFnypW4LK2yCvcoAw4KxK75MGEbbJkD/m4TcoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZvRZBDZ+cf6vCtF2hIvL+hV3TJsZ2wseHS+3yLODDKuODmAClulAK6AxBg1gKHhtV
	 acaouohG489gLNxrcHsZJrEC4z7uMJSeLwL2buIhn4BMhvhSws3/s+f9Fm83Cny4dR
	 MFDLX1NJ4v89FR2XIxfFjl+Yb+QJEXYFzeqf2zRrfKv38e7XzKOyGHzDgEindQIWqO
	 6U3OLzjqbjtZfix0wfpBFPcu+MaHq+zhQaHUQrECdb5Fl/5tMCS9qBFQS6Tp49x4BS
	 DySpCGlANiOKmFB2kwIqxA9yGBJKXT7J1SdSV5yH4VtPum6OkHDyzrMf5Obm5Rv1E/
	 zgdfgTyO6Nm6g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Thiago Becker <tbecker@redhat.com>,
	David Howells <dhowells@redhat.com>,
	linux-cifs@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18 187/314] smb: client: fix oops due to uninitialised var in smb2_unlink()
Date: Tue, 10 Mar 2026 07:17:26 -0400
Message-ID: <64138396a360d21337687e5ed4267c66825e8585.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 37B2024B882
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224366-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:email,manguebit.org:email]
X-Rspamd-Action: no action

From: Paulo Alcantara <pc@manguebit.org>

commit 048efe129a297256d3c2088cf8d79515ff5ec864 upstream.

If SMB2_open_init() or SMB2_close_init() fails (e.g. reconnect), the
iovs set @rqst will be left uninitialised, hence calling
SMB2_open_free(), SMB2_close_free() or smb2_set_related() on them will
oops.

Fix this by initialising @close_iov and @open_iov before setting them
in @rqst.

Reported-by: Thiago Becker <tbecker@redhat.com>
Fixes: 1cf9f2a6a544 ("smb: client: handle unlink(2) of files open by different clients")
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-cifs@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smb2inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 69cb81fa0d3ab..5c25f25aa2efb 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -1205,6 +1205,7 @@ smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 	memset(resp_buftype, 0, sizeof(resp_buftype));
 	memset(rsp_iov, 0, sizeof(rsp_iov));
 
+	memset(open_iov, 0, sizeof(open_iov));
 	rqst[0].rq_iov = open_iov;
 	rqst[0].rq_nvec = ARRAY_SIZE(open_iov);
 
@@ -1229,14 +1230,15 @@ smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 	creq = rqst[0].rq_iov[0].iov_base;
 	creq->ShareAccess = FILE_SHARE_DELETE_LE;
 
+	memset(&close_iov, 0, sizeof(close_iov));
 	rqst[1].rq_iov = &close_iov;
 	rqst[1].rq_nvec = 1;
 
 	rc = SMB2_close_init(tcon, server, &rqst[1],
 			     COMPOUND_FID, COMPOUND_FID, false);
-	smb2_set_related(&rqst[1]);
 	if (rc)
 		goto err_free;
+	smb2_set_related(&rqst[1]);
 
 	if (retries) {
 		for (int i = 0; i < ARRAY_SIZE(rqst);  i++)
-- 
2.51.0


