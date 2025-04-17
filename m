Return-Path: <stable+bounces-133021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B34B0A919CC
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FFC119E4775
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701DC22E011;
	Thu, 17 Apr 2025 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aYa4CRIq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE8E20C497
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744887109; cv=none; b=UEDJ3kVC1W0GXgy3HRU7EO1nev6DyD1FYy73li0CaIt5n9SL3swW7FpZnV0FM2JcvxnKg4mfuZA4hqRULvjASSYl4WD2O3JNa+aPgSwd9WQOxCls1GV44QwRR2rl7IVXowqcJOcpoHx7+eh92/6txdANp6bMf3XtuubxmnMNx4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744887109; c=relaxed/simple;
	bh=u2wfwayr+ZL0KsrF26Gwf/K4Rp1V9BHWMbRbuUVAkyI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=n9dzq+6M6QxGbY16ks6Nfd6JB3JKwBTVWn5Tvfq0ixtcu7iu/MJ5ssGN+MJc0gZDImNpxMkK3b+WccK15guobQ+ogzOlRNGHkxDZq07OVdAdijrVYWuchYI0YXm8S3q3E9cqIqfqAKqjH1UGdp1gXmuidK+tUgglwsPLhL4sKXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aYa4CRIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476C5C4CEEF;
	Thu, 17 Apr 2025 10:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744887109;
	bh=u2wfwayr+ZL0KsrF26Gwf/K4Rp1V9BHWMbRbuUVAkyI=;
	h=Subject:To:Cc:From:Date:From;
	b=aYa4CRIqo+omjKaf6BTmhek3pTFh47Y/B5Frh5YY+L/4tzZeBU4Z2SEYjY2J+LYcw
	 5NWrbYAbE29OnP11/tLHCMPS5fI8puOoaYFiTzmRMYz/7dchH+C4pWiIsM8jOVPGwF
	 0z6Yx6WeHmsOZqBZmT4/c3VCZMLC9rcFoCfWywFA=
Subject: FAILED: patch "[PATCH] soc: samsung: exynos-chipid: Add NULL pointer check in" failed to apply to 5.4-stable tree
To: chenyuan0y@gmail.com,krzysztof.kozlowski@linaro.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:51:34 +0200
Message-ID: <2025041734-saxophone-cranial-0d9b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x c8222ef6cf29dd7cad21643228f96535cc02b327
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041734-saxophone-cranial-0d9b@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c8222ef6cf29dd7cad21643228f96535cc02b327 Mon Sep 17 00:00:00 2001
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Wed, 12 Feb 2025 15:35:18 -0600
Subject: [PATCH] soc: samsung: exynos-chipid: Add NULL pointer check in
 exynos_chipid_probe()

soc_dev_attr->revision could be NULL, thus,
a pointer check is added to prevent potential NULL pointer dereference.
This is similar to the fix in commit 3027e7b15b02
("ice: Fix some null pointer dereference issues in ice_ptp.c").

This issue is found by our static analysis tool.

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Link: https://lore.kernel.org/r/20250212213518.69432-1-chenyuan0y@gmail.com
Fixes: 3253b7b7cd44 ("soc: samsung: Add exynos chipid driver support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index e37dde1fb588..95294462ff21 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -134,6 +134,8 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 
 	soc_dev_attr->revision = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 						"%x", soc_info.revision);
+	if (!soc_dev_attr->revision)
+		return -ENOMEM;
 	soc_dev_attr->soc_id = product_id_to_soc_id(soc_info.product_id);
 	if (!soc_dev_attr->soc_id) {
 		pr_err("Unknown SoC\n");


