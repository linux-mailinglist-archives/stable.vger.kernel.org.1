Return-Path: <stable+bounces-81392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C0B993415
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 18:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE641C23025
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368601DC746;
	Mon,  7 Oct 2024 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WPwM1HNI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA141DC730
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319898; cv=none; b=uV6oTcxZpQkeNA+Gi384xA339QrRfNzVwT+VMeJGTyx6ypN+ev/X+FEUSm/CGBUdUUP7AEdSJOM80hb93Re5O9XnqvQ9b8fEA6qb4EV8ia3nBl6KfoZQLnXsJpSNjTOdhnmRTu12Z804cfYwx8S2qmZI+FZq4M+1bR+5dyVtz3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319898; c=relaxed/simple;
	bh=eCZcPrg8wVnlZ/B3WxbuyJazFs7TAt3GOfilb5gruys=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=H41PSMPOMQtsmZkMlh17vB8xEYUID/Q/RS/Bc+jpYTmnOroI/bBt/cXbSqUhIQxmML20yx/iEqEWFAQxU1w0ff+QxLNUp+DuURGd94JBVDRKZji3aWMEqUSnrKTuBpiq4F1QVKC6ZVWHyIYRuB+Y7aYhuzUBwvQVITAAIu3qaVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WPwM1HNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4C5C4CEC6;
	Mon,  7 Oct 2024 16:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728319898;
	bh=eCZcPrg8wVnlZ/B3WxbuyJazFs7TAt3GOfilb5gruys=;
	h=Subject:To:Cc:From:Date:From;
	b=WPwM1HNITusReJIHpEs2uUN3/oetMjDgKPvdO/c3jN5kU1e40h26RORJkQFtign7l
	 wQLSvLLv5ngqjJwMiJt4ULjTGVm0ENlMbGfbhwgIQZAZLSVW8+xQGzI/4jmfxomjtg
	 O3hmeJ3jirXrG4TXpql0Sm0ZGszoXlcaZGdNsIq8=
Subject: FAILED: patch "[PATCH] clk: samsung: exynos7885: Update CLKS_NR_FSYS after bindings" failed to apply to 6.1-stable tree
To: virag.david003@gmail.com,krzysztof.kozlowski@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 18:51:33 +0200
Message-ID: <2024100733-baggie-dirtiness-7e34@gregkh>
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
git cherry-pick -x 217a5f23c290c349ceaa37a6f2c014ad4c2d5759
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100733-baggie-dirtiness-7e34@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

217a5f23c290 ("clk: samsung: exynos7885: Update CLKS_NR_FSYS after bindings fix")
ef4923c8e052 ("clk: samsung: exynos7885: do not define number of clocks in bindings")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 217a5f23c290c349ceaa37a6f2c014ad4c2d5759 Mon Sep 17 00:00:00 2001
From: David Virag <virag.david003@gmail.com>
Date: Tue, 6 Aug 2024 14:11:47 +0200
Subject: [PATCH] clk: samsung: exynos7885: Update CLKS_NR_FSYS after bindings
 fix

Update CLKS_NR_FSYS to the proper value after a fix in DT bindings.
This should always be the last clock in a CMU + 1.

Fixes: cd268e309c29 ("dt-bindings: clock: Add bindings for Exynos7885 CMU_FSYS")
Cc: stable@vger.kernel.org
Signed-off-by: David Virag <virag.david003@gmail.com>
Link: https://lore.kernel.org/r/20240806121157.479212-5-virag.david003@gmail.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

diff --git a/drivers/clk/samsung/clk-exynos7885.c b/drivers/clk/samsung/clk-exynos7885.c
index f7d7427a558b..87387d4cbf48 100644
--- a/drivers/clk/samsung/clk-exynos7885.c
+++ b/drivers/clk/samsung/clk-exynos7885.c
@@ -20,7 +20,7 @@
 #define CLKS_NR_TOP			(CLK_GOUT_FSYS_USB30DRD + 1)
 #define CLKS_NR_CORE			(CLK_GOUT_TREX_P_CORE_PCLK_P_CORE + 1)
 #define CLKS_NR_PERI			(CLK_GOUT_WDT1_PCLK + 1)
-#define CLKS_NR_FSYS			(CLK_GOUT_MMC_SDIO_SDCLKIN + 1)
+#define CLKS_NR_FSYS			(CLK_MOUT_FSYS_USB30DRD_USER + 1)
 
 /* ---- CMU_TOP ------------------------------------------------------------- */
 


