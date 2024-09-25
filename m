Return-Path: <stable+bounces-77525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E24AC985E10
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80A328D2F9
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7584420B1E9;
	Wed, 25 Sep 2024 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvWiu6yR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A44C20B201;
	Wed, 25 Sep 2024 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266114; cv=none; b=U3b6PjJ77Vt+rikaYVWr1fcRy4v/1u67IMGKNszUm71ORv0vMde1WmX7dFfrZItv8T2YJzhhlXbh+MlnNiTftZX4DkV3EGafvoRA4B9FhbgL55rjZQw99BGygOMS3GK3/b+MltZhXbjPxL8ye1XYlOq79vrZrWMc8I7/sORLzls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266114; c=relaxed/simple;
	bh=VEA4VGq5kC/9nf4ZTHNm/ys5iKz1PWSfsI27jXlN8a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnR9hM9VSEgfjZZeYpgTm9fihCMtOdxZQ2A4ALQaB7C+DN6eUwMbQcKQ0j6hBmfIOR0rWadgWyarEhVUS7WgYBm/IHhR0Iu1AtNlpdz403Q9hRoOSPG9N7GVJrzIRRj3CO3OR0XwlW2ImjZYvekB7YfhBS2uU3xco56/T5yeKKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvWiu6yR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA9AC4CEC3;
	Wed, 25 Sep 2024 12:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266113;
	bh=VEA4VGq5kC/9nf4ZTHNm/ys5iKz1PWSfsI27jXlN8a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QvWiu6yRJvQljucXQxmKokObF3iENrwSIDolT+mq1OTiYtDW+cAOUXQnAoWqoaU9G
	 v+NyAq8L+Uxevjv3VjdSzIHjPteBbtwoxuMvSw+/U7/bhjyivJxtTLbDqXvcgAeUq2
	 sIMhDhTEhz2BGFzsX+Ar8yj4elqPbTj3mToE5fIwf3SUFtnue0852KYIH/4G35mYw7
	 C9i2p4Z93zZBvl943sLPm1qsqgZntZOs36RCyuj5qyVpditPNSyG5ey+at8GoQpl6s
	 8BG/2f2+T2OT/EFXSEFUIIA4rsljz6YTWFZzL+rkbVda6aR1Mhj/hvYNyGzKGJpLHv
	 eTEtwiXQEXeAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	saravanak@google.com,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 177/197] of/irq: Refer to actual buffer size in of_irq_parse_one()
Date: Wed, 25 Sep 2024 07:53:16 -0400
Message-ID: <20240925115823.1303019-177-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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


