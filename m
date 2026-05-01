Return-Path: <stable+bounces-242558-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNOiBf829WkeJgIAu9opvQ
	(envelope-from <stable+bounces-242558-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 01:27:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC9F4B0499
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 01:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2BE3300E02E
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 23:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADC537F00D;
	Fri,  1 May 2026 23:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlalabs-com.20251104.gappssmtp.com header.i=@amlalabs-com.20251104.gappssmtp.com header.b="a5rLOY7H"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6277C37F75F
	for <stable@vger.kernel.org>; Fri,  1 May 2026 23:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777678069; cv=none; b=MMYS1GTZy++onWfdiBZkcQBjlWIkE/D+eabDP4H7neXVVpivjoo9je+uuTi5+E6lSlSIwIQlShcVxYcTSbAlKwPg5Zb2YSFaiSKyzpm6JkGqJlhIj5/WMh9dfj+S9lu3kiq6nEbekq54ot22WGmfBGrl0v0EQ7X1HkRdxbjRCkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777678069; c=relaxed/simple;
	bh=IzsHTZd6P6eYxd9Efo/a+pL4VeFLJKPvFGqGLptMSas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=btTY/A0zSE1nCDGqhLBjDcaCWNQrCJw8TOT0fXgOBdkvlqoTeJHley+7FEv2L1BBA0Z1aPRAtFnrBlIzr4aqkDtbnSFR0smgZ8CsqUzAXhRWG0Gd79P7eXd8QlcELH2Sk6d2u58uSxl8HDRWQmqyZEWpti39cJDBPrnk007rH1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amlalabs.com; spf=pass smtp.mailfrom=amlalabs.com; dkim=pass (2048-bit key) header.d=amlalabs-com.20251104.gappssmtp.com header.i=@amlalabs-com.20251104.gappssmtp.com header.b=a5rLOY7H; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amlalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlalabs.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-8aca4e14411so25228066d6.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 16:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amlalabs-com.20251104.gappssmtp.com; s=20251104; t=1777678067; x=1778282867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PIMoo2xEXf7dASzi8yK3wgyb6uWnPH179QZ1IGul6o0=;
        b=a5rLOY7HOyhrAzO/IcTwgTXnfYNKbOHSJHVEwCg7pLMv16Ta78Ore9X4ROM6qd/XAB
         bJeQW21ljJAWVs1ALYJZ+Q14T2ERUiiyRKWmNnY1xv1Jw59RJkvraYM15mXIQPZeSDDJ
         9SYUHeuQQetbvww8XuoBMBIpsWNvYtV8XHdBDByzDCpykLRDqK60tyO0yF1o87eZJaYo
         5eKeUz0BTaxi/Irs/xnjzE3MP9MuV5oHPSYc4ZmLReW2joVYvLJ4zmJwtKvfKSiQn224
         oxA3oejr3qmPR5eUf9qe7FS4kXCmDV5MJnOgd6qSjZRxPxxi+46SYj2K0EpOUBPHNbF/
         NqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777678067; x=1778282867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIMoo2xEXf7dASzi8yK3wgyb6uWnPH179QZ1IGul6o0=;
        b=C0dU64zrAOYn8J0EQbflL+kIrI+pJJEIos+VMquKa5qNlW5r26f+ZGQG+mSirDRDG8
         sOwiWwoLXZ0T7U/yYVusWbjKq4lT0UixPBbr6N8NUGbaNbSN+9D2DIb2L00EdkEtvMlW
         5Q6TQR3q5hfqopAz+JqTFOH8JziXVp149TEfaUBeqqGHFY4hSXAbSyOVcebB2iBhmmtR
         k1x6h59kKM4ZnudRunI7cay4qOA/9LlTRA99bdzsO26gZ+Vakr4MOybpIYO5E6sBZQMI
         Y0YzzikLvk/ODuvc9IFYFhDsH1DPMPDAV2P7QAF05jMqY/QYy/kQYLouaOXDpKb4czas
         TceA==
X-Forwarded-Encrypted: i=1; AFNElJ+cSXMkjofjrnAzCsIrTXK5UKNFMa9bmFJ/SMyxOVatpEgcUF8MZA/Zu2k8iopBK18IXwmpXrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGMlP9sIqnWA6lk4G1kjQOeGJUVvMoOxlWPcYvA2qztG10ARN1
	tKooEUA8+koCqg0qDW6OU/c5kiWsaMvaAHbVFNvezfOtJTBLxN2OJLJmqR4IWB5bobwVQlXwFM0
	VZyJB4D0gpDB4EZ1s2VMlGrPWQccGATAEh0zmS14=
X-Gm-Gg: AeBDietSg1KoIULpYEB8TgALsCkQY+vGl205OO+ky5BEN1uSX2Fr6xZHVwFugQzrkr6
	Zh7w/yWTMEffrbiU7p00ndd/epiTPT6btQxKY+Vs+U/D43h4RbcmGMsBeuFX2b6ssb+o8ATREex
	l9Ql9bBJyCmn0rVXGRBKL1pK93Lj6NZjbONI3O40c9LEH5C7caaxg91Z2dK1c2q33MPOQTsp7MP
	sEPPZIvO5vuHUVYRQK36KGc5RLwX5cFCmTLrUZOUJG8iz1Vmfh/y1xaRbf4Y23pizY/sWRMBDdE
	8t0YzQ66TD1ILn2UagEfrOeanuY76ZA30WQzz3q4VBzNv46U4N9o5dzZcFJ7Sl/j3lPy4yiXZQj
	eARtkqeCwN5dVgghay/Uujkdw2UE/y/J0g4i+6h3fcmkaEXYBV+Ot6h24n1f6ZVH1mlKIDsBaG+
	/k5yUTU4BX
X-Received: by 2002:a0c:e001:0:b0:89c:d50e:b57 with SMTP id 6a1803df08f44-8b6665f1489mr23648016d6.15.1777678067303;
        Fri, 01 May 2026 16:27:47 -0700 (PDT)
Received: from amlalabs.com (104-10-255-95.lightspeed.sntcca.sbcglobal.net. [104.10.255.95])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8b53b918281sm3200306d6.19.2026.05.01.16.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:27:47 -0700 (PDT)
X-Relaying-Domain: amlalabs.com
From: Souvik Banerjee <souvik@amlalabs.com>
To: miklos@szeredi.hu,
	amir73il@gmail.com
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Souvik Banerjee <souvik@amlalabs.com>
Subject: [PATCH] ovl: use linked upper dentry in copy-up tmpfile
Date: Fri,  1 May 2026 23:27:35 +0000
Message-ID: <20260501232735.2610824-1-souvik@amlalabs.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9CC9F4B0499
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amlalabs-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-242558-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[amlalabs.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[szeredi.hu,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amlalabs-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[souvik@amlalabs.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amlalabs-com.20251104.gappssmtp.com:dkim]

ovl_copy_up_tmpfile() stores the disconnected O_TMPFILE dentry as the
overlay's upper dentry reference via ovl_inode_update().  vfs_tmpfile()
allocated this dentry via d_alloc(parentpath->dentry, &slash_name), so
d_name is "/" and d_parent is c->workdir.  Local upper filesystems
(ext4, btrfs, xfs, ...) immediately rename it to "#<inum>" via
d_mark_tmpfile() inside their ->tmpfile() op; FUSE and virtiofs do
not, so both fields stay that way.  Neither identifies the destination
directory and filename where ovl_do_link() actually linked the file.

When the upper filesystem implements ->d_revalidate() (e.g. FUSE or
virtiofs), ovl_revalidate_real() calls it with the dentry's parent
inode and a snapshot of d_name.  The server tries to look up "/" inside
c->workdir, fails, and overlayfs reports -ESTALE.

This causes persistent ESTALE errors for any file that was copied up via
the tmpfile path, breaking dpkg, apt, and other tools that do
rename-over-existing on overlayfs with a FUSE/virtiofs upper.

Before commit 6b52243f633e ("ovl: fold copy-up helpers into callers"),
the tmpfile copy-up path used a dedicated helper ovl_link_tmpfile()
that captured the linked destination dentry returned by ovl_do_link():

    err = ovl_do_link(temp, udir, upper);
    ...
    if (!err)
        *newdentry = dget(upper);

and published it via ovl_inode_update(d_inode(c->dentry), newdentry).
The fold inlined ovl_do_link() into ovl_copy_up_tmpfile() but dropped
the dget(upper) capture, and rewrote the publish line as
ovl_inode_update(d_inode(c->dentry), dget(temp)) — where temp is the
disconnected O_TMPFILE dentry.

Fix by keeping a reference to the linked destination dentry after
ovl_do_link() succeeds, and publishing that dentry at the existing
ovl_inode_update() call site.  The non-tmpfile/workdir path continues to
publish the renamed temporary dentry.

Reproducer:
  - Mount overlayfs with virtiofs (or a FUSE fs whose server advertises
    FUSE_TMPFILE) as upper
  - Run: dpkg -i <any .deb>
  - Observe: "error installing new file '...': Stale file handle"

Fixes: 6b52243f633e ("ovl: fold copy-up helpers into callers")
Cc: stable@vger.kernel.org # v4.20+
Signed-off-by: Souvik Banerjee <souvik@amlalabs.com>
---
 fs/overlayfs/copy_up.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 13cb60b52bd6..e963701b4c87 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -853,7 +853,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 {
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct inode *udir = d_inode(c->destdir);
-	struct dentry *temp, *upper;
+	struct dentry *temp, *upper, *newdentry = NULL;
 	struct file *tmpfile;
 	int err;
 
@@ -889,6 +889,14 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 	err = PTR_ERR(upper);
 	if (!IS_ERR(upper)) {
 		err = ovl_do_link(ofs, temp, udir, upper);
+		if (!err) {
+			/*
+			 * Record the linked dentry -- not the disconnected
+			 * O_TMPFILE dentry -- so that ->d_revalidate() on
+			 * the upper fs sees the real parent/name.
+			 */
+			newdentry = dget(upper);
+		}
 		end_creating(upper);
 	}
 
@@ -903,7 +911,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 
 	if (!c->metacopy)
 		ovl_set_upperdata(d_inode(c->dentry));
-	ovl_inode_update(d_inode(c->dentry), dget(temp));
+	ovl_inode_update(d_inode(c->dentry), newdentry);
 
 out:
 	ovl_end_write(c->dentry);
-- 
2.51.1


