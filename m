Return-Path: <stable+bounces-64813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834F39439AC
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52E41C2166E
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 23:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9808F16EBE4;
	Wed, 31 Jul 2024 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQwnRjh2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B57916EB76;
	Wed, 31 Jul 2024 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470162; cv=none; b=oYjv9a7CAEFMlpGhm4EUEAmgynzzYYgbed5kmAQXDm+WpJaAeHVu1BKyei2hy1Xne4tpH/C3DWDuHhIaS2eMzZDHqIop9kumh0FLTQJyNrnf6oIqIpTAh/kLS2K6JvaY6QJ81IPOmYSK1Ptvw8MNSnu8DyS8lkxtyP40SZeAUxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470162; c=relaxed/simple;
	bh=2jl/1a5d2ylIOUyh5NIIGlObyWPaxNiMOTU0OECXk6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXf4G2JlZ6jHmMiwGqvUWDPD8cq2jTCCikZ8TAWiI1i8NFb/P9oYNfyNNxIYQcjpx7SG90TJ+D8s8TeLjwphVfqII++ddfryaZIZNckHoownP/RB3RlzBHzVNUjB/mAgtxHEhQfNdcvEmY39kTfx9Bztqj8igPjKAlGAE54Vv6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQwnRjh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7422C32786;
	Wed, 31 Jul 2024 23:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470161;
	bh=2jl/1a5d2ylIOUyh5NIIGlObyWPaxNiMOTU0OECXk6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQwnRjh220Ojn7w4sLVp52VCEvAThs39Y9F7cQIWU7KF3j3NSg+LTRB0njW6cL/p9
	 Qve8rmCz4lUw1FAJt2kRGNcPld/XrltrQ4KuuRxdNwV8PtZ+lUHShoAKGWBHUWwKTG
	 UtpqGkPcmQUbXXXreaX5pBp1jURIQUw3sghfnizuoIAOteiKKAHc8Tg33K8Lf87Imr
	 atpoDJb5fPKhCaJyFCea2Sz+Ag6+vH9f7MAAGKEkSPOVArmdMdWEH6BFk7zAPbdQme
	 T6/R/mGDMkWNxCLRBMOXICWl6ZYKwJBXdQCaTP/QHU4EmH58kEttxMZxwLo9RMDXR0
	 DNMCaRYP1VIyA==
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
Subject: [PATCH AUTOSEL 6.10 2/2] nvme/pci: Add APST quirk for Lenovo N60z laptop
Date: Wed, 31 Jul 2024 19:55:56 -0400
Message-ID: <20240731235557.3929433-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731235557.3929433-1-sashal@kernel.org>
References: <20240731235557.3929433-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index 102a9fb0c65ff..19184b26920d9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2932,6 +2932,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
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


