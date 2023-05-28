Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDFD713AA4
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 18:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjE1Qnz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 12:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjE1Qny (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 12:43:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7BABB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 09:43:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85EC960DD5
        for <stable@vger.kernel.org>; Sun, 28 May 2023 16:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C95C433D2;
        Sun, 28 May 2023 16:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685292231;
        bh=l7Z/z+iwx82RFOZ5Kqcoptz6c8JU0uUy0aFOzUpsB7U=;
        h=Subject:To:Cc:From:Date:From;
        b=nvqWV5AutWFYD+2/cB/UAGNBeMBF/c/l4X312eZJz4aN6WQy3PUluSU1BpNEOSjhM
         vAT3caPiL7rIHdyIFRdqim12mSB7ccXkx0JO7YLMZL00+oGaBKijqt5HTV13eM3cWW
         smlLRPVzLnH/9aKpfQy/77qEvAO8Ij9BCTaOZ8ug=
Subject: FAILED: patch "[PATCH] platform/x86: ISST: Remove 8 socket limit" failed to apply to 5.15-stable tree
To:     steve.wahl@hpe.com, hdegoede@redhat.com,
        ilpo.jarvinen@linux.intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 17:43:48 +0100
Message-ID: <2023052848-preset-slapping-3df7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x bbb320bfe2c3e9740fe89cfa0a7089b4e8bfc4ff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052848-preset-slapping-3df7@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

bbb320bfe2c3 ("platform/x86: ISST: Remove 8 socket limit")
9a1aac8a96dc ("platform/x86: ISST: PUNIT device mapping with Sub-NUMA clustering")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bbb320bfe2c3e9740fe89cfa0a7089b4e8bfc4ff Mon Sep 17 00:00:00 2001
From: Steve Wahl <steve.wahl@hpe.com>
Date: Fri, 19 May 2023 11:04:20 -0500
Subject: [PATCH] platform/x86: ISST: Remove 8 socket limit
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Stop restricting the PCI search to a range of PCI domains fed to
pci_get_domain_bus_and_slot().  Instead, use for_each_pci_dev() and
look at all PCI domains in one pass.

On systems with more than 8 sockets, this avoids error messages like
"Information: Invalid level, Can't get TDP control information at
specified levels on cpu 480" from the intel speed select utility.

Fixes: aa2ddd242572 ("platform/x86: ISST: Use numa node id for cpu pci dev mapping")
Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20230519160420.2588475-1-steve.wahl@hpe.com
Signed-off-by: Hans de Goede <hdegoede@redhat.com>

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index e0572a29212e..02fe360a59c7 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -304,14 +304,13 @@ struct isst_if_pkg_info {
 static struct isst_if_cpu_info *isst_cpu_info;
 static struct isst_if_pkg_info *isst_pkg_info;
 
-#define ISST_MAX_PCI_DOMAINS	8
-
 static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn)
 {
 	struct pci_dev *matched_pci_dev = NULL;
 	struct pci_dev *pci_dev = NULL;
+	struct pci_dev *_pci_dev = NULL;
 	int no_matches = 0, pkg_id;
-	int i, bus_number;
+	int bus_number;
 
 	if (bus_no < 0 || bus_no >= ISST_MAX_BUS_NUMBER || cpu < 0 ||
 	    cpu >= nr_cpu_ids || cpu >= num_possible_cpus())
@@ -323,12 +322,11 @@ static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn
 	if (bus_number < 0)
 		return NULL;
 
-	for (i = 0; i < ISST_MAX_PCI_DOMAINS; ++i) {
-		struct pci_dev *_pci_dev;
+	for_each_pci_dev(_pci_dev) {
 		int node;
 
-		_pci_dev = pci_get_domain_bus_and_slot(i, bus_number, PCI_DEVFN(dev, fn));
-		if (!_pci_dev)
+		if (_pci_dev->bus->number != bus_number ||
+		    _pci_dev->devfn != PCI_DEVFN(dev, fn))
 			continue;
 
 		++no_matches;

