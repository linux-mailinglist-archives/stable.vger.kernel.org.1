Return-Path: <stable+bounces-225717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIZSLeaOuGm2fwEAu9opvQ
	(envelope-from <stable+bounces-225717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 00:14:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD69F2A1DDB
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 00:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AA21300BCBF
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 23:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97142378814;
	Mon, 16 Mar 2026 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpSaJPkX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B16937756D
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773702875; cv=none; b=rkF0R/GBGJTEMBrj/BvazM64y8IJshBzK1wQzQY3Y64VeikD7N7FX71cyK8uRAsX5x3IkNzwS1nDamgKmXXYJYjBK+X9p4fqfCLPllYuQgoRLBzApeaY3nW+ohvIkAOp8j4TOHMIhHkYgHGBpdsRl2cPg1WbUstgvHBetaJZUZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773702875; c=relaxed/simple;
	bh=ojvnUhkou+SWQsZhV0F7iuof+5tWLMFcCx3eyFH75IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POVNo3QWkpaHP43R529+7olv6j6JjGfU7tmjq5oPydLLPC/vf4G6oRio539ndK1B9sg9f17OGWOXvUj/2bB+LjH9SauyX4RMLGVDi4bIxkkVX555rAQ/dibMd/bJJIVF+v7+0B8qjU2x0Eh9U0PLHfaNko5a2VYy/uhoXiRvvzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpSaJPkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8448BC2BC9E;
	Mon, 16 Mar 2026 23:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773702875;
	bh=ojvnUhkou+SWQsZhV0F7iuof+5tWLMFcCx3eyFH75IQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gpSaJPkXjR8AT/JcIr+mJIHZDbhPHhr57ikO3pUWGS4cOFHvtjXhIdOFPViXURdxi
	 RQEiOwVf4R9f0Gzh0J8OThXAnBSJT0OANtsVQ+wfNTBhbdBs8+Q2FFvV1/zJguzvbC
	 YDsCJTImmz2gdEBJX64AwVeCNBBWhGM/++CA6dTC9oQ1XazFxiiNa0O3Bd2AG7E9Ct
	 lYrwCnDc4CTXhr5/b3ZlwOU7n3kcSMT2GG/npz1vIdk5stTu7ue9lO8jLdody5jv7f
	 UvHqVkpu4Xg8xrnYIIiGLOTLzMFPUM/tf48fHReg0qkjuZ7quDyJ57qNjazlKONx4a
	 x27Mr23Yevf+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] usb: gadget: f_ncm: Fix net_device lifecycle with device_move
Date: Mon, 16 Mar 2026 19:14:31 -0400
Message-ID: <20260316231431.1445981-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316231431.1445981-1-sashal@kernel.org>
References: <2026031645-manger-gratitude-6c61@gregkh>
 <20260316231431.1445981-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225717-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,msgid.link:url]
X-Rspamd-Queue-Id: BD69F2A1DDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kuen-Han Tsai <khtsai@google.com>

[ Upstream commit ec35c1969650e7cb6c8a91020e568ed46e3551b0 ]

The network device outlived its parent gadget device during
disconnection, resulting in dangling sysfs links and null pointer
dereference problems.

A prior attempt to solve this by removing SET_NETDEV_DEV entirely [1]
was reverted due to power management ordering concerns and a NO-CARRIER
regression.

A subsequent attempt to defer net_device allocation to bind [2] broke
1:1 mapping between function instance and network device, making it
impossible for configfs to report the resolved interface name. This
results in a regression where the DHCP server fails on pmOS.

Use device_move to reparent the net_device between the gadget device and
/sys/devices/virtual/ across bind/unbind cycles. This preserves the
network interface across USB reconnection, allowing the DHCP server to
retain their binding.

Introduce gether_attach_gadget()/gether_detach_gadget() helpers and use
__free(detach_gadget) macro to undo attachment on bind failure. The
bind_count ensures device_move executes only on the first bind.

[1] https://lore.kernel.org/lkml/f2a4f9847617a0929d62025748384092e5f35cce.camel@crapouillou.net/
[2] https://lore.kernel.org/linux-usb/795ea759-7eaf-4f78-81f4-01ffbf2d7961@ixit.cz/

Fixes: 40d133d7f542 ("usb: gadget: f_ncm: convert to new function interface with backward compatibility")
Cc: stable <stable@kernel.org>
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
Link: https://patch.msgid.link/20260309-f-ncm-revert-v2-7-ea2afbc7d9b2@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_ncm.c   | 38 ++++++++++++++++++---------
 drivers/usb/gadget/function/u_ether.c | 22 ++++++++++++++++
 drivers/usb/gadget/function/u_ether.h | 26 ++++++++++++++++++
 drivers/usb/gadget/function/u_ncm.h   |  2 +-
 4 files changed, 74 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index 28e57d93973ac..b6d22cf43114a 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1438,6 +1438,7 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	struct f_ncm_opts	*ncm_opts;
 
 	struct usb_os_desc_table	*os_desc_table __free(kfree) = NULL;
+	struct net_device		*net __free(detach_gadget) = NULL;
 	struct usb_request		*request __free(free_usb_request) = NULL;
 
 	if (!can_support_ecm(cdev->gadget))
@@ -1451,18 +1452,19 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 			return -ENOMEM;
 	}
 
-	mutex_lock(&ncm_opts->lock);
-	gether_set_gadget(ncm_opts->net, cdev->gadget);
-	if (!ncm_opts->bound) {
-		ncm_opts->net->mtu = (ncm_opts->max_segment_size - ETH_HLEN);
-		status = gether_register_netdev(ncm_opts->net);
-	}
-	mutex_unlock(&ncm_opts->lock);
-
-	if (status)
-		return status;
-
-	ncm_opts->bound = true;
+	scoped_guard(mutex, &ncm_opts->lock)
+		if (ncm_opts->bind_count == 0) {
+			if (!device_is_registered(&ncm_opts->net->dev)) {
+				ncm_opts->net->mtu = (ncm_opts->max_segment_size - ETH_HLEN);
+				gether_set_gadget(ncm_opts->net, cdev->gadget);
+				status = gether_register_netdev(ncm_opts->net);
+			} else
+				status = gether_attach_gadget(ncm_opts->net, cdev->gadget);
+
+			if (status)
+				return status;
+			net = ncm_opts->net;
+		}
 
 	ncm_string_defs[1].s = ncm->ethaddr;
 
@@ -1564,6 +1566,9 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	}
 	ncm->notify_req = no_free_ptr(request);
 
+	ncm_opts->bind_count++;
+	retain_and_null_ptr(net);
+
 	DBG(cdev, "CDC Network: IN/%s OUT/%s NOTIFY/%s\n",
 			ncm->port.in_ep->name, ncm->port.out_ep->name,
 			ncm->notify->name);
@@ -1655,7 +1660,7 @@ static void ncm_free_inst(struct usb_function_instance *f)
 	struct f_ncm_opts *opts;
 
 	opts = container_of(f, struct f_ncm_opts, func_inst);
-	if (opts->bound)
+	if (device_is_registered(&opts->net->dev))
 		gether_cleanup(netdev_priv(opts->net));
 	else
 		free_netdev(opts->net);
@@ -1718,9 +1723,12 @@ static void ncm_free(struct usb_function *f)
 static void ncm_unbind(struct usb_configuration *c, struct usb_function *f)
 {
 	struct f_ncm *ncm = func_to_ncm(f);
+	struct f_ncm_opts *ncm_opts;
 
 	DBG(c->cdev, "ncm unbind\n");
 
+	ncm_opts = container_of(f->fi, struct f_ncm_opts, func_inst);
+
 	hrtimer_cancel(&ncm->task_timer);
 
 	kfree(f->os_desc_table);
@@ -1736,6 +1744,10 @@ static void ncm_unbind(struct usb_configuration *c, struct usb_function *f)
 
 	kfree(ncm->notify_req->buf);
 	usb_ep_free_request(ncm->notify, ncm->notify_req);
+
+	ncm_opts->bind_count--;
+	if (ncm_opts->bind_count == 0)
+		gether_detach_gadget(ncm_opts->net);
 }
 
 static struct usb_function *ncm_alloc(struct usb_function_instance *fi)
diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index f58590bf5e02f..dabaa66692517 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -896,6 +896,28 @@ void gether_set_gadget(struct net_device *net, struct usb_gadget *g)
 }
 EXPORT_SYMBOL_GPL(gether_set_gadget);
 
+int gether_attach_gadget(struct net_device *net, struct usb_gadget *g)
+{
+	int ret;
+
+	ret = device_move(&net->dev, &g->dev, DPM_ORDER_DEV_AFTER_PARENT);
+	if (ret)
+		return ret;
+
+	gether_set_gadget(net, g);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gether_attach_gadget);
+
+void gether_detach_gadget(struct net_device *net)
+{
+	struct eth_dev *dev = netdev_priv(net);
+
+	device_move(&net->dev, NULL, DPM_ORDER_NONE);
+	dev->gadget = NULL;
+}
+EXPORT_SYMBOL_GPL(gether_detach_gadget);
+
 int gether_set_dev_addr(struct net_device *net, const char *dev_addr)
 {
 	struct eth_dev *dev;
diff --git a/drivers/usb/gadget/function/u_ether.h b/drivers/usb/gadget/function/u_ether.h
index 34be220cef77c..c85a1cf3c115d 100644
--- a/drivers/usb/gadget/function/u_ether.h
+++ b/drivers/usb/gadget/function/u_ether.h
@@ -150,6 +150,32 @@ static inline struct net_device *gether_setup_default(void)
  */
 void gether_set_gadget(struct net_device *net, struct usb_gadget *g);
 
+/**
+ * gether_attach_gadget - Reparent net_device to the gadget device.
+ * @net: The network device to reparent.
+ * @g: The target USB gadget device to parent to.
+ *
+ * This function moves the network device to be a child of the USB gadget
+ * device in the device hierarchy. This is typically done when the function
+ * is bound to a configuration.
+ *
+ * Returns 0 on success, or a negative error code on failure.
+ */
+int gether_attach_gadget(struct net_device *net, struct usb_gadget *g);
+
+/**
+ * gether_detach_gadget - Detach net_device from its gadget parent.
+ * @net: The network device to detach.
+ *
+ * This function moves the network device to be a child of the virtual
+ * devices parent, effectively detaching it from the USB gadget device
+ * hierarchy. This is typically done when the function is unbound
+ * from a configuration but the instance is not yet freed.
+ */
+void gether_detach_gadget(struct net_device *net);
+
+DEFINE_FREE(detach_gadget, struct net_device *, if (_T) gether_detach_gadget(_T))
+
 /**
  * gether_set_dev_addr - initialize an ethernet-over-usb link with eth address
  * @net: device representing this link
diff --git a/drivers/usb/gadget/function/u_ncm.h b/drivers/usb/gadget/function/u_ncm.h
index 49ec095cdb4b6..b1f3db8b68c15 100644
--- a/drivers/usb/gadget/function/u_ncm.h
+++ b/drivers/usb/gadget/function/u_ncm.h
@@ -18,7 +18,7 @@
 struct f_ncm_opts {
 	struct usb_function_instance	func_inst;
 	struct net_device		*net;
-	bool				bound;
+	int				bind_count;
 
 	struct config_group		*ncm_interf_group;
 	struct usb_os_desc		ncm_os_desc;
-- 
2.51.0


