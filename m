Return-Path: <stable+bounces-50388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1089063A6
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 07:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44AB6284B73
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 05:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA97A136987;
	Thu, 13 Jun 2024 05:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AWNQENho"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF08913666E
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718258169; cv=none; b=SPeUB3C3JylIZo+9QT8sJwtpc54m3n62bBlT8/SA5JIjwND7ZkwyneiC7DI78/cojGsWEr+pqldftcCl9p9gpnFZrNIbQKaODYKMQ0lmlAsHMeqoKDZ95TlpbY2S85EHC7ARk12ITYQgUSxRVac7jmgeOJ5VLYSic5InnqnsrzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718258169; c=relaxed/simple;
	bh=HSX29U5jR9VKCF7owtDTtc3p6SLha6nSDVs8Hos9lkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNUFKrTMqDMbwH9RZXVLxnkoTRWqSmUX2tKEjpwd4XnLpk0xBECv+nOC0irI2Rp3SPE+RuchyYIuHDjfj8SBWnE3cVQn+jsMtDjEmT5mc1rUKFCNzxmsNe7d51HTTvBY92/dby+RzCGJ32hQxLCBzuY/9fGwWBQdo95E/MopEks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AWNQENho; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57ca8e45a1bso539546a12.0
        for <stable@vger.kernel.org>; Wed, 12 Jun 2024 22:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718258164; x=1718862964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r679RW9VkDW7K5Pb4kvJsm4Wnxo18CrL3Sf2um0Gres=;
        b=AWNQENhoWezzfPGDCL6DNPvz5MFEPsml7cv9XhY0dfqf/YCCq6UdMULWTr7BdMarkA
         A5mgDJKJgDdnXjiY4fovBSNWQXVXOKHlmpT+pb+qYMUt4vTUsjd9BSscAk6FOcJJFi5r
         r3tfEUyD8trCG+IyOSZGUqYR7DskQSYV8VOWc5eXN1u9Zt6G096fHQmHaznOIrZGJaRU
         l+/8rFHdg4HBaSPzoq0y3czv1WkULBq9riNrpq6C7fHOnvv8jasACDbh5dxDuxKNtxwK
         1A1yuwJVrnF/+BclfdTAaEtjGBco9bqMP6m5i7WdxOy+aetVSIY4BfHqjmbszthBCsfk
         PhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718258164; x=1718862964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r679RW9VkDW7K5Pb4kvJsm4Wnxo18CrL3Sf2um0Gres=;
        b=MOr9DpBLpDBpiGGz3osDtETt+DV/4eOhiSc4yfE48fIB7WBECvFn8kg+xZ1wHyw+/x
         othnCZRqnGuxMOsfxVz+3yEMhHHe2DrbgbEXfGWyY5/l7jGRP0udOjynqk1Ur1vAEgy5
         g03IbcfL9k55HTmdE335tDimovN8eRGljYIC4KiupJqNkypScYAFhnP7VE/GhT85UBn6
         1mV72whkzTxA9abNu0hRPwl998pPSXOjy0rOFwKicbUUS/z9rF7Ke1dTadpmMc6FRoQj
         HUD+SMfgJe5Eru1tp6n5lBblh7GsxfE+ijzvTuRA5ANnjhUVKGmZQFRZldZiGixnQZbI
         DS3w==
X-Gm-Message-State: AOJu0YxwiYFBQod+9QbVV1EpBQ1yKzyxlfM12KZxfgd4/PYTiyGpeGjU
	78U/AKXyRC564dZw2I8kAFOFGf8QifnXBf0l2FoEnTM6njhb+v7PMIvuUmDDL0o/8eOyZ6gCKFq
	aCp8=
X-Google-Smtp-Source: AGHT+IF3mJ/Vwcpioj8Xv0usb9N2TGSXsRFkdcNf3nIewz6woeAHpM+2u6QmzfeM8UPIRb9Ge1tzcQ==
X-Received: by 2002:a17:906:c20e:b0:a6e:5801:ed43 with SMTP id a640c23a62f3a-a6f47f59e76mr292294266b.30.1718258163678;
        Wed, 12 Jun 2024 22:56:03 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:6dd9:ebe6:fd11:a860])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecdd2asm34787366b.141.2024.06.12.22.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 22:56:03 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: stable@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 6.1.y] mmc: davinci: Don't strip remove function when driver is builtin
Date: Thu, 13 Jun 2024 07:55:41 +0200
Message-ID: <20240613055540.2284309-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024061227-zit-rupture-640c@gregkh>
References: <2024061227-zit-rupture-640c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1872; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=8r/GEdOjRL5/jmumYWI/iyzIUOJDzlBClCqe0MDJtuQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmaonciE2LZLqxjw9+US8tFZdBDb3X5Ef6R9++U t7tT+rk7QGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZmqJ3AAKCRCPgPtYfRL+ TvGfCACGB8RXmFTI/8qhbOs4AK1uWp085o8PCeBVo8k5iaSv7NkV0wCMmi8OvF9+saD/a4mVgzi hj90jKLXX5WCre/ljAEGtFpKff7KmjN2eNG+Q27JdGM8TTXYMWrnZwbylUWyCNEC9u2sPuSipQb 1RPEJSNvoTYj1oykze8ksJj2SptPhY4YllmMo4Y3LtCSRnQMilHeC6GQbSaCxSN/99T/RfTbIwM IjAnNj27lV3gLkFPB8qhiSlsg1IqMiMdRmARJK6EuERw0v4PZ4ifKSrej6YrA2BzGgZU18wXpAy K2Sd+tB1SutdpaaV3i7jH01Ok+sKIhBUtdY5D4M11wpIF1KW
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Using __exit for the remove function results in the remove callback being
discarded with CONFIG_MMC_DAVINCI=y. When such a device gets unbound (e.g.
using sysfs or hotplug), the driver is just removed without the cleanup
being performed. This results in resource leaks. Fix it by compiling in the
remove callback unconditionally.

This also fixes a W=1 modpost warning:

WARNING: modpost: drivers/mmc/host/davinci_mmc: section mismatch in
reference: davinci_mmcsd_driver+0x10 (section: .data) ->
davinci_mmcsd_remove (section: .exit.text)

Fixes: b4cff4549b7a ("DaVinci: MMC: MMC/SD controller driver for DaVinci family")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240324114017.231936-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[ukleinek: Backport to v6.1.x]
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/mmc/host/davinci_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 7138dfa065bf..e89a97b41515 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1345,7 +1345,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit davinci_mmcsd_remove(struct platform_device *pdev)
+static int davinci_mmcsd_remove(struct platform_device *pdev)
 {
 	struct mmc_davinci_host *host = platform_get_drvdata(pdev);
 
@@ -1402,7 +1402,7 @@ static struct platform_driver davinci_mmcsd_driver = {
 		.of_match_table = davinci_mmc_dt_ids,
 	},
 	.probe		= davinci_mmcsd_probe,
-	.remove		= __exit_p(davinci_mmcsd_remove),
+	.remove		= davinci_mmcsd_remove,
 	.id_table	= davinci_mmc_devtype,
 };
 
-- 
2.43.0


