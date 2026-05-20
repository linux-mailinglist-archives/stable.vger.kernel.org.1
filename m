Return-Path: <stable+bounces-252145-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJrqBXT5DWqR5AUAu9opvQ
	(envelope-from <stable+bounces-252145-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:12:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E8C59588E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D131E31652D0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D133F929A;
	Wed, 20 May 2026 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QZV7Bysc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA42C3FD15F;
	Wed, 20 May 2026 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299909; cv=none; b=UoXZUDKsS3Yxk4AQiuea3oRL5jr3Yu+rCGWGU4YUw93i+6dnFrcvmEb/1/eHHuCGibkM4Ui7b1ti6gsRjQhJje1chcOICicaDktbA/u1WT3Fr+iOmswPyHvhbDbgPP4GAPBV2XMrDF0NFxXzq1OjgWHUokCpkh2/feqXsC+VlSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299909; c=relaxed/simple;
	bh=uRkQvkKYfP/sJRzN2NV2Tm8zvnNgZ3zHLpgrjHWgeZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJVFgI0HegLedLt/6GsZEuquacp38uEWNYhtclLJU4erUXwt23mXs3V3zVILfQ/ruOQhvToChOWvrF5gG6ucHT+Mv2gdNhCxpgYU1L0cAvt/Nf6s+iJzanjDiqVuaghitc7Tms/JNTOdIDPNGCe1tUR3dlPxbrHylmtBxiQaTi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QZV7Bysc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240121F00893;
	Wed, 20 May 2026 17:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299907;
	bh=SAA13nuY3DFvNu+/v4QP6tOyY/g25NhA1Ns8G2NlYnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QZV7ByscK5nvNPBDC2DSEurjcMZfZQzhYoHeHiFEl7OcUQ0GwFQ/06TW42JI4774E
	 4kjsEdJO+B6zBy75blbS4xFU5lGbQkCauJDROyi7b2BFiVRmLwA9HziwcLaqlLvGSX
	 /6uysKE6pdaDNSw4UGv64reASQsOQDXFxPqbeKIY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zoran Ilievski <goodboy@rexbytes.com>,
	Sukhdeep Singh <sukhdeeps@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 890/957] net: atlantic: preserve PCI wake-from-D3 on shutdown when WOL enabled
Date: Wed, 20 May 2026 18:22:53 +0200
Message-ID: <20260520162153.871412608@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252145-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,marvell.com:email]
X-Rspamd-Queue-Id: B1E8C59588E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zoran Ilievski <goodboy@rexbytes.com>

commit 2c308cf34284420963607d677d576a2b4124d8bd upstream.

The shutdown handler aq_pci_shutdown() unconditionally calls
pci_wake_from_d3(pdev, false), clearing the PCI PME_En bit even when
wake-on-LAN has been configured. While aq_nic_shutdown() correctly
programs the NIC firmware via aq_nic_set_power() to listen for magic
packets, the PCI subsystem will not propagate the resulting PME wake
event from D3, so the system never wakes after poweroff.

WOL from suspend (S3) is unaffected because aq_suspend_common() does
not touch pci_wake_from_d3() and relies on the PM core's wake
configuration via device_may_wakeup().

This affects all atlantic-supported NICs (AQC107/108/111/112/113);
users have reported that WOL works if the atlantic driver is never
loaded, but breaks once it has run its shutdown path.

Pass the configured WOL state to pci_wake_from_d3() instead of a
literal false, so the PCI PME_En bit is preserved when the user has
armed WOL via ethtool.

Fixes: 90869ddfefeb ("net: aquantia: Implement pci shutdown callback")
Cc: stable@vger.kernel.org
Signed-off-by: Zoran Ilievski <goodboy@rexbytes.com>
Reviewed-by: Sukhdeep Singh <sukhdeeps@marvell.com>
Link: https://patch.msgid.link/20260511064002.1857-1-goodboy@rexbytes.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -371,7 +371,7 @@ static void aq_pci_shutdown(struct pci_d
 	pci_disable_device(pdev);
 
 	if (system_state == SYSTEM_POWER_OFF) {
-		pci_wake_from_d3(pdev, false);
+		pci_wake_from_d3(pdev, self->aq_hw->aq_nic_cfg->wol);
 		pci_set_power_state(pdev, PCI_D3hot);
 	}
 }



