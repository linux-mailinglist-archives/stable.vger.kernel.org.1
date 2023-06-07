Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79736726D3F
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbjFGUkc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjFGUkb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:40:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A72726A8
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:40:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC6C1645EE
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B53C433EF;
        Wed,  7 Jun 2023 20:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170404;
        bh=cWB1dZy+1AbY9jcNQa0xPC8wJXDRMfc8M7uaWfwUlok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ldwgBmJOIeApoZ+zWH0PJ4pmmoi0TgzBexJ60in51kkjOClKK1/R4h8Ild8efuHFW
         38wpfZg/b+rC/z5Cfj9M198rgBsNi190F3NmOptkTph1dtk9rHnuFbjpuYzGfDOJnx
         zNTTH8hhUwfag4ZurUOiECwE+HkKsmay7y4Oq7wg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Julian Winkler <julian.winkler1@web.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 072/225] platform/x86: intel_scu_pcidrv: Add back PCI ID for Medfield
Date:   Wed,  7 Jun 2023 22:14:25 +0200
Message-ID: <20230607200916.735659969@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Julian Winkler <julian.winkler1@web.de>

[ Upstream commit 4a9b6850c794e4394cad99e2b863d75f5bc8e92f ]

This id was removed in commit b47018a778c1 ("platform/x86: intel_scu_ipc:
Remove Lincroft support"), saying it is only used on Moorestown,
but apparently the same id is also used on Medfield.

Tested on the Medfield based Motorola RAZR i smartphone.

Signed-off-by: Julian Winkler <julian.winkler1@web.de>
Link: https://lore.kernel.org/r/20230416154932.6579-1-julian.winkler1@web.de
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel_scu_pcidrv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel_scu_pcidrv.c b/drivers/platform/x86/intel_scu_pcidrv.c
index 80abc708e4f2f..d904fad499aa5 100644
--- a/drivers/platform/x86/intel_scu_pcidrv.c
+++ b/drivers/platform/x86/intel_scu_pcidrv.c
@@ -34,6 +34,7 @@ static int intel_scu_pci_probe(struct pci_dev *pdev,
 
 static const struct pci_device_id pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x080e) },
+	{ PCI_VDEVICE(INTEL, 0x082a) },
 	{ PCI_VDEVICE(INTEL, 0x08ea) },
 	{ PCI_VDEVICE(INTEL, 0x0a94) },
 	{ PCI_VDEVICE(INTEL, 0x11a0) },
-- 
2.39.2



