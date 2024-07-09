Return-Path: <stable+bounces-58817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA7F92C058
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0834D28BA82
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DC91C231B;
	Tue,  9 Jul 2024 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNnl8BDt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB9E1C2308;
	Tue,  9 Jul 2024 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542178; cv=none; b=abeLnobr+O4pbHFkUw8x7ZdOif9gd8hIvJw+4ROr0/c9GmaWANEneBpWRl87T/5zJgtRW2uzvmz65rrGquopNXytPkOuvXTV7tsLz9gDGwspvbyT+nJk2IpE5PbcKu2w1R7tB9hH1Er6P+X3G3gfFxjPTnsIl/QO7kzzvj9aaww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542178; c=relaxed/simple;
	bh=Zm95n2SGEqjmTMk4Bs/Y4+y12KbObHhx/cFrv7TCRBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIWL78BjfndoVoRi1DPGDgPQviZhLmt/n9SaFahZ6IVd7n31Kpkqk8Gr87Eh9NafrrUwuUKPDUw2LL6iCCVfgcG/asrgkkODzf6Yi/i/t1gDemGP9AJTEFj57psBsGY3a1/IKMgU87uCCocKLMOEvBHg0tYS+nBcADMioaAjmR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNnl8BDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89448C3277B;
	Tue,  9 Jul 2024 16:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542178;
	bh=Zm95n2SGEqjmTMk4Bs/Y4+y12KbObHhx/cFrv7TCRBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NNnl8BDtZc5B+snuwAOmf4v4zzr0As6sfL+xhk5VEkjOpTlf5wedbRRnqcGhro1Rx
	 P2B7E6lJUk1VZRZG/ZxofnZmt6Tfn6BMDzAra/KJFNCKGzChuKOtpaJp4y3vTTvzVO
	 OMh4/WTY3qND0AINMmn+OWTv2sxOkIbiN7WdhHqrqZniIyXtR+7q1Tc2Rzm0LYzoZo
	 z0nPHl71gPeG0QXMIiK8l4xn7d2pWFnKQv4GR17McroH5CLOkKNtxhCp/L5lb/A+u5
	 lkQ8cL21yc+MnG/larMLYNFkNprim4fvfmvXfZM5MI+HbT6yx0NsEZz/jXIuwTHu4o
	 hBNqA7pWMxyxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Boyang Yu <yuboyang@dapustor.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 15/33] nvme: fix NVME_NS_DEAC may incorrectly identifying the disk as EXT_LBA.
Date: Tue,  9 Jul 2024 12:21:41 -0400
Message-ID: <20240709162224.31148-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162224.31148-1-sashal@kernel.org>
References: <20240709162224.31148-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.38
Content-Transfer-Encoding: 8bit

From: Boyang Yu <yuboyang@dapustor.com>

[ Upstream commit 9570a48847e3acfa1a741cef431c923325ddc637 ]

The value of NVME_NS_DEAC is 3,
which means NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS. Provide a
unique value for this feature flag.

Fixes 1b96f862eccc ("nvme: implement the DEAC bit for the Write Zeroes command")
Signed-off-by: Boyang Yu <yuboyang@dapustor.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index fd67240795e3a..21c24cd8b1e8a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -485,7 +485,7 @@ static inline bool nvme_ns_head_multipath(struct nvme_ns_head *head)
 enum nvme_ns_features {
 	NVME_NS_EXT_LBAS = 1 << 0, /* support extended LBA format */
 	NVME_NS_METADATA_SUPPORTED = 1 << 1, /* support getting generated md */
-	NVME_NS_DEAC,		/* DEAC bit in Write Zeores supported */
+	NVME_NS_DEAC = 1 << 2,		/* DEAC bit in Write Zeores supported */
 };
 
 struct nvme_ns {
-- 
2.43.0


