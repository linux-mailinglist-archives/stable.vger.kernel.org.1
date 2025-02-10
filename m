Return-Path: <stable+bounces-114560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF568A2EEBF
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40DB3A3B02
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F7822FDFA;
	Mon, 10 Feb 2025 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TeWHUdHp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E2E17BB6
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195351; cv=none; b=CxfwzRtBsKMI9PpBS2yLbAKJoLIkjWh/KzA8fl/dzNfVbeBTVgOBEVVKrNni6SoJl7qaZik2iAvN89WMUulN+B+U1eSDAdbngwxnLF+y5QgPYbQddSS19VZM6zfNEfzn6PU7SMBdXdDHzkwkJAADTr4cBtZ7vsgnk1NkfdxTY8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195351; c=relaxed/simple;
	bh=TD24+H33BqArZmKHTL1ed22PLkeRqyq0a83K+YquhfE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bLvs2ciAwuO+zYMJXN1Mh9a1CnsKfKh+QM0s+HhP6i1nR/CAa+oriW4ywdom9jCZkCFfRk1Je9sTPR37kK5IHecGzSpRgCpJki7l4mrnqYjTWFl4Bprzsnw/5RleZdjroLJdjiOxVb4ArdKiQgxeSR6n99Ek/OsdRXjAmgIAs0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TeWHUdHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F30DC4CED1;
	Mon, 10 Feb 2025 13:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739195351;
	bh=TD24+H33BqArZmKHTL1ed22PLkeRqyq0a83K+YquhfE=;
	h=Subject:To:Cc:From:Date:From;
	b=TeWHUdHpGcZa67dp5sYt8zDeRGs9xemsRFEOn5GMwSEmvxOTRiCjhXbWkPGH1tnyl
	 +awhfuTWsJKAYbAFZvLrfe9n4UOHho2J3NiLL9kyxpXu/XwnS4flLt3HjaRYD9AaU0
	 BI8q7m+eaQjDCLVXKiyt/7W6hzQiKUHORgovJzFo=
Subject: FAILED: patch "[PATCH] ASoC: renesas: rz-ssi: Add a check for negative sample_space" failed to apply to 5.15-stable tree
To: dan.carpenter@linaro.org,broonie@kernel.org,geert+renesas@glider.be
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:48:54 +0100
Message-ID: <2025021054-entangled-amuser-e6ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 82a0a3e6f8c02b3236b55e784a083fa4ee07c321
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021054-entangled-amuser-e6ea@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 82a0a3e6f8c02b3236b55e784a083fa4ee07c321 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Wed, 8 Jan 2025 12:28:46 +0300
Subject: [PATCH] ASoC: renesas: rz-ssi: Add a check for negative sample_space

My static checker rule complains about this code.  The concern is that
if "sample_space" is negative then the "sample_space >= runtime->channels"
condition will not work as intended because it will be type promoted to a
high unsigned int value.

strm->fifo_sample_size is SSI_FIFO_DEPTH (32).  The SSIFSR_TDC_MASK is
0x3f.  Without any further context it does seem like a reasonable warning
and it can't hurt to add a check for negatives.

Cc: stable@vger.kernel.org
Fixes: 03e786bd4341 ("ASoC: sh: Add RZ/G2L SSIF-2 driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/e07c3dc5-d885-4b04-a742-71f42243f4fd@stanley.mountain
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index d48e2e7356b6..3a0af4ca7ab6 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -521,6 +521,8 @@ static int rz_ssi_pio_send(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	sample_space = strm->fifo_sample_size;
 	ssifsr = rz_ssi_reg_readl(ssi, SSIFSR);
 	sample_space -= (ssifsr >> SSIFSR_TDC_SHIFT) & SSIFSR_TDC_MASK;
+	if (sample_space < 0)
+		return -EINVAL;
 
 	/* Only add full frames at a time */
 	while (frames_left && (sample_space >= runtime->channels)) {


