Return-Path: <stable+bounces-268055-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V8EFCa5IO2oYVggAu9opvQ
	(envelope-from <stable+bounces-268055-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 05:02:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B19106BB015
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 05:02:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=WEwzoXj8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268055-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-268055-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CAF23027A74
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 03:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5D9301704;
	Wed, 24 Jun 2026 03:02:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F624DD15
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 03:02:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782270123; cv=none; b=Oaf9rVez4gaxrUo7CS52l7p40BvGuTRLQjOhc9J4TEauq5udsiGel+TCw0pRvCc/XxnGwrqvAyhcCm3PMDVG3j9a1906zGy43RmWnIO1d+lJruXwoHOjNCcJZzDt2YTUAc+7d5mGcSYIywml2tIanaZxqF9FU35q9wTf7wCPkSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782270123; c=relaxed/simple;
	bh=uJ1TyACt1StjplqJEiWjSNJE5Lljer9Eg9YfoITBpmU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cEfN/q58v9RzN+5bFVhEWE5ffOEGhXjvJ5jk0AezCZdDzgPvweUWf8ZaOWjjhDM5p32EIqQL8OoEVlaAiuWB9QrWMoEAHAiy8l5YGEKnpyk7KxO3jPPVLg59SIK2qlMXKNYrhJPVuZDTO5xfUuLhlIgCgNfGGQa3Vv6uqB5zJis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hhhuuu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEwzoXj8; arc=none smtp.client-ip=209.85.214.202
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c2c98c1be2so3222495ad.0
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 20:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782270121; x=1782874921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P0nPpdTf0BpLFBau1M4FC7hfdf3tJ5Qvc7OfGDfoZuM=;
        b=WEwzoXj8EuBtBtcf4f8OBIX2MFBg/fmOaLhTk871UhhJZ0Uj0cpfOeHCY/cEtMBs79
         uR/88HenoBK8vP1BtHq7Nqemb9FfGtU6VgnSFFQm2puf9Mo7tjDEaX9hfwXaMfWpb107
         T2UFhJoul/YoZvMYgNeiLtd+rY1CBeWZdgu1n2RxPoWYWyMW5S84frYSJwviproTWF5s
         55OxyIU2fWcWkeoB4XJ8nqiAwyAVcvkeM4eEvK7mDRBmDFd3/YnfvBrS7VmDr9jgZLsZ
         7lb9fLocKUyxOQo8vRYSE65wkVmA/l0uuVXXRjKZhj3WTRFxE+us8NSzjFVqaDgbv7Nr
         g2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782270121; x=1782874921;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0nPpdTf0BpLFBau1M4FC7hfdf3tJ5Qvc7OfGDfoZuM=;
        b=Hj0oa+2BaXTxKf8aIzNnKrH6pUqg8XNQBHS8YjRtoQjvDMbOWDQdvHLcRfkSDhe03n
         lBTam48ZE1bC2eL5s00UGcHLjOEktwQw0mDZMmLWXaSnppyY6RucHqIagGXMR0gbewAP
         svyt/86/Nbv6DJkgatZkSkmSayYWsVFQ1Q7pc+Nt66BnZOj2OzcVLBHez88IPxZ2USB/
         yqi9EksXfSyCSq67aDRioUZVMLLxAiD36eAV4j4cUmSw3l1tN1L+Nd43Z+grEBSh3xmw
         p/PDTNOnOsCe8OT5Ehj3NrL2Ne8/KRx8s37W9G3OxVc6Qox87fnDVJ+Jkz+BKUs+Y6X1
         /F2w==
X-Forwarded-Encrypted: i=1; AHgh+RpRVUMBmhVuoT5AoZ1UGLw4OPe0DunvgbxldTSOq4Iw7o+tuT+eBgTPhdjChf6eubDZn784RNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoOp/Gm1w9GekjAhOiJwD/n47abn/K8bG6HGw5l/BIZDHIJqLr
	TiCxpuIhETTkhCyQOti6wNcF1IEDh2FxKZrZyFxZz4Oxe6fHHO0z8Q4sU5jr42JIoYhNfjLZo91
	L1C63PA==
X-Received: from plhz11.prod.google.com ([2002:a17:902:d9cb:b0:2c6:a4ed:efee])
 (user=hhhuuu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c411:b0:2c6:c431:63f3
 with SMTP id d9443c01a7336-2c7e158c8f1mr16473485ad.32.1782270120735; Tue, 23
 Jun 2026 20:02:00 -0700 (PDT)
Date: Wed, 24 Jun 2026 11:01:54 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624030154.393004-1-hhhuuu@google.com>
Subject: [PATCH v2] usb: gadget: udc: Fix use-after-free in gadget_match_driver
From: Jimmy Hu <hhhuuu@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Jimmy Hu <hhhuuu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stern@rowland.harvard.edu,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:hhhuuu@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[hhhuuu@google.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268055-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hhhuuu@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,harvard.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B19106BB015

The udc structure acts as the management structure for the gadget,
but their lifecycles are decoupled. A race condition exists where
usb_del_gadget() frees the udc memory (e.g., via mode-switch work)
while gadget_match_driver() concurrently accesses the freed udc memory
(e.g., via configfs), causing a Use-After-Free (UAF) that triggers a
NULL pointer dereference when the freed memory is zeroed:

[39430.908615][ T1171] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[39430.911397][ T1171] pc : __pi_strcmp+0x20/0x140
[39430.911441][ T1171] lr : gadget_match_driver+0x34/0x60
...
[39430.911890][ T1171]  usb_gadget_register_driver_owner+0x50/0xf8
[39430.911910][ T1171]  gadget_dev_desc_UDC_store+0xf4/0x140
[39430.931308][ T1171]  configfs_write_iter+0xec/0x134

[39430.957058][ T1171] Workqueue: events_freezable __dwc3_set_mode
[39430.957287][ T1171]  dwc3_gadget_exit+0x34/0x8c
[39430.957304][ T1171]  __dwc3_set_mode+0xc0/0x664

Fix this by ensuring the udc structure remains allocated during the
match. To achieve this, introduce a new usb_gadget_release() routine
to the core. When the gadget is added, usb_add_gadget() stores the
gadget's release routine in the udc structure and takes a reference
to the udc. When the gadget is released, usb_gadget_release() drops
the reference to the udc and then calls the gadget's release routine.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jimmy Hu <hhhuuu@google.com>
---
V1 -> V2: Rework the fix using a new release routine in the core.

v1: https://lore.kernel.org/all/20260526070635.839701-1-hhhuuu@google.com/

 drivers/usb/gadget/udc/core.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 60340ff9edbf..f8ce8694c101 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -31,8 +31,9 @@ static const struct bus_type gadget_bus_type;
 /**
  * struct usb_udc - describes one usb device controller
  * @driver: the gadget driver pointer. For use by the class code
- * @dev: the child device to the actual controller
  * @gadget: the gadget. For use by the class code
+ * @gadget_release: the gadget's release routine
+ * @dev: the child device to the actual controller
  * @list: for use by the udc class driver
  * @vbus: for udcs who care about vbus status, this value is real vbus status;
  * for udcs who do not care about vbus status, this value is always true
@@ -53,6 +54,7 @@ static const struct bus_type gadget_bus_type;
 struct usb_udc {
 	struct usb_gadget_driver	*driver;
 	struct usb_gadget		*gadget;
+	void					(*gadget_release)(struct device *dev);
 	struct device			dev;
 	struct list_head		list;
 	bool				vbus;
@@ -1362,6 +1364,18 @@ static void usb_udc_nop_release(struct device *dev)
 	dev_vdbg(dev, "%s\n", __func__);
 }
 
+static void usb_gadget_release(struct device *dev)
+{
+	struct usb_gadget *gadget = dev_to_usb_gadget(dev);
+	struct usb_udc *udc = gadget->udc;
+	/* Cache the gadget's release routine to prevent UAF */
+	void (*release)(struct device *dev) = udc->gadget_release;
+
+	put_device(&udc->dev);
+	if (release)
+		release(dev);
+}
+
 /**
  * usb_initialize_gadget - initialize a gadget and its embedded struct device
  * @parent: the parent device to this udc. Usually the controller driver's
@@ -1418,6 +1432,9 @@ int usb_add_gadget(struct usb_gadget *gadget)
 	mutex_init(&udc->connect_lock);
 
 	udc->started = false;
+	udc->gadget_release = gadget->dev.release;
+	gadget->dev.release = usb_gadget_release;
+	get_device(&udc->dev);
 
 	mutex_lock(&udc_lock);
 	list_add_tail(&udc->list, &udc_list);
@@ -1462,6 +1479,8 @@ int usb_add_gadget(struct usb_gadget *gadget)
 	mutex_lock(&udc_lock);
 	list_del(&udc->list);
 	mutex_unlock(&udc_lock);
+	gadget->dev.release = udc->gadget_release;
+	put_device(&udc->dev);
 
  err_put_udc:
 	put_device(&udc->dev);

base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
-- 
2.55.0.rc0.799.gd6f94ed593-goog


