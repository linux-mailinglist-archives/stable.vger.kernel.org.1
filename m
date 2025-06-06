Return-Path: <stable+bounces-151726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77DAAD075F
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 19:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCA23A5A52
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 17:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5772E28A1FD;
	Fri,  6 Jun 2025 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RSlal6Kt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171428A701
	for <stable@vger.kernel.org>; Fri,  6 Jun 2025 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749230533; cv=none; b=lPfe7kHGIkHszY/cEH9r45B6t+R6HmxFvgFiSZaj+HBomyBKWE3v5dtSvicCQuoZ9QJDOs2Ryx0SRBCN3MSEJGqcqUPAQohnxzNat0F/RsMetYRHU01rJhV4K2MUuTE8hnnE2PB0dY4CnJNGKdV9KET66JFOqKMWkNeQroJh9e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749230533; c=relaxed/simple;
	bh=uUFSrRE0cQAGVz5Rn2g6+62Og8KIl8bJUMCDdd1Wz6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lwvjPwloZKbTiD+mvEt9j6gG2z4HbI6tCh6RQdCWl230C+6S94EDKcX9r9NNw90drKKys/60PEaLcHXBaPJhcLGnFUL0Ex6Tg+DgMwl2zbxJq2nwk1LI/0Rnf5tUHI9UQ/cdWzsOBvoNKdLbwoycyXhN13dVwAtFJp9oLHH+1KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RSlal6Kt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-450cf214200so21108775e9.1
        for <stable@vger.kernel.org>; Fri, 06 Jun 2025 10:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749230528; x=1749835328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Puf9YuVvvlq6XzUD6qmpBkJMcn/scDvWfzB5Ch/1zZE=;
        b=RSlal6Ktj+tXoPe6WZgtAMuOROhqF2Ukd6dW2vfbX9PmiNu2NpT+dL7qw+BoqsjblB
         GyBoEdCL6FanQHmLEq6p51M52LLo99JUmon9RuCj3LuXZcooc2wY6vrk5pXfB0Og8tq8
         kudjZuuHdSfCvXnUAqEn7UIikEVNPXKZ2Dv9NAnQC7eVupwX8kvrjN5FFaPFUy2Fkh4/
         T3tMhkdDnAad1yrBUds0T5WpWFLmGRSwAvPJMrVU4CN3/M7mwID+j9U/oPZJy34vboab
         yuck120i4Y53gngjrgwiO4GLtv1OjVKmhmrL/GCPHo5rh3wyzSvifbH0nW/GGL1L15WM
         pcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749230528; x=1749835328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Puf9YuVvvlq6XzUD6qmpBkJMcn/scDvWfzB5Ch/1zZE=;
        b=wYs6O0F0ntjiVyLPnqrUnpDc5bK4PsHshhfmhQ7RBSYbxthkgC8nXYkm8ZwCk0v4BC
         3uiJMNLYWQ9kiINJmqZ+jRc0lJF7B8j5DwdfA1fda2QR+yThz3CDt8I0viGBIjAqQcNV
         A84XTXST1umECIoJklaTl0WdoRXvQfUVsPZ9ysnpwEJFnbXQ1GrZmO2vK6bFLgEWh2c9
         Kv+HxKjmYQpTRxS6MVvlwMxj4FhhaW2rblpzz4ntdi1sjqVfV4q2nvLZitO7fL9gFWCr
         e5PBiiwYLAqxegrHAuLKNw/qY6m8LWITIB4Wz6jR11ngHY/8DLyrg1GIEQoz8M32fC9I
         qfFg==
X-Forwarded-Encrypted: i=1; AJvYcCVCBNZSj/+OrOy0vmPwz4vP1puFLsbgffQWQbLtvEe5pLKVhRf5uaD3ZIdavveZYxGYxSoT8os=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNSUJ1nhp01C7Xn6JI77TRBnVLlX9o7uXlhbwsvPdMv+xnDlTW
	hSMOvIBkUqjyKHaVpwaO77o+aWWbpZG98ShA9bJqV1eAzbA1775jz4TixbJflN2Ezd/AFkNvBlg
	HqqmD
X-Gm-Gg: ASbGncsf4GUw5cErba8J3eyIZYa7YAgcoGOLrFxReX8CuscOLKGUoiOJ6pZQWgOSz9C
	tdt2HMIZGTtfgG/jciHHN2pcHEfoRNbJfkCFkHmGsop1I5nx1F7/KVZWXjhy9uS+yUsrnwEfmfT
	AlufOPvtZyRFSWvT0YLlx0LkdFBlQ9ZMuBGmipyTJn/yzsqisFDJOHhbj+3nszi7ihOhHNpKCI/
	WczNL09dJ90gc8ACllghqU8usvwynGX6/uOcCGAt/8hevKO7mVXzvb/wBG15+vgXjBhzl0fJSnq
	GFcLZCIJ5qnFnlHAFij8uIr7YE4o+pHFUVHSyI+KleHBAPu0MZcMX14EWEHVxPQwiERpvwi6AOk
	LQ4pkoFkJTP9MOb5d2v6Vc9NOkmKO
X-Google-Smtp-Source: AGHT+IH+EyoVWlBPxLeIQlSu8+Ji5n4gnUydnZTCRUtzSLgmqjbuJNHZpJFzPpqiNyHcbPf5jCLNRA==
X-Received: by 2002:a05:600c:6210:b0:44a:b7a3:b95f with SMTP id 5b1f17b1804b1-452014d99b7mr42635915e9.25.1749230528050;
        Fri, 06 Jun 2025 10:22:08 -0700 (PDT)
Received: from localhost (p200300f65f13c80400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f13:c804::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a532452d7esm2421640f8f.85.2025.06.06.10.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 10:22:07 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	stable@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 6.15.y] pinctrl: mediatek: eint: Fix invalid pointer dereference for v1 platforms
Date: Fri,  6 Jun 2025 19:21:53 +0200
Message-ID: <20250606172154.3498270-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6457; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=SM6WQUFPSZc/QlvOlqlIc7iqv62pdecBlSbSnIxBLTc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoQyOyTj1t9ozloE/2ak6GAZMFcvz0RQuNlkLgG 7eMGbBtaVmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaEMjsgAKCRCPgPtYfRL+ Tr/+B/9jAqMfRTQ1V0MjpZ4fNzBSEFQkRXXe/Ey+PJDzPQKSepHsko3H77BkzH053WjIpzof4WE po+luIuIfLjKiP9m+58icLMVIczAMj8+KIfh/D7Ru0K18Nkqnq5cVjWCX1r7wbp7clyH1aNUDLX cRUi2UjKHiQA0gOswiujinLS72mu9fC6SuAjLTVPYt0/ha4Pr3eJwNJVZzlRQhEmo22aM80aOOc lT3SL7/ILFRH3YnSQeZQOGINF6MMyt5iu7OXrJDEsf/2+3r5/s3Y7fbd00UPmzVXYGxxDbIg5A+ jMZYwGzuavt3Vb/svDjy3LXxk6rtm5vDPrkyVac159X2l9WK
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

commit 1c9977b263475373b31bbf86af94a5c9ae2be42c upstream.

Commit 3ef9f710efcb ("pinctrl: mediatek: Add EINT support for multiple
addresses") introduced an access to the 'soc' field of struct
mtk_pinctrl in mtk_eint_do_init() and for that an include of
pinctrl-mtk-common-v2.h.

However, pinctrl drivers relying on the v1 common driver include
pinctrl-mtk-common.h instead, which provides another definition of
struct mtk_pinctrl that does not contain an 'soc' field.

Since mtk_eint_do_init() can be called both by v1 and v2 drivers, it
will now try to dereference an invalid pointer when called on v1
platforms. This has been observed on Genio 350 EVK (MT8365), which
crashes very early in boot (the kernel trace can only be seen with
earlycon).

In order to fix this, since 'struct mtk_pinctrl' was only needed to get
a 'struct mtk_eint_pin', make 'struct mtk_eint_pin' a parameter
of mtk_eint_do_init() so that callers need to supply it, removing
mtk_eint_do_init()'s dependency on any particular 'struct mtk_pinctrl'.

Fixes: 3ef9f710efcb ("pinctrl: mediatek: Add EINT support for multiple addresses")
Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Link: https://lore.kernel.org/20250520-genio-350-eint-null-ptr-deref-fix-v2-1-6a3ca966a7ba@collabora.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
[ukleinek: backport to 6.15.y]
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

would be great to have this in 6.15. Further backporting isn't needed as
3ef9f710efcb == v6.15-rc1~106^2 isn't in 6.14.

This patch fixes booting on mt8365-evk (and probably a few more machines
based on mediatek SoCs.

There was an easy conflict with
86dee87f4b2e6ac119b03810e58723d0b27787a4 in
drivers/pinctrl/mediatek/mtk-eint.c.

Thanks
Uwe

 drivers/pinctrl/mediatek/mtk-eint.c           | 26 ++++++++-----------
 drivers/pinctrl/mediatek/mtk-eint.h           |  5 ++--
 .../pinctrl/mediatek/pinctrl-mtk-common-v2.c  |  2 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |  2 +-
 4 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/pinctrl/mediatek/mtk-eint.c b/drivers/pinctrl/mediatek/mtk-eint.c
index b4eb2beab691..c516c34aaaf6 100644
--- a/drivers/pinctrl/mediatek/mtk-eint.c
+++ b/drivers/pinctrl/mediatek/mtk-eint.c
@@ -22,7 +22,6 @@
 #include <linux/platform_device.h>
 
 #include "mtk-eint.h"
-#include "pinctrl-mtk-common-v2.h"
 
 #define MTK_EINT_EDGE_SENSITIVE           0
 #define MTK_EINT_LEVEL_SENSITIVE          1
@@ -505,10 +504,9 @@ int mtk_eint_find_irq(struct mtk_eint *eint, unsigned long eint_n)
 }
 EXPORT_SYMBOL_GPL(mtk_eint_find_irq);
 
-int mtk_eint_do_init(struct mtk_eint *eint)
+int mtk_eint_do_init(struct mtk_eint *eint, struct mtk_eint_pin *eint_pin)
 {
 	unsigned int size, i, port, inst = 0;
-	struct mtk_pinctrl *hw = (struct mtk_pinctrl *)eint->pctl;
 
 	/* If clients don't assign a specific regs, let's use generic one */
 	if (!eint->regs)
@@ -519,7 +517,15 @@ int mtk_eint_do_init(struct mtk_eint *eint)
 	if (!eint->base_pin_num)
 		return -ENOMEM;
 
-	if (eint->nbase == 1) {
+	if (eint_pin) {
+		eint->pins = eint_pin;
+		for (i = 0; i < eint->hw->ap_num; i++) {
+			inst = eint->pins[i].instance;
+			if (inst >= eint->nbase)
+				continue;
+			eint->base_pin_num[inst]++;
+		}
+	} else {
 		size = eint->hw->ap_num * sizeof(struct mtk_eint_pin);
 		eint->pins = devm_kmalloc(eint->dev, size, GFP_KERNEL);
 		if (!eint->pins)
@@ -533,16 +539,6 @@ int mtk_eint_do_init(struct mtk_eint *eint)
 		}
 	}
 
-	if (hw && hw->soc && hw->soc->eint_pin) {
-		eint->pins = hw->soc->eint_pin;
-		for (i = 0; i < eint->hw->ap_num; i++) {
-			inst = eint->pins[i].instance;
-			if (inst >= eint->nbase)
-				continue;
-			eint->base_pin_num[inst]++;
-		}
-	}
-
 	eint->pin_list = devm_kmalloc(eint->dev, eint->nbase * sizeof(u16 *), GFP_KERNEL);
 	if (!eint->pin_list)
 		goto err_pin_list;
@@ -610,7 +606,7 @@ int mtk_eint_do_init(struct mtk_eint *eint)
 err_wake_mask:
 	devm_kfree(eint->dev, eint->pin_list);
 err_pin_list:
-	if (eint->nbase == 1)
+	if (!eint_pin)
 		devm_kfree(eint->dev, eint->pins);
 err_pins:
 	devm_kfree(eint->dev, eint->base_pin_num);
diff --git a/drivers/pinctrl/mediatek/mtk-eint.h b/drivers/pinctrl/mediatek/mtk-eint.h
index f7f58cca0d5e..23801d4b636f 100644
--- a/drivers/pinctrl/mediatek/mtk-eint.h
+++ b/drivers/pinctrl/mediatek/mtk-eint.h
@@ -88,7 +88,7 @@ struct mtk_eint {
 };
 
 #if IS_ENABLED(CONFIG_EINT_MTK)
-int mtk_eint_do_init(struct mtk_eint *eint);
+int mtk_eint_do_init(struct mtk_eint *eint, struct mtk_eint_pin *eint_pin);
 int mtk_eint_do_suspend(struct mtk_eint *eint);
 int mtk_eint_do_resume(struct mtk_eint *eint);
 int mtk_eint_set_debounce(struct mtk_eint *eint, unsigned long eint_n,
@@ -96,7 +96,8 @@ int mtk_eint_set_debounce(struct mtk_eint *eint, unsigned long eint_n,
 int mtk_eint_find_irq(struct mtk_eint *eint, unsigned long eint_n);
 
 #else
-static inline int mtk_eint_do_init(struct mtk_eint *eint)
+static inline int mtk_eint_do_init(struct mtk_eint *eint,
+				   struct mtk_eint_pin *eint_pin)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index d1556b75d9ef..ba13558bfcd7 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -416,7 +416,7 @@ int mtk_build_eint(struct mtk_pinctrl *hw, struct platform_device *pdev)
 	hw->eint->pctl = hw;
 	hw->eint->gpio_xlate = &mtk_eint_xt;
 
-	ret = mtk_eint_do_init(hw->eint);
+	ret = mtk_eint_do_init(hw->eint, hw->soc->eint_pin);
 	if (ret)
 		goto err_free_eint;
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 8596f3541265..7289648eaa02 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -1039,7 +1039,7 @@ static int mtk_eint_init(struct mtk_pinctrl *pctl, struct platform_device *pdev)
 	pctl->eint->pctl = pctl;
 	pctl->eint->gpio_xlate = &mtk_eint_xt;
 
-	return mtk_eint_do_init(pctl->eint);
+	return mtk_eint_do_init(pctl->eint, NULL);
 }
 
 /* This is used as a common probe function */
-- 
2.47.2


