Return-Path: <stable+bounces-172166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B14B2FDF1
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 17:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E5B725929
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968D628726F;
	Thu, 21 Aug 2025 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ez1WI6SJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5626D265623
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788930; cv=none; b=IovVKZc2KIb25sEZH76oFhf3TN5xt6F28yjByb8tg5ohISyY40Q4xJf7927FQ9kI5F+LiB3XIY4GRAl0cufnMW15vlCxZ5VcZIlZCQhI0TQ2qXCR/VZz8pT1n/pOLCat/1vSF4HMSw3coTC3OeGjP5LmOS94Pf3DbwuyiB/iseM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788930; c=relaxed/simple;
	bh=QV1EaqA8RGi/dMyIF/8FkcLpZ+99vlm1EET2VvUmRHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCyDXdwPbG4Yu7SxapN/910LcNanCIXL3/vq7454ah6KRZR5Detqp8VQ1QifcbUS5Bb1XeZi0dFEhfZTRBS/GGTbBh9OriZYdscPZJZykvWku9VRRNAx2rLDmhXQxTzZZdZEfxSxjENtA+JHmKCJxzrqBDe9jpMc3RIx877Vz6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ez1WI6SJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB62C4CEEB;
	Thu, 21 Aug 2025 15:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755788929;
	bh=QV1EaqA8RGi/dMyIF/8FkcLpZ+99vlm1EET2VvUmRHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ez1WI6SJuqzXBFWdhWgVbFaYW+r39r8b3larzplqCVtgwaAAl7b80jpoT4tcz8ZU1
	 fBft0vqDfkWTRPTOJYKtr0zYu9b79xTt/Auoc1MEcIB99yBuyu9MFT9tVYUkVuA2HP
	 ggez/+59o4TtJ0JGRWo/VSy1RDuc4Ga+A19w6PjKOYOiNRZBgAaA6FDy0Mq3SIzGs+
	 orrKDzv8ArLbudUE4acQjdBW6HPbk+x7Mn551LrNQBCoA6v8pjihQIwQiSYRE1wETp
	 EeOYSIWjlmtH3xiF/LXDl06diOR5OH5P15dViiUJ6H7+TDffpgP7UtK8VtTeEbnsLR
	 a/PKTA3x685sA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] platform/chrome: cros_ec: remove unneeded label and if-condition
Date: Thu, 21 Aug 2025 11:08:43 -0400
Message-ID: <20250821150844.754065-3-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821150844.754065-1-sashal@kernel.org>
References: <2025082112-freight-pesticide-c276@gregkh>
 <20250821150844.754065-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tzung-Bi Shih <tzungbi@kernel.org>

[ Upstream commit 554ec02c97254962bbb0a8776c3160d294fc7e51 ]

Both `ec_dev->ec` and `ec_dev->pd` are initialized to NULL at the
beginning of cros_ec_register().  Also, platform_device_unregister()
takes care if the given platform_device is NULL.

Remove the unneeded goto-label and if-condition.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Link: https://lore.kernel.org/r/20230308031247.2866401-1-tzungbi@kernel.org
Stable-dep-of: e23749534619 ("platform/chrome: cros_ec: Unregister notifier in cros_ec_unregister()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_ec.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index c5c0b273a8d7..f75b735b36ef 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -207,7 +207,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	err = cros_ec_query_all(ec_dev);
 	if (err) {
 		dev_err(dev, "Cannot identify the EC: error %d\n", err);
-		goto destroy_mutex;
+		goto exit;
 	}
 
 	if (ec_dev->irq > 0) {
@@ -219,7 +219,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		if (err) {
 			dev_err(dev, "Failed to request IRQ %d: %d",
 				ec_dev->irq, err);
-			goto destroy_mutex;
+			goto exit;
 		}
 	}
 
@@ -231,7 +231,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		dev_err(ec_dev->dev,
 			"Failed to create CrOS EC platform device\n");
 		err = PTR_ERR(ec_dev->ec);
-		goto destroy_mutex;
+		goto exit;
 	}
 
 	if (ec_dev->max_passthru) {
@@ -297,7 +297,6 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 exit:
 	platform_device_unregister(ec_dev->ec);
 	platform_device_unregister(ec_dev->pd);
-destroy_mutex:
 	mutex_destroy(&ec_dev->lock);
 	lockdep_unregister_key(&ec_dev->lockdep_key);
 	return err;
@@ -314,8 +313,7 @@ EXPORT_SYMBOL(cros_ec_register);
  */
 void cros_ec_unregister(struct cros_ec_device *ec_dev)
 {
-	if (ec_dev->pd)
-		platform_device_unregister(ec_dev->pd);
+	platform_device_unregister(ec_dev->pd);
 	platform_device_unregister(ec_dev->ec);
 	mutex_destroy(&ec_dev->lock);
 	lockdep_unregister_key(&ec_dev->lockdep_key);
-- 
2.50.1


