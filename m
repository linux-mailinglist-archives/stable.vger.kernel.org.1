Return-Path: <stable+bounces-136811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49158A9EA24
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 09:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B90CF7A60DC
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 07:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD4B21CA0F;
	Mon, 28 Apr 2025 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXB5jjrT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FED220CCDF
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745827101; cv=none; b=Vjnwxu/71n8/5rLj0Ocxp3b7tGJamSq0DK8nZDkS7xxda20/ZdNI1ifM7NHcrlbQwUA8oF6vlzBoKYd1MIGV5ZTf+yVz5RqzY1tGK9qO37YDwr42vDNi4Hnrjswi5siqYCCbgnMdvI/CZGl91Q3JV2FI+vOo94m6wF8bq63RRx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745827101; c=relaxed/simple;
	bh=8sfVpXBJ1QwFNhEhyM+m7Jf1Udg0LIeUknzEgZdGMvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HStsL1W/aMkR9MYsfPqBz24QX3bkB6CqK1NgIc0FOCfVVs7SqJoxfQfCN9Qvvc8JBKCiksVsw3KGG6VdGCW8dEQBoXE/HI/R6LHL+CBarN2Fz8aKdNoJxaFecbbNJ+R28eo7DMn7IUTJ3W71P5mH7gn9ShDxJTuvXVju+y9EO7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXB5jjrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B13C4CEED;
	Mon, 28 Apr 2025 07:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745827100;
	bh=8sfVpXBJ1QwFNhEhyM+m7Jf1Udg0LIeUknzEgZdGMvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DXB5jjrTuz8y2hPAyeM8uFjbxfMR3b9y9wZ4Cd4Cb77lcIiG9jjPjJkUHHnWop1ty
	 /wMW3n25thNS9gggcPAkAR3oBoBp6RmGrS/YZ5lFKJcAd6khpDbZH69WZF+Wdfe5UU
	 19iRNXc3G9tN/m2fLUuI7CHJ/HOWNT70k0r+UgCN9O6F3z0tbrSglg5dpS/uCuwDUK
	 Gcj0lqIhdL0DbXSlOKsfJ2e6nNwlKIARH7mVTWtkZ4Rd9hEZNoegZE2OzCHUJh3tCo
	 EFAwNjlD9rgTtU4VaoYWt8Y/LqmL3v1E9NRAU54fUin2gDY8elz5ZqzXagP+kMO+AV
	 RCuK2KGOggrwQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 6.12.y 2/5] net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
Date: Mon, 28 Apr 2025 09:58:10 +0200
Message-ID: <20250428075813.530-2-kabel@kernel.org>
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

[ Upstream commit 4ae01ec007716986e1a20f1285eb013cbf188830 ]

The atu_move_port_mask for 6341 family (Topaz) is 0xf, not 0x1f. The
PortVec field is 8 bits wide, not 11 as in 6390 family. Fix this.

Fixes: e606ca36bbf2 ("net: dsa: mv88e6xxx: rework ATU Remove")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 720ff57c854d..03c94178612c 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5852,7 +5852,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 3750,
-		.atu_move_port_mask = 0x1f,
+		.atu_move_port_mask = 0xf,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.pvt = true,
@@ -6311,7 +6311,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 3750,
-		.atu_move_port_mask = 0x1f,
+		.atu_move_port_mask = 0xf,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.pvt = true,
-- 
2.49.0


