Return-Path: <stable+bounces-77317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12247985BBC
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7447285D11
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7480C1C3F0D;
	Wed, 25 Sep 2024 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjYsSB+W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A6219F405;
	Wed, 25 Sep 2024 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265150; cv=none; b=tJ1A7aVTQ7UrMMfEqhVVWXJwl0+ntJ+KvAxlAI1e2Hn2mhARBaGydfmoqOk8wUben8KcKx+b+NkgctUW6pYLyCZCOKsvbSzyC41yVtoAxM096lL6SMYQrO2d4zdHtuOOwkCyQ20C60Ws5ZfBpEJuLaf3GuWwxRirJvi2+MvBzcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265150; c=relaxed/simple;
	bh=VEA4VGq5kC/9nf4ZTHNm/ys5iKz1PWSfsI27jXlN8a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oL2huB6+eeAf8vt6YlY5SHb06p0FAQFp2aYdiQXT+eeCL9xVvus1zARpJkaf0bHuuunFu1/Fjgv2q6zgVBKgrU9IaRxSYmbnkvDwn7wNBxxE7HsagcK2BuRYhEasDNi6LfAXOvOg0cLxNlkNjM85wKPHC0eh5JlYQqhA/iVd6EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjYsSB+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D85C4CEC3;
	Wed, 25 Sep 2024 11:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265150;
	bh=VEA4VGq5kC/9nf4ZTHNm/ys5iKz1PWSfsI27jXlN8a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XjYsSB+W7VkIOFj8RHIPwMwAe8cnBX8nz/59zIbhZR+HNvZEcFyYPzv3HeYv1qWAZ
	 8xsheeslhYvvFPkz6xw1Od+5UkZgQDPi2rGKZqoMsJbOYqDoiv+xjOnEDiWtAv1XnH
	 If95sXaHHrSxQ6tsf1klAkQZ9y1fKMXpouGvrZd7iLtJ1ZDIQZ9U89Ir2jeTqAv21k
	 isV5M4DfNbJe9Ng3+YOmt3TVCn0jn2733f0RDf6V0BqsJ5gB3reD+MKbBXCaeWhQ36
	 ULS/4F8/m1fOFcbthtQYWM6DlSi3WaDkTH6lHpaPAtfBImnNkScUnuBl3CNmLGWVxq
	 qrDOjUUeKT2Tw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	saravanak@google.com,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 219/244] of/irq: Refer to actual buffer size in of_irq_parse_one()
Date: Wed, 25 Sep 2024 07:27:20 -0400
Message-ID: <20240925113641.1297102-219-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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


