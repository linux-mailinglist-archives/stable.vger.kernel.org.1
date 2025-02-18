Return-Path: <stable+bounces-116703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87B0A399D3
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0596C172F28
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4390823DE85;
	Tue, 18 Feb 2025 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WdjqSWal"
X-Original-To: stable@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0BD234987;
	Tue, 18 Feb 2025 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739876428; cv=none; b=Tr0pCLe5aDiKCsqoza9pzXl7BrjQw25Vj+bwJb7xxozdDZx0v94KmsM7QGWx/gTwOqycV0YHXocSMPli0sodj3ajiQysfRmYi8xc8mqGaNxoueFUIkbcyR5vXIyjFs+ZSKqTAGQLC7Zq45MjKtcov28bU7fO5IyW5LtTn/zHtNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739876428; c=relaxed/simple;
	bh=18UqQUnfWxPFzrfW52abmx+X/vjz3e8/GrGdCva8woY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UWWCllgYK/ZkPFNxFiJ/IKDnRZI9CFOMxOZvwjFUGEkTImWVw90ezZ1jqjDsTlytdfAH9GTjkQ4zHFk7qT79OhfxuowZmnpJwthcltUG/crCCLFwdCXehF9zd9BL/SjddqcyDHdg+3BGYOgVuTcOdaGHglXYkKU+uhXkbNbavDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WdjqSWal; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 083BF4427A;
	Tue, 18 Feb 2025 11:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739876417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezOVk0Z1kc4cZQkyFk+U3tiggWL6VOIY8xHUunjQ3Sc=;
	b=WdjqSWalyguIP4azpLTk8IVxnK/WFUd6RZq9cEEVHMjzqA4+vK8u89/tb/aty+WSFkIZ+C
	p0xYzREqGf9btP8agFd039X52tuuvP86PYqlvesaGM5A1ptEkJJ7xu79kfT94XtKAIovuD
	UPimBftdBNpMmaaxWQ2ymRByjEZJyNUnHiyRQScpXlyH8MXZF11SCRpx3GF/xHCs8k3lT4
	JKb/MosnulC942bZs2AnqEmfC9MDccDiu7YmujBN2/GI7wum0DiyM0AQnjOAF/xAEVgwIm
	obtVCfJIiD9nuxhzGgLH0j/n+bfjjock0QbZMgIQVQhFwcdBj+agnVAff+V27w==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 18 Feb 2025 12:00:13 +0100
Subject: [PATCH 2/2] driver core: platform: avoid use-after-free on
 pdev->name
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-pdev-uaf-v1-2-5ea1a0d3aba0@bootlin.com>
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

The issue is with this:

	int of_device_add(struct platform_device *ofdev)
	{
		// ...
		ofdev->name = dev_name(&ofdev->dev);
		// ...
	}

We store the current device name pointer. If the device name changes
through a `dev_set_name(dev, "foo")` call:
 - old device name is freed: kfree(dev->name);
 - new device name is allocated: kmalloc(...);
 - notice pdev->name is still the old device name, ie a freed pointer.

OF is at fault here, taking the pointer to the device name in
of_device_add().

The new PLATFORM_DEVICE_FLAG_FREE_NAME flag tells platform devices if
they own their pdev->name pointer and if it requires a kfree() call.

Considerations:

 - The generic case in platform_device_register_full() is not faulty
   because it allocates memory for storing the name adjacent to the
   `struct platform_device` alloc; see platform_device_alloc():

	struct platform_object *pa;
	pa = kzalloc(sizeof(*pa) + strlen(name) + 1, GFP_KERNEL);

   We cannot rely on this codepath in all cases because OF wants to
   change the name after the platform device creation.

 - kfree_const() cannot solve the issue: either we allocated pdev->name
   separately or it is part of the platform_object allocation.
   pdev->name is never coming from read-only data.

 - It is important to duplicate! pdev->name must not change to make sure
   the platform_match() return value is stable over time. If we updated
   pdev->name alongside dev->name, once a device probes and changes its
   name then the platform_match() return value would change.

 - In of_device_add(), we make sure to kstrdup() the new name before
   freeing the old one; if alloc fails, we leave the device as-is.

Fixes: eca3930163ba ("of: Merge of_platform_bus_type with platform_bus_type")
Cc: <stable@vger.kernel.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/base/platform.c         |  2 ++
 drivers/of/platform.c           | 12 +++++++++++-
 include/linux/platform_device.h |  1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index e2284482c7ba7c12fe2ab3c715e7d1daa3f65021..3548714d6ba408abc6c7ab0f3e7496c6e27ba060 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -563,6 +563,8 @@ static void platform_device_release(struct device *dev)
 	kfree(pa->pdev.mfd_cell);
 	kfree(pa->pdev.resource);
 	kfree(pa->pdev.driver_override);
+	if (pa->pdev.flags & PLATFORM_DEVICE_FLAG_FREE_NAME)
+		kfree(pa->pdev.name);
 	kfree(pa);
 }
 
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index c6d8afb284e88061eb6fb0ba02e429cec702664c..ef6f341fd9b77a9e0ed6969c3f322b9bc91d0e8d 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -44,11 +44,21 @@ EXPORT_SYMBOL(of_find_device_by_node);
 
 int of_device_add(struct platform_device *ofdev)
 {
+	char *new_name;
+
 	BUG_ON(ofdev->dev.of_node == NULL);
 
+	new_name = kstrdup(dev_name(&ofdev->dev), GFP_KERNEL);
+	if (!new_name)
+		return -ENOMEM;
+
+	if (ofdev->flags & PLATFORM_DEVICE_FLAG_FREE_NAME)
+		kfree(ofdev->name);
+
 	/* name and id have to be set so that the platform bus doesn't get
 	 * confused on matching */
-	ofdev->name = dev_name(&ofdev->dev);
+	ofdev->name = new_name;
+	ofdev->flags |= PLATFORM_DEVICE_FLAG_FREE_NAME;
 	ofdev->id = PLATFORM_DEVID_NONE;
 
 	/*
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index d842b21ba3791f974fa62f52bd160ef5820261c1..203016afc3899ffa05f38b9d4ce3bfc02d5b75ef 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -25,6 +25,7 @@ struct platform_device {
 	int		id;
 	u8		flags;
 #define PLATFORM_DEVICE_FLAG_ID_AUTO	BIT(0)
+#define PLATFORM_DEVICE_FLAG_FREE_NAME	BIT(1)
 	struct device	dev;
 	u64		platform_dma_mask;
 	struct device_dma_parameters dma_parms;

-- 
2.48.1


