Return-Path: <stable+bounces-172487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A325B321FD
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 20:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D45B67009
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 18:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726131FF7D7;
	Fri, 22 Aug 2025 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0swaV6I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3172C2BDC23
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 18:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755886093; cv=none; b=SflfO94ZgDFY0qMOX+PAe+B7ae9CJ85tjbR3CGXnIEs0v/ww3+tkGgTP7MXLH7Q//mxyiMIRPFp6upxWnlagify9rNsq+Oo2G3iwfCSY4k6m5wCmJgy8OYJcOezlaOjubQI7/r9S9PsmjgWy3zeTJGQ2MuJf9CR2VcN2krPio0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755886093; c=relaxed/simple;
	bh=EC9crYst2Lu8Yp/52FWswrWKIkDOwGIiGQBp3yWW5u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOhspRXN+knYKth+MJ/XGQX4fxnxekwoOdD5bWCRz8xK2yCaB4EUyHn+Ham0nlekaVBhhEALFW2/8lHSJhK2UXWk6rmGpCFaR9vilWZiQBAZTrtK+26dLP+OqBuxL2e4hzcyZcE1nacIW2KXkvKOHdrRM4hdiVCfRizdHANZA34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0swaV6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317CAC4CEED;
	Fri, 22 Aug 2025 18:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755886092;
	bh=EC9crYst2Lu8Yp/52FWswrWKIkDOwGIiGQBp3yWW5u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J0swaV6IuslUDFxnpy9bqBDdGXiPfnitO49c9AYkJMBnaAAqq9JH568F1TG2aWr/4
	 dRaIRTI1bvfaZ9tmqW9bj+r4DeIInl9I+ceiOHkfwEipJBITF/F0YRpv+8AbwvGh9+
	 8tcKY8ybht+4Ej7vQePCT7kx5Vs/GZ4X6Y9aV3JC6WlugVyvYtLhdOFuwmyyDfIo95
	 Muuo29tMNCfkGpBJK8oxlJecRqdJWFhXy1xgZei78j9CJt0MQOaMlYT5Ak3G+X/qni
	 04V2B6u/APpFL6mkaQ3SVxVDzbk7xxl+n99jsgNVSi5yYq8oxY9WtirQGemPPKA4pm
	 O7q1pBUnHvArQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: adc: ad7173: fix setting ODR in probe
Date: Fri, 22 Aug 2025 14:08:10 -0400
Message-ID: <20250822180810.1356484-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082135-slept-video-cdcc@gregkh>
References: <2025082135-slept-video-cdcc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Lechner <dlechner@baylibre.com>

[ Upstream commit 6fa908abd19cc35c205f343b79c67ff38dbc9b76 ]

Fix the setting of the ODR register value in the probe function for
AD7177. The AD7177 chip has a different ODR value after reset than the
other chips (0x7 vs. 0x0) and 0 is a reserved value on that chip.

The driver already has this information available in odr_start_value
and uses it when checking valid values when writing to the
sampling_frequency attribute, but failed to set the correct initial
value in the probe function.

Fixes: 37ae8381ccda ("iio: adc: ad7173: add support for additional models")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250710-iio-adc-ad7173-fix-setting-odr-in-probe-v1-1-78a100fec998@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad7173.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 2eebc6f761a6..19b583e00753 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -1243,6 +1243,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan_st_priv->cfg.bipolar = false;
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
+		chan_st_priv->cfg.odr = st->info->odr_start_value;
 		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
 
 		chan_index++;
@@ -1307,7 +1308,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan->channel = ain[0];
 		chan_st_priv->chan_reg = chan_index;
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
-		chan_st_priv->cfg.odr = 0;
+		chan_st_priv->cfg.odr = st->info->odr_start_value;
 
 		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");
 		if (chan_st_priv->cfg.bipolar)
-- 
2.50.1


