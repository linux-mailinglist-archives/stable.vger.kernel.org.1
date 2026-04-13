Return-Path: <stable+bounces-236126-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCYlDxwG3WkZZAkAu9opvQ
	(envelope-from <stable+bounces-236126-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:05:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8680D3EDAD9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8ECD308E1A6
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8188E3B892D;
	Mon, 13 Apr 2026 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUstMKA9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460983B3C18
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092291; cv=none; b=E3aDY+rv5QJKD1nby6CBDW0bNi4LhROACopqnow9dn+gzaZb2dO7n1ReIaZ681v8vLc0Q6VBpDe8JBjpVIlvYAKdYW9RD6oJiyzzLLP7abAC0Q4+K99aBC3Gel7cMepp5Yq5y5IpceHQP+TR9TDw5Y14bErUcGlZgS5ebbc+AAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092291; c=relaxed/simple;
	bh=IWNA2PiUP0RRHe3/WeMmJrO8/t801asoq7J0PLEDbnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kiqUMz01oGWC/ciVNkPf5p9et9PLX05HnDNA3PCDjDed+FdJbjJ70/1/RXk2Z7/tARXjMd4otABTJ7OeuCED2PeMBhb+pnUevKHtrLDZqpBE+XZhFY7zOMx+YPPQ35mYbLsDnsRdmVpJGIKUBk3p85XWlm9uVsaEUtOZ+ajwtJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUstMKA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B10C2BCAF;
	Mon, 13 Apr 2026 14:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776092291;
	bh=IWNA2PiUP0RRHe3/WeMmJrO8/t801asoq7J0PLEDbnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KUstMKA94Likal7McMr5Q7v/XmKzcbBz3TVpC96LTQig2heIdeij1CNwGImqBWGpJ
	 AaWXYvoUjQ0lTEE7e0OLw2PAaSJqDarhVLYDUDIdPXGmkIG2g5sZL/kcuHwLfqm+Fl
	 Y2F8TSj9hHFUN246ohsQvlWZqGmLmLnNfa27eKc/wI0Mype6TYlIw/fUeVXK41OuQz
	 PenycH1gW0iJ83AaO2t6cG+zru0zhkyOo1SxfEaXTP0EMFRRLcxNea4uJJS+p4u7GE
	 /oQZHTFyvkk2zPC4gt+4RtPE6lutMvEaLncZAD9thcPny9nAauFLQeEjN9g2tw76GJ
	 phhS8av8VP1XA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Frank Li <Frank.Li@nxp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 7/7] arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage up to 0.85V
Date: Mon, 13 Apr 2026 10:58:04 -0400
Message-ID: <20260413145804.2968471-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413145804.2968471-1-sashal@kernel.org>
References: <2026041310-reluctant-amaretto-6070@gregkh>
 <20260413145804.2968471-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236126-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,puri.sm:email,nxp.com:email]
X-Rspamd-Queue-Id: 8680D3EDAD9
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
index 251504dba3f04..6e8d041dc4b80 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -653,7 +653,7 @@ buck1_reg: BUCK1 {
 				regulator-ramp-delay = <1250>;
 				rohm,dvs-run-voltage = <900000>;
 				rohm,dvs-idle-voltage = <850000>;
-				rohm,dvs-suspend-voltage = <810000>;
+				rohm,dvs-suspend-voltage = <850000>;
 				regulator-always-on;
 			};
 
-- 
2.53.0


