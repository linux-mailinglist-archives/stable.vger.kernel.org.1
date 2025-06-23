Return-Path: <stable+bounces-157802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC88AE55A9
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34DD1BC557B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFAD22AE5D;
	Mon, 23 Jun 2025 22:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i6bf1wq9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAFD22A7EF;
	Mon, 23 Jun 2025 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716754; cv=none; b=H1WFTFSH616jimH05ea6n/6YDwQIDZIzuG9MsuCBsJ5ff1O84eri1Qa7KS/s/OqU+C+7aCtYs5/rosdiKmI6pNKNyzN1GMXzw2dBKgrE5QClWP8jPBLiGIWoxuAq426bFiRxCSdijlTeASZ1XTzkNOwrC0a3H6/cTvdArpwooGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716754; c=relaxed/simple;
	bh=b4lcvd9K8FZPzIUVdVzzNi2TDPffRPQO7gK7OsY/yc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLEaW9NzA2Eq8UBMHpWpqMv8DbvNmcORmnc5X1mZHJfVRu0btZSmJRY5ok0IIh2UhYNXfncl6wzhEuuMwpKGIHd+I2vz8uBBN0sVA369OzsUaHaPb5M+CKWHWo2vVP40PVfbX0IwLIXMGLEOA+FFnuvTOQm/3ssZecd6/+qpw5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i6bf1wq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B700C4CEEA;
	Mon, 23 Jun 2025 22:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716754;
	bh=b4lcvd9K8FZPzIUVdVzzNi2TDPffRPQO7gK7OsY/yc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i6bf1wq9X08zdChxpzlgViEe4CXYooxDCbM2VFjb7A59D7io277srYa3+2e2RO/Th
	 burrM4+U8LJRF0Ubivsh5nwmk5Jc88P8sN1vAvaNo04KutV2I0Gj/93NS89+cH0SGF
	 Ew6vpuroDoBMXVax7z30eKQFbcqybjTtYMvfzVps=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 287/290] RISC-V: KVM: Dont treat SBI HFENCE calls as NOPs
Date: Mon, 23 Jun 2025 15:09:08 +0200
Message-ID: <20250623130635.553624885@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
References: <20250623130626.910356556@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anup Patel <apatel@ventanamicro.com>

[ Upstream commit 2e7be162996640bbe3b6da694cc064c511b8a5d9 ]

The SBI specification clearly states that SBI HFENCE calls should
return SBI_ERR_NOT_SUPPORTED when one of the target hart doesn’t
support hypervisor extension (aka nested virtualization in-case
of KVM RISC-V).

Fixes: c7fa3c48de86 ("RISC-V: KVM: Treat SBI HFENCE calls as NOPs")
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Link: https://lore.kernel.org/r/20250605061458.196003-3-apatel@ventanamicro.com
Signed-off-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kvm/vcpu_sbi_replace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_sbi_replace.c b/arch/riscv/kvm/vcpu_sbi_replace.c
index 960836e0cac74..36f5386c60db7 100644
--- a/arch/riscv/kvm/vcpu_sbi_replace.c
+++ b/arch/riscv/kvm/vcpu_sbi_replace.c
@@ -127,9 +127,9 @@ static int kvm_sbi_ext_rfence_handler(struct kvm_vcpu *vcpu, struct kvm_run *run
 	case SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID:
 		/*
 		 * Until nested virtualization is implemented, the
-		 * SBI HFENCE calls should be treated as NOPs
+		 * SBI HFENCE calls should return not supported
+		 * hence fallthrough.
 		 */
-		break;
 	default:
 		retdata->err_val = SBI_ERR_NOT_SUPPORTED;
 	}
-- 
2.39.5




