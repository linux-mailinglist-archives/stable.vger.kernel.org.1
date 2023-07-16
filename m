Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FFF7552F0
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjGPUNp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjGPUNp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:13:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0D790
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:13:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A96F060EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D49C433C8;
        Sun, 16 Jul 2023 20:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538423;
        bh=iuWJK9SJxVMKP5LwSNVXIZp5xRy5szBPUxKW9nQngyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p8UMw5TJyHZ8KsfNlaX9HwRlkrJDfoAQ0IF4UGn9MvPc6yhWbsf2aVJTepQQacvBD
         4eJWWS4w3FDsLqK0me8BAxPmXD5tZkLeO+8geNTjIMrLafUKU+aLEo+/jq/ao4dTvI
         4rRz6q40wFVaHHyKDfDb0cDopV/HLzRIIlJkbpt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
        Rongguang Wei <weirongguang@kylinos.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 445/800] PCI: pciehp: Cancel bringup sequence if card is not present
Date:   Sun, 16 Jul 2023 21:44:58 +0200
Message-ID: <20230716194959.420214184@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Rongguang Wei <weirongguang@kylinos.cn>

[ Upstream commit e8afd0d9fccc27c8ad263db5cf5952cfcf72d6fe ]

If a PCIe hotplug slot has an Attention Button, the normal hot-add flow is:

  - Slot is empty and slot power is off
  - User inserts card in slot and presses Attention Button
  - OS blinks Power Indicator for 5 seconds
  - After 5 seconds, OS turns on Power Indicator, turns on slot power, and
    enumerates the device

Previously, if a user pressed the Attention Button on an *empty* slot,
pciehp logged the following messages and blinked the Power Indicator
until a second button press:

  [0.000] pciehp: Button press: will power on in 5 sec
  [0.001] # Power Indicator starts blinking
  [5.001] # 5 second timeout; slot is empty, so we should cancel the
            request to power on and turn off Power Indicator

  [7.000] # Power Indicator still blinking
  [8.000] # possible card insertion
  [9.000] pciehp: Button press: canceling request to power on

The first button press incorrectly left the slot in BLINKINGON_STATE, so
the second was interpreted as a "cancel power on" event regardless of
whether a card was present.

If the slot is empty, turn off the Power Indicator and return from
BLINKINGON_STATE to OFF_STATE after 5 seconds, effectively canceling the
request to power on.  Putting the slot in OFF_STATE also means the second
button press will correctly request a slot power on if the slot is
occupied.

[bhelgaas: commit log]
Link: https://lore.kernel.org/r/20230512021518.336460-1-clementwei90@163.com
Fixes: d331710ea78f ("PCI: pciehp: Become resilient to missed events")
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 529c348084401..32baba1b7f131 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -256,6 +256,14 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	present = pciehp_card_present(ctrl);
 	link_active = pciehp_check_link_active(ctrl);
 	if (present <= 0 && link_active <= 0) {
+		if (ctrl->state == BLINKINGON_STATE) {
+			ctrl->state = OFF_STATE;
+			cancel_delayed_work(&ctrl->button_work);
+			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
+					      INDICATOR_NOOP);
+			ctrl_info(ctrl, "Slot(%s): Card not present\n",
+				  slot_name(ctrl));
+		}
 		mutex_unlock(&ctrl->state_lock);
 		return;
 	}
-- 
2.39.2



