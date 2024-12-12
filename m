Return-Path: <stable+bounces-103301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 741749EF788
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22878179A77
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C56E211493;
	Thu, 12 Dec 2024 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CHw3+wQQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2917D13CA93;
	Thu, 12 Dec 2024 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024151; cv=none; b=cBrqBvrUU7l2Hudth0+gmv0C34Q6f3xPHOqxh2UcX82SoU7nFJvRgFu1gDgvRnB4W9+FLWp90F/F5/41fAeX4/98QKeims3Bv0rt7HLxZo6Xdk4OF6EP1q0MldPLnZVUUNd/sIgsHci4MGg/U9rrISSjzu6X6xEtEp2ZmJt1VQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024151; c=relaxed/simple;
	bh=o4p2xJefvGtTLQJHFdAqRytydXD8X+rhIUQPbuIWbpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqJYmNK3UFt8biV/GN4lCdNjQQUyzHlR4CaSWaAmYAuwuuYcKQGYwC1uyJkPgOuv3eCY/QQdNk4rC/AiLqTgsvcEw1w91g/mKk1gPZNozIxfJ1ney75bemBVoBqTj+syvO7KbpSwF3wfK69xfZ+hZEMBiLMLQyMXugSZS2dtAwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CHw3+wQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B62BC4CED3;
	Thu, 12 Dec 2024 17:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024151;
	bh=o4p2xJefvGtTLQJHFdAqRytydXD8X+rhIUQPbuIWbpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CHw3+wQQ3ke9dTQehSSHivCqewEgQyejUL1fupFVgmFIXwTyxin/3vsMds742Fy6F
	 FxYXeI/CeGjMtX3KupNNIcv1JJXYI8ysgo0U84ez7V5wP0vUlno/449siCsd+7B6Dv
	 6Kc+69SoOHzdAcFT5ci7Cs4MJqHMBgHTAUBMg9ec=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
	Greg Ungerer <gerg@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 202/459] m68k: mcfgpio: Fix incorrect register offset for CONFIG_M5441x
Date: Thu, 12 Dec 2024 15:59:00 +0100
Message-ID: <20241212144301.548205642@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

[ Upstream commit f212140962c93cd5da43283a18e31681540fc23d ]

Fix a typo in the CONFIG_M5441x preprocessor condition, where the GPIO
register offset was incorrectly set to 8 instead of 0. This prevented
proper GPIO configuration for m5441x targets.

Fixes: bea8bcb12da0 ("m68knommu: Add support for the Coldfire m5441x.")
Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Signed-off-by: Greg Ungerer <gerg@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/m68k/include/asm/mcfgpio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/mcfgpio.h b/arch/m68k/include/asm/mcfgpio.h
index 27f32cc81da6b..02049568198c9 100644
--- a/arch/m68k/include/asm/mcfgpio.h
+++ b/arch/m68k/include/asm/mcfgpio.h
@@ -144,7 +144,7 @@ static inline void gpio_free(unsigned gpio)
  * read-modify-write as well as those controlled by the EPORT and GPIO modules.
  */
 #define MCFGPIO_SCR_START		40
-#elif defined(CONFIGM5441x)
+#elif defined(CONFIG_M5441x)
 /* The m5441x EPORT doesn't have its own GPIO port, uses PORT C */
 #define MCFGPIO_SCR_START		0
 #else
-- 
2.43.0




