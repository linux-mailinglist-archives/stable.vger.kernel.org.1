Return-Path: <stable+bounces-47971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34548FC31E
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 07:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A81428394F
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 05:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14CC21C178;
	Wed,  5 Jun 2024 05:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVs8/kU2"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC8F21C192;
	Wed,  5 Jun 2024 05:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717566608; cv=none; b=jY6iJ0JW2C5yBXyMtbO+3G0RGWrgZgoILPGV6DPMNcwjdL1oWWSELGccvXBIs491hC3b+UNfB9QsBdIfVZmUIQOAfAz7U8RRffIXi76biPMWlWxtRtjeyqkudgLz2dOdib3Auw81/YVt4N/VdVpM7J8f02q2IJESlXIcenAmrts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717566608; c=relaxed/simple;
	bh=yJx99h/vrjH/otsUg9XNdPVe5/820krM6rs9eRejcgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yeg9d8C18Klh7Eg/MCSsv7JACMkEKDKTkWT7YyOlk5ZYAnLREsg8J0kXPfoB4hI4EooBDnsMBngxRRpYY2pDtN9xxjnxa1XX0mTQK4c9Y7+srf0Xcj3XxwpTquMO6hh5LZpbXI/wEL2+7Wp516OhFTgjkYX8ga1OEcct81A68IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVs8/kU2; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3747e9f7cceso21879195ab.1;
        Tue, 04 Jun 2024 22:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717566605; x=1718171405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OXXx+G8S3LAOXSoSSC7Exyjxb+cKriQft0ZkCAiNSTo=;
        b=EVs8/kU2QK11zUmd3iXKLlgjD3NC1s71p4VF9HfE5WiF+RcYiSVb5/l/YdNwHhVbnP
         IvrszawkzBv3qbwxCiDzMuF73S03yXuGL1Q3wkTBO4Hy/VHQndYupyboyTZO8ErQON8X
         9DyaGC4+FofpmFvLp35M2YZdRpRIpDZCwQYvML/JXs9wcfnS7uGdp5+ZZkd3Ut5NLPTZ
         sXYV2fF/rKgrQI+EbhraytC5HmHWk7ZeHcUi6U4X1Fjqn9gZDAxgBbjlJaAQO99XqV1/
         0GCuhqzKxonx4nsr/RSSTGZRhVUCh/jeqDkLpxBo6564ifGVqYcAZ9EGSU3UM3IVw39G
         aaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717566605; x=1718171405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OXXx+G8S3LAOXSoSSC7Exyjxb+cKriQft0ZkCAiNSTo=;
        b=ZpvmYai4rgoC2uaLMip2ZQHeXHojy+f5YVefDnT1t61ldIbmboJCjkC9q09iOM1pbs
         Q6NwUzN7UmzEslZU4KRIIZyPmL7RCaYCiQd9qW9iObp56VOz3B5fKXaYtB0OjF4R6VNp
         l9l+xkdNWcQocHKFac2v11KLq3Y7D7TP54sfUbxMIs1rJpZCdhL/oIXXGMl719YLjoqi
         0+LiNbKEkap+2otYsz9re6dziG6/7WPgfG2RAhKJUFck6IIsvpvTq99tIyVDBGOB3HAN
         hC1N1ZMTcjTm05xcqHZpBYtqlrKfnF8FXx5AcWO08dDDmxcKSnjdbvGfPQWmcXmIIX9V
         iGgA==
X-Forwarded-Encrypted: i=1; AJvYcCVIg8/CO1bEIsTsdoFTNKmI+uIXSTKfjrAJiAajxYVqXU/8l48cXHa5rNIgvvE3wAs/0qTgdi7A01le1kWM6jN2uH7ny71q0wGg1DAlw0mRADl70DIGNuYVj1djXjMEHrYvYLmf
X-Gm-Message-State: AOJu0Yzme4kZ7aau/9lsyESuCrCq76z8P7vElLrUOH3NnmVyqBtESwz4
	rfLZww3QLRHoSw/41DJL8jqc6aT/uHBFfciQ9w/o1a/Xg5DORMzg
X-Google-Smtp-Source: AGHT+IG38HU/vMh5r37/64xeKQTWdknfeAX9UDHPB1tG+qQoA83kVSKVnVC84EjBIYaGa+AdYwOc5w==
X-Received: by 2002:a05:6e02:1d05:b0:374:9af0:5f38 with SMTP id e9e14a558f8ab-374b1f55db6mr14629265ab.32.1717566605527;
        Tue, 04 Jun 2024 22:50:05 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c3598487d9sm7845318a12.70.2024.06.04.22.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 22:50:05 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 3FBDD80587;
	Wed,  5 Jun 2024 13:52:59 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	dwmw2@infradead.org,
	computersforpeace@gmail.com,
	marek.vasut@gmail.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	stable@vger.kernel.org
Subject: [PATCH v2] mtd: spinand: macronix: Add support for serial NAND flash
Date: Wed,  5 Jun 2024 13:48:58 +0800
Message-Id: <20240605054858.37560-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

commit c374839f9b4475173e536d1eaddff45cb481dbdf upstream.

MX35UF{1,2,4}GE4AD and MX35UF{1,2}GE4AC have been
merged into Linux kernel mainline through upstream commit.

For SPI-NAND flash support on Linux kernel LTS v5.4.y,
add SPI-NAND flash MX35UF{1,2,4}GE4AD and MX35UF{1,2}GE4AC in id tables.

Those five flashes have been validated on Xilinx zynq-picozed board and
Linux kernel LTS v5.4.y.

Cc: stable@vger.kernel.org # 5.4.y
Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/macronix.c | 45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index f18c6cfe8ff5..e1446798bfb3 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -132,6 +132,51 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+	SPINAND_INFO("MX35UF4GE4AD", 0xb7,
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF2GE4AD", 0xa6,
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF2GE4AC", 0xa2,
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF1GE4AD", 0x96,
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF1GE4AC", 0x92,
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
 };
 
 static int macronix_spinand_detect(struct spinand_device *spinand)
-- 
2.25.1


