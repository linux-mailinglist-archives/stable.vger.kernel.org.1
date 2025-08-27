Return-Path: <stable+bounces-176514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A11B1B386A8
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 17:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAE25E65F4
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 15:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A40285CB9;
	Wed, 27 Aug 2025 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KDVR+Z3K"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A888B27FD6D
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308487; cv=none; b=bC52XFspeoBqIszISmgrHtoJGJG9cPoXB5n9wuz3yZ1zysT8ZvuGO/7vOgxfY1uu6aDRx7kh18wUsUBt4GgbT0hSZ2gSU2xS+wgbZssun0wC971Pnl/nbt+bZFG+phV0/T7RkUKce/81w5MyD9sK72EPot1RzfPq3siEHcOKoTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308487; c=relaxed/simple;
	bh=HSDP9rXntbbo/SzNMmXdiyg1N9BxuBhjXVJ/uBQBUrs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lcBelR5uUt1m1gm0YV8h36PmdbaUPzkZCXqAftG8Zs96PtAZ1TwqIIEIzzVF9ZCRgmmDi3cs46AYLBKBj+8YQfi0Mlbmm5Z961VtffwjzDsVytrYWDftiXwzzNKYcVo6ff4Ct2my28Qgc9LJtPXqWIAO8mLpdPdTbJSRtNUA9KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KDVR+Z3K; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-771eecebb09so3583943b3a.3
        for <stable@vger.kernel.org>; Wed, 27 Aug 2025 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756308484; x=1756913284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HLD5dyrFNqX9W25nsuFMTaYiQlg+FPGuA0/e2agvvXA=;
        b=KDVR+Z3Kqi1a7p3UAmc8wova5FRZgodWGOYGPCA2LDDfAdZ1lmzFgAMVjIsnmvGdep
         nRa3EGwS18wK83sU99GqlFUp2W4ZU7RS8ogt2Cg01wvvY1j/1w9+BYUCq1AuShZIjuUL
         hm/lKrQQUOQ3UliKPhaRZ0xN6mLSstflABfZl0uRn3R+InoN1NPFAEXlg21H/GQh0VxL
         PPqyZkW4oua5+wjmDm55uAMRbSaVYaESIeuOkp51vfC/3YEc6Swlj0rS14/E6hYkiY/c
         azuP13CVYdTGwTaplDT9s68WbF/rqKbruvJ/k8Ic62Copg6dCb6H7zHACzMVHqQKGBAS
         pBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756308484; x=1756913284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLD5dyrFNqX9W25nsuFMTaYiQlg+FPGuA0/e2agvvXA=;
        b=L4EVSzqp5xaLMpakXcna+M6jEL2cRqGcFwKIhlnZDKWsyZdbNC7Ot3RS1Xidye1xFr
         +nJc29zZwoPeFcOTsB7WQKm8ltIs4lltXZ39Q/39IO5GxQDDsnNkFWQKtQ0t1rXknkJC
         eDPlQMDAxt+BAaVFCEtKUSDKaTs9B3XqiDYLmkCI6c9HvXC9KW4IdlImkyBYvvG4/npW
         K05v/wpwvDfTkgHiaBYMCtggWrDgxIRKrYsIH3ik9ScM40MdGGi6RVyb02eQzijAyyPQ
         KTwxwpL/h19MiYd2yOPGPtwbU0g8R9sAbofn10317F8LfXAx+bIE8aGUdZGPzLt3bML/
         P62g==
X-Forwarded-Encrypted: i=1; AJvYcCWnNHTyxqMbXhtJZUYXUjVXsecGvigNpxCjOGVYNs7+evbR70rBVBH557KBNUfsqg1tldWFUDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXYrhbe89wAw/Otj49S1NXL2xthTdKEQ32PjrxCTAn1AJmDShe
	+o3y4RgmYD7Wk29HKVw+VLPyhcluw0uUMh+WTytB9SJGswN3C1CTD3WeBmNeN9AQmzIbJ9HfBDc
	j4zm6rYOBcySEEzhBDQ==
X-Gm-Gg: ASbGncv3UXq+GFyyw/1jghi8z98wkSfggYSrH9WTdtWGCm6BophgnzKIsZEYyJFphvx
	j3wRsMNNRkH5SWsB09yn6guBqA/GCTk5K9Khsm+hpWct1eTqFA+TgsXkIPAq1sxriHQn1jefXbb
	7ODLebfNeH+fZb0a1iIZBtqkOMoOOfpx2yZqkrwnwMkNhoCHqcBcQm+B/CBglSzwhpPCdiHqjLf
	1AhAUJZ1EL7j2m8rchv9+fwKHc2ePpp7NDMaVB+E+hUwmBNqkJx45ACCsq7E1WkocQdvnCIhQNw
	MPa9GVyumNV1AGa5qXGWqVYo8/VyA8hQw2OlSumgeP9WbnIdR4Kj6tcXa9akiLmvyjl0fcA25jP
	KgoEpOQSTfCfk1l8ixDfLPX+1p7J4X8MkpRlxzr5FRfzhIhIa+QgDBoy62mwn9iW2
X-Google-Smtp-Source: AGHT+IFjVJzj3KAq04af7jyaKVQPUw7/lh0Km2Xbvr3GuzkxjwaVXH1UDcAoO+QMmNUmibC3628sRw==
X-Received: by 2002:a17:903:3b83:b0:248:c96e:f46 with SMTP id d9443c01a7336-248c96e17f8mr4293005ad.60.1756308483845;
        Wed, 27 Aug 2025 08:28:03 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c1b2f5a3csm7630507a12.4.2025.08.27.08.27.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Aug 2025 08:28:03 -0700 (PDT)
From: Fei Li <lifei.shirley@bytedance.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	liran.alon@oracle.com,
	hpa@zytor.com,
	wanpeng.li@hotmail.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Fei Li <lifei.shirley@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH] KVM: x86: Latch INITs only in specific CPU states in KVM_SET_VCPU_EVENTS
Date: Wed, 27 Aug 2025 23:27:54 +0800
Message-Id: <20250827152754.12481-1-lifei.shirley@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ff90afa75573 ("KVM: x86: Evaluate latched_init in
KVM_SET_VCPU_EVENTS when vCPU not in SMM") changes KVM_SET_VCPU_EVENTS
handler to set pending LAPIC INIT event regardless of if vCPU is in
SMM mode or not.

However, latch INIT without checking CPU state exists race condition,
which causes the loss of INIT event. This is fatal during the VM
startup process because it will cause some AP to never switch to
non-root mode. Just as commit f4ef19108608 ("KVM: X86: Fix loss of
pending INIT due to race") said:
      BSP                          AP
                     kvm_vcpu_ioctl_x86_get_vcpu_events
                       events->smi.latched_init = 0

                     kvm_vcpu_block
                       kvm_vcpu_check_block
                         schedule

send INIT to AP
                     kvm_vcpu_ioctl_x86_set_vcpu_events
                     (e.g. `info registers -a` when VM starts/reboots)
                       if (events->smi.latched_init == 0)
                         clear INIT in pending_events

                     kvm_apic_accept_events
                       test_bit(KVM_APIC_INIT, &pe) == false
                         vcpu->arch.mp_state maintains UNINITIALIZED

send SIPI to AP
                     kvm_apic_accept_events
                       test_bit(KVM_APIC_SIPI, &pe) == false
                         vcpu->arch.mp_state will never change to RUNNABLE
                         (defy: UNINITIALIZED => INIT_RECEIVED => RUNNABLE)
                           AP will never switch to non-root operation

In such race result, VM hangs. E.g., BSP loops in SeaBIOS's SMPLock and
AP will never be reset, and qemu hmp "info registers -a" shows:
CPU#0
EAX=00000002 EBX=00000002 ECX=00000000 EDX=00020000
ESI=00000000 EDI=00000000 EBP=00000008 ESP=00006c6c
EIP=000ef570 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
......
CPU#1
EAX=00000000 EBX=00000000 ECX=00000000 EDX=00080660
ESI=00000000 EDI=00000000 EBP=00000000 ESP=00000000
EIP=0000fff0 EFL=00000002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
ES =0000 00000000 0000ffff 00009300
CS =f000 ffff0000 0000ffff 00009b00
......

Fix this by handling latched INITs only in specific CPU states (SMM,
VMX non-root mode, SVM with GIF=0) in KVM_SET_VCPU_EVENTS.

Cc: stable@vger.kernel.org
Fixes: ff90afa75573 ("KVM: x86: Evaluate latched_init in KVM_SET_VCPU_EVENTS when vCPU not in SMM")
Signed-off-by: Fei Li <lifei.shirley@bytedance.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a1c49bc681c46..7001b2af00ed1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5556,7 +5556,7 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
 			return -EINVAL;
 #endif
 
-		if (lapic_in_kernel(vcpu)) {
+		if (!kvm_apic_init_sipi_allowed(vcpu) && lapic_in_kernel(vcpu)) {
 			if (events->smi.latched_init)
 				set_bit(KVM_APIC_INIT, &vcpu->arch.apic->pending_events);
 			else
-- 
2.39.2 (Apple Git-143)


