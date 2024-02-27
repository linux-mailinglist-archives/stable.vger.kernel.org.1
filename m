Return-Path: <stable+bounces-24207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C07386932A
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41AFF1F291B5
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC18D13B7AA;
	Tue, 27 Feb 2024 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fe0rmakY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9F613AA55;
	Tue, 27 Feb 2024 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041333; cv=none; b=lMt/uwsr231FZbkwubv6qfXsgvaafBaT80Ew1AeHgQci3gBs5x+TapET7SGdYcGVRdqfwgq+45f2fxWgAGjW67YTU8AFCzXKCljlsudpc9Qm2q0PKy2kPqBnLEGyDkyVSvWMuPnPbVi6DQUibs5krgkKPXlpLbqSsm+rm0/01cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041333; c=relaxed/simple;
	bh=58N6M4pVAHRm6QWnQyixNUZoL908JiRGLkXbKZ5Kxf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXx6XhxRKqncH4vwNfWTfFm58glH/EaofOipvmFkAzvaHDfWhbfu/zcIE4AVcSndVPQPnLxzJzg6/HpvXKAw6MyaqQ683I6KV9hfyagqkjyz1yf1506pyNHzN+kM16ESAjQIp/QSN84ywiRsEHGlA+huKk1ZyvGvCb+8j1vPE3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fe0rmakY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13741C433F1;
	Tue, 27 Feb 2024 13:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041333;
	bh=58N6M4pVAHRm6QWnQyixNUZoL908JiRGLkXbKZ5Kxf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fe0rmakYnqFCrXeHjVsltP1OTnYRZFFOxBAxUJWWbT48E+XHeIL58Jns59DqnoWOZ
	 AwsKxL/ZPeNS2++fDgR4P8LOFNl+2P2k7+r7F0z9VI+xin+hrQ6ixO1ljHxFFtqjGK
	 1XXZhA9YEi2EzKeilWUUxi2wNCVzd/eEVoVJhV6g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Erhard Furtner <erhard_f@mailbox.org>,
	Ahmad Khalifa <ahmad@khalifa.ws>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 302/334] hwmon: (nct6775) Fix access to temperature configuration registers
Date: Tue, 27 Feb 2024 14:22:40 +0100
Message-ID: <20240227131640.790098521@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit d56e460e19ea8382f813eb489730248ec8d7eb73 ]

The number of temperature configuration registers does
not always match the total number of temperature registers.
This can result in access errors reported if KASAN is enabled.

BUG: KASAN: global-out-of-bounds in nct6775_probe+0x5654/0x6fe9 nct6775_core

Reported-by: Erhard Furtner <erhard_f@mailbox.org>
Closes: https://lore.kernel.org/linux-hwmon/d51181d1-d26b-42b2-b002-3f5a4037721f@roeck-us.net/
Fixes: b7f1f7b2523a ("hwmon: (nct6775) Additional TEMP registers for nct6799")
Cc: Ahmad Khalifa <ahmad@khalifa.ws>
Tested-by: Ahmad Khalifa <ahmad@khalifa.ws>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775-core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index 92a49fafe2c02..f3bf2e4701c38 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -3512,6 +3512,7 @@ int nct6775_probe(struct device *dev, struct nct6775_data *data,
 	const u16 *reg_temp_mon, *reg_temp_alternate, *reg_temp_crit;
 	const u16 *reg_temp_crit_l = NULL, *reg_temp_crit_h = NULL;
 	int num_reg_temp, num_reg_temp_mon, num_reg_tsi_temp;
+	int num_reg_temp_config;
 	struct device *hwmon_dev;
 	struct sensor_template_group tsi_temp_tg;
 
@@ -3594,6 +3595,7 @@ int nct6775_probe(struct device *dev, struct nct6775_data *data,
 		reg_temp_over = NCT6106_REG_TEMP_OVER;
 		reg_temp_hyst = NCT6106_REG_TEMP_HYST;
 		reg_temp_config = NCT6106_REG_TEMP_CONFIG;
+		num_reg_temp_config = ARRAY_SIZE(NCT6106_REG_TEMP_CONFIG);
 		reg_temp_alternate = NCT6106_REG_TEMP_ALTERNATE;
 		reg_temp_crit = NCT6106_REG_TEMP_CRIT;
 		reg_temp_crit_l = NCT6106_REG_TEMP_CRIT_L;
@@ -3669,6 +3671,7 @@ int nct6775_probe(struct device *dev, struct nct6775_data *data,
 		reg_temp_over = NCT6106_REG_TEMP_OVER;
 		reg_temp_hyst = NCT6106_REG_TEMP_HYST;
 		reg_temp_config = NCT6106_REG_TEMP_CONFIG;
+		num_reg_temp_config = ARRAY_SIZE(NCT6106_REG_TEMP_CONFIG);
 		reg_temp_alternate = NCT6106_REG_TEMP_ALTERNATE;
 		reg_temp_crit = NCT6106_REG_TEMP_CRIT;
 		reg_temp_crit_l = NCT6106_REG_TEMP_CRIT_L;
@@ -3746,6 +3749,7 @@ int nct6775_probe(struct device *dev, struct nct6775_data *data,
 		reg_temp_over = NCT6775_REG_TEMP_OVER;
 		reg_temp_hyst = NCT6775_REG_TEMP_HYST;
 		reg_temp_config = NCT6775_REG_TEMP_CONFIG;
+		num_reg_temp_config = ARRAY_SIZE(NCT6775_REG_TEMP_CONFIG);
 		reg_temp_alternate = NCT6775_REG_TEMP_ALTERNATE;
 		reg_temp_crit = NCT6775_REG_TEMP_CRIT;
 
@@ -3821,6 +3825,7 @@ int nct6775_probe(struct device *dev, struct nct6775_data *data,
 		reg_temp_over = NCT6775_REG_TEMP_OVER;
 		reg_temp_hyst = NCT6775_REG_TEMP_HYST;
 		reg_temp_config = NCT6776_REG_TEMP_CONFIG;
+		num_reg_temp_config = ARRAY_SIZE(NCT6776_REG_TEMP_CONFIG);
 		reg_temp_alternate = NCT6776_REG_TEMP_ALTERNATE;
 		reg_temp_crit = NCT6776_REG_TEMP_CRIT;
 
@@ -3900,6 +3905,7 @@ int nct6775_probe(struct device *dev, struct nct6775_data *data,
 		reg_temp_over = NCT6779_REG_TEMP_OVER;
 		reg_temp_hyst = NCT6779_REG_TEMP_HYST;
 		reg_temp_config = NCT6779_REG_TEMP_CONFIG;
+		num_reg_temp_config = ARRAY_SIZE(NCT6779_REG_TEMP_CONFIG);
 		reg_temp_alternate = NCT6779_REG_TEMP_ALTERNATE;
 		reg_temp_crit = NCT6779_REG_TEMP_CRIT;
 
@@ -4034,6 +4040,7 @@ int nct6775_probe(struct device *dev, struct nct6775_data *data,
 		reg_temp_over = NCT6779_REG_TEMP_OVER;
 		reg_temp_hyst = NCT6779_REG_TEMP_HYST;
 		reg_temp_config = NCT6779_REG_TEMP_CONFIG;
+		num_reg_temp_config = ARRAY_SIZE(NCT6779_REG_TEMP_CONFIG);
 		reg_temp_alternate = NCT6779_REG_TEMP_ALTERNATE;
 		reg_temp_crit = NCT6779_REG_TEMP_CRIT;
 
@@ -4123,6 +4130,7 @@ int nct6775_probe(struct device *dev, struct nct6775_data *data,
 		reg_temp_over = NCT6798_REG_TEMP_OVER;
 		reg_temp_hyst = NCT6798_REG_TEMP_HYST;
 		reg_temp_config = NCT6779_REG_TEMP_CONFIG;
+		num_reg_temp_config = ARRAY_SIZE(NCT6779_REG_TEMP_CONFIG);
 		reg_temp_alternate = NCT6798_REG_TEMP_ALTERNATE;
 		reg_temp_crit = NCT6798_REG_TEMP_CRIT;
 
@@ -4204,7 +4212,8 @@ int nct6775_probe(struct device *dev, struct nct6775_data *data,
 				  = reg_temp_crit[src - 1];
 			if (reg_temp_crit_l && reg_temp_crit_l[i])
 				data->reg_temp[4][src - 1] = reg_temp_crit_l[i];
-			data->reg_temp_config[src - 1] = reg_temp_config[i];
+			if (i < num_reg_temp_config)
+				data->reg_temp_config[src - 1] = reg_temp_config[i];
 			data->temp_src[src - 1] = src;
 			continue;
 		}
@@ -4217,7 +4226,8 @@ int nct6775_probe(struct device *dev, struct nct6775_data *data,
 		data->reg_temp[0][s] = reg_temp[i];
 		data->reg_temp[1][s] = reg_temp_over[i];
 		data->reg_temp[2][s] = reg_temp_hyst[i];
-		data->reg_temp_config[s] = reg_temp_config[i];
+		if (i < num_reg_temp_config)
+			data->reg_temp_config[s] = reg_temp_config[i];
 		if (reg_temp_crit_h && reg_temp_crit_h[i])
 			data->reg_temp[3][s] = reg_temp_crit_h[i];
 		else if (reg_temp_crit[src - 1])
-- 
2.43.0




