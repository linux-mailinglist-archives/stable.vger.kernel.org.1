Return-Path: <stable+bounces-59-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1A87F5F20
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 13:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF90D281D1D
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 12:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F213241E3;
	Thu, 23 Nov 2023 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N0rpxO1/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FDB24B38
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 12:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAA3C433C8;
	Thu, 23 Nov 2023 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700743171;
	bh=S2+C1tCkzSKYMzrO79TmUSVKE7jb9Zk2vJlq4LwUPr0=;
	h=Subject:To:Cc:From:Date:From;
	b=N0rpxO1/1CPLts+1AJ3ZL7vyVDgH03s46OwJ68r32BXyjIG+qGR/i2Q3lR0He9Vpl
	 GgjyGvCiGz5xmQK/QCXR9RornnARb5RTnjGW8s3SFQO0pIYN9ooKt3mtK9Zu398OuJ
	 nUl+YgKWjwJmaSpyZ6/lytTmgWt5l4AapYjaXZ+g=
Subject: FAILED: patch "[PATCH] cxl/port: Fix delete_endpoint() vs parent unregistration race" failed to apply to 6.1-stable tree
To: dan.j.williams@intel.com,rrichter@amd.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 23 Nov 2023 12:27:53 +0000
Message-ID: <2023112353-massive-tiara-8774@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8d2ad999ca3c64cb08cf6a58d227b9d9e746d708
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112353-massive-tiara-8774@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

8d2ad999ca3c ("cxl/port: Fix delete_endpoint() vs parent unregistration race")
516b300c4ca8 ("cxl/memdev: Formalize endpoint port linkage")
0a105ab28a4d ("cxl/memdev: Warn of poison inject or clear to a mapped region")
9690b07748d1 ("cxl/memdev: Add support for the Clear Poison mailbox command")
d2fbc4865802 ("cxl/memdev: Add support for the Inject Poison mailbox command")
f0832a586396 ("cxl/region: Provide region info to the cxl_poison trace event")
7ff6ad107588 ("cxl/memdev: Add trigger_poison_list sysfs attribute")
ed83f7ca398b ("cxl/mbox: Add GET_POISON_LIST mailbox command")
d0abf5787adc ("cxl/mbox: Initialize the poison state")
d35b495ddf92 ("cxl/port: Fix find_cxl_root() for RCDs and simplify it")
23c198e3dfaa ("Merge branch 'for-6.3/cxl-events' into cxl/next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8d2ad999ca3c64cb08cf6a58d227b9d9e746d708 Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 27 Oct 2023 20:13:23 -0700
Subject: [PATCH] cxl/port: Fix delete_endpoint() vs parent unregistration race

The CXL subsystem, at cxl_mem ->probe() time, establishes a lineage of
ports (struct cxl_port objects) between an endpoint and the root of a
CXL topology. Each port including the endpoint port is attached to the
cxl_port driver.

Given that setup, it follows that when either any port in that lineage
goes through a cxl_port ->remove() event, or the memdev goes through a
cxl_mem ->remove() event. The hierarchy below the removed port, or the
entire hierarchy if the memdev is removed needs to come down.

The delete_endpoint() callback is careful to check whether it is being
called to tear down the hierarchy, or if it is only being called to
teardown the memdev because an ancestor port is going through
->remove().

That care needs to take the device_lock() of the endpoint's parent.
Which requires 2 bugs to be fixed:

1/ A reference on the parent is needed to prevent use-after-free
   scenarios like this signature:

    BUG: spinlock bad magic on CPU#0, kworker/u56:0/11
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230524-3.fc38 05/24/2023
    Workqueue: cxl_port detach_memdev [cxl_core]
    RIP: 0010:spin_bug+0x65/0xa0
    Call Trace:
      do_raw_spin_lock+0x69/0xa0
     __mutex_lock+0x695/0xb80
     delete_endpoint+0xad/0x150 [cxl_core]
     devres_release_all+0xb8/0x110
     device_unbind_cleanup+0xe/0x70
     device_release_driver_internal+0x1d2/0x210
     detach_memdev+0x15/0x20 [cxl_core]
     process_one_work+0x1e3/0x4c0
     worker_thread+0x1dd/0x3d0

2/ In the case of RCH topologies, the parent device that needs to be
   locked is not always @port->dev as returned by cxl_mem_find_port(), use
   endpoint->dev.parent instead.

Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
Cc: <stable@vger.kernel.org>
Reported-by: Robert Richter <rrichter@amd.com>
Closes: http://lore.kernel.org/r/20231018171713.1883517-2-rrichter@amd.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 7ca01a834e18..0fe915ec2cc2 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1217,35 +1217,39 @@ static struct device *grandparent(struct device *dev)
 	return NULL;
 }
 
+static struct device *endpoint_host(struct cxl_port *endpoint)
+{
+	struct cxl_port *port = to_cxl_port(endpoint->dev.parent);
+
+	if (is_cxl_root(port))
+		return port->uport_dev;
+	return &port->dev;
+}
+
 static void delete_endpoint(void *data)
 {
 	struct cxl_memdev *cxlmd = data;
 	struct cxl_port *endpoint = cxlmd->endpoint;
-	struct cxl_port *parent_port;
-	struct device *parent;
-
-	parent_port = cxl_mem_find_port(cxlmd, NULL);
-	if (!parent_port)
-		goto out;
-	parent = &parent_port->dev;
+	struct device *host = endpoint_host(endpoint);
 
-	device_lock(parent);
-	if (parent->driver && !endpoint->dead) {
-		devm_release_action(parent, cxl_unlink_parent_dport, endpoint);
-		devm_release_action(parent, cxl_unlink_uport, endpoint);
-		devm_release_action(parent, unregister_port, endpoint);
+	device_lock(host);
+	if (host->driver && !endpoint->dead) {
+		devm_release_action(host, cxl_unlink_parent_dport, endpoint);
+		devm_release_action(host, cxl_unlink_uport, endpoint);
+		devm_release_action(host, unregister_port, endpoint);
 	}
 	cxlmd->endpoint = NULL;
-	device_unlock(parent);
-	put_device(parent);
-out:
+	device_unlock(host);
 	put_device(&endpoint->dev);
+	put_device(host);
 }
 
 int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
 {
+	struct device *host = endpoint_host(endpoint);
 	struct device *dev = &cxlmd->dev;
 
+	get_device(host);
 	get_device(&endpoint->dev);
 	cxlmd->endpoint = endpoint;
 	cxlmd->depth = endpoint->depth;


