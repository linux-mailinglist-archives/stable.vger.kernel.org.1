Return-Path: <stable+bounces-243386-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Mm2+KRCr+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243386-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:20:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DC64BF19A
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A96330BF821
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0073B19D1;
	Mon,  4 May 2026 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c74t2/tS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA823B7742;
	Mon,  4 May 2026 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903750; cv=none; b=ZQIoL4RZAwF5xmMdpfMNE4Dqj4WJ+rzksJyrREQ+a2DVhaO1i5WefJ4rU+P8muBwSaXaoVIxmlFTN1F6n5he4pcov5ZdVc35fMW4ZjgV7AfSq3mkijrHRvoT0k1mEvmGxeFDLATqAyEsLYkG87Ug7cjaIU5YD6Dd6NVkGSJO8gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903750; c=relaxed/simple;
	bh=iT0eMMuT3diDsmA2aKKH0rPwRXJTW46qJ6xe3AUD0U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVFhhyyMMBZfqJKBjl7gEaM7S0tS0i7aRmPQhkYJjpuckE6BFtlseHCb8KC7W6k5m+eD5A6zB5t/gpxmEihEWyRLGuyJnOKQQ9F0AZlQqF91tUAaJvN8r5hBl7tiSzlL9W9fxqHfW3rbc/iEhAaxvib3Y6b0wR1Nns62h+iYBrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c74t2/tS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AA5C2BCB8;
	Mon,  4 May 2026 14:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903750;
	bh=iT0eMMuT3diDsmA2aKKH0rPwRXJTW46qJ6xe3AUD0U4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c74t2/tS9qNTIX2zYLJK+oCrssrKpCtqdNsi9aw4D+obzWpVDvvddJJcGEPTGCJvx
	 DpiNP2U8nY+kLqB7bLBr6fiiSHbFkGMBQfbylyVV2Zh4BpC+vS1drWA2aXtqdUfdli
	 mlSKA+IOCSWWlMmsh5Cpq4Meu6FoT/cie5/LlBEs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 6.18 046/275] PCI: imx6: Skip waiting for L2/L3 Ready on i.MX6SX
Date: Mon,  4 May 2026 15:49:46 +0200
Message-ID: <20260504135144.651758755@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 08DC64BF19A
X-Rspamd-Action: no action
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243386-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,nxp.com:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Zhu <hongxing.zhu@nxp.com>

commit 5f73cf1db829c21b7fd44a8d2587cd395b1b2d76 upstream.

On i.MX6SX, the LTSSM registers become inaccessible after the
PME_Turn_Off message is sent to the link. So there is no way to verify
whether the link has entered L2/L3 Ready state or not.

Hence, set IMX_PCIE_FLAG_SKIP_L23_READY flag for i.MX6SX SoC to skip the
L2/L3 Ready state polling and let the DWC core wait for 10ms after sending
the PME_Turn_Off message as per the PCIe spec r6.0, sec 5.3.3.2.1.

Fixes: a528d1a72597 ("PCI: imx6: Use DWC common suspend resume method")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
[mani: commit log]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260228080925.1558395-1-hongxing.zhu@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/dwc/pci-imx6.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1844,6 +1844,7 @@ static const struct imx_pcie_drvdata drv
 		.variant = IMX6SX,
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
 			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
+			 IMX_PCIE_FLAG_SKIP_L23_READY |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.ltssm_off = IOMUXC_GPR12,



