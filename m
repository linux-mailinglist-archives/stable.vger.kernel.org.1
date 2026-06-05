Return-Path: <stable+bounces-260772-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7IjkEmsiI2ohjQEAu9opvQ
	(envelope-from <stable+bounces-260772-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:24:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C0264AEBB
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:24:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DOFbfJbx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260772-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260772-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 080AD30D01C7
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 19:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6264381AEC;
	Fri,  5 Jun 2026 19:17:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C394D42669A
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:17:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687040; cv=none; b=K1pKOsrWHDfh+WktgmFxIzqJrYE+N0bt40RYdcZxTnWw6ZJZfrEA956vvfklTMHYHQWMY0/SNLHzXhs27obh8JheYx7x2J4IukUW28Re1CLWEM4/WL0bOeGqhY/jVudwN1sOlFz8DhGiPlnAhRHtVs1wNj79BM8l5IcUt1xWQMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687040; c=relaxed/simple;
	bh=Z08BrJraQjDAhn87ZnUC21LyhS5P6rCpi4JEODcQu0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3ltzOHVeZi2RR08B6GRJRY07Y7R+lgd6S6RvHarvwA8KQUZvztFD+hVkj/+asL5DQb9htDCZmPTQiRz93eo3r5dTCzfap79RkI1+6UPsu10KTBwMOTAxueKwFUQrOevuhGomjfGevA5ieQBEjBCT77TA4vxn8OcrDV30znE4zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOFbfJbx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37E41F00898;
	Fri,  5 Jun 2026 19:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780687034;
	bh=PVaP4T4PV62H8HxQglJxvdda2WcVrK+1GKbdlQcNyPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DOFbfJbxFPivAH/LpzN79nD8OCoNeFAw5kkk+gaVemcG5rYvjMwlihhj/D66zTalx
	 1wizSBrWJ3/PncfAsYzfh20vYLAMD+obLIS4UvD+L5hehL9DW/ILqfM9JLhyPfRYeF
	 e7p0Ic3AfPgDL9J7JJcWtkld3eYi6iOAPGMrtfo46z8pNBdjvrg/H0T3LDkyFMFU5d
	 f5MtjyM3F1lzj0R7ihNU3SlXg3jOv7IBLj20JPvToVsSxwowuJhx01kzfRiP4PdL4G
	 z/8W3oetQ4jl2RPg8BXDMgejSPBdraVNaGG7uTdsYwEohHsYFUQRv67oM7RklDVB0i
	 sru50LWYCHWUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable <stable@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] usb: gadget: f_hid: fix device reference leak in hidg_alloc()
Date: Fri,  5 Jun 2026 15:17:11 -0400
Message-ID: <20260605191711.2132578-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605191711.2132578-1-sashal@kernel.org>
References: <2026060452-vastness-hulk-8040@gregkh>
 <20260605191711.2132578-1-sashal@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260772-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:lgs201920130244@gmail.com,m:stable@kernel.org,m:johan@kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6C0264AEBB

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit 4f88d65def6f3c90121601b4f62a4c967f3063a6 ]

hidg_alloc() initializes hidg->dev with device_initialize() before
calling dev_set_name(). If dev_set_name() fails, the function currently
jumps to err_unlock and returns without calling put_device().

This leaves the device reference unbalanced and prevents hidg_release()
from being called. Calling put_device() here is also safe, since
hidg_release() only frees resources owned by hidg.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Route the dev_set_name() failure path through err_put_device so the
device reference is dropped properly.

Fixes: 89ff3dfac604 ("usb: gadget: f_hid: fix f_hidg lifetime vs cdev")
Cc: stable <stable@kernel.org>
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Reviewed-by: Johan Hovold johan@kernel.org
Link: https://patch.msgid.link/20260413142119.2977716-1-lgs201920130244@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_hid.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index d44eb06d5a0a43..a3e79121d9eb06 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1278,7 +1278,7 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg->dev.devt = MKDEV(major, opts->minor);
 	ret = dev_set_name(&hidg->dev, "hidg%d", opts->minor);
 	if (ret)
-		goto err_unlock;
+		goto err_put_device;
 
 	hidg->bInterfaceSubClass = opts->subclass;
 	hidg->bInterfaceProtocol = opts->protocol;
@@ -1313,7 +1313,6 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 
 err_put_device:
 	put_device(&hidg->dev);
-err_unlock:
 	mutex_unlock(&opts->lock);
 	return ERR_PTR(ret);
 }
-- 
2.53.0


