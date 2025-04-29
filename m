Return-Path: <stable+bounces-137036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CE1AA083E
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B90484F6B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD7B22424D;
	Tue, 29 Apr 2025 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4mrlZIA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E94321ADD1
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921595; cv=none; b=gc6Ol6q1PFOuGl8rXs2RyU0uJgpcaSH5KUOxdKL9IHJawV4deuNWHsTW7bhxl/O9aYqgOGwC6KFP2nmqwTDW6q9M9eP28KSeIT6fbsRBtNklm6Kc9qFJbyfgHn2JQUpV8RMQL91/zKbuLkmaDrMmrnQpcmhvugVneho2JsbqO2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921595; c=relaxed/simple;
	bh=7eIH2bJt0IpW2m2fxJaDvXZxODLu3FS46Dxzj0B/0ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMwu3z9r6vB6HlcbQOfGGWd8UH9HBuf2M7S9NGHfAwImIZNI7RmIO2wnoIDorE9llY+E7R4C9+rTvsXqBB5aMjs87erBYPK45whZZc9AmezL542lPxfwUvKKdZPv1RUltKlZzQ3CiWdG1gIN0xCuwAsA+WWcWLirtYvmaWmAt3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4mrlZIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B671AC4CEEE;
	Tue, 29 Apr 2025 10:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745921595;
	bh=7eIH2bJt0IpW2m2fxJaDvXZxODLu3FS46Dxzj0B/0ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q4mrlZIAuLD1QMqwyIdyQBWI8GX0+206KYzc2FFA/acFveRZKlzfI9/N1A6mckQ3M
	 IBX2lD4k5tKsOvkfl6NcjK+DveE8RvF/Xbg+pidG3aHa7K+AA2VARLqATTzPZTlTdP
	 32S5Z+/wUsvcwsEyLmbnO+FKNMY+CCX7+NoDdZCElIfcSxzC5AkHLzT0gqA+03hf3a
	 50nb1pJqruYAb9qi6QQbh/AWdE0hiE8cNy9GReOI3FQNkfFRUkr29IBiCgtuLwomU3
	 udkBU0VqD7slervU8jqNZ3FYBB0VSTA5EJkQ1S4QCEdNuF5ul9vN1LyY2M1+rgq4up
	 pGbieWIJM9mZA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y v2 4/4] net: dsa: mv88e6xxx: enable STU methods for 6320 family
Date: Tue, 29 Apr 2025 12:13:03 +0200
Message-ID: <20250429101303.18190-4-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429101303.18190-1-kabel@kernel.org>
References: <20250429101303.18190-1-kabel@kernel.org>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250317173250.28780-6-kabel@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 96b989e336ae..29e4c94c8405 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5200,6 +5200,8 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
+	.stu_getnext = mv88e6352_g1_stu_getnext,
+	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -5248,6 +5250,8 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
+	.stu_getnext = mv88e6352_g1_stu_getnext,
+	.stu_loadpurge = mv88e6352_g1_stu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
@@ -6218,6 +6222,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.internal_phys_offset = 3,
 		.num_gpio = 15,
 		.max_vid = 4095,
+		.max_sid = 63,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
 		.global1_addr = 0x1b,
@@ -6244,6 +6249,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.internal_phys_offset = 3,
 		.num_gpio = 15,
 		.max_vid = 4095,
+		.max_sid = 63,
 		.port_base_addr = 0x10,
 		.phy_base_addr = 0x0,
 		.global1_addr = 0x1b,
-- 
2.49.0


