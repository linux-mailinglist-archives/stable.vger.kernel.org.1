Return-Path: <stable+bounces-136821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E47A9EA90
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 10:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDBB9189C8A6
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 08:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3757625DAED;
	Mon, 28 Apr 2025 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYUVnR0C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB60DA94A
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745828347; cv=none; b=CwvK+XdUCC19BhKa/g0VzvUyMShnqRI99jllcnsqn9h0v/udWo6uMuYoa/mqSPmP5cJJuy9YhrYenluI/dBk6RDzE0drWjZE12RqQXtwgvv5UI0bjKwR8WLC22tcWxK1VIB+Q8TwLgdnGwmVdXQurDKBMJ694oEaXxTnvoysjBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745828347; c=relaxed/simple;
	bh=/S9judEh0jhd0zmW+bUgIv2WmiroAuJZ6BTrZm6S2Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ByGlHexKxfnz4C9aFampCaTuwz+WbR4wiF2yiNqPufpy1YpeDXtaFyz9vo1Xne+zcXxrK4VZ0G8JqQgCwl4lHaDxqBktqc2OndYN/rBpg2YPBwBVZl/HfI/dWpojtOFA9Det8m0ZfKbla2KE6tV4mQelshAXMYeAQT69J/6lUMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYUVnR0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04741C4CEEC;
	Mon, 28 Apr 2025 08:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745828346;
	bh=/S9judEh0jhd0zmW+bUgIv2WmiroAuJZ6BTrZm6S2Yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GYUVnR0CJjxTZS96xd2AQtkAJu8hvlGhjM+WYUnr+/4qHadi1OdnwL0QboZJ9QPki
	 4Gt+1e9A3vPwjZscpR8pdEiFD5YyOXa4vOUbqKJmOec7T+FiInxjcZl0JQWMNDC7R7
	 6Lc96n/p4kC0UOzfGjdw0Ey1BBvWphIJjqYwSe/HqRC/Z5N6BABuroJiaix40UJvjY
	 8CjumHDQuIe10Vjj9xck8Ca/9pnkLAqbqvyCtLUTB/EKUeoa7Lzv2yGygABD/29Lfb
	 3Xc0S3OHH5bTmp3zrHU7penkkcOJq9K4KrGVnAfsGnceFC2Kwv29FYR3ecEaMOf9sY
	 JZZJOwEOI6ZkQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 6.6.y 4/4] net: dsa: mv88e6xxx: enable STU methods for 6320 family
Date: Mon, 28 Apr 2025 10:18:54 +0200
Message-ID: <20250428081854.3641-4-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428081854.3641-1-kabel@kernel.org>
References: <20250428081854.3641-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 1428a6109b20e356188c3fb027bdb7998cc2fb98 upstream.

Commit c050f5e91b47 ("net: dsa: mv88e6xxx: Fill in STU support for all
supported chips") introduced STU methods, but did not add them to the
6320 family. Fix it.

Fixes: c050f5e91b47 ("net: dsa: mv88e6xxx: Fill in STU support for all supported chips")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 472fe300b196..ef52d1ae27d6 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5074,6 +5074,8 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
+	.stu_getnext = mv88e6352_g1_stu_getnext,
+	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -5124,6 +5126,8 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
+	.stu_getnext = mv88e6352_g1_stu_getnext,
+	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -6120,6 +6124,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.internal_phys_offset = 3,
 		.num_gpio = 15,
 		.max_vid = 4095,
+		.max_sid = 63,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
 		.global1_addr = 0x1b,
@@ -6146,6 +6151,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.internal_phys_offset = 3,
 		.num_gpio = 15,
 		.max_vid = 4095,
+		.max_sid = 63,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
 		.global1_addr = 0x1b,
-- 
2.49.0


