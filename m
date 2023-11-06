Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD8C7E241F
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjKFNS0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjKFNSZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:18:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E44BF
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:18:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6723C433C8;
        Mon,  6 Nov 2023 13:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276702;
        bh=rwBzskrV+lLy/LHg8/pon19KGBTb9kqi4LZ9fnXgQ54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nege/Vl9RGUjX6Tl6Rn/XFSkG92avP2pk++rAqC6h+csq+COyzMPwPTeY0tmc304Y
         f6rYTuTM7uhV+9gXp1A302zUHFoNDtn1PRbumnhcJgHSb5FV/g8X5rG6Rw+ik7phxr
         ylc44Vw0Moum6t4A8QGAssDXoAiZ9p2NnJH4oRVo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Max McCarthy <mmccarthy@mcintoshlabs.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.5 67/88] ALSA: usb-audio: add quirk flag to enable native DSD for McIntosh devices
Date:   Mon,  6 Nov 2023 14:04:01 +0100
Message-ID: <20231106130308.229657337@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Max McCarthy <mmccarthy@mcintoshlabs.com>

commit 99248c8902f505ec064cf2b0f74629016f2f4c82 upstream.

McIntosh devices supporting native DSD require the feature to be
explicitly exposed. Add a flag that fixes an issue where DSD audio was
defaulting to DSD over PCM instead of delivering raw DSD data.

Signed-off-by: Max McCarthy <mmccarthy@mcintoshlabs.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/BL0PR13MB4433226005162D186A8DFF4AD6DFA@BL0PR13MB4433.namprd13.prod.outlook.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/quirks.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2220,6 +2220,8 @@ static const struct usb_audio_quirk_flag
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x2ab6, /* T+A devices */
 		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x2afd, /* McIntosh Laboratory, Inc. */
+		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x2d87, /* Cayin device */
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x3336, /* HEM devices */


