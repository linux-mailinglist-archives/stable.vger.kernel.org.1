Return-Path: <stable+bounces-240101-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GliMO5H52kF6QEAu9opvQ
	(envelope-from <stable+bounces-240101-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 11:48:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E06E439103
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 11:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E72E63065797
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125103BAD85;
	Tue, 21 Apr 2026 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b="JHJycwIX"
X-Original-To: stable@vger.kernel.org
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B955E3AEF33
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764734; cv=none; b=qBsW3QdaxE5x34EpZr4q0EjZ52ZwTz7n768WcnY6TZhCb+8vUgAsSs5++rHVPXxsNYrT0Gwr9Ozj5dpIn3Xbdg/FW7sOVJAISow5eb8SZSXIdRuicPRdO4ImPFrtetNgOjhnyD1l1rQMmaycbrqDbXaX1xfBriuBwa4mll72FZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764734; c=relaxed/simple;
	bh=bsijqOyWswuF6NZXlWSly9Z6xtYtxBitACbUnOhzrrc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pAUJaHHhGWr2FwItVmr9jKGE0DBSD+Ofz2UBsY3jmknMBtlI7C31KcbM5TfK6+SA/BMhW9kbRPn2+zgoCbSJpOWscr0+gNaw75PrufE3okaHQmuj4aFXutQZWLRuc82RLOPAqIZCr4X97fXiMpgcqQB1OffMPZ03fCnlE7mXbvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b=JHJycwIX; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g0HXL1FVbzZgZ;
	Tue, 21 Apr 2026 11:45:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1776764721;
	bh=kIVgKNfgffVMWOXygW28hZLiTs45qb7bepzWyDmIFWE=;
	h=From:Subject:Date:To:Cc:From;
	b=JHJycwIXX42FlfTd+u4A59doxw/P/8wi7aixczLnYwx8rPbJEKMk/ee5UOgb/sfM+
	 HcRSNQebL02r9z6JsNllBFBpeBJyMq2AZ5ynFjou5Y9z4RaTM/lFkZiFj54HuEALDe
	 4Cza9BPIM13DNIE3MIK/nhcc9GaX2v9pZxGnh0dhX8+Z7KlqfqKKFao3WGRibTujCN
	 BX2C/BDJt7qsImvlfW48kUJQGIOiIOTyUpke7j7ecN9ybKR+VyCby6YH5V8M3gTUwP
	 57PLkL1Fb9m+mBUcmMGB+UNQxAXd95vcurSXc7KaeEiI/AvFxditWLZiQU41mM4jl+
	 bn95jv4y4u28g==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4g0HXH6wHbzZxF;
	Tue, 21 Apr 2026 11:45:19 +0200 (CEST)
From: Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH v2 0/2] arm64: dts: rockchip: fix Ethernet PHY on Theobroma
 PX30 devices
Date: Tue, 21 Apr 2026 11:45:04 +0200
Message-Id: <20260421-px30-eth-phy-v2-0-68c375b120fd@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WMOw7CMBAFrxJtjZHXgeVTcQ+UIiRr7Cax7MiKF
 fnuLKGiGWme9GaDxNFzgnuzQeTsk58nEXNoYHD99GblR3Ew2pDGVquwCnhxKrii6EK2xysyIoF
 cQmTr1z337MSdT8scy17P+F1/IcF/KKMSsS2dX0ynmzGPwXGM5TgydLXWD6P5EimoAAAA
X-Change-ID: 20260130-px30-eth-phy-676fa181e116
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko.stuebner@cherry.de>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[0leil.net,reject];
	R_DKIM_ALLOW(-0.20)[0leil.net:s=20231125];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240101-lists,stable=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[0leil.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[foss@0leil.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,cherry.de:mid,cherry.de:email]
X-Rspamd-Queue-Id: 2E06E439103
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This removes the reliance on the bootloader setting up the Ethernet PHY
for the Linux kernel to be able to use Ethernet.

This is due to the HW default of the PHY reset line being active and the
MDIO auto-detection mechanism not controlling a PHY's reset line such
that we need to hardcode the PHY ID in the compatible property for it to
be usable by the kernel, regardless of what the bootloader is doing.

We only ever had one PHY (DP83825) for both devices, so it's fine to
hardcode this way.

As discussed in v1[1][2], even though they suffer from the same
limitation, only the patch for Ringneck is targeted for stable releases.

Ethernet is currently broken if the bootloader is built without Ethernet
support for those two boards. Cobra is a product for which the software
stack can only be replaced or updated by Cherry. Ringneck is a SoM
supported since kernel 6.1, the user is likely going to write their own
bootloader support based on the motherboard they attach the SoM to. They
may disable Ethernet support in the bootloader if they don't need to
(e.g. to reduce the attack surface or have an easier time certifying a
 device when arguing with an audit company).

Ethernet-less bootloader was supported until commit e463625af7f9
("arm64: dts: rockchip: move reset to dedicated eth-phy node on
ringneck") for Ringneck. Because I do not control what our users have
made with Ringneck, and that it used to work before commit e463625af7f9,
the patch fixing the issue on Ringneck is a candidate for backporting to
stable.

Cobra never supported it due to its support in the kernel being added 
with this (unknown at the time) limitation. Moreover, Cherry controls
the whole software stack so this is already patched downstream whenever
required. Therefore, the patch fixing the issue on Cobra is not marked
as a candidate for backporting to stable (but if it ends up being
backported, it's fine as well).

[1] https://lore.kernel.org/linux-rockchip/38452338-6e65-47ad-a696-b90c02ac42f0@lunn.ch/
[2] https://lore.kernel.org/linux-rockchip/b2f12140-ee3d-45bc-864e-d51317c83b8d@cherry.de/

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- removed Cc stable on Cobra's patch,
- Link to v1: https://patch.msgid.link/20260202-px30-eth-phy-v1-0-ef365be64922@cherry.de

---
Quentin Schulz (2):
      arm64: dts: rockchip: fix Ethernet PHY not found on PX30 Cobra
      arm64: dts: rockchip: fix Ethernet PHY not found on PX30 Ringneck

 arch/arm64/boot/dts/rockchip/px30-cobra.dtsi    | 2 +-
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: c1f49dea2b8f335813d3b348fd39117fb8efb428
change-id: 20260130-px30-eth-phy-676fa181e116

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>


