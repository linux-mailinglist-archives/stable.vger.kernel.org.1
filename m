Return-Path: <stable+bounces-248520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBaUM0lQB2rBxgIAu9opvQ
	(envelope-from <stable+bounces-248520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:56:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8405543C9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B6E934BB3BE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31043FD958;
	Fri, 15 May 2026 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DbH5ycgJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746AA3FBB4C;
	Fri, 15 May 2026 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861939; cv=none; b=smnwPWDNahLBbuBzxDuCX6eJxp0DRpJ0AhpfAy346B1w8LnOP2tOtqLC3rHZ4mzIn0Kagr9zEqG72iSgJowPjnpuMM7ghkO22zFKtZQrNae7eiTKXimu7UqdLFFHlWHhB/9Fuv5r3bVvHIVQ20lUQMq3XD2oxyWdIrxfJLAiOnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861939; c=relaxed/simple;
	bh=18ttHaHiOvq01vjVI/Ir13/L//qRjoqvx6fVag8+f9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMvrk8KOYsAbliE5LMYJ9cvfw5SJk7v1KhFYCGXyEi4ekFcXT/SUcxuRh5Dxlnz1Apbp78hk+/jwWPVt1qNTW5z8Rs5O8BkLtJ9wRf8fJ3EL6daKILZ95nXngs+vOz/a4AAvLbnfCKUMa835ojR/ul/PFGuwMNnAeR5DUmAEHHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DbH5ycgJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2ECC2BCB0;
	Fri, 15 May 2026 16:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861939;
	bh=18ttHaHiOvq01vjVI/Ir13/L//qRjoqvx6fVag8+f9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DbH5ycgJAQ2WdTy+7/52VwVKUJPRqfnrwCIj9oUunzTGOYqtfOBtbSyX7gD/APeZw
	 h6qgCGyglE8pgxTnr7a3gcrKJhjNFJCvXZ7loS49yEL/birIE22ur4raoQnCuh7RMN
	 SnTpEsqVS4ZpraymFbBq2Nh9gpm0Bi9Lv/o9Ed+A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gregor Herburger <gregor.herburger@linutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 6.18 046/188] arm64: dts: broadcom: bcm2712-d-rpi-5-b: add fixes for pinctrl/pinctrl_aon
Date: Fri, 15 May 2026 17:47:43 +0200
Message-ID: <20260515154658.315640098@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 5E8405543C9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248520-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gregor Herburger <gregor.herburger@linutronix.de>

commit aeb078cebc40d421f61a8f07b0e7919aeb44d751 upstream.

On the -d revision of the bcm2712 the pinctrl differs from the c0
revision. The driver already supports both and distinguishes the two
with the compatible string.

Update the compatible string and reg length to reflect the different
pinctrl.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
Link: https://lore.kernel.org/r/20260226-raspi-dts-updates-v1-5-60832d20ff04@linutronix.de
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/broadcom/bcm2712-d-rpi-5-b.dts |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/arm64/boot/dts/broadcom/bcm2712-d-rpi-5-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-d-rpi-5-b.dts
@@ -35,3 +35,13 @@
 		"PMIC_SCL", // AON_SGPIO_04
 		"PMIC_SDA"; // AON_SGPIO_05
 };
+
+&pinctrl {
+	compatible = "brcm,bcm2712d0-pinctrl";
+	reg = <0x7d504100 0x20>;
+};
+
+&pinctrl_aon {
+	compatible = "brcm,bcm2712d0-aon-pinctrl";
+	reg = <0x7d510700 0x1c>;
+};



