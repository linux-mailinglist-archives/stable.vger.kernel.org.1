Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56A46FA40A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjEHJye (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjEHJyb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:54:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3451B2572A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:54:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE8D062219
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1942C4339B;
        Mon,  8 May 2023 09:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539669;
        bh=bKVfZbGQbbaMi1wWv8cFTLl9g6aqz5vdDPmG5B9/lzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oT3qaTBl3hyoU8/GyrVEM72x1jJSlFRo2pseKk+BAYKH0PPj1G5w12Gkwy5spQsE0
         iTcMF1hkLmVkzyb3rr9BbE+GHFAu/4Jp8mvokZGwQi/rTu6OPpx1aWdl4VNklm0vX4
         ZEXVChkgfJT1zEgOyR04tt4AWHdi3B3H3IfH16HI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.1 072/611] crypto: ccp - Dont initialize CCP for PSP 0x1649
Date:   Mon,  8 May 2023 11:38:34 +0200
Message-Id: <20230508094424.364678291@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

commit c79a3169b9f3633c215b55857eba5921e5b49217 upstream.

A number of platforms are emitting the error:
```ccp: unable to access the device: you might be running a broken BIOS.```

This is expected behavior as CCP is no longer accessible from the PSP's
PCIe BAR so stop trying to probe CCP for 0x1649.

Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/ccp/sp-pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -451,9 +451,9 @@ static const struct pci_device_id sp_pci
 	{ PCI_VDEVICE(AMD, 0x1468), (kernel_ulong_t)&dev_vdata[2] },
 	{ PCI_VDEVICE(AMD, 0x1486), (kernel_ulong_t)&dev_vdata[3] },
 	{ PCI_VDEVICE(AMD, 0x15DF), (kernel_ulong_t)&dev_vdata[4] },
-	{ PCI_VDEVICE(AMD, 0x1649), (kernel_ulong_t)&dev_vdata[4] },
 	{ PCI_VDEVICE(AMD, 0x14CA), (kernel_ulong_t)&dev_vdata[5] },
 	{ PCI_VDEVICE(AMD, 0x15C7), (kernel_ulong_t)&dev_vdata[6] },
+	{ PCI_VDEVICE(AMD, 0x1649), (kernel_ulong_t)&dev_vdata[6] },
 	/* Last entry must be zero */
 	{ 0, }
 };


