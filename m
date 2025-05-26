Return-Path: <stable+bounces-146339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 822F2AC3D3D
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 11:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF10D3B3B5B
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 09:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B621F4262;
	Mon, 26 May 2025 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kluBaCCM"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861D11E47C7
	for <stable@vger.kernel.org>; Mon, 26 May 2025 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748252835; cv=none; b=Ustbaw1Jr3tBDdqskUymQQdoLVfOUj4KNrU4Cn/GPSfathEOk3GA3EjDXyhs45mxRwFICpMTMYYw8+LHtDA2SQUDnu1bPou/Kjj9ESuGrB45CshgQ0lfElVtV0F6t21rgv6oEj2qmm3qLzcV0jHBzoZ9gpqiQm75ZtQoCIrs8aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748252835; c=relaxed/simple;
	bh=yW+lzGrBHFbCZuynhHylQaKFrss+eF7xeqrzeY4Gh7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QBD3LV0JJ455HSiNBy/98k/oMcvpz1/pxUCMZPOE2aVSd0S8v3uYh2G7jq3Cfgnlq+EvvEEEQqtHGXJYR+e7GFYHQ7q9Li1k/EIdKeSrk+STs6PkCXRHFlqTtYC/vD1anskZjt7PAbDBzvBW6hpjYbgUcttQhFTf3UCIlp/qU+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kluBaCCM; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5fa828b4836so314595a12.2
        for <stable@vger.kernel.org>; Mon, 26 May 2025 02:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748252831; x=1748857631; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fAZVyD8nLejv+dB2iGsn12fr15PTc/vSHjJT53bWPAM=;
        b=kluBaCCMak3UcFbm9dxrzkyZmOGiFuIQiN4A3nRYE5Wo4DUcaAgI7hzSQ3TBHfMwCA
         sEpzfJyamUfoewwtnVtVYMn2mdq+b2OBmDrb4H7q4DLJVsBJFkIokgm71I7vSrdtUCei
         Yf7epeu3Z7ckEVA9G/oTsbn6khCjcmpz9OTqXdhHq54dk/ATPF6/yzq/IPNrDrB7UBuf
         NsQtMS4O9B4ughUc2kqhheUi+9dIPSQ8gD/FBBcy9mEnhKhVyxKsOHRm7anEtp/1BcpZ
         0CqVbRrEjHd4iYojCJbBzTNWquuBlrry9ueGWr/+3UX4nI9TlUxcFdoFVFWd9XKfNJTo
         xMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748252831; x=1748857631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAZVyD8nLejv+dB2iGsn12fr15PTc/vSHjJT53bWPAM=;
        b=bWWqQp7VaP3U7zZQxZ1xqS/nWEggkj4CqxkOpCtkq7SygCN5DfrxCb5Tt9MWYZDKZ6
         jzlL4s5XqZeS4zlOh13pfnDK5oDeZfhsO098twYfjGR+1HEsxrQWmf5ZPqgTnsbGQgcD
         luAAUgnW7m7zvn5yHnFO9DDBauLcyM+hmWWdFg+/OD2KQEpnT6lUKRowVv6+hI8IWCl2
         kPhwBdcmZKO6B5xOhf32zdFDWusb8k22M8F4/2qTPjcF4TBkwEDmIUHGh7aatocV0YD7
         Ls02fw4s/Ghod+YLJxrl391HMllo8cinsVXRB4O902o1WBv67pItGz1GrC37TUvufMEE
         5+8A==
X-Forwarded-Encrypted: i=1; AJvYcCXyvmseMZJK04bUHSMn7NR8TzjRZiLDftxDP1m2RfdgN9Uxjqnt4cpJydhJj+lDugbVK0SKyZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfolmm1c2jBS1tN1pHYrALvJoSDZaLy+tsnq/Avznst4CV8VSD
	OMMB1lG02V2Ny9G1FisNgGZYnlJuhHH7faL7dKAJCrFNyaSn60aj9P+1R5X1tTYD4sY/ZFxVC7M
	rimSj
X-Gm-Gg: ASbGncu/Aq0854zhkcwLz//i7i1nXZOD0OkZoR8UPXVv/CQHoYC4BhPSLhY2QjX0KGr
	GzWAH3bFjMCQx0bGiX68MUMHgrNCOgRV1YSbqS2C8QFAm3V5mbHOixEAiPx748j8KxKl18BGxiJ
	OPsTW6fCSkZ4xGgb+wdJrjllDWd+tHwIcOAo7M8qtij0ga8YRq5g+M7qKNzt2oKR2muu/QSjiGH
	HqgWGUAP7k6PherS4PG9NakbWbh5IiqZZ/7FDTO0RTgWIkpFfI3UIs7pjV2PpbkGqiJDVLi+azw
	c588Yfp8Hff1UDkFBMoGUnNJrJpSJeoIU1D1X8Jq5EgLgElF9zooCoJskPNmMzG5vMJ2oiM=
X-Google-Smtp-Source: AGHT+IE08nBeINi9bzH0RFLrXFLcP2pZ6ple+DY12qw1tSMqI7k7yqjWGEAFPZqPtJ0gqM/FV3JHwA==
X-Received: by 2002:a05:6402:354f:b0:5f6:c5e3:faa0 with SMTP id 4fb4d7f45d1cf-602db3b4ebdmr2818936a12.10.1748252831299;
        Mon, 26 May 2025 02:47:11 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6049d482cc7sm1486427a12.19.2025.05.26.02.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 02:47:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 26 May 2025 11:47:01 +0200
Subject: [PATCH 1/3] ASoC: codecs: wcd9335: Fix missing free of regulator
 supplies
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250526-b4-b4-asoc-wcd9395-vdd-px-fixes-v1-1-0b8a2993b7d3@linaro.org>
References: <20250526-b4-b4-asoc-wcd9395-vdd-px-fixes-v1-0-0b8a2993b7d3@linaro.org>
In-Reply-To: <20250526-b4-b4-asoc-wcd9395-vdd-px-fixes-v1-0-0b8a2993b7d3@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Vinod Koul <vkoul@kernel.org>, Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2678;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=yW+lzGrBHFbCZuynhHylQaKFrss+eF7xeqrzeY4Gh7w=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoNDiZVUjOu00z65ZdGdWgoOvgj6MWG6QuPFcRI
 uoGQ61XyjeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaDQ4mQAKCRDBN2bmhouD
 11PDD/4hHos24HAAdgoQUdwzReUuAHWBaP6+UBZHkLMxHIf0Iy3EhDSZAuyoz2/YyBwgD+7DZoY
 oI+Bv0N/XfBHGlpaBauERGcubz3iPud4RfdPI+IgUnbE5nVgZFdmbauTOphrVBHGs6IsZfpvxx2
 NnQ8LAOKWj32tFfFgA74egDTzcqW5AuzyyYmRwhV39nEhnh3XT3iOeO4/TNvShGYYAEhcHn0DeA
 A5ebV3FXEKrpahdxw/woyqJPH/j7cOW2GVzI8Z4ERfSUSEhOECEl/H06RNU3upPNAu0WR/EAR17
 6tOV9d5TEAGwkP/YljJfjKTDmD6mZEe0BS0Z1VaWczIuJm9kl2LHKwk2yj912vCzbFcdkhio20c
 y2phNAjT3c4mmnsQqjGaZjljkMjFy6t1amcwkfFGs46CRz4ui6WUtU9J6FlVglGCgx9prHo8C18
 f40tTh6GeHSBfihEL5HyZbN2VVRc748DdKVQcdnRsphK9uF1IidyLseZpDCLwisQbPD7pNCoQy5
 j8c2P5+0XxzvlgALq/XrBD//sFyXtMc99pau9wO1RovJwnuWpxOYJLay3Rk6Pm5FOQ7DEhdXJ/t
 osuxTMVX14+yfGXx1HKplVUI4BjTdOfHgddZlpQFrYbtsfmLSE2CwHAzCJuu0faVr9ZaWMDu/XA
 HNjoOOxq1DcKatQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver gets and enables all regulator supplies in probe path
(wcd9335_parse_dt() and wcd9335_power_on_reset()), but does not cleanup
in final error paths and in unbind (missing remove() callback).  This
leads to leaked memory and unbalanced regulator enable count during
probe errors or unbind.

Fix this by converting entire code into devm_regulator_bulk_get_enable()
which also greatly simplifies the code.

Fixes: 20aedafdf492 ("ASoC: wcd9335: add support to wcd9335 codec")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd9335.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 8ee4360aff9293178e338e3ef300c37f6f2ac809..5e19e813748dfa0d065287494240007d60478dea 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -332,7 +332,6 @@ struct wcd9335_codec {
 
 	int intr1;
 	struct gpio_desc *reset_gpio;
-	struct regulator_bulk_data supplies[WCD9335_MAX_SUPPLY];
 
 	unsigned int rx_port_value[WCD9335_RX_MAX];
 	unsigned int tx_port_value[WCD9335_TX_MAX];
@@ -355,6 +354,10 @@ struct wcd9335_irq {
 	char *name;
 };
 
+static const char * const wcd9335_supplies[] = {
+	"vdd-buck", "vdd-buck-sido", "vdd-tx", "vdd-rx", "vdd-io",
+};
+
 static const struct wcd9335_slim_ch wcd9335_tx_chs[WCD9335_TX_MAX] = {
 	WCD9335_SLIM_TX_CH(0),
 	WCD9335_SLIM_TX_CH(1),
@@ -4989,30 +4992,16 @@ static int wcd9335_parse_dt(struct wcd9335_codec *wcd)
 	if (IS_ERR(wcd->native_clk))
 		return dev_err_probe(dev, PTR_ERR(wcd->native_clk), "slimbus clock not found\n");
 
-	wcd->supplies[0].supply = "vdd-buck";
-	wcd->supplies[1].supply = "vdd-buck-sido";
-	wcd->supplies[2].supply = "vdd-tx";
-	wcd->supplies[3].supply = "vdd-rx";
-	wcd->supplies[4].supply = "vdd-io";
-
-	ret = regulator_bulk_get(dev, WCD9335_MAX_SUPPLY, wcd->supplies);
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(wcd9335_supplies),
+					     wcd9335_supplies);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to get supplies\n");
+		return dev_err_probe(dev, ret, "Failed to get and enable supplies\n");
 
 	return 0;
 }
 
 static int wcd9335_power_on_reset(struct wcd9335_codec *wcd)
 {
-	struct device *dev = wcd->dev;
-	int ret;
-
-	ret = regulator_bulk_enable(WCD9335_MAX_SUPPLY, wcd->supplies);
-	if (ret) {
-		dev_err(dev, "Failed to get supplies: err = %d\n", ret);
-		return ret;
-	}
-
 	/*
 	 * For WCD9335, it takes about 600us for the Vout_A and
 	 * Vout_D to be ready after BUCK_SIDO is powered up.

-- 
2.45.2


