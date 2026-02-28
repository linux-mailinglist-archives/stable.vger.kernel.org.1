Return-Path: <stable+bounces-220686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFTnKFI/o2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:17:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D3C1C6C9E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00EC930C7A51
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B5F3F7B35;
	Sat, 28 Feb 2026 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6EJdq9r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130C73F7B2D;
	Sat, 28 Feb 2026 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300567; cv=none; b=O72tjZVnXUp+661aaVAwzr8O9iODV0aFcyjfPvExZ69EBOniZKIaw05tQHEWlVnHZxFlAvzBCZZIz1M1sJC1h9SuBI0Z70egsJsjyx/94JLyFPmF0jkTIVsRiGMT0ciQlhjeXqzb6SQJV+X2xqk6UHUV41J+UTBaVX6wNyUPxSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300567; c=relaxed/simple;
	bh=Zw7Fg1lIRwec7hh2wkmhaWdAesRtBhhfWAnFdWCw2CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d83/IGog4zzHxPicXT0jTnEX8vl8A2bJK5NShaOn2EjgyopzAXhwSztpAiYvohP4t7bkZ/cO7lg7ht3//NNsCF4/54g/eSHls+JdLOaAP6zgOAgo9+iYdHOi5+WW8ZMcioDbESJFbbTwzNPA1cFhLdPJOZQ8eNQt790j3D7+sEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6EJdq9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DB7C116D0;
	Sat, 28 Feb 2026 17:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300567;
	bh=Zw7Fg1lIRwec7hh2wkmhaWdAesRtBhhfWAnFdWCw2CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d6EJdq9rohut0n/C+7VkMcw22t9Ov58jZRheRrZzjs9MJ+RAzTzaWNy5hYf2AK9xd
	 2nPru/Rc6yDkjSpHQYiM0f7+2LA7hqBFcrNb1trzNTURxfJmAZrOdZ5XNbLOc9TFQ1
	 fnmZYe3tli98ZxH8kSCVzOA6YwhhZL3LqdEWlUikD4WWUK3M5owSBHXlux1bX6udMB
	 3ZVvIou0rQSSl+9b2BvDXSZnb4CRhWT/wc4j3kcEqJiwC48XUNZBlAsC1cghhVv6/T
	 kLPBWp62rFtomjLht5c8ckU2Z8REA+qSoA04TiLYEBeLh3iOkMtlzL0W6aO/iobWp9
	 qwkF493IAEDuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vitor Soares <vitor.soares@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 607/844] arm64: dts: ti: k3-am69-aquila-clover: Change main_spi2 CS0 to GPIO mode
Date: Sat, 28 Feb 2026 12:28:40 -0500
Message-ID: <20260228173244.1509663-608-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-220686-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,toradex.com:email]
X-Rspamd-Queue-Id: 45D3C1C6C9E
X-Rspamd-Action: no action

From: Vitor Soares <vitor.soares@toradex.com>

[ Upstream commit 319fff9c7d620af83d8ab67050a54f63f16ae4e8 ]

Change CS0 from hardware chip select to GPIO-based chip select to
align with the base aquila device tree configuration.

Fixes: 9f748a6177e1 ("arm64: dts: ti: am69-aquila: Add Clover")
Cc: stable@vger.kernel.org
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Link: https://patch.msgid.link/20260112175350.79270-3-ivitro@gmail.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts b/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts
index c816ba3bfbdf7..ec8ff45877157 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts
@@ -208,7 +208,8 @@ &main_spi2 {
 	pinctrl-0 = <&pinctrl_main_spi2>,
 		    <&pinctrl_main_spi2_cs0>,
 		    <&pinctrl_gpio_05>;
-	cs-gpios = <0>, <&wkup_gpio0 29 GPIO_ACTIVE_LOW>;
+	cs-gpios = <&main_gpio0 39 GPIO_ACTIVE_LOW>,
+		   <&wkup_gpio0 29 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
 	tpm@1 {
-- 
2.51.0


