Return-Path: <stable+bounces-14010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75091837F24
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7D029BE25
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A04B612DA;
	Tue, 23 Jan 2024 00:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OHfeZd4T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE7160DE3;
	Tue, 23 Jan 2024 00:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970963; cv=none; b=WKCbiW9Kak91B1OnTSsMrmzV5k+BUOIYIUhqzAtFq9ujk8FSgYc5s/bt/3pm/F5ynv9iaUZBcEHl4qweBKWW+mHePVPJ9hI5ZmR910x2UmApqrIcS42v0mRshtRH7WARfNGhGEmNvS0Znd5ZkYkIqzB0SYVfN/uDvdJUu8Ts/NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970963; c=relaxed/simple;
	bh=8FCUnnW8h9KwW/Apzr2Etsioq1elSSqGsdDV5QWQeEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QON8pu4Co3lcsvoKD6Xuk0qdyqfqFP8kpuchZdfCNm/kafUFewpJ631G6mL0+e6INJRuSa0AJehqoPASueM8gqp3tQ5OuSBqxo9W44tUlbC7H0UgT8ytSyPMv8wYZUaWmj6tJFtpSNJBzu/w8bhCThvsjleAUB/X/lqvC/JptoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OHfeZd4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9A2C43390;
	Tue, 23 Jan 2024 00:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705970962;
	bh=8FCUnnW8h9KwW/Apzr2Etsioq1elSSqGsdDV5QWQeEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OHfeZd4T9Kl2Rnt624+7FqhGUAbzyTrCwvpbDLsAbhFJGLrtIj6HIYJ8j/53QSfER
	 2JL0ca1u7TY9TRTW+a7duXwbGxF4+HdnFnwEmt4w0rXkhjg5GymMUs+tsWgAwR0oJ5
	 j8WIkFDHS+vFPIO7l/XaUMvzb4sRii2STKlQSkzA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kunwu Chan <chentao@kylinos.cn>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 058/286] powerpc/powernv: Add a null pointer check in opal_event_init()
Date: Mon, 22 Jan 2024 15:56:04 -0800
Message-ID: <20240122235734.259387305@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
References: <20240122235732.009174833@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit 8649829a1dd25199bbf557b2621cedb4bf9b3050 ]

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure.

Fixes: 2717a33d6074 ("powerpc/opal-irqchip: Use interrupt names if present")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231127030755.1546750-1-chentao@kylinos.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/powernv/opal-irqchip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index c164419e254d..dcec0f760c8f 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -278,6 +278,8 @@ int __init opal_event_init(void)
 		else
 			name = kasprintf(GFP_KERNEL, "opal");
 
+		if (!name)
+			continue;
 		/* Install interrupt handler */
 		rc = request_irq(r->start, opal_interrupt, r->flags & IRQD_TRIGGER_MASK,
 				 name, NULL);
-- 
2.43.0




