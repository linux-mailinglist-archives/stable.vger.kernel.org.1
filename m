Return-Path: <stable+bounces-218986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDZSHANanmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:10:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DFF190A06
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42A2730DE3DA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DDD29D29E;
	Wed, 25 Feb 2026 01:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WZDkSOe0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF1529BDA2;
	Wed, 25 Feb 2026 01:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983891; cv=none; b=ISEHJSVjJkaZUZQ7B1Qdiapt5vilWWETtT0/t2+fvpH0GQhbu/tmkxqZ8cD6Ey+R8XHoUBdEYt3ehKjeHUBsIdNZX+fF7wUDpJc3r/TLwP+DL3o6T7uAjaVH8DJ9FCh2At4HK8tURqO2zZ8UDQMIlJrzF3eePrDrmiJUeINbhQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983891; c=relaxed/simple;
	bh=qTxfdv0VW76eW+gdck6WRvyfLCsX399/K3oJU3PDrgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4DwFusPxWefF/xAjqAbE4wuVJ5F+8K5xrV/WYN4OXbNFPf5Ukf2DEsnyQpIcLPoFY09US0zpPFh1Q+Qo49jgjLDWzKc6GPQXzT1IerTt5UKXoGvNice+5mV4iZ6/0phsQ6RCZfgfS3pTK3bkzcjusoCBTBMAQnEDmmuXzD/9Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WZDkSOe0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8621C116D0;
	Wed, 25 Feb 2026 01:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983891;
	bh=qTxfdv0VW76eW+gdck6WRvyfLCsX399/K3oJU3PDrgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WZDkSOe0CuL6QAqHdxDAxmeanxZEaU2EgpB6gFvpOB3+OsAdK5jQRCg4cFKmXIqZS
	 z4mPcu2AUV4/LtpiZHhK0LVXX6LPXmrF/ZqPiKINJX0YKD8kr2wyMMAUPId+EPlv2V
	 dSc4rvqvOl76i8DvK+JCjOnfanTt3XcPXhuSOL+8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan Marek <jonathan@marek.ca>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 163/641] arm64: dts: qcom: x1e: bus is 40-bits (fix 64GB models)
Date: Tue, 24 Feb 2026 17:18:09 -0800
Message-ID: <20260225012353.014387534@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218986-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,0.1.134.160:email,marek.ca:email]
X-Rspamd-Queue-Id: C9DFF190A06
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 3290fd8c2d6e6..512a75da4f13f 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
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




