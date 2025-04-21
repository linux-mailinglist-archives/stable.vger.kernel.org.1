Return-Path: <stable+bounces-134782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9768AA95069
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3DF17225B
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 11:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3A721420A;
	Mon, 21 Apr 2025 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LWfstBcm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF5E20C485
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745236182; cv=none; b=TLMkn+ISPaHo+1/SjqU6dkJkK1CvayVc6KEe5yWCu41SHtY/ckeEH5yAsRKUxfTianEuX2rmDBhzefY4DYcJb3QSTEvbdOvv/cSU/356Hwhnr6cIln/jnycRQi8kPW0ihUBUJj+9FxwiqXfbDDwLxewpBPVOgCRHkkB2whsnQh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745236182; c=relaxed/simple;
	bh=awd9YLv/rksZ5v+lh/4Ev5oobSvNtx8Fc1u6YWjBicU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MmbKEIHteOgAzX2rGYuiIJydFc+eXAi4g5BC6qZ+LDvIV61HPcI6Js9AVQMJ0R/ia2DPxnhpgxMSoU5XZoT7du/b8QclGcxkJuM/wK983g+39VlzjS5H31f+8z+c1+R+hx9LFitTX+ywyglMatKs++Aepb0BcWZLpEYn9rrbv5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LWfstBcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07862C4CEE4;
	Mon, 21 Apr 2025 11:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745236181;
	bh=awd9YLv/rksZ5v+lh/4Ev5oobSvNtx8Fc1u6YWjBicU=;
	h=Subject:To:Cc:From:Date:From;
	b=LWfstBcmduVdlAI3zXdJ0OtBB85wok7+k31gIhbN4DGLx/yxoCi+O4765Gl2xZ/bq
	 I07WOD2lqVDwdXtNUzBRHne3c6qr/kfAVoY2SKVnxKzalcOQvTr/hX9qg9wq5xmu69
	 NOFfjEXqMOc8ZqDoB2sn2cCiGAfVXv+HI6NAFgdM=
Subject: FAILED: patch "[PATCH] ASoC: qcom: Fix sc7280 lpass potential buffer overflow" failed to apply to 6.1-stable tree
To: pimenoveu12@gmail.com,broonie@kernel.org,khoroshilov@ispras.ru,m.kobuk@ispras.ru
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 13:49:38 +0200
Message-ID: <2025042138-spherical-reabsorb-d6da@gregkh>
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
git cherry-pick -x a31a4934b31faea76e735bab17e63d02fcd8e029
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042138-spherical-reabsorb-d6da@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a31a4934b31faea76e735bab17e63d02fcd8e029 Mon Sep 17 00:00:00 2001
From: Evgeny Pimenov <pimenoveu12@gmail.com>
Date: Tue, 1 Apr 2025 23:40:58 +0300
Subject: [PATCH] ASoC: qcom: Fix sc7280 lpass potential buffer overflow

Case values introduced in commit
5f78e1fb7a3e ("ASoC: qcom: Add driver support for audioreach solution")
cause out of bounds access in arrays of sc7280 driver data (e.g. in case
of RX_CODEC_DMA_RX_0 in sc7280_snd_hw_params()).

Redefine LPASS_MAX_PORTS to consider the maximum possible port id for
q6dsp as sc7280 driver utilizes some of those values.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 77d0ffef793d ("ASoC: qcom: Add macro for lpass DAI id's max limit")
Cc: stable@vger.kernel.org # v6.0+
Suggested-by: Mikhail Kobuk <m.kobuk@ispras.ru>
Suggested-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Evgeny Pimenov <pimenoveu12@gmail.com>
Link: https://patch.msgid.link/20250401204058.32261-1-pimenoveu12@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 27a2bf9a6613..de3ec6f594c1 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -13,10 +13,11 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <dt-bindings/sound/qcom,lpass.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
 #include "lpass-hdmi.h"
 
 #define LPASS_AHBIX_CLOCK_FREQUENCY		131072000
-#define LPASS_MAX_PORTS			(LPASS_CDC_DMA_VA_TX8 + 1)
+#define LPASS_MAX_PORTS			(DISPLAY_PORT_RX_7 + 1)
 #define LPASS_MAX_MI2S_PORTS			(8)
 #define LPASS_MAX_DMA_CHANNELS			(8)
 #define LPASS_MAX_HDMI_DMA_CHANNELS		(4)


