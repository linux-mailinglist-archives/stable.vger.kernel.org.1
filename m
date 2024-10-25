Return-Path: <stable+bounces-88202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110ED9B125B
	for <lists+stable@lfdr.de>; Sat, 26 Oct 2024 00:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6903EB2177B
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 22:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE16E18C320;
	Fri, 25 Oct 2024 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LpW8zYBo"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4774D217F30
	for <stable@vger.kernel.org>; Fri, 25 Oct 2024 22:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729894347; cv=none; b=W7zPnU06s9Cqje2vzZX/WxV8+pQdaKMT1/j1Hrf9uJ7JFBx8rQTLqJ1Zv3pwYG8E7hzRK3IdRiFeSM26AWTljzaqO3wwVx6qBX8E8wzHuRmThEXEZTFrOCclr4lgYGOXLjkNsC+xWwas1efXaK4wd1kKBfFxioapmhmKvaw88HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729894347; c=relaxed/simple;
	bh=NK5OZSsxHrxv1wlh6RU3G8N57LyHfd3rgn7LtmDFZgs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fMYd9g2vDXIvNc3z5ud9euhkrsGE2zgE24XDHijUu9u2xfvvlJp1ywg6sRQ9DYNJshnRdVRtWTo2yK47tf4hJt0EXu4M2gR3219sun40nNN5y3EWO6PHp7DKiAwAnrqMkDIWgnMvxaH8eNFcWdQhJD+PrsF8sT761eawcBCXt4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LpW8zYBo; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2b9f2c6559so4339729276.2
        for <stable@vger.kernel.org>; Fri, 25 Oct 2024 15:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729894343; x=1730499143; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kAitD5UlZ526DH4CXulhVwZM1+TjXuj2ZSzY1GKH9CI=;
        b=LpW8zYBoJGSJQz5HZxjoDc3iW/SxIU+zk/EYNBfmdJnoCSC1tqzNAvcA3dqe+Mnjf4
         O6Ar8h9HbBPiQ5slo993rbHc+GZa2HI54b1/CKtJZyCl7I2M+MmBlAzr1Bw4+PrAgMOS
         sEGaRMfWOTi0w59EOPtFWuvE5VVBIS90XY4+gz9Tg+AbekjT4Vss/L7pD+GCyn7rfv9K
         QoxPFf2KmMAif1lKebMvqQG9ATXoO8nWLYmpkMJfimN/W63KmmBsTdiexH0COMcR08GR
         1tLOPLCg3pHiIKOPZeHzuOu3JEZ33xlrejp+ZZwxcJWFTv6etw1H9lYzqtYHm+LY2T4x
         3Bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729894343; x=1730499143;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kAitD5UlZ526DH4CXulhVwZM1+TjXuj2ZSzY1GKH9CI=;
        b=E8/i15Hr8I66y7nUatyBu++WTylq6/Z9OAcDQQuA+yxxl1jYPDNmyVKIclD6Sp5mKh
         /7xGHTZAGHAM/OynHb3rO5a9JwFsU5Z8nHK5naHv1q8OOl/IH6DJD6ARewm3TJcJoZkF
         GSMULmemT+qiuUYebXqOlXT75SNbmypXGRMYNuko4kpeeXBpMG3vuJS5+IX1zK6Ck4ng
         fUY7IcLQ/K8Q3rbTcr801iNj0neA6vl2yfuCu+bZ/EePeZEpg2SH3+CRf0Q2i1i6IvgQ
         1iV0idOT6k0kZ6QrF7Ss7Ox189Se2+a4mU/XsTf4JB6bVRRyJ/9YitQK6V57nUt9ZILx
         zLuw==
X-Forwarded-Encrypted: i=1; AJvYcCVpGc/WUwXLvsRDdXfRjhY1puPUHPhKqhDN7vBFgl3TXVHYu5LezE2fz4gx9/kPY2907YjpvnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya9Jf4NB4ymOoRCZyadkBYM/MoUdzpYfmZ/n1gcSryv4aq79C7
	1/64MNjBhEGJwK3kYE8IKiZ046eZ0C8crBRnyKPpfKLd/oZeksF9XtAdnTrCfaoq1F5J57M0AJc
	qpBKYcw==
X-Google-Smtp-Source: AGHT+IG+6UAmoj1XD96N3OA7Nf/oOruad1eDYvy56vmbEa612keZSXmPriH5DCYyGrnCxORY2rVIPeM7z/tx
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fac1])
 (user=rananta job=sendgmr) by 2002:a25:ec0c:0:b0:e2b:d389:b35c with SMTP id
 3f1490d57ef6-e3087bfc151mr497276.8.1729894343080; Fri, 25 Oct 2024 15:12:23
 -0700 (PDT)
Date: Fri, 25 Oct 2024 22:12:20 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241025221220.2985227-1-rananta@google.com>
Subject: [PATCH] KVM: arm64: Mark the VM as dead for failed initializations
From: Raghavendra Rao Ananta <rananta@google.com>
To: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
Cc: Raghavendra Rao Anata <rananta@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

Syzbot hit the following WARN_ON() in kvm_timer_update_irq():

WARNING: CPU: 0 PID: 3281 at arch/arm64/kvm/arch_timer.c:459
kvm_timer_update_irq+0x21c/0x394
Call trace:
  kvm_timer_update_irq+0x21c/0x394 arch/arm64/kvm/arch_timer.c:459
  kvm_timer_vcpu_reset+0x158/0x684 arch/arm64/kvm/arch_timer.c:968
  kvm_reset_vcpu+0x3b4/0x560 arch/arm64/kvm/reset.c:264
  kvm_vcpu_set_target arch/arm64/kvm/arm.c:1553 [inline]
  kvm_arch_vcpu_ioctl_vcpu_init arch/arm64/kvm/arm.c:1573 [inline]
  kvm_arch_vcpu_ioctl+0x112c/0x1b3c arch/arm64/kvm/arm.c:1695
  kvm_vcpu_ioctl+0x4ec/0xf74 virt/kvm/kvm_main.c:4658
  vfs_ioctl fs/ioctl.c:51 [inline]
  __do_sys_ioctl fs/ioctl.c:907 [inline]
  __se_sys_ioctl fs/ioctl.c:893 [inline]
  __arm64_sys_ioctl+0x108/0x184 fs/ioctl.c:893
  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
  invoke_syscall+0x78/0x1b8 arch/arm64/kernel/syscall.c:49
  el0_svc_common+0xe8/0x1b0 arch/arm64/kernel/syscall.c:132
  do_el0_svc+0x40/0x50 arch/arm64/kernel/syscall.c:151
  el0_svc+0x54/0x14c arch/arm64/kernel/entry-common.c:712
  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

The sequence that led to the report is when KVM_ARM_VCPU_INIT ioctl is
invoked after a failed first KVM_RUN. In a general sense though, since
kvm_arch_vcpu_run_pid_change() doesn't tear down any of the past
initiatializations, it's possible that the VM's state could be left
half-baked. Any upcoming ioctls could behave erroneously because of
this.

Since these late vCPU initializations is past the point of attributing
the failures to any ioctl, instead of tearing down each of the previous
setups, simply mark the VM as dead, gving an opportunity for the
userspace to close and try again.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot <syzkaller@googlegroups.com>
Suggested-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/kvm/arm.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index a0d01c46e4084..ae3551bc98aeb 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -821,12 +821,12 @@ int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 		 */
 		ret = kvm_vgic_map_resources(kvm);
 		if (ret)
-			return ret;
+			goto out_err;
 	}
 
 	ret = kvm_finalize_sys_regs(vcpu);
 	if (ret)
-		return ret;
+		goto out_err;
 
 	/*
 	 * This needs to happen after any restriction has been applied
@@ -836,16 +836,16 @@ int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 
 	ret = kvm_timer_enable(vcpu);
 	if (ret)
-		return ret;
+		goto out_err;
 
 	ret = kvm_arm_pmu_v3_enable(vcpu);
 	if (ret)
-		return ret;
+		goto out_err;
 
 	if (is_protected_kvm_enabled()) {
 		ret = pkvm_create_hyp_vm(kvm);
 		if (ret)
-			return ret;
+			goto out_err;
 	}
 
 	if (!irqchip_in_kernel(kvm)) {
@@ -869,6 +869,10 @@ int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 	mutex_unlock(&kvm->arch.config_lock);
 
 	return ret;
+
+out_err:
+	kvm_vm_dead(kvm);
+	return ret;
 }
 
 bool kvm_arch_intc_initialized(struct kvm *kvm)
-- 
2.47.0.163.g1226f6d8fa-goog


