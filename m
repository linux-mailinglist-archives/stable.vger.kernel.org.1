Return-Path: <stable+bounces-77802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F27669876D2
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 17:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 532E3B281A5
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 15:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F82158D66;
	Thu, 26 Sep 2024 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tr62/Wsx"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA215146D7F
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365608; cv=none; b=iBr2hmjY9ZKc1NeWl7egJ+RFyTpT0y5M6hPGo8SIiW0vQM7g4yXzynPJDgw2/xmWEaWxVvqRjrlmyM51xABfyKb5ezo0ICT9DoXfqTEFydbnxZZ0mao58OuZcqHlkxQmyK8ed25XA7GRTJrv05UfRmZbLsDSv07r22HBQZio/Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365608; c=relaxed/simple;
	bh=vTwVvG8iZlHzHza+YS67mEwp2zyunt+kNzBDYWtFYWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qcQGlGlGDTndNXOCgX+Dv8oFXSvy++aTr+HMLPgPK0m3DddkU3Xwf4xI3/dOzaCfyo4dgfs35W89992uOZZBigMZLP+UH8xmDY008AcOnxJMvefsVwLyHQoWSGuY45qIFBfTIFB2hLxePTQKUVcPdDs8MhzOrwnL86BzZYpTVfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tr62/Wsx; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5389917ef34so1252021e87.2
        for <stable@vger.kernel.org>; Thu, 26 Sep 2024 08:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727365604; x=1727970404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7nKjwcfTxwC0PwN6GrPgJAgBaaTNk6QSx4URpDS/gc=;
        b=Tr62/WsxrIbtWYD/PpbNOfunNtorLYB6HgXtx2kPaQxdlYMzuxlJmBP3XcvDaC1CIM
         /OWmD0XeYGUp6L8PmaFwoxHQFEM/h49p85/eD1vTkksURqcBs4HZetRz4RltopSKKGJD
         N4N6tL2DB8NEK7884Qw2dQleH8eRaFepbcjbxgXtbhgimSBJE5/RDGhM1N72xpkJrPHT
         4rscA1UetElZ3RzCSt2lWGA4Tbze9gXOEtQ4SGOYj0O4u/nycIW+3RokiniMa9+5vm8M
         K1yD/PXBzCmbSjXbwRWV2tDNG0E1zNNu3n1zBVX/ZHBb7yDLe0pWsz1mBB6fxncgXDr6
         sMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727365604; x=1727970404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7nKjwcfTxwC0PwN6GrPgJAgBaaTNk6QSx4URpDS/gc=;
        b=OiruGxdDQWozRd5L+Zk/uCdV2hcKSFaaiaFkr/aF/r9DHdVN0F4JzBfFao18UF7ZsP
         3C/765ZD3fuBMaCQyt/W8tBwPWpI8GaDrJik0enZza0NH+gEEtoKUA2OKQD+J4wIuq4k
         42MvNZBX1ZJ8rK7Ur/cWXVsGLSLI0c3W++vBQxf7GVqrmz4P3yXlB4PAsTuR161UvL22
         1MgTMWY+yedGa7fUf5JYtZSo20iAbhNviJgH7MsLeLvzPcOm29EUujJpsI98ra1A5PII
         9wLU01MpXikQrFku5W++5x/rDBOwj6Bj6cHG3Bi+WAJHY2LVdKbx1eIGJ6h8RytzuwUf
         Bzeg==
X-Forwarded-Encrypted: i=1; AJvYcCUZt7Z8skYuDwJmHVgHyKXA7+L7ToaouQPuJ51tb8MGHuQnaAhnL2kugGOgv2UFewwfjNCGT14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq+CpVdXFoWSC/rTH1oB50cXmXtcENMwLOruKW5Z593vWQvI5n
	g3No10KKiexC9uWhi41/jxQix/ybFi+LVzeuN5EYxKpRIKtVLkZWjw3d0CnEE0c=
X-Google-Smtp-Source: AGHT+IHC0UquaOxuhN7DmBE/LSdM/gTJCcl8evA7sxTCF52bwGR80T7zNwFTy8yz3npSXKHM2xzLNQ==
X-Received: by 2002:a05:6512:b21:b0:536:54df:bff2 with SMTP id 2adb3069b0e04-5389fc6ce3fmr15586e87.54.1727365603983;
        Thu, 26 Sep 2024 08:46:43 -0700 (PDT)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c882405166sm75744a12.9.2024.09.26.08.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:46:43 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Thu, 26 Sep 2024 16:46:37 +0100
Subject: [PATCH 1/4] media: ov08x40: Fix burst write sequence
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-b4-master-24-11-25-ov08x40-v1-1-e4d5fbd3b58a@linaro.org>
References: <20240926-b4-master-24-11-25-ov08x40-v1-0-e4d5fbd3b58a@linaro.org>
In-Reply-To: <20240926-b4-master-24-11-25-ov08x40-v1-0-e4d5fbd3b58a@linaro.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jason Chen <jason.z.chen@intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2802;
 i=bryan.odonoghue@linaro.org; h=from:subject:message-id;
 bh=vTwVvG8iZlHzHza+YS67mEwp2zyunt+kNzBDYWtFYWc=;
 b=owEBbQKS/ZANAwAIASJxO7Ohjcg6AcsmYgBm9YHg4K/kfdpbJQr+sw9ORWikEEUVqPmwUlJR2
 bTlEW+ogzKJAjMEAAEIAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCZvWB4AAKCRAicTuzoY3I
 Ohl/D/0Qb6kIU3vP5HUUG7aJUfyxpNFzA1wXaBuDcXnB/unRTeG6IpZ3IWeEFNgO/tti+ReF2Nm
 crX5bRwXLxSEJ6DO5eKhUL/PbDyq80O0q4LXjfzTbgOb/56biZxFvo73Kp9gcfm8fT1S6SC25pS
 CZ6fLP82MCppTds4iRoAuif/8zfvqRVjEMEoxYz/gwlPFN42n2PDUx74eLJMrV22sP6JkEVYlfD
 qdlbPMU1ziiDTFehsG7vCXXC9Z5TWGSO/U/cBbK6eZSRcD8bUfBLy27NhbmZgHIR/L/IyKBWoP9
 vB0KaQmcJGEWXTNfrMdz0yeL/h5Wtup/MzJYFIKwWmpvWsRAywElmabLlCXwjohKfvNlp6KqceX
 H8LREqgmliNbLF1EoggBJgzDCs2SM/G7zEqoCkQI8s87xeizWkPkqUlyMPmkBdXXcHGQdNP45Y8
 GUc2F4jUSTvdahmtXUzaiozGGGHCKQ7YgkNsk9YnJpoZckdo0F7Ta0oak3ETxMTOaWQZ1QshOYT
 g+9oXzKhpS/0o2m5BwJBfE/EmwBzSR8BuSacZxH80brKjK7iozHMcssJj3AUKUELU9vfirLteoY
 wV4cfEHsygpEby6S0aUn1DVBnyosYcZJoWIas6gtdnFdQp1aaN3Ut3HkxQAACOhG6Yqx44uV+0u
 ObvNwXiyV425BvA==
X-Developer-Key: i=bryan.odonoghue@linaro.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

It is necessary to account for I2C quirks in the burst mode path of this
driver. Not all I2C controllers can accept arbitrarily long writes and this
is represented in the quirks field of the adapter structure.

Prior to this patch the following error message is seen on a Qualcomm
X1E80100 CRD.

[   38.773524] i2c i2c-2: adapter quirk: msg too long (addr 0x0036, size 290, write)
[   38.781454] ov08x40 2-0036: Failed regs transferred: -95
[   38.787076] ov08x40 2-0036: ov08x40_start_streaming failed to set regs

Fix the error by breaking up the write sequence into the advertised maximum
write size of the quirks field if the quirks field is populated.

Fixes: 8f667d202384 ("media: ov08x40: Reduce start streaming time")
Cc: stable@vger.kernel.org # v6.9+
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # x1e80100-crd
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/i2c/ov08x40.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/ov08x40.c b/drivers/media/i2c/ov08x40.c
index 48df077522ad0bb2b5f64a6def8844c02af6a193..be25e45175b1322145dca428e845242d8fea2698 100644
--- a/drivers/media/i2c/ov08x40.c
+++ b/drivers/media/i2c/ov08x40.c
@@ -1339,15 +1339,13 @@ static int ov08x40_read_reg(struct ov08x40 *ov08x,
 	return 0;
 }
 
-static int ov08x40_burst_fill_regs(struct ov08x40 *ov08x, u16 first_reg,
-				   u16 last_reg,  u8 val)
+static int __ov08x40_burst_fill_regs(struct i2c_client *client, u16 first_reg,
+				     u16 last_reg, size_t num_regs, u8 val)
 {
-	struct i2c_client *client = v4l2_get_subdevdata(&ov08x->sd);
 	struct i2c_msg msgs;
-	size_t i, num_regs;
+	size_t i;
 	int ret;
 
-	num_regs = last_reg - first_reg + 1;
 	msgs.addr = client->addr;
 	msgs.flags = 0;
 	msgs.len = 2 + num_regs;
@@ -1373,6 +1371,31 @@ static int ov08x40_burst_fill_regs(struct ov08x40 *ov08x, u16 first_reg,
 	return 0;
 }
 
+static int ov08x40_burst_fill_regs(struct ov08x40 *ov08x, u16 first_reg,
+				   u16 last_reg,  u8 val)
+{
+	struct i2c_client *client = v4l2_get_subdevdata(&ov08x->sd);
+	size_t num_regs, num_write_regs;
+	int ret;
+
+	num_regs = last_reg - first_reg + 1;
+	num_write_regs = num_regs;
+
+	if (client->adapter->quirks && client->adapter->quirks->max_write_len)
+		num_write_regs = client->adapter->quirks->max_write_len - 2;
+
+	while (first_reg < last_reg) {
+		ret = __ov08x40_burst_fill_regs(client, first_reg, last_reg,
+						num_write_regs, val);
+		if (ret)
+			return ret;
+
+		first_reg += num_write_regs;
+	}
+
+	return 0;
+}
+
 /* Write registers up to 4 at a time */
 static int ov08x40_write_reg(struct ov08x40 *ov08x,
 			     u16 reg, u32 len, u32 __val)

-- 
2.46.2


