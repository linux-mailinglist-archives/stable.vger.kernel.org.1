Return-Path: <stable+bounces-86561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB689A1A92
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 08:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B82F1F2368B
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 06:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A047117C217;
	Thu, 17 Oct 2024 06:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="h69ar9II"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEBF17BEAE;
	Thu, 17 Oct 2024 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729145707; cv=none; b=oDGAsD4JrISIik1RdSpphtcx9RoB1iULYFMhhhygy4aDZPMLRfQoQMPznH8aOBjZKlsFc+8CgaXXTzPXnq7kpXU5BjexkwBFoQbE58ScoJTaawN05muRxqJWR1sWstNYkOTYWO9mN3m2IkYIWwMO1NMEYsCUuAtH1t3f6No4qOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729145707; c=relaxed/simple;
	bh=QuwHsti+BEFxd1GuNg6SPmi9WOz/qDElc/ktA+gI/+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rxOq5qoAAHZkktVHQdNV27kqvmlCytftCDaABdLcNRcjgJPnr/6KUxUu7wAOkPWzgK5MRA8g0N8ABMGdwL0vHDfeXOyX9lpqnWZ5+7ZLzd5BXYFx32pbrxWn9Luq9O6PPouSfc3WbJYvrBy3N5NLumiiugIAdVxMUvJW5P9Tb9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=h69ar9II; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1729145626;
	bh=hA4hUN+9KBWHFCEFczU3MeRYWfArLynwxZaFIvHd2oQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=h69ar9IICG9t9Gvoz4CEfc75c7ZodsKdkcnAN5eRkUopodeP4UkAHGFoDbI/4on4e
	 Nhk5eM6ZfbVuD2ckWFBJGOOsqBPTAXGNBWsZJh1jk/sZ7aD3fXwQwiUEvhd+PidV0Q
	 ki0u19djg63d1NvgcQ0Zx6mP33dbziKrm4YvMROw=
X-QQ-mid: bizesmtpsz4t1729145617taeiv3x
X-QQ-Originating-IP: uYtshKjOGBnpjT4JIwF/uJpPdH4CCOgdEKjvuAdhe+g=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 17 Oct 2024 14:13:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12168614839949333599
From: WangYuli <wangyuli@uniontech.com>
To: maz@kernel.org,
	oliver.upton@linux.dev,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	rdunlap@infradead.org,
	sebott@redhat.com
Cc: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	guanwentao@uniontech.com,
	zhanjun@uniontech.com,
	WangYuli <wangyuli@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: arm64: vgic-its: Do not call vgic_put_irq() within vgic_its_inject_cached_translation()
Date: Thu, 17 Oct 2024 14:13:34 +0800
Message-ID: <FEBA39FEBDA1C9D7+20241017061334.222103-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MW//binZVb2sL+UWdPGGY1m+g/fkq/LNgUPkGibMmgIYoLIB5nrMuIm7
	8jYdBTUIYdBEALg1DA3D8jtrKgnpMm4QErFuFaEWBZckUJJio2y2+vySK+LrUs8uzZhMdRB
	x5Jx1SPYxPKkuOIRi7Pa+CO3s/auRVymKcipQ7IkG+PPllxnSzkAJtvFYKy8GxUZGeUGYZp
	XrsaR9JFV4zN8wB46fSUk+zSSXrW5XxFFFa/PsCjCqPnZ/660mNzrUbnQLv37mo/aDNr5An
	U/3nk2nV/evPEHcbO6l7Enh10DTPTrQPQ+jsUHwY0+d/h5xUExECOM26WqrcGiShr7kzq8z
	EDlrJcktNs+Ou8wSp655V2ITogZHcWE0M6oxpXPc9kGkdnZywl2i13gpj+4yEgA0Up/dgUm
	mrjmSXQy8Vtkf29JmT3lLIHR0Pwq+w+FIsscBGbjir3tBySh1WBQaA6g3SDFa7V48VPVMQ/
	uWmuPDbxkskOUGHPVHmOBrSuanI6+LB/QeTUpIcRrT0n7d24lj9GgYr2GTKTz4izhyCgvyF
	IYx/6xyyBwDEzBiF0EvlZsyrH+wDet/jZr3awh/JkSFZgtifJ/9qDwxN9gy9+uNK2o0axF8
	34tlhZqwaoSD7jXYt6glVH2vIu+/PMAXZTHBUdHdKPNd6i3oiXRLIBzs47bV+Dw52IhKVSt
	eoWSZ/Lqg0JEwKxOEY6t8nNLQ8nd99IiFhQxLX0xvoALq/epavQS+bnudXgMGOvatS0oRcr
	+S3nbjm6v739ZTMPw6KCPFcnN8rZakpbCcHSU0ink3hQDrRnN0k/UDaMEc+MVoNKmNKaSif
	Wpk05KHtS7tTZxfGnYKiNcn1KrUHpsQcX9kUpKxl6XNZ9IMSIZgk+Tj2MBHJqUp0NnAKMgu
	mbFjEU6Fe3Ka3kuXkHpKsSvHwWrThwc6tsKRy9hZfqPS53cvCMSM9J6PK9HTRdeX4Bu0B07
	o+vNVBKLW7nbZpdaAnxmgLFZobArfxVnvYZfq3bb45VV0UY+u+tKVEQSijzA5G+q9RB1U21
	D0nc7uXAOlYDY/ThPk
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

There is a probability that the host machine will also restart
when the virtual machine is restarting.

Commit ad362fe07fec ("KVM: arm64: vgic-its: Avoid potential UAF
in LPI translation cache") released the reference count of an IRQ
when it shouldn't have. This led to a situation where, when the
system finally released the IRQ, it found that the structure had
already been freed, triggering a
'refcount_t: underflow; use-after-free' error.

In fact, the function "vgic_put_irq" should be called by
"vgic_its_inject_cached_translation" instead of
"vgic_its_trigger_msi".

Call trace:
  its_free_ite+0x90/0xa0
  vgic_its_free_device+0x3c/0xa0
  vgic_its_destroy+0x4c/0xb8
  kvm_put_kvm+0x214/0x358
  kvm_vcpu_release+0x24/0x38
  __fput+0x84/0x278
  ____fput+0x20/0x30
  task_work_run+0xcc/0x190
  do_exit+0x36c/0xa88
  do_group_exit+0x4c/0xb8
  __arm64_sys_exit_group+0x24/0x28
  invoke_syscall+0x54/0x120
  el0_svc_common.constprop.4+0x16c/0x1f0
  do_el0_svc+0x34/0xb0
  el0_svc+0x1c/0x28
  el0_sync_handler+0x8c/0xb0
  el0_sync+0x148/0x180

Fixes: ad362fe07fec ("KVM: arm64: vgic-its: Avoid potential UAF in LPI translation cache")
Cc: stable@vger.kernel.org
Signed-off-by: Wenyao Hai <haiwenyao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 arch/arm64/kvm/vgic/vgic-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index ba945ba78cc7..fb5f57cbab42 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -679,6 +679,7 @@ static int vgic_its_trigger_msi(struct kvm *kvm, struct vgic_its *its,
 	raw_spin_lock_irqsave(&irq->irq_lock, flags);
 	irq->pending_latch = true;
 	vgic_queue_irq_unlock(kvm, irq, flags);
+	vgic_put_irq(kvm, irq);
 
 	return 0;
 }
@@ -697,7 +698,6 @@ int vgic_its_inject_cached_translation(struct kvm *kvm, struct kvm_msi *msi)
 	raw_spin_lock_irqsave(&irq->irq_lock, flags);
 	irq->pending_latch = true;
 	vgic_queue_irq_unlock(kvm, irq, flags);
-	vgic_put_irq(kvm, irq);
 
 	return 0;
 }
-- 
2.45.2


