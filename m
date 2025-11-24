Return-Path: <stable+bounces-196748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8AEC80F10
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 15:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CD93A23FE
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BE32F7479;
	Mon, 24 Nov 2025 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJuPOzXL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6365836D4F4
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763993497; cv=none; b=koGvVmEmwIoUJDrkMiFgOkNFMN5xw0OcBumoIX/gXmbaMWuTdXZ23+F1GjTs6+RBdx8UslCI/xjavoicnTQnhHQkSruHLXrDOQZMtdxoIHwIpCKl2DECmYXvpgiicOpfNVEZ3KUKuxQdo32eMFfhl/mGumbPhiCnw+5r8bj5hMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763993497; c=relaxed/simple;
	bh=ChqGjNAp7Lvkt9F7Q/bmv5urOQhnuXq3Z8qYcZ54MkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCQl1z472F3WcnNJ4qn9aRFIWB4TCC/G+sFv+OhKL+qb/zZPjwE2dOFW9CySWrwkU47ZciQLq7xDkHpywRc3RHWD1PbnbQHNiBcW20DxHVgNQznmC2/JSYizlYNHWZIUhYjNckjTMUtZQom/OElDqicw0ELRiT00GFyzHHASFgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJuPOzXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49188C4CEF1;
	Mon, 24 Nov 2025 14:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763993496;
	bh=ChqGjNAp7Lvkt9F7Q/bmv5urOQhnuXq3Z8qYcZ54MkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XJuPOzXLI5iMvfR9xgZfcpo3vey9Q1Gspgeqa6dG7spajjRzP6VdSRf0AzEHDCbif
	 L31qA+2KzmiYaBiO10Bnhh3vdSFC4x3ncdcuuXoYMd5iyMN5uSWsLBfHzyBTO+ntqA
	 dzruu0HEInaggysFp2oVywzx63NaeYhWZV3VM/8kxBV5y6SLXPV0mhjUIFGLhwGT4I
	 Tn8PfUlUwcCbyhzbDYGGd+71lqJ8QxD6qul4XW+HfJC0KL2K76DKGpFOzcXFuo4uNu
	 xUXtOIDXrCpUYcB7AMDFF8x1Ne5qW/jTX9Z9r0KoYPxbeLL8ma7Sh/sM4vfMwjNEwD
	 wVA3W2KNREbQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Ene <sebastianene@google.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] KVM: arm64: Check the untrusted offset in FF-A memory share
Date: Mon, 24 Nov 2025 09:11:34 -0500
Message-ID: <20251124141134.4098048-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112429-pasture-geometry-591b@gregkh>
References: <2025112429-pasture-geometry-591b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Ene <sebastianene@google.com>

[ Upstream commit 103e17aac09cdd358133f9e00998b75d6c1f1518 ]

Verify the offset to prevent OOB access in the hypervisor
FF-A buffer in case an untrusted large enough value
[U32_MAX - sizeof(struct ffa_composite_mem_region) + 1, U32_MAX]
is set from the host kernel.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
Acked-by: Will Deacon <will@kernel.org>
Link: https://patch.msgid.link/20251017075710.2605118-1-sebastianene@google.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 8d21ab904f1a9..eacf4ba1d88e9 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -425,7 +425,7 @@ static void __do_ffa_mem_xfer(const u64 func_id,
 	DECLARE_REG(u32, npages_mbz, ctxt, 4);
 	struct ffa_composite_mem_region *reg;
 	struct ffa_mem_region *buf;
-	u32 offset, nr_ranges;
+	u32 offset, nr_ranges, checked_offset;
 	int ret = 0;
 
 	if (addr_mbz || npages_mbz || fraglen > len ||
@@ -460,7 +460,12 @@ static void __do_ffa_mem_xfer(const u64 func_id,
 		goto out_unlock;
 	}
 
-	if (fraglen < offset + sizeof(struct ffa_composite_mem_region)) {
+	if (check_add_overflow(offset, sizeof(struct ffa_composite_mem_region), &checked_offset)) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto out_unlock;
+	}
+
+	if (fraglen < checked_offset) {
 		ret = FFA_RET_INVALID_PARAMETERS;
 		goto out_unlock;
 	}
-- 
2.51.0


