Return-Path: <stable+bounces-47542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5465A8D11E3
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 04:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D77B230AA
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 02:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2886B757E7;
	Tue, 28 May 2024 02:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjEmpz8p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B9F73163;
	Tue, 28 May 2024 02:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862766; cv=none; b=XSdmQ3R3nchWUASlxB6LUsNPBSsVX54frsRwRKu1pbdtiPY1WJIlT5v+70cXz8m4J/tEOKDa2zQgCFepK+4fEn3epnZCiuVRHd4FclLBTp80SttwifS9ABx9lzpnW3MIf8vFqvrgFWvBkkYjCu/+/1wGDHlOdzn+H3CsF7Stbfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862766; c=relaxed/simple;
	bh=KbLJ8iuj1MgM/BPL9938h3XrS3pqEiig6CcYiHlIp2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biEtNr5uB597DJjfLpE1XHgmGEZZMMxNIyit6X175+BPxlwZGTYbdL4B+OQuyZnzn75Mng6PDZ8aEGRtWGJQYTCjUZHnb6DTssncU1JeLELx5qxAxGHsOVMLz0Myn8NJh7JOUZjNJ21/Y5Y9EDwFke4QdPwAhGcZA15giohkXSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjEmpz8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A967AC32782;
	Tue, 28 May 2024 02:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716862766;
	bh=KbLJ8iuj1MgM/BPL9938h3XrS3pqEiig6CcYiHlIp2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sjEmpz8pbhBMCPC3e4LLowKCcZ+jTPgxTI4R43CqBDxoYW15P7W9kSKJMeAgGv7Rq
	 TiFyYatbGXcPEO4VHY2vgQv1zaRwz0v2W4VYDE9KJSSaVY6scLS0zh/0uVwb2OPwOd
	 oauV1dxCroVYopMIJQKu06/oQ7r74ji3OEcmCdPUhTbBlY0Xm+4WeqffL80ADVl1K1
	 oqk2WosGS+yXnChlk9fso5p5bObePCyYF6j8nO1Xxkne6ok16FjVcM6yRjCsU+7Isa
	 o+3bPwYFh5GPSHgJbemoRc0E4SP8aJtDJxrmujqsoB5/aSKjbNVdrvPRsKjgjq/htq
	 emvI3nwDKCN1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksandr Aprelkov <aaprelkov@usergate.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.10 2/2] iommu/arm-smmu-v3: Free MSIs in case of ENOMEM
Date: Mon, 27 May 2024 22:19:21 -0400
Message-ID: <20240528021921.3905481-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528021921.3905481-1-sashal@kernel.org>
References: <20240528021921.3905481-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.218
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
index 982c42c873102..9ac7b37290eb0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2925,7 +2925,7 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	}
 
 	/* Add callback to free MSIs on teardown */
-	devm_add_action(dev, arm_smmu_free_msis, dev);
+	devm_add_action_or_reset(dev, arm_smmu_free_msis, dev);
 }
 
 static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
-- 
2.43.0


