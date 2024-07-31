Return-Path: <stable+bounces-64823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA529439C6
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0198B20379
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 23:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1005189BAF;
	Wed, 31 Jul 2024 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfiol3eQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8BB189BA8;
	Wed, 31 Jul 2024 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470188; cv=none; b=o6xeDd0FvPDd5hA76sNOMNw1/DIjOnLjHHBJYmnmcEouVUkrqwTmc0feVkyBFMhpY3NyIaZdv0oQIwoR3J74oAu/Hn1cExRmF/NssJmHO5wHRFOglizEGPYDKA8E9r2FMDd9gb09ZYR7bVDy8xcr7wvS9bQq0XqToWBIJI4x2TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470188; c=relaxed/simple;
	bh=QtboQ5fxJmEorxCHqjzcYckd8B+t2Q5YktnNVTP0358=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vbs5ZSTcVbHRxszjVh13CGi2C1Bmss0i4UuWyCso0qmRkoActGlX6rl5CQOxdXM4yQtrbK7B1skVQX5rjeEstddwXBLH6TrCA2dC2gRDKve2kiJwW/Ezcd5MaDYwDi2LQODibu8AtKfm7NjRXPZCPy5KoqMlBiB0WS6OkLpBv/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfiol3eQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDA0C116B1;
	Wed, 31 Jul 2024 23:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470188;
	bh=QtboQ5fxJmEorxCHqjzcYckd8B+t2Q5YktnNVTP0358=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jfiol3eQ8d93gn6YwLi4X7ny1EOZL0zae4qaPJ76WWtfVrCOhqa6bIMg4NQCHmoPb
	 um/sw8tHsmQqSw7/Dl7kMt6Jh32rjY/yeKLVfsID+PMqOl0EzDXknTgO+UCKjuI9gS
	 pe/P2E+staSUpY0ywb+s4l9tFd7F+cfaEK1U0/3ut96PyT2Jpw3eqKMtVzp1bXjnvI
	 k+w5oP6DkaimZ+dcJEZLp7d6iQCGrYormTibxXzXWjD+D/P3kj2Kxs3a+Zakh1fKsJ
	 lPuSeGAtDpTtvqFHy4qhK9o63jZO9a6JQT9ZrGWRclx95mBpm3LKHKM9qsMQexJsqM
	 fgsB5GkbbbF9w==
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
Subject: [PATCH AUTOSEL 5.4 2/2] nvme/pci: Add APST quirk for Lenovo N60z laptop
Date: Wed, 31 Jul 2024 19:56:23 -0400
Message-ID: <20240731235624.3929717-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731235624.3929717-1-sashal@kernel.org>
References: <20240731235624.3929717-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
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
index 486e44d20b430..e4776cff42082 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2821,6 +2821,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
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


