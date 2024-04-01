Return-Path: <stable+bounces-34201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B775893E54
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66799B2234B
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CD54778C;
	Mon,  1 Apr 2024 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qq/WLJW2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6441D1CA8F;
	Mon,  1 Apr 2024 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987326; cv=none; b=qydK0m033GrGOAuXUDSzXeqpsf6PNPuOIGdjYC3l49278tqlhrVx4FSco9I0CKwANjB+K1jzoOAABJ+mH1d7wyTXOo4+Imsf5N+/W+tGoEJ3vPHpuZRBil5E4UNN13gU4abC9iSKsVGdmy5uHOfwcauDilC7irYK3Hl4myZvJZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987326; c=relaxed/simple;
	bh=VaaDFBmmwvV9cqmF7DSsEx+8l65zkRPC7qlYoyPs3iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/Hr27p5lZuKt5t101y86vrwGXLCnuC6BzUMMn3lylMo+KASThu9iF3mV/eIt21An1GqGPSmMvBP9xcua58poKhfoYlJnaFotwHewBnd62KBirYtb0ury+FAFUrdVDOh8XoJUKdUvPZ5274C/rgDXs0R26Gm1k6ETPzMVv9uKVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qq/WLJW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A44C433C7;
	Mon,  1 Apr 2024 16:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987326;
	bh=VaaDFBmmwvV9cqmF7DSsEx+8l65zkRPC7qlYoyPs3iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qq/WLJW2H+/+L9D6EW76OTD0XeWk1Ld+M164gSUvIR9H1b3qOs5zHhR0NDLJdoMED
	 U4Dlo6n2xrEe72901ianq3dztY3lamHJGrlh3Im6O22H84qaYeaMjqtgVfDl6ESJMO
	 UvwuSxekd4eO7hX3GQgs4EQJJdRddy5KUxPBt2+U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 253/399] clocksource/drivers/arm_global_timer: Fix maximum prescaler value
Date: Mon,  1 Apr 2024 17:43:39 +0200
Message-ID: <20240401152556.719826965@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit b34b9547cee41575a4fddf390f615570759dc999 ]

The prescaler in the "Global Timer Control Register bit assignments" is
documented to use bits [15:8], which means that the maximum prescaler
register value is 0xff.

Fixes: 171b45a4a70e ("clocksource/drivers/arm_global_timer: Implement rate compensation whenever source clock changes")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240218174138.1942418-2-martin.blumenstingl@googlemail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/arm_global_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 44a61dc6f9320..e1c773bb55359 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -32,7 +32,7 @@
 #define GT_CONTROL_IRQ_ENABLE		BIT(2)	/* banked */
 #define GT_CONTROL_AUTO_INC		BIT(3)	/* banked */
 #define GT_CONTROL_PRESCALER_SHIFT      8
-#define GT_CONTROL_PRESCALER_MAX        0xF
+#define GT_CONTROL_PRESCALER_MAX        0xFF
 #define GT_CONTROL_PRESCALER_MASK       (GT_CONTROL_PRESCALER_MAX << \
 					 GT_CONTROL_PRESCALER_SHIFT)
 
-- 
2.43.0




