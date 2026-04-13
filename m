Return-Path: <stable+bounces-236111-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LhxOED83Gk3YwkAu9opvQ
	(envelope-from <stable+bounces-236111-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:22:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B7B3ED469
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13309300B1AF
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3013DC4C6;
	Mon, 13 Apr 2026 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0hFe6y5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1023DBD62
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090062; cv=none; b=gYEwDK2XL9NOJ0Unb5up1E0E3xZIU+p7/A1L4b532nz2Mmg47JXjXjLzvOGkLbQ+9YTzkA2VandwrTC/AGv8H5zXKBQ62YwZfD6aOmi8v9hbxAdphDBzG8cS7WgGK4vPtc4HPw7pW/Dk71oiZ7vU3A9wbOduuTCrVZdAVHBvUlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090062; c=relaxed/simple;
	bh=DL+qgMpqrNBcC8T2TIy2qejATeHz3c+HBUUA09Kxszg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UuQ59bR23K1uxEmtFYr+MA2J91qjXcn34fTm9IlnP3WygqDcb7DciF9G4TprZT0J7q+MMwYdAVSUmpcXJtnrtVqSCiVGx7ndAMqcy1446BpL+VaCcIGP+sTnzox/Qh8xWuoR8X9/Uq4x94CSfTrcJrpIV7heRQLto7RuRhdBtAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0hFe6y5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E834C2BCB5;
	Mon, 13 Apr 2026 14:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776090062;
	bh=DL+qgMpqrNBcC8T2TIy2qejATeHz3c+HBUUA09Kxszg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D0hFe6y5YCM0E8pUVOdg5kLUEvhM0+2u4+y5OHK4OiZ+Dsn2ay5gZhT8h2dZIT+ku
	 +PFYy0FkkKwzOm+vMX77UGDSw5lqZaHHQhiHmvAg//a0vtM6gPgU04+UI3GKvPbPpG
	 jVDw2WAuKp+pHjBVyH8QyQ2jQ5DaF78/M3VLPOJNdtbhPBWoMswb9F3vYFwELDTbuw
	 +NYouLY0x/SISWiEg1x0UDBeN7hiSNFd9Ll4NAxBk/Pvldqh10rLsCRGFgwEC8FEk+
	 7mJtfhcwrGRR/E692Ahs2efGaY4etTHlrZd+9rVLmA7FvjN09SD46hnG/7wOprzLbb
	 E0vJG5a+uTqCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage up to 0.85V
Date: Mon, 13 Apr 2026 10:20:57 -0400
Message-ID: <20260413142057.2909222-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413142057.2909222-1-sashal@kernel.org>
References: <2026041309-growing-ground-4131@gregkh>
 <20260413142057.2909222-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236111-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[puri.sm:email]
X-Rspamd-Queue-Id: 95B7B3ED469
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

[ Upstream commit 511f76bf1dce5acf8907b65a7d1bc8f7e7c0d637 ]

The minimal voltage of VDD_SOC sourced from BUCK1 is 0.81V, which
is the currently set value. However, BD71837 only guarantees accuracy
of ±0.01V, and this still doesn't factor other reasons for actual
voltage to slightly drop in, resulting in the possibility of running
out of the operational range.

Bump the voltage up to 0.85V, which should give enough headroom.

Cc: stable@vger.kernel.org
Fixes: 8f0216b006e5 ("arm64: dts: Add a device tree for the Librem 5 phone")
Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index ce63d5ef67665..2260ae8dc1a23 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -706,7 +706,7 @@ buck1_reg: BUCK1 {
 				regulator-ramp-delay = <1250>;
 				rohm,dvs-run-voltage = <900000>;
 				rohm,dvs-idle-voltage = <850000>;
-				rohm,dvs-suspend-voltage = <810000>;
+				rohm,dvs-suspend-voltage = <850000>;
 				regulator-always-on;
 			};
 
-- 
2.53.0


