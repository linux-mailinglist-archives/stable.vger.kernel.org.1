Return-Path: <stable+bounces-251612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHWaEKzyDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-251612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:43:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A951C594616
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D500309AA63
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE92359A6F;
	Wed, 20 May 2026 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RCKSgTxd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2172736405A;
	Wed, 20 May 2026 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298435; cv=none; b=FCg1MWQdKo8qRrKUNi5KOLoS7Md9VndV9/AyVjykoMyRyogK2Dce7LxzPeUG6LM/Rfi+HbTSKB1jMBL4k7kQLFvYG4KbwQbnwIr+K4vC8r3MhAFz3Aw51dBVNcLYWEBbRECTSnyZAtq8MgoshkwiLDpsVOIDUB0C/NQKzu9x50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298435; c=relaxed/simple;
	bh=7c1X/Ug5ckP38GwNjPlgs6Ek597XafraDCEmrnNg+jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZU8jkCwpJPZXs1G8t3ogD8TB316rF67qsy5c7oE6jVPNYFv8pBFqMYVTTwgk93dRveShOayYqJrcojOmL/G1/xGgq0S32znGDoAXgqocy4C2pHamTLrIWpmfW9O85PFTBvoCq33VNke7t2x1qZv9kdvLh0eImfK6K2ZDARy2sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RCKSgTxd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF051F000E9;
	Wed, 20 May 2026 17:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298434;
	bh=8PdZU4pYxg5ddYDmJ4+FikjpI+9wIEapxKFrjqUM/Rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RCKSgTxd9C9pHqR1ah78q0blQVDNEPwuCouKpu/pE5YntxUnYwJ8p+WsmJcPAnl1A
	 incpnYID3A3mfdJuZM3ySGLQUxuOKigSUOMrsOiYDEb0vVh9uq8wz5JKsEo5HURGOV
	 UBqWLxJkmjwnpdIsDNAhDWzT+oVc3yY93Agr52Us=
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
Subject: [PATCH 6.18 410/957] arm64: dts: qcom: sm7225-fairphone-fp4: Fix conflicting bias pinctrl
Date: Wed, 20 May 2026 18:14:53 +0200
Message-ID: <20260520162143.416386846@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251612-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,fairphone.com:email]
X-Rspamd-Queue-Id: A951C594616
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index 4afbab570ca15..8cbe068645ea9 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -953,12 +953,14 @@ &qup_uart1_cts {
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
 
@@ -969,12 +971,14 @@ &qup_uart1_rx {
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




