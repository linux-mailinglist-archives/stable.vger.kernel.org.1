Return-Path: <stable+bounces-265546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qjsFJQmLMWqjmAUAu9opvQ
	(envelope-from <stable+bounces-265546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:42:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9D269363F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:42:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Ii4zhIzB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265546-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265546-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA8923035783
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A5F477E2B;
	Tue, 16 Jun 2026 17:42:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DB147AF5F;
	Tue, 16 Jun 2026 17:42:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631748; cv=none; b=Z9wMlVg5PJVRESxugzAOzw2y28E0PO3VL9xSywG5jBDNQ2G8a9XR6nAm8wwlR4IqnQHHtSIhN6PDZw/UpB3KPaGddmURsSXrnJOGD88AeikWNjI6YIHfsipluKL3yLNU5LuWpuF7SMUc86kVmKT23CNDs7WcEH3ifhlj/V1LAbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631748; c=relaxed/simple;
	bh=UFwP3mlYe1ZYNbbDf6a6wz9hfA5o1Co8GdZ+TbT5gdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZecwmKBUAmmih12ZUCK1ABebanwSpUlsJjfVZjnW+kZgPqfYnuut4yywMiu9plqoJ3/RDY2LPqPvzmp+IjC7hshqNPLAgAPKyrPnlQK4Q0PpVaPSSsGPizdqTW3IqdnNjmTiIqNZFTWHPvf1Yj2Ee532FiF2BNGOQ0UsElGYEgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ii4zhIzB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35A11F000E9;
	Tue, 16 Jun 2026 17:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631746;
	bh=62LwnqkX0doEhsLMBHZA58g8AkVU/jvVpMTjBREpz50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ii4zhIzBXkVALmAVAV/COXhg+I+c9Vs+lB6Ze2CcBbYbnrnx6AjevZMv+PRhti45U
	 j3Eb5fsGUTmgnrIJb16Gm4w2g8uI4JEuejql11cqM68GHFrDRsQJnmvBX2d6FFlYNx
	 4UEbO7ckWl+SuCUiDz8p6bxzKKYk0glsK/EFl6OM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hayes Wang <hayeswang@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 248/522] r8152: reduce the control transfer of rtl8152_get_version()
Date: Tue, 16 Jun 2026 20:26:35 +0530
Message-ID: <20260616145137.578229688@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265546-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:hayeswang@realtek.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,realtek.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D9D269363F

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hayes Wang <hayeswang@realtek.com>

[ Upstream commit 02767440e1dda9861a11ca1dbe0f19a760b1d5c2 ]

Reduce the control transfer by moving calling rtl8152_get_version() in
rtl8152_probe(). This could prevent from calling rtl8152_get_version()
for unnecessary situations. For example, after setting config #2 for the
device, there are two interfaces and rtl8152_probe() may be called
twice. However, we don't need to call rtl8152_get_version() for this
situation.

Signed-off-by: Hayes Wang <hayeswang@realtek.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 19440600e729 ("r8152: handle the return value of usb_reset_device()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 98e30291b0500b..f730f6a797e767 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9640,20 +9640,21 @@ static int rtl8152_probe(struct usb_interface *intf,
 			 const struct usb_device_id *id)
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
-	u8 version = rtl8152_get_version(intf);
 	struct r8152 *tp;
 	struct net_device *netdev;
+	u8 version;
 	int ret;
 
-	if (version == RTL_VER_UNKNOWN)
-		return -ENODEV;
-
 	if (intf->cur_altsetting->desc.bInterfaceClass != USB_CLASS_VENDOR_SPEC)
 		return -ENODEV;
 
 	if (!rtl_check_vendor_ok(intf))
 		return -ENODEV;
 
+	version = rtl8152_get_version(intf);
+	if (version == RTL_VER_UNKNOWN)
+		return -ENODEV;
+
 	usb_reset_device(udev);
 	netdev = alloc_etherdev(sizeof(struct r8152));
 	if (!netdev) {
-- 
2.53.0




