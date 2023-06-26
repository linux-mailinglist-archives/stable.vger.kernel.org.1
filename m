Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B0B73E8EC
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjFZSaq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjFZSaL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:30:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE87F171A
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:30:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5219060F4B
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAE7C433C0;
        Mon, 26 Jun 2023 18:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804209;
        bh=l15jnZ/i7qE/A3PEVGMmo0QkMs+AmSrGDA1I8OenQxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fw2kgyPDKt5CUjE3at3VLITIO/oEkbntsgLd2xW1GqFrivIbb1FiklyqsTaKYc7rG
         r3D1JGG5kEvfhwlT8GS8RWvuz2dbZudc14+cBJ59hbXUGld5UOX4NCXn+5+qsx/hbp
         Zr157SzbmHHi8QNccHhJZgdEGbXFs8d1p973bmtA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Wei Liu <wei.liu@kernel.org>
Subject: [PATCH 6.1 050/170] PCI: hv: Fix a race condition bug in hv_pci_query_relations()
Date:   Mon, 26 Jun 2023 20:10:19 +0200
Message-ID: <20230626180802.812101139@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
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

From: Dexuan Cui <decui@microsoft.com>

commit 440b5e3663271b0ffbd4908115044a6a51fb938b upstream.

Since day 1 of the driver, there has been a race between
hv_pci_query_relations() and survey_child_resources(): during fast
device hotplug, hv_pci_query_relations() may error out due to
device-remove and the stack variable 'comp' is no longer valid;
however, pci_devices_present_work() -> survey_child_resources() ->
complete() may be running on another CPU and accessing the no-longer-valid
'comp'. Fix the race by flushing the workqueue before we exit from
hv_pci_query_relations().

Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230615044451.5580-2-decui@microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/pci-hyperv.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3321,6 +3321,24 @@ static int hv_pci_query_relations(struct
 	if (!ret)
 		ret = wait_for_response(hdev, &comp);
 
+	/*
+	 * In the case of fast device addition/removal, it's possible that
+	 * vmbus_sendpacket() or wait_for_response() returns -ENODEV but we
+	 * already got a PCI_BUS_RELATIONS* message from the host and the
+	 * channel callback already scheduled a work to hbus->wq, which can be
+	 * running pci_devices_present_work() -> survey_child_resources() ->
+	 * complete(&hbus->survey_event), even after hv_pci_query_relations()
+	 * exits and the stack variable 'comp' is no longer valid; as a result,
+	 * a hang or a page fault may happen when the complete() calls
+	 * raw_spin_lock_irqsave(). Flush hbus->wq before we exit from
+	 * hv_pci_query_relations() to avoid the issues. Note: if 'ret' is
+	 * -ENODEV, there can't be any more work item scheduled to hbus->wq
+	 * after the flush_workqueue(): see vmbus_onoffer_rescind() ->
+	 * vmbus_reset_channel_cb(), vmbus_rescind_cleanup() ->
+	 * channel->rescind = true.
+	 */
+	flush_workqueue(hbus->wq);
+
 	return ret;
 }
 


