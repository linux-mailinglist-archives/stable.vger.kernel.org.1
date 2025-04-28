Return-Path: <stable+bounces-136814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFD0A9EA25
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 09:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933023AEC39
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 07:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76901DEFDC;
	Mon, 28 Apr 2025 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pg/hSHwV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E24213E60
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745827106; cv=none; b=cBHvyD56xa7mQYvBztFtLq3DcXTWaF8uy3ww6/aFdMxDafOHwnh6P+Rmlf+w6VUnxo1JJ+KwWrmA0gaCMGdrkDoBPcd5ZyUuVHfIN7u7scoe62xhN22AzPphMOKHcBMaTO0DBddj+7eCgBIvMt2zWFlrmPih8o/JzJQj8Bz+JWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745827106; c=relaxed/simple;
	bh=imwB/eQoKl5r288oHcSMjgBw766flofrUNhRm7k7WFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R41R6pfNr7UCasYe0fV4z7yBvd8/eVNxYNvfq1WqNdQQVVSl5xrNz37YNpp3vktJCG51ndMCf0C+6/o3qCroebM4/zH3qQ8Ixj9OCWDcHLBeYofKNamskioPS3PK1a3005mo0a4ZXUxvhVpXTnjRdHzUf+hqkKiEvBt1B2VJSRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pg/hSHwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD38CC4CEEC;
	Mon, 28 Apr 2025 07:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745827106;
	bh=imwB/eQoKl5r288oHcSMjgBw766flofrUNhRm7k7WFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pg/hSHwV8voz33mHT2XgbsHKjA6qeVEnxnJVSFU1M2QoGtL7UGX8sUO60CMsrJB5A
	 9umd/ErzYHIU+i1RPr4nqgQ/ArPXzkcYM+DwJAL6a8jZMXCWrDfpBm7L9txGPukaj6
	 NuixI+JZIJ5iyR94LIsgIK1jtgppZQaQHh/QkS0XeB3sfZcY4AQbE8iGa0JvwCDjLe
	 7ZYf4cvSSfbC7jdNGkQ4OAbcLANrYp9uMY/GflFebDN+VP3kycZM4UhaNL57c0XeHj
	 yVPhnNkZ5d+S8KXl5Zz3IuqXzGNSLgyo1KT1HaLeMgU2weI7x37X5QXe26qM4/dqHn
	 2WSG7ISeMRjhw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 6.12.y 5/5] net: dsa: mv88e6xxx: enable STU methods for 6320 family
Date: Mon, 28 Apr 2025 09:58:13 +0200
Message-ID: <20250428075813.530-5-kabel@kernel.org>
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

[ Upstream commit 1428a6109b20e356188c3fb027bdb7998cc2fb98 ]

Commit c050f5e91b47 ("net: dsa: mv88e6xxx: Fill in STU support for all
supported chips") introduced STU methods, but did not add them to the
6320 family. Fix it.

Fixes: c050f5e91b47 ("net: dsa: mv88e6xxx: Fill in STU support for all supported chips")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 4218ed581409..211c219dd52d 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5213,6 +5213,8 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
+	.stu_getnext = mv88e6352_g1_stu_getnext,
+	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -5263,6 +5265,8 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
+	.stu_getnext = mv88e6352_g1_stu_getnext,
+	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -6258,6 +6262,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 5,
 		.num_gpio = 15,
 		.max_vid = 4095,
+		.max_sid = 63,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
 		.global1_addr = 0x1b,
@@ -6283,6 +6288,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_internal_phys = 5,
 		.num_gpio = 15,
 		.max_vid = 4095,
+		.max_sid = 63,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
 		.global1_addr = 0x1b,
-- 
2.49.0


