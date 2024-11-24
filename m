Return-Path: <stable+bounces-95153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AC19D73BA
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB5E28580A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B4A230F67;
	Sun, 24 Nov 2024 13:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eql3oMkG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF59B230F62;
	Sun, 24 Nov 2024 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456194; cv=none; b=pvr7yp3KndXN/KVG8wc9NJtOKebKev2RANbfxMrrOuWQ44oabCVvsHpKQ/cjiwwcWtsNJR1qdPAW8XO5o3eVCyvjnm9KNd4JjxxZBYRcRrH/hvnwlVIJAJHk+o+/EqdFJsEhatOXL812M+Ui16Gh8QksJZ2DerIG7RB08pttRQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456194; c=relaxed/simple;
	bh=OlhbbIEKdhmL9bWZDL0oWqgtzeLrtDFGYTckgOM9SlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1/xk/7+FQAaRrn35XCdFjMjPFr8vDl7onKeiDoot8OFnPOZNbgJFAc9vimuocufKl49poH6tBv5e9o40BRpyGw09dc8gcZdZzyuVLvlBNZQq77aZ1GlPXgiWI/dFh74PERdJqvtaicOnOaYaOYCWjHMxKkKhxY7ss5EU/ttvAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eql3oMkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFEFC4CED1;
	Sun, 24 Nov 2024 13:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456194;
	bh=OlhbbIEKdhmL9bWZDL0oWqgtzeLrtDFGYTckgOM9SlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eql3oMkGHb4mhpqUrh9wN8tTZ0eYkYJsrCRPxgh8jF7o5EBVfLb3uJmUwTb5sVeUx
	 SMHYiqH9rHojoyLM13ESSVMR5myn/DrkSkzo6maeBg3RO+NouyeBq4FLf9QxMKGj7T
	 BBAmu+8MzCFPOGZ/j4tFvNlnTvyGeKY2qsVZXfQ45gJ2xe7vgLhmCr9mDT6URg3/9l
	 f/4eLq8UecdizwIc+uSg1c6kf/r8HBLMWmucg1bRzFmsb44nW9xAb76wTZg35xxx26
	 56E+DoRMjLVUDzCryZVnDtdZEKAMMGPnCU9SgEdgnV5OFukUCCTEoIfVvfNagW/bkT
	 C5puLMML2OgwA==
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
Subject: [PATCH AUTOSEL 6.1 02/48] drm/vc4: hvs: Set AXI panic modes for the HVS
Date: Sun, 24 Nov 2024 08:48:25 -0500
Message-ID: <20241124134950.3348099-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index 47990ecbfc4df..89c621d35259d 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -906,6 +906,17 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
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


