Return-Path: <stable+bounces-77673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7574985FC4
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09BA61C257AA
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321981D4E08;
	Wed, 25 Sep 2024 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tq9FaHbN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17FE1D4E00;
	Wed, 25 Sep 2024 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266657; cv=none; b=iIVi1G1Ew8SwJmf1rQQJF4YmO+NfpYMRpnhD4MDfM9NMg3W3w70wDxbMWgYy4BvO+k0uVByGderLslv0JVnLFjzAG/Cd9xWTF4lpsc9xcSrRi/lEKFTddTxMgUyrw0V7Gx6XLPU88I90zGitNpzKy7BvP42N/votQVZIVvWuREI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266657; c=relaxed/simple;
	bh=VEA4VGq5kC/9nf4ZTHNm/ys5iKz1PWSfsI27jXlN8a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCy6FZ2sSUE/M6XVnJtqGkRF2iA8by3LB4VqUFYXMP57GgEQkrN2yi28IuNvjD3LDuSoZDAlvv6Nzkeh5Nve0tB5eXxDnELDfMKqSM5CAv5Roez/bequubVLM5Sk8DQXj8JXFDZ0l61jP7lHmkPkAs8q89TY/zGYFF4Eh+4UUkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tq9FaHbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FF0C4CEC7;
	Wed, 25 Sep 2024 12:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266656;
	bh=VEA4VGq5kC/9nf4ZTHNm/ys5iKz1PWSfsI27jXlN8a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tq9FaHbNpl3w9of1O63NztYuRlLOXUwNU5HxJsoaEd+DjayHK7Vs40cYZsICkfRRS
	 O+M/gA/+Yb9+nhfq999gleajG8GyIfasJV7svXNyKZmNT+ropgA83cQd423byFa73I
	 snipd92vU4K5mwCAfRTWiYoyIwaNOkWgZ+o2lEVwe5rcJd72fIxIQbArMw9fChMzmS
	 uXxECjzsXYGiwYB5fidSCjVuJnelRa8NxHSIYYtw31MxZoRpRNbOntwsykJuKKRGfw
	 tiBIj5938nqIMMNB2XYa9rqIbLW3xL1R7ngfv2H5bUEm2lCROvZrtxolE9JLOPPq7V
	 5b3I6N7s9RODw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	saravanak@google.com,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 125/139] of/irq: Refer to actual buffer size in of_irq_parse_one()
Date: Wed, 25 Sep 2024 08:09:05 -0400
Message-ID: <20240925121137.1307574-125-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 39ab331ab5d377a18fbf5a0e0b228205edfcc7f4 ]

Replace two open-coded calculations of the buffer size by invocations of
sizeof() on the buffer itself, to make sure the code will always use the
actual buffer size.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/817c0b9626fd30790fc488c472a3398324cfcc0c.1724156125.git.geert+renesas@glider.be
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 8fd63100ba8f0..d67b69cb84bfe 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -357,8 +357,8 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 	addr = of_get_property(device, "reg", &addr_len);
 
 	/* Prevent out-of-bounds read in case of longer interrupt parent address size */
-	if (addr_len > (3 * sizeof(__be32)))
-		addr_len = 3 * sizeof(__be32);
+	if (addr_len > sizeof(addr_buf))
+		addr_len = sizeof(addr_buf);
 	if (addr)
 		memcpy(addr_buf, addr, addr_len);
 
-- 
2.43.0


