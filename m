Return-Path: <stable+bounces-172187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40515B2FFD3
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A344D5A1DB5
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1682D46B7;
	Thu, 21 Aug 2025 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rW9ZpUDe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEFF2D47FA
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792881; cv=none; b=ZSA2zD3nGh6gRzLIIrTXUZutSkZORMhbLJJFdipyMVLFumnnfGLpTXRwtRq0BZtFYA778lrXLG0mJJu03VV8J3F994uRb9xxHd7rNc3tHqnPNDOhXgURulxl5NxLHzIgpGwnRZ5u9gidicTGpJH9cDLLI5/x9a34bgtz6crwHJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792881; c=relaxed/simple;
	bh=weVg3FFUEA2Cj5OrWpHwxMtmhbG6+6+dieqbcrP0FGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNhFS+AUrYRMaNcllIZxGUGJeyueyXDYNBWjuwjhrv0sP3ua3ZcUWgG0a1xrAWxAQojoWPbZbvAUIupbjf+LS0+V8l20D7Fx/mBzYR7PgM790g9lH+Y4K60vAQlMjhqsxjPZLVYNwZbRrgfCbkhsSuFUJDqPGpkIvHbsmU8+vkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rW9ZpUDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAC7C19424;
	Thu, 21 Aug 2025 16:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755792881;
	bh=weVg3FFUEA2Cj5OrWpHwxMtmhbG6+6+dieqbcrP0FGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rW9ZpUDei+nO+k3x2106+azeWGLDhbC56qgTp3ND1z08m5YEBIF06Q5zg7k4R9gLx
	 GrNKDiyn7N/r5kfGDxWfzqKPbGbaiDHG2j4V4+bS4H83jzrgm46Dc7BkFbUYhOdl/H
	 mJGJiwkYaY/UD6jkghualT6td7MzWwmKhTIH5Fq2I3EaU4+xJ/eo/Bw/cvf0Bfc2Pj
	 p0yK/xS2zGpbUBorLCSrM4pv3KrpVD5xH+hraTMXZpdMQ7wbJuTuTTkQNcHKLL/9w5
	 4/O8kaLTXuyjyIOeDf5I96keGd89JFzsKm4I2haNOPNwThsIISgNv/t8ipR8ie0twS
	 oubmpX0kIcTFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] platform/chrome: cros_ec: remove unneeded label and if-condition
Date: Thu, 21 Aug 2025 12:14:36 -0400
Message-ID: <20250821161437.775522-3-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821161437.775522-1-sashal@kernel.org>
References: <2025082112-segment-delta-e613@gregkh>
 <20250821161437.775522-1-sashal@kernel.org>
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
index 8cac78b6f0ac..ec6ebb250ba3 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -193,7 +193,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	err = cros_ec_query_all(ec_dev);
 	if (err) {
 		dev_err(dev, "Cannot identify the EC: error %d\n", err);
-		goto destroy_mutex;
+		goto exit;
 	}
 
 	if (ec_dev->irq > 0) {
@@ -205,7 +205,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		if (err) {
 			dev_err(dev, "Failed to request IRQ %d: %d",
 				ec_dev->irq, err);
-			goto destroy_mutex;
+			goto exit;
 		}
 	}
 
@@ -217,7 +217,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		dev_err(ec_dev->dev,
 			"Failed to create CrOS EC platform device\n");
 		err = PTR_ERR(ec_dev->ec);
-		goto destroy_mutex;
+		goto exit;
 	}
 
 	if (ec_dev->max_passthru) {
@@ -276,7 +276,6 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 exit:
 	platform_device_unregister(ec_dev->ec);
 	platform_device_unregister(ec_dev->pd);
-destroy_mutex:
 	mutex_destroy(&ec_dev->lock);
 	lockdep_unregister_key(&ec_dev->lockdep_key);
 	return err;
@@ -293,8 +292,7 @@ EXPORT_SYMBOL(cros_ec_register);
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


