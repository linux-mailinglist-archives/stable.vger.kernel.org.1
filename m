Return-Path: <stable+bounces-43683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1AB8C42BE
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 16:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 869DB2816C1
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8758153572;
	Mon, 13 May 2024 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OJSa0ft0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F581474BB
	for <stable@vger.kernel.org>; Mon, 13 May 2024 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608801; cv=none; b=fHjkk/pf2Wn57TxzCKCRu2k69tkIjKMCR+qMHoCaOfgIJhL6IYZaSmHdZ6tMQac1FU9gYkFW4t8wW5jLEa+QF1Eu3ora80TtSeKbuPjZ0kDbX1wCOOQUM8022iepa9ogMUJfWJM30uOvmVae8tyhi6o8xaEE2dWysMXNyAtMT98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608801; c=relaxed/simple;
	bh=/Phhm086Zba+cJrh9lj8Lv16UBq9WYtZqnBnwiqI/Uo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sfZv44chh7st183TfsQM3k1PRdPubDQK/xd+JyTOGz94bGbHA/rrqn6hAjbcSYG3WSFZMw0wn5XkV4d63uqfE49rAMOcpp+NvjSTeTOLGaCBtvjdxV8Owz1/tj8Qt0GdBZ8nQwnXcpC6r/7+WS3oOHtrSaSVA0ngM298dUgI1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OJSa0ft0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CABC32781;
	Mon, 13 May 2024 14:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715608801;
	bh=/Phhm086Zba+cJrh9lj8Lv16UBq9WYtZqnBnwiqI/Uo=;
	h=Subject:To:Cc:From:Date:From;
	b=OJSa0ft06ASWy0khJJUlkoS/BZRwa1aRDe6jmUXF4j48BXWs7A30D+wJOC/4AeHHJ
	 x7Tf2oHBD3HYxG3h0cP/3p41CYnxPpQv2YSuPw/L0/SNAnF7GH3GlFfso/kFmnlZHf
	 eye3L57bXUbsZoTfajTqalDzoACl7ZWM8xo+avWI=
Subject: FAILED: patch "[PATCH] ASoC: ti: davinci-mcasp: Fix race condition during probe" failed to apply to 5.10-stable tree
To: joao.goncalves@toradex.com,broonie@kernel.org,j-luthra@ti.com,peter.ujfalusi@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:59:57 +0200
Message-ID: <2024051357-errand-chariot-abc6@gregkh>
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
git cherry-pick -x d18ca8635db2f88c17acbdf6412f26d4f6aff414
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051357-errand-chariot-abc6@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

d18ca8635db2 ("ASoC: ti: davinci-mcasp: Fix race condition during probe")
1b4fb70e5b28 ("ASoC: ti: davinci-mcasp: Handle missing required DT properties")

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


