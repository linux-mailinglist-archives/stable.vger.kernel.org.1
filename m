Return-Path: <stable+bounces-58442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A5D92B705
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66BB1C20E37
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED99F1586F6;
	Tue,  9 Jul 2024 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cLRXjq5c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC17D1586C4;
	Tue,  9 Jul 2024 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523947; cv=none; b=e2Vj8n0hdrMgwQB/j50M2N9Gkf7ZL3sL/8Cr3MlrTGdIUZk3GmDhttQhy0mfgwgWfVYvetZHY6b8c/TL7ER2zUQweK3Bc4zK3hAxbETbRuOzkqo8VKAVzx+eG1rp2erqKN9CkPv/LkzMeYp67NxVEQtfq1IkSmXb9tEvUr2kX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523947; c=relaxed/simple;
	bh=8rg1sB3aJ4DMHhQ6YFfhQRQLYvMxxa0Ch3HfL4YLW2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfLpAiq6rtuZa0k16IoLFaOxpx9HCMb/fYqEECRXGUBcey0SzDEe00YGVn8e9CVp/MlSadxbbpI3oCF149FBSk708PFCtPjLE+l/mgTyhRx66FATBDvoVRY4YU6GWUv3ElwNkHnq5NOqXWcuc98+Z7+GKByKv73PbMO4dMvaYLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cLRXjq5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E20BC3277B;
	Tue,  9 Jul 2024 11:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720523947;
	bh=8rg1sB3aJ4DMHhQ6YFfhQRQLYvMxxa0Ch3HfL4YLW2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cLRXjq5cviN2ENRYkXRrqWR+D40TSFVR7Svl/MwTGkAgpJHTQeLtWtk16ymu7FsZQ
	 gEdTxPMy/JbcF2dHImqpsnGoiP+3O/ZuxKq+zSOY2xACiOXOIhFnwzA1TsV/aDKzL9
	 bFYQLnQ23g1fg80Ei//cRB9cl4vDjVQIhtahIk9w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 021/197] RISC-V: KVM: Fix the initial sample period value
Date: Tue,  9 Jul 2024 13:07:55 +0200
Message-ID: <20240709110709.737218036@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>
References: <20240709110708.903245467@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Atish Patra <atishp@rivosinc.com>

[ Upstream commit 57990ab90ce31aadac0d5a6293f5582e24ff7521 ]

The initial sample period value when counter value is not assigned
should be set to maximum value supported by the counter width.
Otherwise, it may result in spurious interrupts.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/r/20240420151741.962500-11-atishp@rivosinc.com
Signed-off-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kvm/vcpu_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 86391a5061dda..cee1b9ca4ec48 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -39,7 +39,7 @@ static u64 kvm_pmu_get_sample_period(struct kvm_pmc *pmc)
 	u64 sample_period;
 
 	if (!pmc->counter_val)
-		sample_period = counter_val_mask + 1;
+		sample_period = counter_val_mask;
 	else
 		sample_period = (-pmc->counter_val) & counter_val_mask;
 
-- 
2.43.0




