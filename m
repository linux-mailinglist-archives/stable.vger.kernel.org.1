Return-Path: <stable+bounces-253047-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKgRGyABDmqs5QUAu9opvQ
	(envelope-from <stable+bounces-253047-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:44:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FEB5972A3
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 403F530CFCAA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6463D6CA5;
	Wed, 20 May 2026 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AB4Voyn2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EAD371CEA;
	Wed, 20 May 2026 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302265; cv=none; b=OMy9/MImPO7Nd0z/ceMGczZt67/M9es4+/+a1B/ffyodJwmCSS3AcIREqAMjzPXHidwQOwVNFIEvDc9htPSdg3GwM2li69uEo2Zb+p22uE8op+zj3BfcN2MGUwVX1jTCqB14RHCNw3SyjdUDEM1r2nxWS6KihNPbjg350g3dm8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302265; c=relaxed/simple;
	bh=NY51QWymVKZ4m5P5yFNjV025D/31/tdPhVFTd0pa+x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+CNDaTCZ5gpogROV8Q2KDtlHWteLYpjcp2TqKhlUK8R6Rddfdn1D5Uut4MgqL7G2zQiha9kMtR8Kq1gU8xnnwVx9Is08N+r2ToAJUbaAAvVWmZVUr/iTTpki4JNVyEGAuwHuyQx9PUM8In9DDNLMs6+35NZ1tZ+t4nPHv9mDOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AB4Voyn2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6671F000E9;
	Wed, 20 May 2026 18:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302264;
	bh=5Pfz8N7/D2cLv1F2GvbTpzTnJGetnIy3boVGWVKfp9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AB4Voyn25lHYp2nY2RW0wjRqCxnGj9HsOMw3B55Kwmc4+t3YhtV0n0eScUFshEtVf
	 HWdZlFj3hye0GHo8ErCdsuzSKKlwDrSqqrmbOYtZmoSiamMnKSxR5ed+foeodtSm5/
	 xVq/OBMt+sTYRssqNDkJh05jN6DOlfsvcQgW0rGY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Conor Dooley <conor@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 200/508] arm64: dts: qcom: sm7225-fairphone-fp4: Fix conflicting bias pinctrl
Date: Wed, 20 May 2026 18:20:23 +0200
Message-ID: <20260520162102.970506380@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253047-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,fairphone.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: D9FEB5972A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Weiss <luca.weiss@fairphone.com>

[ Upstream commit be7c1badb0b934cfe88427b1d4ec3eb9f52ba587 ]

The pinctrl nodes from sm6350.dtsi already contain a bias-* property, so
that needs to be deleted, otherwise the dtb will contain two conflicting
bias-* properties.

Reported-by: Conor Dooley <conor@kernel.org>
Closes: https://lore.kernel.org/r/20260310-maritime-silly-05e7b7e03aa6@spud/
Fixes: c4ef464b24c5 ("arm64: dts: qcom: sm7225-fairphone-fp4: Add Bluetooth")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20260319-fp4-uart1-fix-v1-1-f6b3fedef583@fairphone.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index c010e86134ff9..606f7a6f41791 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -533,12 +533,14 @@ &qup_uart1_cts {
 	 * the Bluetooth module drives the pin in either
 	 * direction or leaves the pin fully unpowered.
 	 */
+	/delete-property/ bias-disable;
 	bias-bus-hold;
 };
 
 &qup_uart1_rts {
 	/* We'll drive RTS, so no pull */
 	drive-strength = <2>;
+	/delete-property/ bias-pull-down;
 	bias-disable;
 };
 
@@ -549,12 +551,14 @@ &qup_uart1_rx {
 	 * in tri-state (module powered off or not driving the
 	 * signal yet).
 	 */
+	/delete-property/ bias-disable;
 	bias-pull-up;
 };
 
 &qup_uart1_tx {
 	/* We'll drive TX, so no pull */
 	drive-strength = <2>;
+	/delete-property/ bias-pull-up;
 	bias-disable;
 };
 
-- 
2.53.0




