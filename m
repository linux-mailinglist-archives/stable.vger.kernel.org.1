Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B8A70C69D
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjEVTUL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbjEVTUL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:20:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD73F93
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:20:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3560A62817
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ECFC433D2;
        Mon, 22 May 2023 19:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783209;
        bh=yRgJpGevStmRT87ufU/JPvwH32xAzPu98ugr9mK0EJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hFALioNkjz0HZdAkVpjhSxhF18qrTYFSUBuZMRjY7jBkXX2UrSrfAzTZRVsUIxjfM
         qKjOso0FvkfXLmHpaAXrKM0swgFFF9UfoI85s1g08qAzAfPlX9+6qRqx/3h+2KrLBD
         rhMJiIRKOfhZPkqj3uYH+yNzlx6jPJzp9Ppfk6ig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Luke D. Jones" <luke@ljones.dev>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 174/203] ALSA: hda/realtek: Add quirk for 2nd ASUS GU603
Date:   Mon, 22 May 2023 20:09:58 +0100
Message-Id: <20230522190359.811835872@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
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

From: Luke D. Jones <luke@ljones.dev>

commit a4671b7fba59775845ee60cfbdfc4ba64300211b upstream.

Add quirk for GU603 with 0x1c62 variant of codec.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230505235824.49607-2-luke@ljones.dev
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9121,6 +9121,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1043, 0x1b13, "Asus U41SV", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1bbd, "ASUS Z550MA", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1c23, "Asus X55U", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
+	SND_PCI_QUIRK(0x1043, 0x1c62, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1c92, "ASUS ROG Strix G15", ALC285_FIXUP_ASUS_G533Z_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022", ALC289_FIXUP_ASUS_GA401),


