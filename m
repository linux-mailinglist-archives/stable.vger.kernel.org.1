Return-Path: <stable+bounces-133019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69558A919C7
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DE819E470E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70D422AE74;
	Thu, 17 Apr 2025 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yf7i9EHH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885E220C497
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744887097; cv=none; b=fCMyaJmpOXp2Fw7ygplhzLduqiwg5vCtnQU5lMoef+6JNHPdsjhMZQxLXkY72HrSxjP7sknp+7pGD8pC3Wd1/wqN5I+aQQj/UwkirRRt6PH5b70fQyZq4y2/b4rT87SNYNYnvVduJIF6+Wo7CaPwVn4+XLm+nhotqmQ7JVsaBDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744887097; c=relaxed/simple;
	bh=SdvmV2K/Io6p5S15bhAKgL/4ED6vOXipXbv6Hk6rwTY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OUzkTlSbENCDlteQtgUH2L9o3gWQ4QkN6eZFsvpwinZTCz2cit6Jlt1Rjd0knPbKHzSlqwpB/x5TP8wTUy741T4tcRTRtCKqulEEKuILN3XqDmS50tVI6p1mz89YTvvbUm+yRxd94cxsgZIG76E1yzWHQYgqe6fOUq4Tkd8bLj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yf7i9EHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8B2C4CEE7;
	Thu, 17 Apr 2025 10:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744887097;
	bh=SdvmV2K/Io6p5S15bhAKgL/4ED6vOXipXbv6Hk6rwTY=;
	h=Subject:To:Cc:From:Date:From;
	b=Yf7i9EHH/lMO2cdrIVcpLS0mPAHnYx0VWPw+Xw+Ik+hFhgfqS+7DubvBsqeEt2D5H
	 5qmicx4e/yaT4bzdUKAnlcJPWXwkEjF0xmNzobPR0ZQNk7TVD+iPjEhAD0dxEvtG8t
	 YcAXheD1dx50kkJehlPj66ij3viuDxjnjJNKoXao=
Subject: FAILED: patch "[PATCH] soc: samsung: exynos-chipid: Add NULL pointer check in" failed to apply to 5.15-stable tree
To: chenyuan0y@gmail.com,krzysztof.kozlowski@linaro.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:51:34 +0200
Message-ID: <2025041733-seventy-pulse-890f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c8222ef6cf29dd7cad21643228f96535cc02b327
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041733-seventy-pulse-890f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


