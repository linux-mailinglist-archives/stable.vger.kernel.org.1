Return-Path: <stable+bounces-195354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23666C755F7
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id AE96C2F632
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1EA3644D7;
	Thu, 20 Nov 2025 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vASE0QC8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52AD369208
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656176; cv=none; b=QYtMMkP4hKXuHVTlB+qP+DYKWY+TdsCZ7jJ51YM+deC64PewXcDgaULUlBRSuF0ushkH82NjJQmWAOr8BYIuzPbShG+INMIXskz5miTQV4EDbV+mcaVyYq4v3wQ7VJw5Zuf4UFkP5mN/4U/FiBBdfFB1SBIWe2zMnO954YskWns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656176; c=relaxed/simple;
	bh=/Ge3xtn3kKCZu+XccndghMVRSRAFgZxYr8OD8A1DJbo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZBl670+Qf+QP5lm2bDObMAJPPAcjqQTm++iJCD2zQf4qXlCW9EmxNA7/uNBD5PtL8nDi1xd/zKpb0oZA1cX7u3xoCFF97Bf3SNPXsH1UQazrLFLtZ4E2azv3RCvKJ7cvSBoMstELZkXDnNSfauAx0xPJmdUiYgjmBEQdfCkqW3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vASE0QC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44709C4CEF1;
	Thu, 20 Nov 2025 16:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763656176;
	bh=/Ge3xtn3kKCZu+XccndghMVRSRAFgZxYr8OD8A1DJbo=;
	h=Subject:To:Cc:From:Date:From;
	b=vASE0QC8NQYTJISlktv7FJiPgKdIh0DyjbcgkDMJ4AOwtLbvdZdNVz0rtUmoemIVD
	 3Tf/SlUvGn1tXQcJSx3EbzNJDAG2fKNG9cSkxKJnTBPNd7du+WjhaEu2dEe1TVPtzI
	 NXooBy1pw+ACS1gqvjzVVctRWZsIMpo5s1OnvGvU=
Subject: FAILED: patch "[PATCH] pmdomain: samsung: plug potential memleak during probe" failed to apply to 6.1-stable tree
To: andre.draszik@linaro.org,krzysztof.kozlowski@linaro.org,m.szyprowski@samsung.com,peter.griffin@linaro.org,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:29:33 +0100
Message-ID: <2025112033-oversold-exceeding-d133@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 90c82941adf1986364e0f82c35cf59f2bf5f6a1d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112033-oversold-exceeding-d133@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 90c82941adf1986364e0f82c35cf59f2bf5f6a1d Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
Date: Thu, 16 Oct 2025 16:58:37 +0100
Subject: [PATCH] pmdomain: samsung: plug potential memleak during probe
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

of_genpd_add_provider_simple() could fail, in which case this code
leaks the domain name, pd->pd.name.

Use devm_kstrdup_const() to plug this leak. As a side-effect, we can
simplify existing error handling.

Fixes: c09a3e6c97f0 ("soc: samsung: pm_domains: Convert to regular platform driver")
Cc: stable@vger.kernel.org
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 5d478bb37ad6..f53e1bd24798 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -92,13 +92,14 @@ static const struct of_device_id exynos_pm_domain_of_match[] = {
 	{ },
 };
 
-static const char *exynos_get_domain_name(struct device_node *node)
+static const char *exynos_get_domain_name(struct device *dev,
+					  struct device_node *node)
 {
 	const char *name;
 
 	if (of_property_read_string(node, "label", &name) < 0)
 		name = kbasename(node->full_name);
-	return kstrdup_const(name, GFP_KERNEL);
+	return devm_kstrdup_const(dev, name, GFP_KERNEL);
 }
 
 static int exynos_pd_probe(struct platform_device *pdev)
@@ -115,15 +116,13 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	if (!pd)
 		return -ENOMEM;
 
-	pd->pd.name = exynos_get_domain_name(np);
+	pd->pd.name = exynos_get_domain_name(dev, np);
 	if (!pd->pd.name)
 		return -ENOMEM;
 
 	pd->base = of_iomap(np, 0);
-	if (!pd->base) {
-		kfree_const(pd->pd.name);
+	if (!pd->base)
 		return -ENODEV;
-	}
 
 	pd->pd.power_off = exynos_pd_power_off;
 	pd->pd.power_on = exynos_pd_power_on;


