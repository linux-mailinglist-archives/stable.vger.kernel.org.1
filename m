Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C6073E9AD
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjFZSi6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjFZSit (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:38:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2088B1BD2
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:38:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2B9860F18
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA04C433C8;
        Mon, 26 Jun 2023 18:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804722;
        bh=6IrxlZ4T5WeXUxEWoxtrS5UKasJ+AB0rT2xsDWcxRD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BuEp4XOAz14tvhI2ngDdXBDVXEk9BcqSmgDO2220fQPa8wJSeCTWOQ6BWBRkQh5px
         k+o2Gm6HnFw1P/Dstj1C93EyzwnUz+fZXnnMDSH8IyIvksjcJ7BBEXbarSvtmRkA1V
         azozpiDYpsOVs9CZcppNxm7plFmPyALKkl3CuKJI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Hu <weh@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH 5.15 20/96] Revert "PCI: hv: Fix a timing issue which causes kdump to fail occasionally"
Date:   Mon, 26 Jun 2023 20:11:35 +0200
Message-ID: <20230626180747.768180172@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180746.943455203@linuxfoundation.org>
References: <20230626180746.943455203@linuxfoundation.org>
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

From: Dexuan Cui <decui@microsoft.com>

commit a847234e24d03d01a9566d1d9dcce018cc018d67 upstream.

This reverts commit d6af2ed29c7c1c311b96dac989dcb991e90ee195.

The statement "the hv_pci_bus_exit() call releases structures of all its
child devices" in commit d6af2ed29c7c is not true: in the path
hv_pci_probe() -> hv_pci_enter_d0() -> hv_pci_bus_exit(hdev, true): the
parameter "keep_devs" is true, so hv_pci_bus_exit() does *not* release the
child "struct hv_pci_dev *hpdev" that is created earlier in
pci_devices_present_work() -> new_pcichild_device().

The commit d6af2ed29c7c was originally made in July 2020 for RHEL 7.7,
where the old version of hv_pci_bus_exit() was used; when the commit was
rebased and merged into the upstream, people didn't notice that it's
not really necessary. The commit itself doesn't cause any issue, but it
makes hv_pci_probe() more complicated. Revert it to facilitate some
upcoming changes to hv_pci_probe().

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Wei Hu <weh@microsoft.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230615044451.5580-5-decui@microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/pci-hyperv.c |   71 +++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 37 deletions(-)

--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2889,8 +2889,10 @@ static int hv_pci_enter_d0(struct hv_dev
 	struct pci_bus_d0_entry *d0_entry;
 	struct hv_pci_compl comp_pkt;
 	struct pci_packet *pkt;
+	bool retry = true;
 	int ret;
 
+enter_d0_retry:
 	/*
 	 * Tell the host that the bus is ready to use, and moved into the
 	 * powered-on state.  This includes telling the host which region
@@ -2917,6 +2919,38 @@ static int hv_pci_enter_d0(struct hv_dev
 	if (ret)
 		goto exit;
 
+	/*
+	 * In certain case (Kdump) the pci device of interest was
+	 * not cleanly shut down and resource is still held on host
+	 * side, the host could return invalid device status.
+	 * We need to explicitly request host to release the resource
+	 * and try to enter D0 again.
+	 */
+	if (comp_pkt.completion_status < 0 && retry) {
+		retry = false;
+
+		dev_err(&hdev->device, "Retrying D0 Entry\n");
+
+		/*
+		 * Hv_pci_bus_exit() calls hv_send_resource_released()
+		 * to free up resources of its child devices.
+		 * In the kdump kernel we need to set the
+		 * wslot_res_allocated to 255 so it scans all child
+		 * devices to release resources allocated in the
+		 * normal kernel before panic happened.
+		 */
+		hbus->wslot_res_allocated = 255;
+
+		ret = hv_pci_bus_exit(hdev, true);
+
+		if (ret == 0) {
+			kfree(pkt);
+			goto enter_d0_retry;
+		}
+		dev_err(&hdev->device,
+			"Retrying D0 failed with ret %d\n", ret);
+	}
+
 	if (comp_pkt.completion_status < 0) {
 		dev_err(&hdev->device,
 			"PCI Pass-through VSP failed D0 Entry with status %x\n",
@@ -3162,7 +3196,6 @@ static int hv_pci_probe(struct hv_device
 	struct hv_pcibus_device *hbus;
 	u16 dom_req, dom;
 	char *name;
-	bool enter_d0_retry = true;
 	int ret;
 
 	/*
@@ -3298,47 +3331,11 @@ static int hv_pci_probe(struct hv_device
 	if (ret)
 		goto free_fwnode;
 
-retry:
 	ret = hv_pci_query_relations(hdev);
 	if (ret)
 		goto free_irq_domain;
 
 	ret = hv_pci_enter_d0(hdev);
-	/*
-	 * In certain case (Kdump) the pci device of interest was
-	 * not cleanly shut down and resource is still held on host
-	 * side, the host could return invalid device status.
-	 * We need to explicitly request host to release the resource
-	 * and try to enter D0 again.
-	 * Since the hv_pci_bus_exit() call releases structures
-	 * of all its child devices, we need to start the retry from
-	 * hv_pci_query_relations() call, requesting host to send
-	 * the synchronous child device relations message before this
-	 * information is needed in hv_send_resources_allocated()
-	 * call later.
-	 */
-	if (ret == -EPROTO && enter_d0_retry) {
-		enter_d0_retry = false;
-
-		dev_err(&hdev->device, "Retrying D0 Entry\n");
-
-		/*
-		 * Hv_pci_bus_exit() calls hv_send_resources_released()
-		 * to free up resources of its child devices.
-		 * In the kdump kernel we need to set the
-		 * wslot_res_allocated to 255 so it scans all child
-		 * devices to release resources allocated in the
-		 * normal kernel before panic happened.
-		 */
-		hbus->wslot_res_allocated = 255;
-		ret = hv_pci_bus_exit(hdev, true);
-
-		if (ret == 0)
-			goto retry;
-
-		dev_err(&hdev->device,
-			"Retrying D0 failed with ret %d\n", ret);
-	}
 	if (ret)
 		goto free_irq_domain;
 


