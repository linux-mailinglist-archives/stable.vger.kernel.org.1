Return-Path: <stable+bounces-15761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6E383B75B
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 03:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342CC1F22C8B
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 02:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02AC613A;
	Thu, 25 Jan 2024 02:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWhKV2Z6"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063B31842
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 02:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706150940; cv=none; b=P7vq4+8a5MC/VZft851oH/kIlV2PX5ZhDxETHiZrsrz253OzNZKUplSquzG2TJvn5zGjvlQLbpsNn1veDev8TbeszJFCgpPr2nAQYgPhRiCiViyx33qBZvzCd3loZbz+x8Bm1nyGB/GStwkYqa8IAe6UFZCmGFCR2u8owECKKYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706150940; c=relaxed/simple;
	bh=ylslGzVGnTGyUq8O0pM8fAJsYkLPZ7/+BUy28Q8qbqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=in2ssa/YcUJKA70m1YnHZJ0wKArPl2kEjNeP6P10zpI25PFraowecdBaNHuvaKOQ0bzexATM5iKIsT6WUc/yjfAuPI4Ef6hd50bOvtv3//h+qs+nFQJ1SHyjCT93khW5VmCgJMX+wWVL9TjEa7S3WHx35tp9vi1uTik6Fe5mEJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWhKV2Z6; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bda6c92ce7so3817764b6e.2
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 18:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706150938; x=1706755738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CSf5KfP2riT/ovA/nRZqILHhaPaqgdTgBwq7VQR8loE=;
        b=RWhKV2Z6zJcTGQQJ2T/8ml7sVZEXxuWSCoGPqwjicb7/xWrhhP2dEQIIYuuvXPqkF5
         EhkEPVQkbbWaRHGIU7S1sGca77qp80AXncSoBQC7Zna51b7xhVSTZN1CYaHEh8Bt2guI
         VHZzBtaNFliE40UCjDTve1/8m4DOXgS6iMCgRuVWIqwdMpBcXxGCqsc2gM5bSnA0C3dM
         vqGnhwS8A68IYWyzWZo9cPTIXOhZyi1l5cwjbtzlx6iRZ4Bd1DnofmtARTAAhMKRzwiz
         BL7g1svIT+x5bYUreDkc9gowRHJVy1aIAGEjBwm8LvebT3TO1kiF6Ajr23RiaYAsVn96
         PqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706150938; x=1706755738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSf5KfP2riT/ovA/nRZqILHhaPaqgdTgBwq7VQR8loE=;
        b=gPce5gVOGpPSzBClkxOfBMHihBuN35eng3QuFRwF+5Mf1xH8H/C0POqCQS4en1d8o4
         LGyzgjm7uD9ug7vCV8+/TBk4iWuGGptuUJyeivdJzKkEpHpPWi+bBWhJPLfB2qAY1o7c
         h5r8uLDjbwlBM047nXp1kr5k8puRyBD5cavMLKLkogEkArv5gABcZ7UJfogVE85fQRsL
         kC/JFW0MynoGbTyD5WXOhByPWSKYhLACEWk4rYa8mZ87DrT5LvenFL34w6l4OUt/NXQT
         XAsgbDR3FIBqcr22DYu1RaE6NI2P2pPpxDkFA+0vpykp1rOlPm9vkAj8m+QxFBznf+Ou
         d82w==
X-Gm-Message-State: AOJu0Yz/qltu2BWN1YusNBVFzwitrwNL2X9oz7J7GHWqTPizRJTReUnh
	HYwDjDdszI6WZpEtwVl7xk61lBhJL2exokpj007Jre67u1dubolc
X-Google-Smtp-Source: AGHT+IHtusoyizC/zOA2Ej5j7y8NLUo8an2JxStQ8HLKnNq6s231IbjBaUBho3wC/VrdfWRTAEGlzQ==
X-Received: by 2002:a05:6808:1589:b0:3bd:a5b3:df00 with SMTP id t9-20020a056808158900b003bda5b3df00mr214346oiw.79.1706150937911;
        Wed, 24 Jan 2024 18:48:57 -0800 (PST)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00218300b006dbd341379dsm8392404pfi.68.2024.01.24.18.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 18:48:57 -0800 (PST)
Received: from hqs-appsw-appswa2.mp600.macronix.com (linux-patcher [172.17.236.35])
	by twhmp6px (Postfix) with ESMTPS id 270D180445;
	Thu, 25 Jan 2024 10:52:14 +0800 (CST)
From: Jaime Liao <jaimeliao.tw@gmail.com>
To: miquel.raynal@bootlin.com
Cc: jaimeliao@mxic.com.tw,
	stable@vger.kernel.org
Subject: [PATCH v3] mtd: spinand: macronix: Fix MX35LFxGE4AD page size
Date: Thu, 25 Jan 2024 10:48:16 +0800
Message-Id: <20240125024816.222554-1-jaimeliao.tw@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: JaimeLiao <jaimeliao@mxic.com.tw>

Support for MX35LF{2,4}GE4AD chips was added in mainline through
upstream commit 5ece78de88739b4c68263e9f2582380c1fd8314f.

The patch was later adapted to 5.4.y and backported through
stable commit 85258ae3070848d9d0f6fbee385be2db80e8cf26.

Fix the backport mentioned right above as it is wrong: the bigger chip
features 4kiB pages and not 2kiB pages.

Fixes: 85258ae30708 ("mtd: spinand: macronix: Add support for MX35LFxGE4AD")
Cc: stable@vger.kernel.org # v5.4.y
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
---
Hello,

This is my third attempt to fix a stable kernel. This patch is not a
backport from Linus' tree per-se, but a fix of a backport. The original
mainline commit is fine but the backported one is not, we need to fix
the backported commit in the 5.4.y stable kernel, and this is what I am
attempting to do. Let me know if further explanations are needed.

Regards,
Jaime
---
 drivers/mtd/nand/spi/macronix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index bbb1d68bce4a..f18c6cfe8ff5 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -125,7 +125,7 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
 	SPINAND_INFO("MX35LF4GE4AD", 0x37,
-		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_MEMORG(1, 4096, 128, 64, 2048, 40, 1, 1, 1),
 		     NAND_ECCREQ(8, 512),
 		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
 					      &write_cache_variants,
-- 
2.25.1


