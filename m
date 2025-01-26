Return-Path: <stable+bounces-110690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CCAA1CB81
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00553A46A0
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12DE22488B;
	Sun, 26 Jan 2025 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3Grm6cw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBE2224889;
	Sun, 26 Jan 2025 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903847; cv=none; b=Fzbrv6VMorKvJ0tLgZBXFzWJ93N8pmCtViMFo6g3+NXkiMTxIlyT+WRZjE4m8S5zA4Tzh9/KLyw6XQPWfSwL0h0Xodhw9ROqYIfiRr7YdSWIPENRt0XLRQQYZLnETSQEZkEFeHSw/XUikSTQwxsWEJRaMCv/pDn6VkYIrpFKT3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903847; c=relaxed/simple;
	bh=S+TT1a07YLwKpDsU9KvkyTpwGHYmBWYne8Em3eS41Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SQUMR4Atz/Q30F2H1ypc0BjZJi8Een7f5auAWANyASeUgD2oKMzifBYJ5VQB3zxQw4qA+RQ2C1d5QCwLChnX8Wnle1mzPp1qNIykBDipJfs8ar8QiKzIvlZakRv+7ROK7DWv3CqGKogf9NQ8F1kQ2kA7id/KCHUY3Ao/BzAa+kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3Grm6cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1630EC4CEE6;
	Sun, 26 Jan 2025 15:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903845;
	bh=S+TT1a07YLwKpDsU9KvkyTpwGHYmBWYne8Em3eS41Tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K3Grm6cwWe/JShk7r27d2+4CJfGJuYrFWX0q73G+VIkrxFNaCwxXDw9W6RhlD409v
	 ViAcsMuM2AuFyLxR5Pz+RrsxgZDDKwMalIgH4kJGNMkKvJLel/NU7+PkcGyqvpLy0f
	 /7skExTkWn7+K9390sYy+D5Wn0krAlffnn8St2YT8HgbncmLbC1gnkxAdJTGNJ4gVO
	 EkcKPayubl3NUboFKnIEkPA9e3Lz0UCzoHIcOiXtTj9/m+1Rx2ALi1rEXEtmw1u6XA
	 69E57VsPdiITTPHiCDDddJBQu3Z+flPiZgG4YC5sOKfGr9cwWnKDVyxg76g+IR0clt
	 4LSDEakHIsNaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ptyser@xes-inc.com
Subject: [PATCH AUTOSEL 6.1 06/17] mfd: lpc_ich: Add another Gemini Lake ISA bridge PCI device-id
Date: Sun, 26 Jan 2025 10:03:42 -0500
Message-Id: <20250126150353.957794-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150353.957794-1-sashal@kernel.org>
References: <20250126150353.957794-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
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
index 7b1c597b6879f..03367fcac42a7 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -756,8 +756,9 @@ static const struct pci_device_id lpc_ich_ids[] = {
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


