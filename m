Return-Path: <stable+bounces-114557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F824A2EEBB
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1080F1884F6A
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B89023098C;
	Mon, 10 Feb 2025 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JBNgQbwM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A20422FF20
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195337; cv=none; b=JSgd3PwRBzp8zRb6ElpimKPCjs+qaZ/RwE3DRzIo7Ss4ZIqe65qcBqqIlHBtGnh8BP62gkaxr5lqYKj3Xr/SsfVSUTubn8tA2EgTTANmzonb1Xx2xfmFo/tlDklO99Gk//FwzuThkctgMJGFT9svhTnXsFYob/r3chEMLTP6v+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195337; c=relaxed/simple;
	bh=UkCg+dhsxspNk7QuA2qvVLGBQo3KcEc70WQLnKyQ2B4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=r3WnWqArHladFEOCCd0D10MmTyqCOpAiTfYklyEtHlFdJEnm6L9x1IY/oCozz7UYFjAStOMvNklP/G0zlgLYBoHOxzwXqot6U2mF72GW0kVgMiKO6055ujo6FgXFhL533NmleKiz/Ir38Hk0Ve0aNZ97ZpauAMt+wbVUY4XbcSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JBNgQbwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E339C4CED1;
	Mon, 10 Feb 2025 13:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739195335;
	bh=UkCg+dhsxspNk7QuA2qvVLGBQo3KcEc70WQLnKyQ2B4=;
	h=Subject:To:Cc:From:Date:From;
	b=JBNgQbwMZRZvnxbnHRlHry6dBGzmW2N1a6dDJ4eF8toN/KOeHiH9WO/C3vULadFE8
	 kIGwJKUbNE2VJLiV0Is1ciWddgTOKtT9XOddtpHjK6UvCg8Sbl5JqUyDTynnXKOZIc
	 UrdDnIOMYRUFtTm5RqBXjhdMUZAfUm5yVfuRcmDs=
Subject: FAILED: patch "[PATCH] ASoC: renesas: rz-ssi: Add a check for negative sample_space" failed to apply to 6.12-stable tree
To: dan.carpenter@linaro.org,broonie@kernel.org,geert+renesas@glider.be
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:48:52 +0100
Message-ID: <2025021052-bubble-recycled-bf7b@gregkh>
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
git cherry-pick -x 82a0a3e6f8c02b3236b55e784a083fa4ee07c321
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021052-bubble-recycled-bf7b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


