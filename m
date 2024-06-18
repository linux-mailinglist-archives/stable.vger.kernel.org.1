Return-Path: <stable+bounces-53647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6C190D551
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 16:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC211F21ECF
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87889155337;
	Tue, 18 Jun 2024 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OBeFy3n3"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4760C15531C
	for <Stable@vger.kernel.org>; Tue, 18 Jun 2024 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720276; cv=none; b=ggqn9+XrNtsqFsI1Wa7wclPcexJjUHaHPD+9dznjJL9thzpJZcSeLkXYz23wPSz+BcnAQmUCssw+Pesxh4xY3VHVVEa60GRduUL7P+8V+/70QMu8Ma2VOP3d3/hRf9Yd0eQXFl+aseAK3CUjCp3LK5mvnQdfVPqTlzph63Hptj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720276; c=relaxed/simple;
	bh=W+esAMFORqbHk+s14JOTl27LOv/94ve22QDD/8KhBio=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ffps5fzR4GPbTc/Hy3dJLt582zWa3+KRjDQDZ/C69FDwp3CH7riCRelniIev3ia2aUn84evkT3RRA8z/jxyraPIToRakiVD8HU4KVZ/SZaYhvvYi/0bfryAJDN8Mt6aRuhv4tL7OHCaKoDYkF6iQfDTiiuWT1PE4fgot3zOXfW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OBeFy3n3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B202C3277B;
	Tue, 18 Jun 2024 14:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718720275;
	bh=W+esAMFORqbHk+s14JOTl27LOv/94ve22QDD/8KhBio=;
	h=Subject:To:Cc:From:Date:From;
	b=OBeFy3n3uHlCNJxs5QbVwQPoT1vaPtEZ+TyV6L6EPOhpAYCfc5F3AQQkjNJzn1LGE
	 ynpF2F+XIeBjCEospG8xb3CGkAF2IRryy9LpT8EcuwAxkP/scs6BgApYI+RzCpwCrs
	 tG0NEjAozU1DZzCeed+w3RX4ao8eC/PqlOoWKaxk=
Subject: FAILED: patch "[PATCH] iio: adc: axi-adc: make sure AXI clock is enabled" failed to apply to 5.10-stable tree
To: nuno.sa@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Jun 2024 16:17:45 +0200
Message-ID: <2024061845-applause-lanky-c87c@gregkh>
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
git cherry-pick -x 80721776c5af6f6dce7d84ba8df063957aa425a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061845-applause-lanky-c87c@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

80721776c5af ("iio: adc: axi-adc: make sure AXI clock is enabled")
794ef0e57854 ("iio: adc: adi-axi-adc: move to backend framework")
9c446288d7b3 ("iio: buffer-dmaengine: export buffer alloc and free functions")
21aa971d3e29 ("iio: adc: adi-axi-adc: convert to regmap")
b73f08bb7fe5 ("iio: adc: ad9467: fix scale setting")
1240c94ce819 ("iio: adc: Explicitly include correct DT includes")
4c077429b422 ("iio: mlx90614: Sort headers")
a99544c6c883 ("iio: adc: palmas: add support for iio threshold events")
2d48dbdfc7d4 ("iio: adc: palmas: move eventX_enable into palmas_adc_event")
7501a3a97e4f ("iio: adc: palmas: use iio_event_direction for threshold polarity")
d2ab4eea732d ("iio: adc: palmas: replace "wakeup" with "event"")
79d9622d622d ("iio: adc: palmas: remove adc_wakeupX_data")
6d52b0e70698 ("iio: adc: palmas: Take probe fully device managed.")
49f76c499d38 ("iio: adc: palmas_gpadc: fix NULL dereference on rmmod")
2a3c8f8a4494 ("Merge tag 'iio-for-5.20a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 80721776c5af6f6dce7d84ba8df063957aa425a2 Mon Sep 17 00:00:00 2001
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 26 Apr 2024 17:42:13 +0200
Subject: [PATCH] iio: adc: axi-adc: make sure AXI clock is enabled

We can only access the IP core registers if the bus clock is enabled. As
such we need to get and enable it and not rely on anyone else to do it.

Note this clock is a very fundamental one that is typically enabled
pretty early during boot. Independently of that, we should really rely on
it to be enabled.

Fixes: ef04070692a2 ("iio: adc: adi-axi-adc: add support for AXI ADC IP core")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20240426-ad9467-new-features-v2-4-6361fc3ba1cc@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 9444b0c5a93c..f54830658da8 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -161,6 +161,7 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	struct adi_axi_adc_state *st;
 	void __iomem *base;
 	unsigned int ver;
+	struct clk *clk;
 	int ret;
 
 	st = devm_kzalloc(&pdev->dev, sizeof(*st), GFP_KERNEL);
@@ -181,6 +182,10 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	if (!expected_ver)
 		return -ENODEV;
 
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
 	/*
 	 * Force disable the core. Up to the frontend to enable us. And we can
 	 * still read/write registers...


