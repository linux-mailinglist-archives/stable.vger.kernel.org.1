Return-Path: <stable+bounces-189037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D01BFE201
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 22:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F14DC4E9DFE
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 20:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305E62F9984;
	Wed, 22 Oct 2025 20:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x0/W+Sw7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A042F83C2
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163818; cv=none; b=hsKRGL1hZ8OngaXP4vioSLPADbrvQB/+f65q8kZGiIQCw/v0/sP5FdyNmJ24hgmfkqyV8AqxsAepHRhmfWAI2KVtP1NqXtb4BfyryjxNQQBr1MypYX5rY+wfE6HYgUM5Mb0R+W+PoD6vwmzqrWyXY52x41qfYGRshaSzAMF2I8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163818; c=relaxed/simple;
	bh=jL1xyKeY+DSl7FnGn5fIu9UTUzTUBfMaCWMbOzVyaiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UHSB0P6MV4ApOdyqKdPodH98au/MfHRF9fz3sKGvMDP5iuQYxtRHbxAt7/sV/sc+dgGEIkZ5qExnfrLJslVNs9qH4A4vAYaff7LXtj3YuWlBCAGLW5VB6fBRIOfax2+wjqF5Px2UVRHoHZObbSUWJp1nLgR1GaWhYP8zS3kUviM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x0/W+Sw7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-475c9881821so1446245e9.0
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 13:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761163814; x=1761768614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CMO+68yA0NJP1unpK3WFsi9ClsA9S0hkHZBERZCyzFs=;
        b=x0/W+Sw7IeyhYqPazvetiAgzrtGlYSD1Q/885UKNowuBEW3JnNqnQA1pMbCqSYX0OQ
         r0EfPfq8wLF4I0fPWcZkaScuuLow6/X1zaBqbGaDR+GS36F2PjvxTNqDXIMdCw+Nl+ip
         tXaYKBepDZNrlJs8I0W6RpZBIryVpuvLR7mYGJZM3WZufoGmWQ1AKOFgM4avQP51joZf
         iqsZpceizRnsnKiCNwLeDsU13SRlc7DOZV1vFEzRVS0wzVQtRer0+TS6TfMh0MFPs0re
         y8u7FIBBO06FUJbkF4HdRWa9Xc9y7X0ric0/Hx5vdg8THOddammCyALxQ3q5WtRMb0OQ
         stpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761163814; x=1761768614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMO+68yA0NJP1unpK3WFsi9ClsA9S0hkHZBERZCyzFs=;
        b=E5iPKIM2voui+MPZ15FVoyJ/lwXKonQSUiu7/6Fr6pFXdxHOnlJj+MOK3ul9aVcUvl
         jLDgvM0vpyUmH3BwRRJkp4lhDSz9iPz/1yASsB8k8ssEFcHVijitRif3p9nYBpw6TFWR
         KHsZSqOH7jk/ns3BXOUiwtbAHdFeomZ41zbvfTDPbcTzA47jFNZ2JXmXevJZwnPwgYiF
         EubOBnMVU6DQbEpSnzyHiYM2idAjThmBGd0Ma2a+X6EspiRCeOvscfcxlPQy7L0XZl/J
         BUSRsmJfNe9QJ2MBXiq5AW5Pk6TCFCPxqnnGmIIsAxQlTgVObVyJQvYPOim1fapC99wh
         rwMw==
X-Forwarded-Encrypted: i=1; AJvYcCUfWqFK2y1fXlQgYojyATmqWlUAZiTrcutQplwZ/Q3iVyGXgSNYB4YQTsVH6MAX6q+jH6YoS28=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCkkY3UUrXPENuIFUJ/EPFTbB4rmoiQqsZoEL7tMnWDFms9xik
	XWeRQ6Mqd7igSUy2qV+iHdiEU5EWmyUwcKb15Dq9Owz8vfk+IGoWP6psK0JbvSnPC/M=
X-Gm-Gg: ASbGncvu4afT234VwiEnf12URRLwxc/gKZezCu7VRr+XmZSl2loBAiaBOjosWBcg64F
	LX/U0Rvlyviotat6mPC3MDWGG1gKPjVktMFjhUErOujQlF0xlVnkWQJsIY7zjZ6tG/mPvePyo8f
	DNuqOcDYlxINakstXBAQb3/o/L1lHnTDKylQpJ8iOMANJEUVEuguBU9G0shwCR8k2c6RFZLKr8y
	/C4Ht+QXGXzEz5PVB6iUG7zilogbBDGFrfBr8S4Ti44aRVTbHIUpjJ10hDYwaKmtJhhRKA+bXAb
	hrJiLtBhQUZIN2V1QR4V1RR4y6lAb2MVyjDPPz5oJOT/8x0A+ZV/LVVhSH2Q9UPTVVm+uG2B4OY
	cG1O3UNrlhsc8pP6RweZ96q6RcH1g4xGCHbSjxPvIj3b0Vl4hAyVtZaEI/T4YkssqaOjmhWA1Yo
	xXV+jQv6K6OkeFvcjE
X-Google-Smtp-Source: AGHT+IEE7nbdHtxCgzExX95o6DoJe0s0AWHwSyXzENCSmPhw5KThK31EPdJRY52brcU+d9kt2XaOCg==
X-Received: by 2002:a05:600c:c3:b0:46f:cdfe:cd39 with SMTP id 5b1f17b1804b1-475c6f69890mr15544315e9.16.1761163814335;
        Wed, 22 Oct 2025 13:10:14 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:11f4:2b3f:7c5a:5c10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caa8c785sm415275e9.14.2025.10.22.13.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 13:10:13 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: broonie@kernel.org,
	gregkh@linuxfoundation.org,
	srini@kernel.org
Cc: rafael@kernel.org,
	dakr@kernel.org,
	make24@iscas.ac.cn,
	steev@kali.org,
	dmitry.baryshkov@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	abel.vesa@linaro.org,
	stable@vger.kernel.org
Subject: [PATCH v2] regmap: slimbus: fix bus_context pointer in regmap init calls
Date: Wed, 22 Oct 2025 21:10:12 +0100
Message-ID: <20251022201013.1740211-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4e65bda8273c ("ASoC: wcd934x: fix error handling in
wcd934x_codec_parse_data()") revealed the problem in the slimbus regmap.
That commit breaks audio playback, for instance, on sdm845 Thundercomm
Dragonboard 845c board:

 Unable to handle kernel paging request at virtual address ffff8000847cbad4
 ...
 CPU: 5 UID: 0 PID: 776 Comm: aplay Not tainted 6.18.0-rc1-00028-g7ea30958b305 #11 PREEMPT
 Hardware name: Thundercomm Dragonboard 845c (DT)
 ...
 Call trace:
  slim_xfer_msg+0x24/0x1ac [slimbus] (P)
  slim_read+0x48/0x74 [slimbus]
  regmap_slimbus_read+0x18/0x24 [regmap_slimbus]
  _regmap_raw_read+0xe8/0x174
  _regmap_bus_read+0x44/0x80
  _regmap_read+0x60/0xd8
  _regmap_update_bits+0xf4/0x140
  _regmap_select_page+0xa8/0x124
  _regmap_raw_write_impl+0x3b8/0x65c
  _regmap_bus_raw_write+0x60/0x80
  _regmap_write+0x58/0xc0
  regmap_write+0x4c/0x80
  wcd934x_hw_params+0x494/0x8b8 [snd_soc_wcd934x]
  snd_soc_dai_hw_params+0x3c/0x7c [snd_soc_core]
  __soc_pcm_hw_params+0x22c/0x634 [snd_soc_core]
  dpcm_be_dai_hw_params+0x1d4/0x38c [snd_soc_core]
  dpcm_fe_dai_hw_params+0x9c/0x17c [snd_soc_core]
  snd_pcm_hw_params+0x124/0x464 [snd_pcm]
  snd_pcm_common_ioctl+0x110c/0x1820 [snd_pcm]
  snd_pcm_ioctl+0x34/0x4c [snd_pcm]
  __arm64_sys_ioctl+0xac/0x104
  invoke_syscall+0x48/0x104
  el0_svc_common.constprop.0+0x40/0xe0
  do_el0_svc+0x1c/0x28
  el0_svc+0x34/0xec
  el0t_64_sync_handler+0xa0/0xf0
  el0t_64_sync+0x198/0x19c

The __devm_regmap_init_slimbus() started to be used instead of
__regmap_init_slimbus() after the commit mentioned above and turns out
the incorrect bus_context pointer (3rd argument) was used in
__devm_regmap_init_slimbus(). It should be just "slimbus" (which is equal
to &slimbus->dev). Correct it. The wcd934x codec seems to be the only or
the first user of devm_regmap_init_slimbus() but we should fix it till
the point where __devm_regmap_init_slimbus() was introduced therefore
two "Fixes" tags.

While at this, also correct the same argument in __regmap_init_slimbus().

Fixes: 4e65bda8273c ("ASoC: wcd934x: fix error handling in wcd934x_codec_parse_data()")
Fixes: 7d6f7fb053ad ("regmap: add SLIMbus support")
Cc: stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Ma Ke <make24@iscas.ac.cn>
Cc: Steev Klimaszewski <steev@kali.org>
Cc: Srinivas Kandagatla <srini@kernel.org>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---

The patch/fix is for the current 6.18 development cycle
since it fixes the regression introduced in 6.18.0-rc1.

Changes in v2:
 - &slimbus->dev replaced with just "slimbus", no functional change
 (as suggested by Dmitry);
 - the same argument in __regmap_init_slimbus() was replaced with
 "slimbus" (as suggested by Dmitry);
 - reduced the backtrace log in the commit message (as suggested by Mark);
 - corrected subject/title, few typos, added mention of non-managed init
 func change, rephrased smth;
 - added Reviewed-by tag from Abel.

Prev version: https://lore.kernel.org/linux-sound/20251020015557.1127542-1-alexey.klimov@linaro.org/

 drivers/base/regmap/regmap-slimbus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-slimbus.c b/drivers/base/regmap/regmap-slimbus.c
index 54eb7d227cf4..e523fae73004 100644
--- a/drivers/base/regmap/regmap-slimbus.c
+++ b/drivers/base/regmap/regmap-slimbus.c
@@ -48,8 +48,7 @@ struct regmap *__regmap_init_slimbus(struct slim_device *slimbus,
 	if (IS_ERR(bus))
 		return ERR_CAST(bus);
 
-	return __regmap_init(&slimbus->dev, bus, &slimbus->dev, config,
-			     lock_key, lock_name);
+	return __regmap_init(&slimbus->dev, bus, slimbus, config, lock_key, lock_name);
 }
 EXPORT_SYMBOL_GPL(__regmap_init_slimbus);
 
@@ -63,8 +62,7 @@ struct regmap *__devm_regmap_init_slimbus(struct slim_device *slimbus,
 	if (IS_ERR(bus))
 		return ERR_CAST(bus);
 
-	return __devm_regmap_init(&slimbus->dev, bus, &slimbus, config,
-				  lock_key, lock_name);
+	return __devm_regmap_init(&slimbus->dev, bus, slimbus, config, lock_key, lock_name);
 }
 EXPORT_SYMBOL_GPL(__devm_regmap_init_slimbus);
 
-- 
2.47.3


