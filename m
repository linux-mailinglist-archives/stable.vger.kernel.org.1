Return-Path: <stable+bounces-108384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E70BFA0B384
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 10:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0419918802AC
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 09:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0E7235C01;
	Mon, 13 Jan 2025 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMPCtbjL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432D9235C15;
	Mon, 13 Jan 2025 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736761629; cv=none; b=Htb1rlWo7T92+BJc3uUHHw55VzopjHKJ2YmbXZGbMyxphiaBY2SssInoo/xjiUGO7IJDkfOM4Gz2dAOIJ/GRxUAt0swk7PJT3HBpoIgYfazfEp9wZEFPswiQEYDP7da6tJuQq+9zjFHY3t+712YQJ273rUofdbTwm2odXSg5VOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736761629; c=relaxed/simple;
	bh=9e3wcjDiQuT6RY4XnOjEYM/O28Bk5iZRTgZoKR14NAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QqrA6C40i6OjHZ4sFg+IieABpqQN4OAsA2KC1kTHgB0+aJeB4GWGjH18/IlBthohsQqtRafg8mfKDuuPSrcJOQ5h0T+GEmFiXXKRTGLgOR3t1G/ixCwLRYSlpTpvggSw3Mku55JctmjLA+r/uH/h/5jUrb9VRpqjLwi7BH4IUoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMPCtbjL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-436345cc17bso28744215e9.0;
        Mon, 13 Jan 2025 01:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736761626; x=1737366426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P/Vpk+fuONkvTQ0KzQxSovHrQHyHGceSyePSaTNOG1w=;
        b=aMPCtbjL88uQcVEDOVkghZG0VHM0/5BeaXOT7qDzh5B2fTq3U1OiEge5VY64/HuXh+
         5GvKipSGZFQF9r9SVxOFG/VwNYVrtM48evjK8q4a7B0XV9aOacSqNPzwbLrxNxGeliKW
         3yhyIB4v4+dnVMwCTnwPd3qliIr70cIg3v+m0f5Ftydw/At9U4ZaHI3K3A6iR/87UcVW
         7r1lfk9RoIZip0Kg5C+Yda6uyQV+p/MuPjAWVkEvtocwiuzjfzKcMPcg//n2IzUxMWX+
         epzgrn6BVFDhuImiym1tv3ngdBan9hvGzf+4IzPK/kOG/8JDZJf1XgMnF1kaBo44zoWN
         D0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736761626; x=1737366426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/Vpk+fuONkvTQ0KzQxSovHrQHyHGceSyePSaTNOG1w=;
        b=XNO2cBNAs0LUx0Oflt/OzDqNZ+gJIN2XRiKeIZTnBLgh9qzzB4C+lkpdAkbpg36Ede
         Q+qkdUu6A3Io90t7X2gjInCNj3smtglFY7h0uNYBN8W5R6cE+O2c+NvisTTObA2xsaV2
         cNiyr8317Y8a3g8qznt2l1anUf35wQlwrT+fNxtrDlnCkQ9vjHc2/q0VjMJh2Ac9hQ1s
         jkPft9/7xS3cQ4F/GU0wg+3smTNTavI6Qsttvxc7djrqBGCgb/aCQiba53pttcjGEs9w
         nAxThBRP2w7E/p0GOgXepHS1pk1FrdipXHggk/4KFEfb0tVOk9pIM+QUCypwByT6lyyD
         4XRw==
X-Forwarded-Encrypted: i=1; AJvYcCU/dqd0TnwKVfPcFq5RhUQAM2yW9QaiBRenrPsa5CLMbEfbd/XUeEhRViJbXe1e/19X7rWCZUKU@vger.kernel.org, AJvYcCX0RJi9/SbQO1+FtaLdvYkWS5hzPha7lhQDcHdQ9mHwv4Nl47f8cq/ztQPNcEuu28mpZKS1dKpH2NrTft4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9TulXORxRVZ1vMd7PDWKJGeb7RthIHrvxy8PcDIQlEjRZG4lB
	krL8WT4GhGXintfZ8rI04hzEyBmxHaWFe3NUqPs9TLgTrh/leCBw
X-Gm-Gg: ASbGncvKq5A6GMDuCtcbmFnxXAXylBrs9uB8GDkAhqO8j6FkVeTl2krO1X9FIcXHTyD
	y+KXrx6bTLPZ8w8tM9wav288x1EE8o0N8wBAv/KniktaoSx3iFswICJqLDu+pW/Vp5ujdeDWpZu
	jh2peiXsTsOKK0sw1w8dVy+OamX7Wt3hucelKspNqTVwCvS3YgqNAN0ukhJsnwqP5puIJn6xD9R
	JoosHRxpdUVlQsblDmPuM0SeA+FqYXHRsGs7HetvDQ9EjMVFd3aCb4Xxzu96MT3ttVKv+Zh
X-Google-Smtp-Source: AGHT+IHP5Bm+4RrlbE63eSMQZv1afGLq2XBlbRHRzKAffDpxJbpr/cFucD7iCpIjpeVScKlPbLduCA==
X-Received: by 2002:a05:6000:18ab:b0:385:f349:ffe7 with SMTP id ffacd0b85a97d-38a872f6d5fmr17550961f8f.2.1736761625584;
        Mon, 13 Jan 2025 01:47:05 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:a5a1:302a:fcf7:c337])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b80besm11472257f8f.83.2025.01.13.01.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:47:05 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: abelvesa@kernel.org,
	peng.fan@nxp.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	shengjiu.wang@nxp.com,
	francesco.dolcini@toradex.com
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] clk: imx: imx8-acm: fix flags for acm clocks
Date: Mon, 13 Jan 2025 10:46:08 +0100
Message-ID: <20250113094654.12998-1-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Currently, the flags for the ACM clocks are set to 0. This configuration
causes the fsl-sai audio driver to fail when attempting to set the
sysclk, returning an EINVAL error. The following error messages
highlight the issue:
fsl-sai 59090000.sai: ASoC: error at snd_soc_dai_set_sysclk on 59090000.sai: -22
imx-hdmi sound-hdmi: failed to set cpu sysclk: -22

By setting the flag CLK_SET_RATE_NO_REPARENT, we signal that the ACM
driver does not support reparenting and instead relies on the clock tree
as defined in the device tree. This change resolves the issue with the
fsl-sai audio driver.

CC: stable@vger.kernel.org
Fixes: d3a0946d7ac9 ("clk: imx: imx8: add audio clock mux driver")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/clk/imx/clk-imx8-acm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8-acm.c b/drivers/clk/imx/clk-imx8-acm.c
index c169fe53a35f..f20832a17ea3 100644
--- a/drivers/clk/imx/clk-imx8-acm.c
+++ b/drivers/clk/imx/clk-imx8-acm.c
@@ -371,7 +371,8 @@ static int imx8_acm_clk_probe(struct platform_device *pdev)
 	for (i = 0; i < priv->soc_data->num_sels; i++) {
 		hws[sels[i].clkid] = devm_clk_hw_register_mux_parent_data_table(dev,
 										sels[i].name, sels[i].parents,
-										sels[i].num_parents, 0,
+										sels[i].num_parents,
+										CLK_SET_RATE_NO_REPARENT,
 										base + sels[i].reg,
 										sels[i].shift, sels[i].width,
 										0, NULL, NULL);
-- 
2.45.2


