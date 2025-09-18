Return-Path: <stable+bounces-175701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F197B36957
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EDB21C41C6E
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50468350843;
	Tue, 26 Aug 2025 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0gyO0DBQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF2531985C;
	Tue, 26 Aug 2025 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217741; cv=none; b=NkgaACJ9TpqutOiBHeDcLY8RVJNSaTYCqerxE7zO/UwMhujl54lc6xzdYyN0AoyudrAdwNfdZWhCYkjUAYGDKm8Y7OIxd3Kqm1yTuyDM+Vk53RLQPa2E82bl4Xq6EntGN09A6GnxiD5GVI/eIDZdWBThWs4JqhHBXYRDZXZ1wcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217741; c=relaxed/simple;
	bh=qHq9knWVnaQREi5Frzkf8oKU3YLvhj72B+fU3MAsctk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPhmHa95U9alSl20hVYgzjPA4uyOa31uzxfSzgNymbY0gY8cwARbA5k+UBat06kAmeaBDpVXKfjixUL6lFtqZvdfwUApHxMjNZ8+/g9eWAtV7BELB1PGv5tm7sd5dV+MK/AUWMV8aBvQC9Bjs8cvL9YtrRberRTJPOEc5qWQ4Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0gyO0DBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BB8C4CEF1;
	Tue, 26 Aug 2025 14:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756217740;
	bh=qHq9knWVnaQREi5Frzkf8oKU3YLvhj72B+fU3MAsctk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0gyO0DBQl2MoFdo05DAeNEfw/K40fgLboSkfw8WurQpdx+9JD9+3LTJ3HMVNCPWNo
	 ryjxwIh8fialHMBjM3vP1RQR10MhKKbaI3Q/ktQLWrB8yDZFpqqsmWm8kFMj2YgCWa
	 oywgbrbI7CU+r25jNgN/D8O9kV/zddbhoFGAv4w8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Xinxin Wan <xinxin.wan@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 257/523] ASoC: codecs: rt5640: Retry DEVICE_ID verification
Date: Tue, 26 Aug 2025 13:07:47 +0200
Message-ID: <20250826110930.765314365@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110924.562212281@linuxfoundation.org>
References: <20250826110924.562212281@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xinxin Wan <xinxin.wan@intel.com>

[ Upstream commit 19f971057b2d7b99c80530ec1052b45de236a8da ]

To be more resilient to codec-detection failures when the hardware
powers on slowly, add retry mechanism to the device verification check.
Similar pattern is found throughout a number of Realtek codecs. Our
tests show that 60ms delay is sufficient to address readiness issues on
rt5640 chip.

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Xinxin Wan <xinxin.wan@intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://patch.msgid.link/20250530142120.2944095-3-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5640.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index a5674c227b3a..c12966025cfa 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2810,6 +2810,11 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 	}
 
 	regmap_read(rt5640->regmap, RT5640_VENDOR_ID2, &val);
+	if (val != RT5640_DEVICE_ID) {
+		usleep_range(60000, 100000);
+		regmap_read(rt5640->regmap, RT5640_VENDOR_ID2, &val);
+	}
+
 	if (val != RT5640_DEVICE_ID) {
 		dev_err(&i2c->dev,
 			"Device with ID register %#x is not rt5640/39\n", val);
-- 
2.39.5




