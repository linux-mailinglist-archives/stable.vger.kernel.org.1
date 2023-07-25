Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F07976169A
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjGYLkl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbjGYLkg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:40:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3C32119
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:40:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 806C06156E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92500C433CA;
        Tue, 25 Jul 2023 11:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285222;
        bh=nocWU53HaoEAh4dU6Y8xCq/UEEhrsq607qnRJGQI8wc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPiFj/Vk4tZI2ehJV+cLZAsZoqbDB4c097vgxNfwfMcwhp25fWnovSgV8K3L29gTj
         N2rbsN2dZFhkY7vrb7Ub03WP7DUrDX7yiqCJZemGxhH9JmgQIU2Kdk1XO3h924bZPF
         B07iVWg2o0Zt7eymKm3KhiADaqPe0WwEqF0WQMnY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
        Rongguang Wei <weirongguang@kylinos.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 098/313] PCI: pciehp: Cancel bringup sequence if card is not present
Date:   Tue, 25 Jul 2023 12:44:11 +0200
Message-ID: <20230725104525.207786424@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 6503d15effbbd..45d0f63707158 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -258,6 +258,14 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
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



