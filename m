Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716B370C9E9
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbjEVTxC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbjEVTw6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:52:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10392B6
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A25AA62B2E
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EB7C433D2;
        Mon, 22 May 2023 19:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785176;
        bh=zWycd4NOleDucaTDIy3mDGBMZOAdcEm+iiY194zdWkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mccyp1QS2yFI3RwNVCu+5KbXnU19v7m1Dy0WykkbusjoRGd9T2r6VW2KbbhVHrqGj
         gkEGU/KWfAo/YwugZxx1nActaQ4Icy2BKW2pkF3iR2DOuHgrprfU4yPNq71ikqRrxY
         eVKft34Synkav1EoLWgxkudHIxreui73BEGJzlMo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6.3 334/364] thunderbolt: Clear registers properly when auto clear isnt in use
Date:   Mon, 22 May 2023 20:10:39 +0100
Message-Id: <20230522190421.126165398@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

commit c4af8e3fecd03b0aedcd38145955605cfebe7e3a upstream.

When `QUIRK_AUTO_CLEAR_INT` isn't set, interrupt masking should be
cleared by writing to Interrupt Mask Clear (IMR) and interrupt
status should be cleared properly at shutdown/init.

This fixes an error where interrupts are left enabled during resume
from hibernation with `CONFIG_USB4=y`.

Fixes: 468c49f44759 ("thunderbolt: Disable interrupt auto clear for rings")
Cc: stable@vger.kernel.org # v6.3
Reported-by: Takashi Iwai <tiwai@suse.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217343
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/nhi.c      |   29 ++++++++++++++++++++++++-----
 drivers/thunderbolt/nhi_regs.h |    2 ++
 2 files changed, 26 insertions(+), 5 deletions(-)

--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -54,6 +54,21 @@ static int ring_interrupt_index(const st
 	return bit;
 }
 
+static void nhi_mask_interrupt(struct tb_nhi *nhi, int mask, int ring)
+{
+	if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
+		return;
+	iowrite32(mask, nhi->iobase + REG_RING_INTERRUPT_MASK_CLEAR_BASE + ring);
+}
+
+static void nhi_clear_interrupt(struct tb_nhi *nhi, int ring)
+{
+	if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
+		ioread32(nhi->iobase + REG_RING_NOTIFY_BASE + ring);
+	else
+		iowrite32(~0, nhi->iobase + REG_RING_INT_CLEAR + ring);
+}
+
 /*
  * ring_interrupt_active() - activate/deactivate interrupts for a single ring
  *
@@ -61,8 +76,8 @@ static int ring_interrupt_index(const st
  */
 static void ring_interrupt_active(struct tb_ring *ring, bool active)
 {
-	int reg = REG_RING_INTERRUPT_BASE +
-		  ring_interrupt_index(ring) / 32 * 4;
+	int index = ring_interrupt_index(ring) / 32 * 4;
+	int reg = REG_RING_INTERRUPT_BASE + index;
 	int interrupt_bit = ring_interrupt_index(ring) & 31;
 	int mask = 1 << interrupt_bit;
 	u32 old, new;
@@ -123,7 +138,11 @@ static void ring_interrupt_active(struct
 					 "interrupt for %s %d is already %s\n",
 					 RING_TYPE(ring), ring->hop,
 					 active ? "enabled" : "disabled");
-	iowrite32(new, ring->nhi->iobase + reg);
+
+	if (active)
+		iowrite32(new, ring->nhi->iobase + reg);
+	else
+		nhi_mask_interrupt(ring->nhi, mask, index);
 }
 
 /*
@@ -136,11 +155,11 @@ static void nhi_disable_interrupts(struc
 	int i = 0;
 	/* disable interrupts */
 	for (i = 0; i < RING_INTERRUPT_REG_COUNT(nhi); i++)
-		iowrite32(0, nhi->iobase + REG_RING_INTERRUPT_BASE + 4 * i);
+		nhi_mask_interrupt(nhi, ~0, 4 * i);
 
 	/* clear interrupt status bits */
 	for (i = 0; i < RING_NOTIFY_REG_COUNT(nhi); i++)
-		ioread32(nhi->iobase + REG_RING_NOTIFY_BASE + 4 * i);
+		nhi_clear_interrupt(nhi, 4 * i);
 }
 
 /* ring helper methods */
--- a/drivers/thunderbolt/nhi_regs.h
+++ b/drivers/thunderbolt/nhi_regs.h
@@ -93,6 +93,8 @@ struct ring_desc {
 #define REG_RING_INTERRUPT_BASE	0x38200
 #define RING_INTERRUPT_REG_COUNT(nhi) ((31 + 2 * nhi->hop_count) / 32)
 
+#define REG_RING_INTERRUPT_MASK_CLEAR_BASE	0x38208
+
 #define REG_INT_THROTTLING_RATE	0x38c00
 
 /* Interrupt Vector Allocation */


