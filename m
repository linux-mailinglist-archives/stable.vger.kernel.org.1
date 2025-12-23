Return-Path: <stable+bounces-203280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5127CD86BC
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 09:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73A7F3021040
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 08:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5932FF160;
	Tue, 23 Dec 2025 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aOxPLi3c"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5278D2D7387
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766476971; cv=none; b=I7U9Cn2Uh0v5rz/lx+Fy0wxBt5aP9ZvLLpKOMLnIuj3/km89cRvJrtwB2bpmEnubORT5pKYiwy3KFVEEum6HavP9DmmU+xyshVc3bTbD8xcTXRL1ku912DH+1TXKts6SWEJG1eNcdd/8ZOBy9hzpy+gWC3TuqEaL19A7URV7awg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766476971; c=relaxed/simple;
	bh=9sxiLrElTI5Ztk43MEmWpEu6IKgM9WAgv2dhiRlK6Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CXPC+Dfs6/LGv+r2xnSZDihtyacf8FjPkPETULSRCFHDi7PCaA8o3wlrXtOgIwBNlFbksJZNPu6/ojptwvHrJ0A2DeY1RwPv0YG6hvsNaMElZ2AAzVCZwcEMS6bwDvAXkN0GKybM01+T7CvdLLH9VhhzlqIa9V+/YcCfZVo0mHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aOxPLi3c; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2a08c65fceeso9166265ad.2
        for <stable@vger.kernel.org>; Tue, 23 Dec 2025 00:02:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766476969; x=1767081769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTUH1SPKBV/BQ5rzdoe3NdUj8Uqe/XoIX8txSdtTxSM=;
        b=fjU9Sa9bTKJQ88wMkyqWS05oQzVjwHZNMgNmbU/mOw/IhCnCP9g1ihnUz+OTDeVqDJ
         WyeXYYix6MXeoqaQrKncSdogZ4WMT3ZJu4+GqZuK13tUYOnns255kI/t3klz5Le1pWjw
         5R3xqTzSTCvKihIUZK9BuQIXruvUYIsmoI9KnzUnNpZfDxUolorH/p5zC747ibaj4yKZ
         HMTHo2rJuHOFDAl+8OAeG1nQEVd/R9dRGGOZ41M6a+HJEg/xyYwzK+PuUPI3Svtvgcu7
         RNVhbzYHnwdxf7yb/7AiclDzJvCE6+kBw6+AiIwESLguwYZjeVQNLKERim5o/5Xgapon
         ijXA==
X-Gm-Message-State: AOJu0YwoDvw0krKpkz+C58Gpq6hAWapKHW/cz894VdUtGfIDNWQHYgGr
	r2T+eMrubugP4xzHoIXT6IciYnAZHXLghH4EjZptCVRBrgVWcs2uYKnRtpS64lQBAPFBJD2Fikq
	zpbA/XNPMBmWqfuYpEEwUBT4APhqANmAzpvD39HWhY939pDWXlc3KVU/DTHFGoBFvKKY9jgs7MQ
	SOFOfCYJHMYpyalgsbfk+X6XYnBpTaPrJBjKi8Ja615dmN4iimvglpoK+DRSDFl6DhLPKk2vSpo
	FAqr5/6RxAZCA6wgdKhiiYkdETDvf4=
X-Gm-Gg: AY/fxX6BuIsAXIXVjShHRI4qCFX+CFPZB4xXuFR2huZe/oxU54AyWnLGQvMA4pEWaRl
	v+MsvEodNuZDdys2CWBq0FQih4KvpFoKCmCpW4wM8fRtXlcYHILTrO65cF54xNMk2+AO9UVCfob
	0WNxeeFsxhwEv/E7/yyddlQLcqyC25P/Lxl4fpz2gyLSrvV6c/7bY476YXhmppwT6nW9ILdnXM6
	F1Z2s3UxWj82lEPo3ITGVGTIkj7pMIXsCHywXUEbzg1MqjwAuonvtwr+gejLMWLQ1qNFH/1GsLf
	SCriEBDgQDPqZmCySMgIsOadzDKlhoCvqPJccKrAjlQP1f1x5BOHe1fCnWQpvZB10VNvaqueOx/
	ghfa+yla/L4Q9OIqTQIMBOQs4drbtRoe4hdtf8xByL5EYD7KXNMa4uHGIqfdvXLVBdT0/JPCGV6
	2nXvcluZvdotuxM4D3YhaPcslb/BLN6FxzH+ENPXPuT20oOQJVsZrtBI62dR0AlA==
X-Google-Smtp-Source: AGHT+IFaxbn37Ccyl8SVDBieSK5S6rXeOAoSgVfpjmjejNLABEhMf9bLFW1E2IiNKUZp3pHxYWR/n4nQR1Ra
X-Received: by 2002:a17:903:15ce:b0:298:9a1:88e8 with SMTP id d9443c01a7336-2a2f2736638mr92794285ad.5.1766476969507;
        Tue, 23 Dec 2025 00:02:49 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a2f3d1b8e6sm14299185ad.43.2025.12.23.00.02.49
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Dec 2025 00:02:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b1be0fdfe1so201974185a.2
        for <stable@vger.kernel.org>; Tue, 23 Dec 2025 00:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766476968; x=1767081768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OTUH1SPKBV/BQ5rzdoe3NdUj8Uqe/XoIX8txSdtTxSM=;
        b=aOxPLi3cmG7xNLQbzY81NKyu+rRR6l+tjiEJ0KXp+yP1dDq35nn/DX+SRydMnLGrTz
         p4osyAUEWGiIUbrUPkqeurmuYAN6OQ/vAiGdPb4VEYiFRjqe9fjU85rfKxaWLdcYRRQl
         b9i3K2fz6rZIA83SXRXi2Y/oCuY334/i057wc=
X-Received: by 2002:a05:622a:11d4:b0:4f3:616c:dbed with SMTP id d75a77b69052e-4f4abbc85d9mr156899441cf.0.1766476967751;
        Tue, 23 Dec 2025 00:02:47 -0800 (PST)
X-Received: by 2002:a05:622a:11d4:b0:4f3:616c:dbed with SMTP id d75a77b69052e-4f4abbc85d9mr156899141cf.0.1766476967188;
        Tue, 23 Dec 2025 00:02:47 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4c46e4aabsm53636071cf.16.2025.12.23.00.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 00:02:46 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Boris Burkov <boris@bur.io>,
	Bin Lan <bin.lan.cn@windriver.com>,
	He Zhe <zhe.he@windriver.com>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10.y] btrfs: do not clean up repair bio if submit fails
Date: Tue, 23 Dec 2025 08:00:41 +0000
Message-ID: <20251223080041.1428811-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 8cbc3001a3264d998d6b6db3e23f935c158abd4d ]

The submit helper will always run bio_endio() on the bio if it fails to
submit, so cleaning up the bio just leads to a variety of use-after-free
and NULL pointer dereference bugs because we race with the endio
function that is cleaning up the bio.  Instead just return BLK_STS_OK as
the repair function has to continue to process the rest of the pages,
and the endio for the repair bio will do the appropriate cleanup for the
page that it was given.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[Minor context change fixed.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Keerthana: Backported the patch to v5.10.y ]
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
---
 fs/btrfs/extent_io.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 489d370ddd60..3d0b854e0c19 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2655,7 +2655,6 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 	bool need_validation;
 	struct bio *repair_bio;
 	struct btrfs_io_bio *repair_io_bio;
-	blk_status_t status;
 
 	btrfs_debug(fs_info,
 		   "repair read error: read error at %llu", start);
@@ -2699,13 +2698,13 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 "repair read error: submitting new read to mirror %d, in_validation=%d",
 		    failrec->this_mirror, failrec->in_validation);
 
-	status = submit_bio_hook(inode, repair_bio, failrec->this_mirror,
-				 failrec->bio_flags);
-	if (status) {
-		free_io_failure(failure_tree, tree, failrec);
-		bio_put(repair_bio);
-	}
-	return status;
+	/*
+	 * At this point we have a bio, so any errors from submit_bio_hook()
+	 * will be handled by the endio on the repair_bio, so we can't return an
+	 * error here.
+	 */
+	submit_bio_hook(inode, repair_bio, failrec->this_mirror, failrec->bio_flags);
+	return BLK_STS_OK;
 }
 
 /* lots and lots of room for performance fixes in the end_bio funcs */
-- 
2.43.7


