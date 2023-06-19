Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CA17353A3
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjFSKr0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjFSKrB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:47:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16481BEA
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:46:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49C3560B80
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625DBC433C0;
        Mon, 19 Jun 2023 10:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171592;
        bh=gDrRAn/3Di0ZftnLSoA+mqE0h0skAQn1H02GdAnvofI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ba2tAxrm/+TCJn/cMC35Q219YRjMXzlrWBCGMgOEBrzKomJQDXigzkg2QWyquyOrN
         0QNNAw5W6CNvPOpTO3jQdNwZt+CK1eiEEvDRANuDucvRV6ueIttHB3KpEYeOKQ+W17
         buz5nl+XOkwSlvCl+zvu+VEG8dXnVDfs9zJYkAPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, beld zhang <beldzhang@gmail.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6.1 079/166] thunderbolt: Mask ring interrupt on Intel hardware as well
Date:   Mon, 19 Jun 2023 12:29:16 +0200
Message-ID: <20230619102158.629004381@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
@@ -56,9 +56,14 @@ static int ring_interrupt_index(const st
 
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


