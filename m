Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204DD7CABE2
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjJPOqs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbjJPOqr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:46:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0240095
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:46:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C603C433C7;
        Mon, 16 Oct 2023 14:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467605;
        bh=BQPYK3g3r+IpS/qxh1oXJc2zw46JoejCkKjGqM/mLkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GJvmkqzcrhe9++OlcCp30Z4k5FJDe5uR0REk+oPhsSgFYMo1DnReuOQWSHo/KNOHl
         wqArJBkX0vPVfXUnh5Z5L4N/Lebzj65ooPVBallyaff0QBBtEZKyYFK3FI+RXKdlhY
         mHruxl7/0OpY+gYINf1f4g4ffGWItOOJBnCbzU4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, WhaleChang <whalechang@google.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.5 027/191] ALSA: usb-audio: Fix microphone sound on Opencomm2 Headset
Date:   Mon, 16 Oct 2023 10:40:12 +0200
Message-ID: <20231016084016.034757637@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: WhaleChang <whalechang@google.com>

commit 6a83d6f3bb3c329a73e3483651fb77b78bac1878 upstream.

When a Opencomm2 Headset is connected to a Bluetooth USB dongle,
the audio playback functions properly, but the microphone does not work.

In the dmesg logs, there are messages indicating that the init_pitch
function fails when the capture process begins.

The microphone only functions when the ep pitch control is not set.

Toggling the pitch control off bypasses the init_piatch function
and allows the microphone to work.

Signed-off-by: WhaleChang <whalechang@google.com>
Link: https://lore.kernel.org/r/20231006044852.4181022-1-whalechang@google.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/quirks.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1994,7 +1994,11 @@ void snd_usb_audioformat_attributes_quir
 		/* mic works only when ep packet size is set to wMaxPacketSize */
 		fp->attributes |= UAC_EP_CS_ATTR_FILL_MAX;
 		break;
-
+	case USB_ID(0x3511, 0x2b1e): /* Opencomm2 UC USB Bluetooth dongle */
+		/* mic works only when ep pitch control is not set */
+		if (stream == SNDRV_PCM_STREAM_CAPTURE)
+			fp->attributes &= ~UAC_EP_CS_ATTR_PITCH_CONTROL;
+		break;
 	}
 }
 


