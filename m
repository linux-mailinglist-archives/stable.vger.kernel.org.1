Return-Path: <stable+bounces-192776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2296C42C46
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 12:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A746A4E3DF8
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 11:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95565285C99;
	Sat,  8 Nov 2025 11:54:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA9B1FC8;
	Sat,  8 Nov 2025 11:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762602863; cv=none; b=jxMGkzGOWPXm6H3bIUHPeMoKggf4XBA/YyncIVOxrXigvTv82wJKCRmdCJ5+vg38+4dNoYLVGNvGRgJrU1pvXczUlBdFNz7+iw8o96hCOsC7FHjFCLyJq0s4A0LXLfPuGeNlHayTjSzUJ6KyjO8p9I9Ksgfu9dUDzR5w9nwsY2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762602863; c=relaxed/simple;
	bh=ndNmxdkh04ykLZ7E1ZNLgfUkU5xu9a8BkyVL5p81t3k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GvHv4uv1yAJfUPfYtAbiVjdDXxYZGPMLfVh4gU8cxa7HjVU0Wik8plzZovChXJEcDE8B2tLqHYN59VhJj1AnfqyDaehb0ifs+gsc8I4HUMsaDhZ6BE/HPqsLif1/DIKHFqJ6+CI39H97DiDJfn1HNrRuntmDk6L4KISco0m/HkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-05 (Coremail) with SMTP id zQCowAD3YvFLLw9pipgGAg--.40529S2;
	Sat, 08 Nov 2025 19:53:53 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: akpm@linux-foundation.org,
	jgg@ziepe.ca,
	leon@kernel.org,
	jhubbard@nvidia.com,
	mpenttil@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mm/hmm/test: Fix error handling in dmirror_device_init
Date: Sat,  8 Nov 2025 19:53:46 +0800
Message-Id: <20251108115346.6368-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:zQCowAD3YvFLLw9pipgGAg--.40529S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF17Jr1ktw4rXryfJFW5Jrb_yoW8Xw1fpF
	1UJas0kryUGrn3Gr18Zr48Ww1UKr9Yywn5Aw1UG34IgrW3XryYqry8Gw4Fqw1FkrWkJF15
	XFWaq3Z5AF1UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gw4l42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JU6GQhUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

dmirror_device_init() calls device_initialize() which sets the device
reference count to 1, but fails to call put_device() when error occurs
after dev_set_name() or cdev_device_add() failures. This results in
memory leaks of struct device objects. Additionally,
dmirror_device_remove() lacks the final put_device() call to properly
release the device reference.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 6a760f58c792 ("mm/hmm/test: use char dev with struct device to get device node")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 lib/test_hmm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 83e3d8208a54..5159fc36eea6 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -1458,20 +1458,25 @@ static int dmirror_device_init(struct dmirror_device *mdevice, int id)
 
 	ret = dev_set_name(&mdevice->device, "hmm_dmirror%u", id);
 	if (ret)
-		return ret;
+		goto put_device;
 
 	ret = cdev_device_add(&mdevice->cdevice, &mdevice->device);
 	if (ret)
-		return ret;
+		goto put_device;
 
 	/* Build a list of free ZONE_DEVICE struct pages */
 	return dmirror_allocate_chunk(mdevice, NULL);
+
+put_device:
+	put_device(&mdevice->device);
+	return ret;
 }
 
 static void dmirror_device_remove(struct dmirror_device *mdevice)
 {
 	dmirror_device_remove_chunks(mdevice);
 	cdev_device_del(&mdevice->cdevice, &mdevice->device);
+	put_device(&mdevice->device);
 }
 
 static int __init hmm_dmirror_init(void)
-- 
2.17.1


