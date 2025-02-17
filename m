Return-Path: <stable+bounces-115774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FCAA345C1
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688FD3B0DFA
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7DF145A03;
	Thu, 13 Feb 2025 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="miGitG76"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B3370820;
	Thu, 13 Feb 2025 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459203; cv=none; b=NemrAnA3GoqvoBMy7cFNH6RK8pq0YTHLWoyY4CY/n4OWMQ0whiY8GfwWJ6hJJFUm77alDmU7qdK17xCnO+D0ok+tJFNSb5ALTjXFoLiBACb7S7/iFEa2+oEyxytvLYMUOHCw+/8nd+RrvQYR9op5BQ/AtBseq6W2+FmNxzFMRK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459203; c=relaxed/simple;
	bh=7+ZI+pl3vmrT/T4nNJI4Ow+ZV2nufpkiaLDuovV4tu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JfpA0318I+ezSrql9goZh3KrZhXixgQpNT+Ezw03os49bBnBDEfQSxaem574I2el4d28oyEQqScIRrQ7VjB+geyqXsS76ThpKqwAs0zLWPbEL+6Lcz5VRyepCiR3i+CKt+5eTpLpTah809CrZ0A2bpgP5k9yQfWdzVXrPrfg+xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=miGitG76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9056AC4CEE4;
	Thu, 13 Feb 2025 15:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739459203;
	bh=7+ZI+pl3vmrT/T4nNJI4Ow+ZV2nufpkiaLDuovV4tu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=miGitG76gzlOerT7k3Mre5pjTqFIB9/iRftrL64zCD/jSlJr/wJUy2sQ964acK0hQ
	 Am5Q/Ae80DFUsPXAfGdBwps+tyZcgdE+kCkgMkH1dbKR/aK+TgGLZt9DKGioAKdLiY
	 VJO3NAwLSMYwGtKyolvScXt4OhKE05dCb0r6Ao5E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gabor Juhos <j4g8y7@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.13 197/443] clk: qcom: clk-alpha-pll: fix alpha mode configuration
Date: Thu, 13 Feb 2025 15:26:02 +0100
Message-ID: <20250213142448.215231736@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabor Juhos <j4g8y7@gmail.com>

commit 33f1722eb86e45320a3dd7b3d42f6593a1d595c2 upstream.

Commit c45ae598fc16 ("clk: qcom: support for alpha mode configuration")
added support for configuring alpha mode, but it seems that the feature
was never working in practice.

The value of the alpha_{en,mode}_mask members of the configuration gets
added to the value parameter passed to the regmap_update_bits() function,
however the same values are not getting applied to the bitmask. As the
result, the respective bits in the USER_CTL register are never modifed
which leads to improper configuration of several PLLs.

The following table shows the PLL configurations where the 'alpha_en_mask'
member is set and which are passed as a parameter for the
clk_alpha_pll_configure() function. In the table the 'expected rate' column
shows the rate the PLL should run at with the given configuration, and
the 'real rate' column shows the rate the PLL runs at actually. The real
rates has been verified on hardwareOn IPQ* platforms, on other platforms,
those are computed values only.

      file                 pll         expected rate   real rate
  dispcc-qcm2290.c     disp_cc_pll0      768.0 MHz     768.0 MHz
  dispcc-sm6115.c      disp_cc_pll0      768.0 MHz     768.0 MHz
  gcc-ipq5018.c        ubi32_pll        1000.0 MHz !=  984.0 MHz
  gcc-ipq6018.c        nss_crypto_pll   1200.0 MHz    1200.0 MHz
  gcc-ipq6018.c        ubi32_pll        1497.6 MHz != 1488.0 MHz
  gcc-ipq8074.c        nss_crypto_pll   1200.0 MHz != 1190.4 MHz
  gcc-qcm2290.c        gpll11            532.0 MHz !=  518.4 MHz
  gcc-qcm2290.c        gpll8             533.2 MHz !=  518.4 MHz
  gcc-qcs404.c         gpll3             921.6 MHz     921.6 MHz
  gcc-sm6115.c         gpll11            600.0 MHz !=  595.2 MHz
  gcc-sm6115.c         gpll8             800.0 MHz !=  787.2 MHz
  gpucc-sdm660.c       gpu_cc_pll0       800.0 MHz !=  787.2 MHz
  gpucc-sdm660.c       gpu_cc_pll1       740.0 MHz !=  729.6 MHz
  gpucc-sm6115.c       gpu_cc_pll0      1200.0 MHz != 1190.4 MHz
  gpucc-sm6115.c       gpu_cc_pll1       640.0 MHz !=  633.6 MHz
  gpucc-sm6125.c       gpu_pll0         1020.0 MHz != 1017.6 MHz
  gpucc-sm6125.c       gpu_pll1          930.0 MHz !=  921.6 MHz
  mmcc-sdm660.c        mmpll8            930.0 MHz !=  921.6 MHz
  mmcc-sdm660.c        mmpll5            825.0 MHz !=  806.4 MHz

As it can be seen from the above, there are several PLLs which are
configured incorrectly.

Change the code to apply both 'alpha_en_mask' and 'alpha_mode_mask'
values to the bitmask in order to configure the alpha mode correctly.

Applying the 'alpha_en_mask' fixes the initial rate of the PLLs showed
in the table above. Since the 'alpha_mode_mask' is not used by any driver
currently, that part of the change causes no functional changes.

Cc: stable@vger.kernel.org
Fixes: c45ae598fc16 ("clk: qcom: support for alpha mode configuration")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Gabor Juhos <j4g8y7@gmail.com>
Link: https://lore.kernel.org/r/20241021-fix-alpha-mode-config-v1-1-f32c254e02bc@gmail.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/qcom/clk-alpha-pll.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -432,6 +432,8 @@ void clk_alpha_pll_configure(struct clk_
 	mask |= config->pre_div_mask;
 	mask |= config->post_div_mask;
 	mask |= config->vco_mask;
+	mask |= config->alpha_en_mask;
+	mask |= config->alpha_mode_mask;
 
 	regmap_update_bits(regmap, PLL_USER_CTL(pll), mask, val);
 



