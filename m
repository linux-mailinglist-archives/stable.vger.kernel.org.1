Return-Path: <stable+bounces-211571-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCnEK/Zod2nCfQEAu9opvQ
	(envelope-from <stable+bounces-211571-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:15:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3B688AD3
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 14:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B356530495CE
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 13:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42BD338586;
	Mon, 26 Jan 2026 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WgHUcMnU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C643382FE
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769433249; cv=none; b=aNJYG6yw1kB+C4vW8Qb5gAAmfbqSWcnLjJrt2mEVnu/lQlMVNt54VZsoz4D076lmU+GBH797Yd9C4eH2LKS0A0Hf/HRmvyvmptCZxo7dlnghGa4YA2YRqAhDErWfoh6kvPnpB49EuADzLN1DBmLCjoi6qu4q7L8SF+LvN9YyRkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769433249; c=relaxed/simple;
	bh=HqEU02lWNTPRhSQVHx57lh7UfdSLCUzYlxYdCt6LT6E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jCXCJmfxm2oVEktneWpcOT9zZe/xTX8UaaRKP8i207+swXY3Yg6Wel9alIbcGhENBdnbndsXGEFZquatLyBKia/uvB0Uqgy1SURwrfTC4mgXBzAWJDkQZpXvWE2oUvI5K65OFHHkvcz/6KNwOYepF4/khEU35VGsrYJeGFfF0fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WgHUcMnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A2BC116C6;
	Mon, 26 Jan 2026 13:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769433249;
	bh=HqEU02lWNTPRhSQVHx57lh7UfdSLCUzYlxYdCt6LT6E=;
	h=Subject:To:Cc:From:Date:From;
	b=WgHUcMnUJbgGQuEM31DFas62habvL9EYZPGKxCfujdcvtH5QVTMlY0BZVFUYXydwp
	 pqFfa6J8HOzUFbttZjk8BatdpGCYbvVAX/VQTl0hloT/aaePHg9Xu0UE/p237KekU6
	 l2o5qt2tAi3CsNjcvrYFqPUaxb2yakOrF81qJWaI=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: talos: Correct UFS clocks ordering" failed to apply to 6.18-stable tree
To: pradeep.pragallapati@oss.qualcomm.com,andersson@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Jan 2026 14:14:06 +0100
Message-ID: <2026012606-rebel-animator-928a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211571-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,qualcomm.com:email,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D3B688AD3
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 8bb3754909cde5df4f8c1012bde220b97d8ee3bc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012606-rebel-animator-928a@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8bb3754909cde5df4f8c1012bde220b97d8ee3bc Mon Sep 17 00:00:00 2001
From: Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>
Date: Wed, 26 Nov 2025 18:41:46 +0530
Subject: [PATCH] arm64: dts: qcom: talos: Correct UFS clocks ordering

The current UFS clocks does not align with their respective names,
causing the ref_clk to be set to an incorrect frequency as below,
which results in command timeouts.

ufshcd-qcom 1d84000.ufshc: invalid ref_clk setting = 300000000

This commit fixes the issue by properly reordering the UFS clocks to
match their names.

Fixes: ea172f61f4fd ("arm64: dts: qcom: qcs615: Fix up UFS clocks")
Cc: stable@vger.kernel.org
Signed-off-by: Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20251126131146.16146-1-pradeep.pragallapati@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index d1dbfa3bd81c..95d26e313622 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -1399,10 +1399,10 @@ ufs_mem_hc: ufshc@1d84000 {
 				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
 				 <&gcc GCC_UFS_PHY_AHB_CLK>,
 				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
-				 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
-				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>;
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
 			clock-names = "core_clk",
 				      "bus_aggr_clk",
 				      "iface_clk",


