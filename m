Return-Path: <stable+bounces-81235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D42F0992817
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 11:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B921281734
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 09:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F6D18CC0A;
	Mon,  7 Oct 2024 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I5nE8wVo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269981741E0
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293340; cv=none; b=Aga7x6JbMZwYVKcu/VynrckBrtUc2WKz4s2k3OP3bDveAkt8pMPbrc5wpK32Vgn9EKnvsCRrdAp/0JVyiwPEStCfwPXo/h2kfiMa8vdB2V+br4fLDTfu5o7sAmC8sg7l8mJ5cEs3YAiubH6oiuclZ/BX/dIcqLwlv2u5iEb5njI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293340; c=relaxed/simple;
	bh=LqJd4Xa1f8MCwaKEvLxJqAxXOtBSygts+X9RK566RKE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=btWcgZfT2RoPo6pIIj3r+leVb3w4S5+C777SUVc4vyMcmFk4o5nHwR0hAqE9cDXIpJON+XdtGA4b3VqGvj3Bb4ZdeQXwjeTsI6AOu7Qmxw647teHtdEe2MthrXFs6A5sDngdYF/J53sq3OTD7PimpPk5X1FjiifnYSf5tZmy5aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I5nE8wVo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9ABC4CECC;
	Mon,  7 Oct 2024 09:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728293339;
	bh=LqJd4Xa1f8MCwaKEvLxJqAxXOtBSygts+X9RK566RKE=;
	h=Subject:To:Cc:From:Date:From;
	b=I5nE8wVoIG8u+4mN7IFccym2/5jv58xAwdlDN8F6AF3orstc+DZDPaFBYvAciUemF
	 wJ8PzJ1SqtgwJ43ovyVPL8bzELr1H7ubXXXQTanArPTLbRXhWd+GAfgffgltbigDsc
	 4647TzKqFiUj48yzSxXV9I1V+3wBtEcOw595CNWM=
Subject: FAILED: patch "[PATCH] dt-bindings: clock: exynos7885: Fix duplicated binding" failed to apply to 6.1-stable tree
To: virag.david003@gmail.com,krzysztof.kozlowski@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 11:28:57 +0200
Message-ID: <2024100757-huntress-lunacy-e567@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x abf3a3ea9acb5c886c8729191a670744ecd42024
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100757-huntress-lunacy-e567@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

abf3a3ea9acb ("dt-bindings: clock: exynos7885: Fix duplicated binding")
b3f9581affb0 ("dt-bindings: clock: samsung: remove define with number of clocks")
284f6dcb50ae ("dt-bindings: clock: exynos850: Add AUD and HSI main gate clocks")
521568cff706 ("dt-bindings: clock: exynos850: Add Exynos850 CMU_G3D")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From abf3a3ea9acb5c886c8729191a670744ecd42024 Mon Sep 17 00:00:00 2001
From: David Virag <virag.david003@gmail.com>
Date: Tue, 6 Aug 2024 14:11:44 +0200
Subject: [PATCH] dt-bindings: clock: exynos7885: Fix duplicated binding

The numbering in Exynos7885's FSYS CMU bindings has 4 duplicated by
accident, with the rest of the bindings continuing with 5.

Fix this by moving CLK_MOUT_FSYS_USB30DRD_USER to the end as 11.

Since CLK_MOUT_FSYS_USB30DRD_USER is not used in any device tree as of
now, and there are no other clocks affected (maybe apart from
CLK_MOUT_FSYS_MMC_SDIO_USER which the number was shared with, also not
used in a device tree), this is the least impactful way to solve this
problem.

Fixes: cd268e309c29 ("dt-bindings: clock: Add bindings for Exynos7885 CMU_FSYS")
Cc: stable@vger.kernel.org
Signed-off-by: David Virag <virag.david003@gmail.com>
Link: https://lore.kernel.org/r/20240806121157.479212-2-virag.david003@gmail.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

diff --git a/include/dt-bindings/clock/exynos7885.h b/include/dt-bindings/clock/exynos7885.h
index 255e3aa94323..54cfccff8508 100644
--- a/include/dt-bindings/clock/exynos7885.h
+++ b/include/dt-bindings/clock/exynos7885.h
@@ -136,12 +136,12 @@
 #define CLK_MOUT_FSYS_MMC_CARD_USER	2
 #define CLK_MOUT_FSYS_MMC_EMBD_USER	3
 #define CLK_MOUT_FSYS_MMC_SDIO_USER	4
-#define CLK_MOUT_FSYS_USB30DRD_USER	4
 #define CLK_GOUT_MMC_CARD_ACLK		5
 #define CLK_GOUT_MMC_CARD_SDCLKIN	6
 #define CLK_GOUT_MMC_EMBD_ACLK		7
 #define CLK_GOUT_MMC_EMBD_SDCLKIN	8
 #define CLK_GOUT_MMC_SDIO_ACLK		9
 #define CLK_GOUT_MMC_SDIO_SDCLKIN	10
+#define CLK_MOUT_FSYS_USB30DRD_USER	11
 
 #endif /* _DT_BINDINGS_CLOCK_EXYNOS_7885_H */


