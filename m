Return-Path: <stable+bounces-140621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36F6AAAA24
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D29467A1E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3830E377649;
	Mon,  5 May 2025 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2QCaRF9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BB92C17A0;
	Mon,  5 May 2025 22:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485373; cv=none; b=dInylSbk6yQB+Vr065YXOsAtpql362/Qm7N6WdSdSi5bTyA6I1HHPE0VE9EhSpBYaBOquRKKWgted9Cc0MLPyFg8HYbm+ZYsstFYj+r6hnWajD9D8MNi3Hd5FONa3wtloRaAsMCNO8kPRNaWUEKkr2MUw0HSok4QgF5Jk8fEoLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485373; c=relaxed/simple;
	bh=oWh6utGVMzCnodEAboCMwtV7BDi78kZURU9WXd8r9ng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JrJfwhu/NCoWlhZDXKzJZLwFJHKBmw8sgQ9XPlEoGR0NNrN7o47QrR9nYl6fyQRjBgJVf3yY8zDqE1Dm+vU/2duxhVnrGtD3nO+xtErPj4RSGqgYd65Of69etXBuZE4qFZJxExLpzDj/HOG950tHYc6nb/KWg2JZ7uMvbrI+VP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2QCaRF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD43C4CEE4;
	Mon,  5 May 2025 22:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485372;
	bh=oWh6utGVMzCnodEAboCMwtV7BDi78kZURU9WXd8r9ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D2QCaRF99E3hClrn0ILacH9bIvSbS66eOaiLEZ9/dWoeYOsAxM9tyBmhqHsK/GFCK
	 z75zxIlqvSJbiqbpHbzU6u1fLa+X7Mi/++/uSjod2O6r+pvcp+VygucXAwiGDbZ94D
	 L6xP2cNdJdGyYa0W0iyKB7Epgr9wMzOMSvW9TSsZza/N/s27Nc6Y+q1u9k+SbbipfJ
	 pwz2ZeBEFOOPFzuE0mVKpTtfmQN+CLEgdajScsDl9IIfCWLVaBcjKdYWqekMjFWQNK
	 tTFuk+dHdcdTBiHcK6yK56uTtcnplc6qBwYwS8Nz7RZifupVwCJmeJ7+JBiycAl4V1
	 IX+68P2qWtvXg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chris Morgan <macromorgan@hotmail.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	wens@csie.org
Subject: [PATCH AUTOSEL 6.12 296/486] mfd: axp20x: AXP717: Add AXP717_TS_PIN_CFG to writeable regs
Date: Mon,  5 May 2025 18:36:12 -0400
Message-Id: <20250505223922.2682012-296-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

[ Upstream commit bfad07fe298bfba0c7ddab87c5b5325970203a1e ]

Add AXP717_TS_PIN_CFG (register 0x50) to the table of writeable
registers so that the temperature sensor can be configured by the
battery driver.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Link: https://lore.kernel.org/r/20250204155835.161973-3-macroalpha82@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/axp20x.c       | 1 +
 include/linux/mfd/axp20x.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 4051551757f2d..3780929039710 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -214,6 +214,7 @@ static const struct regmap_range axp717_writeable_ranges[] = {
 	regmap_reg_range(AXP717_VSYS_V_POWEROFF, AXP717_VSYS_V_POWEROFF),
 	regmap_reg_range(AXP717_IRQ0_EN, AXP717_IRQ4_EN),
 	regmap_reg_range(AXP717_IRQ0_STATE, AXP717_IRQ4_STATE),
+	regmap_reg_range(AXP717_TS_PIN_CFG, AXP717_TS_PIN_CFG),
 	regmap_reg_range(AXP717_ICC_CHG_SET, AXP717_CV_CHG_SET),
 	regmap_reg_range(AXP717_DCDC_OUTPUT_CONTROL, AXP717_CPUSLDO_CONTROL),
 	regmap_reg_range(AXP717_ADC_CH_EN_CONTROL, AXP717_ADC_CH_EN_CONTROL),
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index f4dfc1871a95b..d1c21ad6440d1 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -135,6 +135,7 @@ enum axp20x_variants {
 #define AXP717_IRQ2_STATE		0x4a
 #define AXP717_IRQ3_STATE		0x4b
 #define AXP717_IRQ4_STATE		0x4c
+#define AXP717_TS_PIN_CFG		0x50
 #define AXP717_ICC_CHG_SET		0x62
 #define AXP717_ITERM_CHG_SET		0x63
 #define AXP717_CV_CHG_SET		0x64
-- 
2.39.5


