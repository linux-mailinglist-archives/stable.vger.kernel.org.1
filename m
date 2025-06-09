Return-Path: <stable+bounces-152014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 211B3AD1CC7
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 14:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFAF188AD68
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 12:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2BF254B09;
	Mon,  9 Jun 2025 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="O3dHBVvW"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E83256C7D;
	Mon,  9 Jun 2025 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749470444; cv=none; b=gnSJJX3kcrxHoCqobbk69BKhtcJZL543M4hvNIegMY1EDMT1moRhCbbpKHAYcAoeYTHzROzzrsEi+1U0w6r1HEzpIqzPQa3KuLCnO/jiV/uHNvfQ26TCtjfN+oEYuC39SFn9Zh4/WgTfzA/38xv7d/86gmFrCB5uxkAHhyBjmOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749470444; c=relaxed/simple;
	bh=PKWgQGgRJ1guVZn+qEPTzImhKYgLlE0AV9Fupk0kTfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a+6nmqCJ6OXJ8rc8Q7ZLMIg/u/2tF150FnRafBZOGBYVvCjmqv6TN8qfsFs22B3pUjqSOmCIq1ndXH0+oSX/7JpNY0uFTmhIJhJobfFlWpi8NcVMC47RJnvqHQg8NceqHQy4A+Q5Jh0dxfi9JUMemvo7hIh2DOoT9P0eOyc8YZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=O3dHBVvW; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1749470438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ex2JFBinh8YiWxVMhoLzM47i1TZJvrxnedGrO88QYuw=;
	b=O3dHBVvWxVuVkPDus4ne+jZDafnHzyyhXuEhkrCCDvWDJSyTO6HOQcZwO6j5bnpbwTg5Mf
	8dj53My4mXs5xENi2F1oFZdh5dZjZPYhbqEqkoiHeq1T/MR0cCLpLs4hDlPXns0itXESXb
	VYoM5bxh1eMWPH0VlMZzdLHHCa7EBL8=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Julien Thierry <julien.thierry.kdev@gmail.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Oliver Upton <oliver.upton@linux.dev>,
	Quentin Perret <qperret@google.com>
Subject: [PATCH 5.10] KVM: arm64: Tear down vGIC on failed vCPU creation
Date: Mon,  9 Jun 2025 15:00:37 +0300
Message-ID: <20250609120038.41396-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Will Deacon <will@kernel.org>

commit 250f25367b58d8c65a1b060a2dda037eea09a672 upstream.

If kvm_arch_vcpu_create() fails to share the vCPU page with the
hypervisor, we propagate the error back to the ioctl but leave the
vGIC vCPU data initialised. Note only does this leak the corresponding
memory when the vCPU is destroyed but it can also lead to use-after-free
if the redistributor device handling tries to walk into the vCPU.

Add the missing cleanup to kvm_arch_vcpu_create(), ensuring that the
vGIC vCPU structures are destroyed on error.

Cc: <stable@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20250314133409.9123-1-will@kernel.org
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
[Denis: minor fix to resolve merge conflict.]                                           
Signed-off-by: Denis Arefev <arefev@swemel.ru>                                    
---
Backport fix for CVE-2025-37849
Link: https://nvd.nist.gov/vuln/detail/cve-2025-37849
---
 arch/arm64/kvm/arm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index afe8be2fef88..3adaa3216baf 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -294,7 +294,12 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	if (err)
 		return err;
 
-	return create_hyp_mappings(vcpu, vcpu + 1, PAGE_HYP);
+	err = kvm_share_hyp(vcpu, vcpu + 1);
+	if (err)
+		kvm_vgic_vcpu_destroy(vcpu);
+
+	return err;
+
 }
 
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
-- 
2.43.0


