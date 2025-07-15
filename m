Return-Path: <stable+bounces-161995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40048B05B0F
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 059A47AD031
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BD42E2657;
	Tue, 15 Jul 2025 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R0p0MHFl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4067120487E;
	Tue, 15 Jul 2025 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585394; cv=none; b=gt5iqQSD2w795ORt+A7xNsU52dGrUraK4PZeJwwGqsLKNqhDHWoeT9FfLd8YytQWRg53GtRzlwwJDh5fgewG1Y6CsjopDiHBg4aeI9Fz3/So9nmZlUogDaV4ZWrMIUGiNufwFrCnWO0kjEKaWcXy4L+tBOJkPxAMaUUjZGnV3xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585394; c=relaxed/simple;
	bh=D6xdroMpU7/liPcC7bMHByhUNjboemXv7TwP8tZ7/6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UX3Bzx1BC9MjTUuW5tylTowkejK9XlJO47edtvGbHnNUzOs3YCaUmtelnu2QJ02SFEUOYhjsqBs8HTdEXTA5lhKW3sZbPZyzMY0GfqcoU0NF3e7Z3E6Xjnyy+0xxvq5c3HllI0aD/BGPrJ/VOGO0LzIGg1TxCyTcA49Mze8oe34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R0p0MHFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C19AC4CEE3;
	Tue, 15 Jul 2025 13:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752585393;
	bh=D6xdroMpU7/liPcC7bMHByhUNjboemXv7TwP8tZ7/6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R0p0MHFl1Y4fmX2tyPIQEAlxWiX1GqsvgDw9ieNBm0FCKsyVjhdv4Rooy9ex2CayT
	 i+SzPpbIZlQdGiiQyoLz4pNkQoCJEZ1TpEzlM56lDqmi4/10L+iojwz4pgpmVvGZ0h
	 EXizoTQYtCqsvI/BpokMna1X5nKiuMKfJ+RKtqEw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 016/163] irqchip/irq-msi-lib: Select CONFIG_GENERIC_MSI_IRQ
Date: Tue, 15 Jul 2025 15:11:24 +0200
Message-ID: <20250715130809.423521660@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130808.777350091@linuxfoundation.org>
References: <20250715130808.777350091@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nam Cao <namcao@linutronix.de>

[ Upstream commit eb2c93e7028b4c9fe4761734d65ee40712d1c242 ]

irq-msi-lib directly uses struct msi_domain_info and more things which are
only available when CONFIG_GENERIC_MSI_IRQ=y.

However, there is no dependency specified and CONFIG_IRQ_MSI_LIB can be
enabled without CONFIG_GENERIC_MSI_IRQ, which causes the kernel build fail.

Make IRQ_MSI_LIB select GENEREIC_MSI_IRQ to prevent that.

Fixes: 72e257c6f058 ("irqchip: Provide irq-msi-lib")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/b0c44007f3b7e062228349a2395f8d850050db33.1751277765.git.namcao@linutronix.de
Closes: https://lore.kernel.org/oe-kbuild-all/202506282256.cHlEHrdc-lkp@intel.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index c1f3048360085..a799a89195c51 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -71,6 +71,7 @@ config ARM_VIC_NR
 
 config IRQ_MSI_LIB
 	bool
+	select GENERIC_MSI_IRQ
 
 config ARMADA_370_XP_IRQ
 	bool
-- 
2.39.5




