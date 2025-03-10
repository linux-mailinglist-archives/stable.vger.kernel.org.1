Return-Path: <stable+bounces-121664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D01BFA58BD6
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 07:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417C4188BE0A
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 06:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405921C760D;
	Mon, 10 Mar 2025 06:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTBMEWx3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E825134CF5;
	Mon, 10 Mar 2025 06:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741587176; cv=none; b=SEpWImlioOlG/JHCOXwRnfF/Yztaa5hGw1Hfcb7JYdXfvRCkk1+l0tk+clWCfYMM7PyAPb0oApsYhVXsHxnkiFNEUB0Ub4BTJGtMnQiND1lyUjFYWOn6vQeClUCO238VrKsKinfGIYBXEDThciswBcaJhKertpWBHGrPgU9TEow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741587176; c=relaxed/simple;
	bh=IwqHQDBwSuTVidoWpcAHGXgI2bJZGWVRqXPAmGK7cIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RsA8Zd/ljoDPcgLZ/FrL7QfXbFni2lCmR8AocaU2tSa9oLXKHP7IyH78W3IqxrXGhmLSfQX5sSE98XizwUpQ1pl6+UszWy8vZGOr1o8z9dF2KCOb3ilHpedlFpX5JpL12J4D12F/TG+dy3d0junIP6ovIZuGjgd4qudPZvq4avY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTBMEWx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5F55C4CEE5;
	Mon, 10 Mar 2025 06:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741587175;
	bh=IwqHQDBwSuTVidoWpcAHGXgI2bJZGWVRqXPAmGK7cIo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=gTBMEWx36xc2YFJBnkNLat0KBIILM1y6h0CQvnJ+9k8YdNiSuZVI7Oiw/sCq954y/
	 EViDe1VT51nmMmHXWUgpgxfGQWVhUlu+i1hQQWHKPSPAM46SMPFGKHUzYGlpbq7DWc
	 lmhJroREzgjtOOBe9MyZiqnknNaleSHEsPrZv+tV45Z81Q8E/MiB0UgHNozfGCtxek
	 qoBzEl/Ns8YOxTxeagFD2C4FlQT4EwYVJRKH8SV6LyxcKVYgGMAMIDQeftz0yvc5rU
	 2l/j7OJUsOJ7MQUrk80dIBGSExB1d44aacj4J7qm/yyTYCpKt0BXnv05wjZ5fwUVje
	 5XpmRtkg94KBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A46C282DE;
	Mon, 10 Mar 2025 06:12:55 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 10 Mar 2025 01:11:58 -0500
Subject: [PATCH] iommu/arm: Allow disabling Qualcomm support in arm_smmu_v3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-b4-qcom-smmu-v1-1-733a1398ff85@gmail.com>
X-B4-Tracking: v=1; b=H4sIAK2CzmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0MD3SQT3cLk/Fzd4tzcUt0Uk+TkxDQzs0TD5FQloJaCotS0zAqwcdG
 xtbUAKo+Rtl4AAAA=
X-Change-ID: 20250310-b4-qcom-smmu-d4ccaf66a1ce
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741587175; l=992;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=8mZdDIMzM15RJAJ2ViAymKW4I/RyQ463WLVTHNvdOss=;
 b=VxZlCVYBtjNtBkmmPUW9Cq2dx3v6oxhk7wRY+57QD7wraDxUu2bicinn3sWO5zq0hNa5Bto0T
 /dYzcsQuL2KB5bhHQ8pQL52WvdFKE00bBofObUCQcIpLBHOGJxLGeDO
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

If ARCH_QCOM is enabled when building arm_smmu_v3, a dependency on
qcom-scm is added, which currently cannot be disabled. Add a prompt to
ARM_SMMU_QCOM to allow disabling this dependency.

Fixes: 0f0f80d9d5db ("iommu/arm: fix ARM_SMMU_QCOM compilation")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/iommu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index ec1b5e32b9725bc1104d10e5d7a32af7b211b50a..cca0825551959e3f37cc2ea41aeae526fdb73312 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -381,6 +381,7 @@ config ARM_SMMU_MMU_500_CPRE_ERRATA
 
 config ARM_SMMU_QCOM
 	def_tristate y
+	prompt "Qualcomm SMMUv3 Support"
 	depends on ARM_SMMU && ARCH_QCOM
 	select QCOM_SCM
 	help

---
base-commit: 1110ce6a1e34fe1fdc1bfe4ad52405f327d5083b
change-id: 20250310-b4-qcom-smmu-d4ccaf66a1ce

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



