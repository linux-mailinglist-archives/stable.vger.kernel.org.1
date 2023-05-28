Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13B7713E3E
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjE1Tdk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjE1Tdg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:33:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044C4BB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:33:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95DF861DD1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E41C433EF;
        Sun, 28 May 2023 19:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302415;
        bh=ayn8WPNBmwxt++QIuaoYDi/Ugbh0R12xKITBoF5kzyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HqCZMaVeBUJCslfOKNZEzYuKMUE9bJvmBwQ3/GbZQqBgBeLm8KGlMFAi5YOLshrnB
         2QyqxFRFWXIEbrpLWcR1KtH3Rs5GRfCM+YYeHR74EqNX7WkUtbijofh3nzW1QrrRgg
         A13BTE1UZsD4gwSfb1AzSVcbMNZGxUvO8NY1BFW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Steve Wahl <steve.wahl@hpe.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 6.3 094/127] platform/x86: ISST: Remove 8 socket limit
Date:   Sun, 28 May 2023 20:11:10 +0100
Message-Id: <20230528190839.368312849@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Steve Wahl <steve.wahl@hpe.com>

commit bbb320bfe2c3e9740fe89cfa0a7089b4e8bfc4ff upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -295,14 +295,13 @@ struct isst_if_pkg_info {
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
@@ -314,12 +313,11 @@ static struct pci_dev *_isst_if_get_pci_
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


