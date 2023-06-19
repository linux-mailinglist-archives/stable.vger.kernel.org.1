Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB62D735369
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjFSKpa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjFSKo5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:44:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35A5CD
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:44:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48E3860B73
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F783C433CC;
        Mon, 19 Jun 2023 10:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171464;
        bh=cSSVDTQpJqb7XRpFpNVPyyJeOBZglaDhXgxypDATuPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vLMUTdz2Uo6NJZDFmQxLDnTJ4yxLyi425of75a0RpKiLlwGlvzpnE4HZGREeVqqGd
         VzNDHZRM7BgfERPjwoQsBcuJRcbL1p4yDtvOt7Zi2+nFKUG+AAGVsqbX9PJsEZimnB
         C1YO1TKParwYfd6P3Xr/uNn6Ellslldwe5+LYgsw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tatsuki Sugiura <sugi@nemui.org>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 041/166] NVMe: Add MAXIO 1602 to bogus nid list.
Date:   Mon, 19 Jun 2023 12:28:38 +0200
Message-ID: <20230619102156.711096108@linuxfoundation.org>
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

From: Tatsuki Sugiura <sugi@nemui.org>

[ Upstream commit a3a9d63dcd15535e7fdf4c7c1b32bfaed762973a ]

HIKSEMI FUTURE M.2 SSD uses the same dummy nguid and eui64.
I confirmed it with my two devices.

This patch marks the controller as NVME_QUIRK_BOGUS_NID.

---------------------------------------------------------
sugi@tempest:~% sudo nvme id-ctrl /dev/nvme0
NVME Identify Controller:
vid       : 0x1e4b
ssvid     : 0x1e4b
sn        : 30096022612
mn        : HS-SSD-FUTURE 2048G
fr        : SN10542
rab       : 0
ieee      : 000000
cmic      : 0
mdts      : 7
cntlid    : 0
ver       : 0x10400
rtd3r     : 0x7a120
rtd3e     : 0x1e8480
oaes      : 0x200
ctratt    : 0x2
rrls      : 0
cntrltype : 1
fguid     : 00000000-0000-0000-0000-000000000000
<snip...>
---------------------------------------------------------

---------------------------------------------------------
sugi@tempest:~% sudo nvme id-ns /dev/nvme0n1
NVME Identify Namespace 1:
<snip...>
nguid   : 00000000000000000000000000000000
eui64   : 0000000000000002
lbaf  0 : ms:0   lbads:9  rp:0 (in use)
---------------------------------------------------------

Signed-off-by: Tatsuki Sugiura <sugi@nemui.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ba4903c86f7ff..145fa7ef3f740 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3537,6 +3537,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1e4B, 0x1602),   /* MAXIO MAP1602 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
-- 
2.39.2



