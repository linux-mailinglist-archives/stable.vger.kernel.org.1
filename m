Return-Path: <stable+bounces-84248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092F299CF3F
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47241F20F2F
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49551BD00A;
	Mon, 14 Oct 2024 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fDyPl7sA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27221B4F1E;
	Mon, 14 Oct 2024 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917344; cv=none; b=iLhLRU5O56Ii1+aQ3doiaP7GEvPp0ran7OqgEx1gzJbNkgK41lePXHPwHSGZ0TUPHsih0UGafcs7lNWsPdkN5KN1KIMCYtwQy+YgHj0+jzZoSjWDPXWBLazFo1FnsULoLIiVZIiBAxY+wxuaXBHiDjB4mjUr5eh5+pXhDxzVCwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917344; c=relaxed/simple;
	bh=2fKrg89s71VHYFLZva62JBhgnVtCnEcO1N1xtxbbk4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcDgYfYWiJ0nsOxXXJVa/l6lXXSKX+YH/wtu3Il/v08hCG2K+kM6CqE4zSasAU1UHHK6wLxtsda3hPzg0u3DGh7T1yRzcFkltzoi0JNjw/w2oAeFcf/5+vzvEvXHxIrrom40BdRpN8ZH7KC/tXJrMBj0GGfy3J6lEnhCXuquth0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fDyPl7sA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CDFC4CEC3;
	Mon, 14 Oct 2024 14:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917344;
	bh=2fKrg89s71VHYFLZva62JBhgnVtCnEcO1N1xtxbbk4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fDyPl7sAHS9S3CHElrti3Fe3gY98vWbr7+ykxXDEjPLQXfrA+B+TVWOEmQWctt4aa
	 YkRxssi4KjP2PZlJRiJXyS4dIkLXHExfdT3kiPFZMv97sDKv71iM/jopwDZDGkimGn
	 ls/cbDOQLBzKwVGx1clFKn/Nvk/7RfpKdwaKx0Kk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 010/798] RISC-V: KVM: Fix sbiret init before forwarding to userspace
Date: Mon, 14 Oct 2024 16:09:24 +0200
Message-ID: <20241014141218.355287832@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Jones <ajones@ventanamicro.com>

[ Upstream commit 6b7b282e6baea06ba65b55ae7d38326ceb79cebf ]

When forwarding SBI calls to userspace ensure sbiret.error is
initialized to SBI_ERR_NOT_SUPPORTED first, in case userspace
neglects to set it to anything. If userspace neglects it then we
can't be sure it did anything else either, so we just report it
didn't do or try anything. Just init sbiret.value to zero, which is
the preferred value to return when nothing special is specified.

KVM was already initializing both sbiret.error and sbiret.value, but
the values used appear to come from a copy+paste of the __sbi_ecall()
implementation, i.e. a0 and a1, which don't apply prior to the call
being executed, nor at all when forwarding to userspace.

Fixes: dea8ee31a039 ("RISC-V: KVM: Add SBI v0.1 support")
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Link: https://lore.kernel.org/r/20240807154943.150540-2-ajones@ventanamicro.com
Signed-off-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kvm/vcpu_sbi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_sbi.c b/arch/riscv/kvm/vcpu_sbi.c
index f96991d230bfc..bc575f6921504 100644
--- a/arch/riscv/kvm/vcpu_sbi.c
+++ b/arch/riscv/kvm/vcpu_sbi.c
@@ -67,8 +67,8 @@ void kvm_riscv_vcpu_sbi_forward(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	run->riscv_sbi.args[3] = cp->a3;
 	run->riscv_sbi.args[4] = cp->a4;
 	run->riscv_sbi.args[5] = cp->a5;
-	run->riscv_sbi.ret[0] = cp->a0;
-	run->riscv_sbi.ret[1] = cp->a1;
+	run->riscv_sbi.ret[0] = SBI_ERR_NOT_SUPPORTED;
+	run->riscv_sbi.ret[1] = 0;
 }
 
 void kvm_riscv_vcpu_sbi_system_reset(struct kvm_vcpu *vcpu,
-- 
2.43.0




