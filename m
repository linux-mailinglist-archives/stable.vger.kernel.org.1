Return-Path: <stable+bounces-180854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DF1B8E9A1
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 01:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2062189373B
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 23:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C92125784A;
	Sun, 21 Sep 2025 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2qqRsF6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCDE226CFC
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 23:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758497833; cv=none; b=KAno07o7z4GCa2YfsHCgL09N95J6K6N9rgdYyM2XZX24rfJYXZRXzTLy6Tqg5+9ZyLyFT4KQie3B4byw2NoFjQwaHZKVak/AzowgPrk5TjYTf3hcPGIAGnxhgyWF867aZOC+D74U2l0eCYPP1cL90jBBB3iaETTgNe0gS8HjgN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758497833; c=relaxed/simple;
	bh=YhaGovhPIdosN3MQ5iLJkoSuNO0QTXekjkbpJykj8C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/gMyJO/KxF1lVaqS9J++3eQa6URcAaocFJBHePaKNgTWrkdWBdhCG8hRhJy+PFa1Uto2qwJLH3nH39GI2Svxod1uTvcAeOAG68TKwaspGTHTP7ZsOeGr0MriV/i31cVWbNpibBmpu2zUy83Q1bvXJP9MPrAExb66Mm5v2if878=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2qqRsF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1A1C4CEF7;
	Sun, 21 Sep 2025 23:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758497832;
	bh=YhaGovhPIdosN3MQ5iLJkoSuNO0QTXekjkbpJykj8C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2qqRsF6p1/PErktYZUpjrHelamuW5rVkZ6BXCTEXDAio6znhc37NHhKK12inw3Dj
	 OCf3jARG1dmrFD+pAdyaaA1VUVVzxjsK2saeDpZthzMfX+KsOkG+Du/hTKeYYt4a1r
	 H4QhoCpjiJOgWkSj15GNXKBxe/4RHxIjVvF7BR4lm01G3j50DNfM3CRqbA1gBQ1TuM
	 gt3oQHrvBa7MairyygnmFpIavX1w+YHEfsmVtchpU838G3ZA5LVv9u6rtLDrq1sDZi
	 jdlHNClpZ6s/jUgcZFp4gfFlWDDCHW2LrMVmD0cq2oY+vZXGIc1MWxaF9XtQM8ipI9
	 cV5DHLEb10wDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] net: rfkill: gpio: Fix crash due to dereferencering uninitialized pointer
Date: Sun, 21 Sep 2025 19:37:09 -0400
Message-ID: <20250921233709.3086047-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921233709.3086047-1-sashal@kernel.org>
References: <2025092155-familiar-divisible-9535@gregkh>
 <20250921233709.3086047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hansg@kernel.org>

[ Upstream commit b6f56a44e4c1014b08859dcf04ed246500e310e5 ]

Since commit 7d5e9737efda ("net: rfkill: gpio: get the name and type from
device property") rfkill_find_type() gets called with the possibly
uninitialized "const char *type_name;" local variable.

On x86 systems when rfkill-gpio binds to a "BCM4752" or "LNV4752"
acpi_device, the rfkill->type is set based on the ACPI acpi_device_id:

        rfkill->type = (unsigned)id->driver_data;

and there is no "type" property so device_property_read_string() will fail
and leave type_name uninitialized, leading to a potential crash.

rfkill_find_type() does accept a NULL pointer, fix the potential crash
by initializing type_name to NULL.

Note likely sofar this has not been caught because:

1. Not many x86 machines actually have a "BCM4752"/"LNV4752" acpi_device
2. The stack happened to contain NULL where type_name is stored

Fixes: 7d5e9737efda ("net: rfkill: gpio: get the name and type from device property")
Cc: stable@vger.kernel.org
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Hans de Goede <hansg@kernel.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20250913113515.21698-1-hansg@kernel.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rfkill/rfkill-gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index ecfb766c47d08..1a3560cdba3e9 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -78,10 +78,10 @@ static int rfkill_gpio_acpi_probe(struct device *dev,
 static int rfkill_gpio_probe(struct platform_device *pdev)
 {
 	struct rfkill_gpio_data *rfkill;
-	struct gpio_desc *gpio;
+	const char *type_name = NULL;
 	const char *name_property;
 	const char *type_property;
-	const char *type_name;
+	struct gpio_desc *gpio;
 	int ret;
 
 	rfkill = devm_kzalloc(&pdev->dev, sizeof(*rfkill), GFP_KERNEL);
-- 
2.51.0


