Return-Path: <stable+bounces-172546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B99B326B0
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 05:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D390B60F1B
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 03:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888D91EA7E4;
	Sat, 23 Aug 2025 03:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z604SgV1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461A24317D
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 03:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755920157; cv=none; b=vE3Mk9n0PAke/mDNokiNTbve+SDhaVVsWIOWy/y+15uhOPnbF8sCx3IuW6jNxgM23j7zGDO1tneSP5ndJFbGW2UW1BIgBUMxYtqxkumPJnIEZ99Sy+dY5SaKzWqH6B+SOALuWAvADgBH24UmYu2cAmdFsSadsrYqoSWRSsrxKyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755920157; c=relaxed/simple;
	bh=RCAHzBZzlwGGksKfP5F3AJtD4WPB17ZViFj0E+kT56I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0ouY7KMBMihPbHQvkXVhttHUXgrNF8vkBQ9S4y+qWBUFpMyk9FARFYsLbj+y8P7oxk/iZQ13xB0nFD7uNsYDfzFIOaIYaAH4nQ46VifRcYo3fQrx6p87P4ReTHgeGPNNHTldgKKUqzxFEnanNUvTzOjirl3+ekLmR2KHWY7A7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z604SgV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F9BC4CEED;
	Sat, 23 Aug 2025 03:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755920156;
	bh=RCAHzBZzlwGGksKfP5F3AJtD4WPB17ZViFj0E+kT56I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z604SgV19sceIfli2XlSaI7TD/gVna+Ygm82gn5W90y9BcT/5z0QEhc7tsgIzkkDG
	 zxJ9vO3YrWBIULAelQUXGoZ/DiYIWxFq+HlyrJD07Uwg9KsaOHHHY3Ta6hK1fswtDV
	 Wy2l78EM/RLxNWWTh3ECSAt7/jMlrP7zBYCfrEjLTYHVXCcJQDidXwMVtW0zuIbKvN
	 wXbHloLzdql3BYQ2p4MBu7l7mMg1oLo3HRWsE79EvbyMDF397HGkD+tvhvNyBE5OVg
	 2i2iN13KDt5ql5z7sVf6OMR6CY0NM3fqyLD17PFQhP2lxi9mBrfDVOtoCJfW5f5R/z
	 Y1LlRsCYUQSxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] media: camss: Convert to platform remove callback returning void
Date: Fri, 22 Aug 2025 23:35:53 -0400
Message-ID: <20250823033554.1801998-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082155-riches-diaper-55d5@gregkh>
References: <2025082155-riches-diaper-55d5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 428bbf4be4018aefa26e4d6531779fa8925ecaaf ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: 69080ec3d0da ("media: qcom: camss: cleanup media device allocated resource on error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/camss/camss.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index da5a8e18bb1e..c9265fb26182 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1477,7 +1477,7 @@ void camss_delete(struct camss *camss)
  *
  * Always returns 0.
  */
-static int camss_remove(struct platform_device *pdev)
+static void camss_remove(struct platform_device *pdev)
 {
 	struct camss *camss = platform_get_drvdata(pdev);
 
@@ -1487,8 +1487,6 @@ static int camss_remove(struct platform_device *pdev)
 
 	if (atomic_read(&camss->ref_count) == 0)
 		camss_delete(camss);
-
-	return 0;
 }
 
 static const struct of_device_id camss_dt_match[] = {
@@ -1519,7 +1517,7 @@ static const struct dev_pm_ops camss_pm_ops = {
 
 static struct platform_driver qcom_camss_driver = {
 	.probe = camss_probe,
-	.remove = camss_remove,
+	.remove_new = camss_remove,
 	.driver = {
 		.name = "qcom-camss",
 		.of_match_table = camss_dt_match,
-- 
2.50.1


