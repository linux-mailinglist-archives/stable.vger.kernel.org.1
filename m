Return-Path: <stable+bounces-136871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8CCA9EFDD
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 13:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B413BE7C5
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A3726158A;
	Mon, 28 Apr 2025 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="joMLodb9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8483A1FBEA4
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841431; cv=none; b=Cdv6jTk+HwWHC31DRgYcVKpJuFFX+QJUuBhh12/5tRjIFprJQUJdyrecj13I7uJEsmexRf14mAxzx4X6kuJrstrNGpusm4QD2cIpi/Kr2oYNaXGvKfulO0oexRytTtWC8tK9kly5dSq2KKp8d/mUMKBOkGZecT8uC1KRHJMAOG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841431; c=relaxed/simple;
	bh=c9VuJuEo6HVM20UPE9oJEQJ/p93LEROgT3NRZ4ILDwk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QonCZ6iT60f02d5qAht2AhJE1zDDJ7+j+DG7lqIDr5tjp1tIon55QkJ0xGETh+IoVXXQSPaLNFXtD64ScgLlc/WjUbsM9QuE1NC8U1FAgx1pHQA1mPZ650qXEwArd2P46EtxhF1J/Fx8Z/3wqabl6fuX4/P4wUx1R1QYgbiNicI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=joMLodb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FD7C4CEE9;
	Mon, 28 Apr 2025 11:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745841431;
	bh=c9VuJuEo6HVM20UPE9oJEQJ/p93LEROgT3NRZ4ILDwk=;
	h=Subject:To:Cc:From:Date:From;
	b=joMLodb90QUxDAu7gCGOXEfs8mFwhCrmGXpZrF97H3Ry2xDbk1s9bGb/vrEe7EFF7
	 35C7gDjMIoQxG3IYHwWYq0o84fuuOthgzR4cigD3ApK1gnsa6wApCH1SvaSThVN1kZ
	 2mx8c0BJQLjGD+XEaDBIfuznA68dVfQkF/rQ5ZPc=
Subject: FAILED: patch "[PATCH] Revert "drm/meson: vclk: fix calculation of 59.94 fractional" failed to apply to 5.10-stable tree
To: christianshewitt@gmail.com,martin.blumenstingl@googlemail.com,neil.armstrong@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 13:56:52 +0200
Message-ID: <2025042852-shrewdly-dill-2adb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f37bb5486ea536c1d61df89feeaeff3f84f0b560
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042852-shrewdly-dill-2adb@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f37bb5486ea536c1d61df89feeaeff3f84f0b560 Mon Sep 17 00:00:00 2001
From: Christian Hewitt <christianshewitt@gmail.com>
Date: Mon, 21 Apr 2025 22:12:59 +0200
Subject: [PATCH] Revert "drm/meson: vclk: fix calculation of 59.94 fractional
 rates"

This reverts commit bfbc68e.

The patch does permit the offending YUV420 @ 59.94 phy_freq and
vclk_freq mode to match in calculations. It also results in all
fractional rates being unavailable for use. This was unintended
and requires the patch to be reverted.

Fixes: bfbc68e4d869 ("drm/meson: vclk: fix calculation of 59.94 fractional rates")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20250421201300.778955-2-martin.blumenstingl@googlemail.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20250421201300.778955-2-martin.blumenstingl@googlemail.com

diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index 2a942dc6a6dc..2a82119eb58e 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -790,13 +790,13 @@ meson_vclk_vic_supported_freq(struct meson_drm *priv, unsigned int phy_freq,
 				 FREQ_1000_1001(params[i].pixel_freq));
 		DRM_DEBUG_DRIVER("i = %d phy_freq = %d alt = %d\n",
 				 i, params[i].phy_freq,
-				 FREQ_1000_1001(params[i].phy_freq/1000)*1000);
+				 FREQ_1000_1001(params[i].phy_freq/10)*10);
 		/* Match strict frequency */
 		if (phy_freq == params[i].phy_freq &&
 		    vclk_freq == params[i].vclk_freq)
 			return MODE_OK;
 		/* Match 1000/1001 variant */
-		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/1000)*1000) &&
+		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/10)*10) &&
 		    vclk_freq == FREQ_1000_1001(params[i].vclk_freq))
 			return MODE_OK;
 	}
@@ -1070,7 +1070,7 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 
 	for (freq = 0 ; params[freq].pixel_freq ; ++freq) {
 		if ((phy_freq == params[freq].phy_freq ||
-		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/1000)*1000) &&
+		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/10)*10) &&
 		    (vclk_freq == params[freq].vclk_freq ||
 		     vclk_freq == FREQ_1000_1001(params[freq].vclk_freq))) {
 			if (vclk_freq != params[freq].vclk_freq)


