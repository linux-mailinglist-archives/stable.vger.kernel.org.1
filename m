Return-Path: <stable+bounces-244283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NlrKaRy+mkDPAMAu9opvQ
	(envelope-from <stable+bounces-244283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:43:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8934D4715
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 00:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A5C33048F2A
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 22:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EE832548B;
	Tue,  5 May 2026 22:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/aY6MeE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73672EB856;
	Tue,  5 May 2026 22:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778021019; cv=none; b=EHsxVkXkqA6sL15oV2IquOlITVc4cyazu2TG6T0UhH1h8tXi2Yxq/qvr22fKT5hpuzjMYuYbo/v+i/BELSTI0SbJGNieFB4RBFYKgU1btmSlhRP7JNOiYZqgdlFr2smNiG7jVoInFr78x13SjdJcUDBwMIorIyeU8ov0kZBEFTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778021019; c=relaxed/simple;
	bh=0wQyfIPOLVqOSSQDH32X9XpB1NsPFRS8W6WD+ZVR0sM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fz3kho/qv+eAIOexMyPvA2vWNSJMBqEie4yPxJY6k9l3zU0eWi9rSoLGzGYV+X3F3peEQKebZyH8fotwLrhoTgCWRNe8laDq4SIrO/on0RY9bOeZETAh5tLtgTX1hys4j/+Fz+oLi09mP45lrIy3/khW5TXfDcY3j7hMl/YAYXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/aY6MeE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BFDC2BCB4;
	Tue,  5 May 2026 22:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778021018;
	bh=0wQyfIPOLVqOSSQDH32X9XpB1NsPFRS8W6WD+ZVR0sM=;
	h=From:To:Cc:Subject:Date:From;
	b=j/aY6MeEqp6Fpj8uNJYJkH5izYwYgtkU4xMmnnEYstBcVzgcb/ZDofels2mECaBOP
	 Gc8lmO12nSi7EdBZllFREajRkd5+qiNPwzlqKDUtkMqDbSdCJp/3ZsOAMv8aJH6t2b
	 2Uz2ae2FIkXQtIJbqe3y5DB1H8Q3iB+khdSxs5B1I9Dkx4vF0jFc8pPlNQ7nVBkreR
	 Hn/HB2ZzaAQERHAAkl+E5ket05Cnip33oAKEt73hZgdxTOs6R5aMQ9q46KUdcvgkTl
	 TSYCsam0Wn15AuOZ2/hLXm+Vbn6JjRSXFV24gPIFV96kP0G9i7rEZe3Uk259VgCQDw
	 foQCQVOk4MLyg==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Colin Walters <walters@verbum.org>,
	stable@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2] ovl: fix verity lazy-load guard broken by fsverity_active() semantic change
Date: Tue,  5 May 2026 15:42:57 -0700
Message-ID: <20260505224257.23213-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1F8934D4715
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,gmail.com,infradead.org,verbum.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-244283-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Colin Walters <walters@verbum.org>

Commit f77f281b6118 ("fsverity: use a hashtable to find the
fsverity_info") made fsverity_active() check whether the inode has the
verity flag, rather than whether the inode's fsverity_info is loaded.
This broke ovl_ensure_verity_loaded(), which wants to load the
fsverity_info for any verity inodes that haven't had it loaded yet.

Therefore, to check that the fsverity_info hasn't yet been loaded, use
fsverity_get_info(inode) == NULL instead of !fsverity_active(inode).

Also, since fsverity_get_info() now involves a hash table lookup, put
the more lightweight IS_VERITY() flag check first.

Fixes: f77f281b6118 ("fsverity: use a hashtable to find the fsverity_info")
Cc: stable@vger.kernel.org
Link: https://github.com/bootc-dev/bootc/issues/2174
Signed-off-by: Colin Walters <walters@verbum.org>
Link: https://lore.kernel.org/r/6630d44f-967d-41f0-81ce-6958b371465a@app.fastmail.com
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

v2: improved commit message, and use '== NULL' to make it clear that
    it's a check for a NULL pointer.

 fs/overlayfs/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 7b86a6bac644..b41f4788e4f0 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1352,11 +1352,11 @@ char *ovl_get_redirect_xattr(struct ovl_fs *ofs, const struct path *path, int pa
 int ovl_ensure_verity_loaded(const struct path *datapath)
 {
 	struct inode *inode = d_inode(datapath->dentry);
 	struct file *filp;
 
-	if (!fsverity_active(inode) && IS_VERITY(inode)) {
+	if (IS_VERITY(inode) && fsverity_get_info(inode) == NULL) {
 		/*
 		 * If this inode was not yet opened, the verity info hasn't been
 		 * loaded yet, so we need to do that here to force it into memory.
 		 */
 		filp = kernel_file_open(datapath, O_RDONLY, current_cred());

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.54.0


