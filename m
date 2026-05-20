Return-Path: <stable+bounces-250522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5nfZIGXnDWrO4gUAu9opvQ
	(envelope-from <stable+bounces-250522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:55:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0394592A1D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E15FE303AF24
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A555D31F9BE;
	Wed, 20 May 2026 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TJA1Eoz4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5493835201E;
	Wed, 20 May 2026 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295630; cv=none; b=d0o6aqAF85difvYoBh5WxSb1IR9bbhVyKad/9I1sLWwklb8PykdXrUqscQ9EBn0dFYgh3oMZlc2Ji7zBCCi3VNjtQzFLnf+LN/L8rwiHUk3DZs1qUcyrCGK9MeUFVff22YgPXJILhUN3+OwCR6tNl3tDYqBEhaBYjeZ7RUrT2DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295630; c=relaxed/simple;
	bh=Wp8GNfgcXHRoZlOSKK+ctiONjKrPg7Le9LukSeZZUQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plwjN0AFlAZSBMdmFym9WhfG+y/U3PdjQRnTuUnggAzku4Yp6KdGkP+T3zxrQEzCM6UuC9F0DU7q7F2ycnKMVasM3bcL3Hr2AHlqxh7Cjnx4ZYckwbWpce6kUi2LQdzNh8yhuf/9mMydlYZ1/gyFVM1Eat07FwCsSc+1dFEqfdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TJA1Eoz4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2761F000E9;
	Wed, 20 May 2026 16:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295629;
	bh=vuBpIy6x3yffySYpumiuIcBm3jA1ieLSRasYk/3mNNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TJA1Eoz4F5v6bNqxIek/6SDw83NOaJrVBT4ChDXf0U4uJcwqNLqtmg05tiyzvOqEk
	 RyS96QbJj58aVeUU+L60jT4xf6yyM2rxKZaShL0pKS0CDS5XAhpCpt8EbcrS3/G7Zu
	 MnrgoAzIghNoQ/84cjsdgmF1GzS1+5gXkRM1D4k8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	William Zhang <william.zhang@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0492/1146] ARM: dts: BCM5301X: Drop extra NAND controller compatible
Date: Wed, 20 May 2026 18:12:22 +0200
Message-ID: <20260520162159.326082700@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250522-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,1.19.21.224:email,broadcom.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: F0394592A1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit f699e0aa7a1382f52fb6f3e8e26754e7aaad6db6 ]

Fix the dtbs_check warning introduced when the brcm,brcmnand fallback
compatible got removed for iProc machines.

Fixes: 4db35366d6dc ("dt-bindings: mtd: brcm,brcmnand: Drop "brcm,brcmnand" compatible for iProc")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: William Zhang <william.zhang@broadcom.com>
Link: https://lore.kernel.org/r/20260204091530.624230-1-miquel.raynal@bootlin.com
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/broadcom/bcm-ns.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm-ns.dtsi b/arch/arm/boot/dts/broadcom/bcm-ns.dtsi
index d0d5f7e52a917..46b650abdb904 100644
--- a/arch/arm/boot/dts/broadcom/bcm-ns.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm-ns.dtsi
@@ -479,7 +479,7 @@ thermal: thermal@2c0 {
 	};
 
 	nand_controller: nand-controller@18028000 {
-		compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1", "brcm,brcmnand";
+		compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1";
 		reg = <0x18028000 0x600>, <0x1811a408 0x600>, <0x18028f00 0x20>;
 		reg-names = "nand", "iproc-idm", "iproc-ext";
 		interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.53.0




