Return-Path: <stable+bounces-9836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8B98255A6
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 15:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD861F240A2
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 14:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D0D2E3E8;
	Fri,  5 Jan 2024 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bW0nygjk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606C22D051;
	Fri,  5 Jan 2024 14:41:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB62C433C8;
	Fri,  5 Jan 2024 14:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465665;
	bh=B+yRsj+bjLUkWamgApaMm1Ex0f3RwwOuTTU8k/j9f4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bW0nygjkm6Icj7D6o6+Gw68QDGYEiWu/U4zEFn1eJwqqr88E0PAra6CwebFlyjIXc
	 NVN8WD02hCwBwPO+rZ5/JlWKNNt3mhxlNrFY2W0m4qfo/mSrCiskT4Jv+wgcgtukT4
	 RFDQHYDPvPXPHGpt/7dXxu/CvIzU6onpLmHi+Seg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haoran Liu <liuhaoran14@163.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 23/41] Input: ipaq-micro-keys - add error handling for devm_kmemdup
Date: Fri,  5 Jan 2024 15:39:03 +0100
Message-ID: <20240105143814.964224261@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105143813.957669139@linuxfoundation.org>
References: <20240105143813.957669139@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haoran Liu <liuhaoran14@163.com>

[ Upstream commit 59b6a747e2d39227ac2325c5e29d6ab3bb070c2a ]

Check the return value of i2c_add_adapter. Static analysis revealed that
the function did not properly handle potential failures of
i2c_add_adapter, which could lead to partial initialization of the I2C
adapter and unstable operation.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
Link: https://lore.kernel.org/r/20231203164653.38983-1-liuhaoran14@163.com
Fixes: d7535ffa427b ("Input: driver for microcontroller keys on the iPaq h3xxx")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/ipaq-micro-keys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/keyboard/ipaq-micro-keys.c b/drivers/input/keyboard/ipaq-micro-keys.c
index 602900d1f9378..2d0d09ee9ab08 100644
--- a/drivers/input/keyboard/ipaq-micro-keys.c
+++ b/drivers/input/keyboard/ipaq-micro-keys.c
@@ -108,6 +108,9 @@ static int micro_key_probe(struct platform_device *pdev)
 	keys->codes = devm_kmemdup(&pdev->dev, micro_keycodes,
 			   keys->input->keycodesize * keys->input->keycodemax,
 			   GFP_KERNEL);
+	if (!keys->codes)
+		return -ENOMEM;
+
 	keys->input->keycode = keys->codes;
 
 	__set_bit(EV_KEY, keys->input->evbit);
-- 
2.43.0




