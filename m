Return-Path: <stable+bounces-49815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35338FEEF8
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F922824FD
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE9019923A;
	Thu,  6 Jun 2024 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZTH7UocY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0961A1885;
	Thu,  6 Jun 2024 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683723; cv=none; b=qVU8q5OmEIISYB9O/vkxjK35I++cvUFw/YzURDArvE/bdDQ93cX/EXsQ/RRSkqGoXTkZKAQKMJIqydPvzUfHjNcfu0SobR/T41+yloZpjo3/JFty07+5OdLnS20R1pY1hovxxHTBgrsh8Nv4pGTX/6DmiJdx/fzzDEsnYTKYo0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683723; c=relaxed/simple;
	bh=e5wAGgwY3S3pRJ8C3qtOU845qdMONiCwiWqDsSKcqlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A73hg9rKmUZssoaLKdJDGmyMXHzccClVWJCuQiTXNpu8T2eQI5hCDQHPFd7XQDI/a/bjO4VWhw0OhL9+to4Fbsr33MJFeh4NBp4Xj++TzHwWT6ZCVFoeJ1IxvM4yE0pV+9wf/vS7zeBn2069vWHqdk0b5IKfbz+jtxKDufxxt+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZTH7UocY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C23C32781;
	Thu,  6 Jun 2024 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683722;
	bh=e5wAGgwY3S3pRJ8C3qtOU845qdMONiCwiWqDsSKcqlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZTH7UocYikD6pGe5sFztQMBaMXZKIL8zwXojo9STcTveDDR1kktxVQrceolBClQ4W
	 atJ30OlGj0v8MI440zuPp5a6f8Is6j7ComehEo/ET/Fq1k7/8OlRa3N0EqQV2jL1Xl
	 o+5wBA6XPWLkN4gJy38dd6IOc3F9RA/021WieLlM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Henry Wang <xin.wang2@amd.com>,
	Michal Orzel <michal.orzel@amd.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 667/744] drivers/xen: Improve the late XenStore init protocol
Date: Thu,  6 Jun 2024 16:05:39 +0200
Message-ID: <20240606131753.864737067@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Henry Wang <xin.wang2@amd.com>

[ Upstream commit a3607581cd49c17128a486a526a36a97bafcb2bb ]

Currently, the late XenStore init protocol is only triggered properly
for the case that HVM_PARAM_STORE_PFN is ~0ULL (invalid). For the
case that XenStore interface is allocated but not ready (the connection
status is not XENSTORE_CONNECTED), Linux should also wait until the
XenStore is set up properly.

Introduce a macro to describe the XenStore interface is ready, use
it in xenbus_probe_initcall() to select the code path of doing the
late XenStore init protocol or not. Since now we have more than one
condition for XenStore late init, rework the check in xenbus_probe()
for the free_irq().

Take the opportunity to enhance the check of the allocated XenStore
interface can be properly mapped, and return error early if the
memremap() fails.

Fixes: 5b3353949e89 ("xen: add support for initializing xenstore later as HVM domain")
Signed-off-by: Henry Wang <xin.wang2@amd.com>
Signed-off-by: Michal Orzel <michal.orzel@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Link: https://lore.kernel.org/r/20240517011516.1451087-1-xin.wang2@amd.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/xenbus/xenbus_probe.c | 36 ++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 3205e5d724c8c..1a9ded0cddcb0 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -65,13 +65,17 @@
 #include "xenbus.h"
 
 
-static int xs_init_irq;
+static int xs_init_irq = -1;
 int xen_store_evtchn;
 EXPORT_SYMBOL_GPL(xen_store_evtchn);
 
 struct xenstore_domain_interface *xen_store_interface;
 EXPORT_SYMBOL_GPL(xen_store_interface);
 
+#define XS_INTERFACE_READY \
+	((xen_store_interface != NULL) && \
+	 (xen_store_interface->connection == XENSTORE_CONNECTED))
+
 enum xenstore_init xen_store_domain_type;
 EXPORT_SYMBOL_GPL(xen_store_domain_type);
 
@@ -751,19 +755,19 @@ static void xenbus_probe(void)
 {
 	xenstored_ready = 1;
 
-	if (!xen_store_interface) {
+	if (!xen_store_interface)
 		xen_store_interface = memremap(xen_store_gfn << XEN_PAGE_SHIFT,
 					       XEN_PAGE_SIZE, MEMREMAP_WB);
-		/*
-		 * Now it is safe to free the IRQ used for xenstore late
-		 * initialization. No need to unbind: it is about to be
-		 * bound again from xb_init_comms. Note that calling
-		 * unbind_from_irqhandler now would result in xen_evtchn_close()
-		 * being called and the event channel not being enabled again
-		 * afterwards, resulting in missed event notifications.
-		 */
+	/*
+	 * Now it is safe to free the IRQ used for xenstore late
+	 * initialization. No need to unbind: it is about to be
+	 * bound again from xb_init_comms. Note that calling
+	 * unbind_from_irqhandler now would result in xen_evtchn_close()
+	 * being called and the event channel not being enabled again
+	 * afterwards, resulting in missed event notifications.
+	 */
+	if (xs_init_irq >= 0)
 		free_irq(xs_init_irq, &xb_waitq);
-	}
 
 	/*
 	 * In the HVM case, xenbus_init() deferred its call to
@@ -822,7 +826,7 @@ static int __init xenbus_probe_initcall(void)
 	if (xen_store_domain_type == XS_PV ||
 	    (xen_store_domain_type == XS_HVM &&
 	     !xs_hvm_defer_init_for_callback() &&
-	     xen_store_interface != NULL))
+	     XS_INTERFACE_READY))
 		xenbus_probe();
 
 	/*
@@ -831,7 +835,7 @@ static int __init xenbus_probe_initcall(void)
 	 * started, then probe.  It will be triggered when communication
 	 * starts happening, by waiting on xb_waitq.
 	 */
-	if (xen_store_domain_type == XS_LOCAL || xen_store_interface == NULL) {
+	if (xen_store_domain_type == XS_LOCAL || !XS_INTERFACE_READY) {
 		struct task_struct *probe_task;
 
 		probe_task = kthread_run(xenbus_probe_thread, NULL,
@@ -1014,6 +1018,12 @@ static int __init xenbus_init(void)
 			xen_store_interface =
 				memremap(xen_store_gfn << XEN_PAGE_SHIFT,
 					 XEN_PAGE_SIZE, MEMREMAP_WB);
+			if (!xen_store_interface) {
+				pr_err("%s: cannot map HVM_PARAM_STORE_PFN=%llx\n",
+				       __func__, v);
+				err = -EINVAL;
+				goto out_error;
+			}
 			if (xen_store_interface->connection != XENSTORE_CONNECTED)
 				wait = true;
 		}
-- 
2.43.0




