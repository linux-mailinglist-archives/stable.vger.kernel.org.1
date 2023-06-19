Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9DC73550B
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 13:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjFSLA7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 07:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjFSLAe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 07:00:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F611FD9
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:59:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1650E60BA2
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D23C433CB;
        Mon, 19 Jun 2023 10:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172372;
        bh=HAEnoUdDsP5vGw7nTN+6vZNliMdtd+ooTaOPYgDOwo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VcZUI/JGajl6+jrc2uS6xh36cJ74L+5fXfJNUi/00Bm6X5x3eT4rF7Di482rKGVd7
         ozszIz6W0UtEflXG47CaKuA/xXa+lc5OJ2nc1Lsy5aTGEJRI1Ms1RpDqekN6s6YZO5
         ngye5XTuLopTmJzqU1y9HlMn5P8sXvRGxHQpWCXw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lukasz Tyl <ltyl@hem-e.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 044/107] ALSA: usb-audio: Add quirk flag for HEM devices to enable native DSD playback
Date:   Mon, 19 Jun 2023 12:30:28 +0200
Message-ID: <20230619102143.603104141@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
References: <20230619102141.541044823@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Lukasz Tyl <ltyl@hem-e.com>

commit 122e2cb7e1a30438cc0e8bf70d4279db245d7d5b upstream.

This commit adds new DEVICE_FLG with QUIRK_FLAG_DSD_RAW and Vendor Id for
HEM devices which supports native DSD. Prior to this change Linux kernel
was not enabling native DSD playback for HEM devices, and as a result,
DSD audio was being converted to PCM "on the fly". HEM devices,
when connected to the system, would only play audio in PCM format,
even if the source material was in DSD format. With the addition of new
VENDOR_FLG in the quircks.c file, the devices are now correctly
recognized, and raw DSD data is transmitted to the device,
allowing for native DSD playback.

Signed-off-by: Lukasz Tyl <ltyl@hem-e.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230614122524.30271-1-ltyl@hem-e.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/quirks.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1921,6 +1921,8 @@ static const struct usb_audio_quirk_flag
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x2ab6, /* T+A devices */
 		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x3336, /* HEM devices */
+		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x3353, /* Khadas devices */
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x3842, /* EVGA */


