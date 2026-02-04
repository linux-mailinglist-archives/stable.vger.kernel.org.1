Return-Path: <stable+bounces-213796-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIfxL7pjg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213796-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:20:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0E1E8513
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18E4F30151FE
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575092D594F;
	Wed,  4 Feb 2026 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XomKZpjz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A66F423A62;
	Wed,  4 Feb 2026 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217540; cv=none; b=H0N/Tkj+w0BUUqS8W9Zya5l6RfRhL8yYri8tskXs7Mx51NMqTzken03wyDcIcxDHD8AZ5nRZ98/SUx+CdiiDER/48EW99iiTp0uxEBd5VX9caftciw0YvZ1tsuNzQSA7ODxxdn/9JGChy9AG1eV0JaTZ3mz09XQf+XWCD4sq/kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217540; c=relaxed/simple;
	bh=I7rmWifNfDHMkd0l1oyK9z9wy++FOH5iZJBmh+/fdSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sU9m50r7hhvZzvFhiuUrkLDgDz+lB2tioVux3xLnZOi912OOwKWQWBl+ZN7G2tGA3F1tRW1LExyD19Y2ybxwSSHF9OxMtgItVtW1+HNix9FzMZvjWTqISxJKWhHO4yV3mk2Pg82FUPUZoSfSS/8Bv6zkmv8yEyGoJvbT3A/Z8nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XomKZpjz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823B2C4CEF7;
	Wed,  4 Feb 2026 15:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217540;
	bh=I7rmWifNfDHMkd0l1oyK9z9wy++FOH5iZJBmh+/fdSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XomKZpjzY8so3zed7bkfoHNRyT/gq1uCDHKKltG98j+hauHYnMW7KP02MicOOdR7e
	 oWBG6/vZlglSvcEbkZVquHT27D5buLHnGOmBJzN66VIMMtCYbCdA/0Ufs8XX07Kkjy
	 +M+nyumvrNKOjOneIYXH3dPvwGd2uMrOTIuQP7nY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rafael Beims <rafael.beims@toradex.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.1 044/280] phy: freescale: imx8m-pcie: assert phy reset during power on
Date: Wed,  4 Feb 2026 15:36:58 +0100
Message-ID: <20260204143911.224172133@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213796-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:url,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,toradex.com:email]
X-Rspamd-Queue-Id: 5B0E1E8513
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael Beims <rafael.beims@toradex.com>

commit f2ec4723defbc66a50e0abafa830ae9f8bceb0d7 upstream.

After U-Boot initializes PCIe with "pcie enum", Linux fails to detect
an NVMe disk on some boot cycles with:

  phy phy-32f00000.pcie-phy.0: phy poweron failed --> -110

Discussion with NXP identified that the iMX8MP PCIe PHY PLL may fail to
lock when re-initialized without a reset cycle [1].

The issue reproduces on 7% of tested hardware platforms, with a 30-40%
failure rate per affected device across boot cycles.

Insert a reset cycle in the power-on routine to ensure the PHY is
initialized from a known state.

[1] https://community.nxp.com/t5/i-MX-Processors/iMX8MP-PCIe-initialization-in-U-Boot/m-p/2248437#M242401

Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251223150254.1075221-1-rafael@beims.me
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -91,7 +91,8 @@ static int imx8_pcie_phy_power_on(struct
 			writel(imx8_phy->tx_deemph_gen2,
 			       imx8_phy->base + PCIE_PHY_TRSV_REG6);
 		break;
-	case IMX8MP: /* Do nothing. */
+	case IMX8MP:
+		reset_control_assert(imx8_phy->reset);
 		break;
 	}
 



