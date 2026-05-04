Return-Path: <stable+bounces-243090-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGSONJim+GkExgIAu9opvQ
	(envelope-from <stable+bounces-243090-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:00:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDC04BE537
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38C053035F16
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF013D75CE;
	Mon,  4 May 2026 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pYVzJNad"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDEF20DD51;
	Mon,  4 May 2026 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902992; cv=none; b=Kug86tPd14/JfjPrQM1n8TKFObwmsD24+GWCts9QRk6gpr8QYC8oSasoquosC+e8KUbX+S3KwMh7wZrLKb/PswivRa3tiRG/c2XGD7ToLkyGkxaqBYJlGdbECjEwvxwnb1Xvm5WkHuVWLmATlv9cYPMiyOwmWL3ysCwjkR7RF/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902992; c=relaxed/simple;
	bh=1BsSI3d/zegQxs+vAOUAYfjlIWTyzDS9JgWR261Ejac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aeOxRHvrOJ0jnGYWcK9n52Kwkur++j0QubzPLtOsmJgCw3l/vCyhmv0Aqu6DLPjr2M3z3Vzkl18zOimYJ2nEpiwdKVrPuYVwVywbkdsLK9u3ejEEMeZITGNk4kuAJcKvUp6yTFO+6QhsX9O4LQ+nh82I4TN4FS+hUEk174wYmZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pYVzJNad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AAEC2BCB8;
	Mon,  4 May 2026 13:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777902992;
	bh=1BsSI3d/zegQxs+vAOUAYfjlIWTyzDS9JgWR261Ejac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pYVzJNadkVeNFL7Ldcs8nb8b/RbmxyJ/7deSfSmD9TFBZM13aL6myLDqKqb0Ij9Dn
	 3yZw6GVmkY2hjdNzzRkBBLGj04SK49v44oaeWsYLp0juExM1rEWgKZC8bVzESDkkNp
	 mzOm0GgQYo45BKaETynFhJL00AC0XnbULzyx1wHM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Elson Serrao <elson.serrao@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 7.0 060/307] phy: qcom: m31-eusb2: clear PLL_EN during init
Date: Mon,  4 May 2026 15:49:05 +0200
Message-ID: <20260504135145.078668285@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 8DDC04BE537
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-243090-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Elson Serrao <elson.serrao@oss.qualcomm.com>

commit 520a98bdf7ae0130e22d8adced3d69a2e211b41f upstream.

The driver currently sets bit 0 of USB_PHY_CFG1 (PLL_EN) during PHY
initialization. According to the M31 EUSB2 PHY hardware documentation,
this bit is intended only for test/debug scenarios and does not control
mission mode operation. Keeping PLL_EN asserted causes the PHY to draw
additional current during USB bus suspend. Clearing this bit results in
lower suspend power consumption without affecting normal operation.

Update the driver to leave PLL_EN cleared as recommended by the hardware
documentation.

Fixes: 9c8504861cc4 ("phy: qcom: Add M31 based eUSB2 PHY driver")
Cc: stable@vger.kernel.org
Signed-off-by: Elson Serrao <elson.serrao@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://patch.msgid.link/20260217201130.2804550-1-elson.serrao@oss.qualcomm.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/phy/qualcomm/phy-qcom-m31-eusb2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
@@ -83,7 +83,7 @@ static const struct m31_phy_tbl_entry m3
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_CFG0, UTMI_PHY_CMN_CTRL_OVERRIDE_EN, 1),
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_UTMI_CTRL5, POR, 1),
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_HS_PHY_CTRL_COMMON0, PHY_ENABLE, 1),
-	M31_EUSB_PHY_INIT_CFG(USB_PHY_CFG1, PLL_EN, 1),
+	M31_EUSB_PHY_INIT_CFG(USB_PHY_CFG1, PLL_EN, 0),
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_FSEL_SEL, FSEL_SEL, 1),
 };
 



