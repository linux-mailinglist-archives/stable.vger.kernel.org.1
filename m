Return-Path: <stable+bounces-123371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42EDA5C4FF
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA2C7AC302
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5667725E81A;
	Tue, 11 Mar 2025 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B4nrpy+J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A088632E;
	Tue, 11 Mar 2025 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705761; cv=none; b=hCMJhvt7Ds7p0YnkDl6Zc07xvY99nyphp+Hm5x4o+TLNwcG4mF60opsYNtVRnz+XArLk7q7BbH7oNufuM27GcjAiN2Iau6tpK5iIyn/mtJ8VG+pI9nBEgXWF0+umbeOxAgQiruDivct2xp8OUB48Vxvpe5XN6Y4grD3MYils9w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705761; c=relaxed/simple;
	bh=kBXOq6hKD0Z3iV45vJuTkWCbnSSb+VlL+m3gV38sjh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oj2BCOkfNhbFncFJS1LpuZEHpLbtdXbPfX7R0FH4rbYBzSj93XFdBZancyQddpB6CThNJVIAqOUBB9ypRXV9mSfiKku3DLrmEENwMh1F1n/O3nJ5rP7Ut83QzfzhYnnjmjRPn71S9OMMnSW70rvGvkdhNxgDrisX7XcvF1pp0Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B4nrpy+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F35C4CEE9;
	Tue, 11 Mar 2025 15:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741705760;
	bh=kBXOq6hKD0Z3iV45vJuTkWCbnSSb+VlL+m3gV38sjh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B4nrpy+JZVnzt0mP3XE/lxpGZ7O6inmY0aPGSY+IE+c5AE0QwctXu+1sJlEOXUDKJ
	 VhOYaTtzwbOEdDlxfXcJCHfFl2rGXEQZJoUOL9ssjF4BMDhthcYu9a2FP7R69VCFAi
	 60hk3VpLkzeRp3wNswpKgvaV9rl10zQLOTL0U0XY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH 5.4 118/328] leds: lp8860: Write full EEPROM, not only half of it
Date: Tue, 11 Mar 2025 15:58:08 +0100
Message-ID: <20250311145719.586442551@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145714.865727435@linuxfoundation.org>
References: <20250311145714.865727435@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

commit 0d2e820a86793595e2a776855d04701109e46663 upstream.

I struggle to explain dividing an ARRAY_SIZE() by the size of an element
once again. As the latter equals to 2, only the half of EEPROM was ever
written. Drop the unexplainable division and write full ARRAY_SIZE().

Cc: stable@vger.kernel.org
Fixes: 7a8685accb95 ("leds: lp8860: Introduce TI lp8860 4 channel LED driver")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Link: https://lore.kernel.org/r/20241114101402.2562878-1-alexander.sverdlin@siemens.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/leds/leds-lp8860.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/leds/leds-lp8860.c
+++ b/drivers/leds/leds-lp8860.c
@@ -267,7 +267,7 @@ static int lp8860_init(struct lp8860_led
 		goto out;
 	}
 
-	reg_count = ARRAY_SIZE(lp8860_eeprom_disp_regs) / sizeof(lp8860_eeprom_disp_regs[0]);
+	reg_count = ARRAY_SIZE(lp8860_eeprom_disp_regs);
 	for (i = 0; i < reg_count; i++) {
 		ret = regmap_write(led->eeprom_regmap,
 				lp8860_eeprom_disp_regs[i].reg,



