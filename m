Return-Path: <stable+bounces-193250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D85FC4A162
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48AAF188E52B
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 00:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E545024113D;
	Tue, 11 Nov 2025 00:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fK2bH6+V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EFA1C6FE1;
	Tue, 11 Nov 2025 00:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822722; cv=none; b=kC+YCirTiM+VVviWPlV4gS343fbSPzWNez8FrQrl+d4wkqCk6MMHmAQOiK1hGhQShDYse9R9CJ9qMgSndTGr5TIXsR6QasULPeunTMA8MkW6TxxQa9zKFXFjh0Vn9+sfqijDIswUb8kui3+CtSiDsfg2uSTcEIorX+hkKJtZs0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822722; c=relaxed/simple;
	bh=6Jh99eqotPRXwq0XcX+MbNqJ/rvf2W8XSj8Osr4D5ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFCAGyaZgmInum6w7itQFms+SB2XGl+A5mrL9B97HFGzx42u5mSqgHZCmvAQqjG0HzHZdjpNAfzeLIJSQlowcxAhVqT6jMbbDSWO/nqw6TWyCsgVpGPfwe/puTwS+YPbZqXoIbFPuVLJLTXyvwCcB5G8q8fXmXFToFDP3ySBU2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fK2bH6+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3954DC116B1;
	Tue, 11 Nov 2025 00:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762822722;
	bh=6Jh99eqotPRXwq0XcX+MbNqJ/rvf2W8XSj8Osr4D5ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fK2bH6+VyofUpjjHKGIZABQ18lLnjHDWZonxRsQVuVtWpbtP0mpGr5kMW7Qi83JWf
	 UnK/TZomYayiXPGaOZvKVkzuzcUYwneSeBo8N/8Qya9watSuVN+CuueR10hXcgsN2e
	 2PpJRzxzuXtkdcop3XmDrBh9VVvEF7G1JgdjbVQU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rong Zhang <i@rong.moe>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 155/849] hwmon: (k10temp) Add device ID for Strix Halo
Date: Tue, 11 Nov 2025 09:35:25 +0900
Message-ID: <20251111004540.175162335@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
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

From: Rong Zhang <i@rong.moe>

[ Upstream commit e5d1e313d7b6272d6dfda983906d99f97ad9062b ]

The device ID of Strix Halo Data Fabric Function 3 has been in the tree
since commit 0e640f0a47d8 ("x86/amd_nb: Add new PCI IDs for AMD family
0x1a"), but is somehow missing from k10temp_id_table.

Add it so that it works out of the box.

Tested on Beelink GTR9 Pro Mini PC.

Signed-off-by: Rong Zhang <i@rong.moe>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20250823180443.85512-1-i@rong.moe
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/k10temp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 2f90a2e9ad496..b98d5ec72c4ff 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -565,6 +565,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M50H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_1AH_M90H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
-- 
2.51.0




