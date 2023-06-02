Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D947720A7E
	for <lists+stable@lfdr.de>; Fri,  2 Jun 2023 22:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbjFBUoN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 16:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjFBUoM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 16:44:12 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C7A1A6
        for <stable@vger.kernel.org>; Fri,  2 Jun 2023 13:44:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f4d80bac38so3338135e87.2
        for <stable@vger.kernel.org>; Fri, 02 Jun 2023 13:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685738649; x=1688330649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9rd/H5LZeGNsQjBkz2Gf2rkXX/hq9GYqk6eLCuVnnQA=;
        b=nG5UYi/mikn09iRuvFsoU3axTq++gJa9uQGMbbBl2cIRTh/lJ7AIE+T6fD0V1LUUGs
         iptGj/HlY/R67KyYJDwgIL05PLU09MjakPB2FcgV2Rqd2tY9oQV9r+l801jNvsFtHKTO
         gQnYcSxjXMdT/5ePn4G84oS/lp5tX9+EkkqNiH2Me6D3chPGLBG6Ok0kl1YZbes5AvFZ
         J5xaDG/oE4ywJ4+8y+ZsEIgmntDX4SE4IMRDeGuEUu2zSpJXWQEJtyEUcVpoDcr+DVL7
         w302w73B2qsNeCVSj1ra+QuomHhxq+HjNT8eOVmcAujv9LHFPqDj3vdvRMcpoe/7BQ6r
         1kjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685738649; x=1688330649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rd/H5LZeGNsQjBkz2Gf2rkXX/hq9GYqk6eLCuVnnQA=;
        b=chX5k5idHBXV1AcAts7VabdRtsgoxV8dXBU+GC640Tf+nUIu/ncsjNOp5hFL1pPh/H
         vpr8k/7OU3Nx/DYUibrPqU2YIP+kBpaLcZXRrGUs72gBfW/A9OkfqP8gMzisFQIAloXw
         2YXuQKwc7vG4a6SEzCsQSuVe50RU4H8UmInkmLs1BWj3DX62SVBiGwZc05uW4T1Mwpg2
         3nrYTbtar0XxcG8taz6H359VeUlLJEJUj8TOsz71nHqoBf61pPOue+GgONRYfRJrkSCn
         H5B03pvGfTCBr3B5LP2xEgNt5nu90ItPkuU1Jt6J0Jg/1HN6mU68/ZKyIEg+SLZt5ruR
         BeNw==
X-Gm-Message-State: AC+VfDxhbjRAq8nzUCX3ZQMJLlJwOvLfcb7LxGw9JA+ubL61j8KUPWiY
        Zz/mVZhS9AeJWxHgXMCDLy4iuQagCtXeoZTbQxg=
X-Google-Smtp-Source: ACHHUZ7xcEylBm0OQcCuvh7XXsAb0Db+nkjBoXlqxM3eXd731dBOMKRh0zdbidlqsrt7QJpZMQ7f3g==
X-Received: by 2002:a05:6512:98b:b0:4f5:a17f:4897 with SMTP id w11-20020a056512098b00b004f5a17f4897mr2403404lft.43.1685738648691;
        Fri, 02 Jun 2023 13:44:08 -0700 (PDT)
Received: from Fecusia.lan (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id o2-20020a056512050200b004f122a378d4sm268473lfb.163.2023.06.02.13.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 13:44:07 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <npitre@baylibre.com>, stable@vger.kernel.org
Subject: [PATCH v3] mtd: cfi_cmdset_0001: Byte swap OTP info
Date:   Fri,  2 Jun 2023 22:43:59 +0200
Message-Id: <20230602204359.3493320-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Currently the offset into the device when looking for OTP
bits can go outside of the address of the MTD NOR devices,
and if that memory isn't readable, bad things happen
on the IXP4xx (added prints that illustrate the problem before
the crash):

cfi_intelext_otp_walk walk OTP on chip 0 start at reg_prot_offset 0x00000100
ixp4xx_copy_from copy from 0x00000100 to 0xc880dd78
cfi_intelext_otp_walk walk OTP on chip 0 start at reg_prot_offset 0x12000000
ixp4xx_copy_from copy from 0x12000000 to 0xc880dd78
8<--- cut here ---
Unable to handle kernel paging request at virtual address db000000
[db000000] *pgd=00000000
(...)

This happens in this case because the IXP4xx is big endian and
the 32- and 16-bit fields in the struct cfi_intelext_otpinfo are not
properly byteswapped. Compare to how the code in read_pri_intelext()
byteswaps the fields in struct cfi_pri_intelext.

Adding a small byte swapping loop for the OTP in read_pri_intelext()
and the crash goes away.

The problem went unnoticed for many years until I enabled
CONFIG_MTD_OTP on the IXP4xx as well, triggering the bug.

Cc: Nicolas Pitre <npitre@baylibre.com>
Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Move the byte swapping to a small loop in read_pri_intelext()
  so all bytes are swapped as we reach cfi_intelext_otp_walk().
ChangeLog v1->v2:
- Drill deeper and discover a big endian compatibility issue.
---
 drivers/mtd/chips/cfi_cmdset_0001.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_cmdset_0001.c
index 54f92d09d9cf..02aaf09d6f5c 100644
--- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -421,9 +421,25 @@ read_pri_intelext(struct map_info *map, __u16 adr)
 		extra_size = 0;
 
 		/* Protection Register info */
-		if (extp->NumProtectionFields)
+		if (extp->NumProtectionFields) {
+			struct cfi_intelext_otpinfo *otp =
+				(struct cfi_intelext_otpinfo *)&extp->extra[0];
+
 			extra_size += (extp->NumProtectionFields - 1) *
-				      sizeof(struct cfi_intelext_otpinfo);
+				sizeof(struct cfi_intelext_otpinfo);
+
+			if (extp_size >= sizeof(*extp) + extra_size) {
+				int i;
+
+				/* Do some byteswapping if necessary */
+				for (i = 0; i < extp->NumProtectionFields - 1; i++) {
+					otp->ProtRegAddr = le32_to_cpu(otp->ProtRegAddr);
+					otp->FactGroups = le16_to_cpu(otp->FactGroups);
+					otp->UserGroups = le16_to_cpu(otp->UserGroups);
+					otp++;
+				}
+			}
+		}
 	}
 
 	if (extp->MinorVersion >= '1') {
-- 
2.40.1

