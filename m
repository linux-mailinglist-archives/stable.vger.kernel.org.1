Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9238773B386
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 11:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjFWJ2U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 05:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjFWJ2T (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 05:28:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEA59D
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 02:28:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D752B619E4
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 09:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14C9C433C8;
        Fri, 23 Jun 2023 09:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687512497;
        bh=16CWMx4578xFFxv6B7yxxGBpZKSXTUou9Pt/9w/CCmk=;
        h=Subject:To:Cc:From:Date:From;
        b=MPxpfXEKrH1og8WJ8tp5o1JYY2BjFOglKLqaLQNlqwnX9yGLq4+GO3z4dlM81fh2K
         Ent2aKdehpecLgFgxiMJd/0AzqSeA1tQRSTZy6g4c4C0q2GLiT/VYVNRosvHgoi5ww
         1Zz5gLiDwUz/4ROZgqZxzwC1btUUOt4okbxc4Jao=
Subject: FAILED: patch "[PATCH] PCI: hv: Remove the useless hv_pcichild_state from struct" failed to apply to 4.19-stable tree
To:     decui@microsoft.com, lpieralisi@kernel.org, mikelley@microsoft.com,
        wei.liu@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 23 Jun 2023 11:28:06 +0200
Message-ID: <2023062306-sphinx-acid-52ac@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x add9195e69c94b32e96f78c2f9cea68f0e850b3f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023062306-sphinx-acid-52ac@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From add9195e69c94b32e96f78c2f9cea68f0e850b3f Mon Sep 17 00:00:00 2001
From: Dexuan Cui <decui@microsoft.com>
Date: Wed, 14 Jun 2023 21:44:49 -0700
Subject: [PATCH] PCI: hv: Remove the useless hv_pcichild_state from struct
 hv_pci_dev

The hpdev->state is never really useful. The only use in
hv_pci_eject_device() and hv_eject_device_work() is not really necessary.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230615044451.5580-4-decui@microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 733637d96765..a826b41c949a 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -545,19 +545,10 @@ struct hv_dr_state {
 	struct hv_pcidev_description func[];
 };
 
-enum hv_pcichild_state {
-	hv_pcichild_init = 0,
-	hv_pcichild_requirements,
-	hv_pcichild_resourced,
-	hv_pcichild_ejecting,
-	hv_pcichild_maximum
-};
-
 struct hv_pci_dev {
 	/* List protected by pci_rescan_remove_lock */
 	struct list_head list_entry;
 	refcount_t refs;
-	enum hv_pcichild_state state;
 	struct pci_slot *pci_slot;
 	struct hv_pcidev_description desc;
 	bool reported_missing;
@@ -2843,8 +2834,6 @@ static void hv_eject_device_work(struct work_struct *work)
 	hpdev = container_of(work, struct hv_pci_dev, wrk);
 	hbus = hpdev->hbus;
 
-	WARN_ON(hpdev->state != hv_pcichild_ejecting);
-
 	/*
 	 * Ejection can come before or after the PCI bus has been set up, so
 	 * attempt to find it and tear down the bus state, if it exists.  This
@@ -2901,7 +2890,6 @@ static void hv_pci_eject_device(struct hv_pci_dev *hpdev)
 		return;
 	}
 
-	hpdev->state = hv_pcichild_ejecting;
 	get_pcichild(hpdev);
 	INIT_WORK(&hpdev->wrk, hv_eject_device_work);
 	queue_work(hbus->wq, &hpdev->wrk);

