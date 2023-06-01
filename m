Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1DC71F31E
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 21:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjFATlc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 15:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFATlb (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 15:41:31 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EAD186
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 12:41:30 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b1a86cdec6so6658011fa.3
        for <stable@vger.kernel.org>; Thu, 01 Jun 2023 12:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685648488; x=1688240488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=07Cs4CQ5DO1E16iWtYpBiJJQS/hY2lJCobeGVpSPz14=;
        b=BNbaGYUEPpkIx4sUkDST9v15mLetC5t+6DrHUStkqsmV/6rOnG+1WbUPV6OEC2tk4M
         0ANOn1pt0ljW6tJDUFNzzKmbLNf0BKPd7SHcemjWpYUfbUgBnGOnKK8nAYtqmcS/4jvI
         Tu2p5csWgqIX78821O7KDys6arNlhUbw0dXpSkU5W+mcS+KPt/1gUj4nr+aaO6gHtUUx
         F+f5fM2U+aWWK0QhsrzsMlodirxPsmxVSQmNDnQbSIwvXcsyURlrG7BN1uB9PlfFNBOr
         M7oyDZFFdGUv9yCZzabZmNwpOib6rgQ7heO2QAWiQOoay2JCCggkefwlefyv9zi6ry11
         Gs7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685648488; x=1688240488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07Cs4CQ5DO1E16iWtYpBiJJQS/hY2lJCobeGVpSPz14=;
        b=Xb672qX3/fLI/v8AED5m22TzcHkEp4PrwYdHM8cqMujHenTIa6v9zn7ok7EhGh3eef
         lSNDIXbYNPAAuamo3DxXY+cnyBqNK8HdY92ULahZNVgoUlVw4ttS/ZVi/rxlChwYWm0G
         2y0Z+w64FD3UpawaUdwIy9UTLRTn3RhlZD0I3RQg2qLfm/dbgP6ud2+m0zUxU28QJPF/
         g2Y3lEabifHCUPzvL7n4A6Ij1pySaF+MeWGIDE4I/CBjK9Gf7AIYTQR0h5QT9IrexX2e
         Mxfcf352S4CxHK1T0J7iQ0x6+mH3YXGK8j3BnPZuI3CfiwkjSYTd8oisSGUR8vbcFH14
         8/HQ==
X-Gm-Message-State: AC+VfDwldpyyUCGKrHY6eOkrKahsNMsbRGc56JksWBZsQn4d9uZvl8Vl
        g98aQPpeaEYFLSjRm+uWm3lhpLazXh7OdYPMdf8=
X-Google-Smtp-Source: ACHHUZ4h/V0ZRBer47FFwyNEFzpKTVp1xztDqVg7voJCoqd35yq/sZCaCdokL5wLaMjiqXVRAM00nA==
X-Received: by 2002:a2e:8048:0:b0:2af:228a:8670 with SMTP id p8-20020a2e8048000000b002af228a8670mr307386ljg.2.1685648488245;
        Thu, 01 Jun 2023 12:41:28 -0700 (PDT)
Received: from Fecusia.lan (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id v21-20020a2e87d5000000b002ab59a09d75sm3879222ljj.120.2023.06.01.12.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 12:41:27 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Pitre <npitre@baylibre.com>, stable@vger.kernel.org
Subject: [PATCH v2] mtd: cfi_cmdset_0001: Byte swap OTP info
Date:   Thu,  1 Jun 2023 21:41:23 +0200
Message-Id: <20230601194123.3408902-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Adding some byte swapping after casting the &extp->extra[0] into
a struct cfi_intelext_otpinfo * pointer, and the crash goes away.

The problem went unnoticed for many years until I enabled
CONFIG_MTD_OTP on the IXP4xx as well, triggering the bug.

Cc: Nicolas Pitre <npitre@baylibre.com>
Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Drill deeper and discover a big endian compatibility issue.
---
 drivers/mtd/chips/cfi_cmdset_0001.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_cmdset_0001.c
index 54f92d09d9cf..7603b0052a16 100644
--- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -2336,6 +2336,11 @@ static int cfi_intelext_otp_walk(struct mtd_info *mtd, loff_t from, size_t len,
 		chip = &cfi->chips[chip_num];
 		otp = (struct cfi_intelext_otpinfo *)&extp->extra[0];
 
+		/* Do some byteswapping if necessary */
+		otp->ProtRegAddr = le32_to_cpu(otp->ProtRegAddr);
+		otp->FactGroups = le16_to_cpu(otp->FactGroups);
+		otp->UserGroups = le16_to_cpu(otp->UserGroups);
+
 		/* first OTP region */
 		field = 0;
 		reg_prot_offset = extp->ProtRegAddr;
-- 
2.40.1

