Return-Path: <stable+bounces-68871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA005953468
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F411F291D9
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F801A706A;
	Thu, 15 Aug 2024 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nUxPn6xG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4000A1A2C0F;
	Thu, 15 Aug 2024 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731929; cv=none; b=Oy09hzWThQc4rLcFXHnVDCfMtLGywQ6lYf+l+GnO5MDxCbKoM9cEPO4V4CX38oeonORWjv1ELpZz5PXCXIILyJiFgYcbv04fXe61k324VkqQQihCG4SZhxYjkdFoZk0hKgX4HB8MvaZoeIHcWAEkpr8iWjGUKfHCHHdToItOoA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731929; c=relaxed/simple;
	bh=KfTUHRs8j5ih86fBZuRAAuKdaOUmHYgK9P6NaD+c8do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/83h2feySLGXyE2CbHDT1Aw6Ck3vd3RK7s7noeCYAuXrPC8uHQ3rZBGfStZ9Wfd6TMe9zz8us8FEk2rlWwNnQBaQxPA2YBEJBklCbYGcpdDbtt2CvPvfHR/fQEJ00hIvUAlM4KtrAfpUBHul3/J36bpTgP70tkd/jmk0gUhD5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nUxPn6xG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F75C32786;
	Thu, 15 Aug 2024 14:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731929;
	bh=KfTUHRs8j5ih86fBZuRAAuKdaOUmHYgK9P6NaD+c8do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nUxPn6xGVzYh2VoFzZAXF1e59nNDzBBxWidYjinAJHhvwIYeaj6Qnx4oU+eZJfUDL
	 xVOpuLWzAk3EgBkl57o8ezJV9sWV6Wgh6pVWfY+YiMAxMdNzAfJNzDjRi8jWrjjIIE
	 y/eNa0uMPkAJeYRnp6CO0JtCZUbAvnrfveZzn/D8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Walle <mwalle@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 022/352] ARM: dts: imx6qdl-kontron-samx6i: fix board reset
Date: Thu, 15 Aug 2024 15:21:28 +0200
Message-ID: <20240815131920.075557611@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131919.196120297@linuxfoundation.org>
References: <20240815131919.196120297@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Walle <mwalle@kernel.org>

[ Upstream commit b972d6b3b46345023aee56a95df8e2c137aa4ee4 ]

On i.MX6 the board is reset by the watchdog. But in turn to do a
complete board reset, we have to assert the WDOG_B output which is
routed also to the CPLD which then do a complete power-cycle of the
board.

Fixes: 2125212785c9 ("ARM: dts: imx6qdl-kontron-samx6i: add Kontron SMARC SoM Support")
Signed-off-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi
index cf001c251fe37..8eda848e9f0e8 100644
--- a/arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi
@@ -813,5 +813,6 @@ &wdog1 {
 	/* CPLD is feeded by watchdog (hardwired) */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_wdog1>;
+	fsl,ext-reset-output;
 	status = "okay";
 };
-- 
2.43.0




