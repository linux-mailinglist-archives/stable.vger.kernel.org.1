Return-Path: <stable+bounces-239886-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNxRCkdZ5mmtvAEAu9opvQ
	(envelope-from <stable+bounces-239886-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:50:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B396343016D
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8CD0732EDF56
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF9234402B;
	Mon, 20 Apr 2026 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jtwqQyq7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F9333858B;
	Mon, 20 Apr 2026 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701468; cv=none; b=Uq4BYlEqy4008XtlIY7VKC5Yn+sF/dfw05ZII9fdO2JDN4BXH4J/oYoHVs3xNNJuGZuGKVTbgU0DHzdUN/RMC08DG4on39NPfMFnB3U1WhuwxN38vByqiPuEt3SP2kVx3EPcPHnEnp1d5WcDRUVNeIyyXT35ft1KJTI85KqVZ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701468; c=relaxed/simple;
	bh=B5KKIjrKmfkJq+cb41jSsBTQNVrJifHKOXiqaZu+uJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaioxJFqYpSdF3H5RGRuMjbaa0yYUmYps90UyafasPLYr3nu7X6KKvgYiVeLviLhFkXoKgdgpkaBvsjuZI401EKHxE6nCptl8dj4AWkGSyA313UIAOirll+y+cNh+185h7cMupYxLJK7yNrZurhTv6nq6UAJLYbTBoTswszeSpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jtwqQyq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EFCC19425;
	Mon, 20 Apr 2026 16:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701467;
	bh=B5KKIjrKmfkJq+cb41jSsBTQNVrJifHKOXiqaZu+uJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jtwqQyq79brpaZCMDxIfp2hS56kIsVKRqRNh3PMTQv0lsaYWMVk+zm6xE33+g/CHq
	 MiqPVfwcX/cd9S6Yb9yN0CU+KJHy3pPBWmvDnquyY6C7u7p3IgsZYakxXJPE7OZ89d
	 Zm32pLGz+oudGlm7T39nFuQYuVsZW6VogDL2f4DY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Johan Hovold <johan@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>
Subject: [PATCH 6.12 118/162] wifi: rtw88: fix device leak on probe failure
Date: Mon, 20 Apr 2026 17:42:30 +0200
Message-ID: <20260420153931.315878842@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153927.006696811@linuxfoundation.org>
References: <20260420153927.006696811@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239886-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: B396343016D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit bbb15e71156cd9f5e1869eee7207a06ea8e96c39 upstream.

Driver core holds a reference to the USB interface and its parent USB
device while the interface is bound to a driver and there is no need to
take additional references unless the structures are needed after
disconnect.

This driver takes a reference to the USB device during probe but does
not to release it on all probe errors (e.g. when descriptor parsing
fails).

Drop the redundant device reference to fix the leak, reduce cargo
culting, make it easier to spot drivers where an extra reference is
needed, and reduce the risk of further memory leaks.

Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/netdev/2026022319-turbofan-darkened-206d@gregkh/
Cc: stable@vger.kernel.org	# 6.2
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260306085144.12064-19-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtw88/usb.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -953,7 +953,7 @@ static int rtw_usb_intf_init(struct rtw_
 			     struct usb_interface *intf)
 {
 	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
-	struct usb_device *udev = usb_get_dev(interface_to_usbdev(intf));
+	struct usb_device *udev = interface_to_usbdev(intf);
 	int ret;
 
 	rtwusb->udev = udev;
@@ -979,7 +979,6 @@ static void rtw_usb_intf_deinit(struct r
 {
 	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
 
-	usb_put_dev(rtwusb->udev);
 	kfree(rtwusb->usb_data);
 	usb_set_intfdata(intf, NULL);
 }



