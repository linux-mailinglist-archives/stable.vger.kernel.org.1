Return-Path: <stable+bounces-247601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHfvNP/dBmp4ogIAu9opvQ
	(envelope-from <stable+bounces-247601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:49:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B23154BB2F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24EB4308154B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451BF40DFC0;
	Fri, 15 May 2026 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dn5+YtQr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EAA406284
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834502; cv=none; b=fgJGLNbdtfkaCZK1aJj2KhPiY8bn/yZexeShYWkOyskbZdo8EdKJh2M55TKAfHjyH/O4HGt3p7wSIDOt0DBHWzJO83vlBi6BMqFs2nuFSV5m8Wkp+s2nLKofENizLWCoWETbDs1gjP3reTCVpnezVMIsZeNyZY30Nl16/7Kdag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834502; c=relaxed/simple;
	bh=tJ+af386mViubwFOihlNRUAL+NrHWh1Ewlykyn642zA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=H76k2XfnKgsXizGYR6K9YkWWYjUw1iNMY+goyYpLi9LrYfZjN1BFxxOezpLqciEiN5/axNqTLr8ThzgMzCBniT87UpC0I9aA/7Uysei8sO/7hK0ddHaVUG7627euiZcGaqxYtGuEodRwSQeAMy1Ta5glwlZ4O/prXNhM5NJ64o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dn5+YtQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A293C2BCB8;
	Fri, 15 May 2026 08:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778834501;
	bh=tJ+af386mViubwFOihlNRUAL+NrHWh1Ewlykyn642zA=;
	h=Subject:To:Cc:From:Date:From;
	b=Dn5+YtQr4JKQF/6ZuoY9+h1MYS4KoGaM5suu/LJvwUvOgnbZPSqnoF6ddbXaudrfV
	 yQerQifysW/GBnACFHev6wmKjlKWSUKOlaHZeTyOunEDs2b8OcsOSVjegwjtFumKfd
	 YeTFXLR5Bl7+M7VvxeimCTM4GBwLX8aXFSDpfAZM=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: kodiak: Fix PCIe1 PHY ref clock voting" failed to apply to 6.18-stable tree
To: krishna.chundru@oss.qualcomm.com,andersson@kernel.org,dmitry.baryshkov@oss.qualcomm.com,konrad.dybcio@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:41:45 +0200
Message-ID: <2026051545-blooming-unashamed-d09d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7B23154BB2F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247601-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,qualcomm.com:email,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 30e8b6d42e8988eaaf0c2efd8c3797cb3884faea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051545-blooming-unashamed-d09d@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 30e8b6d42e8988eaaf0c2efd8c3797cb3884faea Mon Sep 17 00:00:00 2001
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 23 Jan 2026 17:42:27 +0530
Subject: [PATCH] arm64: dts: qcom: kodiak: Fix PCIe1 PHY ref clock voting

GCC_PCIE_CLKREF_EN controls a repeater that provides the reference clock
only to the PCIe0 PHY. PCIe1 PHY receives its refclk directly from the CXO
source.

If the PCIe1 driver in HLOS votes for or against GCC_PCIE_CLKREF_EN, it
will inadvertently modify the refclk to PCIe0 as well. Since PCIe0 is
managed by WPSS while PCIe1 is managed in HLOS, there is no mechanism to
coordinate these votes. As a result, HLOS may disable this repeater
during suspend and cut off the PCIe0 PHY refclk while PCIe0 is still
active.

Replace the unused GCC_PCIE_CLKREF_EN clock entry with RPMH_CXO_CLK to
reflect the actual hardware wiring and prevent unintended changes to
PCIe0 clocking.

Fixes: 92e0ee9f83b3 ("arm64: dts: qcom: sc7280: Add PCIe and PHY related nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260123-fix_pcie1_phy_clk-v1-1-38f82ea01792@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index 6079e67ea829..ba0f7e5c89a0 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -2445,7 +2445,7 @@ pcie1_phy: phy@1c0e000 {
 			reg = <0 0x01c0e000 0 0x1000>;
 			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
 				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
-				 <&gcc GCC_PCIE_CLKREF_EN>,
+				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_PCIE1_PHY_RCHNG_CLK>,
 				 <&gcc GCC_PCIE_1_PIPE_CLK>;
 			clock-names = "aux",


