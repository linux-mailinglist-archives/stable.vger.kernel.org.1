Return-Path: <stable+bounces-204331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5726CEBB55
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 10:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52AAF3014AFF
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 09:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6561F318131;
	Wed, 31 Dec 2025 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="MLgsVcf8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zTD6P0KX"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D084F1D5AD4;
	Wed, 31 Dec 2025 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767174147; cv=none; b=KsB6YO+Oo05jB46LJw39esguuRV2z7E+FhQ//V0Yhz6bJkPlFAsEGKAzFYIChkYS7u7KxapvbYDptqNQx1HV590XVwfBzRh2G4/iOMW034AYf0xUhT0y4ocRrk4jHGBdjPEbfGk8wLpVh46FA2RZPWhfe2Cor5o4k0Z+ZWB5Vro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767174147; c=relaxed/simple;
	bh=xJzCPQmr76VNl5jCxm+Qduv0QwPM15gusEARXhaF7Do=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=By3jOyaxcd4k0pAzaGB4YZygTaE31sBGwaZrk00mfh72b3ri3z50hHm7qX+rdr852hIxcwmq57kl0xuOczmxN8ZO6mntVo4OVo9VNEU7A9Nym+Cq1ao52HJ0bwDhxFpHlDQf6FTEDhXPphnJskRiKyMm6Q+Mbx5lOYgPxLcGLfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=MLgsVcf8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zTD6P0KX; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CB0807A010C;
	Wed, 31 Dec 2025 04:42:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 31 Dec 2025 04:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1767174143; x=1767260543; bh=hS
	6XZTtAqHnnW+f1AAVumjb0R3JxUAZPLUP82F/FDSE=; b=MLgsVcf8hl1RFoBH9J
	Mnoa9A7Frol7Yuopv2Zmd6Y+RnjfAASz8BrrVbvaRaRfS0sZGcHQCNBwpCBZO72i
	Y9q/w1KUc+qWpbHv3jkTLlNSRhCzhyuRa7JRPLwk9X85JVHCdYRHJ2xDVKPB07yz
	bgoSmtYuUFoZUDjlC+t4ior8/twz4UXzSI6qKbvtf3ASIFQq5A3t7gpgv5uaLhaA
	1zhaB6cXXGd1Lgis6P9BCtDoaVvGuS6hgR9gM9JZBBG9E+NO7/u+/1hjImwEhui7
	7aXaS/3fp7WhXdyI9TgZZPn3CriVvoMoxUEJIaYQAkdWA9RenQtlJ1Hknnwe4CJ6
	0Hxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1767174143; x=1767260543; bh=hS6XZTtAqHnnW+f1AAVumjb0R3Jx
	UAZPLUP82F/FDSE=; b=zTD6P0KXMWm8MksJkqFWViwQbVeLN7xOf5vzohBLyH8e
	HgXseWuBlF/EPwgyY7+9v1M3ZuuicMCEOANT+Di18c2yNwon/AWF/kL9Gal3UYad
	CN7oOA3VjEWt+pH2AzSJo3t9G4TI13oSYTzXh4w/7XFrkQ+jGC3E1FcQ9PsMA4vX
	/oQ2l+YpyvqLso9wLJFQoZIr4S6NCvrPosyD6IC862iHGhhjsJ679Gs5Httxa2TI
	ycvpyibiFTGeejBaRy8FFst12hdJ2jxvYfw6PElfstUl/YUP8sRcndT12xjSTNAM
	QD0EBXYw0zySnLne+XPZjEykAOfhyvq8Ciq/GgVnmg==
X-ME-Sender: <xms:_-9UaQN8Ui9W-bVUdfMBhs-JSMHfjZXX0BfJqsrHHqz7JfpaABE_IA>
    <xme:_-9UaZhfAWF1U2JALUoZ2pXRYc8wyIilU5Umc1QiQz07ofyA9injRxa8O5hdaU_KL
    UJ6Fy8NenmMMInia7nC4HJcn9W0OEsbX7uwMRUcpPPclt0onlK2xw>
X-ME-Received: <xmr:_-9Uaa4YtgC15-kLQLWiuKEwHRJNbr0Ob6SaMd3i4JLc70s0dO9d7kgBI2L9CHbBEbONPgXuin0TbSTZ6DCBMFxCoR_8-IDjRGitEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekvdehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheplfgrnhhnvgcuifhr
    uhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpeefheeltd
    ehfeetjeefvdehteeutddtteelgeduueetjeevteeifeeuvdefffdvieenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopeekpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlh
    eslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehnvggrlhesghho
    mhhprgdruggvvhdprhgtphhtthhopehjsehjrghnnhgruhdrnhgvthdprhgtphhtthhope
    hsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvggvse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshgrhhhisehlihhsthhsrdhlihhnuhig
    rdguvghvpdhrtghpthhtohepshhvvghnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_-9UaY2LqZmifgtncPRph7siEYH5HgDR5m875leypgLKIsoAlbZ3PA>
    <xmx:_-9UadtIDS5WzDV--0QiwS0S69248s0B0igaklc_HEGC9sjkjbLlmA>
    <xmx:_-9UaW59orB_iAPMtfWG-5qTF4-kLtukCX8vKbQjPgoAPGS6_wYIFw>
    <xmx:_-9UaRc4TwCfDZL9KJyYxNe7cRNXq1Z4gfXPTKQKgcpotlecHxRsBg>
    <xmx:_-9UaePBSgTnhK5OVDJpjSyQhH-c07gXY4nWWc1Ks4oJ5sadIwaAvRpo>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Dec 2025 04:42:22 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Wed, 31 Dec 2025 10:42:12 +0100
Subject: [PATCH v2] mfd: macsmc: Initialize mutex
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-macsmc-mutex_init-v2-1-5818c9dc9b29@jannau.net>
X-B4-Tracking: v=1; b=H4sIAPPvVGkC/32NQQ6CMBBFr0JmbQ2tLYgr72GIGcsgY0IxbSEY0
 rtbOYDL95L//gaBPFOAS7GBp4UDTy6DOhRgB3RPEtxlBlUqUzbKiBFtGK0Y50jrnR1HcS672j4
 Uou0R8u7tqed1b97azAOHOPnPfrHIn/1XW6SQQsuKGqq0rk/m+kLncD46itCmlL5blJHyswAAA
 A==
X-Change-ID: 20250925-macsmc-mutex_init-80d7cb2aacfa
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1305; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=xJzCPQmr76VNl5jCxm+Qduv0QwPM15gusEARXhaF7Do=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhsyQ93+WP2h+Itt+OWydBMfzVeZX3+h8vvVm5UyVTK33n
 49ELeln6ihlYRDjYpAVU2RJ0n7ZwbC6RjGm9kEYzBxWJpAhDFycAjCRbltGhudFh+5kPZmxNr5e
 65HNZL21e75WtnHKyN2ae+swR7rpK2ZGhv2+0ec7ls3Tya0PuFo6TShHrzHB23uFlM0rPYU7slr
 GjAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Initialize struct apple_smc's mutex in apple_smc_probe(). Using the
mutex uninitialized surprisingly resulted only in occasional NULL
pointer dereferences in apple_smc_read() calls from the probe()
functions of sub devices.

Fixes: e038d985c9823 ("mfd: Add Apple Silicon System Management Controller")
Cc: stable@vger.kernel.org
Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v2:
- rewritten commit message
- added missing Cc: stable
- rebased onto v6.19-rc1
- Link to v1: https://lore.kernel.org/r/20250925-macsmc-mutex_init-v1-1-416e9e644735@jannau.net
---
 drivers/mfd/macsmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/macsmc.c b/drivers/mfd/macsmc.c
index e3893e255ce5e4bb4832d80ad1fc002d413a291a..3015e8d36d6e5bfdcea342c7d05a7b34788d7845 100644
--- a/drivers/mfd/macsmc.c
+++ b/drivers/mfd/macsmc.c
@@ -413,6 +413,7 @@ static int apple_smc_probe(struct platform_device *pdev)
 	if (!smc)
 		return -ENOMEM;
 
+	mutex_init(&smc->mutex);
 	smc->dev = &pdev->dev;
 	smc->sram_base = devm_platform_get_and_ioremap_resource(pdev, 1, &smc->sram);
 	if (IS_ERR(smc->sram_base))

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20250925-macsmc-mutex_init-80d7cb2aacfa

Best regards,
-- 
Janne Grunau <j@jannau.net>


