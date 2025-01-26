Return-Path: <stable+bounces-110644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47580A1CAB0
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C30C87A19D4
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508C620AF6F;
	Sun, 26 Jan 2025 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJnQUiSy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026A020AF6A;
	Sun, 26 Jan 2025 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903747; cv=none; b=E0cml1cGhZwH04fxKhcD0aocOfzggcU21mjxdQh+xc2RI0B0SgP60JoF3ya7Nl7dkPwvU10RYaIX8u8wtrNI/z7jItj4BtQjv/1hiwmmiOnEuADc3iO0c6VvSFoYpXEl7Gk5eiK+TAQMa1q7ly0MGlm0qQARW4snorLy6nGwy7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903747; c=relaxed/simple;
	bh=CUsXLr4W40Q/yqnnXpzRJxtZvO6XB9k5Rb+rgCdz5wk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=URwTZaI/Dcgxv7qN0ZYm4GVv8Xg7C1xP84qAC9n7fdMx/XnzbBy/nI6fVkVhB6zw+sSesqeecaGRQgb3PD4K9im20uzfoe1vTgHQh1sMm9TZ5e6yL39f6pf+d5rqwfE4ZL2vXeGYjLo8jM4HCq8+dXQsnkJaGj/O0JSXrv5+SyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJnQUiSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B916C4CEE4;
	Sun, 26 Jan 2025 15:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903746;
	bh=CUsXLr4W40Q/yqnnXpzRJxtZvO6XB9k5Rb+rgCdz5wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OJnQUiSy7jJhOSokaU9YJ1MkExKSOJ3KwYY/ZEGXi2dOAKHWpsiOSgsr4y8bpBs+B
	 l/gLV9NFwcs6OJ2jOKYOyqEtvlrzPKFoPrBPY/W8pJrrwYDhYXKGsvRXEU1fjg+tPu
	 4kcRzOGNDRJitpsTICYrNV6+VkrdHqZIcyhOIOaBBx/E9dX8Cpts5IfZY/osDu12QM
	 2Q3y44njYwzfYZpDoMIwyJP8rKfhJMC8sih75t5t/gWN9M9f0WNAFi5Bmp0o7QEKOg
	 oOgyQNDEuCONu9Rmo5RUuqI8j03whf15gPH0gh7lVzKbmdEkFO6UEsCyj3CSueCkE4
	 +8Sy3cx4S/U3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ptyser@xes-inc.com
Subject: [PATCH AUTOSEL 6.12 08/29] mfd: lpc_ich: Add another Gemini Lake ISA bridge PCI device-id
Date: Sun, 26 Jan 2025 10:01:49 -0500
Message-Id: <20250126150210.955385-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150210.955385-1-sashal@kernel.org>
References: <20250126150210.955385-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
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


