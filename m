Return-Path: <stable+bounces-146269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9BFAC304A
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 17:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ABBE7AFADA
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 15:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149901EB1BA;
	Sat, 24 May 2025 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hkjb3xFR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E4B25776
	for <stable@vger.kernel.org>; Sat, 24 May 2025 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748101970; cv=none; b=XBVfqN/RvQ2QlYUw8zbCMQs/L+rU6iP1S9srZIDwLQ019Dh3/Hxcsq8y9N7DeGe9xIN3UvAn95hzLbqsqJqOUI6mWqdXbh2+uBm36kJutKskahkV9Kf4PkLHo9FVu4/QSuI+yGs47120aySY3YvN7bK+8L75zoo36H5IDd3GO94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748101970; c=relaxed/simple;
	bh=yB33lTfN4hSC069x/KdKAaQcbaPSNNYM7k+Hsg16cLM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BcaeQNcCnvJR2ucVWuMzaqDfzcfBedYmjxkIhn74oXrJl6MmLwvPH4tiIdcFE3IWSuZwYdeZULw0y7wTqfkCvFk+71p1dy5IS+pCbwh6E5IV9C2rAWWgNNR7hi6bZkNVk5FcVvnsaghJC2GoN5aCajDH5/uZHFXV9jyvKiB+vbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hkjb3xFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A51C4CEE4;
	Sat, 24 May 2025 15:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748101970;
	bh=yB33lTfN4hSC069x/KdKAaQcbaPSNNYM7k+Hsg16cLM=;
	h=Subject:To:Cc:From:Date:From;
	b=Hkjb3xFR9xNEYCO+kgOLyUqepYwreTIl+ACDUxSsojGve97b39lm8n+IjaDve4UL3
	 5OCnfDJycvb8jcCRYyVOSsOfiQD2cVh8P3aE5YR3KwjUcnp5XR/4rSInqNtl53PlDc
	 mwUZo2Iu8mdyx9rkgllAJINyq+H5G1hsQYhAqV0g=
Subject: FAILED: patch "[PATCH] pmdomain: core: Fix error checking in" failed to apply to 6.6-stable tree
To: dan.carpenter@linaro.org,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 24 May 2025 17:51:58 +0200
Message-ID: <2025052458-boogeyman-busily-acd9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0f5757667ec0aaf2456c3b76fcf0c6c3ea3591fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052458-boogeyman-busily-acd9@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0f5757667ec0aaf2456c3b76fcf0c6c3ea3591fe Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Thu, 8 May 2025 09:29:23 +0300
Subject: [PATCH] pmdomain: core: Fix error checking in
 genpd_dev_pm_attach_by_id()

The error checking for of_count_phandle_with_args() does not handle
negative error codes correctly.  The problem is that "index" is a u32 so
in the condition "if (index >= num_domains)" negative error codes stored
in "num_domains" are type promoted to very high positive values and
"index" is always going to be valid.

Test for negative error codes first and then test if "index" is valid.

Fixes: 3ccf3f0cd197 ("PM / Domains: Enable genpd_dev_pm_attach_by_id|name() for single PM domain")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/aBxPQ8AI8N5v-7rL@stanley.mountain
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 9b2f28b34bb5..d6c1ddb807b2 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3126,7 +3126,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 	/* Verify that the index is within a valid range. */
 	num_domains = of_count_phandle_with_args(dev->of_node, "power-domains",
 						 "#power-domain-cells");
-	if (index >= num_domains)
+	if (num_domains < 0 || index >= num_domains)
 		return NULL;
 
 	/* Allocate and register device on the genpd bus. */


