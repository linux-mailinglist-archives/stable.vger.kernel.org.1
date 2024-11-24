Return-Path: <stable+bounces-94900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014CE9D7076
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC99B281EC4
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB26918E362;
	Sun, 24 Nov 2024 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6GVhcWb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D1E18DF93;
	Sun, 24 Nov 2024 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455190; cv=none; b=EQE5Qg3zhJL8tHyByNmveCw0j3Yi4f2GW5/gcFFbUKOL77LbGLAXImOGpSxs0zkVaa83GL6KZPTemximEq4BCcOKpRxGevWXOGJsNhEfUPapwQuFe6G1b6WyhXJrryaBKFOGj2UnIte39mLgGf+ZbkLbrnDc1Wsgt1lB20r0F30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455190; c=relaxed/simple;
	bh=4gsN6HZoBiJ+Hb1KJjKp2p9n12HqzOM68/2JIIX6yD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAm57TBF9kXz6iGkSIBnaUT00AfijaTDTf2OGRpFBP/1YgxDbm8hD3ivt/pmQXwms6/GBEyeJ3F3yhdgWIK0ZWdJnxt3djCB5QvjU3j1KsXKzywUPcSIqclmEOAAeLUtz2wsHE6Ozg3c+oERXWOMAIxHnMBp8AUH2fiPqD0stys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6GVhcWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C316C4CED3;
	Sun, 24 Nov 2024 13:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455190;
	bh=4gsN6HZoBiJ+Hb1KJjKp2p9n12HqzOM68/2JIIX6yD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u6GVhcWbFvHeyUmvbzb8Sf/QOzH3fS4+WelHPdFL/nmjT4Phv3ofnbuUmN05OMarb
	 o4Nsc4lAlVXbb2DJcyGKK+z01lg9fzEJhBwrAHGzL2jwIbQHGP0srb/JakW3WIZCaf
	 tpZebJEhllT2oNnjGJhRn1mQHOQw6m3kw4MOyBrYbnFbmOpvhUrlyPAEv/RyI5KhTl
	 Q/o3V0hd8dPv4vAYJ0Gw433SEmVxyktEOQAu1jacCs+V1291cmWa1cpHV4KoSvPn1K
	 A5q/IOH7xnBfH34cP23aM1teL/7oRDX0qt4nwmLE8IiETz/QBggIIFZ3H7k+oZd9Cu
	 4QugL1Ck1MPqg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 004/107] drm/vc4: hvs: Set AXI panic modes for the HVS
Date: Sun, 24 Nov 2024 08:28:24 -0500
Message-ID: <20241124133301.3341829-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

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
index 2a835a5cff9dd..32ecc26a749a1 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -951,6 +951,17 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
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


