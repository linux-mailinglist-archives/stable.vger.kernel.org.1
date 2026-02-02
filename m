Return-Path: <stable+bounces-213048-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH0xMdt9gGnE8wIAu9opvQ
	(envelope-from <stable+bounces-213048-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 11:35:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9C6CB0B7
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 11:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 736213064F26
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 10:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477DB2BE7BB;
	Mon,  2 Feb 2026 10:27:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E95533A6ED
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770028073; cv=none; b=Hmz0F7bCE03rXYPqopdFl69VK6qemHvMiKZSFLcFXfD8bj0GcygvXdfD7tUIb9KO+6bzMKnr+0AThTPJhJOV4RnTgxNcP/ZEFs2j7UPmarSdaGkJIegUcLnbmLWZVqy8bgjLQaCnE2IOPibFchXvp9JnXwmvixAwconO2ffEpC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770028073; c=relaxed/simple;
	bh=ICwMGryFunsZELBhig/u81PV/a50m1eW3wfstcBgRZo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kyx09TwdFbiuvGhXaIBMQ/RjKrZ3EueewVdAyLSan9aazjFXGThJP3W3SWU1Asq00sKO7fjHxfKqoGdI3sm9FSOY2G2KYDRHgxQ4rLLvHhVZleJmOdConIsRUXXwdfoxNRxK2F/Nsk5a//5FAHLLt2bRVn1To6dmf8LdqsGfxTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4f4N986l7Yz8n0;
	Mon,  2 Feb 2026 11:27:40 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4f4N98059bz5sw;
	Mon,  2 Feb 2026 11:27:39 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH 0/2] arm64: dts: rockchip: fix Ethernet PHY on Theobroma
 PX30 devices
Date: Mon, 02 Feb 2026 11:27:24 +0100
Message-Id: <20260202-px30-eth-phy-v1-0-ef365be64922@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvyJ7TnANLPpKdJBacy8mGmGIf0+6D
 MxhpkKmxJRhERUSPZz5Cl1wELB7G06SfHQHrbRROCoZSwfdXkb/SjMZZ3FGQjTQk5jIcfl369b
 aB+vsMXheAAAA
X-Change-ID: 20260130-px30-eth-phy-676fa181e116
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Heiko Stuebner <heiko.stuebner@cherry.de>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[0leil.net];
	FROM_NEQ_ENVFROM(0.00)[foss@0leil.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-213048-lists,stable=lfdr.de,kernel];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cherry.de:mid,cherry.de:email]
X-Rspamd-Queue-Id: ED9C6CB0B7
X-Rspamd-Action: no action

This removes the reliance on the bootloader setting up the Ethernet PHY
for the Linux kernel to be able to use Ethernet.

This is due to the HW default of the PHY reset line being active and the
MDIO auto-detection mechanism not controlling a PHY's reset line such
that we need to hardcode the PHY ID in the compatible property for it to
be usable by the kernel, regardless of what the bootloader is doing.

We only ever had one PHY (DP83825) for both devices, so it's fine to
hardcode this way.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (2):
      arm64: dts: rockchip: fix Ethernet PHY not found on PX30 Cobra
      arm64: dts: rockchip: fix Ethernet PHY not found on PX30 Ringneck

 arch/arm64/boot/dts/rockchip/px30-cobra.dtsi    | 2 +-
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 4d310797262f0ddf129e76c2aad2b950adaf1fda
change-id: 20260130-px30-eth-phy-676fa181e116

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


