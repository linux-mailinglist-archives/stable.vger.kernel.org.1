Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A52775A5F
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjHILHu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjHILHu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:07:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1771FFA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:07:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E59C63142
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF2EC433C7;
        Wed,  9 Aug 2023 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579269;
        bh=PXQiQFjq/cqo/1d/HCyukYjW1hkz688esadOgf150Ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FokULfAED2M9d2UFmJb/T6OvheSkz+aRKZnWdO/iXBO3BvhBdLdvFxs84wjp1wjjB
         x5PzjX4cMuPcQJTBQnfvr1xNXFaY87hNdkOiYUD8YnI829QY99LmZ3D4KDMPLf9Adt
         9a/DDW0a4TymyjwfXZSbBtIldyJDkXswegot5vNM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jason Adriaanse <jason_a69@yahoo.co.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4.14 108/204] PCI: Add function 1 DMA alias quirk for Marvell 88SE9235
Date:   Wed,  9 Aug 2023 12:40:46 +0200
Message-ID: <20230809103646.222105556@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

commit 88d341716b83abd355558523186ca488918627ee upstream.

Marvell's own product brief implies the 92xx series are a closely related
family, and sure enough it turns out that 9235 seems to need the same quirk
as the other three, although possibly only when certain ports are used.

Link: https://lore.kernel.org/linux-iommu/2a699a99-545c-1324-e052-7d2f41fed1ae@yahoo.co.uk/
Link: https://lore.kernel.org/r/731507e05d70239aec96fcbfab6e65d8ce00edd2.1686157165.git.robin.murphy@arm.com
Reported-by: Jason Adriaanse <jason_a69@yahoo.co.uk>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/quirks.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4035,6 +4035,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_M
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c49 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9230,
 			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9235,
+			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0642,
 			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TTI, 0x0645,


