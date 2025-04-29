Return-Path: <stable+bounces-137032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B58FAA0831
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA37C3A81A0
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C27F2BE7C5;
	Tue, 29 Apr 2025 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9fS4Cwi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C5925D1F7
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921462; cv=none; b=dMoMA2Zsim3GMb9OrFPlI5I664YEqXU9WTcNtyZMjb9S0uwWvq4qwUA/V+x/onfKR4OT9BRytCujVzWXWM0Iwhrwvn3vw1CKVoGPW1pCgvxPb7EQs3SOpKE6DyRu1X2NRWXfVHWhzsQzDM4I6nO/NPaqANz/K8QU9aUakEIUomg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921462; c=relaxed/simple;
	bh=Q90/fV6EL4bjtXZIRXUTSxPQ8QVu/t27tTH8gGKMI/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Km6K8o7z5NObCk4b5StyWCbITKfZ5RKEaE8XYOhCt7zRyVpGthtLyZKmSNLW8XcDr9iKbuepuAK9SrQtmMWIBI9KF2Do5kaldTIhWwJzTnJtTgMAFG+AxqTFZuzhQrK0BolCaYoy8fKDm4B3+RrHJxOhOgcPHG8mGsOhoUNJREc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9fS4Cwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C4CC4CEED;
	Tue, 29 Apr 2025 10:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745921462;
	bh=Q90/fV6EL4bjtXZIRXUTSxPQ8QVu/t27tTH8gGKMI/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V9fS4CwiJ/c3SsIL41pawGm6L5NTKaNeNqUka2YGDtVsxrKBv5Rr/lnHJ4g8xZyST
	 HF+Wi0wiD1XW6q8C5Vp308jo/yVjpa1igzhi/c6bZH1udjB4CcOEvoEqlBMOY8NLjG
	 Yx4GcVuSlpw4qExWBLuRPR+bA8JXTrgJKqlLAJf+HJDLKCxt+wRZ0TlTUep8YyXZ/x
	 4yERBmMpCGKpmqRxcUVALrCzkYFj9xRbOJw/Uc+TL3vZl0Vfc8DJeq/xghDU6Ks2HO
	 xdCYgroqQ72ZLeE5CZYuZb/hj1z2ZtJ7yP20kc3tlWzEvlDk3tqFE+HJQ9+famZVvo
	 00bT0Zr3cGQhQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y v2 4/4] net: dsa: mv88e6xxx: enable STU methods for 6320 family
Date: Tue, 29 Apr 2025 12:10:50 +0200
Message-ID: <20250429101050.17539-4-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429101050.17539-1-kabel@kernel.org>
References: <20250429101050.17539-1-kabel@kernel.org>
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


