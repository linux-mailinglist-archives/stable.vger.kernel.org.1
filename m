Return-Path: <stable+bounces-254878-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK3CEbcqGGrneggAu9opvQ
	(envelope-from <stable+bounces-254878-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:44:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 775F85F176D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2CD6301D135
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991503E5ED2;
	Thu, 28 May 2026 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fMjTSS71"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351B53E5573
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968679; cv=none; b=cvP+j6Eu31xbpAmaEc1mtMEREisqqmC5EKlHWrzEgK6GTlyYUxiL7odIG3N5n0BRN/1Xybc0vJmdAtIN10A5rO6Ctt3vxj52j/TEv7JJcA6UMSJ8x1WzABs32DptIx0jFlrXjY5eyZi+xE8eych8Jyx70wYOGnFO/SCibntmLHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968679; c=relaxed/simple;
	bh=KqYjnisblXNAnE2IVZSDS8Hl6whRrUQxS7FL0Uf+mmo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XaFbNmObMpbxFNLI++128t6OHcfziSlh2YTT1HUJ+kd+q5Ff6rZmkKTKpXFqAevbtgWdvdobAMoevYxdQUQ//88Tv6HWE2tiljKV7dEYlOjaFVYDetsTiPRoBHZ+c/8w2z3b0vYR3CQ+fJB2Gl3c54Az0bRWop7QnAs209ScxPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fMjTSS71; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A201F000E9;
	Thu, 28 May 2026 11:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779968673;
	bh=pwlwtHhCUUjDYLvG7tpimpK6Uc3LUw4NwVXz/q3av+0=;
	h=Subject:To:Cc:From:Date;
	b=fMjTSS71yE0h/Z7MFmUHQTa/0XIAaxDHm7n9P+nVVhjnA5595eJT58eiiMHnCVYFa
	 D+gZV0tV4S5Srpl5aPHBECwdwktjWi3Cz6R3Wvo7gvxL2n8eKFRWCVWLM80zHrxXgD
	 /kqjv992IhVgLLzVLn8v3MECdZ79P7OJuJCvCuX4=
Subject: FAILED: patch "[PATCH] phy: qcom-qmp-ufs: Fix kaanapali PHY PLL lock failure after" failed to apply to 6.12-stable tree
To: nitin.rawat@oss.qualcomm.com,abel.vesa@oss.qualcomm.com,konrad.dybcio@oss.qualcomm.com,mani@kernel.org,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 13:43:37 +0200
Message-ID: <2026052837-stopping-busily-25e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254878-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,msgid.link:url,linuxfoundation.org:dkim,gregkh:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 775F85F176D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 80305760d7a55b884fb9023c490b75568d1ea0b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052837-stopping-busily-25e3@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 80305760d7a55b884fb9023c490b75568d1ea0b1 Mon Sep 17 00:00:00 2001
From: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 16:18:51 +0530
Subject: [PATCH] phy: qcom-qmp-ufs: Fix kaanapali PHY PLL lock failure after
 SM8650 G4 fix

Commit 81af9e40e2e4 ("phy: qcom: qmp-ufs: Fix SM8650 PCS table for Gear 4")
moved QPHY_V6_PCS_UFS_PLL_CNTL register configuration from the shared
sm8650_ufsphy_g5_pcs table to the SM8650-specific sm8650_ufsphy_pcs base
table to fix Gear 4 operation on SM8650.

However, this change inadvertently broke kaanapali and SM8750 SoCs
which also rely on the shared sm8650_ufsphy_g5_pcs table for Gear 5
configuration but use their own sm8750_ufsphy_pcs base table. After the
change, kaanapali PHYs are left without the required PLL_CNTL = 0x33
setting, causing the PHY PLL to remain at its hardware reset default
value, preventing PLL lock and resulting in DME_LINKSTARTUP timeouts.

Fix this by adding the missing QPHY_V6_PCS_UFS_PLL_CNTL = 0x33 entry
to the sm8750_ufsphy_pcs table, mirroring what the original commit
already did for sm8650_ufsphy_pcs.

Cc: stable@vger.kernel.org # v6.19.12
Fixes: 81af9e40e2e4 ("phy: qcom: qmp-ufs: Fix SM8650 PCS table for Gear 4")
Signed-off-by: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20260415104851.2763238-1-nitin.rawat@oss.qualcomm.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 771bc7c2ab50..b87314c8379d 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -1112,6 +1112,7 @@ static const struct qmp_phy_init_tbl sm8750_ufsphy_pcs[] = {
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PCS_CTRL1, 0x40),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x33),
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_SIGDET_CTRL2, 0x68),
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_POST_EMP_LVL_S4, 0x0e),


