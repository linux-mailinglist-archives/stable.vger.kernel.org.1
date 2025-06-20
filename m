Return-Path: <stable+bounces-155019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6ADAE16EB
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A124A5B01
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83E927E063;
	Fri, 20 Jun 2025 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="geMCOXdR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790F027E04A
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750410128; cv=none; b=IZTpkBbxIyPgNFWGi6tMoMSDCwfrz3o3oJBHocBchKWLfndZa822q4NtT2+I0nq/usnn49ZUnjUMct4URiTrEzhH3V6YNXWQhhxjPQoj0H5RXm5DFslyxivvwtau/EVNxG2ZHkIGR+EZ8EM/e/sp3D0WCdZ/K07l5ZcxJ9PxFrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750410128; c=relaxed/simple;
	bh=jLv4fIPUdTe2ervrKIBOy6yAdHaW9DjDyTnIABj42d4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=URY/qkKrQStlcZVsJLVlVAwZvP+J/V6VoCjoUgaU/qoMhbnfWBHySxKKw9eRXjuVX1yC5AcA/A0JcwYtgB1HmueHItEp/kG2+lvahfOOTVdcWbnwh7DvRWT1IhneQNwJXf0J3Aeuns5nYi4Yc3kzLd3hqo35VMcbmEkv8zY0SBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=geMCOXdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7861C4CEE3;
	Fri, 20 Jun 2025 09:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750410128;
	bh=jLv4fIPUdTe2ervrKIBOy6yAdHaW9DjDyTnIABj42d4=;
	h=Subject:To:Cc:From:Date:From;
	b=geMCOXdRBBsd3KkHcyk2xLhKArR7Dfi0oF7ntEu+pSCg3OYLxcHUzIPN/Vl6eDCJW
	 a4uPusBeDFCD8/lWQM9jnJpDZUdZByZrrL/wN0DNV00aih/QiPAPSZB96K0dVW6MVD
	 meQ36UNWtJ5z5A16rmZLgUa4TYHYCrAnSA3LkNRI=
Subject: FAILED: patch "[PATCH] Input: gpio-keys - fix possible concurrent access in" failed to apply to 5.15-stable tree
To: gatien.chevallier@foss.st.com,dmitry.torokhov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:00:03 +0200
Message-ID: <2025062003-wizard-hamstring-172d@gregkh>
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
git cherry-pick -x 8f38219fa139623c29db2cb0f17d0a197a86e344
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062003-wizard-hamstring-172d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8f38219fa139623c29db2cb0f17d0a197a86e344 Mon Sep 17 00:00:00 2001
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Fri, 30 May 2025 16:09:23 -0700
Subject: [PATCH] Input: gpio-keys - fix possible concurrent access in
 gpio_keys_irq_timer()

gpio_keys_irq_isr() and gpio_keys_irq_timer() access the same resources.
There could be a concurrent access if a GPIO interrupt occurs in parallel
of a HR timer interrupt.

Guard back those resources with a spinlock.

Fixes: 019002f20cb5 ("Input: gpio-keys - use hrtimer for release timer")
Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
Link: https://lore.kernel.org/r/20250528-gpio_keys_preempt_rt-v2-2-3fc55a9c3619@foss.st.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index d884538107c9..f9db86da0818 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -449,6 +449,8 @@ static enum hrtimer_restart gpio_keys_irq_timer(struct hrtimer *t)
 						      release_timer);
 	struct input_dev *input = bdata->input;
 
+	guard(spinlock_irqsave)(&bdata->lock);
+
 	if (bdata->key_pressed) {
 		input_report_key(input, *bdata->code, 0);
 		input_sync(input);


