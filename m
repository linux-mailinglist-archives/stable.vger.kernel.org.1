Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1EF77AC90
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjHMVec (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjHMVeb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:34:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC2610F9
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:34:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F9FF62C4B
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439E5C433C8;
        Sun, 13 Aug 2023 21:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962472;
        bh=gSrfnqz/OjqO75BDBSotY+LJ7X7F2I4cnsVPdRlBE58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b6ijhxxRHs4bzSp+wjvyCalg6h4ycxBPPLYsAaMlAsnaMDq2iHsxQCS3rJLFYb020
         4j546bu7zDGP4js+tDHreaTZhHszCDJdZP0lbcTP3kmo7/V/2T2TyVI5BaenivlLTJ
         zwQONreyGC9VZ+1D3rwAinSwhi6ZH6hXjDqlwCU4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, August Wikerfors <git@augustwikerfors.se>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 6.1 024/149] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and 512G
Date:   Sun, 13 Aug 2023 23:17:49 +0200
Message-ID: <20230813211719.522079303@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: August Wikerfors <git@augustwikerfors.se>

commit 688b419c57c13637d95d7879e165fff3dec581eb upstream.

The Samsung PM9B1 512G SSD found in some Lenovo Yoga 7 14ARB7 laptop units
reports eui as 0001000200030004 when resuming from s2idle, causing the
device to be removed with this error in dmesg:

nvme nvme0: identifiers changed for nsid 1

To fix this, add a quirk to ignore namespace identifiers for this device.

Signed-off-by: August Wikerfors <git@augustwikerfors.se>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/pci.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3504,7 +3504,8 @@ static const struct pci_device_id nvme_i
 	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x144d, 0xa80b),   /* Samsung PM9B1 256G and 512G */
-		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x144d, 0xa809),   /* Samsung MZALQ256HBJD 256G */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1cc4, 0x6303),   /* UMIS RPJTJ512MGE1QDY 512G */


