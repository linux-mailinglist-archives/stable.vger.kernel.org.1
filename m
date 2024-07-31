Return-Path: <stable+bounces-64821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B719439C1
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F532848A5
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 23:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD875189905;
	Wed, 31 Jul 2024 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGK4qYuX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B83E188018;
	Wed, 31 Jul 2024 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470183; cv=none; b=o2vea2u1zFB3vweqw/gbKq5XQhp2nCupqExa7xGA6EDK8IbNckM8uiu26qQ/wLtKYv2PO9YteQGwr2NTRGQzaWI24LPrehBJxk/O5N+CDHXXLWJ8ZWOCuohUGjgHR9T+a+GW+6OOTYvGwbBPYvdI9gP285J19dHGKvf7+luf/g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470183; c=relaxed/simple;
	bh=kdR2LEy/ink/mBs9qor8KWfMUd9udeGRCCasPf1W8BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frluEy+Y/ENiz0SGLd/QI9VTAWRsZ7iTdIBLw3/jTCiS20cLsDDgptSDwvQJclL7SASxBue94Q8nBX0KTr7AM2Cf+sJ44gVgdhD5btlqSXETCGemN7Ax7HMiqfq+vLa0wwUbUWmuZ7vYkM7z5FTgBk4gAn3Oc1JTkqNmRBXi1wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGK4qYuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21207C4AF11;
	Wed, 31 Jul 2024 23:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470183;
	bh=kdR2LEy/ink/mBs9qor8KWfMUd9udeGRCCasPf1W8BI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RGK4qYuXolk4tvjtwqpIgcGFiPU0R/d9Y4NjufVL6jh1WP/2GCUGW4+EU1B5HF8Kq
	 cduXzoQO6FqofOrSUFYzQaelrC9Cd3r1NLCRgbksSpAuEJbMkM1vPJmPxVi7+0lOSF
	 el9xWO14KeL6mStSWgDBk1QlqipMSnEB0J6E5tPUYTsSxtSyTg4+lLaE41HK22ztwf
	 guX0XB4R5w8qaluoD9QdlvAFPyAfPfiDwG94jMCQfd4uVPAUy26JoglQeLFpbtR6t+
	 7esX9m882octMngiong6IeyQmFkGosMXw5MxZVgWybnrGbyOoNBDxhYkujYF6cQhgU
	 GCjGyq5DLOxeQ==
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
Subject: [PATCH AUTOSEL 5.10 2/2] nvme/pci: Add APST quirk for Lenovo N60z laptop
Date: Wed, 31 Jul 2024 19:56:18 -0400
Message-ID: <20240731235618.3929665-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731235618.3929665-1-sashal@kernel.org>
References: <20240731235618.3929665-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index a7131f4752e28..148996ae80644 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2847,6 +2847,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 			return NVME_QUIRK_SIMPLE_SUSPEND;
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


