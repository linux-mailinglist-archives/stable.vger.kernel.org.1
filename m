Return-Path: <stable+bounces-144554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 560B9AB90BE
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 22:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EDC97B8D4F
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 20:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74F7298CC0;
	Thu, 15 May 2025 20:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KxvIC6ys"
X-Original-To: stable@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1293200132
	for <stable@vger.kernel.org>; Thu, 15 May 2025 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747340565; cv=none; b=SCezWXl5QLL77KDOkdTMNMnGu2FCya5BZgc0QO5gmyjgjaaUVGqzZ2otzKfnPSel8jVmPu+ufBXqTvjHeIZa8U06EGltliDqnLN3PEbwf7YxEOpSfNWQa5zlbuVEyRyiozUQUr3r/JaJ90ED4FicX0Zgtba+XXmL+pC8wYPPiXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747340565; c=relaxed/simple;
	bh=+qPmiMCvCbwWMFsumLnuxL1X1H5/Bc3uUrJ2a2yIFXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iScgne0X6C8vG5vzyUOIYwNE211AoJeY2kizA6cwC+UeNOSuVW+00cggXdMYUUoJACw8y8USVtOjTq3LdiLchqOQyayNU+45HXPjK/lcmfNfYMp5eUQXrVwy1pQTd4Tf1nIvG+Zfa880E8DL6APeDD/HaDz2pGLAPcawCIXfLSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KxvIC6ys; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A1DB42DFF;
	Thu, 15 May 2025 20:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747340554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uKKuaJKi32k5rW30CO1tdtsdLidjfvlU9/bh0onXR7o=;
	b=KxvIC6ysVWg6b4w2/9x/hz09eIw1Dk3GFa+VtWL8yHNeEOSvG78q6vAN5M++gf/Q8FIBbw
	Qgx0nlzn8/NnA1L25yc2dJB2Hg0crwY4EQFHCPKjgEP9VGRDcz8DTytnptKqsYoEyT7W/7
	o84L0hlGoBMiCYr/qUlIGW8ONTZsZKB8jLl/NFWlCE30e8BuLVhuRQxDcwPsW1h22ZppkZ
	T3U8ZN8fNNvnOtZdlwjO/o9BLB6JfQpCprxSQXFIzoYW/gRROZDWjiX3/1UhjUIoR1qQm7
	ECYPp4Pl7JiAHOF0BD3biPLeydsBscXQXvgpQKG/YiOuHLWVYMcEfWUyjkxVSw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: stable@vger.kernel.org
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12.y] iio: light: opt3001: fix deadlock due to concurrent flag access
Date: Thu, 15 May 2025 22:21:45 +0200
Message-ID: <20250515202145.46813-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025051215-economist-traffic-fa57@gregkh>
References: <2025051215-economist-traffic-fa57@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtkeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeuvdelkeekteeuiefhvdejfeegleevfeelteegleejjeekueejfeeutddulefhnecuffhomhgrihhnpehmshhgihgurdhlihhnkhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegrtddtvdemudgsrgejmeegkehfjeemudeltgehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegrtddtvdemudgsrgejmeegkehfjeemudeltgehpdhhvghlohepsghoohhthidrfhhrihhtiidrsghogidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeflohhnrghth
 hgrnhdrvegrmhgvrhhonheshhhurgifvghirdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

The threaded IRQ function in this driver is reading the flag twice: once to
lock a mutex and once to unlock it. Even though the code setting the flag
is designed to prevent it, there are subtle cases where the flag could be
true at the mutex_lock stage and false at the mutex_unlock stage. This
results in the mutex not being unlocked, resulting in a deadlock.

Fix it by making the opt3001_irq() code generally more robust, reading the
flag into a variable and using the variable value at both stages.

Fixes: 94a9b7b1809f ("iio: light: add support for TI's opt3001 light sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Link: https://patch.msgid.link/20250321-opt3001-irq-fix-v1-1-6c520d851562@bootlin.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
(cherry picked from commit f063a28002e3350088b4577c5640882bf4ea17ea)
[Fixed conflict while applying on 6.12]
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/iio/light/opt3001.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 176e54bb48c3..d5ca75b12883 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -692,8 +692,9 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	struct opt3001 *opt = iio_priv(iio);
 	int ret;
 	bool wake_result_ready_queue = false;
+	bool ok_to_ignore_lock = opt->ok_to_ignore_lock;
 
-	if (!opt->ok_to_ignore_lock)
+	if (!ok_to_ignore_lock)
 		mutex_lock(&opt->lock);
 
 	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
@@ -730,7 +731,7 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	}
 
 out:
-	if (!opt->ok_to_ignore_lock)
+	if (!ok_to_ignore_lock)
 		mutex_unlock(&opt->lock);
 
 	if (wake_result_ready_queue)
-- 
2.49.0


