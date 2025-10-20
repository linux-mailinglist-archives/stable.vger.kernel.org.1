Return-Path: <stable+bounces-187914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DD0BEF0A5
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 03:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 91D6A3487C5
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 01:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3249C1E32B9;
	Mon, 20 Oct 2025 01:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZtLLZYXC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B1D1ACED7
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 01:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760925364; cv=none; b=gaAbFz/nb3lRKOcMb9RZBvFf7fF9Me1/ULJsBySCr7JhS7qSwWXDT6IETzziQE8f9XFrnEAZMKU/lHfwmbwLB2YJQCuxY+3eOGoyy7SR8xUTSjoxAXRZLENkLWvCIwqI/XpB6T7BtpT84oxSYH/0JfduZEap9QTV17SpbA3nL58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760925364; c=relaxed/simple;
	bh=FhzgS1/MGPIfdcjIr19V6Zpkv9/EfeIlF628IPVhrec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tYTw1KoMtsbc4JJDM6vfihaELnsBtkLlW2kYEz2u6MuXQo4MnJAgjdFkcD6eeiHj6v5YJ40Pa0rY8VTl/Uj+WuZAejlLO0SLiLuLPSEFafPfsy9rPZJhgVVpdF4tnnxLPELRbAOeZzaoNGe6PyvuBxBc2nYo2e69i4oWv9KyKx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZtLLZYXC; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso3868238f8f.0
        for <stable@vger.kernel.org>; Sun, 19 Oct 2025 18:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760925359; x=1761530159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+Q06UI6PhTkJgy9be05aY/Rj5+zLhZlUFJf9K2EKUA=;
        b=ZtLLZYXCEwmFAGJ4IrUwSi2FVlzITPw5zpr2GbTDQBKg76usSjPsPQmJrB95vg843S
         hti0GW+u+0hYVdwSUxQvq9DJvHsBch/6jlnydiDkZqQNi/6qS51dWA9FkqlTAful1qLH
         xJYTousGr54EeYX+wr1G/TIKRc1cIib51qgY4u536WTqZH/UyuamjhWN+TumaZ9NPvTc
         myrdEx0LNY6EI7XMIicTE5dEElfhErz+brIrIH6bnjw6oJhpEhfxEvwxBJil7MGT1v8q
         s5+NWWuoYnSHtBtd0kxB7NqKlqTmSQxvHVO4nLFaUWMCh6E3E9TjY7qQ8bLKIpWz4iyk
         4a6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760925359; x=1761530159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+Q06UI6PhTkJgy9be05aY/Rj5+zLhZlUFJf9K2EKUA=;
        b=mNdwLox9U+z0B4II0N6xIVx2TI2c3w6p9HTYP0h4LcIUgb1XMGg28UMxAlsxMjquVI
         HMzQHM/eNrPKv9+lsvbWIH6CrBTn8uF3f+mCicIyfa2IvEcZALzIJHro1mL8XVEj0CD7
         WieMIg7gXZQff4U0mNpXDwseHIxfLqrsD9d0K1XU0MoIk5voOtjObF+YPctfrpuWx0eV
         rnEFmaxlDFZAB/SG0sRq6oGIL2h6z/NwLhRaEPPtY1LJ8ZA+OnqTqbM5EHg4696IIIbY
         xsMy/p7jBeYLLW992RTepvJxPgArWBQZnf2YkoJ6Ej6IxkCqgvjYM0JivbguVS891Stq
         V5YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtEydFjUeadg5+thYLdEKXWz+c6VQMBAcJWje2XkpbBbSc/zhOUhOnau9XeLMXNmAZw1mTuY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXuHRYx0gvGqEHtxTAg4o5eVvOk0zToN7hehWSfLfeU+XBi9ds
	cqljrSdHN2qpTjYu5qYcP7fI80bOlMnNGiv2eE7ZcnizBMZKJvbTypimvUqCuu5Vrnk=
X-Gm-Gg: ASbGnct3Hw8Be2kcXgVHPNu57LE9evHIs6p0CZF10ncyT8k1nWxXhGix558hyrywJi9
	nq88W2xbmZ8f9iNJMDuAil+/0es4ggq/wmwRdtkp+bxoUp2K/PT6pUMyql7zKSomSdBTsPV6vkz
	zDwgS5h2ERo9ibW3noaBSfgaDL81FLH1XXyAwmFxtmb3nJhoO1XYAi6BoCkfWCa6JF4AXxcuWEd
	Qc84jZIFc4/XUJbyWeiBac8QD3OtJbHBlftr1egcjL7aNix2O6jUewifCbJ9A5rojbQhhNZQw/F
	gVApMeiwS6GC5Z82VxUqbzdxfOZI8QwawwDdysH13NEz56hxl3iXRiSTQbKPCbtCKLCokhL69No
	/eaxU/6LU6peE6DJkfHncLweQF94a59t5Smv2MfhiitpMcWTi7Mn84vcKj+k1Kxgjx0zaQaH8sg
	rb6c4GJWp+RAtvbL8=
X-Google-Smtp-Source: AGHT+IG6BI0NR7Fcw8+O+sc+d7pzt0R1JZXANX7cqKWtOTX4YgRgFe1wtH43dzv/ihmHpMDqYHwKTw==
X-Received: by 2002:a05:6000:26ca:b0:428:3c66:a027 with SMTP id ffacd0b85a97d-4283c66a441mr4335994f8f.54.1760925359019;
        Sun, 19 Oct 2025 18:55:59 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:9f99:cf6:2e6a:c11f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47152959b6dsm115381535e9.7.2025.10.19.18.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 18:55:58 -0700 (PDT)
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
	stable@vger.kernel.org
Subject: [PATCH] regmap: slimbus: fix bus_context pointer in __devm_regmap_init_slimbus
Date: Mon, 20 Oct 2025 02:55:57 +0100
Message-ID: <20251020015557.1127542-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4e65bda8273c ("ASoC: wcd934x: fix error handling in
wcd934x_codec_parse_data()") revealed the problem in slimbus regmap.
That commit breaks audio playback, for instance, on sdm845 Thundercomm
Dragonboard 845c board:

 Unable to handle kernel paging request at virtual address ffff8000847cbad4
 Mem abort info:
   ESR = 0x0000000096000007
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x07: level 3 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000007, ISS2 = 0x00000000
   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
 swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000a1360000
 [ffff8000847cbad4] pgd=0000000000000000, p4d=100000010003e403, pud=100000010003f403, pmd=10000001025cf403, pte=0000000000000000
 Internal error: Oops: 0000000096000007 [#1]  SMP
 Modules linked in: (long list of modules...)
 CPU: 5 UID: 0 PID: 776 Comm: aplay Not tainted 6.18.0-rc1-00028-g7ea30958b305 #11 PREEMPT
 Hardware name: Thundercomm Dragonboard 845c (DT)
 pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : slim_xfer_msg+0x24/0x1ac [slimbus]
 lr : slim_read+0x48/0x74 [slimbus]
 sp : ffff800089113330
 x29: ffff800089113350 x28: 00000000000000c0 x27: 0000000000000268
 x26: 0000000000000198 x25: 0000000000000001 x24: 0000000000000000
 x23: 0000000000000000 x22: ffff800089113454 x21: ffff00008488e800
 x20: ffff000084b4760a x19: 0000000000000001 x18: 0000000000000be2
 x17: 0000000000000c19 x16: ffffbcef364cd260 x15: ffffbcef36dafb10
 x14: 0000000000000d38 x13: 0000000000000cb4 x12: 0000000000000c91
 x11: 1fffe0001161b6e1 x10: ffff800089113470 x9 : ffff00008b0db70c
 x8 : ffff000081479ee0 x7 : 0000000000000000 x6 : 0000000000000800
 x5 : 0000000000000001 x4 : 0000000000000000 x3 : ffff00008263c200
 x2 : 0000000000000060 x1 : ffff800089113368 x0 : ffff8000847cb7c8
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
 Code: 910083fd f9423464 f9000fe4 d2800004 (394c3003)
 ---[ end trace 0000000000000000 ]---

The __devm_regmap_init_slimbus() started to be used instead of
__regmap_init_slimbus() after the commit mentioned above and turns out
the incorrect bus_context pointer (3rd argument) was used in
__devm_regmap_init_slimbus(). It should be &slimbus->dev. Correct it.
The wcd934x codec seems to be the only (or the first) user of
devm_regmap_init_slimbus() but we should fix till the point where
__devm_regmap_init_slimbus() was introduced therefore two "Fixes" tags.

Fixes: 4e65bda8273c ("ASoC: wcd934x: fix error handling in wcd934x_codec_parse_data()")
Fixes: 7d6f7fb053ad ("regmap: add SLIMbus support")
Cc: stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Ma Ke <make24@iscas.ac.cn>
Cc: Steev Klimaszewski <steev@kali.org>
Cc: Srinivas Kandagatla <srini@kernel.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---

The patch/fix is for the current 6.18 development cycle
since it is fixes the regression introduced in 6.18.0-rc1.

 drivers/base/regmap/regmap-slimbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-slimbus.c b/drivers/base/regmap/regmap-slimbus.c
index 54eb7d227cf4..edfee18fbea1 100644
--- a/drivers/base/regmap/regmap-slimbus.c
+++ b/drivers/base/regmap/regmap-slimbus.c
@@ -63,7 +63,7 @@ struct regmap *__devm_regmap_init_slimbus(struct slim_device *slimbus,
 	if (IS_ERR(bus))
 		return ERR_CAST(bus);
 
-	return __devm_regmap_init(&slimbus->dev, bus, &slimbus, config,
+	return __devm_regmap_init(&slimbus->dev, bus, &slimbus->dev, config,
 				  lock_key, lock_name);
 }
 EXPORT_SYMBOL_GPL(__devm_regmap_init_slimbus);
-- 
2.47.3


