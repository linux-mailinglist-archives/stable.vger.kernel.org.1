Return-Path: <stable+bounces-105588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2309FAD34
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 11:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C181651BE
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 10:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4AF193429;
	Mon, 23 Dec 2024 10:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nU/5Ws/J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEBC193408
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734950219; cv=none; b=fOavcnHkzlEupDeQtcGb4iwGjB8bRys+N2grb0V1aJEkB6RNBLgw5Qz/QcxjQvVQ8inzyY/JAsXIq/v11glrZruDRz3w0Rt+L3Xyjd2JTwe7QJYlgv2QanMnkgJxjj8VbszzabMmD/jcXURfzfd7SEnV2KOLttTsuwdlpkZ1nYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734950219; c=relaxed/simple;
	bh=gAsh7SYg2PxAFKaA9MgiglCID8/hGpMTKxrryKE3Mes=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZTMVa+xDR1wUpnBvz5q7m7UcoTFy4CgLSTuY2VY9EAk+MKkgnL+fVBCAiQhIxE9+qBBfGXL4D9Yp3omePcSNP9tCz583ZXpEkQiY9wHRg+zAurA+aSJ2arcDaR9p8ZVsa+fTumYUCLTdVpWtfBLGiMMgMDPK1bsp0lq8GLFGxUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nU/5Ws/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E79C4CED3;
	Mon, 23 Dec 2024 10:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734950218;
	bh=gAsh7SYg2PxAFKaA9MgiglCID8/hGpMTKxrryKE3Mes=;
	h=Subject:To:Cc:From:Date:From;
	b=nU/5Ws/JDuwLGkNGOfLIVJ7k7AMip1gPS+JyviMQvzqc+T/elZEtR5uPqQVq53eC5
	 qXUK3ZNksFbii62Vnlifpp6AehjBwaUhBSSqHzhqwBLqTuyxDB2K2LhyuBz10x8GVZ
	 zeaEnIOuhQOzW0q54bXkayb7OR8t2SBBnQ93BNuE=
Subject: FAILED: patch "[PATCH] Drivers: hv: util: Avoid accessing a ringbuffer not" failed to apply to 5.4-stable tree
To: mhklinux@outlook.com,decui@microsoft.com,wei.liu@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Dec 2024 11:36:56 +0100
Message-ID: <2024122355-diligence-trapper-0972@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 07a756a49f4b4290b49ea46e089cbe6f79ff8d26
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122355-diligence-trapper-0972@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 07a756a49f4b4290b49ea46e089cbe6f79ff8d26 Mon Sep 17 00:00:00 2001
From: Michael Kelley <mhklinux@outlook.com>
Date: Wed, 6 Nov 2024 07:42:47 -0800
Subject: [PATCH] Drivers: hv: util: Avoid accessing a ringbuffer not
 initialized yet

If the KVP (or VSS) daemon starts before the VMBus channel's ringbuffer is
fully initialized, we can hit the panic below:

hv_utils: Registering HyperV Utility Driver
hv_vmbus: registering driver hv_utils
...
BUG: kernel NULL pointer dereference, address: 0000000000000000
CPU: 44 UID: 0 PID: 2552 Comm: hv_kvp_daemon Tainted: G E 6.11.0-rc3+ #1
RIP: 0010:hv_pkt_iter_first+0x12/0xd0
Call Trace:
...
 vmbus_recvpacket
 hv_kvp_onchannelcallback
 vmbus_on_event
 tasklet_action_common
 tasklet_action
 handle_softirqs
 irq_exit_rcu
 sysvec_hyperv_stimer0
 </IRQ>
 <TASK>
 asm_sysvec_hyperv_stimer0
...
 kvp_register_done
 hvt_op_read
 vfs_read
 ksys_read
 __x64_sys_read

This can happen because the KVP/VSS channel callback can be invoked
even before the channel is fully opened:
1) as soon as hv_kvp_init() -> hvutil_transport_init() creates
/dev/vmbus/hv_kvp, the kvp daemon can open the device file immediately and
register itself to the driver by writing a message KVP_OP_REGISTER1 to the
file (which is handled by kvp_on_msg() ->kvp_handle_handshake()) and
reading the file for the driver's response, which is handled by
hvt_op_read(), which calls hvt->on_read(), i.e. kvp_register_done().

2) the problem with kvp_register_done() is that it can cause the
channel callback to be called even before the channel is fully opened,
and when the channel callback is starting to run, util_probe()->
vmbus_open() may have not initialized the ringbuffer yet, so the
callback can hit the panic of NULL pointer dereference.

To reproduce the panic consistently, we can add a "ssleep(10)" for KVP in
__vmbus_open(), just before the first hv_ringbuffer_init(), and then we
unload and reload the driver hv_utils, and run the daemon manually within
the 10 seconds.

Fix the panic by reordering the steps in util_probe() so the char dev
entry used by the KVP or VSS daemon is not created until after
vmbus_open() has completed. This reordering prevents the race condition
from happening.

Reported-by: Dexuan Cui <decui@microsoft.com>
Fixes: e0fa3e5e7df6 ("Drivers: hv: utils: fix a race on userspace daemons registration")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
Link: https://lore.kernel.org/r/20241106154247.2271-3-mhklinux@outlook.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20241106154247.2271-3-mhklinux@outlook.com>

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index 29e01247a087..7400a5a4d2bd 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -767,6 +767,12 @@ hv_kvp_init(struct hv_util_service *srv)
 	 */
 	kvp_transaction.state = HVUTIL_DEVICE_INIT;
 
+	return 0;
+}
+
+int
+hv_kvp_init_transport(void)
+{
 	hvt = hvutil_transport_init(kvp_devname, CN_KVP_IDX, CN_KVP_VAL,
 				    kvp_on_msg, kvp_on_reset);
 	if (!hvt)
diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 86d87486ed40..bde637a96c37 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -389,6 +389,12 @@ hv_vss_init(struct hv_util_service *srv)
 	 */
 	vss_transaction.state = HVUTIL_DEVICE_INIT;
 
+	return 0;
+}
+
+int
+hv_vss_init_transport(void)
+{
 	hvt = hvutil_transport_init(vss_devname, CN_VSS_IDX, CN_VSS_VAL,
 				    vss_on_msg, vss_on_reset);
 	if (!hvt) {
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 370722220134..36ee89c0358b 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -141,6 +141,7 @@ static struct hv_util_service util_heartbeat = {
 static struct hv_util_service util_kvp = {
 	.util_cb = hv_kvp_onchannelcallback,
 	.util_init = hv_kvp_init,
+	.util_init_transport = hv_kvp_init_transport,
 	.util_pre_suspend = hv_kvp_pre_suspend,
 	.util_pre_resume = hv_kvp_pre_resume,
 	.util_deinit = hv_kvp_deinit,
@@ -149,6 +150,7 @@ static struct hv_util_service util_kvp = {
 static struct hv_util_service util_vss = {
 	.util_cb = hv_vss_onchannelcallback,
 	.util_init = hv_vss_init,
+	.util_init_transport = hv_vss_init_transport,
 	.util_pre_suspend = hv_vss_pre_suspend,
 	.util_pre_resume = hv_vss_pre_resume,
 	.util_deinit = hv_vss_deinit,
@@ -611,6 +613,13 @@ static int util_probe(struct hv_device *dev,
 	if (ret)
 		goto error;
 
+	if (srv->util_init_transport) {
+		ret = srv->util_init_transport();
+		if (ret) {
+			vmbus_close(dev->channel);
+			goto error;
+		}
+	}
 	return 0;
 
 error:
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index d2856023d53c..52cb744b4d7f 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -370,12 +370,14 @@ void vmbus_on_event(unsigned long data);
 void vmbus_on_msg_dpc(unsigned long data);
 
 int hv_kvp_init(struct hv_util_service *srv);
+int hv_kvp_init_transport(void);
 void hv_kvp_deinit(void);
 int hv_kvp_pre_suspend(void);
 int hv_kvp_pre_resume(void);
 void hv_kvp_onchannelcallback(void *context);
 
 int hv_vss_init(struct hv_util_service *srv);
+int hv_vss_init_transport(void);
 void hv_vss_deinit(void);
 int hv_vss_pre_suspend(void);
 int hv_vss_pre_resume(void);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 22c22fb91042..02a226bcf0ed 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1559,6 +1559,7 @@ struct hv_util_service {
 	void *channel;
 	void (*util_cb)(void *);
 	int (*util_init)(struct hv_util_service *);
+	int (*util_init_transport)(void);
 	void (*util_deinit)(void);
 	int (*util_pre_suspend)(void);
 	int (*util_pre_resume)(void);


