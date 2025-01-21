Return-Path: <stable+bounces-110045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E572EA1859A
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 20:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C371B3ABAFF
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D44519E7D3;
	Tue, 21 Jan 2025 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZGZeiPT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317B62E406
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737487515; cv=none; b=GW0Tbdx9fnuc+cY0I5tifYwoVi82qnffwIh88YW+g62aCmNGwdI8RqrA3x9C+g6OH1OSfgll7wJwdWYDNxLQHuXkxBW0y7dEHVuzHZg1C5PhtMrSY3ZEe1MT1jmaoG4k3v0qBd2S+kOFSz3p/TLBi4T4bW2RzZPy/mNsnaIi5WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737487515; c=relaxed/simple;
	bh=4kizRe2rgXySp8A1jCGinFKGSl5lHwSo1HF/xS0Okwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCnrLVsUygxEC2RfnU0eF5P1nZ9P0oET4prFV7iJwI+DdMwFOvn/zOdfnmX04jYXdwJieOYCvSv27IdI/oXF9u+vMpwVlggIsd8MG92PT+IavPXQndgKgUKdybMcFKV1Ay2uFsDuIPrRJSHAk9YPj98snGVsmVo7XPm15+h+tTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZGZeiPT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso5495846f8f.1
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 11:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737487512; x=1738092312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BQt4u1Y3GeikF9g8y57XTCh9Gzrta3TPR2hq1BQ24g=;
        b=WZGZeiPTyZWEsExlOeSPJPw262yqFkWalW5mgpA6zXbtkPI0jkHp6zGX/+XD1mJyy8
         Uun4W46NZ4Lrr/b9ckyOjATRWV8bwzOXGwBabZ+jtp//iUb4xdv+Z8G9y0UeLcyFOJcl
         kk0uUGSF8OZc2v58U4MYqHTYBt2kNmbisFF1orhs8eRokSz7EQhR3wSnZIlQ6tlJTSsk
         ja71Uj7FJUcmap7LqZYRWGfHF7e4rd1uGDV0LmWeXyNj0lM+AIGOk8ZHzr9GU3jBY5FH
         16d3yuB0sTjjxGnBaL4UrdWOG+nKjotqeHbhZXHQqtaKqBlkvYzNDtfiqAtaRdqxkOcy
         xgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737487512; x=1738092312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BQt4u1Y3GeikF9g8y57XTCh9Gzrta3TPR2hq1BQ24g=;
        b=hqu1LaWHU5Uuqksbpz72TSJdRzb+PhKdDpWSL7q2loyHT49/arcSS8rjOIbyHYeHlk
         6v4JqLuMvuziy30lU296KQIMUPSxy66udp2MRbThTnulFJFy67NTZ8I5hq1CVI+0wj/P
         TH3paPW7T6R9TVV7m+WH0ecylrzbG1U+vddo3/OTAqiuHchANvxp1Hs1qDeifOj3GRvF
         geuqAMMU1N9jsmrSTn1TVj7sVOG7uicCQcQOgelX3xFcImLd/0FHxjITWXSpBd3wL0/u
         20FDL/pdq8f49QcdwmIqDw/9gsRXB3+oou0BbFK14W5iv3HELvpAut/ga6NeeP6lEc6Q
         knvg==
X-Forwarded-Encrypted: i=1; AJvYcCX5npLiqJiDicG4t9XQZJoCqRlrv+15mmFF/7ISuXRGysSq6+Sixtkn1gH0MriwGBj56o/9BKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YztZF2aCo0PFYAw83A66V6w2OuStHe7RPHR1AdTjpnHjx5+jNu6
	2HPySZvnpk50TS5NyZ5zKGpc+sgdmXJrBlCe4aXFAjdcrV4XVwyI
X-Gm-Gg: ASbGncupOhCwB2DPKhfXuGMYwg4YSr/59QDe1DhPpzL4PgkzE2brv/kGS7ODQcwxssl
	MnOmjDHtEJXFpnOTvkKwAIEvckImLEEav/VADmTFfy5Zjetouo1kPjzctkl/nwD2xRhvWhqeg0f
	RIh5hSUHJZ2sn5mcr+35K6yw0DYbm3mrYd8aCS337ddPclCtnjKgRgJcmCdBZMVDWn9TpQbgBNM
	feHhA8ODWoG246mgBBZCi94rwufscIv1W0ck/Q0Lx2Xx8zmr+2nv/wzkGkrD9gqX9CQxa42OcQS
	C4Hyyd79+VMXAxpl1w==
X-Google-Smtp-Source: AGHT+IEOIZKjDDOPbQOJbj1c+DJa7lzVBfjBjqW9nQImZi8C/6JrWCmovg4qdFn/MqPYgANk02bI/A==
X-Received: by 2002:a05:6000:178e:b0:388:c61d:43e4 with SMTP id ffacd0b85a97d-38bf57b9d47mr17985637f8f.45.1737487512321;
        Tue, 21 Jan 2025 11:25:12 -0800 (PST)
Received: from localhost.localdomain ([109.175.243.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf327ded8sm14004086f8f.89.2025.01.21.11.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 11:25:12 -0800 (PST)
From: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
To: 
Cc: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	yan kang <kangyan91@outlook.com>,
	yue sun <samsun1006219@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] HID: corsair-void: Add missing delayed work cancel for headset status
Date: Tue, 21 Jan 2025 19:24:41 +0000
Message-ID: <20250121192444.31127-3-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121192444.31127-2-stuart.a.hayhurst@gmail.com>
References: <20250121192444.31127-2-stuart.a.hayhurst@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cancel_delayed_work_sync() call was missed, causing a use-after-free
in corsair_void_remove().

Reported-by: yan kang <kangyan91@outlook.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/all/SY8P300MB042106286A2536707D2FB736A1E42@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM/
Closes: https://lore.kernel.org/all/SY8P300MB0421872E0AE934C9616FA61EA1E42@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM/

Fixes: 6ea2a6fd3872 ("HID: corsair-void: Add Corsair Void headset family driver")
Cc: stable@vger.kernel.org
Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
---
 drivers/hid/hid-corsair-void.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-corsair-void.c b/drivers/hid/hid-corsair-void.c
index 6ece56b850fc..bd8f3d849b58 100644
--- a/drivers/hid/hid-corsair-void.c
+++ b/drivers/hid/hid-corsair-void.c
@@ -726,6 +726,7 @@ static void corsair_void_remove(struct hid_device *hid_dev)
 	if (drvdata->battery)
 		power_supply_unregister(drvdata->battery);
 
+	cancel_delayed_work_sync(&drvdata->delayed_status_work);
 	cancel_delayed_work_sync(&drvdata->delayed_firmware_work);
 	sysfs_remove_group(&hid_dev->dev.kobj, &corsair_void_attr_group);
 }
-- 
2.47.1


