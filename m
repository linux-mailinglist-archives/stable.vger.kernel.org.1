Return-Path: <stable+bounces-112265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7305CA281CF
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 03:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6CD164711
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 02:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEF534545;
	Wed,  5 Feb 2025 02:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4r2WuL2"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D970125A65D;
	Wed,  5 Feb 2025 02:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738722707; cv=none; b=Hc82UrMre/wRt39PH+7VLU9D+l6PWME9jEdUAlF/aIQgdh2mjNZiSVI5vz6dy3BnQ3M9hxKtfFFdxffRyWIk+qbLCIgP+ccwjFvpSJrpEct9eB2LG/HL7tjngnMqZ+YAW01VG8SGEqwvU1JlDQb0zlxjohA+qI7gnmPw9MvnM14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738722707; c=relaxed/simple;
	bh=JZJXpwS+xoCT6XiBnJVHG4CZf+80Tv6gEp9DVIKPYN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WDYJOPFRXZrlqtPZYiXywuuEMRcw07zRRLjmAgA+1xLP2vRrt9z+PCN+v7mipUgLOWVl/Y8iUgLfgNdFy1EpOa0N5xRGCeeAFiJVHDiQJ9WSrHAv8+eaayQ/mbUUIw9p+ptwoxbYTLy5aHpptJNJ1P97IK3Qf+ETs/n/C4xvCXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4r2WuL2; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d888fc8300so30213666d6.3;
        Tue, 04 Feb 2025 18:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738722704; x=1739327504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWJ3+/U5udNqpfJpR2/uzHJvQHNbsouaJRdWxi3SJj0=;
        b=W4r2WuL2z0aZK7SPX1T6hm9b+ih6pMDJAaG0hCW0UucUqOMG6ltDtmlBRfh6KcgBvf
         +X7yVOAxwNm35/TFU7flEjqERRL1hU1ISa74VcJRGO5VB6iu5aio1ctmPWEgaXgOX7zc
         fIF1YF0MRpLBm6T4sTtNHmjpdrXnfN+2AOPkD1e7WqCzPLB7aBrIzg/6qpI+QFdUZHGO
         hTA+QkyxRN0sTZr47IdRtydPmkRTNHWbmnkq+vllLmlZNPacNxI5Des6pgdmgk0fxZF1
         UJzkdqL7E9Pz+LEIH0q6suWeflKS31i7n85xvMXGMuSNBGXIPkxZWa0kxSkWHqCmowP6
         iAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738722704; x=1739327504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWJ3+/U5udNqpfJpR2/uzHJvQHNbsouaJRdWxi3SJj0=;
        b=QnnLRg6h50aECgCifmGhYUK3kJi/Vbtin+FQQzY9tTDfuNVQrdYe8WVKITRL25f0wF
         XnWidcLfkSWwOe0+yrGf64ZG5vgSkR3ItJzvEaKqF4CqiqeWJ6M+EkvIU6QVmqFxe7vx
         jc6xeDMQwe/+yO749Fip3govu9bIVQ/S7x0GtWwNQ/ZluAGN2QKJQ/yGmc8h2AE7iUeR
         PJa9LsmEB6U0xIN6DBH6bhY0lf4rAiq40SYfqLDCx/hEQqruYqpqDQWLb4G5JGs9FxP/
         nvkslauLKQGQzLnTS4bBZZkMAfu5H/ajlPC1d1qAljIAJJwyzQEi+8MmG5P7o80kzeNy
         knvw==
X-Forwarded-Encrypted: i=1; AJvYcCW1tgl7s0Q8vhdbdbcipCbDHhwNANIx6nRgJEfRqyLc+CDbv4hxu3iHat3pSyunQYxOJl4s960cXe3lMSY=@vger.kernel.org, AJvYcCWZULERMSO+FgHse+DzuDQqHEAJN9mL/uT1YjE1kKcFDY24zR+pZ6XEmEfCVsRZz4EYCozjN2Th@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3xHfCqii4RFkUTfzDboTqnIx8WXGS6YJVZTNw+nl8w3fuqqw6
	sKxxmkVMi0MkwKFrIKw4nf5lUUpfTcdTQyZDrPcAl/5vREB7SFABoQ5yQg==
X-Gm-Gg: ASbGnctuIeYRKGmcMpXTR3otQjRJLxc3l1ZhsCBXlRQyiIEu5VdoKuVopAB/F26fHGK
	yH39HY9OxTy+txM5d41uzNZsFiQLp/s0IS9cbeoq/jjZJMkUgzdCNmEy1e7sD0xWECdMJ10g4u5
	XMvxVW4HsXgKtJo4Y7tZrPYfbYA8zz9BwC8ykksnsB73PUi2wtj8cT6k/ktWgr5i7UWvJJJw9YK
	/hlsSX0q9m5cZN7BQ/k/Xni9s0B+Z5S9nPD1fxeVB5OkEgPoFgYpL8NCoPbPzQmATnBO8UV9GIU
	1rnB06tWcMfLuewH41+AUOrZ6hfmZgjAIpfN4A==
X-Google-Smtp-Source: AGHT+IF5cIIkftGw4WwRHKqTtt8+I6sIv48dAqRnLodKyaijhaIOt3OFLc/uyoQLFQAexUGZekPcbw==
X-Received: by 2002:ad4:5ec6:0:b0:6d4:b1e:5418 with SMTP id 6a1803df08f44-6e42fc6e390mr18830106d6.33.1738722704642;
        Tue, 04 Feb 2025 18:31:44 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e25492254esm68579306d6.90.2025.02.04.18.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 18:31:44 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: christophe.jaillet@wanadoo.fr
Cc: gmpy.liaowx@gmail.com,
	jiashengjiangcool@gmail.com,
	jirislaby@kernel.org,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	stable@vger.kernel.org,
	vigneshr@ti.com
Subject: [PATCH v3 1/2] mtd: Replace kcalloc() with devm_kcalloc()
Date: Wed,  5 Feb 2025 02:31:40 +0000
Message-Id: <20250205023141.26195-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f9a35a4f-b774-4480-910a-cdcf926df41b@wanadoo.fr>
References: <f9a35a4f-b774-4480-910a-cdcf926df41b@wanadoo.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kcalloc() with devm_kcalloc() to prevent memory leaks in case of
errors.

Fixes: 78c08247b9d3 ("mtd: Support kmsg dumper based on pstore/blk")
Cc: <stable@vger.kernel.org> # v5.10+
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v2 -> v3:

1. Replace kcalloc() with devm_kcalloc().
2. Remove kfree().
3. Remove checks.

v1 -> v2:

1. Remove redundant logging.
2. Add kfree() in the error-handling path.
---
 drivers/mtd/mtdpstore.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/mtdpstore.c b/drivers/mtd/mtdpstore.c
index 7ac8ac901306..2d004d41cf75 100644
--- a/drivers/mtd/mtdpstore.c
+++ b/drivers/mtd/mtdpstore.c
@@ -417,11 +417,11 @@ static void mtdpstore_notify_add(struct mtd_info *mtd)
 	}
 
 	longcnt = BITS_TO_LONGS(div_u64(mtd->size, info->kmsg_size));
-	cxt->rmmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
-	cxt->usedmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
+	cxt->rmmap = devm_kcalloc(&mtd->dev, longcnt, sizeof(long), GFP_KERNEL);
+	cxt->usedmap = devm_kcalloc(&mtd->dev, longcnt, sizeof(long), GFP_KERNEL);
 
 	longcnt = BITS_TO_LONGS(div_u64(mtd->size, mtd->erasesize));
-	cxt->badmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
+	cxt->badmap = devm_kcalloc(&mtd->dev, longcnt, sizeof(long), GFP_KERNEL);
 
 	/* just support dmesg right now */
 	cxt->dev.flags = PSTORE_FLAGS_DMESG;
@@ -527,9 +527,6 @@ static void mtdpstore_notify_remove(struct mtd_info *mtd)
 	mtdpstore_flush_removed(cxt);
 
 	unregister_pstore_device(&cxt->dev);
-	kfree(cxt->badmap);
-	kfree(cxt->usedmap);
-	kfree(cxt->rmmap);
 	cxt->mtd = NULL;
 	cxt->index = -1;
 }
-- 
2.25.1


