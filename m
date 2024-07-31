Return-Path: <stable+bounces-64819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7B79439BB
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47DDE1F217B4
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 23:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D03187FFA;
	Wed, 31 Jul 2024 23:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Enfic/QW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D98170828;
	Wed, 31 Jul 2024 23:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470178; cv=none; b=G6tmVMAakc8bXQoJt0Gz4ogMyPQohZYmVAwgUtTItSlZ3ZRMbohJIvDFCS/mKfZ2SPaIhAWv/N+lIN/OGwf3a0Zb3xR36E8af6LKAZqYAPqjL8DivEm1DTCkUgCivZyGG+MkO94D72XRZ3t7VNx9IvogkGEmwg6z8zQrZWvIooY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470178; c=relaxed/simple;
	bh=T4sw8rKiOXTbYAT4aUb2OMUCS8f1KwLr5ACCRUuIPKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdBtpp3G3L98YpHT9ah+E+MiMtWibZdVbsZf0QdB08uSbqL+C3SmQN9SCPiRZyYV8U34bdOVeInBJMyUNYeeRG5IdAMGy0J4dsfRqagkPvEdLFQ5c6GlX7i57D7lk69K0yiRGtXzQTWkV0s1AH1KjZdBrzdtiaopYvKW06o+40g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Enfic/QW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6404C116B1;
	Wed, 31 Jul 2024 23:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470177;
	bh=T4sw8rKiOXTbYAT4aUb2OMUCS8f1KwLr5ACCRUuIPKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Enfic/QWWXq5c7KRDH0OMzjCJkkJtxAUgHe4KdrXcFehOHhvqocCT5dU0+jwrPDjV
	 Knh8ZY5pZ3+2rQPCmOpv/mKfwXrML+h1XkP4AMmEruiIQuLYG+zmP9Z7+pCklUAHVh
	 ClCM6mnQNuQTudy/jn/9xjJWuIfUEBnNXkajpEz5uFFheIt3q34fa/ni7iENI3BEVp
	 D/0yWpuglPCroMVZnB/4O5/gdzQLQgefND3ty16C/umeQ0jWLUCFee/RgnFo04L2dK
	 YOKZSyofCetFDld59x9iD7gIiZcbsu1UB9A72Zm4IHnI6tryh7xzR6qC80QzVooJc3
	 XGto6CQjmyxOw==
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
Subject: [PATCH AUTOSEL 5.15 2/2] nvme/pci: Add APST quirk for Lenovo N60z laptop
Date: Wed, 31 Jul 2024 19:56:12 -0400
Message-ID: <20240731235613.3929589-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731235613.3929589-1-sashal@kernel.org>
References: <20240731235613.3929589-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index 5a3ba7e390546..d73b8eb76b8f5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2968,6 +2968,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
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


