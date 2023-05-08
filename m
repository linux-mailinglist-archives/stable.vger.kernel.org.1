Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25586FA736
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjEHK2g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbjEHK2P (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:28:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7361719
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43F7A6264E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040D3C433EF;
        Mon,  8 May 2023 10:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541677;
        bh=x8PeYNY0rZ9ItwFo4OWQsWe2NVoiqx/uoWA+Kgrf+CM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vba17WObsDwrpeeHTrHEtP5a2FNx/gJekSkwBYPhpiKImgJbPx7FURJ6PN0DMlboV
         czbcTHlHpyuQSi+/axAY1riVja8uc/KuALgw9hNjAh1Aya3jUfY+3x5HN7xJIn6Mqm
         QF+fonZQD6JftqD1cQ9IOBIkOLeu1d23nQMOVwzM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 191/663] ACPI: processor: Fix evaluating _PDC method when running as Xen dom0
Date:   Mon,  8 May 2023 11:40:17 +0200
Message-Id: <20230508094434.610422452@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Roger Pau Monne <roger.pau@citrix.com>

[ Upstream commit 073828e954459b883f23e53999d31e4c55ab9654 ]

In ACPI systems, the OS can direct power management, as opposed to the
firmware.  This OS-directed Power Management is called OSPM.  Part of
telling the firmware that the OS going to direct power management is
making ACPI "_PDC" (Processor Driver Capabilities) calls.  These _PDC
methods must be evaluated for every processor object.  If these _PDC
calls are not completed for every processor it can lead to
inconsistency and later failures in things like the CPU frequency
driver.

In a Xen system, the dom0 kernel is responsible for system-wide power
management.  The dom0 kernel is in charge of OSPM.  However, the
number of CPUs available to dom0 can be different than the number of
CPUs physically present on the system.

This leads to a problem: the dom0 kernel needs to evaluate _PDC for
all the processors, but it can't always see them.

In dom0 kernels, ignore the existing ACPI method for determining if a
processor is physically present because it might not be accurate.
Instead, ask the hypervisor for this information.

Fix this by introducing a custom function to use when running as Xen
dom0 in order to check whether a processor object matches a CPU that's
online.  Such checking is done using the existing information fetched
by the Xen pCPU subsystem, extending it to also store the ACPI ID.

This ensures that _PDC method gets evaluated for all physically online
CPUs, regardless of the number of CPUs made available to dom0.

Fixes: 5d554a7bb064 ("ACPI: processor: add internal processor_physically_present()")
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/processor_pdc.c | 11 +++++++++++
 drivers/xen/pcpu.c           | 20 ++++++++++++++++++++
 include/xen/xen.h            | 11 +++++++++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 8c3f82c9fff35..18fb04523f93b 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -14,6 +14,8 @@
 #include <linux/acpi.h>
 #include <acpi/processor.h>
 
+#include <xen/xen.h>
+
 #include "internal.h"
 
 static bool __init processor_physically_present(acpi_handle handle)
@@ -47,6 +49,15 @@ static bool __init processor_physically_present(acpi_handle handle)
 		return false;
 	}
 
+	if (xen_initial_domain())
+		/*
+		 * When running as a Xen dom0 the number of processors Linux
+		 * sees can be different from the real number of processors on
+		 * the system, and we still need to execute _PDC for all of
+		 * them.
+		 */
+		return xen_processor_present(acpi_id);
+
 	type = (acpi_type == ACPI_TYPE_DEVICE) ? 1 : 0;
 	cpuid = acpi_get_cpuid(handle, type, acpi_id);
 
diff --git a/drivers/xen/pcpu.c b/drivers/xen/pcpu.c
index fd3a644b08559..b3e3d1bb37f3e 100644
--- a/drivers/xen/pcpu.c
+++ b/drivers/xen/pcpu.c
@@ -58,6 +58,7 @@ struct pcpu {
 	struct list_head list;
 	struct device dev;
 	uint32_t cpu_id;
+	uint32_t acpi_id;
 	uint32_t flags;
 };
 
@@ -249,6 +250,7 @@ static struct pcpu *create_and_register_pcpu(struct xenpf_pcpuinfo *info)
 
 	INIT_LIST_HEAD(&pcpu->list);
 	pcpu->cpu_id = info->xen_cpuid;
+	pcpu->acpi_id = info->acpi_id;
 	pcpu->flags = info->flags;
 
 	/* Need hold on xen_pcpu_lock before pcpu list manipulations */
@@ -381,3 +383,21 @@ static int __init xen_pcpu_init(void)
 	return ret;
 }
 arch_initcall(xen_pcpu_init);
+
+#ifdef CONFIG_ACPI
+bool __init xen_processor_present(uint32_t acpi_id)
+{
+	const struct pcpu *pcpu;
+	bool online = false;
+
+	mutex_lock(&xen_pcpu_lock);
+	list_for_each_entry(pcpu, &xen_pcpus, list)
+		if (pcpu->acpi_id == acpi_id) {
+			online = pcpu->flags & XEN_PCPU_FLAGS_ONLINE;
+			break;
+		}
+	mutex_unlock(&xen_pcpu_lock);
+
+	return online;
+}
+#endif
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 7adf59837c258..0efeb652f9b8f 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -71,4 +71,15 @@ static inline void xen_free_unpopulated_pages(unsigned int nr_pages,
 }
 #endif
 
+#if defined(CONFIG_XEN_DOM0) && defined(CONFIG_ACPI) && defined(CONFIG_X86)
+bool __init xen_processor_present(uint32_t acpi_id);
+#else
+#include <linux/bug.h>
+static inline bool xen_processor_present(uint32_t acpi_id)
+{
+	BUG();
+	return false;
+}
+#endif
+
 #endif	/* _XEN_XEN_H */
-- 
2.39.2



