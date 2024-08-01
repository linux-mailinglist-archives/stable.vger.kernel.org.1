Return-Path: <stable+bounces-65008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA32943D93
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A66E3B291AA
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84481C8E80;
	Thu,  1 Aug 2024 00:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIezus4k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7441C1B2718;
	Thu,  1 Aug 2024 00:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471920; cv=none; b=LZnFv2NwHJhAfh2g8KB7ynjkWBlKQZlovGC2Xuzn7nWkBoqNpYI9yG7I9XEXKJocJUiTJCP5aCQo/E7qJgRj2Z045mz/fkkKo4mwcv14vqtjrMbTvqm5fTphPNP8ZKMdCsgvP0Qr8WVqlMrlQ+QS4bvhyA11ON0uL08czirRLRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471920; c=relaxed/simple;
	bh=JwoFdsuc3jJQ6SJDjO2il0usDr1uOw6eXVCsT+PTWBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0aDpD7Qq+nhZJ9WHT2Gqu3PCKM1EJ6ORjjQdOvZcy2Meb16KItj/xcaPXLOu6QhBRvB4fIDja6OMSxFBFy4yB1mZW6s+AdpGpMmZGBXg1J0k1SkvWgUd0qpgYdgkm4yvOcVH+NgTfUjkYsp1rdU6eMkd+9YQXsDT6DzUJmtbEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIezus4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589FFC4AF0C;
	Thu,  1 Aug 2024 00:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471920;
	bh=JwoFdsuc3jJQ6SJDjO2il0usDr1uOw6eXVCsT+PTWBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fIezus4kO+caAgm3TCwE1jCedsntbcyV/Ud50v3mCYoWgzykz49MsizdP+IzsBnR0
	 BdcCmEiU6JSChLH78qu+Gw+P1iyvJUd09Xdera38YB+GYEmt3re2NiJOxabMriPxrS
	 PvfjRRllHV5i8yUHod6ge36VisJ7k+nIzgprS8FuYtklkxodUoDATbAmFdOHlfzcb9
	 u2PKfSanB8MG5WkQNREfkqsfCUPtlOoXSovKcWli+RbVxeBN+7kkViUnQQWxWOcSJV
	 THwU7BFyHxAMi5Y9/j/7r7iZJBYEmnusI8iHU5MnmePkyp31GYzc2zTI8exYP20cXc
	 hInW2Bc1N1YWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rakesh Ughreja <rughreja@habana.ai>,
	Ofir Bitton <obitton@habana.ai>,
	Sasha Levin <sashal@kernel.org>,
	ogabbay@kernel.org,
	ttayar@habana.ai,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 62/83] accel/habanalabs/gaudi2: unsecure edma max outstanding register
Date: Wed, 31 Jul 2024 20:18:17 -0400
Message-ID: <20240801002107.3934037-62-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
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

From: Rakesh Ughreja <rughreja@habana.ai>

[ Upstream commit 3309887c6ff8ca2ac05a74e1ee5d1c44829f63f2 ]

Netowrk EDMAs uses more outstanding transfers so this needs to be
programmed by EDMA firmware.

Signed-off-by: Rakesh Ughreja <rughreja@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
Signed-off-by: Ofir Bitton <obitton@habana.ai>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/habanalabs/gaudi2/gaudi2_security.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2_security.c b/drivers/accel/habanalabs/gaudi2/gaudi2_security.c
index 2742b1f801eb2..3897db8532004 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2_security.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2_security.c
@@ -479,6 +479,7 @@ static const u32 gaudi2_pb_dcr0_edma0_unsecured_regs[] = {
 	mmDCORE0_EDMA0_CORE_CTX_TE_NUMROWS,
 	mmDCORE0_EDMA0_CORE_CTX_IDX,
 	mmDCORE0_EDMA0_CORE_CTX_IDX_INC,
+	mmDCORE0_EDMA0_CORE_WR_COMP_MAX_OUTSTAND,
 	mmDCORE0_EDMA0_CORE_RD_LBW_RATE_LIM_CFG,
 	mmDCORE0_EDMA0_QM_CQ_CFG0_0,
 	mmDCORE0_EDMA0_QM_CQ_CFG0_1,
-- 
2.43.0


