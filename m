Return-Path: <stable+bounces-39494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16108A51D2
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C955B242A3
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A738E7174D;
	Mon, 15 Apr 2024 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTN2A08n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671247317D
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188293; cv=none; b=oDjDfpvqDs0knjAkY+roLDGEi60W4gRXlTMEFGAGO7ZDFnlszP3dDcwRa2BxpDFhvs7Roa5wx3LuYL3LQcSJCJ+EGGZNSZHr5H6l65hWWcoM6UPSv2IGEZ3VpF4fGZ9ORmKo4wXwT5qUx2nqIAtL7Zk8b72IZCKsOjflcSRNcY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188293; c=relaxed/simple;
	bh=Qa9sri7w5J6FhjUeW1+6YBibGuu3bKOl86W4ElzHXqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAAit5qbTY0VC1+eF1mWXq8V3Zp3Xam9oGm0aJRDKa2+hTsA1eCjZlqgzV24osHmO2AjdCFoL/lbSpJx7+bdrpznisKbj6JB+CykPwo87Ks1XMsdZvu1hyOz5anasr9siI2IFIgaVk37oh3JqQw7PMeoqTk+caZE0fKkxSSNm3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTN2A08n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2219EC4AF07;
	Mon, 15 Apr 2024 13:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188292;
	bh=Qa9sri7w5J6FhjUeW1+6YBibGuu3bKOl86W4ElzHXqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTN2A08n/GxCYMSQVdwgUs4fcblEGR2D7RPmiPHZK4W1aXctdV1HgKC92V+XbEo02
	 6bZ9dmWdEJeLHwcRT99AVCD/KP5HXZupJdnsIVYW3BSkYhJRQj5oFp+MIqxdmF5wW7
	 L1j7MtRlQBCg3wKWz7nsbP5nv1Wnvf25iNGsy5jL848vVcUhn8y3e20VkCEXd9sf2K
	 012B/f/PuF7bTZhANe+4pupv0k7OaZQ9v65KhKzcla0fD2atKqnykWLSoHMoeNktmh
	 VAz5niJuXkA09yNnnp5W+vTIGYRpYp2neI0UXhlo0Q1m/40KRzE0Cfak+LkBkOHfWF
	 PQKtQzIrW/0oQ==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 003/190] ALSA: jack: Fix mutex call in snd_jack_report()
Date: Mon, 15 Apr 2024 06:48:53 -0400
Message-ID: <20240415105208.3137874-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415105208.3137874-1-sashal@kernel.org>
References: <20240415105208.3137874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 89dbb335cb6a627a4067bc42caa09c8bc3326d40 ]

snd_jack_report() is supposed to be callable from an IRQ context, too,
and it's indeed used in that way from virtsnd driver.  The fix for
input_dev race in commit 1b6a6fc5280e ("ALSA: jack: Access input_dev
under mutex"), however, introduced a mutex lock in snd_jack_report(),
and this resulted in a potential sleep-in-atomic.

For addressing that problem, this patch changes the relevant code to
use the object get/put and removes the mutex usage.  That is,
snd_jack_report(), it takes input_get_device() and leaves with
input_put_device() for assuring the input_dev being assigned.

Although the whole mutex could be reduced, we keep it because it can
be still a protection for potential races between creation and
deletion.

Fixes: 1b6a6fc5280e ("ALSA: jack: Access input_dev under mutex")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/cf95f7fe-a748-4990-8378-000491b40329@moroto.mountain
Tested-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230706155357.3470-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/jack.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/core/jack.c b/sound/core/jack.c
index d2f9a92453f2f..6340de60f26ef 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -378,6 +378,7 @@ void snd_jack_report(struct snd_jack *jack, int status)
 {
 	struct snd_jack_kctl *jack_kctl;
 #ifdef CONFIG_SND_JACK_INPUT_DEV
+	struct input_dev *idev;
 	int i;
 #endif
 
@@ -389,30 +390,28 @@ void snd_jack_report(struct snd_jack *jack, int status)
 					    status & jack_kctl->mask_bits);
 
 #ifdef CONFIG_SND_JACK_INPUT_DEV
-	mutex_lock(&jack->input_dev_lock);
-	if (!jack->input_dev) {
-		mutex_unlock(&jack->input_dev_lock);
+	idev = input_get_device(jack->input_dev);
+	if (!idev)
 		return;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(jack->key); i++) {
 		int testbit = SND_JACK_BTN_0 >> i;
 
 		if (jack->type & testbit)
-			input_report_key(jack->input_dev, jack->key[i],
+			input_report_key(idev, jack->key[i],
 					 status & testbit);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(jack_switch_types); i++) {
 		int testbit = 1 << i;
 		if (jack->type & testbit)
-			input_report_switch(jack->input_dev,
+			input_report_switch(idev,
 					    jack_switch_types[i],
 					    status & testbit);
 	}
 
-	input_sync(jack->input_dev);
-	mutex_unlock(&jack->input_dev_lock);
+	input_sync(idev);
+	input_put_device(idev);
 #endif /* CONFIG_SND_JACK_INPUT_DEV */
 }
 EXPORT_SYMBOL(snd_jack_report);
-- 
2.43.0


