Return-Path: <stable+bounces-176871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 158E2B3E6F6
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 16:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC03A7A6714
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 14:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D232F49EE;
	Mon,  1 Sep 2025 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3G/osQx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339731F4621;
	Mon,  1 Sep 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736688; cv=none; b=X7rP71fh6XaLx/bgxSUjsSIQNUOaCmABpD4JsWUaiTNjaADBiZBMkkfo2Xneswaf4YWv76lcvF/BtQ++qc9nfQCN+4WpwSvcxikmAbLQIOSsFzRu0L/ZiYHqqfvNVLpv3zXl3wkrH2tfqDsAilzpw116ERCDb+uXqcL8ySbLK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736688; c=relaxed/simple;
	bh=ZtG+wa3X6+HfL309XwwUBOo4DsFffE3TJur0zd963GY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UFOvvIdUSGd3QRzHFbY7oDQL2cnXy+C5zNNOwA1Sil28EZYzkD9mL9OAFW8J9coKmOQkjxo55Sok/jsiPbx8Js4ZqHjQH9O0QwUZ46kdMfzLWskU0b/iyZuExMYBDxHLB8GyGF9A44QUEu4EhhD1q5hSsuZPwKrKv7Y4Yu0/7Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3G/osQx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b7d485204so34929855e9.0;
        Mon, 01 Sep 2025 07:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756736684; x=1757341484; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rqvcXlp0W7MSF3vmJ03eJQXl6LGqOtNp4w5UN/Mvcy0=;
        b=E3G/osQxwlSAKuGIn7c0Fb5kj6ej1+O/J8mUkyesc+F4EQDRhKyXgS+1tLBYJzZd3R
         2RVFnPXeOkqC+kufCcLSdTtBiyhshbBM5hoZojpPr1sxlkxQnLX3/TnDn7MnclngWFYU
         nKk/obV3RNXGav7y/DinOjfTvdfqzE0+7Y7H/cElW1feVFot8gRiIhCdX+ivTlq0Egv6
         1xjhgbZa82Rg3bMQg3fNa1u5xUguQpqWZ5y2hk7MtIA9ESDKB5ZUPp5LxVTyoFhQW7nJ
         n0WBfLkOETKuX8IQRD1I8oxpTXKFqjfldHZeLTKpoBHz56SdtXYN7O/GNxhQT32aIJzb
         9E0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756736684; x=1757341484;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rqvcXlp0W7MSF3vmJ03eJQXl6LGqOtNp4w5UN/Mvcy0=;
        b=Cgf3SVYz3Q2H3kiX8ycin96RVXMl+uJb3ixkTlKAjKIUc5ZDxlSx1+8qi2WHBjrTLJ
         TUEcvMo+E8CWPpvb+VE/gDWDh5df29OKnenzfMA2DqgcHYWrINrkTc4zl8CnD4kKq+GH
         f+QA03/mCLFiMHakwP0k2bSu4jh1j31wRmv7LLiw6kDBy+fvZNtEXQzp2b5SnrVoTjv5
         sNDa+JXzz/hKcviQPTvS7S9oQsyUgNZ5t77r13rS9tr3yokUxEakbcjk6tVZ5lAiA3WE
         /JKSXy1XDy6G9Tl7SJXyQV39DdYFRzbf/S+EZZRpiV8wZ4DHWWIq3B3QdyuOaJHsQ6L+
         JTkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjnY2p9Gd/sDNCGjls6pjIqRUHAbZPhHYzc29kgHcTd3iF1CokvEyNF1oV3jtmSPALAmGQm3f3@vger.kernel.org, AJvYcCWcWI0nim3uxdEjcsG5sV8/v7u2ZF8k2P5YVsNM0Ozk/n3H+9ane3rqz+0lLofJdsAiceag7czzKT48bqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk+cXrtb9jfZ+NPqMaypcwG2HWfpsaXyQlX/yg10yq9CUocIlU
	OuWE5g90TwO452gSQjebk1TJyq1MONVTCLvCEquYPdUG6dkTo8Z4Q/zw
X-Gm-Gg: ASbGncs6Jf7XxeLNPvtAGa1gBtIxy3/tRrdSvkmGYTRTfJ5ITLUSVf7lrvbb0LQDx8D
	t8xp8XOuoPGKGctREpYgf9aM/hEIz5c2NnEPH5Dz5p3Mxi2LNBJFUFhyxT7MY6QKU6by4tQsXvu
	gMW7Gnv4LWdMFLnQIQkMziKM18iWmDEqhvR7YByOsUzSt9iT0JYzqoPhDNldRCsDpoR5ESxe+iF
	g1TY3vUXFiiYhAHMLo8TQrUzksiw5R0L8GAgVoEyCtbevnA9998deumx6ApyQ8upMNZxZuMzknm
	RClxegYP6/CxSqgoQKw0vHCPFOBzagX2yF08jgiEWBWWc/X3MNAOgBU/1zdSMjzfxAzIXZpkO8v
	8irXMoKAunCqBfrLtLIMC+HpjQS9WCgf0j5Q1+T0TrTKgl3QryDAX5yfEaia6Fg==
X-Google-Smtp-Source: AGHT+IHqPtct6XqWPq/LJ5GxcIfD94d0NHMlxPrBgPKNbuLPMxEx6hG7wkfcL+GTCikbm6rlk5HEHQ==
X-Received: by 2002:a05:6000:2408:b0:3cb:d8e2:48b2 with SMTP id ffacd0b85a97d-3d1dc78e7f4mr7803896f8f.13.1756736684089;
        Mon, 01 Sep 2025 07:24:44 -0700 (PDT)
Received: from [192.168.0.253] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3d26f22f5bdsm10142026f8f.37.2025.09.01.07.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 07:24:43 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 01 Sep 2025 16:24:35 +0200
Subject: [PATCH v2] mtd: core: always verify OOB offset in
 mtd_check_oob_ops()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-mtd-validate-ooboffs-v2-1-c1df86a16743@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKKstWgC/4WNQQ6CMBBFr0Jm7RgKAsWV9zAsajuFSSglLWk0h
 LtbuYDL95L//g6RAlOEe7FDoMSR/ZKhuhSgJ7WMhGwyQ1VWTSlrgW4zmNTMRm2E3r+8tRGpbnT
 Xt82ttAR5ugay/D6zzyHzxHHz4XO+JPGzf4JJoEBTW6OpU7Lt5WN0iuer9g6G4zi+14CeK7gAA
 AA=
X-Change-ID: 20250831-mtd-validate-ooboffs-e35c796540fe
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.2

Using an OOB offset past end of the available OOB data is invalid,
irregardless of whether the 'ooblen' is set in the ops or not. Move
the relevant check out from the if statement to always verify that.

The 'oobtest' module executes four tests to verify how reading/writing
OOB data past end of the devices is handled. It expects errors in case
of these tests, but this expectation fails in the last two tests on
MTD devices, which have no OOB bytes available.

This is indicated in the test output like the following:

    [  212.059416] mtd_oobtest: attempting to write past end of device
    [  212.060379] mtd_oobtest: an error is expected...
    [  212.066353] mtd_oobtest: error: wrote past end of device
    [  212.071142] mtd_oobtest: attempting to read past end of device
    [  212.076507] mtd_oobtest: an error is expected...
    [  212.082080] mtd_oobtest: error: read past end of device
    ...
    [  212.330508] mtd_oobtest: finished with 2 errors

For reference, here is the corresponding code from the oobtest module:

    /* Attempt to write off end of device */
    ops.mode      = MTD_OPS_AUTO_OOB;
    ops.len       = 0;
    ops.retlen    = 0;
    ops.ooblen    = mtd->oobavail;
    ops.oobretlen = 0;
    ops.ooboffs   = 1;
    ops.datbuf    = NULL;
    ops.oobbuf    = writebuf;
    pr_info("attempting to write past end of device\n");
    pr_info("an error is expected...\n");
    err = mtd_write_oob(mtd, mtd->size - mtd->writesize, &ops);
    if (err) {
            pr_info("error occurred as expected\n");
    } else {
            pr_err("error: wrote past end of device\n");
            errcnt += 1;
    }

As it can be seen, the code sets 'ooboffs' to 1, and 'ooblen' to
mtd->oobavail which is zero in our case.

Since the mtd_check_oob_ops() function only verifies 'ooboffs' if 'ooblen'
is not zero, the 'ooboffs' value does not gets validated and the function
returns success whereas it should fail.

After the change, the oobtest module will bail out early with an error if
there are no OOB bytes available on the MDT device under test:

    # cat /sys/class/mtd/mtd0/oobavail
    0
    # insmod mtd_test; insmod mtd_oobtest dev=0
    [  943.606228]
    [  943.606259] =================================================
    [  943.606784] mtd_oobtest: MTD device: 0
    [  943.612660] mtd_oobtest: MTD device size 524288, eraseblock size 131072, page size 2048, count of eraseblocks 4, pages per eraseblock 64, OOB size 128
    [  943.616091] mtd_test: scanning for bad eraseblocks
    [  943.629571] mtd_test: scanned 4 eraseblocks, 0 are bad
    [  943.634313] mtd_oobtest: test 1 of 5
    [  943.653402] mtd_oobtest: writing OOBs of whole device
    [  943.653424] mtd_oobtest: error: writeoob failed at 0x0
    [  943.657419] mtd_oobtest: error: use_len 0, use_offset 0
    [  943.662493] mtd_oobtest: error -22 occurred
    [  943.667574] =================================================

This behaviour is more accurate than the current one where most tests
are indicating successful writing of OOB data even that in fact nothing
gets written into the device, which is quite misleading.

Cc: stable@vger.kernel.org
Fixes: 5cdd929da53d ("mtd: Add sanity checks in mtd_write/read_oob()")
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v2:
  - add Reviewed-by tag from Daniel
  - add stable and Fixes tags
  - Link to v1: https://lore.kernel.org/r/20250831-mtd-validate-ooboffs-v1-1-d3fdce7a8698@gmail.com
---
 drivers/mtd/mtdcore.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 5ba9a741f5ac3c297ae21329c2827baf5dc471f0..9a3c9f163219bcb9fde66839f228fd8d38310f2d 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1590,12 +1590,12 @@ static int mtd_check_oob_ops(struct mtd_info *mtd, loff_t offs,
 	if (offs < 0 || offs + ops->len > mtd->size)
 		return -EINVAL;
 
+	if (ops->ooboffs >= mtd_oobavail(mtd, ops))
+		return -EINVAL;
+
 	if (ops->ooblen) {
 		size_t maxooblen;
 
-		if (ops->ooboffs >= mtd_oobavail(mtd, ops))
-			return -EINVAL;
-
 		maxooblen = ((size_t)(mtd_div_by_ws(mtd->size, mtd) -
 				      mtd_div_by_ws(offs, mtd)) *
 			     mtd_oobavail(mtd, ops)) - ops->ooboffs;

---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250831-mtd-validate-ooboffs-e35c796540fe

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


