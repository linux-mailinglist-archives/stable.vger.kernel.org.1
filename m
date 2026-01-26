Return-Path: <stable+bounces-211649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPRLFMKUd2n0iwEAu9opvQ
	(envelope-from <stable+bounces-211649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 17:22:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED8F8A9D7
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 17:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84504300B449
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3840828DB54;
	Mon, 26 Jan 2026 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdluDn/Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F119C228CB8
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769444496; cv=none; b=HIz6w11xjLYyMGlLoEWZhRqQu7+gxCNHA2pWNHkkDWaDMyFsCFxmU7/V0iEtqTVKCiheAtObgV7+b7xCmTU6rgJ6++oEW22u0XU1AbefDhkhNyqdskgw1UnCPekKVJ/8zbR3+q3btPJV9EDLnVGDNCr70fHyGTqR3S7MBe3MV2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769444496; c=relaxed/simple;
	bh=lLIz66mX9WQl/fHtawncy3kwY2ZgSqcEtte6NU8M8k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4xr5jwXVUcBzgv5RaLc48GwWP4vbJSEU4mI1RaR0ZRhcSxxGFco5H4i45bxdhL1u3vcek3R2Ek0+pCpIqjoWPlGsgHT8J/Yr0Hayf/F9EWxTcS57snIZ5rEwUeVLFJxuX+FbAIclmM6mIvQET0QH0j2Hy5tehxIeO+KxnfZOgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdluDn/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4356C116C6;
	Mon, 26 Jan 2026 16:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769444495;
	bh=lLIz66mX9WQl/fHtawncy3kwY2ZgSqcEtte6NU8M8k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NdluDn/QY7T5sY7O+tSk/y1EX3H1LjYooktg+p/AbUBKUX0JXPDTFpercL1TZsImz
	 7Fsq7XI3FiDeraPmIPYlEmVnHRgowOC0kJxPBYkWb5no0DyFl6nxLsip1UAhMgMvPQ
	 xtm23AC5YLB5HXxyKp/NEO2Pxx/z2YRS9mJ9zLg0e+Mzij+2YOHYxszdOMoAScI9Rj
	 ABW6HNZRZalyHH+xkknsOVaMIfkEM5fW9PeHureTGjvbWSB+fmAjD9bmTveqD/y5zd
	 X8ACl77fhjPHuTvZNhOj8pyUMuzEznkk7q9/i4bDADpVA8WfTzQbU8MLLQ2k9ts7h4
	 UjxtEPxS0wHuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Geraldo Nascimento <geraldogabriel@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] arm64: dts: rockchip: remove redundant max-link-speed from nanopi-r4s
Date: Mon, 26 Jan 2026 11:21:33 -0500
Message-ID: <20260126162133.3376453-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012623-turban-vanish-b9f4@gregkh>
References: <2026012623-turban-vanish-b9f4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,manjaro.org,rock-chips.com,sntech.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211649-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rock-chips.com:email,sntech.de:email,manjaro.org:email,msgid.link:url]
X-Rspamd-Queue-Id: 9ED8F8A9D7
X-Rspamd-Action: no action

From: Geraldo Nascimento <geraldogabriel@gmail.com>

[ Upstream commit ce652c98a7bfa0b7c675ef5cd85c44c186db96af ]

This is already the default in rk3399-base.dtsi, remove redundant
declaration from rk3399-nanopi-r4s.dtsi.

Fixes: db792e9adbf8 ("rockchip: rk3399: Add support for FriendlyARM NanoPi R4S")
Cc: stable@vger.kernel.org
Reported-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
Link: https://patch.msgid.link/6694456a735844177c897581f785cc00c064c7d1.1763415706.git.geraldogabriel@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
[ adapted file path from rk3399-nanopi-r4s.dtsi to rk3399-nanopi-r4s.dts ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
index 6a6b36c36ce21..0a55aa44effe1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
@@ -73,7 +73,6 @@ &i2c4 {
 };
 
 &pcie0 {
-	max-link-speed = <1>;
 	num-lanes = <1>;
 	vpcie3v3-supply = <&vcc3v3_sys>;
 };
-- 
2.51.0


