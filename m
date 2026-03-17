Return-Path: <stable+bounces-226273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ3IDJ6GuWncJAIAu9opvQ
	(envelope-from <stable+bounces-226273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:51:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E22A2AE8A1
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6F993062996
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C8F3F20FD;
	Tue, 17 Mar 2026 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JQE5fHq8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FF13F210B;
	Tue, 17 Mar 2026 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765980; cv=none; b=Kntwo4YmKc0ybi05VX4ZEF3p7B5d+szkjjrIBcd5np74hcfAsnPjyoPZYh9oXfTirAD5R/UOYbssX+PU3yZDer1HSiA8bZL6qsCsoIPrEj5Y506LAKggPhAr+UtdL6TveHWowGxF+qTiMEipjHMme9QRd0ktDrupjLHLSAS/J5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765980; c=relaxed/simple;
	bh=oDPAgEIb0eR2kKiShX++j1qtDrG68BZE6+/fvx9QZlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cywnMh/16zzficcBB+YIMPcrckg1xL0O2NCDmLkTOTB4LXAokVV7GdkHIxfazYtQI7pvpJVrrT8XWCpwAIxUJyRWdsQP1icfKCNwD+lOYM+MW89omnNb0vYSFZVWbOHZiziSG53XwEcDigzpCygMaG03cNRBWADJseA+K2GrCSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JQE5fHq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435A3C2BC86;
	Tue, 17 Mar 2026 16:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765979;
	bh=oDPAgEIb0eR2kKiShX++j1qtDrG68BZE6+/fvx9QZlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JQE5fHq8P4OxdtzIq/Sqe0sPtnyhcWwc7lKxW1uKo6lDDCYUqXKQEnFeQYRZSwzw8
	 XKr9KFmgkCqa+eyO+TX16v01nEd6tjHOa14ASI+hjtqTRA2b3N/1lZ/IAeTDBA/RML
	 A4HH5AqG1smjlzBZso8U++AXtlQn95FYNaJ5rZM8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Christoffer Sandberg <cs@tuxedo.de>,
	Werner Sembach <wse@tuxedocomputers.com>
Subject: [PATCH 6.19 143/378] usb/core/quirks: Add Huawei ME906S-device to wakeup quirk
Date: Tue, 17 Mar 2026 17:31:40 +0100
Message-ID: <20260317163012.278041934@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226273-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tuxedo.de:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tuxedocomputers.com:email]
X-Rspamd-Queue-Id: 4E22A2AE8A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoffer Sandberg <cs@tuxedo.de>

commit 0326ff28d56b4fa202de36ffc8462a354f383a64 upstream.

Similar to other Huawei LTE modules using this quirk, this version with
another vid/pid suffers from spurious wakeups.

Setting the quirk fixes the issue for this device as well.

Cc: stable <stable@kernel.org>
Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Link: https://patch.msgid.link/20260306172817.2098898-1-wse@tuxedocomputers.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/quirks.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -208,6 +208,10 @@ static const struct usb_device_id usb_qu
 	/* HP v222w 16GB Mini USB Drive */
 	{ USB_DEVICE(0x03f0, 0x3f40), .driver_info = USB_QUIRK_DELAY_INIT },
 
+	/* Huawei 4G LTE module ME906S  */
+	{ USB_DEVICE(0x03f0, 0xa31d), .driver_info =
+			USB_QUIRK_DISCONNECT_SUSPEND },
+
 	/* Creative SB Audigy 2 NX */
 	{ USB_DEVICE(0x041e, 0x3020), .driver_info = USB_QUIRK_RESET_RESUME },
 



