Return-Path: <stable+bounces-251569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Nc5GCz2DWry4wUAu9opvQ
	(envelope-from <stable+bounces-251569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:58:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02778594FDC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED3433036E32
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DC535AC17;
	Wed, 20 May 2026 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DuHdLxnK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC59E3A874C;
	Wed, 20 May 2026 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298322; cv=none; b=ee/Msyp9THToyV6eRPJa2PhFPjFkv1qn3IoQVDxZW4d5kym/pse8hrYPAu4GEDzdRGmaktEkrdbGynTuHvO4gNewVaSWa7zNNfUJLvH5pnMnrjlMNcfMwyvLne0Gri9FbpIuNmKBhdbF3VPg7o1PCdiAXgpajujQ2s/R73LPiIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298322; c=relaxed/simple;
	bh=dwZJKmv1T2tGFkrd1CUfO5noAjiWUoKC3OsljqcX8nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0EpGzOby2RNw58hUfI9i08XoiJhgfglyQb7uv4jPcv9VwPqptcFwQwp+5rN0+Znz76uAf3SzHA5yK5cY0/ZKq3MCChdS1rgs7KOelHi94XSQE/In3B7RlxVy2JpDfBoqV5JFSO240gztQB3tp4Xyhu5YtFBBZjmiG1OleNRJ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DuHdLxnK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7621F000E9;
	Wed, 20 May 2026 17:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298320;
	bh=ap5Asy32MEEDtMb2kJInU7P/m4jgGMSrp/tProoaP9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DuHdLxnKF+TjWRHdSxLkWcPa6TSsuwZV4Z1HEPOTaTBU0O4qKtlwzz/Y21zA80Z73
	 x5rcniDtzxuk+kQCj86wVyStSGfPWppnH3fWachcXhHyt7CRzi5aQUIt8eBtctHmuv
	 iHUedmM33dDlndUYxhrpZeEDwE/BVlfTNrwuAh+U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 367/957] arm64: dts: rockchip: Make Jaguar PCIe-refclk pin use pull-up config
Date: Wed, 20 May 2026 18:14:10 +0200
Message-ID: <20260520162142.487713200@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251569-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sntech.de:email,rock-chips.com:email]
X-Rspamd-Queue-Id: 02778594FDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Stuebner <heiko.stuebner@cherry.de>

[ Upstream commit f45d4356feeba1c8dac3414b688f59292ddfc9f9 ]

The hardware PU/PD config of the pin after reset is to pull-up and on
Jaguar this will also keep the device in reset until the driver actually
enables the pin. So restore this boot pull-up config of the pin on Jaguar
instead of setting it to pull-none.

Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
Fixes: 0ec7e1096332 ("arm64: dts: rockchip: add PCIe3 support on rk3588-jaguar")
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Link: https://patch.msgid.link/20260210080303.680403-5-heiko@sntech.de
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
index 176925d0a1a80..557158093b586 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
@@ -585,7 +585,7 @@ led1_pin: led1-pin {
 
 	pcie30x4 {
 		pcie30x4_clkreqn_m0: pcie30x4-clkreqn-m0 {
-			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 
 		pcie30x4_perstn_m0: pcie30x4-perstn-m0 {
-- 
2.53.0




