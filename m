Return-Path: <stable+bounces-251568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GecJGTyDWrj4wUAu9opvQ
	(envelope-from <stable+bounces-251568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:41:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4689059453A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 927683066338
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B2F36C9D2;
	Wed, 20 May 2026 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sk9TVEZ7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2224B3A3825;
	Wed, 20 May 2026 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298319; cv=none; b=eSuqzZkjptnVsN0X2pAzAq2XfOq7Mgwnh7k2LL/CHo4SwhLGBxL4w5MP8bCbLMM2g8wkqznhe/QMhREKKwWFupX31e0YMQJ5BRT0yZIirga6qBS+uJM0uWGuImZ4S8m2SVaUlZVZPU+1zFdhBD00QEmNEb4Mg2Oh4O9S6n2w+Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298319; c=relaxed/simple;
	bh=ma6e4Cet8HLC5gp1TX9K69Kjnnp+nk9ivtH91sea8+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbYUCSeXKxNSncs7wtwtoV/ZhLvv6JeO6elSYn1MJ0gyo2O9FS9AOOFkl/Cvk0N6QzUHoqHdPpNURWWdclYgyaCc4rabZw3St0AFhD8cV0mRvmPFHcm86+i+PMTr9mGoDA8lCX23JfAJm+Uo0FdcUvSwI082xNqKCFoANrsvwrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sk9TVEZ7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719861F000E9;
	Wed, 20 May 2026 17:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298317;
	bh=apcgc22aHNhBwIIT2ucQaT7GjhsVx4Bl3zUz6dLrtmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sk9TVEZ7mh7s/szxE5Ki2agElVqwNYudmcWzwLaWSAL2CleF1WOJxlsMjTxe8Wj4t
	 9QNPiMmCs3eJ7f2B5WflO/lER9PPcAyuKfuCIg7DzB/pYJrHOjLIGXY2z6VEE0Vx9B
	 mXjIAP0lN2rUOwuUOegDeLpSK3uOZKWz5fwDUWmo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luke Wang <ziniu.wang_1@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 366/957] arm64: dts: imx91-11x11-evk: change usdhc tuning step for eMMC and SD
Date: Wed, 20 May 2026 18:14:09 +0200
Message-ID: <20260520162142.465572488@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251568-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Queue-Id: 4689059453A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luke Wang <ziniu.wang_1@nxp.com>

[ Upstream commit 5ab0c76df2403137a6d0fb27a55e03cedf47f44c ]

During system resume, the following errors occurred:

  [  430.638625] mmc1: error -84 writing Cache Enable bit
  [  430.643618] mmc1: error -84 doing runtime resume

For eMMC and SD, there are two tuning pass windows and the gap between
those two windows may only have one cell. If tuning step > 1, the gap may
just be skipped and host assumes those two windows as a continuous
windows. This will cause a wrong delay cell near the gap to be selected.

Set the tuning step to 1 to avoid selecting the wrong delay cell.

For SDIO, the gap is sufficiently large, so the default tuning step does
not cause this issue.

Fixes: 6772c4cffd87 ("arm64: dts: freescale: add i.MX91 11x11 EVK basic support")
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
index aca78768dbd4b..4164d9e4e0fd2 100644
--- a/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
@@ -415,6 +415,7 @@ &usdhc1 {
 	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
 	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	fsl,tuning-step = <1>;
 	status = "okay";
 };
 
@@ -429,6 +430,7 @@ &usdhc2 {
 	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
 	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
 	vmmc-supply = <&reg_usdhc2_vmmc>;
+	fsl,tuning-step = <1>;
 	status = "okay";
 };
 
-- 
2.53.0




