Return-Path: <stable+bounces-180856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB51B8E9AA
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 01:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0736618969CE
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 23:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03221D416E;
	Sun, 21 Sep 2025 23:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfQA4Hee"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA81A55
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 23:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758498393; cv=none; b=qnLkHlsoQPhWlyvMpqllJ+qjLiKsw0WBH64jIUy7KEf0dgjnTB+eMK/Z7ThV0gYshyowGsQsPzeWuLZAtaaKmoB8tDyGErqGvkHMQ++sOb8FKyHqyN4yA08AUra57WCjd4g3rEg4ez0+CQgo3mpC/dQsI85nr3zC5IZCIxnTs2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758498393; c=relaxed/simple;
	bh=YhaGovhPIdosN3MQ5iLJkoSuNO0QTXekjkbpJykj8C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHHkXpsh6+5Gj4NZr6HXB/5uuGQEA4nFXT/lGyrDLdKwuL0HhUoWnLLpzJRcuT6pgbrnRgq2uvJi993d11PyuTydPzNJ27Suj5kNoxH6oMudQ+unFJiZE6Po4sjBy+dZRzNQUAsnzNgnezNqlSVnOn4kXFwJoko0n0PWPs6Ps+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfQA4Hee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D22C116B1;
	Sun, 21 Sep 2025 23:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758498393;
	bh=YhaGovhPIdosN3MQ5iLJkoSuNO0QTXekjkbpJykj8C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CfQA4Hee8BQMCXRIuHdfWJxaNCmBHk2SQ8O5SfG9LvZEseRfFgRCDlQrve892bUbu
	 5hxsxx7+bluh5m0JNT9n4+IV2wHt7cYJYyL0Q/5CaS5m/eNmivYZtcBhi/1QlpjPWM
	 fUvGNd/Myr0nR5DwafnJKr7zMtv5PdjadN6AyeirImrgtGmsXuVrqCxcXMU3WAT47A
	 x+du83PltKDo/PzkAF2c/aSEMXKsPhCgUg5Uhh7w/UnvKH/3ONLraK/Ua3IcmQ8aLh
	 DMnSty+qOqKakWKd+AX1avvDfiWQPE8tzoiJRwrhONgdAClAKUO44eHrT78otB2aVr
	 k6iQzQnip8qIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] net: rfkill: gpio: Fix crash due to dereferencering uninitialized pointer
Date: Sun, 21 Sep 2025 19:46:30 -0400
Message-ID: <20250921234630.3087563-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921234630.3087563-1-sashal@kernel.org>
References: <2025092156-postal-sappiness-e1ac@gregkh>
 <20250921234630.3087563-1-sashal@kernel.org>
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


