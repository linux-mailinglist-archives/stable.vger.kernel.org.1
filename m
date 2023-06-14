Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61929713D1C
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjE1TV7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjE1TV6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:21:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E33EA6
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:21:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A081261B36
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD282C4339B;
        Sun, 28 May 2023 19:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301717;
        bh=y95bWQOXTnZ37ppDVgo6fIVggRSSc6SsBJgV8ZAEbxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yn0w44xHaqC0QfTjouOiSrWNos45pRaX2BvzzvK8psKYzhctSCeduccL9SDY73f0y
         ePXxDle+WQIUTjoExdakap2BgAPTAOoJkNF//omVEuDNSVhGh8wWcVjf+EkmIGbS0D
         agjo6gdW7fwdxq40/Me0gVCIu2T2TovE0HCNGpEA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 113/132] ALSA: hda/realtek - Fixed one of HP ALC671 platform Headset Mic supported
Date:   Sun, 28 May 2023 20:10:52 +0100
Message-Id: <20230528190837.231772319@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190833.565872088@linuxfoundation.org>
References: <20230528190833.565872088@linuxfoundation.org>
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

From: Kailang Yang <kailang@realtek.com>

commit f2adbae0cb20c8eaf06914b2187043ea944b0aff upstream.

HP want to keep BIOS verb table for release platform.
So, it need to add 0x19 pin for quirk.

Fixes: 5af29028fd6d ("ALSA: hda/realtek - Add Headset Mic supported for HP cPC")
Signed-off-by: Kailang Yang <kailang@realtek.com>
Link: https://lore.kernel.org/r/74636ccb700a4cbda24c58a99dc430ce@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9290,6 +9290,7 @@ static const struct snd_hda_pin_quirk al
 	SND_HDA_PIN_QUIRK(0x10ec0671, 0x103c, "HP cPC", ALC671_FIXUP_HP_HEADSET_MIC2,
 		{0x14, 0x01014010},
 		{0x17, 0x90170150},
+		{0x19, 0x02a11060},
 		{0x1b, 0x01813030},
 		{0x21, 0x02211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0671, 0x103c, "HP cPC", ALC671_FIXUP_HP_HEADSET_MIC2,


