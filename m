Return-Path: <stable+bounces-53837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978C490EA24
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF572825EB
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0C713DDAE;
	Wed, 19 Jun 2024 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="J9rCWZ5g";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="bC00VQxP"
X-Original-To: stable@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6151137747;
	Wed, 19 Jun 2024 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798181; cv=none; b=qe5YaS8ScEqXU0J5J3iVazVEmgTXlhkmrPhqNzgtIGtlGaadzJoAap0+k2JOYEi4sK1/Vblk9A+Z6S+iyt28o+QRjKP81Zfbg2J7Mc5ur7Yxg3vDnA6ilN5OyBTVHepa03okA5QXBZ5t8dnniH2chBx+UhcfiLkkSUxhkvB7mAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798181; c=relaxed/simple;
	bh=vNlqdyqa9MfOvISLpNehM2+w4OXrnK6P7mGk6acSEfE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NkWyDgf28P1NZZE3jxERdgE3EoBg9p9hDMBKBA1rqANCo8x7NNfDXlIEvb9kQaH8IkxqyFjy+gPE4CTzVVUI3m6xE50wyVg7sprmm1UeUiQeeQURf2SwgG3+rp/C7KZTLETIVckgTYQsncikwx0YdPO0wVqem/L+67m1xV57l5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=J9rCWZ5g; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=bC00VQxP reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718798179; x=1750334179;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+lWn1KtMeGuGAa+FVSQruLojNNK9iYkcG7UCHgu3G/w=;
  b=J9rCWZ5gd9Gc46sKWkv0yACZgHEXu99u3nnS46INtfX3D9ovl2PkBZQy
   pZ+GmPhjRBgoMnmZpEHQzrIxVhBlTAazWRpEU3V8AUKRNQ9bAOYdB1Q64
   tO6QoHF+ZPicahJnN3Ne8RK1b55T08pRSY8GUnn4F4HmurClNIde86oib
   vDx9lBa0BUMfsPDZQLb/czDtmuf39FjZ83p5z3v7CaOw8DBjGsvCPg/WV
   kaWpT5B7UVFQSEV+1p2TonCZOl/4WfBZERKEDgriccYwRo5wocmqn8PBT
   G8KE+/poLxMgcLx63BwvFhzG4sS46b0w4vzUUjNVrwWBcyRGUlePwBLPm
   A==;
X-CSE-ConnectionGUID: ep4LqlfCT9yhsl/RnvAKtQ==
X-CSE-MsgGUID: UMnrp/tGQROlJerEq8BtrQ==
X-IronPort-AV: E=Sophos;i="6.08,250,1712613600"; 
   d="scan'208";a="37475541"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Jun 2024 13:56:16 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E239161456;
	Wed, 19 Jun 2024 13:56:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718798172; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=+lWn1KtMeGuGAa+FVSQruLojNNK9iYkcG7UCHgu3G/w=;
	b=bC00VQxPw2/s1LjYTjh5PO+eI8IUP84VmxjAXDKmdwxTvJuzLh/4xeuMMQuw4rUQZ/qPSq
	k/MBMKZGWi6v1Tl06PORk5NKIsrg6Yi6PVynrhqCrD2h88nx8ZQ/vkLC+SebD0M3BJvTtb
	eiQxdOhvoz7CSgkz7TBDRkDukgHYWntI8gsbfJu4yv3UqYlaZlcEguf6Y6AEPD5xSZOKcp
	Rq5n8xuebCoN7fAPk2Il2DCIIDoSZ0E9hc+nj+zKvDOjKAgJcC54R6v09UTHNerbNX2pHN
	SsucbR2m+QyWyr+p02pI72TLou8jqQv1ezNwI+asTC66gWqXub/1wVzZ6kN4RQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Lee Jones <lee@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 resend] MAINTAINERS: Fix 32-bit i.MX platform paths
Date: Wed, 19 Jun 2024 13:56:10 +0200
Message-Id: <20240619115610.2045421-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The original patch was created way before the .dts movement on arch/arm.
But it was patch merged after the .dts reorganization. Fix the arch/arm
paths accordingly.

Fixes: 7564efb37346a ("MAINTAINERS: Add entry for TQ-Systems device trees and drivers")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c36d72143b995..762e97653aa3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22930,9 +22930,9 @@ TQ SYSTEMS BOARD & DRIVER SUPPORT
 L:	linux@ew.tq-group.com
 S:	Supported
 W:	https://www.tq-group.com/en/products/tq-embedded/
-F:	arch/arm/boot/dts/imx*mba*.dts*
-F:	arch/arm/boot/dts/imx*tqma*.dts*
-F:	arch/arm/boot/dts/mba*.dtsi
+F:	arch/arm/boot/dts/nxp/imx/imx*mba*.dts*
+F:	arch/arm/boot/dts/nxp/imx/imx*tqma*.dts*
+F:	arch/arm/boot/dts/nxp/imx/mba*.dtsi
 F:	arch/arm64/boot/dts/freescale/fsl-*tqml*.dts*
 F:	arch/arm64/boot/dts/freescale/imx*mba*.dts*
 F:	arch/arm64/boot/dts/freescale/imx*tqma*.dts*
-- 
2.34.1


