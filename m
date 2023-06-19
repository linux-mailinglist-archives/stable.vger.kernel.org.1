Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5A87354DA
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjFSK7S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbjFSK6z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:58:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA141726
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:57:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CE1F60B5F
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9E3C433C0;
        Mon, 19 Jun 2023 10:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172250;
        bh=6RKCs0wMRDGWK8DsBROFb/lfeMXrmeEI6AuGMA5xHuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IJ5nb3rqPY1cbKeuohRRRjqHLuNjePEevqxdKkvN0JHQEZFY+gynAzj06Lw+XiYoH
         ov6y4Gpeic2pUMoe0VcgUaUOWP02xvpVFkw6TgjuWr71xhypfKrHd6npqUR/vHsWtJ
         mLTJAkoNb0vrkanVi26iqbcbPXwLaLOcFezAeH+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ratchanan Srirattanamet <peathot@hotmail.com>,
        Karol Herbst <kherbst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 65/89] drm/nouveau: dont detect DSM for non-NVIDIA device
Date:   Mon, 19 Jun 2023 12:30:53 +0200
Message-ID: <20230619102141.222468036@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
References: <20230619102138.279161276@linuxfoundation.org>
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

From: Ratchanan Srirattanamet <peathot@hotmail.com>

[ Upstream commit 11d24327c2d7ad7f24fcc44fb00e1fa91ebf6525 ]

The call site of nouveau_dsm_pci_probe() uses single set of output
variables for all invocations. So, we must not write anything to them
unless it's an NVIDIA device. Otherwise, if we are called with another
device after the NVIDIA device, we'll clober the result of the NVIDIA
device.

For example, if the other device doesn't have _PR3 resources, the
detection later would miss the presence of power resource support, and
the rest of the code will keep using Optimus DSM, breaking power
management for that machine.

Also, because we're detecting NVIDIA's DSM, it doesn't make sense to run
this detection on a non-NVIDIA device anyway. Thus, check at the
beginning of the detection code if this is an NVIDIA card, and just
return if it isn't.

This, together with commit d22915d22ded ("drm/nouveau/devinit/tu102-:
wait for GFW_BOOT_PROGRESS == COMPLETED") developed independently and
landed earlier, fixes runtime power management of the NVIDIA card in
Lenovo Legion 5-15ARH05. Without this patch, the GPU resumption code
will "timeout", sometimes hanging userspace.

As a bonus, we'll also stop preventing _PR3 usage from the bridge for
unrelated devices, which is always nice, I guess.

Fixes: ccfc2d5cdb02 ("drm/nouveau: Use generic helper to check _PR3 presence")
Signed-off-by: Ratchanan Srirattanamet <peathot@hotmail.com>
Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/79
Reviewed-by: Karol Herbst <kherbst@redhat.com>
Signed-off-by: Karol Herbst <kherbst@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/DM6PR19MB2780805D4BE1E3F9B3AC96D0BC409@DM6PR19MB2780.namprd19.prod.outlook.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
index 69a84d0197d0a..7b946d44ab2c1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
+++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
@@ -220,6 +220,9 @@ static void nouveau_dsm_pci_probe(struct pci_dev *pdev, acpi_handle *dhandle_out
 	int optimus_funcs;
 	struct pci_dev *parent_pdev;
 
+	if (pdev->vendor != PCI_VENDOR_ID_NVIDIA)
+		return;
+
 	*has_pr3 = false;
 	parent_pdev = pci_upstream_bridge(pdev);
 	if (parent_pdev) {
-- 
2.39.2



