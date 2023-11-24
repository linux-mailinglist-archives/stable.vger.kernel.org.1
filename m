Return-Path: <stable+bounces-447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 889757F7B1E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15C351F20EF8
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6A839FE3;
	Fri, 24 Nov 2023 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJg5E7Mz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AB719BE
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 10:01:40 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5482df11e73so2979710a12.0
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 10:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700848899; x=1701453699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nMxbVR2rLfAZt5vPU+lVR4wGuvIRl6WENNaqc0E73kg=;
        b=OJg5E7MzJPj/XknQ1CDmY8DoUtfbmvTequeSFNmbX5G5XmluhYnnB50gct0FfoiwU8
         5k7Izwn6ae8L+CQqdwDxiK5D13fV0AdjTb2gtsrdaGNqM4KvCw9ru75MhZonj5jt1cnQ
         8DnkN+5+RSfbT3haFXkzS7AG5kwSd6P4D106WG2RrMm3aWCPpBuSRKM1b6mmhze4EE5F
         ydx6qvrydOLUCNOofQszOrH7R5oAOKlvrTqgPAhZLVvjpCsbr5+BguimVhFFalWcVtJS
         oX+M4uDhNz+CqA0/ZWYmbc6AlgqXZURT9b8vXHc7qX4Bthltt5jb1mZpFtCOMx9/bH50
         fv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700848899; x=1701453699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMxbVR2rLfAZt5vPU+lVR4wGuvIRl6WENNaqc0E73kg=;
        b=d6ozMyzWQk7/Y/p610myM/zPGEfzXM1iB+/7P4uM8maEthJbpbatFgyAiS4K1PyIIW
         IgzWBvC2Ge5kNofQcAJdBH/kD6IrMoKMwLbh+ZAlmJGu5YqaFceN1cbiXurn6OY3yd02
         RN1Tve1f/QjKPX4s2l3L+rBkny/wavzFr+HXDKqKTy4O+WHnMrREaWzJW7/+H3E2udZE
         a0TnVUcGoAaT58FegYDSazS2QW/AJZBW7h9Jbp6PDNuzEXXMPlc8E4pUjCeh4nqzmct9
         7EnCgrAtPD1FnOd3xUcppJjo+BD1y5aruIv+xf3s0fVGnBeUvZv9brJqnc9xsb4hSaD/
         QbjA==
X-Gm-Message-State: AOJu0Yw2ffl6MkEk8eX8R5Qel9yWKL65gkYBfKYCT1LEcgq2I7q8/1vp
	34wQaGMkblLXqAMZppMonbqdXQ==
X-Google-Smtp-Source: AGHT+IHsz3LcGDH3Rt86rCdvS80rKeIS5a4qh2ZQvdfnBPgmrONEFonUhMa3/w580MfYUG2pVVWF3Q==
X-Received: by 2002:a50:c042:0:b0:543:bf55:248b with SMTP id u2-20020a50c042000000b00543bf55248bmr2619735edd.13.1700848899134;
        Fri, 24 Nov 2023 10:01:39 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id bq2-20020a056402214200b00548a0e8c316sm2010965edb.20.2023.11.24.10.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 10:01:38 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Shreyas NC <shreyas.nc@intel.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] soundwire: stream: fix NULL pointer dereference for multi_link
Date: Fri, 24 Nov 2023 19:01:36 +0100
Message-Id: <20231124180136.390621-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If bus is marked as multi_link, but number of masters in the stream is
not higher than bus->hw_sync_min_links (bus->multi_link && m_rt_count >=
bus->hw_sync_min_links), bank switching should not happen.  The first
part of do_bank_switch() code properly takes these conditions into
account, but second part (sdw_ml_sync_bank_switch()) relies purely on
bus->multi_link property.  This is not balanced and leads to NULL
pointer dereference:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  ...
  Call trace:
   wait_for_completion_timeout+0x124/0x1f0
   do_bank_switch+0x370/0x6f8
   sdw_prepare_stream+0x2d0/0x438
   qcom_snd_sdw_prepare+0xa0/0x118
   sm8450_snd_prepare+0x128/0x148
   snd_soc_link_prepare+0x5c/0xe8
   __soc_pcm_prepare+0x28/0x1ec
   dpcm_be_dai_prepare+0x1e0/0x2c0
   dpcm_fe_dai_prepare+0x108/0x28c
   snd_pcm_do_prepare+0x44/0x68
   snd_pcm_action_single+0x54/0xc0
   snd_pcm_action_nonatomic+0xe4/0xec
   snd_pcm_prepare+0xc4/0x114
   snd_pcm_common_ioctl+0x1154/0x1cc0
   snd_pcm_ioctl+0x54/0x74

Fixes: ce6e74d008ff ("soundwire: Add support for multi link bank switch")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/stream.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 9dc6399f206a..f9c0adc0738d 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -742,14 +742,15 @@ static int sdw_bank_switch(struct sdw_bus *bus, int m_rt_count)
  * sdw_ml_sync_bank_switch: Multilink register bank switch
  *
  * @bus: SDW bus instance
+ * @multi_link: whether this is a multi-link stream with hardware-based sync
  *
  * Caller function should free the buffers on error
  */
-static int sdw_ml_sync_bank_switch(struct sdw_bus *bus)
+static int sdw_ml_sync_bank_switch(struct sdw_bus *bus, bool multi_link)
 {
 	unsigned long time_left;
 
-	if (!bus->multi_link)
+	if (!multi_link)
 		return 0;
 
 	/* Wait for completion of transfer */
@@ -847,7 +848,7 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
 			bus->bank_switch_timeout = DEFAULT_BANK_SWITCH_TIMEOUT;
 
 		/* Check if bank switch was successful */
-		ret = sdw_ml_sync_bank_switch(bus);
+		ret = sdw_ml_sync_bank_switch(bus, multi_link);
 		if (ret < 0) {
 			dev_err(bus->dev,
 				"multi link bank switch failed: %d\n", ret);
-- 
2.34.1


