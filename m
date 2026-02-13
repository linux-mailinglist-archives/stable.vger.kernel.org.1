Return-Path: <stable+bounces-216243-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH1uKak3j2n2MgEAu9opvQ
	(envelope-from <stable+bounces-216243-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:39:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BDD13722D
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8CC530459D2
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDFD361666;
	Fri, 13 Feb 2026 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0AC/4AE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF37361DBA
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770993513; cv=none; b=WpasXCwY54NJ3jrMS+wtJCpFlp6WUZb4OwLWKFkmWKYlSW0C4aWos+BS7G4fZz9Z7fKTSx8hi1jAdneJC1XyeDyVVifrQxF4NTctXltl/qzb8cP4yTYs7D9g14Pdrnf72UYm6tqMYYXTVnpqzaIu+7YnXTHtWOZMdbPYzD8H3Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770993513; c=relaxed/simple;
	bh=2Yh7aBShA6c8gQ4pY43dXnO0B18sPgc8K/vuxbeNWds=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iukH8kp14U+qa1xE+efcoYw3fXwsm2wjVzhcnnAWBZKdsl5BTxjQkGpQwVepX7NMbEOsY6T8jGsLTjeO1NXsCpFmsWS6sXLm0u51pwzIhySA9AemuShaaJ75qhD+2b8OVWMsh7jqMOSSVf7D08hlob/K5rID1y54pG31Wh4wasA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A0AC/4AE; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-437700715ddso966974f8f.2
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 06:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770993501; x=1771598301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/UGGDvqnPusZ8w3DOSxM5/L8hUMj6ctAm+38uUc+sw8=;
        b=A0AC/4AEKRdtNHuciJzG5zvmaNxp1lGVqG0JFg9OQUcKS5HMAVC56gVveqQiiGJQgZ
         vIYiryhGKvWyEcaBXvwrmQlJvyqQSKiDfsAlXPlVd5+5Ijrhym0ITk57hgUnuDXh3suG
         TNcfjWyAQOG0CR/RgtJoQTTIBWxC7rc2fyIVJSKz5qI7RYfCV7Tz54Wf8XAfVJkqAyas
         R76waxcS0XmdqwgnKMNsl1RFrzTAauZre6aTpHaDuboZMTM44RzSH/o86WSlvld2OZX3
         pkZ4DzTFf3kkqBaJ5BNB9Egjk/8q5+d6glDG4wzLjyuyffqIT+0fH/GZIJq56HpAgFwv
         GAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770993501; x=1771598301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/UGGDvqnPusZ8w3DOSxM5/L8hUMj6ctAm+38uUc+sw8=;
        b=P28TSrLimvtweeRlnbJwhtaUd9xn8spX2UQLpXF2s86aB728GflYERgXCnrOOT3m5+
         AR264p4h1LNuHVCSaJ11PWtTfKXlN1B75rTfu/xBLwAXwMdXGxB8aK4SzLUku1hmofnO
         zoxbXO6Q57ha7b64hToCVGQLdLlr3ycgffX+99ZiPhoSVz7RJOXxpyMWY+wJuypu3z3f
         dQFn1L/8GhOqY/dC5wgTYwW3wukLZBVlnTxDENX6FZma/XQN3mtSYGVaKL6+yjdoO5VR
         JdWSMfCMZKJRFaklFZROgb+8OIsF5kZLUzocn+F6yIjVwgde8Z49o3y3o/+e6PcA3ojw
         hCjA==
X-Forwarded-Encrypted: i=1; AJvYcCWNMLDsQmBkXKsLUl7PDtul2fUVu50VXHYJ8LyNlA3ZhXAcU912BHvDgigIsTnR+lzr1OvZucE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoE+jaRsbBs12en6Dr2c7njWkGofO59/1At8ZYi5iwhvN5sgHv
	hFiDoqUjJKydca7fiiddt0h+XwfrlJIQCL1Gb7WhTEvTqq9xwjxmLA1iRXS0ived6aPv8vMcE5j
	Y7Q==
X-Received: from wrqa11.prod.google.com ([2002:adf:f7cb:0:b0:437:72d9:7316])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:588d:0:b0:436:369f:39fa
 with SMTP id ffacd0b85a97d-43796af9ed9mr4847850f8f.44.1770993501337; Fri, 13
 Feb 2026 06:38:21 -0800 (PST)
Date: Fri, 13 Feb 2026 14:38:15 +0000
In-Reply-To: <20260213143815.1732675-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260213143815.1732675-1-tabba@google.com>
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260213143815.1732675-5-tabba@google.com>
Subject: [PATCH v2 4/4] KVM: arm64: Remove redundant kern_hyp_va() in unpin_host_sve_state()
From: Fuad Tabba <tabba@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, tabba@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-216243-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08BDD13722D
X-Rspamd-Action: no action

The `sve_state` pointer in `hyp_vcpu->vcpu.arch` is initialized as a
hypervisor virtual address during vCPU initialization in
`pkvm_vcpu_init_sve()`.

`unpin_host_sve_state()` calls `kern_hyp_va()` on this address. Since
`kern_hyp_va()` is idempotent, it's not a bug. However, it is
unnecessary and potentially confusing. Remove the redundant conversion.

Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/hyp/nvhe/pkvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 59a010221818..389fa5f09c3d 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -392,7 +392,7 @@ static void unpin_host_sve_state(struct pkvm_hyp_vcpu *hyp_vcpu)
 	if (!vcpu_has_feature(&hyp_vcpu->vcpu, KVM_ARM_VCPU_SVE))
 		return;
 
-	sve_state = kern_hyp_va(hyp_vcpu->vcpu.arch.sve_state);
+	sve_state = hyp_vcpu->vcpu.arch.sve_state;
 	hyp_unpin_shared_mem(sve_state,
 			     sve_state + vcpu_sve_state_size(&hyp_vcpu->vcpu));
 }
-- 
2.53.0.273.g2a3d683680-goog


