Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6B5713FCB
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjE1TtE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjE1TtD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:49:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E0A9C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:49:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EDF962013
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFF9C433EF;
        Sun, 28 May 2023 19:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303341;
        bh=nr+LTTGYO3fcmUoCemDoPqF3Cv2xXD5hcW23N04V83o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPMLBNtaTdsef2RWjOufTnFE3QtEgUYwFD2toR5QQBWXQtc5/ssX3/vCU9LYVWeIX
         1fT9SmmYzxvY1ZM1B9yrLFLhWuewoDhB/bS2/5WaBn8ko7rk9Q3GYQ3f+K7Z3NaCzA
         9HSQP0g4PGCcw+TtGofSfLt3AtvhjiEyu3pb13qQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 12/69] ALSA: hda: Fix unhandled register update during auto-suspend period
Date:   Sun, 28 May 2023 20:11:32 +0100
Message-Id: <20230528190828.815393744@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
References: <20230528190828.358612414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 81302b1c7c997e8a56c1c2fc63a296ebeb0cd2d0 upstream.

It's reported that the recording started right after the driver probe
doesn't work properly, and it turned out that this is related with the
codec auto-suspend.  Namely, after the probe phase, the usage count
goes zero, and the auto-suspend is programmed, but the codec is kept
still active until the auto-suspend expiration.  When an application
(e.g. alsactl) updates the mixer values at this moment, the values are
cached but not actually written.  Then, starting arecord thereafter
also results in the silence because of the missing unmute.

The root cause is the handling of "lazy update" mode; when a mixer
value is updated *after* the suspend, it should update only the cache
and exits.  At the resume, the cached value is written to the device,
in turn.  The problem is that the current code misinterprets the state
of auto-suspend as if it were already suspended.

Although we can add the check of the actual device state after
pm_runtime_get_if_in_use() for catching the missing state, this won't
suffice; the second call of regmap_update_bits_check() will skip
writing the register because the cache has been already updated by the
first call.  So we'd need fixes in two different places.

OTOH, a simpler fix is to replace pm_runtime_get_if_in_use() with
pm_runtime_get_if_active() (with ign_usage_count=true).  This change
implies that the driver takes the pm refcount if the device is still
in ACTIVE state and continues the processing.  A small caveat is that
this will leave the auto-suspend timer.  But, since the timer callback
itself checks the device state and aborts gracefully when it's active,
this won't be any substantial problem.

Long story short: we address the missing register-write problem just
by replacing the pm_runtime_*() call in snd_hda_keep_power_up().

Fixes: fc4f000bf8c0 ("ALSA: hda - Fix unexpected resume through regmap code path")
Reported-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Closes: https://lore.kernel.org/r/a7478636-af11-92ab-731c-9b13c582a70d@linux.intel.com
Suggested-by: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230518113520.15213-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/hda/hdac_device.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -611,7 +611,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_power_up_pm);
 int snd_hdac_keep_power_up(struct hdac_device *codec)
 {
 	if (!atomic_inc_not_zero(&codec->in_pm)) {
-		int ret = pm_runtime_get_if_in_use(&codec->dev);
+		int ret = pm_runtime_get_if_active(&codec->dev, true);
 		if (!ret)
 			return -1;
 		if (ret < 0)


