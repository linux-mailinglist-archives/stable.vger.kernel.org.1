Return-Path: <stable+bounces-172083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96463B2FA91
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5F2AA3C02
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49F6334398;
	Thu, 21 Aug 2025 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbaov2JK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CE633471E
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782842; cv=none; b=foPtdpV1/pHWXnQWeOQRi4MfIi4ZI2oiqa3bOT+aZolYrAiQ5IvAjxc86+mr0a/913oH3kfFr/4wKPVqfMtJpFTOd6yNe3R5GtpgxWKs3MnoJbJVjJ0bSHEXS38b/URNDva0jfopv/ExeRctRABQswpaQD0oMNVrCXCYtJkG2Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782842; c=relaxed/simple;
	bh=etRLxDSvO9+wqq7jU0zFbRpYunU+ROd/hwtPIE5klB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nic/eM6SzH0gbOZMztvfmrkYjRRv3D4b8e0WoFsu7rhiSBmdjLNbFoq2UcHWN0TGiBzG90uZxD7qPYvxcsLV7bD496tkXslCWdwMwfImFDd4De6Go08PKz4yF6MN8vVRB3RFF7uv9tVFO5+AwD45+F+8A7nj9VzwMvDxyvjvRVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbaov2JK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3657C113CF;
	Thu, 21 Aug 2025 13:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755782842;
	bh=etRLxDSvO9+wqq7jU0zFbRpYunU+ROd/hwtPIE5klB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bbaov2JKhlN5Dy59RJPEmq5KSajRc54TI4KOfV0HNQhN4Ny9gqMjPPn/7A4aKQHt8
	 4aJEistEhx9/sWeb76WKmBfRPYJvsmk1rg4JvohTrO+f2hPC/brjkpKVQUcoEjwOYM
	 OFYvW2omWXN9ZaJwkzkT5BeMLwdiguZ4eONE16SkXf6ltbElDkDHtlFOjd4QpwCgsV
	 mM/fMq2kHBUvxURsJoRnuR5nioVbSErS9II6NkqGDas9nzEH755ILFBXzijYj3nmrr
	 WHTa6xpSU8yfNimykenOIy4gHkJ228zfGlpLVGRXe4Hi+oKDgRh++saH/wFEQSiKPk
	 14zp7ku/rYrlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] platform/chrome: cros_ec: remove unneeded label and if-condition
Date: Thu, 21 Aug 2025 09:27:18 -0400
Message-ID: <20250821132719.713502-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821132719.713502-1-sashal@kernel.org>
References: <2025082112-exemplary-explode-1646@gregkh>
 <20250821132719.713502-1-sashal@kernel.org>
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
index 4ae57820afd5..6d997c59376d 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -205,7 +205,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	err = cros_ec_query_all(ec_dev);
 	if (err) {
 		dev_err(dev, "Cannot identify the EC: error %d\n", err);
-		goto destroy_mutex;
+		goto exit;
 	}
 
 	if (ec_dev->irq > 0) {
@@ -217,7 +217,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		if (err) {
 			dev_err(dev, "Failed to request IRQ %d: %d\n",
 				ec_dev->irq, err);
-			goto destroy_mutex;
+			goto exit;
 		}
 	}
 
@@ -229,7 +229,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		dev_err(ec_dev->dev,
 			"Failed to create CrOS EC platform device\n");
 		err = PTR_ERR(ec_dev->ec);
-		goto destroy_mutex;
+		goto exit;
 	}
 
 	if (ec_dev->max_passthru) {
@@ -295,7 +295,6 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 exit:
 	platform_device_unregister(ec_dev->ec);
 	platform_device_unregister(ec_dev->pd);
-destroy_mutex:
 	mutex_destroy(&ec_dev->lock);
 	lockdep_unregister_key(&ec_dev->lockdep_key);
 	return err;
@@ -312,8 +311,7 @@ EXPORT_SYMBOL(cros_ec_register);
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


