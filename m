Return-Path: <stable+bounces-124311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE058A5F630
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 14:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BB54207F6
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2155C267B79;
	Thu, 13 Mar 2025 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="su5I6Z0b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F2E267B6A;
	Thu, 13 Mar 2025 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873339; cv=none; b=U/1OtAMKDWBJuVS6PyMFE8P9SDyKxZVagW9ayoC1sXtdrlL4OvyeptEdN+ij/QRiz6RB3ea4wKB6A9g1z6FT/spmJ21RYAwnmHG1jlV142kN+8AVq4VttuAH4QmtlsY4/ldAjLTq4KmhGgtR6BqGvHvFyDvfWDmACxwk5AaH33Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873339; c=relaxed/simple;
	bh=1yTACMD9yPiilRcuCNwnjUeLb5zGlv9TzKcXia8sHdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBrvHR3kWWujC9/y8ZEXBzPlbvoDTVG+Rp6tFnlnGormk0a1ZXJjX06tJMr54nv+onfCeJ6JHSmhvGFbNXA8c1cq3sWwxl5+xwWyNEvBhglhtPHbla0phLDGYbqpIvxIh4mAXdCkZquVJQMobjpTBm0dSCk/ELkuJ91nrj2ecSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=su5I6Z0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F835C4CEE5;
	Thu, 13 Mar 2025 13:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873338;
	bh=1yTACMD9yPiilRcuCNwnjUeLb5zGlv9TzKcXia8sHdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=su5I6Z0bMvDYdxv/Q5ubj87qQWtchO2+es3GiNr162PnAM2umamYwONSoCl/Mf1km
	 69p1O7Tw0POa4bUXgP+IU8InNZT62HWWGK96PAIHH0BwD+eKoeuIkAzSnKKmon4Tqr
	 8npv8D8+8HhZ9zE9QyRE8Ci0iF07Inu/d9mHBmgCmjOSIZlNBj9bY4TBFuHKEGJ+b4
	 ZyLDwTN8/Ag5delnkXu0gH9OYviF1tmeUfUZlseFHPrB07U9oqjY2rbep4Q+ime0ZB
	 eqKA1i+q7r3AkLQ22jqOHZBz30EEJjQPo0bNUzkpX/mO01Wli09SNULf80oZvINyHC
	 BlEmaflds3y+Q==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net 12/13] net: dsa: mv88e6xxx: fix internal PHYs for 6320 family
Date: Thu, 13 Mar 2025 14:41:45 +0100
Message-ID: <20250313134146.27087-13-kabel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313134146.27087-1-kabel@kernel.org>
References: <20250313134146.27087-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix internal PHYs definition for the 6320 family, which has only 2
internal PHYs (on ports 3 and 4).

Fixes: bc3931557d1d ("net: dsa: mv88e6xxx: Add number of internal PHYs")
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: <stable@vger.kernel.org> # 6.6.x
---
 drivers/net/dsa/mv88e6xxx/chip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 3849b8d55fa9..898aff46693b 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6240,7 +6240,8 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 4096,
 		.num_macs = 8192,
 		.num_ports = 7,
-		.num_internal_phys = 5,
+		.num_internal_phys = 2,
+		.internal_phys_offset = 3,
 		.num_gpio = 15,
 		.max_vid = 4095,
 		.max_sid = 63,
@@ -6267,7 +6268,8 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.num_databases = 4096,
 		.num_macs = 8192,
 		.num_ports = 7,
-		.num_internal_phys = 5,
+		.num_internal_phys = 2,
+		.internal_phys_offset = 3,
 		.num_gpio = 15,
 		.max_vid = 4095,
 		.max_sid = 63,
-- 
2.48.1


