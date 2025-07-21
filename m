Return-Path: <stable+bounces-163573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941FCB0C3A2
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90A23AC5A0
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00CB2C3254;
	Mon, 21 Jul 2025 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="RNSiaWvy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B66D2836AF
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098568; cv=none; b=IPep/U4334yQU9/kKTg92BY1BsTxly7sbOsEHzgypSrKU9M/sFrYlC+LQk19pfBLtf3lcuNI1o2fppOBsVHz349cUDhe8bMLFp40G0XG0yuk/bQ0rwFDZBHsK55AUwWvYL862xBj6WUTCLyJJhOK4unQb6eyTYz+y/sUFER2sow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098568; c=relaxed/simple;
	bh=k7RGTNlza4GhUK48V62W51N5ElOYan77CwwOLaNbUVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lEnO7H5EgtKhl4H+/p3o8Z6RADpHOs7kHGgFEl/OcoJN6yV9/wfXtl3EZiEELnRp4wTmpvTu9yvZwcoD6glu9Y4P3ZJhlUHs6oAMhYfEVZkhpUJ5oKj+RRqbgF80nz+NPukM5p7nJwnHNR515PAzP+nQqcqgNXUnz0owSImGeQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=RNSiaWvy; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b38fdac002bso568430a12.0
        for <stable@vger.kernel.org>; Mon, 21 Jul 2025 04:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1753098566; x=1753703366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1AsW3DIQB4IKAMtRvRaL86JI3EMeQz/pLeyho77Pbc=;
        b=RNSiaWvyHQbrtv4C7myj+nLm4sPuohO9RwCIQlOxcHGwmIuyCVV7uoKx1oCMTWxmkv
         Mus1D+/2vKOeRv5RfQ0QVmxUKLVMpvcdTPby14T051/E1ZhRzAvk6pC0wFCRPYY7mXcj
         SQiNPRI6zDHp6ErwE57lH4UepuI7qGKOJy7d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753098566; x=1753703366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1AsW3DIQB4IKAMtRvRaL86JI3EMeQz/pLeyho77Pbc=;
        b=gbaw0L4oYHiuoTza2+rbyHRGH1IqwccyBy6E4BMIGjkmHQ5K6lExycmpMEhZ0NTkx0
         FBxULHPT5xNxppr16w8kmqTMSCFn3zcShdJFh8wb16u3rfye7m4K27+z5RnBEzU+PVpY
         7qwkZfOgcumE6DDk9UhH2F/MF7D03W3jUpk5OUaYmjnPsMDDit8Fw0+zZuxfWMqOZmao
         wlutLyyCi29wlXHLKfNarg9T58KeAa6SD9o9cO+VuUQCrlH8elx7WmEmUBzeFliosR1k
         wE4Q+PvqTzqbzfgKC8ZD/aciIUKmPXgiyCp/5KMqBXneIDr9CKQg5nJRQeUezBO/qTT6
         BcoQ==
X-Gm-Message-State: AOJu0Yxb10+Q0qNnAT6PLQApeiUTCdn6XAYyI0LJTuhr7S4le8zkDGAg
	UxoEwyjYlYSEYbRJmw7HCffSeg6+vcHkMMYfbqX8dCPpezfanlx6kLjSgP6ZV3v9eMBYW9C4b9Y
	l76sGiXc=
X-Gm-Gg: ASbGncvWNw8s3uGKQCNii58gX6Fp2Fi9wdKktoVWRRwBDY8GVAIncOC09mHTlUBOu1l
	JJESeaf31/bkCrHXZKMoi5sAbdFiyXoGKbIuXJqkUqnsh0D/ZJYNlIGiJLWV+Iidi/UOdc11EeJ
	4BrEnWcX+dtIrAKJst06FulYBYIRyZH9fStCqMk5KDFg96rVfLq28FZ/r5ArpJxdRvgeIlwKviM
	kHNOCaw49UW+wy2ImFT95Jjhj7TszspzkslHI+O0A2ptp3NLObm9V1wVyZn7mwT5lVaBZxgFcWR
	Cm4sjDlWQXqIw6tfbUo1azXlKrZxY7N2JKniqu4XAPXWQoMHuDMcL9cjwTVnTZ8EcDzF7PNG6zX
	l6PSZra2k5n47EMoUAebCTnUXKoVBiZEM7g==
X-Google-Smtp-Source: AGHT+IHDBDVJVnuTK+0y5tr1cBR5G54j6nuOd/JVZtC3rRRvrxSkhaymSnRrbkpDoTkDSanEtVSGdg==
X-Received: by 2002:a05:6a20:431c:b0:235:6606:684a with SMTP id adf61e73a8af0-237d6120da0mr14955477637.5.1753098566026;
        Mon, 21 Jul 2025 04:49:26 -0700 (PDT)
Received: from shubhamPC.mvista.com ([182.74.28.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d5d8sm5572140b3a.112.2025.07.21.04.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 04:49:25 -0700 (PDT)
From: skulkarni@mvista.com
To: stable@vger.kernel.org
Cc: Dinghao Liu <dinghao.liu@zju.edu.cn>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Shubham Kulkarni <skulkarni@mvista.com>
Subject: [PATCH 5.4.y 1/3] power: supply: bq24190_charger: Fix runtime PM imbalance on error
Date: Mon, 21 Jul 2025 17:18:44 +0530
Message-Id: <20250721114846.1360952-2-skulkarni@mvista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250721114846.1360952-1-skulkarni@mvista.com>
References: <20250721114846.1360952-1-skulkarni@mvista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 1a37a039711610dd53ec03d8cab9e81875338225 ]

pm_runtime_get_sync() increments the runtime PM usage counter even
it returns an error code. Thus a pairing decrement is needed on
the error handling path to keep the counter balanced.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 47c29d692129 ("power: supply: bq24190: Fix use after free bug in bq24190_remove due to race condition")
Signed-off-by: Shubham Kulkarni <skulkarni@mvista.com>
---
 drivers/power/supply/bq24190_charger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index f912284b2e55..446b6f13dc8a 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -484,8 +484,10 @@ static ssize_t bq24190_sysfs_store(struct device *dev,
 		return ret;
 
 	ret = pm_runtime_get_sync(bdi->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(bdi->dev);
 		return ret;
+	}
 
 	ret = bq24190_write_mask(bdi, info->reg, info->mask, info->shift, v);
 	if (ret)
-- 
2.25.1


