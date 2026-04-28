Return-Path: <stable+bounces-241545-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qELSC7iO8Gl4UwEAu9opvQ
	(envelope-from <stable+bounces-241545-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:40:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 608C6482CC5
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A1253046442
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653283EDAC6;
	Tue, 28 Apr 2026 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h00sOX+p"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A53EE1EC
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372217; cv=none; b=EKpwmRJO2BL3uWNGPJQjYJb+QPuYYBqlakIyfkhj1BRoTcJ3VrdvjqI6hPbfVhOC4dF7AhlBZzm4MNgEh/7mmWGMlbw3n692cEPvsrt1bTyxYhzBZsywxQ1b5Ki5Je1vWmJxLozs658O0hE40UyXOj1ZNzP5QPLU7SG5LmbL0Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372217; c=relaxed/simple;
	bh=pWsb4LXB9ThVgvldcf9CnL/d7vmpsynGuhGjfwFYyJI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ufxAYeubiM+ABR5DARGIaRsPZNy68TWWBIobmAYk5tEyOCAZRXxep2tR1GC+Sb28ZXVd0lj+hcSUI1QXReGN6TEWVHKGqeTkg2W/mxBm/fk0os2IgUzzwhmhX5YJbUPzbV9deN/fuykSn3ZeAizV9FiOB7QkYf+s+Vde+3DvUF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h00sOX+p; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4411a36715dso6672883f8f.2
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 03:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777372214; x=1777977014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GmmNYOk+NsHl9ECni3ZP17QcbrO127/DqtR017v434Y=;
        b=h00sOX+pg51AOtlp5hCgDgF+KVHtVyFQ+MoPG9ZPL840gpmouGfh4k2RMP8AOHwCVK
         Wifu5VudsNXcBTeodRMzowUtoc4MgJgSUeBY5McksMZg1bOtU91PD7VOLO3nqBCvosaE
         v8mo2OlikjdHPTKAFBCjSktEHhtg0dm1QskLJ6QY1N0VOHDazfCK/JlqbKYdVGIDWYRS
         ZxVbpjHO3fjJmFnRSF93R787hp3X76UzH8YhANDO1ug5KWwsJF5LU1x/GJk9Z1ShAxuM
         Bvy7eoVKq50zmX4LOjMQfs0iZu7ePuVdpLaZF+LTwaaSoCA5c/5Kw3zp0tD4TVSY2m2e
         gs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777372214; x=1777977014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GmmNYOk+NsHl9ECni3ZP17QcbrO127/DqtR017v434Y=;
        b=nR0rowVIWIoRmXy/OvnM+SU6+sRZrHD2CO92dz1Jc6+ZmykdTM0LL7IuIPpiqj2Ib8
         YbNSLNBV554FyAN9I7TcsOUWZoILpHKsMT86my8CuyCL9zT/YXoLiyp+pTvdNv+Z5xPA
         iTlqYiTK8te1DztYJwKI7GgpCz/Xpl2IxVnjfeOPynvVZOVCIifkCWml3s5AkKMqD7j7
         lWcScp6wDqsyIHtaXNDRuCoj3FULqOBIL4n/p0ebABU1xqHeQzA4sKVCfJTcJMCLg+6y
         6C0Q2cztQZXKAQ9AgqIte0QMRCsxBhES1+zsiufWqmnjvIwWZBDn7By3aEU77r5ZdkHZ
         AZ7A==
X-Forwarded-Encrypted: i=1; AFNElJ+6k80xrtJ4IPSUCecO/kUgBdYlHDF9mXtOToQYYeBfOrRZafZZh4S43+79fp5VaC4Y8mWf/50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLAv6nkYEGqKNUadoaGYplc68m2LyJ+H9vq+QRF1PmZQSAoSS5
	IaCjF6i8L05HFqCL73E+AsP6c33wUaHiBwsfyLzCyv769+fmwIAxyfphVF4q88vKE+U9Nvb6zCp
	tQw==
X-Received: from wrrn5.prod.google.com ([2002:adf:fe05:0:b0:439:d2b7:2393])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:26c6:b0:43f:e7c9:2402
 with SMTP id ffacd0b85a97d-4464761c29fmr4504996f8f.3.1777372213972; Tue, 28
 Apr 2026 03:30:13 -0700 (PDT)
Date: Tue, 28 Apr 2026 11:30:04 +0100
In-Reply-To: <20260428103008.696141-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428103008.696141-1-tabba@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428103008.696141-5-tabba@google.com>
Subject: [PATCH 4/8] KVM: arm64: Fix __deactivate_fgt macro parameter typo
From: Fuad Tabba <tabba@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	qperret@google.com, vdonnefort@google.com, tabba@google.com, 
	catalin.marinas@arm.com, will@kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 608C6482CC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241545-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

__deactivate_fgt() declares its first parameter as "htcxt" but the body
references "hctxt". The parameter is unused; the macro silently captures
"hctxt" from the enclosing scope. Both existing callers
(__deactivate_traps_hfgxtr() and __deactivate_traps_ich_hfgxtr()) happen
to define a local "struct kvm_cpu_context *hctxt", so the macro works
by coincidence.

A future caller without an "hctxt" local in scope, or naming it
differently, would compile but bind to the wrong context. Align the
parameter name with the sibling __activate_fgt() macro.

The "vcpu" parameter remains unused in the body, kept for API symmetry
with __activate_fgt() (which uses it).

Fixes: f5a5a406b4b8 ("KVM: arm64: Propagate and handle Fine-Grained UNDEF bits")
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/hyp/include/hyp/switch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 98b2976837b1..bf0eb5e43427 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -245,7 +245,7 @@ static inline void __activate_traps_ich_hfgxtr(struct kvm_vcpu *vcpu)
 	__activate_fgt(hctxt, vcpu, ICH_HFGITR_EL2);
 }
 
-#define __deactivate_fgt(htcxt, vcpu, reg)				\
+#define __deactivate_fgt(hctxt, vcpu, reg)				\
 	do {								\
 		write_sysreg_s(ctxt_sys_reg(hctxt, reg),		\
 			       SYS_ ## reg);				\
-- 
2.54.0.545.g6539524ca2-goog


