Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C28B7D30FA
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjJWLEO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjJWLEJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:04:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E1E10CF
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:04:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D550CC433B8;
        Mon, 23 Oct 2023 11:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059041;
        bh=Gbf55e9MfB9U6CCD8oBkO2Ot4VxHtXEsnVBvEr/QA0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kE8oJFvWRUq9lLS8o30Ri7t1/fdcz30BNofVVVAGjQyWhwn+8d+BnZ76KqKfy9kaX
         Fd4v1n3Z33slxh6e4gI56CNEOivV1utX8oz9ShdNJfgUaZvfmSYs3NIEVnaOpHuQIs
         jd4r0v/CG5/w+tEz5hNiHjq1knLVbhkS3pYxgMEg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Artem Borisov <dedsa2002@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.5 044/241] ALSA: hda/realtek: Add quirk for ASUS ROG GU603ZV
Date:   Mon, 23 Oct 2023 12:53:50 +0200
Message-ID: <20231023104834.989909860@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Artem Borisov <dedsa2002@gmail.com>

commit 5dedc9f53eef7ec07b23686381100d03fb259f50 upstream.

Enables the SPI-connected Cirrus amp and the required pins
for headset mic detection.

As of BIOS version 313 it is still necessary to modify the
ACPI table to add the related _DSD properties:
  https://gist.github.com/Flex1911/1bce378645fc95a5743671bd5deabfc8

Signed-off-by: Artem Borisov <dedsa2002@gmail.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20231014075044.17474-1-dedsa2002@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9738,6 +9738,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x1573, "ASUS GZ301V", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1662, "ASUS GV301QH", ALC294_FIXUP_ASUS_DUAL_SPK),
+	SND_PCI_QUIRK(0x1043, 0x1663, "ASUS GU603ZV", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1683, "ASUS UM3402YAR", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),


