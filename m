Return-Path: <stable+bounces-270116-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /NL8If/ERGqC0goAu9opvQ
	(envelope-from <stable+bounces-270116-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 09:42:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D556EAC97
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 09:42:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270116-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270116-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A107300C9A7
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 07:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F053BB668;
	Wed,  1 Jul 2026 07:42:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3503009F6;
	Wed,  1 Jul 2026 07:42:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891768; cv=none; b=me0VLgQwEm1/mN2z7yY81WRi8mwGog7q3STRtuYSrROB6Xq+hU8j4WuQ2cWPNbFpW92bbpIH4T3iJYXhjBiEqXI9igMnqq94agG6vn7TXC2i+Ys0C+AGV8s3tY4xSWmhtRzUim2k/Xw6sWXktUGSqisnCfLUd6JlAI0Isk38Gb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891768; c=relaxed/simple;
	bh=LRk3F+glB1e+uODYrg3n9UX4FoxzrJ+UwW5EF1K6820=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RFsGi21j6no+WqSkUuF4zgTa8SqKpWPxuRt06/F0AGVseMejYhr8wabWVDxaRIGcFc9ko/imFUco064/sx6nDWIXbKFd/B475IvU/bVN/p8Sqhy0y1T/mzWVq0PGOQo6rKCKhOqj+7b/hoLD9GTCozeJhQVHe7XIuFZgPzzFlgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 6f0a90ea752011f1aa26b74ffac11d73-20260701
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7e7bc834-067e-429c-b48a-8d941eef7612,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:0ad45be064530f10f0bd86a303b51d1c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6f0a90ea752011f1aa26b74ffac11d73-20260701
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1546790373; Wed, 01 Jul 2026 15:42:38 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com,
	charsyam@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v4] ntfs: validate error codes from untrusted disk data
Date: Wed,  1 Jul 2026 15:42:33 +0800
Message-Id: <20260701074233.67855-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[kylinos.cn];
	TAGGED_FROM(0.00)[bounces-270116-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linkinjeon@kernel.org,m:hyc.lee@gmail.com,m:charsyam@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhongling0719@126.com,m:zenghongling@kylinos.cn,m:stable@vger.kernel.org,m:hyclee@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[zenghongling@kylinos.cn,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenghongling@kylinos.cn,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,126.com,kylinos.cn];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kylinos.cn:email,kylinos.cn:mid,kylinos.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3D556EAC97

ntfs_lookup_ino_by_name() returns MFT references read directly from
disk, which are untrusted data. The current code extracts error codes
via MREF_ERR() without proper validation, allowing maliciously crafted
NTFS images to trigger kernel panic.

The MFT reference encoding uses bit 47 as an error indicator, but the
lower 32 bits can contain arbitrary values. If a malicious image sets
the error bit with a positive integer (e.g., 1), MREF_ERR() returns
that positive value. Returning ERR_PTR(1) causes VFS to treat it as
a valid dentry pointer since IS_ERR() only recognizes values in
[-MAX_ERRNO, -1] as errors.

This leads to kernel panic when walk_component() → step_into()
dereferences the bogus pointer at:
    struct inode *inode = dentry->d_inode;

Fix by strictly validating error codes: only accept negative values
in the valid errno range [-MAX_ERRNO, -1]. Convert all other values
(positive, zero, or out-of-range) to -EIO to indicate disk corruption.

This prevents potential security issues and ensures proper error handling
for corrupted or malicious NTFS filesystems.

Fixes: 1e9ea7e04472d ("Revert \"fs: Remove NTFS classic\"")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Suggested-by: Namjae Jeon <linkinjeon@kernel.org>

---
Change in v2:
 - Use else branch to replace original error handling, avoiding duplicate
   logging and ensuring single consistent error messag
---
Change in v3:
 - move the assignment long err = MREF_ERR(mref); to the top of the block
   and reuse err instead of using MREF_ERR(mref).
---
Change in v4
 - Declaring variables at the top.
---
 fs/ntfs/namei.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index a19626a135bd..3d8b7e557b08 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -177,6 +177,7 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
 	u64 mref;
 	unsigned long dent_ino;
 	int uname_len;
+	long err;
 
 	ntfs_debug("Looking up %pd in directory inode 0x%llx.",
 			dent, NTFS_I(dir_ino)->mft_no);
@@ -233,9 +234,18 @@ static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *dent,
 		ntfs_debug("Done.");
 		return d_splice_alias(NULL, dent);
 	}
-	ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error code %i.",
-			-MREF_ERR(mref));
-	return ERR_PTR(MREF_ERR(mref));
+
+	err = MREF_ERR(mref);
+
+	if (err < 0 && err >= -MAX_ERRNO) {
+		ntfs_error(vol->sb, "ntfs_lookup_ino_by_name() failed with error code %li.",
+				err);
+		return ERR_PTR(err);
+	}
+	ntfs_error(vol->sb, 
+		"ntfs_lookup_ino_by_name() returned invalid error code %li, treating as disk corruption.",
+			err);
+	return ERR_PTR(-EIO);
 handle_name:
 	{
 		struct mft_record *m;
-- 
2.25.1


