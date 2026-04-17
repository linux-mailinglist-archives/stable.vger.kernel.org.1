Return-Path: <stable+bounces-238378-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN9tOcV74WlDtwAAu9opvQ
	(envelope-from <stable+bounces-238378-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 02:16:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E73415C94
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 02:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31C9D3039D86
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 00:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462EC15E97;
	Fri, 17 Apr 2026 00:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="lMvcKvYX"
X-Original-To: stable@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AA940DFC0;
	Fri, 17 Apr 2026 00:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776384959; cv=none; b=Wqi2qzs/fI20veFg6JDkH8WN8AnPkyzIc9rxqP6s72su7lwiOlapCTnkF4fnJDyW1r5No+Qg0ZJygJKxVLmLXjuo+r2JjEy6RKbhtvjzHEP7VHg9kWy6vld3VShYw1IN3YXyuLlxFEhN3w4AH5BVVZkF+eOUcrSRxGTL8aqkHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776384959; c=relaxed/simple;
	bh=GaLR26YMKHEpPTz6l7m9Ngr/Gvcz/0LL5V+80n4wqj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZWQfSow4h0tzbnZWKR1NRDfiHhwumLhuXewiUgLcDnpZ8ejv5V2e92HVq0/nnJT3lGqVfBSzHSxsWaNEGpNQ+0YhcdHA9XE7/y5txuYCVHT/+yUVh1V7J72H541PvZRcKdr3FDPKGzaxGT7g4QkXB2uq2deLei96BgUa3U7jMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=lMvcKvYX; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Content-Type:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=aRybrhZ3O2xQQ8KQ99MAu6C0wcCHqBdT1DKsr4ddO7E=; b=lMvcKvYXGVVqqbm/AES0fGaD2E
	B3/rc9We9KQOO4aM7grwrUZxgdpbyhU06XhTQKc5QSnXRGCSqHYHUy1i3inp9M/q16lhfQD2vCZ8y
	HTBE9lDzxFmrQTQcfi18TjPe9K4i6qGQHV9sXEpiGFMDJLeGkV4i3Cc3Bj9G+I6Wcj/BZPYOrDcDW
	68UrVid4KVS+v6u44El6kWafKgW2YM/fccURp0BZQcAw87gmBBqqkSlR2bzNXzydXpbt7HGZ4R2wD
	CzAnCDWFdBrPqz4pHovflblnqIs4MTkB/+YuXLoFUEKSJRI84ORxyh+FzRgAJTI9Af7BhwqYipwNB
	pAjldcFw==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
	id 1wDWsC-00000000J7g-1R9N;
	Thu, 16 Apr 2026 21:15:52 -0300
From: Paulo Alcantara <pc@manguebit.org>
To: Steve French <smfrench@gmail.com>
Cc: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	linux-cifs@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] smb: client: fix dir separator in SMB1 UNIX mounts
Date: Thu, 16 Apr 2026 21:15:50 -0300
Message-ID: <20260417001550.1301260-1-pc@manguebit.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[manguebit.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[manguebit.org:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238378-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[pc@manguebit.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[manguebit.org:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[moonlit-rail.com:email,manguebit.org:email,manguebit.org:dkim,manguebit.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51E73415C94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When calling cifs_mount_get_tcon() with SMB1 UNIX mounts,
@cifs_sb->mnt_cifs_flags needs to be read or updated only after
calling reset_cifs_unix_caps(), otherwise it might end up with missing
CIFS_MOUNT_POSIXACL and CIFS_MOUNT_POSIX_PATHS bits.

This fixes the wrong dir separator used in paths caused by the missing
CIFS_MOUNT_POSIX_PATHS bit in cifs_sb_info::mnt_cifs_flags.

Reported-by: "Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
Closes: https://lore.kernel.org/r/f758f4ff-4d54-4244-931d-38f469c3ff14@moonlit-rail.com
Fixes: 4fc3a433c139 ("smb: client: use atomic_t for mnt_cifs_flags")
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-cifs@vger.kernel.org
Cc: stable@vger.kernel.org
---
 fs/smb/client/connect.c | 10 +++++-----
 fs/smb/client/smb1ops.c | 19 ++++++++-----------
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 69b38f0ccf2b..e9eeb9f8a561 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3610,7 +3610,6 @@ int cifs_mount_get_tcon(struct cifs_mount_ctx *mnt_ctx)
 	server = mnt_ctx->server;
 	ctx = mnt_ctx->fs_ctx;
 	cifs_sb = mnt_ctx->cifs_sb;
-	sbflags = cifs_sb_flags(cifs_sb);
 
 	/* search for existing tcon to this server share */
 	tcon = cifs_get_tcon(mnt_ctx->ses, ctx);
@@ -3625,9 +3624,10 @@ int cifs_mount_get_tcon(struct cifs_mount_ctx *mnt_ctx)
 	 * path (i.e., do not remap / and \ and do not map any special characters)
 	 */
 	if (tcon->posix_extensions) {
-		sbflags |= CIFS_MOUNT_POSIX_PATHS;
-		sbflags &= ~(CIFS_MOUNT_MAP_SFM_CHR |
-			     CIFS_MOUNT_MAP_SPECIAL_CHR);
+		atomic_or(CIFS_MOUNT_POSIX_PATHS, &cifs_sb->mnt_cifs_flags);
+		atomic_andnot(CIFS_MOUNT_MAP_SFM_CHR |
+			      CIFS_MOUNT_MAP_SPECIAL_CHR,
+			      &cifs_sb->mnt_cifs_flags);
 	}
 
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
@@ -3651,6 +3651,7 @@ int cifs_mount_get_tcon(struct cifs_mount_ctx *mnt_ctx)
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 		tcon->unix_ext = 0; /* server does not support them */
 
+	sbflags = cifs_sb_flags(cifs_sb);
 	/* do not care if a following call succeed - informational */
 	if (!tcon->pipe && server->ops->qfs_tcon) {
 		server->ops->qfs_tcon(mnt_ctx->xid, tcon, cifs_sb);
@@ -3675,7 +3676,6 @@ int cifs_mount_get_tcon(struct cifs_mount_ctx *mnt_ctx)
 
 out:
 	mnt_ctx->tcon = tcon;
-	atomic_set(&cifs_sb->mnt_cifs_flags, sbflags);
 	return rc;
 }
 
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 9694117050a6..e198e3dda917 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -49,7 +49,6 @@ void reset_cifs_unix_caps(unsigned int xid, struct cifs_tcon *tcon,
 
 	if (!CIFSSMBQFSUnixInfo(xid, tcon)) {
 		__u64 cap = le64_to_cpu(tcon->fsUnixInfo.Capability);
-		unsigned int sbflags;
 
 		cifs_dbg(FYI, "unix caps which server supports %lld\n", cap);
 		/*
@@ -76,29 +75,27 @@ void reset_cifs_unix_caps(unsigned int xid, struct cifs_tcon *tcon,
 		if (cap & CIFS_UNIX_TRANSPORT_ENCRYPTION_MANDATORY_CAP)
 			cifs_dbg(VFS, "per-share encryption not supported yet\n");
 
-		if (cifs_sb)
-			sbflags = cifs_sb_flags(cifs_sb);
-
 		cap &= CIFS_UNIX_CAP_MASK;
 		if (ctx && ctx->no_psx_acl)
 			cap &= ~CIFS_UNIX_POSIX_ACL_CAP;
 		else if (CIFS_UNIX_POSIX_ACL_CAP & cap) {
 			cifs_dbg(FYI, "negotiated posix acl support\n");
-			if (cifs_sb)
-				sbflags |= CIFS_MOUNT_POSIXACL;
+			if (cifs_sb) {
+				atomic_or(CIFS_MOUNT_POSIXACL,
+					  &cifs_sb->mnt_cifs_flags);
+			}
 		}
 
 		if (ctx && ctx->posix_paths == 0)
 			cap &= ~CIFS_UNIX_POSIX_PATHNAMES_CAP;
 		else if (cap & CIFS_UNIX_POSIX_PATHNAMES_CAP) {
 			cifs_dbg(FYI, "negotiate posix pathnames\n");
-			if (cifs_sb)
-				sbflags |= CIFS_MOUNT_POSIX_PATHS;
+			if (cifs_sb) {
+				atomic_or(CIFS_MOUNT_POSIX_PATHS,
+					  &cifs_sb->mnt_cifs_flags);
+			}
 		}
 
-		if (cifs_sb)
-			atomic_set(&cifs_sb->mnt_cifs_flags, sbflags);
-
 		cifs_dbg(FYI, "Negotiate caps 0x%x\n", (int)cap);
 #ifdef CONFIG_CIFS_DEBUG2
 		if (cap & CIFS_UNIX_FCNTL_CAP)
-- 
2.53.0


