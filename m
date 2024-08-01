Return-Path: <stable+bounces-64916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B86A943C58
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A026B2317F
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4601BE860;
	Thu,  1 Aug 2024 00:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSSK+PqO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F931BE855;
	Thu,  1 Aug 2024 00:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471419; cv=none; b=TlBrNhIpzS3mNEK4/YRqJMN7sBM0k/ESjLs+2BsaaNKGpKQxhLWJkD2BfIxwEn8GfFJa4JUjw8ilv4fYbwfAEutAm+UeQLX7KR2NfpwZ85RpNIqTBrnTFOkHw91ih1EwluZh/JpltJQ3tPYDVtbmfqfDACZ7hD01sU3N9qLbqQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471419; c=relaxed/simple;
	bh=ESNMqqSSifGjTIF9jtKdskNaQNhl1748NcdFTZEQUts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NP0p5tWMNpaCQFkHbue7neTCT9dkrbsRE0IcaU08M35qbT5R2VCcwElxE3nCy/fjrZK9ExWhiVkygPbB647gQtSOmTQOfdU6i5Gg5m47Wb1acgxc2Ru6thkW6wD7pmt2QZ7ihvq1bs9If2hIjbVXomc09zZybhbMOxmBmOixC5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSSK+PqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FBFC4AF0C;
	Thu,  1 Aug 2024 00:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471418;
	bh=ESNMqqSSifGjTIF9jtKdskNaQNhl1748NcdFTZEQUts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qSSK+PqOEtnOr8AY0NQWITQ8s01+ReSAKOs6EbCeGhMXehLS0urb1UWt5aARzlznH
	 c7cEQpHWmPWG+QbRhLEL60RFOBq21EeczIkdHvDN42h7kQ2aoq6eiGT5zU2F6UaTCm
	 7JU4mlJyGa4qbLvt/6esdWAKQVlYYdO2iD3NJBtkJhB/PbDFvnC8mE/lsykjayGGQq
	 GpnCC6dpuNpukhv6nF6slKEzl92BKBtJIT7HLVNlfQNjqsc+IYOGFqFF9gbxc2pfZY
	 WQOUhV4gKTMNIO4iI65//TeF+18+I/s44+qQ3wcJOiL86Q6q1GcE8Mo+9OOIMm9xNq
	 OnO8tMwlJzVoQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rakesh Ughreja <rughreja@habana.ai>,
	Ofir Bitton <obitton@habana.ai>,
	Sasha Levin <sashal@kernel.org>,
	ogabbay@kernel.org,
	ttayar@habana.ai,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 091/121] accel/habanalabs/gaudi2: unsecure edma max outstanding register
Date: Wed, 31 Jul 2024 20:00:29 -0400
Message-ID: <20240801000834.3930818-91-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
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
index 34bf80c5a44bf..307ccb912ccd6 100644
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


