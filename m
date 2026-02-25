Return-Path: <stable+bounces-218608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGtOH/lTnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:44:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA88A18FB1F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 368EA30A573C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7960925A642;
	Wed, 25 Feb 2026 01:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ri8Y4vc8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBF1243376;
	Wed, 25 Feb 2026 01:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983454; cv=none; b=uRsTtMXlrOwLK3Jj+eEIEPMJoDOAHUM659NiMs/MZLXQX8/mw8OyDPalHXLSnkZamTPGpf7V05UyXwMcd0LmLmhOWcgrv8m7ZQOfMkkqdm7o3mp5xaL6Vk86ZMQnAwOL8pO1YiR86aVmAQiMh3ZpNNXCQy9ko8TSIA94c4BO3aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983454; c=relaxed/simple;
	bh=4aL+qUU2vdjtI2QygyAZjuZYuW/o4QAUV9z7i5iXGb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJZXHfEEfSNOfz7YWiRROJO5ZHMsnCZxBu2Op3rR+VXcKk2bDnTEEghl8HPAlvTd7HPq04eEK1h0TuJakVrIJnk3CaxrkDmhEJdsuDH9E2tFpeXpLGLKY2CYMn7GFiqbx1OGbJlkByN5CAPPIgsL0k/KySN0KaRpGqZYWlHQHOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ri8Y4vc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69B9C116D0;
	Wed, 25 Feb 2026 01:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983453;
	bh=4aL+qUU2vdjtI2QygyAZjuZYuW/o4QAUV9z7i5iXGb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ri8Y4vc8lSR/abDJvbd41ZceSeM1rILnZmSM0BkFnIVsyrV07aC9U+QGsvOIWU1fy
	 E/I0Tdliti19xiRS5LwZPBMJ1L6kC2zK6OABVdCBOE4A0Mcst7WlnycuUWUmWIerA+
	 AK7CyLtk7539T6IzSZ4iRl7Ye+++4LEyNC9z6lZQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 568/781] usb: typec: ucsi: drop an unused Kconfig symbol
Date: Tue, 24 Feb 2026 17:21:17 -0800
Message-ID: <20260225012413.735148936@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218608-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,chromium.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA88A18FB1F
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit c5177144b561dd4037a6a225d444b3604afbfbf2 ]

EXTCON_TCSS_CROS_EC isn't used anywhere else in the kernel tree,
so drop it from this Kconfig file.

(unless it should be EXTCON_USBC_CROS_EC ?)

Fixes: f1a2241778d9 ("usb: typec: ucsi: Implement ChromeOS UCSI driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Benson Leung <bleung@chromium.org>
Link: https://patch.msgid.link/20251228190604.2484082-1-rdunlap@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
index b812be4d0e674..87dd992a4b9e9 100644
--- a/drivers/usb/typec/ucsi/Kconfig
+++ b/drivers/usb/typec/ucsi/Kconfig
@@ -73,7 +73,6 @@ config CROS_EC_UCSI
 	tristate "UCSI Driver for ChromeOS EC"
 	depends on MFD_CROS_EC_DEV
 	depends on CROS_USBPD_NOTIFY
-	depends on !EXTCON_TCSS_CROS_EC
 	default MFD_CROS_EC_DEV
 	help
 	  This driver enables UCSI support for a ChromeOS EC. The EC is
-- 
2.51.0




