Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00903713F77
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjE1Tps (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjE1Tpo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:45:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6984EC7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:45:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6ADB61F50
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C33C4339B;
        Sun, 28 May 2023 19:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303141;
        bh=xVqFFFE5fTYVwX6hcYuvOUC/rUmnDr0kBMjUkNiRlLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RBpNC9gKmTvwHf0i/i0pZ9+JAEWA5f3DzF/mvaSoRCW8mN7WdK0+KewYZQ24TV0bI
         0a7l1xBjzQMh7KHKXqFKvE3Qcr6XjJuwwkdrSGBZUNZmIFRzwLLXupdYX7LVmsZEcI
         f1hNRjshlz6U6KHYxRG+4Js3HgQKeOyOVRREjqcg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bin Li <bin.li@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10 170/211] ALSA: hda/realtek: Enable headset onLenovo M70/M90
Date:   Sun, 28 May 2023 20:11:31 +0100
Message-Id: <20230528190847.720035393@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bin Li <bin.li@canonical.com>

commit 4ca110cab46561cd74a2acd9b447435acb4bec5f upstream.

Lenovo M70/M90 Gen4 are equipped with ALC897, and they need
ALC897_FIXUP_HEADSET_MIC_PIN quirk to make its headset mic work.
The previous quirk for M70/M90 is for Gen3.

Signed-off-by: Bin Li <bin.li@canonical.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230524113755.1346928-1-bin.li@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11187,6 +11187,8 @@ static const struct snd_pci_quirk alc662
 	SND_PCI_QUIRK(0x17aa, 0x32cb, "Lenovo ThinkCentre M70", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32cf, "Lenovo ThinkCentre M950", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x32f7, "Lenovo ThinkCentre M90", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x3321, "Lenovo ThinkCentre M70 Gen4", ALC897_FIXUP_HEADSET_MIC_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x331b, "Lenovo ThinkCentre M90 Gen4", ALC897_FIXUP_HEADSET_MIC_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3742, "Lenovo TianYi510Pro-14IOB", ALC897_FIXUP_HEADSET_MIC_PIN2),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo Ideapad Y550P", ALC662_FIXUP_IDEAPAD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Ideapad Y550", ALC662_FIXUP_IDEAPAD),


