Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37897BDFB3
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377122AbjJINcz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377126AbjJINcy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:32:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225CDB6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:32:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DF2C433C8;
        Mon,  9 Oct 2023 13:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858372;
        bh=D5I8x2Bvys/JX6BIh32HafwNtRLkSsGXjyVcxQwWkRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iiJkVRYhYMWQR8Ci1olOG9IHsyVnwjVUJjE5KDCPa7ZRDFdvn/kde2ca/b83hTXZ2
         dDP4ziaCEg6tHQpgWpv8DXKyc62Qszbh+bgJMYVd+dnKqu/yuFKT8mTANmInenGiyR
         gxiez3hspphplDGtg0+ezI+z2tKhQzNixqgGg3Xw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 075/131] ALSA: hda: Disable power save for solving pop issue on Lenovo ThinkCentre M70q
Date:   Mon,  9 Oct 2023 15:01:55 +0200
Message-ID: <20231009130118.615329970@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

commit 057a28ef93bdbe84326d34cdb5543afdaab49fe1 upstream.

Lenovo ThinkCentre M70q had boot up pop noise.
Disable power save will solve pop issue.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/315900e2efef42fd9855eacfeb443abd@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/hda_intel.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2237,6 +2237,7 @@ static struct snd_pci_quirk power_save_b
 	SND_PCI_QUIRK(0x8086, 0x2068, "Intel NUC7i3BNB", 0),
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=198611 */
 	SND_PCI_QUIRK(0x17aa, 0x2227, "Lenovo X1 Carbon 3rd Gen", 0),
+	SND_PCI_QUIRK(0x17aa, 0x316e, "Lenovo ThinkCentre M70q", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1689623 */
 	SND_PCI_QUIRK(0x17aa, 0x367b, "Lenovo IdeaCentre B550", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1572975 */


