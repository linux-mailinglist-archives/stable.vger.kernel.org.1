Return-Path: <stable+bounces-151418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C87ACDFF1
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 16:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E981B170312
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 14:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22741290BCE;
	Wed,  4 Jun 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rg9iLF0s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAC528EA65
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046277; cv=none; b=VVPdT15fLm5XXZTWCatzckF7Ar18tVQhWtDpjDF6BcO5Kk2F/b6A8jB43KfQwiK1xvCl+3QltCsrGDNkN1gEQSfMXvyxebMOT/qEkA1CkvmfGl0xb6AxnvKVecWtrf3da100EUGGa3Trh029MA/EUeonSwK6ur6oc/3IFPQmY3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046277; c=relaxed/simple;
	bh=pcE6GDbR3ZTyF94j4bU9tVRa3iZUIJ0O2KdBtM00XWw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mhqiHafS/QmJJ8W1+bNQN/1+3goBFwO99VFGohP/52oOWZNMUrugr/bScYyX3pLqQC6ZNQNW8RMwkZ5sS+39S8L4OlzH6frOqHGtSCE7zCF7Pbnald+KMnSnTC1rCIfm6fQKRM0HtOkPvB3RJ9OOq0MgKBK2Z8Y/WeH6bmPOR18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rg9iLF0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1EDC4CEE4;
	Wed,  4 Jun 2025 14:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749046277;
	bh=pcE6GDbR3ZTyF94j4bU9tVRa3iZUIJ0O2KdBtM00XWw=;
	h=Subject:To:Cc:From:Date:From;
	b=rg9iLF0sOpL9oRaHwm4I35RySvpEwmIX8jif8wR6tfZ6FzSF5SWB0nCP73yLhpd6Y
	 Z3B2FlRPvnB3YHxlvOwcyy9nEvx80YjOJ4JcG+cQ/P7/0totY4vcCjzyEhQLDeVyXs
	 JcJPdqTIUWfq2b0BhNvNkXhZ+SRXo9dpKI8NFslU=
Subject: FAILED: patch "[PATCH] clk: samsung: correct clock summary for hsi1 block" failed to apply to 6.12-stable tree
To: pritam.sutar@samsung.com,alim.akhtar@samsung.com,krzysztof.kozlowski@linaro.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Jun 2025 16:11:14 +0200
Message-ID: <2025060414-sprinkler-species-7979@gregkh>
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
git cherry-pick -x 81214185e7e1fc6dfc8661a574c457accaf9a5a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025060414-sprinkler-species-7979@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 81214185e7e1fc6dfc8661a574c457accaf9a5a4 Mon Sep 17 00:00:00 2001
From: Pritam Manohar Sutar <pritam.sutar@samsung.com>
Date: Tue, 6 May 2025 13:31:54 +0530
Subject: [PATCH] clk: samsung: correct clock summary for hsi1 block

clk_summary shows wrong value for "mout_hsi1_usbdrd_user".
It shows 400Mhz instead of 40Mhz as below.

dout_shared2_div4           1 1 0 400000000 0 0 50000 Y ...
  mout_hsi1_usbdrd_user     0 0 0 400000000 0 0 50000 Y ...
    dout_clkcmu_hsi1_usbdrd 0 0 0 40000000  0 0 50000 Y ...

Correct the clk_tree by adding correct clock parent for
"mout_hsi1_usbdrd_user".

Post this change, clk_summary shows correct value.

dout_shared2_div4           1 1 0 400000000 0 0 50000 Y ...
  mout_clkcmu_hsi1_usbdrd   0 0 0 400000000 0 0 50000 Y ...
    dout_clkcmu_hsi1_usbdrd 0 0 0 40000000  0 0 50000 Y ...
      mout_hsi1_usbdrd_user 0 0 0 40000000  0 0 50000 Y ...

Fixes: 485e13fe2fb6 ("clk: samsung: add top clock support for ExynosAuto v920 SoC")
Cc: <stable@kernel.org>
Signed-off-by: Pritam Manohar Sutar <pritam.sutar@samsung.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Link: https://lore.kernel.org/r/20250506080154.3995512-1-pritam.sutar@samsung.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

diff --git a/drivers/clk/samsung/clk-exynosautov920.c b/drivers/clk/samsung/clk-exynosautov920.c
index f8168eed4a66..da4afe8ac2ab 100644
--- a/drivers/clk/samsung/clk-exynosautov920.c
+++ b/drivers/clk/samsung/clk-exynosautov920.c
@@ -1729,7 +1729,7 @@ static const unsigned long hsi1_clk_regs[] __initconst = {
 /* List of parent clocks for Muxes in CMU_HSI1 */
 PNAME(mout_hsi1_mmc_card_user_p) = {"oscclk", "dout_clkcmu_hsi1_mmc_card"};
 PNAME(mout_hsi1_noc_user_p) = { "oscclk", "dout_clkcmu_hsi1_noc" };
-PNAME(mout_hsi1_usbdrd_user_p) = { "oscclk", "mout_clkcmu_hsi1_usbdrd" };
+PNAME(mout_hsi1_usbdrd_user_p) = { "oscclk", "dout_clkcmu_hsi1_usbdrd" };
 PNAME(mout_hsi1_usbdrd_p) = { "dout_tcxo_div2", "mout_hsi1_usbdrd_user" };
 
 static const struct samsung_mux_clock hsi1_mux_clks[] __initconst = {


