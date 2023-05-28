Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE718713F46
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjE1Tnr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjE1Tnq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:43:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDBC9C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:43:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A4A861F1C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:43:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438A0C433D2;
        Sun, 28 May 2023 19:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303023;
        bh=QolQt8rClIny/B+LhgUcu+kfmJqFmEeGPzugc0Mdn2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bSxtJzIxuRc5GG0YMlsHF8dOvaUiQqmHockhdbMkyp9QzxHD+vINw7bGdAeyPGd+0
         LePNZxKwf6M3DOC4KKyAS6C1ZbasThb5H7e2UoTPIp2xbO+l+fnLDapPHGEpPrLf1l
         h17kZYEtTSkybw4tJeRt/JkNAYBERcNQNIhD9Al4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Humlick <john@humlick.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10 123/211] ALSA: usb-audio: Add a sample rate workaround for Line6 Pod Go
Date:   Sun, 28 May 2023 20:10:44 +0100
Message-Id: <20230528190846.608966994@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
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

commit 359b4315471181f108723c61612d96e383e56179 upstream.

Line6 Pod Go (0e41:424b) requires the similar workaround for the fixed
48k sample rate like other Line6 models.  This patch adds the
corresponding entry to line6_parse_audio_format_rate_quirk().

Reported-by: John Humlick <john@humlick.org>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230512075858.22813-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/format.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -419,6 +419,7 @@ static int line6_parse_audio_format_rate
 	case USB_ID(0x0e41, 0x4248): /* Line6 Helix >= fw 2.82 */
 	case USB_ID(0x0e41, 0x4249): /* Line6 Helix Rack >= fw 2.82 */
 	case USB_ID(0x0e41, 0x424a): /* Line6 Helix LT >= fw 2.82 */
+	case USB_ID(0x0e41, 0x424b): /* Line6 Pod Go */
 	case USB_ID(0x19f7, 0x0011): /* Rode Rodecaster Pro */
 		return set_fixed_rate(fp, 48000, SNDRV_PCM_RATE_48000);
 	}


