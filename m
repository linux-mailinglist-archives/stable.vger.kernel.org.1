Return-Path: <stable+bounces-244603-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULbVCpC//GnSTAAAu9opvQ
	(envelope-from <stable+bounces-244603-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 18:36:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 959694EC505
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 18:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 905113050920
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 16:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C20844D01F;
	Thu,  7 May 2026 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLmlj65e"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6777F3FAE18
	for <stable@vger.kernel.org>; Thu,  7 May 2026 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778171696; cv=none; b=dYu2ramBjrtMclqJ3F9Cl6f1/pNYuzgFzasyr1EeSj6LKqE3ZzS/5kHKWTMhTeSyAy69nvvvNLXIQu+0q02dlK6X9Wo0zWYOnLTf+NrwRjLkD8KJ22Kz6VgSDCPj7h+MjnvOWLzjPh5Q8qlhw/KGC1phdKYjhodER95hSxU77hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778171696; c=relaxed/simple;
	bh=67jMIhxSZ6IpyO4o5D89+eoatcvd8leasbTpm1BcyGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ud/2+/NBJFtAFzN4hIBMKonsqxZiJtDLlkZL/SBo00hny6saEHbGb9D6SGAU44gHsbjvSjdNXJP3VCns9Hu9NqlJJVZ/zOVNPyUvUGlalYWm04TakVl2PAWrV/sny/0ND7lWaNo82xD+9aydD14z2uXOZdVNLDBwDjQhuqG6vL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLmlj65e; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8f97c626aaso187794966b.2
        for <stable@vger.kernel.org>; Thu, 07 May 2026 09:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778171691; x=1778776491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gG5C6gXZ/LiIqxaLiBv5dvLMMivS9UIn2zta7LN39yI=;
        b=CLmlj65ewinVQn5Sg45tMrPfXYD+5JiXKJuvYgKSk7rag090lkITNnWveSfUK/1Moi
         3R6jvEalAQtptfJ/apDs0ywpPB5diEg6xim+XqZ0XCY1iv0uOizS+d8++QFa+amLFtRp
         ZUcvSORoT6Qd0lYUHcdQl0rrwOAvy5qgiw3SKYakAuwAavRFq49NCk59Ub+tWBaGC46K
         cMOhK1GchPUlgDB7QYeKJHCTsNbdSCnYJ8rd+XLECK/aKXU2hqk69HFPWpmfW6e6ZYvJ
         RaozdZe0myr1gIWVR3C9VHPRPcZPUG1T6TlX2jV4wdi2YPXiqocgHdIkozDbz/8JcRvs
         gUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778171691; x=1778776491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gG5C6gXZ/LiIqxaLiBv5dvLMMivS9UIn2zta7LN39yI=;
        b=SD39TXgilTy4FL8dTgof0QMbi2yxZzYcUACSF4Mc11CqdKN424LwVqzOwSO4Sh2pkb
         9bL9EmKBapzcOARshhRrAhG9Cp7pYS/3F6F/kPn9u7qWcdPltrxz4CSI2LtTpW5IEM3+
         lEW7yZW/oZGlqJLkhVjm63vu+IueH53XMK8dROlNiwuN6bxkU5yQ+zxALgBN1hwauy0W
         FBhjoVbaN2aUMGqZY/zTAtyRDEiM9rivq2tULl8ewDDmFOfCpSffZctQZ7JuNvUgoMwe
         mqHHPQrx1ljUil56qRmTHgcSv3EbnZcbpqXF/vKxZbvCoShkhvQ2Et+G5VvWG8bdpzBJ
         LOOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/IJ+PMhR+nBkUQ6JSr3Hbr8xujG+3BgQKJNIYeonh1ReF6oSNSkekH9LpCZ8f+mWIRbVqRBtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDP1h1MQUIbVrd6z9r8H8YHNi4kBguS216BWYKVprxn7UHHlks
	5Kmf02UYWMFzMjWR2kbtzmKuFOtZcZCRyIna3e3lmKSDOH+EW2ldky+h
X-Gm-Gg: AeBDieuIPavOd2goEPcDpRhfQA3lKJIFu6XpiKn/g21Y34WKWjAd+Ih0Y07TQfR8jBH
	jMIBxUQU/ZzbEzIo5DKfbayrCkkEqRZit3O7//iUzIreQveRjcZa37XNkeCDxRjFz/VrHv3qn5K
	GyIO4FkNACihqXTZ6BECCQk4uRsAgRxc0fQXGqGby5uJ8OuRpzoTPJKiTwdRs8Gej7f7fRirjqO
	9Yj/c3WuS5loe6UO0Mqte6lqNtJ/lBfm+2LMZMpBrHJlz1zvZDBPKkP9w3K5nSujtp0QDN+GXpD
	g9IcGrnE5IF6f3UusgHifIrgjizeq+KuYDWfAMLkWOVvl75A9XcI7XJevVGXQ/NFMN82DdAHk+G
	hfHXmDeazuOjBMVkurG907hYJ/t3ogaATl8aISSFfO3DmOe03K9Py+USWnRgRIpbQT3QS/e6hjG
	DF7UdyM7fDhK7/XkNnuX7UmbSB7gYvfJtN3A==
X-Received: by 2002:a17:907:3f24:b0:bc6:2bd3:8176 with SMTP id a640c23a62f3a-bc62bd388e2mr413967366b.35.1778171691229;
        Thu, 07 May 2026 09:34:51 -0700 (PDT)
Received: from avt74j0.. ([2a02:8109:8617:d700:d9bb:cdec:69e5:2f8e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67eb34dd33fsm8765a12.31.2026.05.07.09.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:34:50 -0700 (PDT)
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
Subject: [PATCH v1] media: i2c: alvium: fix critical pointer access in alvium_ctrl_init
Date: Thu,  7 May 2026 18:34:30 +0200
Message-ID: <20260507163443.39794-1-mhecht73@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 959694EC505
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,avnet.eu,vger.kernel.org,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244603-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhecht73@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

The current implementation of alvium_ctrl_init creates several controls
in function alvium_ctrl_init and uses the returned pointer without
check. That can cause write access over NULL-pointer for several
controls.
The reworked code checks the pointers before adding flags and also it
creates controls for V4L2_CID_BLUE_BALANCE and V4L2_CID_RED_BALANCE only
if supported by the particular camera model.

Fixes: 0a7af872915e ("media: i2c: Add support for alvium camera")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Hecht <mhecht73@gmail.com>
---
 drivers/media/i2c/alvium-csi2.c | 72 +++++++++++++++++++--------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
index b62b45a4f2fc..947b32950efa 100644
--- a/drivers/media/i2c/alvium-csi2.c
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -2100,34 +2100,41 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
 					      V4L2_CID_PIXEL_RATE, 0,
 					      ALVIUM_DEFAULT_PIXEL_RATE_MHZ, 1,
 					      ALVIUM_DEFAULT_PIXEL_RATE_MHZ);
-	ctrls->pixel_rate->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+	if (ctrls->pixel_rate)
+		ctrls->pixel_rate->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
 	/* Link freq is fixed */
 	ctrls->link_freq = v4l2_ctrl_new_int_menu(hdl, ops,
 						  V4L2_CID_LINK_FREQ,
 						  0, 0, &alvium->link_freq);
-	ctrls->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
-
-	/* Auto/manual white balance */
+	if (ctrls->link_freq)
+		ctrls->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+
+	/* manual white balance */
+	if (alvium->avail_ft.whiteb) {
+		ctrls->blue_balance = v4l2_ctrl_new_std(hdl, ops,
+							V4L2_CID_BLUE_BALANCE,
+							alvium->min_bbalance,
+							alvium->max_bbalance,
+							alvium->inc_bbalance,
+							alvium->dft_bbalance);
+
+		ctrls->red_balance = v4l2_ctrl_new_std(hdl, ops,
+						       V4L2_CID_RED_BALANCE,
+						       alvium->min_rbalance,
+						       alvium->max_rbalance,
+						       alvium->inc_rbalance,
+						       alvium->dft_rbalance);
+	}
+
+	/* Auto white balance */
 	if (alvium->avail_ft.auto_whiteb) {
 		ctrls->auto_wb = v4l2_ctrl_new_std(hdl, ops,
 						   V4L2_CID_AUTO_WHITE_BALANCE,
 						   0, 1, 1, 1);
-		v4l2_ctrl_auto_cluster(3, &ctrls->auto_wb, 0, false);
-	}
-
-	ctrls->blue_balance = v4l2_ctrl_new_std(hdl, ops,
-						V4L2_CID_BLUE_BALANCE,
-						alvium->min_bbalance,
-						alvium->max_bbalance,
-						alvium->inc_bbalance,
-						alvium->dft_bbalance);
-	ctrls->red_balance = v4l2_ctrl_new_std(hdl, ops,
-					       V4L2_CID_RED_BALANCE,
-					       alvium->min_rbalance,
-					       alvium->max_rbalance,
-					       alvium->inc_rbalance,
-					       alvium->dft_rbalance);
+		if (ctrls->auto_wb)
+			v4l2_ctrl_auto_cluster(3, &ctrls->auto_wb, 0, false);
+	}
 
 	/* Auto/manual exposure */
 	if (alvium->avail_ft.auto_exp) {
@@ -2136,7 +2143,9 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
 					       V4L2_CID_EXPOSURE_AUTO,
 					       V4L2_EXPOSURE_MANUAL, 0,
 					       V4L2_EXPOSURE_AUTO);
-		v4l2_ctrl_auto_cluster(2, &ctrls->auto_exp, 1, true);
+		if (ctrls->auto_exp)
+			v4l2_ctrl_auto_cluster(2, &ctrls->auto_exp,
+					       V4L2_EXPOSURE_MANUAL, true);
 	}
 
 	ctrls->exposure = v4l2_ctrl_new_std(hdl, ops,
@@ -2145,15 +2154,8 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
 					    alvium->max_exp,
 					    alvium->inc_exp,
 					    alvium->dft_exp);
-	ctrls->exposure->flags |= V4L2_CTRL_FLAG_VOLATILE;
-
-	/* Auto/manual gain */
-	if (alvium->avail_ft.auto_gain) {
-		ctrls->auto_gain = v4l2_ctrl_new_std(hdl, ops,
-						     V4L2_CID_AUTOGAIN,
-						     0, 1, 1, 1);
-		v4l2_ctrl_auto_cluster(2, &ctrls->auto_gain, 0, true);
-	}
+	if (ctrls->exposure)
+		ctrls->exposure->flags |= V4L2_CTRL_FLAG_VOLATILE;
 
 	if (alvium->avail_ft.gain) {
 		ctrls->gain = v4l2_ctrl_new_std(hdl, ops,
@@ -2162,7 +2164,17 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
 						alvium->max_gain,
 						alvium->inc_gain,
 						alvium->dft_gain);
-		ctrls->gain->flags |= V4L2_CTRL_FLAG_VOLATILE;
+		if (ctrls->gain)
+			ctrls->gain->flags |= V4L2_CTRL_FLAG_VOLATILE;
+	}
+
+	/* Auto/manual gain */
+	if (alvium->avail_ft.auto_gain) {
+		ctrls->auto_gain = v4l2_ctrl_new_std(hdl, ops,
+						     V4L2_CID_AUTOGAIN,
+						     0, 1, 1, 1);
+		if (ctrls->auto_gain)
+			v4l2_ctrl_auto_cluster(2, &ctrls->auto_gain, 0, true);
 	}
 
 	if (alvium->avail_ft.sat)
-- 
2.43.0


