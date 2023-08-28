Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C7978ABA5
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjH1KdZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjH1Kcz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:32:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08356130
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:32:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC42963CFA
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE3BC433C8;
        Mon, 28 Aug 2023 10:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218750;
        bh=CLumFTdj3TyGnL3rdrA++8rJ6fkTJrctNWP5LEAFavY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qr9zc6afZjtBmX8ftmvjkV94E9ZUUFcgZ1XFLC7pj4OXUmEVdogu6mltVk0RMc1No
         xM/7rncq45WqdemCnBDpKVKArKuHLVyGeqYLCN+iMcIxxpMCtP7i0cQXpvwuw+eDXm
         Lk/rf5dvAPSydUIWMNbrRj5Fw2KxdaAUqqPZFx+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
        Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 6.1 070/122] ALSA: ymfpci: Fix the missing snd_card_free() call at probe error
Date:   Mon, 28 Aug 2023 12:13:05 +0200
Message-ID: <20230828101158.773379203@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 1d0eb6143c1e85d3f9a3f5a616ee7e5dc351d33b upstream.

Like a few other drivers, YMFPCI driver needs to clean up with
snd_card_free() call at an error path of the probe; otherwise the
other devres resources are released before the card and it results in
the UAF.

This patch uses the helper for handling the probe error gracefully.

Fixes: f33fc1576757 ("ALSA: ymfpci: Create card with device-managed snd_devm_card_new()")
Cc: <stable@vger.kernel.org>
Reported-and-tested-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Closes: https://lore.kernel.org/r/20230823135846.1812-1-takashi.yano@nifty.ne.jp
Link: https://lore.kernel.org/r/20230823161625.5807-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/ymfpci/ymfpci.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/sound/pci/ymfpci/ymfpci.c
+++ b/sound/pci/ymfpci/ymfpci.c
@@ -150,8 +150,8 @@ static inline int snd_ymfpci_create_game
 void snd_ymfpci_free_gameport(struct snd_ymfpci *chip) { }
 #endif /* SUPPORT_JOYSTICK */
 
-static int snd_card_ymfpci_probe(struct pci_dev *pci,
-				 const struct pci_device_id *pci_id)
+static int __snd_card_ymfpci_probe(struct pci_dev *pci,
+				   const struct pci_device_id *pci_id)
 {
 	static int dev;
 	struct snd_card *card;
@@ -333,6 +333,12 @@ static int snd_card_ymfpci_probe(struct
 	return 0;
 }
 
+static int snd_card_ymfpci_probe(struct pci_dev *pci,
+				 const struct pci_device_id *pci_id)
+{
+	return snd_card_free_on_error(&pci->dev, __snd_card_ymfpci_probe(pci, pci_id));
+}
+
 static struct pci_driver ymfpci_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_ymfpci_ids,


