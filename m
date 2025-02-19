Return-Path: <stable+bounces-118032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C1DA3B9DD
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19269800091
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD131D6DBC;
	Wed, 19 Feb 2025 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TOCM0HTs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2FD28629E;
	Wed, 19 Feb 2025 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957044; cv=none; b=ZICs+0YYfYPww7PA+j7LpBGPUP9JqHmOmhA64gCo1vypba20KIBsS9zPbkchTIpJvx7I0Lh4JW1zCmMkgwyR45KZXH/kJR5YdQK3uXluAwHpryvC7TszUL3WFmxUX0AADyUYmObKV69EJecyIkAzIrSy3VmVx3LBuGS7MnCprSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957044; c=relaxed/simple;
	bh=B+r8h714TzZDm6/GVMEkluR8B14H0xEGN7CWnfVNZlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b97yUwJdfENznOclD2Avk2J8ZTZmZ6zoyklWgZFShgYxs6AvqSuyjY37wxQCZFpNsLorUYvrow87T59nl07gBU42f0YmeCMIdiuP0kT4axGDPL5zwfoWgPtnJr5C/L614x9SyGxf0R6i5S/atCZBLBNiV197Ek7bue3vDDkNH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TOCM0HTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73487C4CED1;
	Wed, 19 Feb 2025 09:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739957044;
	bh=B+r8h714TzZDm6/GVMEkluR8B14H0xEGN7CWnfVNZlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOCM0HTsr826i+Z6asYdcmKzxLxG9bXT8iUj3vpqAv/wpWRI9VisGUkwxqfUa1D6C
	 1gWfaJnrB7FAtHvC1rXmXi7XHKR24wAQmMLPKkjUIrUQaKRFfi9CdLyxgm6IPfGwbo
	 Bql0oWWkbv9IqSTqJqhajP7fdrVWl7897YTtKABY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gabor Juhos <j4g8y7@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.1 357/578] clk: qcom: clk-alpha-pll: fix alpha mode configuration
Date: Wed, 19 Feb 2025 09:26:01 +0100
Message-ID: <20250219082707.065628629@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -339,6 +339,8 @@ void clk_alpha_pll_configure(struct clk_
 	mask |= config->pre_div_mask;
 	mask |= config->post_div_mask;
 	mask |= config->vco_mask;
+	mask |= config->alpha_en_mask;
+	mask |= config->alpha_mode_mask;
 
 	regmap_update_bits(regmap, PLL_USER_CTL(pll), mask, val);
 



