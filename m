Return-Path: <stable+bounces-64817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD2D9439B6
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089241F2192A
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 23:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA54B184537;
	Wed, 31 Jul 2024 23:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQww0nR2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842DA184531;
	Wed, 31 Jul 2024 23:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470172; cv=none; b=gsb86ATSfsjbTWu6+IGwWActAwCiXQrvwSTnBLZw/n5fbxhUzdTUp2UJMhXTKHijW601D5pMaN7OqFpkP4l2SNRs53SDIX6Djs0nxA52pkh6+WbBcnnHSz1QuDW+ZdRGtr7poSGzCWgLu82vUOcFzZSrcOwbcEa/vV6EDM8jIME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470172; c=relaxed/simple;
	bh=8Jk9+KZ3pS8c9MGVpuW6nmS2TGspvDsBbVKytT89wAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATDFIz3UONYTkU8ufAXkUDtSdkw3noBbD+ngGP7OI7gRGMuqqdveXzjqGsScdNT7g0FdYYKggv2Mp25lJVqNQZvvxb5Qextmy6N70PhVwgULGq1BP3K6WKm3bVg5M844Mtb3/sO0JyxDwaPnwYY7LHDfRKYQlxGyD+jFrYgF/DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQww0nR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E22C4AF0F;
	Wed, 31 Jul 2024 23:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470172;
	bh=8Jk9+KZ3pS8c9MGVpuW6nmS2TGspvDsBbVKytT89wAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQww0nR2kXfGuuOuLARiY77t11SYXSVd8DFR1L+0aO2Qj+2tH/q/00eXO+ZRcVklr
	 1IMmafpX/94/s59Eezc/Fy2lUnlBJQv11HnIQOkRl9+gNtNM2uaM48Ao/Wtr3KwFuV
	 tRUwFHrF3N2zqlldEn1cZ2Gi1QUpXv+Cg/xEKsB6vDlfOd/XNhsVGsKHq63ODEfu5A
	 SgjFcdnE866yehY/2wwhTMhOp/Wo4KodLQK9kvgmsZIgeRyzmV57mBaX15pd+2SF0M
	 1KlQ0LSQWbxCNGhqEjw723Ese3Zi+g7M0OT/R9gCGPBP7eVzWIO4awPuIyg+pdklws
	 6HYkEjY2q94EQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: WangYuli <wangyuli@uniontech.com>,
	hmy <huanglin@uniontech.com>,
	Wentao Guan <guanwentao@uniontech.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 2/2] nvme/pci: Add APST quirk for Lenovo N60z laptop
Date: Wed, 31 Jul 2024 19:56:07 -0400
Message-ID: <20240731235608.3929537-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731235608.3929537-1-sashal@kernel.org>
References: <20240731235608.3929537-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: WangYuli <wangyuli@uniontech.com>

[ Upstream commit ab091ec536cb7b271983c0c063b17f62f3591583 ]

There is a hardware power-saving problem with the Lenovo N60z
board. When turn it on and leave it for 10 hours, there is a
20% chance that a nvme disk will not wake up until reboot.

Link: https://lore.kernel.org/all/2B5581C46AC6E335+9c7a81f1-05fb-4fd0-9fbb-108757c21628@uniontech.com
Signed-off-by: hmy <huanglin@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 32e89ea853a47..15b768736b9f8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3108,6 +3108,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
 	}
 
+	/*
+	 * NVMe SSD drops off the PCIe bus after system idle
+	 * for 10 hours on a Lenovo N60z board.
+	 */
+	if (dmi_match(DMI_BOARD_NAME, "LXKT-ZXEG-N6"))
+		return NVME_QUIRK_NO_APST;
+
 	return 0;
 }
 
-- 
2.43.0


