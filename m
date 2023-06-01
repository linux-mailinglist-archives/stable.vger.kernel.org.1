Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82BF719DAD
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjFANZm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjFANZg (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:25:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661BBE62
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:25:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E60E96446B
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB93C433EF;
        Thu,  1 Jun 2023 13:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625899;
        bh=+FuEXp2CrXa7JRb6HVnkawtf9eBceJOwfEgaYneRn1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eRO1KxvZrJ8Y2eSZCuSGS+elBTkRLBlr6+xbKPp6DrV4qwjWlznm/nMnP4id6LzL9
         crulpwlaYoPh9pk0dqR/BOdyJ5ZUUu0IL1+5HrbKCSKFzpHZQNgW6aB1RzsiIu7yFH
         Bf8FUmwk+639ZBTWzAkOpaxy/vkp/xW3l1xRlx7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 11/42] platform/x86: ISST: PUNIT device mapping with Sub-NUMA clustering
Date:   Thu,  1 Jun 2023 14:20:58 +0100
Message-Id: <20230601131937.210474739@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131936.699199833@linuxfoundation.org>
References: <20230601131936.699199833@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 9a1aac8a96dc014bec49806a7a964bf2fdbd315f ]

On a multiple package system using Sub-NUMA clustering, there is an issue
in mapping Linux CPU number to PUNIT PCI device when manufacturer decided
to reuse the PCI bus number across packages. Bus number can be reused as
long as they are in different domain or segment. In this case some CPU
will fail to find a PCI device to issue SST requests.

When bus numbers are reused across CPU packages, we are using proximity
information by matching CPU numa node id to PUNIT PCI device numa node
id. But on a package there can be only one PUNIT PCI device, but multiple
numa nodes (one for each sub cluster). So, the numa node ID of the PUNIT
PCI device can only match with one numa node id of CPUs in a sub cluster
in the package.

Since there can be only one PUNIT PCI device per package, if we match
with numa node id of any sub cluster in that package, we can use that
mapping for any CPU in that package. So, store the match information
in a per package data structure and return the information when there
is no match.

While here, use defines for max bus number instead of hardcoding.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://lore.kernel.org/r/20220629194817.2418240-1-srinivas.pandruvada@linux.intel.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Stable-dep-of: bbb320bfe2c3 ("platform/x86: ISST: Remove 8 socket limit")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../intel/speed_select_if/isst_if_common.c    | 39 +++++++++++++++----
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index e8424e70d81d2..fd102678c75f6 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -277,29 +277,38 @@ static int isst_if_get_platform_info(void __user *argp)
 	return 0;
 }
 
+#define ISST_MAX_BUS_NUMBER	2
 
 struct isst_if_cpu_info {
 	/* For BUS 0 and BUS 1 only, which we need for PUNIT interface */
-	int bus_info[2];
-	struct pci_dev *pci_dev[2];
+	int bus_info[ISST_MAX_BUS_NUMBER];
+	struct pci_dev *pci_dev[ISST_MAX_BUS_NUMBER];
 	int punit_cpu_id;
 	int numa_node;
 };
 
+struct isst_if_pkg_info {
+	struct pci_dev *pci_dev[ISST_MAX_BUS_NUMBER];
+};
+
 static struct isst_if_cpu_info *isst_cpu_info;
+static struct isst_if_pkg_info *isst_pkg_info;
+
 #define ISST_MAX_PCI_DOMAINS	8
 
 static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn)
 {
 	struct pci_dev *matched_pci_dev = NULL;
 	struct pci_dev *pci_dev = NULL;
-	int no_matches = 0;
+	int no_matches = 0, pkg_id;
 	int i, bus_number;
 
-	if (bus_no < 0 || bus_no > 1 || cpu < 0 || cpu >= nr_cpu_ids ||
-	    cpu >= num_possible_cpus())
+	if (bus_no < 0 || bus_no >= ISST_MAX_BUS_NUMBER || cpu < 0 ||
+	    cpu >= nr_cpu_ids || cpu >= num_possible_cpus())
 		return NULL;
 
+	pkg_id = topology_physical_package_id(cpu);
+
 	bus_number = isst_cpu_info[cpu].bus_info[bus_no];
 	if (bus_number < 0)
 		return NULL;
@@ -324,6 +333,8 @@ static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn
 		}
 
 		if (node == isst_cpu_info[cpu].numa_node) {
+			isst_pkg_info[pkg_id].pci_dev[bus_no] = _pci_dev;
+
 			pci_dev = _pci_dev;
 			break;
 		}
@@ -342,6 +353,10 @@ static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn
 	if (!pci_dev && no_matches == 1)
 		pci_dev = matched_pci_dev;
 
+	/* Return pci_dev pointer for any matched CPU in the package */
+	if (!pci_dev)
+		pci_dev = isst_pkg_info[pkg_id].pci_dev[bus_no];
+
 	return pci_dev;
 }
 
@@ -361,8 +376,8 @@ struct pci_dev *isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn)
 {
 	struct pci_dev *pci_dev;
 
-	if (bus_no < 0 || bus_no > 1 || cpu < 0 || cpu >= nr_cpu_ids ||
-	    cpu >= num_possible_cpus())
+	if (bus_no < 0 || bus_no >= ISST_MAX_BUS_NUMBER  || cpu < 0 ||
+	    cpu >= nr_cpu_ids || cpu >= num_possible_cpus())
 		return NULL;
 
 	pci_dev = isst_cpu_info[cpu].pci_dev[bus_no];
@@ -417,10 +432,19 @@ static int isst_if_cpu_info_init(void)
 	if (!isst_cpu_info)
 		return -ENOMEM;
 
+	isst_pkg_info = kcalloc(topology_max_packages(),
+				sizeof(*isst_pkg_info),
+				GFP_KERNEL);
+	if (!isst_pkg_info) {
+		kfree(isst_cpu_info);
+		return -ENOMEM;
+	}
+
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				"platform/x86/isst-if:online",
 				isst_if_cpu_online, NULL);
 	if (ret < 0) {
+		kfree(isst_pkg_info);
 		kfree(isst_cpu_info);
 		return ret;
 	}
@@ -433,6 +457,7 @@ static int isst_if_cpu_info_init(void)
 static void isst_if_cpu_info_exit(void)
 {
 	cpuhp_remove_state(isst_if_online_id);
+	kfree(isst_pkg_info);
 	kfree(isst_cpu_info);
 };
 
-- 
2.39.2



