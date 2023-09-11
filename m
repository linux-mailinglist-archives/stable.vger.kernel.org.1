Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DAC79ADBC
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359523AbjIKWRd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241368AbjIKPHV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:07:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B28FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:07:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A37C433C8;
        Mon, 11 Sep 2023 15:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444836;
        bh=wHKKGI5NTfyYy5IU0wTM38FoIJ7qvzyLEil5MtD6noI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2tUwe8/v8z3fwXj/g0L3NRbV7K8yRVHgJiLj/AMXPmXsCn/C2thcBijhpIOBOb1sZ
         gDfsbZFH9Dn/h7XrxlWWginL33qLc9rKlL7agxKS9Y2bROG9bXwN9Js2q3wq8yShz7
         LBVRL1KCVPLcuLBVfL6L6tpXirZyP1dd+Rr/NgNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mikel Rychliski <mikel@mikelr.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 134/600] x86/efistub: Fix PCI ROM preservation in mixed mode
Date:   Mon, 11 Sep 2023 15:42:47 +0200
Message-ID: <20230911134637.569112756@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 33a7811e12c65..4f0152b11a890 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -61,7 +61,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 	rom->data.type	= SETUP_PCI;
 	rom->data.len	= size - sizeof(struct setup_data);
 	rom->data.next	= 0;
-	rom->pcilen	= pci->romsize;
+	rom->pcilen	= romsize;
 	*__rom = rom;
 
 	status = efi_call_proto(pci, pci.read, EfiPciIoWidthUint16,
-- 
2.40.1



