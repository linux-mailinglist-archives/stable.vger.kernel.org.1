Return-Path: <stable+bounces-152482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE5FAD61CF
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF6017E6AA
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11347243968;
	Wed, 11 Jun 2025 21:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CoUP9bxb"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82B121CC5D;
	Wed, 11 Jun 2025 21:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678505; cv=none; b=Ci9Nrb3/ZQgmGOHD0XnhCvtfI8w0AOCmfbS68EGCTPA6X1++J9K3bDD+hqU3kKZX6LAAF9DcE5a1TuEpzMARf9hSapJgOoMkrzY4S9VolRkewFhKytSC5QKvHstlNrMa18U+Lgx4kaCTSUfGWaYukWkqN5OV83ohuxQfePfuG80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678505; c=relaxed/simple;
	bh=XihviUvmfcFQm07eUKUNvugeka6fyRlZ1FLIMhqZAbg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hoeA+DuKD5D8WJDm6I3ChN7skYrtHTXj786QzS12ZdiVED+fc6JVotxa8cODp1KZIlkSCrg/1iKR3qaPDsb+DbI6JAxEGgseoxbGLXYdFH3xkJZ0pnrhEsPy5nO8hFM0UX1jUpWpIMC5aJU/sE7zPzdJ+AVZQ77WvEJuXMlEBgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CoUP9bxb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749678495;
	bh=XihviUvmfcFQm07eUKUNvugeka6fyRlZ1FLIMhqZAbg=;
	h=From:Subject:Date:To:Cc:From;
	b=CoUP9bxbwIrsYYV8XpPTayPg46oAQOhYgeuguZ/ZtGVms0GRmBL/iLyp7KuilDde7
	 4HfJL+F9TDG4yDzlWguz0QIUNESYA48TLa+4WeClgC07DkejVxpvvZfnDvlMASjzY1
	 y5X7SiO3PTB8/wHPbTXmk182McDOp37uTQSxqAl2hb1VgYld3eQppSVXfgnKbkhLdq
	 O1RKpo4fIyXsAKVpex6u3QVaV9d015BRTkzOhL9ApuQgBj5OADU91FR25fvsrCxdqu
	 hmwrWssy9IWAoHj2t4nKLITJpEuSW6NcGszcHXoXp4puXOb8qJisw6KZlxDzDBhmb3
	 P94iu4FiRPY0A==
Received: from localhost (unknown [212.93.144.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 6E74F17E105E;
	Wed, 11 Jun 2025 23:48:15 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 0/3] arm64: dts: rockchip: Fix HDMI output on RK3576
Date: Thu, 12 Jun 2025 00:47:46 +0300
Message-Id: <20250612-rk3576-hdmitx-fix-v1-0-4b11007d8675@collabora.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIL5SWgC/x2MQQqAIBAAvxJ7bmEtUugr0aFyzSWy0Igg/HvSc
 QZmXkgchRP01QuRb0lyhAKqrmDxU1gZxRaGhpqOtFIYt7YzGr3d5XrQyYNMLbnZzmSVgdKdkYv
 +n8OY8wekTPnQYwAAAA==
X-Change-ID: 20250611-rk3576-hdmitx-fix-e030fbdb0d17
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, Andy Yan <andyshrk@163.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.14.2

Since commit c871a311edf0 ("phy: rockchip: samsung-hdptx: Setup TMDS
char rate via phy_configure_opts_hdmi"), the workaround of passing the
PHY rate from DW HDMI QP bridge driver via phy_set_bus_width() became
partially broken, unless the rate adjustment is done as with RK3588,
i.e. by CCF from VOP2.

Attempting to fix this up at PHY level would not only introduce
additional hacks, but it would also fail to adequately resolve the
display issues that are a consequence of the system CRU limitations.

Therefore, let's proceed with the solution already implemented for
RK3588, that is to make use of the HDMI PHY PLL as a more accurate DCLK
source in VOP2.

It's worth noting a follow-up patch is going to drop the hack from the
bridge driver altogether, while switching to HDMI PHY configuration API
for setting up the TMDS character rate.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (3):
      dt-bindings: display: vop2: Add optional PLL clock property for rk3576
      arm64: dts: rockchip: Enable HDMI PHY clk provider on rk3576
      arm64: dts: rockchip: Add HDMI PHY PLL clock source to VOP2 on rk3576

 .../bindings/display/rockchip/rockchip-vop2.yaml   | 56 +++++++++++++++++-----
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           |  7 ++-
 2 files changed, 49 insertions(+), 14 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250611-rk3576-hdmitx-fix-e030fbdb0d17


