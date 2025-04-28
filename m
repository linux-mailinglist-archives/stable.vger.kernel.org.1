Return-Path: <stable+bounces-136812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAFBA9EA23
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 09:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB5A3AE757
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 07:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CDB218E83;
	Mon, 28 Apr 2025 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iL+JoeD5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B00212B3F
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745827102; cv=none; b=Elz5B+F8H5qDbt6nT/iGia00vnFMo7gr14d8uvxN4UWYzKyI9LLngPhNr08Eh+W/4fyqcOkYLlwg7nJqHlX1/vjHPV08Xj36c+sHbPSohs8DNTrLNFvmym/UjyiLeo67wLOMOUP9HN2mEAGJdWFQC9ec60VtRj2i/be5OAj+jqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745827102; c=relaxed/simple;
	bh=CPvCbNdWUu2xxrYTL+we2K0B86bjQcYzo+m44j1uGx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTzmjtaYO5bncjbZZcKAlX1LRVteKOLrx1Ls9kLL5eDVYBDBN22yCaoEP5UGA/0223OLqfBrqUmW3eFxUno/LeJ/eIPauapnufETO26N0vjyLTiNiY6hrytdc/Os8qdpvvfME3kWwYIYwJmPbhyTVjNDeK2yMpsuIADkdSp/7WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iL+JoeD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6B3C4CEE4;
	Mon, 28 Apr 2025 07:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745827102;
	bh=CPvCbNdWUu2xxrYTL+we2K0B86bjQcYzo+m44j1uGx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iL+JoeD5GOqHa7+ycQgxQ1AMRXnXv0uJxV1S73PRxzsJ//NxJ6NKl+Yz6vbibYnIs
	 sLsEaJ1S2tULypGkIKhXV2lkGXbygBPenVQdaWdWXTjBAHtlB7vnPWCUEuuTLl6vjP
	 LshwrWwNrFgsdS3d4Co1GHR4SvKbbeDmmogqEMY5zpGInJX5ZNxEU0PkdPNMPUOW3h
	 CvLNR22h0gGORAJ+A8p6ZTQhtL1Hee3TlYCXiAHfcbaa2x2PFJ9PscvcVqBtXOJhap
	 j+tGL3eKAVKVxqZ8f1OpXe+W9wEunk9wl5nRxNMnd/XAtT7HYk70w5d2E9wGT5apK4
	 gd8B2fzKoglaQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 6.12.y 3/5] net: dsa: mv88e6xxx: enable PVT for 6321 switch
Date: Mon, 28 Apr 2025 09:58:11 +0200
Message-ID: <20250428075813.530-3-kabel@kernel.org>
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

[ Upstream commit f85c69369854a43af2c5d3b3896da0908d713133 ]

Commit f36456522168 ("net: dsa: mv88e6xxx: move PVT description in
info") did not enable PVT for 6321 switch. Fix it.

Fixes: f36456522168 ("net: dsa: mv88e6xxx: move PVT description in info")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 03c94178612c..a56b1d5a0cd0 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6289,6 +6289,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.g1_irqs = 8,
 		.g2_irqs = 10,
 		.atu_move_port_mask = 0xf,
+		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
-- 
2.49.0


