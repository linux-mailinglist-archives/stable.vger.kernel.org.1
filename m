Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C523D74F902
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 22:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjGKU3B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 16:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjGKU3B (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 16:29:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16847195
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 13:29:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DE19615F2
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 20:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B84C433C8;
        Tue, 11 Jul 2023 20:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689107339;
        bh=rlpcgABeS+SD64DZXjiasXm2lMQH156dJKlhIeBBhBs=;
        h=Subject:To:Cc:From:Date:From;
        b=R7SD2cCgRDJhE1ldN3AqZWowPON6OGh6k/sp5hHT0U3DoLb73Q3xKuXtB2jbqRTAj
         jRGJE9z9AeaIuQAoGR1Kgk6EIdbYrF072pMSwVXHWahBVkFtAtdRE4GZdWlzrR6Pbs
         t1LJ/5Oc680AoE+sBo6s3jn5hbcbMk+oQkLmP2vM=
Subject: FAILED: patch "[PATCH] ALSA: jack: Fix mutex call in snd_jack_report()" failed to apply to 5.15-stable tree
To:     tiwai@suse.de, amadeuszx.slawinski@linux.intel.com,
        dan.carpenter@linaro.org, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 11 Jul 2023 22:28:56 +0200
Message-ID: <2023071156-amicably-trowel-5ddf@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 89dbb335cb6a627a4067bc42caa09c8bc3326d40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071156-amicably-trowel-5ddf@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 89dbb335cb6a627a4067bc42caa09c8bc3326d40 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 6 Jul 2023 17:53:57 +0200
Subject: [PATCH] ALSA: jack: Fix mutex call in snd_jack_report()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/sound/core/jack.c b/sound/core/jack.c
index 88493cc31914..03d155ed362b 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -654,6 +654,7 @@ void snd_jack_report(struct snd_jack *jack, int status)
 	struct snd_jack_kctl *jack_kctl;
 	unsigned int mask_bits = 0;
 #ifdef CONFIG_SND_JACK_INPUT_DEV
+	struct input_dev *idev;
 	int i;
 #endif
 
@@ -670,17 +671,15 @@ void snd_jack_report(struct snd_jack *jack, int status)
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
 		int testbit = ((SND_JACK_BTN_0 >> i) & ~mask_bits);
 
 		if (jack->type & testbit)
-			input_report_key(jack->input_dev, jack->key[i],
+			input_report_key(idev, jack->key[i],
 					 status & testbit);
 	}
 
@@ -688,13 +687,13 @@ void snd_jack_report(struct snd_jack *jack, int status)
 		int testbit = ((1 << i) & ~mask_bits);
 
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

