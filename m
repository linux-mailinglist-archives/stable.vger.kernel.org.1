Return-Path: <stable+bounces-47530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978B48D11BC
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 04:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5373C283C26
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 02:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A1E29D1C;
	Tue, 28 May 2024 02:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLlJL66q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C14229402;
	Tue, 28 May 2024 02:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862726; cv=none; b=ByXcv5sojew2K8iNPNElZnLUGQlLLPx3SuxNrMyX8Xg95xrerGrVdUVaa+1k51Y0XMUJd2JjJI7/AG0hpMtcf2LjOREte0eKJdj6aGFzbzf0EgTfwX+KYgWGNEcCZs+DFhUuq7L7/MFt86N84fh1vpdAbJMFc5vomFqwhlCe+XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862726; c=relaxed/simple;
	bh=/y3TuOamaSzqh7hV7VFaWnajUt2YPaIpzkp8Ve5If5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlWSPHd9vL6hFYCLcqkTndZBsnJ5F6Xm8WpTH7fkbFSQGC8mTh3NI+cwQRp7nWkyKfQoMLcS0N4xlbxQGHf/p8JVSXIf/27fwnSABTVmPmCd+PjQwsjsgLh705/k44TIDGLA1iTMsZMCjsJKKqAEkTfC2D7R4/1goHp7PF0TuY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLlJL66q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E6FC4AF07;
	Tue, 28 May 2024 02:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716862725;
	bh=/y3TuOamaSzqh7hV7VFaWnajUt2YPaIpzkp8Ve5If5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VLlJL66qm50OVnDbMixs6fJE9U8qA3vTWbtHvJnn4ATlBxXhkEIDd3zdRFpaGBSkI
	 j1DaIz3wjH2F/4wl3QRH+KoJzh5avILv9TxwwA+hDoFjz3wdtfXRFl0WoI6eGPBIuG
	 X14AcqJrkqm91hFV3bDyjAwsTPgHTggD6yKTZATN7LWObd8bDcRK7Dqo8LyM6Sc92n
	 3jfQ8XF8zCmliPnb+0QvYGdJ6O5eyA9a4+Z4mkdWJ5aEaTE3iY8wZMINPdwGyPFvXS
	 s2PhgBjW7ZcZYJuNht6BXtvSI1uoCEQmzms9nogj+4A1sDsoVBpinMwt3y7UH5f666
	 lcNkCCJJ+sGfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksandr Aprelkov <aaprelkov@usergate.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 6.8 2/4] iommu/arm-smmu-v3: Free MSIs in case of ENOMEM
Date: Mon, 27 May 2024 22:18:37 -0400
Message-ID: <20240528021840.3905128-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528021840.3905128-1-sashal@kernel.org>
References: <20240528021840.3905128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.11
Content-Transfer-Encoding: 8bit

From: Aleksandr Aprelkov <aaprelkov@usergate.com>

[ Upstream commit 80fea979dd9d48d67c5b48d2f690c5da3e543ebd ]

If devm_add_action() returns -ENOMEM, then MSIs are allocated but not
not freed on teardown. Use devm_add_action_or_reset() instead to keep
the static analyser happy.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>
Link: https://lore.kernel.org/r/20240403053759.643164-1-aaprelkov@usergate.com
[will: Tweak commit message, remove warning message]
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f3f2e47b6d488..5071a8495a78c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3181,7 +3181,7 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
 
 	/* Add callback to free MSIs on teardown */
-	devm_add_action(dev, arm_smmu_free_msis, dev);
+	devm_add_action_or_reset(dev, arm_smmu_free_msis, dev);
 }
 
 static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
-- 
2.43.0


