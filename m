Return-Path: <stable+bounces-137038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAADAA0843
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90AD53BAC16
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C802BE7BB;
	Tue, 29 Apr 2025 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaehPW29"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5275384D02
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 10:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921686; cv=none; b=JxfwhZ92HS3OHr57wApEuy0aDrnx/jthFkLBi1/tnGnIBJ2Q9BJ/O+GtM7T871XHB/0Qz3iUlSB8AR+x0MO1cMddRXHEGpquYflZ6XisWjQgO1BTnkBoVwi+OmBB4BEq45NibO9Jm8r0Spey2RS8aIr1F470+VH985oD0yA8JyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921686; c=relaxed/simple;
	bh=4FHsI55FQmpx8ZgY0NWPCDvp0Srlluk//1P1Dt2qVFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvcoK0vbh0nRcpfpnf8paI89FoxtHrska8IdkdnM69yNOUU0CQRXPHBlpKEm2kh3cuU/UK5tJ3lBRUcdrM7K5l69UVlFqW2JhwNMaTU8EFlFIZD5GQQkxGeU8PJtMbYfKXIPtqwgZP5tg8/DIALbvzD2QzNsM2hhg2+wqHT16yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaehPW29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EA5C4CEED;
	Tue, 29 Apr 2025 10:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745921684;
	bh=4FHsI55FQmpx8ZgY0NWPCDvp0Srlluk//1P1Dt2qVFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NaehPW29RBI1eSPVkpXeARBVuy+wYGRASWpUKrJ292do65hxlF1TPYuG1odStargR
	 4ecCLraPcobs5RHhrSAPRoTKMN50/TU7LzIpHp2hvB4xw0JXmhkbuOYHmyFp8rVTnP
	 vk96QoyozKwPLcijcrenY3XvFzj5I1Wuv+2RoiQJzydvXaYoAQTcI1n5pfmdpKiws4
	 P/En2AmiKhFGoMCY/4f0nq5M2PnLe3slqcfZKi7/Bf5hBXOm2ZN/5KKWPQk/6JJ7Ca
	 1tQX9LTfM9yKA8K4+BCD+enmMZi3qpxeimw2w66DQSaHu+hzDUgU5MA96aSx1pYnB1
	 KsQP3XuXkZkXg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y v2 2/3] net: dsa: mv88e6xxx: enable PVT for 6321 switch
Date: Tue, 29 Apr 2025 12:14:35 +0200
Message-ID: <20250429101436.18669-2-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429101436.18669-1-kabel@kernel.org>
References: <20250429101436.18669-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit f85c69369854a43af2c5d3b3896da0908d713133 upstream.

Commit f36456522168 ("net: dsa: mv88e6xxx: move PVT description in
info") did not enable PVT for 6321 switch. Fix it.

Fixes: f36456522168 ("net: dsa: mv88e6xxx: move PVT description in info")
Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250317173250.28780-4-kabel@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 02bcf5a4b073..06ae3440c785 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5639,6 +5639,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.g1_irqs = 8,
 		.g2_irqs = 10,
 		.atu_move_port_mask = 0xf,
+		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
-- 
2.49.0


