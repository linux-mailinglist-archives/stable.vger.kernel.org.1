Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4326D735533
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 13:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjFSLCf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 07:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjFSLCQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 07:02:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C072105
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 04:01:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38A9260B7F
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 11:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA18C433C0;
        Mon, 19 Jun 2023 11:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172469;
        bh=4uQDjWVJF3zrgRzTtI5gZMWHpVJSDX6sGOJkrWD5Iwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zdlRCu+f9stDUk2DFaREaMk78gq7imiC3VWXYPZpBzUwUTWdtri2UuBZGQUKY8SgT
         iGhAcmopXW21GmGI1J0eonYf45ehAfSul4Pv1By21VdygA2lIjpcBOgh7AeplkP+Sm
         PJWwB3ZbyDAkDSCxRZwdnM0IvxPtbDyL49nebFl0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, beld zhang <beldzhang@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 5.15 054/107] thunderbolt: Mask ring interrupt on Intel hardware as well
Date:   Mon, 19 Jun 2023 12:30:38 +0200
Message-ID: <20230619102144.080375694@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
References: <20230619102141.541044823@linuxfoundation.org>
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

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 9f9666e65359d5047089aef97ac87c50f624ecb0 upstream.

When resuming from system sleep states the driver issues following
warning on Intel hardware:

  thunderbolt 0000:07:00.0: interrupt for TX ring 0 is already enabled

The reason for this is that the commit in question did not mask the ring
interrupt on Intel hardware leaving the interrupt active. Fix this by
masking it also in Intel hardware.

Reported-by: beld zhang <beldzhang@gmail.com>
Tested-by: beld zhang <beldzhang@gmail.com>
Closes: https://lore.kernel.org/linux-usb/ZHKW5NeabmfhgLbY@debian.me/
Fixes: c4af8e3fecd0 ("thunderbolt: Clear registers properly when auto clear isn't in use")
Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/nhi.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -53,9 +53,14 @@ static int ring_interrupt_index(const st
 
 static void nhi_mask_interrupt(struct tb_nhi *nhi, int mask, int ring)
 {
-	if (nhi->quirks & QUIRK_AUTO_CLEAR_INT)
-		return;
-	iowrite32(mask, nhi->iobase + REG_RING_INTERRUPT_MASK_CLEAR_BASE + ring);
+	if (nhi->quirks & QUIRK_AUTO_CLEAR_INT) {
+		u32 val;
+
+		val = ioread32(nhi->iobase + REG_RING_INTERRUPT_BASE + ring);
+		iowrite32(val & ~mask, nhi->iobase + REG_RING_INTERRUPT_BASE + ring);
+	} else {
+		iowrite32(mask, nhi->iobase + REG_RING_INTERRUPT_MASK_CLEAR_BASE + ring);
+	}
 }
 
 static void nhi_clear_interrupt(struct tb_nhi *nhi, int ring)


