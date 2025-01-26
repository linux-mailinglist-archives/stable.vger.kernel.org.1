Return-Path: <stable+bounces-110611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61786A1CA92
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1728E3A4018
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73511DE2C7;
	Sun, 26 Jan 2025 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPmou8Lf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335A1DDC35;
	Sun, 26 Jan 2025 15:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903648; cv=none; b=LSR5rohrW/LwEIY2XZM9YeI6dXwnjAMKi1mRZvONWNQZhyod8sQh4UQMQtuDNefqv9AD0QDmZ/bJdfj4drm9k+PiB0+8tgaMaFLou04lPYJEuhaHkQk4uJxSSUqaMhsWsgVTUo0xbDtLmr6Yw04mMu7TtafLwsN7lLq/udczwPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903648; c=relaxed/simple;
	bh=CUsXLr4W40Q/yqnnXpzRJxtZvO6XB9k5Rb+rgCdz5wk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cnfmivY3+jR6SdOl2YyP93depUxspsZO5hf3Io3D99d3X1hIFgK6+BEYuBSU4xzDqcJL9jDpL8SQ49KEHUPapdiEDoZSsq9B7qVJDrdZOOqdu4TmYwnZLBRltI6n6RI2QRuBu3G7bRz8BotEUG7git4VcbDdoARIYPPWaLXq5EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPmou8Lf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706FDC4CEE2;
	Sun, 26 Jan 2025 15:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903648;
	bh=CUsXLr4W40Q/yqnnXpzRJxtZvO6XB9k5Rb+rgCdz5wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VPmou8LfkPJiu8wY3ARAYl7ISG1Bl9VgzNYhuffW2UiWRXWHyfMrLP/ZR8bAixnE6
	 axuiIaxhVNvKFaANDr3jpwwCxlSPG8D1LpJTMB8aoq1ahi4gPofwTvAXhNcXwqqxz5
	 GOWr3Mevm73fyBB9XiJoE5Dyoa8s85C7NnbQ0vT7CqOW+snvKE6mQ3G42u88LAwAGU
	 mqb6+5TvOzfVmsEgaWtKtAi6w9pFinJMlkvGvBbcabxaHZwfO3xVHVnHQbMuZBwUdJ
	 ZjyDKVkS7SB+CBceiopPysj7+kImDmXEhvasaSDe0DSlI75FA2/ODHvWnOnVcF5xDb
	 L50janJ4SqCGw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ptyser@xes-inc.com
Subject: [PATCH AUTOSEL 6.13 10/35] mfd: lpc_ich: Add another Gemini Lake ISA bridge PCI device-id
Date: Sun, 26 Jan 2025 10:00:04 -0500
Message-Id: <20250126150029.953021-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150029.953021-1-sashal@kernel.org>
References: <20250126150029.953021-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 1e89d21f8189d286f80b900e1b7cf57cb1f3037e ]

On N4100 / N4120 Gemini Lake SoCs the ISA bridge PCI device-id is 31e8
rather the 3197 found on e.g. the N4000 / N4020.

While at fix the existing GLK PCI-id table entry breaking the table
being sorted by device-id.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Link: https://lore.kernel.org/r/20241114193808.110132-1-hdegoede@redhat.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/lpc_ich.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index f14901660147f..4b7d0cb9340f1 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -834,8 +834,9 @@ static const struct pci_device_id lpc_ich_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x2917), LPC_ICH9ME},
 	{ PCI_VDEVICE(INTEL, 0x2918), LPC_ICH9},
 	{ PCI_VDEVICE(INTEL, 0x2919), LPC_ICH9M},
-	{ PCI_VDEVICE(INTEL, 0x3197), LPC_GLK},
 	{ PCI_VDEVICE(INTEL, 0x2b9c), LPC_COUGARMOUNTAIN},
+	{ PCI_VDEVICE(INTEL, 0x3197), LPC_GLK},
+	{ PCI_VDEVICE(INTEL, 0x31e8), LPC_GLK},
 	{ PCI_VDEVICE(INTEL, 0x3a14), LPC_ICH10DO},
 	{ PCI_VDEVICE(INTEL, 0x3a16), LPC_ICH10R},
 	{ PCI_VDEVICE(INTEL, 0x3a18), LPC_ICH10},
-- 
2.39.5


