Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE1D72BF9F
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjFLKp5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjFLKpQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:45:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53200F7C7
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:30:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96B1360D56
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E4BC433B4;
        Mon, 12 Jun 2023 10:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565810;
        bh=TgQq0faDLmnnZWwMjnJtw+W6Lul6DKuyzev9gDI/2wQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eoagyYuNecYgyhpGb5NBP4RqkW1SpGcwqk3Z0rzqBAgq+aKVYx53bwKXycThZvTee
         Ojv7rV/VUMFEXie33MjmI8meu+/x10TEmrvH5J8A1oVdntDweUA02KTRmyZhrBoxha
         BThAx4OWHdvxTfI3jPiAXeviavIX6GQQpQ+l6fPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Hutchings <ben@decadent.org.uk>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 23/23] Revert "staging: rtl8192e: Replace macro RTL_PCI_DEVICE with PCI_DEVICE"
Date:   Mon, 12 Jun 2023 12:26:24 +0200
Message-ID: <20230612101651.911193510@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101651.138592130@linuxfoundation.org>
References: <20230612101651.138592130@linuxfoundation.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit ec310591cf839653a5b2c1fcf6b8a110c3f2485c which is
commit a80f4c7dc4dbd2925cf3da86004137965cb16086 upstream.

Ben reports that this should not have been backported to the older
kernels as the rest of the macro is not empty.  It was a clean-up patch
in 6.4-rc1 only, it did not add new device ids.

Reported-by: Ben Hutchings <ben@decadent.org.uk>
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>
Link: https://lore.kernel.org/r/aa0d401a7f63448cd4c2fe4a2d7e8495d9aa123e.camel@decadent.org.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |    6 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h |    5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -61,9 +61,9 @@ static const struct rtl819x_ops rtl819xp
 };
 
 static struct pci_device_id rtl8192_pci_id_tbl[] = {
-	{PCI_DEVICE(0x10ec, 0x8192)},
-	{PCI_DEVICE(0x07aa, 0x0044)},
-	{PCI_DEVICE(0x07aa, 0x0047)},
+	{RTL_PCI_DEVICE(0x10ec, 0x8192, rtl819xp_ops)},
+	{RTL_PCI_DEVICE(0x07aa, 0x0044, rtl819xp_ops)},
+	{RTL_PCI_DEVICE(0x07aa, 0x0047, rtl819xp_ops)},
 	{}
 };
 
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -67,6 +67,11 @@
 #define IS_HARDWARE_TYPE_8192SE(_priv)		\
 	(((struct r8192_priv *)rtllib_priv(dev))->card_8192 == NIC_8192SE)
 
+#define RTL_PCI_DEVICE(vend, dev, cfg) \
+	.vendor = (vend), .device = (dev), \
+	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, \
+	.driver_data = (kernel_ulong_t)&(cfg)
+
 #define TOTAL_CAM_ENTRY		32
 #define CAM_CONTENT_COUNT	8
 


