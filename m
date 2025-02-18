Return-Path: <stable+bounces-116702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCB6A399C8
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4CD188C50B
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077D723C392;
	Tue, 18 Feb 2025 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T32YcB5r"
X-Original-To: stable@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567EC1A841C;
	Tue, 18 Feb 2025 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739876426; cv=none; b=TdEtoxwhMCyg+iV+PwDwM9WOww+6NyYYFRHBRVv5YOIVBXiy0cR3m989Cz2a41WcRQ+9u5MtfLwpR1CW0iintmWZ4P8aRALphDkawN2eFtok5bUx95d58q4h3yWIWmYqbadrKKIhvUoZ+a9gWCCgzoPRmLDLT5SvhSMN0D9QMn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739876426; c=relaxed/simple;
	bh=5zpTewL8k5Mh1szdJy9h1f0I9ZKhu9gJ/l6OlWAeSA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y/zEuY7VtPvi8WvYlyDuQ09tVU5eNZ/j4zX9o4VJEJR8F9WAsPC2o7+HAI8Zfy4mtlMonoZ7M3oA+pSzEzZkKurSgUjaYb2gx4Gq/kenFruGe4CbmZ/uSjzlzENUXZTj400hHwi81xVJKPBGH0Z9ggmPWvNqGWk9b+NjC75+sDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T32YcB5r; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2AAB744283;
	Tue, 18 Feb 2025 11:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739876416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bFpl79XooWwtz03EVMtL/4iwpR/E64DldF23S6kQkdM=;
	b=T32YcB5rlbGCUUPmhbBi1mhieqCJO1doFatTNuVykeiuVz6rGGO12XaTU6zqX/QaVXq8C+
	GV9SJtiI4wtFtXKI6ibintgbuRD7nf2I9Xdzs4arg++6A4BTxKg6N9yfiCWg5YAcwYtK+b
	6YVBmrMxnCaIYQldaJKDECYfLeuMou2aRmmxBIt2jMQecarGfHJQtjlIZuFPi962tjdBsp
	jZI+v+KGbkTdffygXb6D8AX/obICZY0HgB+9YTIlRFvokOrcFaDzDwQxHll+qvPiU5e9VV
	BbdH3+dP1nZyVgMaHfTnmrcdcQ+pe2KCwnJyU+/ul16W/6bVZ1toQpFG6R524g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 18 Feb 2025 12:00:12 +0100
Subject: [PATCH 1/2] driver core: platform: turn pdev->id_auto into
 pdev->flags
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-pdev-uaf-v1-1-5ea1a0d3aba0@bootlin.com>
References: <20250218-pdev-uaf-v1-0-5ea1a0d3aba0@bootlin.com>
In-Reply-To: <20250218-pdev-uaf-v1-0-5ea1a0d3aba0@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Binbin Zhou <zhoubinbin@loongson.cn>, linux-sound@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefvhhorohcunfgvsghruhhnuceothhhvghordhlvggsrhhunhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleevhfekueefvdekgfehhffgudekjeelgfdthedtiedvtdetteegvdeileeiuefhnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemieeigegsmehftdhffhemfhgvuddtmeelvghfugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemieeigegsmehftdhffhemfhgvuddtmeelvghfugdphhgvlhhopegludelvddrudeikedruddtrdeliegnpdhmrghilhhfrhhomhepthhhvghordhlvggsrhhunhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehli
 hhnuhigqdhsohhunhgusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopeiihhhouhgsihhnsghinheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhgvohdrlhgvsghruhhnsegsohhothhlihhnrdgtohhm
X-GND-Sasl: theo.lebrun@bootlin.com

struct platform_device->id_auto is the only boolean stored inside the
structure. Remove it and add an u8 flags field. The goal is to allow
more flags (without using more memory).

Cc: <stable@vger.kernel.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/base/platform.c         | 6 +++---
 include/linux/platform_device.h | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 6f2a33722c5203ac196a6e36e153648d0fe6c6d4..e2284482c7ba7c12fe2ab3c715e7d1daa3f65021 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -682,7 +682,7 @@ int platform_device_add(struct platform_device *pdev)
 		if (ret < 0)
 			return ret;
 		pdev->id = ret;
-		pdev->id_auto = true;
+		pdev->flags |= PLATFORM_DEVICE_FLAG_ID_AUTO;
 		dev_set_name(dev, "%s.%d.auto", pdev->name, pdev->id);
 		break;
 	}
@@ -720,7 +720,7 @@ int platform_device_add(struct platform_device *pdev)
 	return 0;
 
  failed:
-	if (pdev->id_auto) {
+	if (pdev->flags & PLATFORM_DEVICE_FLAG_ID_AUTO) {
 		ida_free(&platform_devid_ida, pdev->id);
 		pdev->id = PLATFORM_DEVID_AUTO;
 	}
@@ -750,7 +750,7 @@ void platform_device_del(struct platform_device *pdev)
 	if (!IS_ERR_OR_NULL(pdev)) {
 		device_del(&pdev->dev);
 
-		if (pdev->id_auto) {
+		if (pdev->flags & PLATFORM_DEVICE_FLAG_ID_AUTO) {
 			ida_free(&platform_devid_ida, pdev->id);
 			pdev->id = PLATFORM_DEVID_AUTO;
 		}
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 074754c23d330c9a099e20eecfeb6cbd5025e04f..d842b21ba3791f974fa62f52bd160ef5820261c1 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -23,7 +23,8 @@ struct platform_device_id;
 struct platform_device {
 	const char	*name;
 	int		id;
-	bool		id_auto;
+	u8		flags;
+#define PLATFORM_DEVICE_FLAG_ID_AUTO	BIT(0)
 	struct device	dev;
 	u64		platform_dma_mask;
 	struct device_dma_parameters dma_parms;

-- 
2.48.1


