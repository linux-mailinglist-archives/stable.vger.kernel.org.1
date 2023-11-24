Return-Path: <stable+bounces-866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D727F7CEA
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB59DB2143A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC833A8D5;
	Fri, 24 Nov 2023 18:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cuMeMPtt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CBE33063;
	Fri, 24 Nov 2023 18:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B75C433C8;
	Fri, 24 Nov 2023 18:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849972;
	bh=qtfHT8OlkiEl2rGDzdB84gh9ohNPwwDBkBEwLyqMPPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cuMeMPttVStC88XTQdN1AToY3Rn7to5V4Scl9VO2kJ1CviEYZqjavr+ilvQqle/TT
	 vqzNeIQlsaHtx81SkfQLvKlqVew0Y+I810Yw31jWZKxHFXxsL4/oaXQzw7QaldCQlC
	 7j6S1RGkkU6JMYo/mEvFZQ6uTevffDZbkt8ysqSc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robert Richter <rrichter@amd.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 6.6 394/530] cxl/port: Fix delete_endpoint() vs parent unregistration race
Date: Fri, 24 Nov 2023 17:49:20 +0000
Message-ID: <20231124172040.016067678@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

From: Dan Williams <dan.j.williams@intel.com>

commit 8d2ad999ca3c64cb08cf6a58d227b9d9e746d708 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cxl/core/port.c |   34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1242,35 +1242,39 @@ static struct device *grandparent(struct
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
+	struct device *host = endpoint_host(endpoint);
 
-	parent_port = cxl_mem_find_port(cxlmd, NULL);
-	if (!parent_port)
-		goto out;
-	parent = &parent_port->dev;
-
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



