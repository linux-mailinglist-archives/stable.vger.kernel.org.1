Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C7573537F
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjFSKqP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjFSKps (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:45:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42132100
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:45:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C15E160B80
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5444C433C8;
        Mon, 19 Jun 2023 10:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171523;
        bh=mdbmSESeonHWN1aK4IwDHNYlhsoIxMfPZ0/Z6vaPIGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sym4Co/am6x95DmHy8X/dH0XxEBczr3ztiPQVDyIAUuid5YYnXTpAcgBddG7QLkBs
         C00sN+KHn5UkYqT7ZiElmazo2TML0Sn4bajSBOeIkPr2hSwCZshmDU/TMl0HLEe7FU
         W7GnNnhN/sa2fR9mKJEWKOyzG/obSEkWGi9y0Dzc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 062/166] ALSA: usb-audio: Fix broken resume due to UAC3 power state
Date:   Mon, 19 Jun 2023 12:28:59 +0200
Message-ID: <20230619102157.801180113@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 8ba61c9f6c9bdfbf9d197b0282641d24ae909778 upstream.

As reported in the bugzilla below, the PM resume of a UAC3 device may
fail due to the incomplete power state change, stuck at D1.  The
reason is that the driver expects the full D0 power state change only
at hw_params, while the normal PCM resume procedure doesn't call
hw_params.

For fixing the bug, we add the same power state update to D0 at the
prepare callback, which is certainly called by the resume procedure.

Note that, with this change, the power state change in the hw_params
becomes almost redundant, since snd_usb_hw_params() doesn't touch the
parameters (at least it tires so).  But dropping it is still a bit
risky (e.g. we have the media-driver binding), so I leave the D0 power
state change in snd_usb_hw_params() as is for now.

Fixes: a0a4959eb4e9 ("ALSA: usb-audio: Operate UAC3 Power Domains in PCM callbacks")
Cc: <stable@vger.kernel.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217539
Link: https://lore.kernel.org/r/20230612132818.29486-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/pcm.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -650,6 +650,10 @@ static int snd_usb_pcm_prepare(struct sn
 		goto unlock;
 	}
 
+	ret = snd_usb_pcm_change_state(subs, UAC3_PD_STATE_D0);
+	if (ret < 0)
+		goto unlock;
+
  again:
 	if (subs->sync_endpoint) {
 		ret = snd_usb_endpoint_prepare(chip, subs->sync_endpoint);


