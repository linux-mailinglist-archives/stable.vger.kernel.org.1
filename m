Return-Path: <stable+bounces-218223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC+cKxZSnmmbUgQAu9opvQ
	(envelope-from <stable+bounces-218223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:36:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 900D918F1CB
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E749F310454A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02247242D9B;
	Wed, 25 Feb 2026 01:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vysGV7lQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EF32E401;
	Wed, 25 Feb 2026 01:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983017; cv=none; b=eYsnTaRs0f52p7Q4AW5ptzP6+nSP3knKJDBdf0Qcgo2CPdb9BWrlFNk4cApgp294wqsGX5olHDFEGcUB+1UiAG0fmlwTL5kgxq4/gXMJ5pqIJhnxZ5f5G+CYzA04VYXfazyo8X1PhNi2eHJR27EWycXqDsnoShqPcp/YFGsKda4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983017; c=relaxed/simple;
	bh=wQsuwcriK/o9WRXigW10bDJ6Pa4IBO4CsIv3JkL8caM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rh5stdg8qh/D3hF178szmr1NbBPMm1bdODybI1lkr9lk1xMOEZBaomoV5aDbYcI5edgxZbF2OIpFqirPxkR8ndn3CPUk46acBTAJ66+rzVwr5Pm5DKaiQ8K0jZ09Avpia/o80ErNXUHU2zbnnddntZew/C/JOZPHEZtLjkpUKP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vysGV7lQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EDCC116D0;
	Wed, 25 Feb 2026 01:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983017;
	bh=wQsuwcriK/o9WRXigW10bDJ6Pa4IBO4CsIv3JkL8caM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vysGV7lQDm80RFkhc5KVCEpdZITTJ9IPTS1Xi+n3qFicXhZbx3WLUHkhzOqRyQ9of
	 wJ5zHzoHC8B7MYEOXKteLLcZJdQ48QD/7l1DZ4UMZjyqInWdTy+NuXwdxikLN+47A1
	 fH6R7Hr5jZFF7a3nzY0PDe+euQglHO3kBW+QSV1E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan Marek <jonathan@marek.ca>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 185/781] arm64: dts: qcom: x1e: bus is 40-bits (fix 64GB models)
Date: Tue, 24 Feb 2026 17:14:54 -0800
Message-ID: <20260225012404.183820580@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218223-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.1.134.160:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,marek.ca:email]
X-Rspamd-Queue-Id: 900D918F1CB
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonathan Marek <jonathan@marek.ca>

[ Upstream commit b38dd256e11a4c8bd5a893e11fc42d493939c907 ]

Unlike the phone SoCs this was copied from, x1e has a 40-bit physical bus.
The upper address space is used to support more than 32GB of memory.

This fixes issues when DMA buffers are allocated outside the 36-bit range.

Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20251127212943.24480-1-jonathan@marek.ca
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/hamoa.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index 9c9e567731556..83a0a0c3239d2 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -791,8 +791,8 @@ soc: soc@0 {
 
 		#address-cells = <2>;
 		#size-cells = <2>;
-		dma-ranges = <0 0 0 0 0x10 0>;
-		ranges = <0 0 0 0 0x10 0>;
+		dma-ranges = <0 0 0 0 0x100 0>;
+		ranges = <0 0 0 0 0x100 0>;
 
 		gcc: clock-controller@100000 {
 			compatible = "qcom,x1e80100-gcc";
-- 
2.51.0




