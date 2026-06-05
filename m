Return-Path: <stable+bounces-260808-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ijb7MygnI2oIjgEAu9opvQ
	(envelope-from <stable+bounces-260808-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:44:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D3B64B07B
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:44:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DZf3FNVn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260808-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260808-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0B5D309DB45
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 19:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F25E404BCE;
	Fri,  5 Jun 2026 19:38:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DC141B355
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:38:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688310; cv=none; b=tDeDdjP/ZdUH8RoZkD62U0GyL1chdHH5NdRFvgcZhlHl9c44qN4pmZiWNc31aDY1FPuTLCsfbuqqALilf7Eid7MidDGSBAPSkzf8U9/6clTXxuaRmh06Cjv7NdT4wE5YWUcJXRTMlBgcM2kNsK54XiFt7HtbLQErupymjZRfJZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688310; c=relaxed/simple;
	bh=qHL42ZCIbTM5D8eNYPk16TccL1ke63k/hProoSMiyYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlF+D+d9yv6ecC1wMjcUOSYYqoDvq1T7VwWzFOOHZa25rcuIr3rD2Y5eHN6PIeduw3+TiHY6dVPn9YkN4CsA3byvO1ijv6cCvvlLAHIoA5nK+kzp0TT0U5POt0ISE3R1GOTnT9bPSeMsyhGXIMtauCHAaNpa1VINl47sUOxKhgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZf3FNVn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D571F00893;
	Fri,  5 Jun 2026 19:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688309;
	bh=3waOopIiCWDVvlhtM9jVSir9HYZewWRyMccNAK6aacY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DZf3FNVniYB74EFbhBeaSwroOGOAvp98/8ivQlRQCSNDxHjr91NAynBkqX4fSWoV5
	 5ZeT1fnA68EpuBluCgY+H2rUf8jRdXTqRrPXDRexXNko/WH5bm2jTVf0FWMSYHR6A1
	 4ijzHEyWsCwfl+EUIVAdo+ERQ2LgaTDtH3DZv/+x1savCo7pC6IHfTiNb2uFOnhFrJ
	 cNznB1NX3/fpr+1z3V9ahvkn1ySdh5LZ5irGBr5DsUJC7KNgAVmZNoonYFcI/qEZZn
	 JMJI0Kk/F73GGVert2HuCWb7ilFw3qoyewFkNLZ/hpgriV/cNImKdZR1RZuYUMZOXh
	 elXrf3CfdpPWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: John Keeping <john@metanate.com>,
	Lee Jones <lee@kernel.org>,
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] usb: gadget: f_hid: tidy error handling in hidg_alloc
Date: Fri,  5 Jun 2026 15:38:25 -0400
Message-ID: <20260605193826.2169399-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060453-cape-pavestone-2366@gregkh>
References: <2026060453-cape-pavestone-2366@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260808-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:john@metanate.com,m:lee@kernel.org,m:andrzej.p@collabora.com,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,metanate.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46D3B64B07B

From: John Keeping <john@metanate.com>

[ Upstream commit 944fe915d00d3cb1bacb1e77cabfb6dc82e6f8b8 ]

Unify error handling at the end of the function, reducing the risk of
missing something on one of the error paths.

Moving the increment of opts->refcnt later means there is no need to
decrement it on the error path and is safe as this is guarded by
opts->lock which is held for this entire section.

Tested-by: Lee Jones <lee@kernel.org>
Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Reviewed-by: Lee Jones <lee@kernel.org>
Signed-off-by: John Keeping <john@metanate.com>
Link: https://lore.kernel.org/r/20221122123523.3068034-4-john@metanate.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 4f88d65def6f ("usb: gadget: f_hid: fix device reference leak in hidg_alloc()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_hid.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index f8cc26af702c96..07c4f7bbdb2719 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1265,7 +1265,6 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	opts = container_of(fi, struct f_hid_opts, func_inst);
 
 	mutex_lock(&opts->lock);
-	++opts->refcnt;
 
 	spin_lock_init(&hidg->write_spinlock);
 	spin_lock_init(&hidg->read_spinlock);
@@ -1278,11 +1277,8 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg->dev.class = hidg_class;
 	hidg->dev.devt = MKDEV(major, opts->minor);
 	ret = dev_set_name(&hidg->dev, "hidg%d", opts->minor);
-	if (ret) {
-		--opts->refcnt;
-		mutex_unlock(&opts->lock);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto err_unlock;
 
 	hidg->bInterfaceSubClass = opts->subclass;
 	hidg->bInterfaceProtocol = opts->protocol;
@@ -1293,14 +1289,13 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 					    opts->report_desc_length,
 					    GFP_KERNEL);
 		if (!hidg->report_desc) {
-			put_device(&hidg->dev);
-			--opts->refcnt;
-			mutex_unlock(&opts->lock);
-			return ERR_PTR(-ENOMEM);
+			ret = -ENOMEM;
+			goto err_put_device;
 		}
 	}
 	hidg->use_out_ep = !opts->no_out_endpoint;
 
+	++opts->refcnt;
 	mutex_unlock(&opts->lock);
 
 	hidg->func.name    = "hid";
@@ -1315,6 +1310,12 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg->qlen	   = 4;
 
 	return &hidg->func;
+
+err_put_device:
+	put_device(&hidg->dev);
+err_unlock:
+	mutex_unlock(&opts->lock);
+	return ERR_PTR(ret);
 }
 
 DECLARE_USB_FUNCTION_INIT(hid, hidg_alloc_inst, hidg_alloc);
-- 
2.53.0


