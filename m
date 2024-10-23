Return-Path: <stable+bounces-87951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44FE9AD667
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 23:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B2D1C20F26
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 21:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489FD1E7C16;
	Wed, 23 Oct 2024 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9lu8s+o"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371931494B3
	for <stable@vger.kernel.org>; Wed, 23 Oct 2024 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717998; cv=none; b=cNBfMQNJV6CXHu+Gh7szouISSf+O2lehHoFR6PKRNLvZKwLOZ+IX2+iDaRyJTnaaxHLC41I7i3vwP8OJAj0GfbvHoKAflUqNzTv+DMajALUW83VuKun9+2q79xKm6Im05qxlYjOl8i8kbtQaruY0esnmcsiPQrSBbIdXU+ne5/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717998; c=relaxed/simple;
	bh=FKOS4VcTOcfEkdQvbSh/sjqUBzZDslh94oUXLeqfIr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GDndRzkfWZBwMxssGZsh/bJL2muEFcH+Ohe9vvZopUceayyPB2vmvgYQ3eHojd+NcQtWS5xttA6S90Y9F3SfmGb1VxviqFMRCQu15nNuSLdbdeqeCI9NEXIsgM8DEMrGpulFAlFfQGbK/3vC6hGlwlAw2Oo8FTHzhl2yA+DA0m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9lu8s+o; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-7b154f71885so17116585a.0
        for <stable@vger.kernel.org>; Wed, 23 Oct 2024 14:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729717995; x=1730322795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MCdIPw1scUzZ/qF39vP4SWy2EyXqMACy7FsQ1MZaVb4=;
        b=T9lu8s+oppHp6Fz+j5PWIBHw3gW5GsM0DsAc26HyrEWabnTKGqHTlK8MzEvuvqh7t8
         r/2ZU7OZmtIakyJcdcU9ITb4Jil59T8JlfukLAHII0Q3n2PcM8lITICjiRG+os72MUbS
         uKYZpT9LB/F5MQP8PoTb//cLVSHWdhpDFjam9OUQ5qCZ5lrzT13NvDRDbl8DIzDMsU/r
         vZhEGwBfrZjANjTsTEV89/5tZKoPA0naiW+koBA6kXS3AO6Cp952HhsVBskTY9+KwpQt
         8N7BcN6yO/f2ogJLApLuBQXnKPH2WdshM3ObsGEcIkcHCxitB+aY5RCKDBNqDrKZRr1X
         pNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717995; x=1730322795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCdIPw1scUzZ/qF39vP4SWy2EyXqMACy7FsQ1MZaVb4=;
        b=lvzGkfPg6ZbM/qVYLLA9FIvGoWapFzySXljdWHFUsA7q4T/5fSg0A03KIimZ/ky+Wt
         lzPHukLuWJEzMkQKCJr6K+y7v+2KcFdfGBx6Zi5cYLtcz9jEe7hQ4/AZ1QQgJePQ+0cZ
         iAUqdMg24NZ2QI96BouoVtJcL5RrIZephNpDqRKVGgvBmVwmb7ZZVHyewk9+jl7ROKvE
         txy3qfWuj7D6henBgzF0SvBxlDEF5cKFB3ZoeBC80Ooeyu5wAyMEhYKJMEtc+EM9rXkl
         dnMjx6rpSEdJ+L4u9j+brSsZVijgZRFLs0ukbckxkVC09+0eF3QJiPdiQ5jjgzaRC+Fn
         B2Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXnNBpmqSJ8QV+SoV6OZ/5GD7iIiqrtDLjwYGaTWcnq3FM1W/LOtdmrwN2WA3aNEC0OB5ufQtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIPjadX3C2uugx7Nrs3eyWSCCqsTdXoBEpemsS8LCxmnJ9U0/S
	TWtak9JyxntEuaxgzTWlwJ9LxejechHznud88zkLpsFiTE4noxU2
X-Google-Smtp-Source: AGHT+IG6SHQd2UbknuiJO0zSgtIat6OwS2EA3NcHpw+bDSwcHDqrbswyTjGufQI99cN8Tay7klbeKA==
X-Received: by 2002:a05:620a:1926:b0:7b1:4a48:56bb with SMTP id af79cd13be357-7b17e5bc5a1mr443735485a.56.1729717995075;
        Wed, 23 Oct 2024 14:13:15 -0700 (PDT)
Received: from localhost.localdomain (mobile-130-126-255-54.near.illinois.edu. [130.126.255.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a037fbsm421212785a.60.2024.10.23.14.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 14:13:13 -0700 (PDT)
From: Gax-c <zichenxie0106@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	arnd@arndb.de,
	dinghao.liu@zju.edu.cn
Cc: linux-mtd@lists.infradead.org,
	zzjas98@gmail.com,
	chenyuan0y@gmail.com,
	Zichen Xie <zichenxie0106@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] mtd: diskonchip: Cast an operand to prevent potential overflow
Date: Wed, 23 Oct 2024 16:13:10 -0500
Message-Id: <20241023211310.13015-1-zichenxie0106@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zichen Xie <zichenxie0106@gmail.com>

There may be a potential integer overflow issue in inftl_partscan().
parts[0].size is defined as "uint64_t"  while mtd->erasesize and
ip->firstUnit are defined as 32-bit unsigned integer. The result of
the calculation will be limited to 32 bits without correct casting.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
Cc: stable@vger.kernel.org
---
v2: Correct "Fixes" tag.
v3: Shorten subject and adjust commit log wrapping.
v4: Add Cc tag.
---
 drivers/mtd/nand/raw/diskonchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 8db7fc424571..70d6c2250f32 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -1098,7 +1098,7 @@ static inline int __init inftl_partscan(struct mtd_info *mtd, struct mtd_partiti
 		    (i == 0) && (ip->firstUnit > 0)) {
 			parts[0].name = " DiskOnChip IPL / Media Header partition";
 			parts[0].offset = 0;
-			parts[0].size = mtd->erasesize * ip->firstUnit;
+			parts[0].size = (uint64_t)mtd->erasesize * ip->firstUnit;
 			numparts = 1;
 		}
 
-- 
2.34.1


