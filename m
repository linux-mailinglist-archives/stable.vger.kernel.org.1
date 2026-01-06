Return-Path: <stable+bounces-205046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09042CF757A
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 09:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC0903073F88
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 08:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B16B2DC792;
	Tue,  6 Jan 2026 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="mrjPrQqF"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACA81BBBE5
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767689313; cv=none; b=Opyu/lhL6Bool+lKGLIpVnXKiqh8msN6RInBLylruLb+s6mRCX2/FO8bQp5GNZshRKpCQfrgT1LrTP3U9V2HuOemuDH1/nAC4VNAYa3S5AiB0Px8W69CIKQhluryU+Qx89yvee12krO8iH3tGmMevYNK7Mt/R+hbhTy2gQgY/9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767689313; c=relaxed/simple;
	bh=tzas3/joaMGBU+SDtnWhUHfVRcM4fTGJmqiHajhVV8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPkKSIfKEyvV+UNhaXhcRx9uG09ELeQ+uKebMBPLWSMlXTuYic8VFofSoo6UXhqcWw3AH79CH1Zz4EbQJJyXs5O23ieAxYUw0cUuyv2NvR8m4hrk8VWzTdSIiPnj7MPduC0+4BIkGsOTHjIX5TnX4vVNH+ftlGfYZcI9ji81rTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=mrjPrQqF; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64fabaf9133so1253612a12.3
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 00:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1767689309; x=1768294109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XxK6mB3Dr2ZqUnEijrTyuH4FtxcVLOKZHeBdJMmwl24=;
        b=mrjPrQqFSqKB70HKsGgI7jVzLP6HBAMcTnEiJONvbI8/vhwybbgySVRD2/5dOYSi0k
         N3Z/w1SHJ1kg3d51xfubfWr3VNSl4ANCbnlROfjAiImi18GVtd0zeVjFVTsA7WYZTDRX
         ylMw0eFfj2V5qGNQWxAsyWOWOK9NzVpRAn7bM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767689309; x=1768294109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxK6mB3Dr2ZqUnEijrTyuH4FtxcVLOKZHeBdJMmwl24=;
        b=G+LhiZdI+0LMNzsu6TAHG8uFLMTwwiwhSo8T9xeyTHThmsAX9GrB5ccdZhuEaavJ/h
         oXuIwVqEPI0SJmXXj1Gtlqal1xgd+kfw0j/vG/SC9CYAZpl1FZDDLE+JlwTwEEOi7gTc
         Yt4M3iIUcEctOJlulV0w6Y+SfMjuclTD5KCMTkRNplkwyqrZV6B2WKs5ATWkWvguoiFc
         cjYHktP8wqCb0zP+6R/yPVHNGEYAyawDv5VH+dTH7J6/wCTzwA6D6XNtbSId4Ly8npOv
         H+ICD8cV3E4II0iPK/bRF68zoZkw+kZxaMy5drnibd4ctjzGYH9iVbCW2xKU2/625EbF
         jxIg==
X-Forwarded-Encrypted: i=1; AJvYcCVRJ74tELtv/fo/dBSWpI4jucIpQwLpAJPSqm4d5724cdu2Utux2mkNOQf30J+FQmq6PUxnx2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfRH0Zz8TxoC+REJn+ggKxID7Vkow9SAIOlvlU2hDmgMFzk8L8
	QfmikXJCv9jKLZggulVZ3DswwX2eSpGrei7e1FEbrASnVeg42Y9grHmIfErCjknWSfc=
X-Gm-Gg: AY/fxX4cijFGP5J41SD+8urN5s3DacbcbL71J5SO2BvVk2UnOvv+c3AYuHzbVryOd6D
	ZtmUv4/AKcZLOEHuqpsY1UWzk5sgPBHNg9Afww9Z7p6UlF9Rh8B9TVtkziwaoBVPFY0MCtLpTey
	KwgsNY9ApQEP8VBW4OzqauGKIK7lOQwN961sGuQhrfxtkIYLLBpFWG+KzSk+FmySBqIAy4RLsYh
	lbnWEtBKAnBzd3PbzeWFOsARjSK5U013CqP1j5krwuxDkxrDhaqIk2anglFg15srUx3TPeiW1NX
	2eLo/Mibcz7nfzC+7nqDG1t2obgWA42OmFUYqP8q9hUodnBjHF+UMDopdI4kOuswGbZaB/YRIMG
	8fTz65tSd0g9gENYVU8+KOZ7UzcJtb05wA7AL0JTFuyWjydNxBoo/HM0gPxA9CsaKRfHdfDT7qL
	Nv2wAi/c5EZoqnY04VD0rqKNSyI9koZPqXURkbQho=
X-Google-Smtp-Source: AGHT+IGNZG9HYrU6znG1XT2PLBjL9IBlLbwC6us1VE4nZSB+4uRh97YAaMpzUsuYysrkWNcCZSkDdg==
X-Received: by 2002:a05:6402:3594:b0:64d:589a:572b with SMTP id 4fb4d7f45d1cf-6507954bd5amr2316942a12.17.1767689308605;
        Tue, 06 Jan 2026 00:48:28 -0800 (PST)
Received: from tone.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4ed5sm1513832a12.11.2026.01.06.00.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 00:48:28 -0800 (PST)
From: Petko Manolov <petko.manolov@konsulko.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	stable@vger.kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	Petko Manolov <petkan@nucleusys.com>
Subject: [PATCH NET v2 1/1] net: usb: pegasus: fix memory leak in update_eth_regs_async()
Date: Tue,  6 Jan 2026 10:48:21 +0200
Message-ID: <20260106084821.3746677-1-petko.manolov@konsulko.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Petko Manolov <petkan@nucleusys.com>

When asynchronously writing to the device registers and if usb_submit_urb()
fail, the code fail to release allocated to this point resources.

Fixes: 323b34963d11 ("drivers: net: usb: pegasus: fix control urb submission")
Signed-off-by: Petko Manolov <petkan@nucleusys.com>
---
v2:
  - replace the auto-cleanup form with the classic kfree();

 drivers/net/usb/pegasus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
index 81ca64debc5b..c514483134f0 100644
--- a/drivers/net/usb/pegasus.c
+++ b/drivers/net/usb/pegasus.c
@@ -168,6 +168,8 @@ static int update_eth_regs_async(pegasus_t *pegasus)
 			netif_device_detach(pegasus->net);
 		netif_err(pegasus, drv, pegasus->net,
 			  "%s returned %d\n", __func__, ret);
+		usb_free_urb(async_urb);
+		kfree(req);
 	}
 	return ret;
 }
-- 
2.52.0


