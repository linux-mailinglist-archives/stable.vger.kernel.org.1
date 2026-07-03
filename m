Return-Path: <stable+bounces-271841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vxkGIXD5R2pjiQAAu9opvQ
	(envelope-from <stable+bounces-271841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 20:03:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4586704BAE
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 20:03:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IEjJ1HaZ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271841-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271841-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D62E3301B4EA
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 18:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBA62E22B5;
	Fri,  3 Jul 2026 18:03:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0A92C0294
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 18:03:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783101806; cv=none; b=cG9FLLGRbXXW3FhQ0FoUMB1reCnDZrI7Imuqpcd3UELsaORRvN46H43L83JWTBab1LTdyH2J4oBiQj5RCJzjkHbgRuYh1Z9hochi836+irgKnybBPVkAjAXReTg0HKIsnwcREu3yqH/NC0z2CXtSiFBxugK5UmcVRg42VOwj54E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783101806; c=relaxed/simple;
	bh=y4ehL0qJixwQ1CQc/XoLnLys4QR6IEk8QQFtHX8uAQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvT3IMfS29OS+WioIEHj+J9EQHRH3G+u+Axpc+QnaBSLr0PC155Wm/h6mRSKErLanhA2lIQ0xhATUPUxG7C4p818oe6k3+GNPxHALVZ3Lqe8JHbFxZm3ENB/aNl+E5oVaHT/1XZq+7QpIia0ThGjWmP8dCOLeEZFkozovO0fDxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEjJ1HaZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97821F000E9;
	Fri,  3 Jul 2026 18:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783101804;
	bh=DwB0B1otIS1Z4FIClHxQfS2c7TfNsDPe1Ibzo6Chmk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IEjJ1HaZRpUhqBGhtA3UZhjN0DUlM4CoUyfz6V41pKiabMbATyT/9aaqzkynSCDsu
	 A33jDNoyEoWDAYG0h9DJoqfGwWR3xKjU6eN93QsDZJQZo0uVeBDNi3GCuICQpftWCq
	 9KSCymrluK3U/PAKd1G3vwgQ1PxJ0Q2ts0OIGBRRA5YcY2Q3ItN5wM1BZQn0+VbgBL
	 47+tCNV6cx6p5wDzqTFci+0nAZ84QRAlDLxe1eRp8+cSodR+ye6OZzlYJUVl+f2Bm2
	 h0dNyTpX6a9wKrP9xvLe2sXDMq/D0JNKiNDCvcg+LS+nt51tjw9yxlqjJ3EaCD/dmQ
	 MLdWI8R5cP0zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] f2fs: bound i_inline_xattr_size for non-inline-xattr inodes
Date: Fri,  3 Jul 2026 14:03:22 -0400
Message-ID: <20260703180322.196790-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070207-aloha-agony-a520@gregkh>
References: <2026070207-aloha-agony-a520@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271841-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:hexlabsecurity@proton.me,m:chao@kernel.org,m:jaegeuk@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,proton.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E4586704BAE

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 378acf3cf19b6af6cba55e8dd1154c4e1504bae8 ]

When the flexible_inline_xattr feature is enabled, do_read_inode() loads
the on-disk i_inline_xattr_size unconditionally:

	if (f2fs_sb_has_flexible_inline_xattr(sbi))
		fi->i_inline_xattr_size = le16_to_cpu(ri->i_inline_xattr_size);

but sanity_check_inode() only range-checks it when the inode also has the
FI_INLINE_XATTR flag set.  An inode that carries an inline dentry or inline
data but not FI_INLINE_XATTR -- the normal layout for an inline
directory -- therefore keeps a fully attacker-controlled
i_inline_xattr_size from a crafted image.

get_inline_xattr_addrs() returns that value with no flag gating, so it
feeds the inode geometry:

	MAX_INLINE_DATA()  = 4 * (CUR_ADDRS_PER_INODE - i_inline_xattr_size - 1)
	NR_INLINE_DENTRY() = MAX_INLINE_DATA() * BITS_PER_BYTE / (...)
	addrs_per_page()   = CUR_ADDRS_PER_INODE - i_inline_xattr_size

A large i_inline_xattr_size drives MAX_INLINE_DATA() and NR_INLINE_DENTRY()
negative, so make_dentry_ptr_inline() sets d->max (int) to a negative
value.  The inline directory walk then compares an unsigned long bit_pos
against that negative d->max, which is promoted to a huge unsigned bound,
and reads far past the inline area:

	while (bit_pos < d->max)		/* fs/f2fs/dir.c */
		... test_bit_le(bit_pos, d->bitmap) / d->dentry[bit_pos] ...

Mounting a crafted image and reading such a directory triggers an
out-of-bounds read in f2fs_fill_dentries(); the same underflow also
corrupts ADDRS_PER_INODE for regular files.

Validate i_inline_xattr_size against MAX_INLINE_XATTR_SIZE whenever the
flexible_inline_xattr feature is enabled -- i.e. whenever the value is
loaded from disk and consumed -- and keep the lower MIN_INLINE_XATTR_SIZE
bound gated on inodes that actually carry an inline xattr, so legitimate
inodes with i_inline_xattr_size == 0 are still accepted.

Cc: stable@vger.kernel.org
Fixes: 6afc662e68b5 ("f2fs: support flexible inline xattr size")
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/inode.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index db80b6cad325cf..1f8aa7cb0b879d 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -307,15 +307,6 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 				  F2FS_TOTAL_EXTRA_ATTR_SIZE);
 			return false;
 		}
-		if (f2fs_sb_has_flexible_inline_xattr(sbi) &&
-			f2fs_has_inline_xattr(inode) &&
-			(!fi->i_inline_xattr_size ||
-			fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE)) {
-			f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_inline_xattr_size: %d, max: %zu",
-				  __func__, inode->i_ino, fi->i_inline_xattr_size,
-				  MAX_INLINE_XATTR_SIZE);
-			return false;
-		}
 		if (f2fs_sb_has_compression(sbi) &&
 			fi->i_flags & F2FS_COMPR_FL &&
 			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
@@ -329,6 +320,16 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
+	if (f2fs_sb_has_flexible_inline_xattr(sbi) &&
+		(fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE ||
+		(f2fs_has_inline_xattr(inode) &&
+		fi->i_inline_xattr_size < MIN_INLINE_XATTR_SIZE))) {
+		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_inline_xattr_size: %d, min: %zu, max: %zu",
+			  __func__, inode->i_ino, fi->i_inline_xattr_size,
+			  MIN_INLINE_XATTR_SIZE, MAX_INLINE_XATTR_SIZE);
+		return false;
+	}
+
 	if (!f2fs_sb_has_extra_attr(sbi)) {
 		if (f2fs_sb_has_project_quota(sbi)) {
 			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
-- 
2.53.0


