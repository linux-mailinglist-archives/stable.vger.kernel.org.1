Return-Path: <stable+bounces-81391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADE3993414
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 18:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9362827A8
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373621DC741;
	Mon,  7 Oct 2024 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZU7pxsuY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1481DC72A
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319895; cv=none; b=hNhu+kAMY1t7xel2fDQZtNVyRhW6UK0v2KJcMSsx+GVAugLnuUTc4+GoUX+2ZCBgrc0DyvLPXhOA7CC41yv7vGtqXAiICEladdMWYCaf6ZFGgC36PIUobDjcLRUs0KS6594rcO3A/yETT4s1nCrSl1r6JeHNxwahoZdizTZB9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319895; c=relaxed/simple;
	bh=Dw7yyo13udm1Z9QXLTrj263xVWZIhyZI48zFkrnBJJ8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fC3HAmdXO/wl4N4MtMQg73fEXP1sclt6ompureIUh3w1UQXDdq5bkecPg02w5H0FlwWcyJwcderDbWcm3QkMG6pUz8mWBC52cgvNlI7OhJzkmpoDRa5mbYHWL4LJVONArblGCX/OtXXeDQwjx2Blkc/jjUW6jnNU2arCxtM6qcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZU7pxsuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B783C4CEC6;
	Mon,  7 Oct 2024 16:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728319894;
	bh=Dw7yyo13udm1Z9QXLTrj263xVWZIhyZI48zFkrnBJJ8=;
	h=Subject:To:Cc:From:Date:From;
	b=ZU7pxsuY04pUNR+ObEkXbzX6/j7+IP+oPuqqWTk6/vgBCFFPUTqYQVkk6TDWG/Kw2
	 J2v30vpI1MDKItucsNfi24GgKh1kdlU8Wdiqc7bKF9Q8isn5qrNMZO/LguZQb4jd7u
	 xI5Xdla4GlLH7qNxa/TVmKwpJ58OGGMJet4hR9qM=
Subject: FAILED: patch "[PATCH] clk: samsung: exynos7885: Update CLKS_NR_FSYS after bindings" failed to apply to 6.12-stable tree
To: virag.david003@gmail.com,krzysztof.kozlowski@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 18:51:31 +0200
Message-ID: <2024100731-affidavit-legibly-02fb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 217a5f23c290c349ceaa37a6f2c014ad4c2d5759
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100731-affidavit-legibly-02fb@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



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
 


