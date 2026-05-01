Return-Path: <stable+bounces-242330-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB1iBKKP9Gn/CAIAu9opvQ
	(envelope-from <stable+bounces-242330-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:33:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3BD4AC0F7
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0449830CB793
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3863A1E9B;
	Fri,  1 May 2026 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zvf3dQIV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEF639F19A
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777634516; cv=none; b=mpYVMB0RYFsbNOyLShBSCShIPl481EwzC1oAbo5MnRwuHoqVlUfb4fcvU2ssrvYxW8JOjYHlgI3lrXPe1SxoOvHe2kDPIGvS46oIU9mE5pSoEyYPk+tRzgwBoS8kVcgllo2hjGVFDtAYzsCF4svfJEiTTQSGFSrztP3GOStm6Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777634516; c=relaxed/simple;
	bh=BzOwJo7tMtTnOiFbCf1do1lKh7xZTwBmNLgdzfBWFIc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B1yEzHvI5n9iTgWiyD0XFVCFZlH3sD7qhMv8Cil2RJLDhk1CNNjDkTog4R5dl/LaM6jTW8/yZlAB7h2El1lDgbVp2phEwKzUQJ5/dloncNlmBNtCcQD1qvXyZkamtEdlIlXdvL9FezgZnt9SSZ6JaW8rC/0lCoRaZ3LXgtKdWz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zvf3dQIV; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-488d56f87e8so14272385e9.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777634513; x=1778239313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=llK0KM02OjlQ3dfGmbUJ3xamz2nXDZo+cJOrJzYBrAM=;
        b=Zvf3dQIV3LYO21yVthF5k4CucAc9DRmykSbnq9CR8Lg6Rur/7cxAV+yjBhtwDl9zkA
         95pUhwkiINy6Im7IBrqLUQR6LKhpVQFZcX9Ip4vzM2sURC8WOC60Y3ctOfkkxAYmTFLE
         OuaA+2D2XN5iW8F/pHIq2zOSilKvB5ODTFwJBztBvaJy+nRwu0JvpLum/XMns92tFUwn
         yo5Cu/frBhRjS8kV9vO4CgJriUAy8XEx4vgp1QJCUjDtzeB/Ap0dT+xeblGeJrJfTJ51
         OOzV6x4IvkkyFcyUjoCZi32h+l+rnX2WLUO/QL60V7kWSkL8HAzecsq+X495xFTqmwKt
         F3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777634513; x=1778239313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llK0KM02OjlQ3dfGmbUJ3xamz2nXDZo+cJOrJzYBrAM=;
        b=exdzNeW28Ow2rsbyMzKvR/Q87buNAdt6ShhGsCyAeNeQbJJk46ACPWS+NxaqsKybnn
         gJY9Csw+3r8ydJt9Z79W+7a6wAT7u5wPLDKIaNYAcXyTl6/BdnqeqkO4mNEgqmTKngIC
         +capB2BoM+DHWAdhFKSkRhHs4647Jx9/kM5QddLChiYUyZh02+BWMDH8sRK948nLLrwV
         ql9HgEFhQkw6jNkRzxZtwBknI4YStU61iINOy8EIKW2hCs061PttwyQTOlS1fciEoS8t
         UBuGB2REaqwWbmpyX0SPyRGwWdRkOfMwTWIR/Y0Z4KYrzs0ZrW4ZGJNrCN7CoR9Uxt++
         FMnw==
X-Forwarded-Encrypted: i=1; AFNElJ+AxWPbBlL7Y39N5DvHBYFZ+GY5l3R4Fu8p1SSsYEd8mMj+Ijym5nLxC9yLIoTTiX0LjZhUodQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1uEU81azjxehgA12jRjACMCMpD2JNW+eYAs+c1ULMKHBH1I4i
	BxbwxsqoGDcZs+F5zgGcuxuzkx/4roP3i3T2+J1TVw+C3yp3z09x3Hi3B/MnIi5fmTNMtmKUW2D
	CFA==
X-Received: from wmee3.prod.google.com ([2002:a05:600c:2183:b0:48a:5547:c79e])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:19ce:b0:489:1c32:210d
 with SMTP id 5b1f17b1804b1-48a8eb8834fmr41657655e9.15.1777634513137; Fri, 01
 May 2026 04:21:53 -0700 (PDT)
Date: Fri,  1 May 2026 12:21:45 +0100
In-Reply-To: <20260501112149.2824881-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260501112149.2824881-1-tabba@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501112149.2824881-3-tabba@google.com>
Subject: [PATCH v2 2/6] KVM: arm64: Guard against NULL vcpu on VHE hyp panic path
From: Fuad Tabba <tabba@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	qperret@google.com, vdonnefort@google.com, tabba@google.com, 
	catalin.marinas@arm.com, will@kernel.org, yaoyuan@linux.alibaba.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6D3BD4AC0F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242330-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On VHE, __hyp_call_panic() unconditionally calls __deactivate_traps(vcpu)
on the vcpu pointer read from host_ctxt->__hyp_running_vcpu. That pointer
is cleared after every guest exit (and is never set when no guest is
running), so an unexpected EL2 exception landing in _guest_exit_panic,
e.g. via the el2t*_invalid / el2h_irq_invalid vectors - reaches this
function with vcpu == NULL. __deactivate_traps() then dereferences vcpu
via ___deactivate_traps() -> vserror_state_is_nested() -> vcpu_has_nv()
-> vcpu->arch.features, faulting inside the panic handler and obscuring
the original failure.

The nVHE counterpart (hyp_panic() in arch/arm64/kvm/hyp/nvhe/switch.c)
already guards its vcpu-using cleanup with "if (vcpu)"; mirror that
here. sysreg_restore_host_state_vhe() does not depend on vcpu and
continues to run unconditionally, preserving panic forensics. The
trailing panic("...VCPU:%p", vcpu) prints "(null)" safely via printk's
%p handling.

Fixes: 6a0259ed29bb ("KVM: arm64: Remove hyp_panic arguments")
Assisted-by: Gemini:gemini-3.1-pro review-prompts
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/hyp/vhe/switch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 9db3f11a4754..1e8995add14f 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -663,7 +663,8 @@ static void __noreturn __hyp_call_panic(u64 spsr, u64 elr, u64 par)
 	host_ctxt = host_data_ptr(host_ctxt);
 	vcpu = host_ctxt->__hyp_running_vcpu;
 
-	__deactivate_traps(vcpu);
+	if (vcpu)
+		__deactivate_traps(vcpu);
 	sysreg_restore_host_state_vhe(host_ctxt);
 
 	panic("HYP panic:\nPS:%08llx PC:%016llx ESR:%08llx\nFAR:%016llx HPFAR:%016llx PAR:%016llx\nVCPU:%p\n",
-- 
2.54.0.545.g6539524ca2-goog


