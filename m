Return-Path: <stable+bounces-219377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNnSJIGinmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:19:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D45CD193351
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FDC331B2D44
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA5730171E;
	Wed, 25 Feb 2026 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hFEs11VP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D802A3002D1;
	Wed, 25 Feb 2026 06:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002675; cv=none; b=TXD9SLrnvmcA8UeNHDMdtT53vWK1xdY6j+kPhl4ClR001ixLg507NG2o3/g0S7zfYxCKIU/VOoXGRzKhSPrsIi/TiXIrGWERu7NRHSLlRMBdDYhmHQgQOPuMhSuCAfqWC+KsoEW+mjI6Gd+KEwpDJpU4+bxZdpEv4IG2lsXd2n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002675; c=relaxed/simple;
	bh=c/kUUFsrKjRUH2wJWO06Fhdpnt4g4OICc2nHNfe+y1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vc2oCnm5G6UmQ5dxwNUUzAh1P2vx476Vz78/YDFfqMu0NRDOFWFACBL0WlDneV3vkeNDS8vU+JIbZYz/lmDMjTKWer7R3w5mZrjFwdcYsR26zgmmP8wrxy8/8eBQZtlKWzaNJr/Nm8i8WnN11OjMskDFt+zfw4JW+SRK494kU8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hFEs11VP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C72C116D0;
	Wed, 25 Feb 2026 06:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002675;
	bh=c/kUUFsrKjRUH2wJWO06Fhdpnt4g4OICc2nHNfe+y1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hFEs11VP89CePBVy5s5ybLb+lvBkCosZx3Gb+S63KxIEaGE1WYLOtCrsLIeVsvv/p
	 8nf7PuhrGJWIpNOntmrK7Eq/cOylcIiGGaOugtTCciw+imUocm7gfurkfNvA/40UfA
	 ZC/I5mMoAYto20qfvavkp10l4muCO4i9BnNzhB0o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 459/641] usb: typec: ucsi: drop an unused Kconfig symbol
Date: Tue, 24 Feb 2026 17:23:05 -0800
Message-ID: <20260225012359.636870662@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-219377-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D45CD193351
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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




