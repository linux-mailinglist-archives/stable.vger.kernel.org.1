Return-Path: <stable+bounces-184972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9C0BD477B
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D693B86F8
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F177930FF24;
	Mon, 13 Oct 2025 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g879muXv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17A730FF13;
	Mon, 13 Oct 2025 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368967; cv=none; b=RwAsu8vQoD1g9eLyHEh7SbE3fMRKXDqrbduPYs0/UzggzB4ckc1o9U4uS7MnEnJfrBUkApATGupH0fw4YT5o4wlY8+c49ERolKFBGXhUz+DyfrHTXpsEGpozR//YfzrzlRPbkCuKP9LvEotLs2IL6I9vk5oYXV7EQKjiR1KhK5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368967; c=relaxed/simple;
	bh=hary/BSstPWp+DnTpc7Don5W0EK4LdlhGRSZvg7B+Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJM6353CLet1aCtjVPfTiGtgobahMKYyzZVRR6cRCLYU0lHjMvz7iUcDjN5tUdYoHF8YckqRecyimDxJl/Lotbvh9TOcjracIuTLvk/9Fgo12jjvj5qy6iE5VECpZ3NG8BjmiBC7jIJxjkOOL6SCaILg5To2vIMWnhb2onnWyt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g879muXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40F2C116B1;
	Mon, 13 Oct 2025 15:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760368967;
	bh=hary/BSstPWp+DnTpc7Don5W0EK4LdlhGRSZvg7B+Ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g879muXvAFwc6LYcrdavSsNhlOUKXs9bqySwRMftozj7u5SDImyhS6t3jaOJTOsXe
	 5znwVpMErk99dR3g7WtdO7VzXO/CtKLMkWvPk51O1AH/AADBedCKXp7wCnVYEf/m80
	 /EotIqRHxTuakg95dwbKQNuqMXBRiVRJjFRAjanI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrei Lalaev <andrei.lalaev@anton-paar.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 081/563] leds: leds-lp55xx: Use correct address for memory programming
Date: Mon, 13 Oct 2025 16:39:02 +0200
Message-ID: <20251013144414.231473384@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrei Lalaev <andrei.lalaev@anton-paar.com>

[ Upstream commit d6058316d16ee0d1861c0550051b2492efb54b79 ]

Memory programming doesn't work for devices without page support.
For example, LP5562 has 3 engines but doesn't support pages,
the start address is changed depending on engine number.
According to datasheet [1], the PROG MEM register addresses for each
engine are as follows:

  Engine 1: 0x10
  Engine 2: 0x30
  Engine 3: 0x50

However, the current implementation incorrectly calculates the address
of PROG MEM register using the engine index starting from 1:

  prog_mem_base = 0x10
  LP55xx_BYTES_PER_PAGE = 0x20

  Engine 1: 0x10 + 0x20 * 1 = 0x30
  Engine 2: 0x10 + 0x20 * 2 = 0x50
  Engine 3: 0x10 + 0x20 * 3 = 0x70

This results in writing to the wrong engine memory, causing pattern
programming to fail.

To correct it, the engine index should be decreased:
  Engine 1: 0x10 + 0x20 * 0 = 0x10
  Engine 2: 0x10 + 0x20 * 1 = 0x30
  Engine 3: 0x10 + 0x20 * 2 = 0x50

1 - https://www.ti.com/lit/ds/symlink/lp5562.pdf

Fixes: 31379a57cf2f ("leds: leds-lp55xx: Generalize update_program_memory function")
Signed-off-by: Andrei Lalaev <andrei.lalaev@anton-paar.com>
Link: https://lore.kernel.org/r/20250820-lp5562-prog-mem-address-v1-1-8569647fa71d@anton-paar.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/leds-lp55xx-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-lp55xx-common.c b/drivers/leds/leds-lp55xx-common.c
index e71456a56ab8d..fd447eb7eb15e 100644
--- a/drivers/leds/leds-lp55xx-common.c
+++ b/drivers/leds/leds-lp55xx-common.c
@@ -212,7 +212,7 @@ int lp55xx_update_program_memory(struct lp55xx_chip *chip,
 	 * For LED chip that support page, PAGE is already set in load_engine.
 	 */
 	if (!cfg->pages_per_engine)
-		start_addr += LP55xx_BYTES_PER_PAGE * idx;
+		start_addr += LP55xx_BYTES_PER_PAGE * (idx - 1);
 
 	for (page = 0; page < program_length / LP55xx_BYTES_PER_PAGE; page++) {
 		/* Write to the next page each 32 bytes (if supported) */
-- 
2.51.0




