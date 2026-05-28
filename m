Return-Path: <stable+bounces-254884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHeAMncrGGqwfAgAu9opvQ
	(envelope-from <stable+bounces-254884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:48:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD4D5F1840
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF50E30465DA
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFE43E5A3D;
	Thu, 28 May 2026 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J11sJd0R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4643CE4A7
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968719; cv=none; b=L9hecdQ8CKIrpP3X9eaLAlg0jMg64jNB+qYW/ytRHjyKmoJF+yVkvFDpIHglDV2EojJAVOE2VHdhO0RpsLaLPCbHwG88kut74JJW82Zg1vb7GyuRjC5WFEFp27SEFzfhXob0H6Wtxx6QPeMszJP0LUky/T+FTzGOILV+j2M+B6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968719; c=relaxed/simple;
	bh=dRcNcqC1+KgVCBNJi1X9/ZUf8GMrwnqcr2dlyjg+SEI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IQ+yif/LCYx7H1edZV8G4OSJSXus3YcQ2EpLdpAi5PpqAIIc2thplKLvXbXtdavhNynnZHLldDoBpnDK558Fri/1L2I9ScvA72nC9OF/L75WAxCbZ+2Fp454l2kP5XhCBC0ZdZm5tmCoI2o88tPBxdkXhYgexYt+AYGeS9uJkiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J11sJd0R; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355081F000E9;
	Thu, 28 May 2026 11:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779968717;
	bh=GmC8qFBgjDIUGp4ntia5dKjB+b/w9I1aWwW8P/xpE1g=;
	h=Subject:To:Cc:From:Date;
	b=J11sJd0RVlvWkgrxsYy7528VQ7NhIGASvJL7L6P0aZqfms/n6kKPT2OQrhuOaQi1o
	 M+JE9ZlngaNCmo613U0ttqMei073aauSjwMJnqfUrEzet6Um16n+zvEI8bayT1DTBx
	 u99ZlKyqIt3D52bYavDFQ3rlQoUwWklLehpPGZVE=
Subject: FAILED: patch "[PATCH] phy: qcom: edp: Fix AUX_CFG8 programming for DP mode" failed to apply to 6.18-stable tree
To: yongxing.mou@oss.qualcomm.com,dmitry.baryshkov@oss.qualcomm.com,konrad.dybcio@oss.qualcomm.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 13:44:24 +0200
Message-ID: <2026052824-rigging-trial-9eaf@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254884-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,qualcomm.com:email,gregkh:email]
X-Rspamd-Queue-Id: 4BD4D5F1840
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x bf237a9fcbbf9d658522f7315ffc04bf2d49be42
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052824-rigging-trial-9eaf@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bf237a9fcbbf9d658522f7315ffc04bf2d49be42 Mon Sep 17 00:00:00 2001
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:35:22 +0800
Subject: [PATCH] phy: qcom: edp: Fix AUX_CFG8 programming for DP mode

AUX_CFG8 depends on whether the PHY is operating in eDP or DP mode, not
the selected swing/pre-emphasis table. All supported platforms already
have the proper tables, so remove the unnecessary check.

Cc: stable@vger.kernel.org
Fixes: 6078b8ce070c ("phy: qcom: edp: Add set_mode op for configuring eDP/DP submode")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Link: https://patch.msgid.link/20260427-edp_phy-v5-4-3bb876824475@oss.qualcomm.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 3e613b374032..3a848f18a8d6 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -325,12 +325,7 @@ static int qcom_edp_phy_init(struct phy *phy)
 	       DP_PHY_PD_CTL_PLL_PWRDN | DP_PHY_PD_CTL_DP_CLAMP_EN,
 	       edp->edp + DP_PHY_PD_CTL);
 
-	/*
-	 * TODO: Re-work the conditions around setting the cfg8 value
-	 * when more information becomes available about why this is
-	 * even needed.
-	 */
-	if (edp->cfg->dp_swing_pre_emph_cfg && !edp->is_edp)
+	if (!edp->is_edp)
 		aux_cfg[8] = 0xb7;
 
 	writel(0xfc, edp->edp + DP_PHY_MODE);


