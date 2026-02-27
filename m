Return-Path: <stable+bounces-219924-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGGTBnlGoWkirwQAu9opvQ
	(envelope-from <stable+bounces-219924-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 08:23:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF29D1B3CDB
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 08:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0FB8311FFB8
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 07:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88FF3382E6;
	Fri, 27 Feb 2026 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvZmSE6t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1A529B8C7;
	Fri, 27 Feb 2026 07:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176830; cv=none; b=eJp9F422JzWFp7vyPvo7MuHI/b0rlwKWWQiIl4YwWS6AeIMe0QAWmgECndEnZEwng9vTkdRno+5puQhJ/euF4DDefPZvPJ3kujm/CZqzdMNuI1y9UgiBRF72PBtEgm9OfBnvZv/q2Kq4KJPv84sxXLRMSSZeIYq+sFkpj6RaMpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176830; c=relaxed/simple;
	bh=5LqXlDaWAq/8TXIbV3fX9rXHaDbI2PpJbWwGZMlzwgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OOjlTsmFPfU17giXVLWeL/H4PuTzQRlOBwgtOwYnhHNDGhTK5SMpEuioh/MWBrU6jNkqI22n+TyRmjewSvQRIpM0atS+QQuA6olSvKs2aKiGB/XCsiWsNKfyKazJ5RRosqOSNaORLvFFj3lH5CKOQ5IG0LqmQnNHVTNdErNirmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvZmSE6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A373C116C6;
	Fri, 27 Feb 2026 07:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772176830;
	bh=5LqXlDaWAq/8TXIbV3fX9rXHaDbI2PpJbWwGZMlzwgo=;
	h=From:To:Cc:Subject:Date:From;
	b=lvZmSE6tZPcbwCNO9WASZPlQL6JlNsetEr8mr8bhA49BTuArozEnb5Gw3TDsNLIBT
	 FfF3RNroSlpnPD/Gbso4NEhtFacR0EZx1GvEQCm0T00OUFebCaF7knjKu8P2lC29Ps
	 wRI18VYb+AvshyaTXJmnWG22nNi7hLcUyWATIKXD3ciYbCSQkkLJh6/TeLOafqBflw
	 GQp/xVGQkLhmjmvlOybOY2Uwfd4/gn6mZnltDKR/jj3KG/XMSGP13pLb9AtlNsMHTN
	 MDMDZWffexJSr4HWbEz98ZxioRyW2J5xmo0OoGx5QbriBlKAMvowECSLVA+rnU/SFo
	 xPRwOJUVWW6Gg==
From: Shawn Guo <shawnguo@kernel.org>
To: Wei Xu <xuwei5@hisilicon.com>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: hisilicon: poplar: Correct PCIe reset GPIO polarity
Date: Fri, 27 Feb 2026 15:19:58 +0800
Message-ID: <20260227071958.1350024-1-shawnguo@kernel.org>
X-Mailer: git-send-email 2.47.3
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
	TAGGED_FROM(0.00)[bounces-219924-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawnguo@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF29D1B3CDB
X-Rspamd-Action: no action

The PCIe reset GPIO on Poplar is actually active low.  The active high
worked before because kernel driver didn't respect the setting from DT.
This is changed since commit 1d26a55fbeb9 ("PCI: histb: Switch to using
gpiod API"), and thus PCIe on Poplar got brken since then.

Fix the problem by correcting the polarity.

Fixes: 32fa01761bd9 ("arm64: dts: hi3798cv200: enable PCIe support for poplar board")
Cc: stable@vger.kernel.org
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
index 7d370dac4c85..579d55daa7d0 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
@@ -179,7 +179,7 @@ &ohci {
 };
 
 &pcie {
-	reset-gpios = <&gpio4 4 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&gpio4 4 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie>;
 	status = "okay";
 };
-- 
2.47.3


