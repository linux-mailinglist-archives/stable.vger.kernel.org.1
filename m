Return-Path: <stable+bounces-43684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6FC8C42BF
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 16:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD3BEB21384
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 14:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8244153572;
	Mon, 13 May 2024 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F6tU2e22"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8644F1474BB
	for <stable@vger.kernel.org>; Mon, 13 May 2024 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608807; cv=none; b=MFBB6pee2qxfew1ujDbXZL0lyS9NcxIPb2nZSuv9ss3H7Zyj9Dxs/9x+/s1G1tW2yy1CtUnzjatl27l+pabFXG62P/MS6liWezH+DcfSdrEDivGg4WQbL9ArCKVPRSIoaZYtfi4EnjOfO1i2vqhQiPwfxRQzfFZu/YyJa096vfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608807; c=relaxed/simple;
	bh=YkTsrxhlhyDLPgWp2C5406Mre7wLi/2s11xEBVv9cX0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VGjj7F3TMip3UO1TCjNC7YrgQbk7vfwdBPwLMfP1YdQFEa/tIwYBDIL6xWketu5+y7nB3sbwXu5jQWtv4ECb41GGG45T7jB1hlvbi0h3hz0Mca6d6jGIvosu3OA7l6nFAGeX28eTsvDH01EaWUvdY8oznQs6u1TFomltHCzxlF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F6tU2e22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7B3C4AF10;
	Mon, 13 May 2024 14:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715608807;
	bh=YkTsrxhlhyDLPgWp2C5406Mre7wLi/2s11xEBVv9cX0=;
	h=Subject:To:Cc:From:Date:From;
	b=F6tU2e22pxTpmt39WwGZTvqCYGK0BcdMdIi1+aKE5wR++bXxF0YQBd/0Te0OiTY7s
	 lj1WyQLywYP3VCk4ux+4JNJYiR5FrZ3UbXGnzBo1XXdcxAPTTvIxJDTuaVd7pDQZqm
	 Vs6ToxZQ46sdowEbKjDMkAjrflAK16WILm1JQUng=
Subject: FAILED: patch "[PATCH] ASoC: ti: davinci-mcasp: Fix race condition during probe" failed to apply to 5.4-stable tree
To: joao.goncalves@toradex.com,broonie@kernel.org,j-luthra@ti.com,peter.ujfalusi@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 16:00:03 +0200
Message-ID: <2024051302-deluge-renovate-d904@gregkh>
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
git cherry-pick -x d18ca8635db2f88c17acbdf6412f26d4f6aff414
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051302-deluge-renovate-d904@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

d18ca8635db2 ("ASoC: ti: davinci-mcasp: Fix race condition during probe")
1b4fb70e5b28 ("ASoC: ti: davinci-mcasp: Handle missing required DT properties")
1125d925990b ("ASoC: ti: davinci-mcasp: Simplify the configuration parameter handling")
db8793a39b29 ("ASoC: ti: davinci-mcasp: Remove legacy dma_request parsing")
372c4bd11de1 ("ASoC: ti: davinci-mcasp: Use platform_get_irq_byname_optional")
19f6e424d615 ("ASoC: ti: davinci-mcasp: remove always zero of davinci_mcasp_get_dt_params")
f4d95de415b2 ("ASoC: ti: davinci-mcasp: remove redundant assignment to variable ret")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d18ca8635db2f88c17acbdf6412f26d4f6aff414 Mon Sep 17 00:00:00 2001
From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
Date: Wed, 17 Apr 2024 15:41:38 -0300
Subject: [PATCH] ASoC: ti: davinci-mcasp: Fix race condition during probe

When using davinci-mcasp as CPU DAI with simple-card, there are some
conditions that cause simple-card to finish registering a sound card before
davinci-mcasp finishes registering all sound components. This creates a
non-working sound card from userspace with no problem indication apart
from not being able to play/record audio on a PCM stream. The issue
arises during simultaneous probe execution of both drivers. Specifically,
the simple-card driver, awaiting a CPU DAI, proceeds as soon as
davinci-mcasp registers its DAI. However, this process can lead to the
client mutex lock (client_mutex in soc-core.c) being held or davinci-mcasp
being preempted before PCM DMA registration on davinci-mcasp finishes.
This situation occurs when the probes of both drivers run concurrently.
Below is the code path for this condition. To solve the issue, defer
davinci-mcasp CPU DAI registration to the last step in the audio part of
it. This way, simple-card CPU DAI parsing will be deferred until all
audio components are registered.

Fail Code Path:

simple-card.c: probe starts
simple-card.c: simple_dai_link_of: simple_parse_node(..,cpu,..) returns EPROBE_DEFER, no CPU DAI yet
davinci-mcasp.c: probe starts
davinci-mcasp.c: devm_snd_soc_register_component() register CPU DAI
simple-card.c: probes again, finish CPU DAI parsing and call devm_snd_soc_register_card()
simple-card.c: finish probe
davinci-mcasp.c: *dma_pcm_platform_register() register PCM  DMA
davinci-mcasp.c: probe finish

Cc: stable@vger.kernel.org
Fixes: 9fbd58cf4ab0 ("ASoC: davinci-mcasp: Choose PCM driver based on configured DMA controller")
Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Reviewed-by: Jai Luthra <j-luthra@ti.com>
Link: https://lore.kernel.org/r/20240417184138.1104774-1-jpaulo.silvagoncalves@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index b892d66f7847..1e760c315521 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -2417,12 +2417,6 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	mcasp_reparent_fck(pdev);
 
-	ret = devm_snd_soc_register_component(&pdev->dev, &davinci_mcasp_component,
-					      &davinci_mcasp_dai[mcasp->op_mode], 1);
-
-	if (ret != 0)
-		goto err;
-
 	ret = davinci_mcasp_get_dma_type(mcasp);
 	switch (ret) {
 	case PCM_EDMA:
@@ -2449,6 +2443,12 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		goto err;
 	}
 
+	ret = devm_snd_soc_register_component(&pdev->dev, &davinci_mcasp_component,
+					      &davinci_mcasp_dai[mcasp->op_mode], 1);
+
+	if (ret != 0)
+		goto err;
+
 no_audio:
 	ret = davinci_mcasp_init_gpiochip(mcasp);
 	if (ret) {


