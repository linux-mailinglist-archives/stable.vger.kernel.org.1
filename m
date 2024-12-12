Return-Path: <stable+bounces-102441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14059EF2E3
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F20F16C7F8
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE278226520;
	Thu, 12 Dec 2024 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cp5pW+CQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B14213E6B;
	Thu, 12 Dec 2024 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021237; cv=none; b=XxHcodI+VBn8kRnMnJMa/X0X1ycCnt/h12A5MElss2ciAbNWD6VTcK2S+LmRcb+ovv2ewXtswBVeI9Hy9uo3qwmw6Tkcxw5y8xpfCqakb2C2XFF49JTcxonLG5OtRhjT8gJrVlG3R9RmxMcBMxY2xI0tDAMLBuurv/WMaXkZ48U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021237; c=relaxed/simple;
	bh=oyzXDGTE0H8WU8Tcw6EcbavSxdPRDlONFEJ6z68Z0b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWLE1DSUxB0LAou9AT/JaInhbTXiqWZdsFtHMlo7mRflyJYyao6r/gjiF2yYqLBDO5UUggs7748NC2/RD/+/0gCgDZHJDj/GsYivFhDdwx2+JrlaZCLAMYA3tKeXQY14XbTSIDsohLzzqI9yQm0JH5YE/F1eyHCwAl1fcDpEaGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cp5pW+CQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58DBC4CECE;
	Thu, 12 Dec 2024 16:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734021237;
	bh=oyzXDGTE0H8WU8Tcw6EcbavSxdPRDlONFEJ6z68Z0b4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cp5pW+CQOnHtlSJdGKHiJfhBGds8P/6GbmKg4pJtyF5wOne24SaU7UxH8Va1y8hWn
	 889VY/urZQr8dWUu3dVUZNmydguXm1dWXmUnHCJf+O9t9NRLbtSRFw8XuvnnCFzPz7
	 wc5wpW4TJFI6aLKkdwCZwgDcKtj6BfeM8Wr3npz0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Ripard <mripard@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 654/772] drm/vc4: hvs: Set AXI panic modes for the HVS
Date: Thu, 12 Dec 2024 15:59:59 +0100
Message-ID: <20241212144416.945584664@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 82c8eda2d4358..88442cb65915f 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -910,6 +910,17 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
 			      SCALER_DISPCTRL_SCLEIRQ);
 
 
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
 	/* Set AXI panic mode.
 	 * VC4 panics when < 2 lines in FIFO.
 	 * VC5 panics when less than 1 line in the FIFO.
-- 
2.43.0




