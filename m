Return-Path: <stable+bounces-64815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B649439B1
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588A51C215C1
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 23:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB104183CBD;
	Wed, 31 Jul 2024 23:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="be3BsEL0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7854E16F8F3;
	Wed, 31 Jul 2024 23:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470167; cv=none; b=sqY0WSadz8oI5KKkTQ78qFr9CfxDLNKb+z7T6uv9v9nLMDWz4lC162KRTwcHB8RLeQdrBQBRRnjMeIMhMDP+6cadM4mjZ4UsYKpnPW3Fb1MyPZJng0Ovme2/JCMzPdWW+iEsf9ZaIJucGIzbecouAwuMIyk3Z2Zlfh+/xXzQDss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470167; c=relaxed/simple;
	bh=J5A+VaynqsB56aee4iFU6MhjpOJp9RxqKEdz1mR9oyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSWj2qZZcHSdmx28BOH4EonsByeveO5a7zifDyWPmod3rMYEUOVXmrYjplKKqG67Ve5LXqJbbaVm1Ovx26cU1lxUsL6ayVsqt22480cw6HBcdjCBbYNTEhhOXVa9DkOBT7Ya2ZDzHske1h7SeiotvU7tFXYIJAOiySON4+V6+Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=be3BsEL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002E2C4AF0C;
	Wed, 31 Jul 2024 23:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470167;
	bh=J5A+VaynqsB56aee4iFU6MhjpOJp9RxqKEdz1mR9oyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=be3BsEL0XY0nzaerfBV+uc1e3PSrj9LOdOuUFbfUqDBmMlgfXqtZdUd9hiQ4kAusu
	 sC/0UQL50l54c3+fXyjzZu+V4fNpVVPJ2Z8ej4bhWowXWkUYr/wNEdgiBV/6y1d2Xu
	 fPMrqxfoac1HI9uO57urWhMlDKtbzgtyFGeA2MOIfCbXKg5DgXWCANgEK0fnzIJSMO
	 Ka1MXDy8h+gUqE5wpsruzwj3l8jHc7rdKLHe1Yo14TIv7OQF2fhPKeKbEn7Lik84fN
	 U7ND6ViRl0CZVNKJkQHmMwBTG7Bo/MJwzHEJQ7+fQy+wq3ebeS6r8rgyommLP1g+Nc
	 WAzZuU4zeBN/g==
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
Subject: [PATCH AUTOSEL 6.6 2/2] nvme/pci: Add APST quirk for Lenovo N60z laptop
Date: Wed, 31 Jul 2024 19:56:02 -0400
Message-ID: <20240731235602.3929485-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731235602.3929485-1-sashal@kernel.org>
References: <20240731235602.3929485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 710fd4d862520..ca485e5e31896 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2930,6 +2930,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
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


