Return-Path: <stable+bounces-96231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 365AD9E1707
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5202810F8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B82B1DED71;
	Tue,  3 Dec 2024 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CGRFHSEn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A751DED59
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217506; cv=none; b=WP97xJLtdtLFQ2QHVB08hscsY6OCs0/bXk0VhNSW/47XAk9sHDHovCUu1QDa8rA5BH/gakZgKSE/PDdsGl7gagmqcSDRgbREYaZmquSQzfIckIpOWptTG7zKHTO1D7g0Squh87K5+uwaisbe8RHc7hU/bHNBFH18kPC8RwaMD2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217506; c=relaxed/simple;
	bh=b6MxuSNy/In/kaHN00fHnQ2xGFyOqNzpykuU/R8umUQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=npoEskjRhnrgKx35rSAwXdOhaqmbkLrUfgOOeiS4sqmePqKCE0Z9GcP+9KfLQHLq4EIsGQYWGZenKYG1nwgSfBOQkVEyDBDXPUhhSqZp+e5nAb38ymqVLkk7J3jMQmAWMuu8DlH/anIu6xHMuv3QCVkI8Qek3Wg95BHhckXiPgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CGRFHSEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54438C4CECF;
	Tue,  3 Dec 2024 09:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733217505;
	bh=b6MxuSNy/In/kaHN00fHnQ2xGFyOqNzpykuU/R8umUQ=;
	h=Subject:To:Cc:From:Date:From;
	b=CGRFHSEn9hYLHSw5rCX+I/5h5W5+V3d2JFQ9POaZS1i1qVBXdFt7tyclb3uLykN6z
	 4XKU/cS0YD9K9BC5QtbwQ1zAO11v4FWVR33I6IVMlwv964LSme4kLydgc30O32N4Em
	 GWmH7B4WXohSMsWO4ynC6ixWhwetgki1wWBH38uY=
Subject: FAILED: patch "[PATCH] gpio: grgpio: Add NULL check in grgpio_probe" failed to apply to 5.15-stable tree
To: hanchunchao@inspur.com,bartosz.golaszewski@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Dec 2024 10:18:14 +0100
Message-ID: <2024120314-undergrad-gulp-8de1@gregkh>
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
git cherry-pick -x 050b23d081da0f29474de043e9538c1f7a351b3b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120314-undergrad-gulp-8de1@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 050b23d081da0f29474de043e9538c1f7a351b3b Mon Sep 17 00:00:00 2001
From: Charles Han <hanchunchao@inspur.com>
Date: Thu, 14 Nov 2024 17:18:22 +0800
Subject: [PATCH] gpio: grgpio: Add NULL check in grgpio_probe

devm_kasprintf() can return a NULL pointer on failure,but this
returned value in grgpio_probe is not checked.
Add NULL check in grgpio_probe, to handle kernel NULL
pointer dereference error.

Cc: stable@vger.kernel.org
Fixes: 7eb6ce2f2723 ("gpio: Convert to using %pOF instead of full_name")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
Link: https://lore.kernel.org/r/20241114091822.78199-1-hanchunchao@inspur.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
index 7ffe59d845f0..169f33c41c59 100644
--- a/drivers/gpio/gpio-grgpio.c
+++ b/drivers/gpio/gpio-grgpio.c
@@ -369,6 +369,9 @@ static int grgpio_probe(struct platform_device *ofdev)
 	gc->owner = THIS_MODULE;
 	gc->to_irq = grgpio_to_irq;
 	gc->label = devm_kasprintf(dev, GFP_KERNEL, "%pOF", np);
+	if (!gc->label)
+		return -ENOMEM;
+
 	gc->base = -1;
 
 	err = of_property_read_u32(np, "nbits", &prop);


