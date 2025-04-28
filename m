Return-Path: <stable+bounces-136819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C89AA9EA8D
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 10:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DD51778B8
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 08:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A7D253F02;
	Mon, 28 Apr 2025 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQXisD4B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321FD24EAAB
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 08:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745828343; cv=none; b=JmW6XnH4QS9yyjFF40upAWdsZ4+89DIdKBymxpvD5gLvzpAHyuRKCVoLkPlTuN+Yk08B0vzk5+bkaIsCgsYLiJ7/Kfkr4k9CQi0hUdQd8e9spMH5F9B38o5G8GoMK2pHGhrNbvyS/6HJJiPy0C3/Ejt9Vqh2760HZA2xoRs7FqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745828343; c=relaxed/simple;
	bh=rkovaV77VNJf7TdFq4CBE3CzbqEols6OnKsf6+0vRro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pl9odNWqgWwD3P4R964Etf6HDNU4jEOVYpRwIURv159HOa5Y0WfrJMdbrsjfRKiqsxb+3ZM7ZyZlmPxlt16BlQMKvFkyknnfuv0kwafngYJmNRzDC5Fs42JATkXK8/sPG3MVGyk57VtWWiJPimt2PX83CdrZ3td9Bw3M6X64iTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQXisD4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A0FC4CEEC;
	Mon, 28 Apr 2025 08:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745828342;
	bh=rkovaV77VNJf7TdFq4CBE3CzbqEols6OnKsf6+0vRro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQXisD4BgOqusQMpZ2+1nLYkD+iaMqBpyRVVd2sPXi7+tN5yE952txyM1021U4bop
	 nql4m7SI9QxsmMgfSxmQl1EGRRZa4yg2LBKY2jnXRXIAv1pOO3td4xHYmxUENvrcdT
	 tZK4PhKP6R1mP5jOpCyDDYdeUY6iVHGV9UDXT5wJNSneh1ZHKab4pOT4Z3OBO8b3Or
	 ICK0P3w4o1c/ylUAr10rouHL11/fxs4OpDqpJAoSo0L8LVsV4e7lMKWjuDlleVvIGp
	 TMTqbps+klHyx/oKnY7odX8R6qHZY7oxnZJEATBulr1ej7M4r8Mr/RgC4HcT6WT1UM
	 HX8AYwlLQ6YFg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 6.6.y 2/4] net: dsa: mv88e6xxx: enable PVT for 6321 switch
Date: Mon, 28 Apr 2025 10:18:52 +0200
Message-ID: <20250428081854.3641-2-kabel@kernel.org>
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

commit f85c69369854a43af2c5d3b3896da0908d713133 upstream.

Commit f36456522168 ("net: dsa: mv88e6xxx: move PVT description in
info") did not enable PVT for 6321 switch. Fix it.

Fixes: f36456522168 ("net: dsa: mv88e6xxx: move PVT description in info")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index be42de54e7df..f8ac209e712e 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6152,6 +6152,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.g1_irqs = 8,
 		.g2_irqs = 10,
 		.atu_move_port_mask = 0xf,
+		.pvt = true,
 		.multi_chip = true,
 		.edsa_support = MV88E6XXX_EDSA_SUPPORTED,
 		.ptp_support = true,
-- 
2.49.0


