Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F12F7A3B26
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240467AbjIQUOA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240744AbjIQUNl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:13:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB2E187
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:13:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E97C433CA;
        Sun, 17 Sep 2023 20:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981602;
        bh=Rg5DUJ2SIAsZ9xzy717JrDsr/u6SdSr8YULNb8Cbrd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eh5+EPqMyYxorTkxEF89YcrzYu5mYQZjbuYuon4+yG1/WapvbiIkJxtmNqM/elGJm
         2+KvoujAtjzdTyI8nZnhS2UAy2woWnPCvn61oFL+IDkC/hRCaAlRs/YDnuvXfUSKgE
         HVM9Cj9LMnuPqpH9NgvZx9ADUv39mOLK0mC9Y5ZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mikel Rychliski <mikel@mikelr.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 077/511] x86/efistub: Fix PCI ROM preservation in mixed mode
Date:   Sun, 17 Sep 2023 21:08:24 +0200
Message-ID: <20230917191115.735090149@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikel Rychliski <mikel@mikelr.com>

[ Upstream commit 8b94da92559f7e403dc7ab81937cc50f949ee2fd ]

preserve_pci_rom_image() was accessing the romsize field in
efi_pci_io_protocol_t directly instead of using the efi_table_attr()
helper. This prevents the ROM image from being saved correctly during a
mixed mode boot.

Fixes: 2c3625cb9fa2 ("efi/x86: Fold __setup_efi_pci32() and __setup_efi_pci64() into one function")
Signed-off-by: Mikel Rychliski <mikel@mikelr.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 72162645b553e..1cb4466e3c108 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -60,7 +60,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 	rom->data.type	= SETUP_PCI;
 	rom->data.len	= size - sizeof(struct setup_data);
 	rom->data.next	= 0;
-	rom->pcilen	= pci->romsize;
+	rom->pcilen	= romsize;
 	*__rom = rom;
 
 	status = efi_call_proto(pci, pci.read, EfiPciIoWidthUint16,
-- 
2.40.1



