Return-Path: <stable+bounces-136813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3135A9EA26
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 09:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 683977A1DFC
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 07:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001CC212B3F;
	Mon, 28 Apr 2025 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0EMpjQS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48A320CCDF
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745827104; cv=none; b=k0KHPWwgSID0hoI+/xNaADmXLpG6C8SkFie30vQijB0B1d2UCDrGqPOz0BGuRLOyuNOsh63gDKS2e8/FCe+yxJXaeecvSydSfAbR1hw8a+/iX2Jhm0aaTfQ19eLFluzdlzkAbmKyTjebVN43erQ05LfFieiTXFvISPO+cn1zwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745827104; c=relaxed/simple;
	bh=2yR7+aVbk6cam3788Fs9Ua5HWJ1Wwzz11DjFh3r4Npo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/J49fHuHOSOEbHqc4mRbWsq0ivRTIRYSMMsx6z3usKSVi5oU83lNCf3dCuibBQyR51oqfgx5Vbav85fMQ87jIde9o27PJ0h91uP1mqplT3ZU2//k58VQmwTnpr4q5vtJEJgl2P5gCWSciUkcwj2+MIIEGphQPJs0NIoodwNbpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0EMpjQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2FCC4CEED;
	Mon, 28 Apr 2025 07:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745827104;
	bh=2yR7+aVbk6cam3788Fs9Ua5HWJ1Wwzz11DjFh3r4Npo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M0EMpjQSMQe8RJZNs7igCXsJgplCEiVvKxlwXwWe17CgVcXuZMxU/EooC308r5ob5
	 X5pglGxZSMMDpxHd21b3zNnIhEQVJ0WnMA9L+o7uYkcrJJF2jQDzrLMCTjsn4bHM+O
	 4xRLq9VMfo0OuAYeWPOUrQGaNTe7bzYWHkdPDwKf6Hw9pp6GDXwUSGLsa503OgXsK6
	 h511kWfqmMJYUzoqKbwmlQSjSNtuGVRz1Q7KXyIHpVZCPNTReP/z4B8OSvJEys5z+G
	 X4psRV0kBLcOwlEGqWh9ybwLby1TTKvA2Ab/6Kqxm2ulS4yXBbQW3TP9137CSNnejQ
	 oRJyBF1LbCJRg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 6.12.y 4/5] net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
Date: Mon, 28 Apr 2025 09:58:12 +0200
Message-ID: <20250428075813.530-4-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428075813.530-1-kabel@kernel.org>
References: <20250428075813.530-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Upstream commit a2ef58e2c4aea4de166fc9832eb2b621e88c98d5 ]

Commit f3a2cd326e44 ("net: dsa: mv88e6xxx: introduce .port_set_policy")
did not add the .port_set_policy() method for the 6320 family. Fix it.

Fixes: f3a2cd326e44 ("net: dsa: mv88e6xxx: introduce .port_set_policy")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index a56b1d5a0cd0..4218ed581409 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5186,6 +5186,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
@@ -5236,6 +5237,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.port_set_rgmii_delay = mv88e6320_port_set_rgmii_delay,
 	.port_set_speed_duplex = mv88e6185_port_set_speed_duplex,
 	.port_tag_remap = mv88e6095_port_tag_remap,
+	.port_set_policy = mv88e6352_port_set_policy,
 	.port_set_frame_mode = mv88e6351_port_set_frame_mode,
 	.port_set_ucast_flood = mv88e6352_port_set_ucast_flood,
 	.port_set_mcast_flood = mv88e6352_port_set_mcast_flood,
-- 
2.49.0


