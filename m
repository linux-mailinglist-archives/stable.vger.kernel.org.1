Return-Path: <stable+bounces-177921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBB6B4684C
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 04:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5E95C0690
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 02:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F8C1F8908;
	Sat,  6 Sep 2025 02:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="To0HTPhP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96141F866A
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 02:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757124816; cv=none; b=AaOxVAPz/88V6y1//TjbM7fytkJ3JjbipuhZeQ40aclMkPDDtHOaaypyb1YMIrTRmnHvkyY+AvAsCGPvWYjhdoFBMDbj+HJphhgMozBIbRQqjmbj9oZGpulh7etxLEHyN7y287NTtVQT6q7KpZlU6W393TpqoqmdtnGWNeInVwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757124816; c=relaxed/simple;
	bh=jMF0zGDUd0FUrM2MpsMmD/6vaolRKDid1hhy5gjh7y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rY7YHuWeQtAu53673K60Nx+WrfQYkMdlzjZShCwG9Y1s4hN8ieOJH+Jkhqxqa8hcSpnc71g2T1ra/3PdYDsC5yELt2ZyvIgCnUlK+yqq0UmI7W5N7Pv5HLjPeAwLNfAZw9CKxSl+/9SzyeAcSoJ1XVHTm6ijQhQX6mUbM5nl2B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=To0HTPhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D1DC4CEF4;
	Sat,  6 Sep 2025 02:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757124816;
	bh=jMF0zGDUd0FUrM2MpsMmD/6vaolRKDid1hhy5gjh7y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=To0HTPhPLI63VaOeMmawMSpEXgu6XdBwTFmuybGxg/Jllsr4wn+PvLWWfr3l/nEC5
	 sIr8uTg7wym6Lv75ZxW6KBuY0rqGXdoRNx0fD1rha81syqsoEX5xANCEDNTEc25CZe
	 d/RHkk90GRxxN9iZ0Mg61aJCVOFNbQY0BDSAyq6i1wBoFvEDOK3nNiHJprhWcALjR4
	 OxgPWUwt3cw4ld2+gBxvgjDOcBXxZ2CUY8jnRZ6q6yUhiwxwrBzRyv1vyuJc18Oq1m
	 QoMDCIxBHEV0zS8QzCh2uByktfI+nP0AQyhMKPzLhdqP6UQXM2bAGs3cr13qvf+jSh
	 zRkjZCthRIORw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: light: opt3001: fix deadlock due to concurrent flag access
Date: Fri,  5 Sep 2025 22:13:34 -0400
Message-ID: <20250906021334.3665365-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025051215-defendant-dilation-d039@gregkh>
References: <2025051215-defendant-dilation-d039@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

[ Upstream commit f063a28002e3350088b4577c5640882bf4ea17ea ]

The threaded IRQ function in this driver is reading the flag twice: once to
lock a mutex and once to unlock it. Even though the code setting the flag
is designed to prevent it, there are subtle cases where the flag could be
true at the mutex_lock stage and false at the mutex_unlock stage. This
results in the mutex not being unlocked, resulting in a deadlock.

Fix it by making the opt3001_irq() code generally more robust, reading the
flag into a variable and using the variable value at both stages.

Fixes: 94a9b7b1809f ("iio: light: add support for TI's opt3001 light sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Link: https://patch.msgid.link/20250321-opt3001-irq-fix-v1-1-6c520d851562@bootlin.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/opt3001.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index dc529cbe3805e..25a45c4251fbd 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -692,8 +692,9 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
 	bool wake_result_ready_queue = false;
+	bool ok_to_ignore_lock = opt->ok_to_ignore_lock;
 
-	if (!opt->ok_to_ignore_lock)
+	if (!ok_to_ignore_lock)
 		mutex_lock(&opt->lock);
 
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
@@ -730,7 +731,7 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	}
 
 out:
-	if (!opt->ok_to_ignore_lock)
+	if (!ok_to_ignore_lock)
 		mutex_unlock(&opt->lock);
 
 	if (wake_result_ready_queue)
-- 
2.50.1


