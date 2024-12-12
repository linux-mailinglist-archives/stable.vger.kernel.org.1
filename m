Return-Path: <stable+bounces-103513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8299EF867
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B9617974F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C83222D67;
	Thu, 12 Dec 2024 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0Vc2jy2h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B233F2153DD;
	Thu, 12 Dec 2024 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024798; cv=none; b=hEVQXurTrBZ2xJspwOk/QcESi+B1Bzw3RZMBAgn6DI2Ca+q+0x1SD4FOdYn1Yiy7PDVTjixQqIOcdKZwmLPfLhtonGOFSILLHFoYj93m8EoJgymYETa2d0tbPNhsozkmM7cxUHSYku4f9DLQby26tLJr70rIQEMZI9bPyq/XfDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024798; c=relaxed/simple;
	bh=x86PpJSB4ksdHmHCZ7A46kyKbceh235Z5xFxEsKz1sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/5hLLRoP7pBp83WLXzkcB0LlRa+5QvZoctVBEb0xL1qXdsOYn9NEe8iVTodRzel4vacg0SawpaBU/i8BlMypjKtTiSCodirFFLCEyxURCRIvM/nG2UOK78u+XKHwRWzYvl+WZZ6OmF2R/WkbHf2Ygp6rXxMUZqayt735s5s6Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0Vc2jy2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB44BC4CECE;
	Thu, 12 Dec 2024 17:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024796;
	bh=x86PpJSB4ksdHmHCZ7A46kyKbceh235Z5xFxEsKz1sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0Vc2jy2hHlZAXdU1PpxjCPDX/fn9tiVYpWQb5VPUjyzTby/XMphbpFVjoTTOuIW5I
	 IPxbbrq3dv79OOAeCq70IDIQE5URx+16YUAZAN1+QtZ0pIcc2D2IOLov4gXoDxoGSV
	 ZzBxgz6zDVmgddSC59wI2ioASL/Ar4WigNC59QUk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 385/459] drm/vc4: hvs: Set AXI panic modes for the HVS
Date: Thu, 12 Dec 2024 16:02:03 +0100
Message-ID: <20241212144308.978398096@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

[ Upstream commit 014eccc9da7bfc76a3107fceea37dd60f1d63630 ]

The HVS can change AXI request mode based on how full the COB
FIFOs are.
Until now the vc4 driver has been relying on the firmware to
have set these to sensible values.

With HVS channel 2 now being used for live video, change the
panic mode for all channels to be explicitly set by the driver,
and the same for all channels.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240621152055.4180873-7-dave.stevenson@raspberrypi.com
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index f8f2fc3d15f73..64a02e29b7cb1 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -688,6 +688,17 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
 	dispctrl |= VC4_SET_FIELD(2, SCALER_DISPCTRL_PANIC1);
 	dispctrl |= VC4_SET_FIELD(2, SCALER_DISPCTRL_PANIC2);
 
+	/* Set AXI panic mode.
+	 * VC4 panics when < 2 lines in FIFO.
+	 * VC5 panics when less than 1 line in the FIFO.
+	 */
+	dispctrl &= ~(SCALER_DISPCTRL_PANIC0_MASK |
+		      SCALER_DISPCTRL_PANIC1_MASK |
+		      SCALER_DISPCTRL_PANIC2_MASK);
+	dispctrl |= VC4_SET_FIELD(2, SCALER_DISPCTRL_PANIC0);
+	dispctrl |= VC4_SET_FIELD(2, SCALER_DISPCTRL_PANIC1);
+	dispctrl |= VC4_SET_FIELD(2, SCALER_DISPCTRL_PANIC2);
+
 	HVS_WRITE(SCALER_DISPCTRL, dispctrl);
 
 	ret = devm_request_irq(dev, platform_get_irq(pdev, 0),
-- 
2.43.0




