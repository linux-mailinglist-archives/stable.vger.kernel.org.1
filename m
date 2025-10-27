Return-Path: <stable+bounces-189951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB066C0CEBF
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 11:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6873BDBBB
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 10:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3901283FD8;
	Mon, 27 Oct 2025 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vrBLRIYF"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729EC22424E
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761560307; cv=none; b=B87oYatJVLSW98CHAtoqWyg71rOfFLPBQzA+jAQG6B2+q+ZNUhtdEALwPMPr7FyLSAj/hjCPDDZU7sO2vX1f8U8fAwh98+pqsS75gyx1kECfXiV31NaOT20YGW4QiZ0SjifGbHbC1SgHuKRop4mK7CR/e3L6REjA16YcHB8hb6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761560307; c=relaxed/simple;
	bh=cqrBqLQytVCzcJ7E7kwhYkcYYp2Zs/BePmICGhQ/GWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UrLH7GTkk26gkLHq7RZOeHS3yfuXeYmBLXifW2Z/OnNoEOxxSuOGKupkR9hgDcBZwN5z2B5cPytOtzPgu7QPfwCrOtr5LRoAZH4iWdzDGSH4P/Ri7kxa0WpRhBWybpF1xJhPcmiY0UjTMSiDIPtF9j6BQS65ec9RoVn5UaJsS+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vrBLRIYF; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-592fcf7a1ceso3444341e87.1
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 03:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761560303; x=1762165103; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jx03cUjHaKSnZslq4rOuaP2cLEUlRGHdIcj19b2yJKE=;
        b=vrBLRIYFYvNdHfOjSecnukcz3DdQK/MAkzO40xpZEuP664+FoHsh/MVlKUQIPj0DsW
         UYkqH4QSAVoi/hNN4wBCHJaR5B7KA9M9urGa4ONICv2RlV+JHTQUMpLKtGDSOrvd0M9W
         pLXYAl/a6hUiqu59Nz+mEDTlrmyNRmSzNPE/4ky9Mm+dyIDqnC/G0dYKCBxc3L0RtHV5
         MhXIlZzjL3LuSYvKdlBaCdeY3xBPlxvckE0oZOQDyMyOBYFRBroYW9/LGM7LoPSSd7eE
         6aZjA0LE9JuJ7xoWeFFnE957yfVeGf6QmNSv+nGKgGmaGh5HN+IYd2qnepXn1ll/2AEO
         3GFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761560303; x=1762165103;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jx03cUjHaKSnZslq4rOuaP2cLEUlRGHdIcj19b2yJKE=;
        b=jgEjqRe/FqgFdAxmppJ/l9C1T2R/iCd7JAZJmU29ZsuSeKTawPLO3toytiKk0qZqU+
         vT27c5cVX+ffUMWLyhzYM9xXjAHoLXi/mhdIgXefNngzyGwSJeaQAG7BSGcNvfOHLhUT
         5ZPbo2l3Suwt9t0jVCwcy3QUnmS9H3rSBAn2uN2JNpv1tr08chNG1NK29ZJAfUwigw1+
         KaWeYxHAImi+/0V3Yq7nebPfcCoyK2zSmCF1uE4IljcnHJrJH/YaU4JL7w+OYHN9J9su
         6rNJO8vhT62bUx5lRmag0NkYBri+Wx6ONJhniKBHXei1WJJclbNHohOR8OSbMCVWCt7i
         Pprg==
X-Forwarded-Encrypted: i=1; AJvYcCU0hz3g/YQDYnziM8mSKRpYWR+lTZR6zOaMIn7j2cEEmap+27Olrd/SXIhD6TredM41mtPcwUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOmJWTLSwXySo5JokL/IbiuvQLSEb1ilCtYKuMmOnHHiu/WalO
	IN3kx8LUsAja/1ESernZsuw4Hv06HHcZNkNkXoHEMt8BTPIe7jvvHUPIP12UyJVVT9c=
X-Gm-Gg: ASbGncu3ZZFxLOIZjUMDVUxiETCdWJHSG0u8/cfcEfW2hExgCWRoZOofP60CfHiNR+1
	tL9HyiZ5UlnKSbkbyl2YkMOQxEeiJKJ8MME5bNOQe+Air4RALU0EZovcg7RL+bkhW4L/t/XgtCy
	FmWZsOEGVJZBrGH877cEzThvXswlqFRux3S+Qdc181IM8oZLNBtmuv9Znw1Oa2aTNXcr1AN0jYH
	1thgJaiBTTVvF8frbnZB1OZarWHwHJgKBEVgTJSbzp/dMFoJG/WH9Ep72hPkYQ1AhhsXFfyh9NZ
	S7JkQzo5bsV3+dc/cfwZ41ulmvF2cLlIBsCHCO8khS1PejGatKswkaCuhj3/S6vfI+Hu0SRxEBB
	u13bIUSybQd3g+bv3jnyzPg5UqzcLwTxXlPc5Yy+ar7zXEIUMQiQbdun7vzxdxn0OWp3fsUicOs
	mWpmlLWW2OKFzw+AkoCgk8GwPuuX3ByPi1PXH9ZeoBchIXyMC3rp63+Toku7tKkFqhnw==
X-Google-Smtp-Source: AGHT+IH7t8z7lDWKkakNj0SLYuUWwctos1aBtTyjZBDabk0/LlhiEDtCYrfnR0zT5tDvpxsBwbOmzg==
X-Received: by 2002:a05:6512:3a93:b0:592:f72f:c1d2 with SMTP id 2adb3069b0e04-592fc9d4fa5mr3566258e87.10.1761560303437;
        Mon, 27 Oct 2025 03:18:23 -0700 (PDT)
Received: from [192.168.1.2] (c-92-34-217-190.bbcust.telenor.se. [92.34.217.190])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f6e644sm2225342e87.79.2025.10.27.03.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 03:18:23 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 11:18:17 +0100
Subject: [PATCH] iio: accel: bmc150: Fix irq assumption regression
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-fix-bmc150-v1-1-ccdc968e8c37@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNz3bTMCt2k3GRDUwNd81RTMwtDI6MkIzNTJaCGgqJUoCzYsOjY2lo
 AMCLE4VwAAAA=
X-Change-ID: 20251027-fix-bmc150-7e568122b265
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: linux-iio@vger.kernel.org, stable@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.3

The code in bmc150-accel-core.c unconditionally calls
bmc150_accel_set_interrupt() in the iio_buffer_setup_ops,
such as on the runtime PM resume path giving a kernel
splat like this if the device has no interrupts:

Unable to handle kernel NULL pointer dereference at virtual
  address 00000001 when read
CPU: 0 UID: 0 PID: 393 Comm: iio-sensor-prox Not tainted
  6.18.0-rc1-postmarketos-stericsson-00001-g6b43386e3737 #73 PREEMPT
Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Support)
PC is at bmc150_accel_set_interrupt+0x98/0x194
LR is at __pm_runtime_resume+0x5c/0x64
(...)
Call trace:
bmc150_accel_set_interrupt from bmc150_accel_buffer_postenable+0x40/0x108
bmc150_accel_buffer_postenable from __iio_update_buffers+0xbe0/0xcbc
__iio_update_buffers from enable_store+0x84/0xc8
enable_store from kernfs_fop_write_iter+0x154/0x1b4
kernfs_fop_write_iter from do_iter_readv_writev+0x178/0x1e4
do_iter_readv_writev from vfs_writev+0x158/0x3f4
vfs_writev from do_writev+0x74/0xe4
do_writev from __sys_trace_return+0x0/0x10

This bug seems to have been in the driver since the beginning,
but it only manifests recently, I do not know why.

Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/bmc150-accel-core.c | 5 +++++
 drivers/iio/accel/bmc150-accel.h      | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 3c5d1560b163..f4421a3b0ef2 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -523,6 +523,10 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
 	const struct bmc150_accel_interrupt_info *info = intr->info;
 	int ret;
 
+	/* We do not always have an IRQ */
+	if (!data->has_irq)
+		return 0;
+
 	if (state) {
 		if (atomic_inc_return(&intr->users) > 1)
 			return 0;
@@ -1696,6 +1700,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	}
 
 	if (irq > 0) {
+		data->has_irq = true;
 		ret = devm_request_threaded_irq(dev, irq,
 						bmc150_accel_irq_handler,
 						bmc150_accel_irq_thread_handler,
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index 7a7baf52e595..6e9bb69a1fd4 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -59,6 +59,7 @@ enum bmc150_accel_trigger_id {
 struct bmc150_accel_data {
 	struct regmap *regmap;
 	struct regulator_bulk_data regulators[2];
+	bool has_irq;
 	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
 	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
 	struct mutex mutex;

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251027-fix-bmc150-7e568122b265

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


