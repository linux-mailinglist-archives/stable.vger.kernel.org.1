Return-Path: <stable+bounces-131682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 151DBA80B60
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D5E1BC2E75
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51DE27C859;
	Tue,  8 Apr 2025 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sGS/k4WM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FCE26F478;
	Tue,  8 Apr 2025 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117050; cv=none; b=d+1ikBM4RdvQ4zAH+QBILOIkujxqEkZyDa8EJCP2zJ4lmMgIOMFALpsyzN3Zv+tEaKNYesDsGXqzs5rqNh2Hy8WMxqOXUHzSOs3wxRsUcgrO5jx7SHId8higHy3fC468k4onw+jQKnTVjtSq2vcMOGNQQx1FHW4ogbR2y1MPg44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117050; c=relaxed/simple;
	bh=nygzRU2W/FlGD2SEUaWXrItGMvZjxTFqQeVd7rfyetE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2bMOg7m7AlzsCaeVV0IfZiSgr2HMhtlAGWXNmliRHsdFmd7RvmFut2/Cuv7vijFoZRoH4lGY1kAsZJO/FwUCUYJQiz6K8Kw7xvav/OO5hIP5iEqsnTpt2jCqTRlHiaREcZq4DI5eFLSr8IdjkyVCBXfQ4yNPalfJjxNA6qOyEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sGS/k4WM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C7DC4CEE5;
	Tue,  8 Apr 2025 12:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744117050;
	bh=nygzRU2W/FlGD2SEUaWXrItGMvZjxTFqQeVd7rfyetE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sGS/k4WMLvCjDbAqUlyIW/GKybHXdk3FWLZSHqPYwLRXc7FtHfUOQJ1Dk8V/ME6zV
	 bBxF36JPHAPEcMsSJlrP197BMHC/ej6/UH1Zzsrqgmb6j/GWHKRz8PKdf2IhNgkKfR
	 +tkes6Eg0VpgVsPXOvz+MHqY/i129BQsdr3imoQo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.12 366/423] LoongArch: BPF: Dont override subprogs return value
Date: Tue,  8 Apr 2025 12:51:32 +0200
Message-ID: <20250408104854.388966404@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hengqi Chen <hengqi.chen@gmail.com>

commit 60f3caff1492e5b8616b9578c4bedb5c0a88ed14 upstream.

The verifier test `calls: div by 0 in subprog` triggers a panic at the
ld.bu instruction. The ld.bu insn is trying to load byte from memory
address returned by the subprog. The subprog actually set the correct
address at the a5 register (dedicated register for BPF return values).
But at commit 73c359d1d356 ("LoongArch: BPF: Sign-extend return values")
we also sign extended a5 to the a0 register (return value in LoongArch).
For function call insn, we later propagate the a0 register back to a5
register. This is right for native calls but wrong for bpf2bpf calls
which expect zero-extended return value in a5 register. So only move a0
to a5 for native calls (i.e. non-BPF_PSEUDO_CALL).

Cc: stable@vger.kernel.org
Fixes: 73c359d1d356 ("LoongArch: BPF: Sign-extend return values")
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/net/bpf_jit.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -907,7 +907,10 @@ static int build_insn(const struct bpf_i
 
 		move_addr(ctx, t1, func_addr);
 		emit_insn(ctx, jirl, LOONGARCH_GPR_RA, t1, 0);
-		move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
+
+		if (insn->src_reg != BPF_PSEUDO_CALL)
+			move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
+
 		break;
 
 	/* tail call */



