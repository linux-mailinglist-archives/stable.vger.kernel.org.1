Return-Path: <stable+bounces-176691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0E2B3B6CB
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 11:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D47F1C25F9B
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 09:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7A62F617B;
	Fri, 29 Aug 2025 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ewACIXGu"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A833025DB12
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458890; cv=none; b=TjiqA9aKalG8vsv1exX9Pe3h5kN2obmams9N7oki0IIFtiYwtgeQQsv7DfXRAF9iC8iKuzpBNW3y+27t8cjBYXButwPdtzh9CdcY2SHBrr0DvfT/UtAxNuUAeiUrswTeCU1v3l1Ss0di8VDJ0+onKN+bvKkZadGbBbu27NqRKDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458890; c=relaxed/simple;
	bh=GYhKNJswLW4IPBl68A6X78Ts9TSiGfI+3AkJiv3sW/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sqIpLCK3SkoS2OSdl8+juzPqyw2FGw4zlfFxOPGLZi2UmKokPnDTWva3HN93aV4nJl5ZHKD0Hz3Vo8CTTHg3d907BMqjSVehcWYQxDBbcULijMaFIEh6Uxcj2YYy9tHQd0nn+bFTH45o46GRAkPaPn5NCWDIvD5MjGLNYUj/JKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ewACIXGu; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afea7e61575so217241666b.2
        for <stable@vger.kernel.org>; Fri, 29 Aug 2025 02:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756458885; x=1757063685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kmQAx6HSRLTh/zFI/3605hgJxHe7kWmftVvK8IMvrA8=;
        b=ewACIXGuiS8ISqMpUa44ednytVJqDvZ3AJVF9o6yBO6al/A3Trq2yw56kTn2Joqnvg
         6QmKENJD/U5zFv0juGv7Z+2x8U3x9sgToIh3VrVfUU+w895COnoC2CpHRKIwAq5sGvcC
         gqSwJHuGyOa5pAfVmE5I2DIK2vbez32FHsV0uHRKc9Zq9uJY/Ep4jf/Fn2JexxHA6joB
         O06pIHwrf7UxgwBuVUreE5oyltsFt8YG9YoN945AVXM+BOKpmwry1nWzZvLfrj75MNix
         psZku6mehpzitTAevKf5PLHJoatHCYGcUBVD2eExyW2aCutLFV23jTj7Jn0lAbx7+Dwr
         kpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756458885; x=1757063685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmQAx6HSRLTh/zFI/3605hgJxHe7kWmftVvK8IMvrA8=;
        b=ghEcMiIPpWjAabxnC1HH0B/Ba7Ge7cCI6hsU2gdLMdycP7HU7YwHTqtrUXvueL1bnm
         jo6/G6cvs1TqCWRQoeKQn+mkIWbmzrNwAPCibNkSof7NmLsB5mYmW/iSieL5EH8gWJ7G
         EQxjTz4jzwzFzVTCVYrcWOpBv0SzAGleCekRfOceRknQU3DeajfrlEQ8bhhLdUG6R5Ts
         2OptNZivbhbOZ2T3CSAdR/ZiKfvL3aShwRTG6fOShCA+yiDO9SsKBN1nYbEwiRDAaiJ5
         3OjtbE4yymyfUVRlDlMWbYS2EQ+QKX5Q8FjZxt1IHS/eUfJ6N+uXhyDKNFcuxaS+ll6l
         syzw==
X-Forwarded-Encrypted: i=1; AJvYcCVtJw+Y2WnYPHhSENo5kSaHgTnb0lP/d1ub9VZbH/+xnfzxpBx0CZMtV6Q6oItDuR3+DhvU0hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQFeeQlaVaA1EW9g0dlG4zxcRmR4cHwoHKL2iuV6+BYguc2dr5
	S+sAKoc6jbOp9m/pHm1DUS6ppAz74pdhdOWIQy0qFwCXTOLdhSq5myZtIxxXBHHVCrs=
X-Gm-Gg: ASbGncs1Y20QGMrCmuQBDJFJIKUlNEGeb99YPUO7X+uqukjlMa7XEUBo7Idwp/nbNQW
	Lh3vF4bhfrtfDALbP/ZHcndOxPWwwFkZrKoDg2tMx9Gn2Ctm5iH1/Qm2tjM19tdeB4Pm5CjClG1
	+gh2ql21WPWlMuAQ3qD8sPwlmMHOVBIedca4z5s0BIJ1cks07PIST6ajKmmMbCbO4FE/i4CervG
	Cg05UPgdSq1GqnOVSp546uEhaY25VsBMHSryGVaBrtqrNBuKhfabeOWd/gdZXQf+DTSoX5HkP0Z
	kGFl8+/oPN0tIAr7w1x6pMOy3+NLPcFbX7PEtIKboYrmNrz4m4QP3hclUh8YAEpSq9FuJOdmKXk
	vC68K83zvdNS4bHaYl85nNTwlnfkkotuVvNgfW0Fqnp23YkeKQtjWmjyFYnPshR/s8znWnfXoGw
	rFYwiLEe5R6K4rFy1cZGoRhGXQddN49UV2wYL3NLUueoc=
X-Google-Smtp-Source: AGHT+IGB6p+wPGwqWVIJ1QllB0JDRnXeqTx87rRflV/WMVzo3i+xyRYddtAINLfaY7h5KL2CUoUzXA==
X-Received: by 2002:a17:907:6093:b0:afe:da1c:880b with SMTP id a640c23a62f3a-afeda1c8a77mr563396966b.15.1756458884864;
        Fri, 29 Aug 2025 02:14:44 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcc1c52fsm161630266b.73.2025.08.29.02.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 02:14:44 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akshay.gupta@amd.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	naveenkrishna.chatradhi@amd.com,
	linux@roeck-us.net,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] drivers/misc/amd-sbi/Kconfig: select REGMAP_I2C
Date: Fri, 29 Aug 2025 11:14:41 +0200
Message-ID: <20250829091442.1112106-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Without CONFIG_REGMAP, rmi-i2c.c fails to build because struct
regmap_config is not defined:

 drivers/misc/amd-sbi/rmi-i2c.c: In function ‘sbrmi_i2c_probe’:
 drivers/misc/amd-sbi/rmi-i2c.c:57:16: error: variable ‘sbrmi_i2c_regmap_config’ has initializer but incomplete type
    57 |         struct regmap_config sbrmi_i2c_regmap_config = {
       |                ^~~~~~~~~~~~~

Additionally, CONFIG_REGMAP_I2C is needed for devm_regmap_init_i2c():

 ld: drivers/misc/amd-sbi/rmi-i2c.o: in function `sbrmi_i2c_probe':
 drivers/misc/amd-sbi/rmi-i2c.c:69:(.text+0x1c0): undefined reference to `__devm_regmap_init_i2c'

Fixes: 013f7e7131bd ("misc: amd-sbi: Use regmap subsystem")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 drivers/misc/amd-sbi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/amd-sbi/Kconfig b/drivers/misc/amd-sbi/Kconfig
index 4840831c84ca..4aae0733d0fc 100644
--- a/drivers/misc/amd-sbi/Kconfig
+++ b/drivers/misc/amd-sbi/Kconfig
@@ -2,6 +2,7 @@
 config AMD_SBRMI_I2C
 	tristate "AMD side band RMI support"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  Side band RMI over I2C support for AMD out of band management.
 
-- 
2.47.2


