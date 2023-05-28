Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C7F713F64
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjE1To4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjE1Toz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:44:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A370A8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:44:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACF1E61F39
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AA5C433D2;
        Sun, 28 May 2023 19:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303094;
        bh=o6jwMRrANQVMfW8ZTRMI+a5w+5q/BF2JPjS1IuivHd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ubjg9jIzRAU8uNO5hbPOfajk4LBjLr9fIhPvnrtkTeNn2IfTBBnmB4n0zM4lktOsP
         66/yWYsxq1iBkpWJx/hgZIegND2lQltJP0DwzOinDcQWfe5MQwLlFp/LapmeupcLiS
         0o62D3x//dSWwRJ5L2anJzIfs9YD639fmwjwBtoM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vitaliy Tomin <tomin@iszf.irk.ru>,
        stable <stable@kernel.org>
Subject: [PATCH 5.10 144/211] serial: Add support for Advantech PCI-1611U card
Date:   Sun, 28 May 2023 20:11:05 +0100
Message-Id: <20230528190847.090767528@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vitaliy Tomin <tomin@iszf.irk.ru>

commit d2b00516de0e1d696724247098f6733a6ea53908 upstream.

Add support for Advantech PCI-1611U card

Advantech provides opensource drivers for this and many others card
based on legacy copy of 8250_pci driver called adv950

https://www.advantech.com/emt/support/details/driver?id=1-TDOIMJ

It is hard to maintain to run as out of tree module on newer kernels.
Just adding PCI ID to kernel 8250_pci works perfect.

Signed-off-by: Vitaliy Tomin <tomin@iszf.irk.ru>
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/20230423034512.2671157-1-tomin@iszf.irk.ru
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1839,6 +1839,8 @@ pci_moxa_setup(struct serial_private *pr
 #define PCI_SUBDEVICE_ID_SIIG_DUAL_30	0x2530
 #define PCI_VENDOR_ID_ADVANTECH		0x13fe
 #define PCI_DEVICE_ID_INTEL_CE4100_UART 0x2e66
+#define PCI_DEVICE_ID_ADVANTECH_PCI1600	0x1600
+#define PCI_DEVICE_ID_ADVANTECH_PCI1600_1611	0x1611
 #define PCI_DEVICE_ID_ADVANTECH_PCI3620	0x3620
 #define PCI_DEVICE_ID_ADVANTECH_PCI3618	0x3618
 #define PCI_DEVICE_ID_ADVANTECH_PCIf618	0xf618
@@ -4185,6 +4187,9 @@ static SIMPLE_DEV_PM_OPS(pciserial_pm_op
 			 pciserial_resume_one);
 
 static const struct pci_device_id serial_pci_tbl[] = {
+	{	PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI1600,
+		PCI_DEVICE_ID_ADVANTECH_PCI1600_1611, PCI_ANY_ID, 0, 0,
+		pbn_b0_4_921600 },
 	/* Advantech use PCI_DEVICE_ID_ADVANTECH_PCI3620 (0x3620) as 'PCI_SUBVENDOR_ID' */
 	{	PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI3620,
 		PCI_DEVICE_ID_ADVANTECH_PCI3620, 0x0001, 0, 0,


