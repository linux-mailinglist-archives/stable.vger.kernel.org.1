Return-Path: <stable+bounces-251597-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCLVF232DWry4wUAu9opvQ
	(envelope-from <stable+bounces-251597-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:59:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A01F59507E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24CC130FD0D5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0355359A6F;
	Wed, 20 May 2026 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hbmSx5La"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D806369D67;
	Wed, 20 May 2026 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298395; cv=none; b=jvSaSzY1Ts4McIguivGy89KI75R9gfFXQHOZW1P6++1t9t7y/jZ5aSvRnV56vA6agYFwe7giRxcHADfFxp5MtVz4zIZXsVt4xX2kjuxtIYOEuXCIJEZeF0cwyplTqkB6VIYd7czZJbaVg3GpF3K2VFIgnXsXuIbsrE6MKk3xAlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298395; c=relaxed/simple;
	bh=7yNiLhe2PRS4TPNI+qRyPAfZ85t/fsa9NJ7sFdYpTQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jOj9WFNDu86o3je2lmLsYjKwHHgigDmLxTTZuMGcnC0WD20krOGnabjkMXKVtssGRarpWliNV8BwoIl6SbV+vlTi/Pd6Xb3zN0kucju2mFH5zWY71QLdqsSocSP9p7zrHpz5JrN++sG4yzZBLknIbSrkcTZ9Rxk24S/0OAff/E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hbmSx5La; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37681F000E9;
	Wed, 20 May 2026 17:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298394;
	bh=W4lce2/IFuNypEsc47zB8viRUw8DoDvAt8ekf+GJZT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hbmSx5LaWKXCxF1h3vVaW53EAHCFHwpADkMFVXDzbz6e8D31S+cjVQmvWMDUQWAI9
	 pjoD2rDn+pe14mtOLAABOPkwpbYC/ZgDuyC6VBmNVHuTgB/9JOTyFyeoCPGYXzAkom
	 U0Yq8NA/opJe7Mhqphk0qg8xU7x3Y6cEv2Fbldy8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?=E8=B0=A2=E8=87=B4=E9=82=A6=20 ?= <Yeking@Red54.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 392/957] arm64: dts: rockchip: Fix RK3562 EVB2 model name
Date: Wed, 20 May 2026 18:14:35 +0200
Message-ID: <20260520162143.028951879@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251597-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,sntech.de:email,msgid.link:url,red54.com:email]
X-Rspamd-Queue-Id: 0A01F59507E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>

[ Upstream commit ede6a05606892bab4f6d785ffcfc124150c2eb32 ]

The model name should be "Rockchip RK3562 EVB2 V10 Board".

Fixes: ceb6ef1ea900 ("arm64: dts: rockchip: Add RK3562 evb2 devicetree")
Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
Link: https://patch.msgid.link/tencent_78E7E3F6991FB4403D5ADC9E6A6BC3BF8307@qq.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3562-evb2-v10.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3562-evb2-v10.dts b/arch/arm64/boot/dts/rockchip/rk3562-evb2-v10.dts
index 6a84db154a7d5..387062eea5208 100644
--- a/arch/arm64/boot/dts/rockchip/rk3562-evb2-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3562-evb2-v10.dts
@@ -13,7 +13,7 @@
 #include "rk3562.dtsi"
 
 / {
-	model = "Rockchip RK3562 EVB V20 Board";
+	model = "Rockchip RK3562 EVB2 V10 Board";
 	compatible = "rockchip,rk3562-evb2-v10", "rockchip,rk3562";
 
 	chosen: chosen {
-- 
2.53.0




