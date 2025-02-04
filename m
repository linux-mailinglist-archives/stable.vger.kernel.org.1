Return-Path: <stable+bounces-112109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3474BA26A0B
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 03:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D30E165A58
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 02:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06DF78F5B;
	Tue,  4 Feb 2025 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCGDDInF"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A4B200CB;
	Tue,  4 Feb 2025 02:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738636409; cv=none; b=iVlefOWfI8Wv7O6BDhd0idg8gWoIhpizICH8kZlxsIAHtLv6oILOYIan8+eiJQXnuXDQB5JKVYs5PhT7nehOXCPnd2sO94m6SCcAbm8rgSPWovM11I0mPQEPpdcMPQWD257HKSf7qLIcwueJQbkOj/Vea5/drk9re1LuKCPh89k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738636409; c=relaxed/simple;
	bh=ml73UtkO8cs4Pij7jB00Z18O7UxmGQTOthJwQKKKSSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I8Y1AJL+j0857GU9huLa6RyhP/x/5LUinwa2lkKbrIzOysJhkrz+A7QexixU83cYaf3dA76qbRZVGdVW+qxSnLBaKGP0N+4PjH8hwsaFGLMPZt2bB2qWsrjAWIZ6LQNUOjBEgoPGPndpQxDm28LEjXpAaIRAFZSwCnjfcv+BOG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCGDDInF; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6edb82f85so755017685a.3;
        Mon, 03 Feb 2025 18:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738636407; x=1739241207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cH7H0PH3nCsAonZFaIiiXIpDDBfA5/nUJG90X2bZFn8=;
        b=iCGDDInF5Y6lKbu4e+FW6Kkwr6CXyKB+tHmo5r6/E4vW5opeYHY8V6pc7Ga9UKCcCU
         hlHJnOMmnH/lAOUDGKj0FTMOwHEjAA5Ll8UBDkpNAPxPQb8sXxHY70lYVAdqL488HVy5
         DE9kdN1WAXH5zRp34E4cLRnIEaKyfELMuUHBSjDPTSYC/xH5Um6VfG2yhnk30h+op3x6
         LObZU989JSlmqU9n8op4tzaOQp+HdSuJncj98NZkXkUpwGMlpZnifof6HjknS5Dn2R0n
         th6AhXebqR01UBPNleWwM3j5Gcbl8inesiwa97LtQRqh1geqM1Ypk3QhwR+b63vldktQ
         kJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738636407; x=1739241207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cH7H0PH3nCsAonZFaIiiXIpDDBfA5/nUJG90X2bZFn8=;
        b=hbWupxjmk4t+ckOa4xNxnbCdHUcelXlSTTBsPqwiDpYRiRllYpb5hE5L8n86aw9cxS
         2sLxV+x9XiMbTuOIsFk3XwDDgpROV1kxYxsK3GaI5O2GKz7GqLZHn4syowCiwpWLZB/F
         tPHAHRtEf8W8LVO2vkBvx/jytL/SANXFncYyXtyP1G94V1IQhVjoTHwRPcnynDddjuZQ
         TjE3B0yAYKfS1h/sM7aFdcwA9b6Ul5htfA9j98OTDySRH1sz5g0jy9YTSHNjZ/T9kRmc
         RyBsJ2020c/EpxdmMVLvomHL/A3uW87e7738IF6aUIovxSPnTtgQC8H3Lu/o/RJrz+go
         C0+w==
X-Forwarded-Encrypted: i=1; AJvYcCXKv0TaSP4adDpBUWSu1vYqvykoIMeAze8sdLGr5fU3cLypmcOIsM4WVKYkE9GqGVacEwuT/JFGoxoor2A=@vger.kernel.org, AJvYcCXkBbEoTDGecrywoSRXwxxbq4jkbREWrpcmQ3NyECKMbP4HQIqXe9YIp9BGNKiQKt2dL9yud26R@vger.kernel.org
X-Gm-Message-State: AOJu0YxP6aKdvjFMiZoZvtxQsCKTLwpUA6U/oFJQa93YAwjURQ3U7sk/
	gIo04HOzTHTdw8vgVmS+ZjR3oAyBq6Ut8SCI2YeqPvrE04ZTS2uM
X-Gm-Gg: ASbGncuoMcsmfyC+ZcR4PRXypGRlGw7I2BoiaMSsUNQS0uMo3kWX04U8BHlPRAjBxen
	5mLFCjDUO7tZj8nO5MxLVZlM9EWpZIeiPaeHrdUIFNXAOPYgUOZ0uCTI3SOqFJyPZRI8b2fSD4B
	NH34xpsUzu/XxKg+YRy0KfOcmo5UibqhDXoYPTYN2qhfVkPuM0fcmrSlfgorOUC9zUHj52tSAdb
	OUVEkxurM62B3LPC98mUo8UMNz6BTqi6XTYfHBov+Qek5NtbW3rkI0ISW/yswANlN1jK9YxgKhr
	1dhwYPDsJf/prYregsSZECsSksjUXlbMZ0PpvA==
X-Google-Smtp-Source: AGHT+IFkU0QnpYEf727d4vGDJg7962NUWX2M0s4YoN/ETYbpRFdzQ54W40zKw1w4f5qr3g91DhlqwA==
X-Received: by 2002:a05:620a:8394:b0:7b6:ce6e:229c with SMTP id af79cd13be357-7bffcd9b5ecmr4006496785a.55.1738636406808;
        Mon, 03 Feb 2025 18:33:26 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a90ccd0sm588688485a.99.2025.02.03.18.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 18:33:26 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: christophe.jaillet@wanadoo.fr
Cc: gmpy.liaowx@gmail.com,
	jiashengjiangcool@gmail.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	stable@vger.kernel.org
Subject: [PATCH v2] mtd: Add check and kfree() for kcalloc()
Date: Tue,  4 Feb 2025 02:33:23 +0000
Message-Id: <20250204023323.14213-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <30ad77af-4a7b-4a15-9c0b-b0c70d9e1643@wanadoo.fr>
References: <30ad77af-4a7b-4a15-9c0b-b0c70d9e1643@wanadoo.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a check for kcalloc() to ensure successful allocation.
Moreover, add kfree() in the error-handling path to prevent memory leaks.

Fixes: 78c08247b9d3 ("mtd: Support kmsg dumper based on pstore/blk")
Cc: <stable@vger.kernel.org> # v5.10+
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v1 -> v2:

1. Remove redundant logging.
2. Add kfree() in the error-handling path.
---
 drivers/mtd/mtdpstore.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdpstore.c b/drivers/mtd/mtdpstore.c
index 7ac8ac901306..2d8e330dd215 100644
--- a/drivers/mtd/mtdpstore.c
+++ b/drivers/mtd/mtdpstore.c
@@ -418,10 +418,17 @@ static void mtdpstore_notify_add(struct mtd_info *mtd)
 
 	longcnt = BITS_TO_LONGS(div_u64(mtd->size, info->kmsg_size));
 	cxt->rmmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
+	if (!cxt->rmmap)
+		goto end;
+
 	cxt->usedmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
+	if (!cxt->usedmap)
+		goto free_rmmap;
 
 	longcnt = BITS_TO_LONGS(div_u64(mtd->size, mtd->erasesize));
 	cxt->badmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
+	if (!cxt->badmap)
+		goto free_usedmap;
 
 	/* just support dmesg right now */
 	cxt->dev.flags = PSTORE_FLAGS_DMESG;
@@ -435,10 +442,20 @@ static void mtdpstore_notify_add(struct mtd_info *mtd)
 	if (ret) {
 		dev_err(&mtd->dev, "mtd%d register to psblk failed\n",
 				mtd->index);
-		return;
+		goto free_badmap;
 	}
 	cxt->mtd = mtd;
 	dev_info(&mtd->dev, "Attached to MTD device %d\n", mtd->index);
+	goto end;
+
+free_badmap:
+	kfree(cxt->badmap);
+free_usedmap:
+	kfree(cxt->usedmap);
+free_rmmap:
+	kfree(cxt->rmmap);
+end:
+	return;
 }
 
 static int mtdpstore_flush_removed_do(struct mtdpstore_context *cxt,
-- 
2.25.1


