Return-Path: <stable+bounces-64052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589BF941BE4
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15000283B08
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECF6161901;
	Tue, 30 Jul 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KF8zUcim"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E351FBA;
	Tue, 30 Jul 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358828; cv=none; b=gZHReXDwmiQCjz3BLFeQ28S+nPyHzfDmlCdz7/+0YpS0H5+FXD7RLFTTqox1+8Ui2voXN/PIKCoJslcuXXtdkf69Lj4IOtxdKabcX61ek3Epbpcyn5+54U6wXeOwAsWvt0qC7MvVO2j/58A/qNOBLskz9wB2fE5HEb6MVXX1Ul0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358828; c=relaxed/simple;
	bh=QI3XqtrbUxBbJxPGfEUP1G/gRhdSdKpWObPAb+uPDf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+KZrnQvQiGDdN46Oon8KVNMIePmd6gZ0aLtyVyhUzU5LOsw1WgWKHC6Xs7rvuaOsRBr1lU50I6VN0cS66sFy3YjSvHoNK7+12HlKUjrcqZkKzX81Id62RlKPNZz8TIkdgGz4v7554Zvtr+WoX85a+3BH0BIoUp3iMQpSi1fWNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KF8zUcim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8877AC32782;
	Tue, 30 Jul 2024 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722358828;
	bh=QI3XqtrbUxBbJxPGfEUP1G/gRhdSdKpWObPAb+uPDf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KF8zUcim5eeiYFDRjfDbIxOpVR/PnkyyT+XFaxJipe+dd73UFEhxgZudy1qasJFJL
	 QlF00PsrTt0PRCmyR/8tJ8MEy5qaye860RFEh2Mne0JJ4+JbUUZC/Gkq/Hq2uCF6Ft
	 KRVNE0H+Xj72+DLev+C10Ds6f/ThkOi2z6EqvPJc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 400/809] KVM: PPC: Book3S HV: Fix the set_one_reg for MMCR3
Date: Tue, 30 Jul 2024 17:44:36 +0200
Message-ID: <20240730151740.485087327@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shivaprasad G Bhat <sbhat@linux.ibm.com>

[ Upstream commit f9ca6a10be20479d526f27316cc32cfd1785ed39 ]

The kvmppc_set_one_reg_hv() wrongly get() the value
instead of set() for MMCR3. Fix the same.

Fixes: 5752fe0b811b ("KVM: PPC: Book3S HV: Save/restore new PMU registers")
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/171759276847.1480.16387950124201117847.stgit@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kvm/book3s_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index daaf7faf21a5e..a4f34f94c86f7 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2540,7 +2540,7 @@ static int kvmppc_set_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
 		vcpu->arch.mmcrs = set_reg_val(id, *val);
 		break;
 	case KVM_REG_PPC_MMCR3:
-		*val = get_reg_val(id, vcpu->arch.mmcr[3]);
+		kvmppc_set_mmcr_hv(vcpu, 3, set_reg_val(id, *val));
 		break;
 	case KVM_REG_PPC_PMC1 ... KVM_REG_PPC_PMC8:
 		i = id - KVM_REG_PPC_PMC1;
-- 
2.43.0




