Return-Path: <stable+bounces-244726-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFBzBPqz/WkXhwAAu9opvQ
	(envelope-from <stable+bounces-244726-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 11:59:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8034F49FE
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 11:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DEC7301D232
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 09:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025C8384228;
	Fri,  8 May 2026 09:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKxAwJu9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582FB347FE1
	for <stable@vger.kernel.org>; Fri,  8 May 2026 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234358; cv=none; b=BPr1PrQEJu5YJ6Rz4Xrn+//bZuOByW/vChB2bXoYSiYwFS4Hy4jt3SMX212xrJ9zyNtd0BjnH6qejNG+sbeWIF69BFrRTc65UHOj41cCVk26Ob4n4fEUCghDNN1jlnhfar9qbTD/8dwQ7OuOydQnz26qgoEvfzxL0A4sD2OPleA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234358; c=relaxed/simple;
	bh=qDpRiVP7yy2vZXwlKwWWMHcQ60seEAa9/LRbPd9AM5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqkltCq/MJ1weZS7lEVhCk9irONFrQACdu0yLirTxc/JhGrShRY+gBwrAiZu5/0UKq7LdN7VORkfFypWeiPh78mTcs4sYaQuxpoBq6hhWsbSGjhUjJyNEDUL3NA29prGK7e2/vWQMvS3uhFLoMBZ41/9IXVe/Pyh5df3qrtJuXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKxAwJu9; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso1588243f8f.0
        for <stable@vger.kernel.org>; Fri, 08 May 2026 02:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778234356; x=1778839156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5LpTxIGRwThEUVNq/DxFwIbrwCO3s6L/v7P5s8pgCg4=;
        b=ZKxAwJu9kqWVj3eSgqSZIlQu0VyzY+hEfDRLIxLku0kHnGrn3VdmEsnMblYRpD4gN+
         ApkSWa5WuNaApknB8j1hHgT3pZ5l64BO5Znz+8eTTS5H5Zxt2UyI46LOKjYYO4Uwa6x8
         zP5Ej2gCTE9+Jwh39cqe61ld1X26Up2ed8UME59yLsHfMVUxK37P2WuC35WM5Z1cVqvm
         bjh7V+5cLziRRvo54q3oUmQRrB5wqnkCOMTtVNUQlZ5NE04uQgUtGBT5ov2mSExDYNgU
         4rkTdbe1p5Z1nsRkbHgH7H4AhFmPZmEap6VqVStHq0IhZktg/o7HRAyg7LaXSfMXDo4J
         hSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778234356; x=1778839156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LpTxIGRwThEUVNq/DxFwIbrwCO3s6L/v7P5s8pgCg4=;
        b=E4FYkOtrz/QVN4S4hbl3gtN9quKyrv4HOXTIKOV4Z4Fk6N6kfDs/bcttEXSZTmza5f
         u8jvx2PNOtNZcwAtcrct7cb87gzxO5Xr8PY6/gQDuSO05/hndES8KKm5/ouatK+DwQUZ
         9xaW8EUY1HDAg4jEMEWfZ5ekce41JT+iEActgAajj6dzQkh4IjIqHDWttkrsCh4ilXNa
         ZUVbz2FOVE2BtgKZqEnCCS4Jl3kkFuB6p7ZlXmLxSlFT4ZJnc3aZCw+4bNVEQpdNvvGp
         f+1jFdDrUzarhH0dINW8TYE3WZ3vvvcR1qy1/G4l7BNH0DHO5iwy8eB3FSKhbXHG3pCA
         2n+w==
X-Forwarded-Encrypted: i=1; AFNElJ/7lWWizcHvec4cV5fdnXKhteCh+O6TmeT1DQsoCuaK4g4cWrEWO3BfhOg8u4//u3THqldFCpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymr/IogKYDVil4iChiFrwGOzrWo1Iax5oNbFcBoG4y1PqIWcTV
	fk5SqDFtjiLU76/xYZ+FP2IBRU7S8snzR60iQy2IqVF2AN+QJjy69tca
X-Gm-Gg: Acq92OEysb8UjMGMD8q8LafqtkYNEHFZy7pMoxc+ry4gh3Ss4/8Z7KDZyYFq93D1GU0
	GVC3Uv9H/dIZM+vm/PqySFZBzVnl7bVsDrZihJlFtwhXcETQD05oQh0xaLMl3mIguLNeo5ML2jZ
	in6QeLEPe8x5LNId6YDOE5gJX6eBP53yvwnl+BwJKfKeTH/ejMUVHBQnOoljcsIbHp69k8Ww8PG
	Xt7MtLFwb8r9qYyEgLkgVkL96StYH3JB9PxI1xlGc+whPwL+HO87Z+1mQPo8jYKVVzNs+XHVvvD
	2sZ+w7SxAb9VTGGMLex170wOIfJdKmgYrOsCOKyLrmj8cv2rs5OGQdSDooY67O+Ik8gE5gkitOg
	8RQ/p+IvMcJma+xyVGsp0J1O88XyMhrzImu5dp1hnukmDVQjreJ/RmtvcLyjxEUwk8LdPPJ3XRU
	WI7Qj5LbXQBAX+DaRxADh+/MY=
X-Received: by 2002:a05:6000:2586:b0:43d:dd:8ca4 with SMTP id ffacd0b85a97d-4515b61bcc3mr18843966f8f.14.1778234355604;
        Fri, 08 May 2026 02:59:15 -0700 (PDT)
Received: from avt74j0.. ([2a02:8109:8617:d700:d9bb:cdec:69e5:2f8e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120f1f9sm3060894f8f.24.2026.05.08.02.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:59:15 -0700 (PDT)
From: Martin Hecht <mhecht73@gmail.com>
To: 
Cc: sakari.ailus@linux.intel.com,
	martin.hecht@avnet.eu,
	michael.roeder@avnet.eu,
	stable@vger.kernel.org,
	Martin Hecht <mhecht73@gmail.com>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] media: i2c: alvium: fix critical pointer access in alvium_ctrl_init
Date: Fri,  8 May 2026 11:59:03 +0200
Message-ID: <20260508095906.500220-1-mhecht73@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6B8034F49FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,avnet.eu,vger.kernel.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-244726-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhecht73@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The current implementation of alvium_ctrl_init creates several controls in
function alvium_ctrl_init and uses the returned pointer without check. That
can cause write access over NULL-pointer for several controls. The reworked
code checks the pointers before adding flags.

Fixes: 0a7af872915e ("media: i2c: Add support for alvium camera")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Hecht <mhecht73@gmail.com>
---
Changes in v3 (since v1):
- Split conditional creation of manual WB controls into another patch.
- Limit changes only on checking returned pointer values.
- ctrls->pixel_rate->flags is readonly by default, no need to replicate that.

Changes in v2:
- Has been rewoked completely because file was brocken.
---
 drivers/media/i2c/alvium-csi2.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
index b62b45a4f2fc..f51f9b987759 100644
--- a/drivers/media/i2c/alvium-csi2.c
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -2100,20 +2100,21 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
 					      V4L2_CID_PIXEL_RATE, 0,
 					      ALVIUM_DEFAULT_PIXEL_RATE_MHZ, 1,
 					      ALVIUM_DEFAULT_PIXEL_RATE_MHZ);
-	ctrls->pixel_rate->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
 	/* Link freq is fixed */
 	ctrls->link_freq = v4l2_ctrl_new_int_menu(hdl, ops,
 						  V4L2_CID_LINK_FREQ,
 						  0, 0, &alvium->link_freq);
-	ctrls->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+	if (ctrls->link_freq)
+		ctrls->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
 	/* Auto/manual white balance */
 	if (alvium->avail_ft.auto_whiteb) {
 		ctrls->auto_wb = v4l2_ctrl_new_std(hdl, ops,
 						   V4L2_CID_AUTO_WHITE_BALANCE,
 						   0, 1, 1, 1);
-		v4l2_ctrl_auto_cluster(3, &ctrls->auto_wb, 0, false);
+		if (ctrls->auto_wb)
+			v4l2_ctrl_auto_cluster(3, &ctrls->auto_wb, 0, false);
 	}
 
 	ctrls->blue_balance = v4l2_ctrl_new_std(hdl, ops,
@@ -2122,6 +2123,7 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
 						alvium->max_bbalance,
 						alvium->inc_bbalance,
 						alvium->dft_bbalance);
+
 	ctrls->red_balance = v4l2_ctrl_new_std(hdl, ops,
 					       V4L2_CID_RED_BALANCE,
 					       alvium->min_rbalance,
@@ -2136,7 +2138,9 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
 					       V4L2_CID_EXPOSURE_AUTO,
 					       V4L2_EXPOSURE_MANUAL, 0,
 					       V4L2_EXPOSURE_AUTO);
-		v4l2_ctrl_auto_cluster(2, &ctrls->auto_exp, 1, true);
+		if (ctrls->auto_exp)
+			v4l2_ctrl_auto_cluster(2, &ctrls->auto_exp,
+					       V4L2_EXPOSURE_MANUAL, true);
 	}
 
 	ctrls->exposure = v4l2_ctrl_new_std(hdl, ops,
@@ -2145,14 +2149,16 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
 					    alvium->max_exp,
 					    alvium->inc_exp,
 					    alvium->dft_exp);
-	ctrls->exposure->flags |= V4L2_CTRL_FLAG_VOLATILE;
+	if (ctrls->exposure)
+		ctrls->exposure->flags |= V4L2_CTRL_FLAG_VOLATILE;
 
 	/* Auto/manual gain */
 	if (alvium->avail_ft.auto_gain) {
 		ctrls->auto_gain = v4l2_ctrl_new_std(hdl, ops,
 						     V4L2_CID_AUTOGAIN,
 						     0, 1, 1, 1);
-		v4l2_ctrl_auto_cluster(2, &ctrls->auto_gain, 0, true);
+		if (ctrls->auto_gain)
+			v4l2_ctrl_auto_cluster(2, &ctrls->auto_gain, 0, true);
 	}
 
 	if (alvium->avail_ft.gain) {
@@ -2162,7 +2168,8 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
 						alvium->max_gain,
 						alvium->inc_gain,
 						alvium->dft_gain);
-		ctrls->gain->flags |= V4L2_CTRL_FLAG_VOLATILE;
+		if (ctrls->gain)
+			ctrls->gain->flags |= V4L2_CTRL_FLAG_VOLATILE;
 	}
 
 	if (alvium->avail_ft.sat)
-- 
2.43.0


