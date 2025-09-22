Return-Path: <stable+bounces-180858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B798BB8E9D5
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 02:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70AC116BEAD
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 00:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C107163CF;
	Mon, 22 Sep 2025 00:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZRuUZgk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E769522F
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 00:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758499601; cv=none; b=R+PM0RIXNRLUKuJDWcGf+ybFS3EXPisU8caNniXCERfeRHRayAwVmibmt3E0FHRKSK0i//u9zQ5WDkFmsz5/a7GZpHBQxOWUw3ylMbi+CHBdCi1TyA8VMLKSzoAqBUvh/uln0qOaffVAk7Z/d8njBjusjSm52UtZMO9Z2EsgX5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758499601; c=relaxed/simple;
	bh=YhaGovhPIdosN3MQ5iLJkoSuNO0QTXekjkbpJykj8C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+Vuq5UZ5xFtWCht40FFtPA0564V0jsvA7dNepkQokCHYszDrIoJEZLCSsOlD+1g+QpnSO9c/7z8HtI7ILOr+/FdaZ1orbmQ811J9s3aOFV0ZAByEGg9GCkQh2RpaA/R6sPrvs8FeY4p9ATnxPukeoUGEQw3W9kWGZ/eLP31L2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZRuUZgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C61C4CEF7;
	Mon, 22 Sep 2025 00:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758499601;
	bh=YhaGovhPIdosN3MQ5iLJkoSuNO0QTXekjkbpJykj8C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZRuUZgk6YB+KBATasivDLD6iKjgAbb428uk1q3xX5QVuzU2HEuYwM0y3ESxi2zeK
	 U5dpsujxlTuxnW8bRdChjtPGWJznde3hTTcNuunp6maFI0CebmObZGSvdea3VBs/OP
	 IrD1hMSRon7p5/3GM3K+vO+G863EQ1FBW3bFD8Jn9Y6WOyY9Ktp8bjafRv5m//pcTB
	 3E7WmYr9IrWQj78E2oSHK/vASyGWThzFbED8AY/lR2pQFPCQKIG8IMDs+hW8Ski8DX
	 8QBMt0ojQCcObydimI5ywftFd5MVqO7vnRWwwurb4i1oyRKHsANOyZIlq1LCNS4P1s
	 he71n/zBIGfVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 2/2] net: rfkill: gpio: Fix crash due to dereferencering uninitialized pointer
Date: Sun, 21 Sep 2025 20:06:37 -0400
Message-ID: <20250922000637.3095532-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922000637.3095532-1-sashal@kernel.org>
References: <2025092157-imagines-darkroom-e5c5@gregkh>
 <20250922000637.3095532-1-sashal@kernel.org>
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


