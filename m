Return-Path: <stable+bounces-242332-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE4kGrmP9Gn/CAIAu9opvQ
	(envelope-from <stable+bounces-242332-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:34:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 179E24AC114
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E086E30D32D6
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBAB3A3E98;
	Fri,  1 May 2026 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZEiGNOFx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEEF3A2568
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777634518; cv=none; b=fN7JKEkdPAqEXxOiCjvdTSeEo0u2vkj0hf6n9CT+EIkk59q+6yPFMVruhW1gPggWB9gs9aHLo4RSMQU4vlL2+i9UOrxtren+OcCK0XaXw2YPnGqq/uawn/m609s433kXrIB0aaQMDY2YtXAanFcZ114jytbRe5wltEqIF/QULV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777634518; c=relaxed/simple;
	bh=WNOrRSdjW6v3MCflD6MesgXjVe7HTEIv6WOiAqLeuXs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eIg6jL/S7azFH/mTZMh7VK7Za2iW3enRt1+D7vL5vSj0Q2yiJ/eLCsxKlE9uj9o7e5WBHR1pv0X58OZ+oXcLnBZd7b97nWsOePst7oPcf0JiO8heOdv9z6TSQ+X5a52XULsvyGh0gjacW+dvNP+okJf2sr+u9lnjPlkeWRU4qu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZEiGNOFx; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso19975355e9.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777634516; x=1778239316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aYwcKF+O9BRV6I0nh/EUmrDeLL0Ut6fk04SddS0PCXg=;
        b=ZEiGNOFxmeyWksOgyCaEDkowsKSIiloV/zAB44LYxbnkp2L3yLXjOyGTNb0zGZa2iY
         EgwRpsBxRBD7uYziDYXDeuR4wgJBIe+QrLN0NVzI5iXOOWzFYe83Up3p75mBimwjhwa5
         xgj+WOTQrZvRR4sYKhTQzWNtVqW0T22DuXo1DkOxN9rLLKu4TeNsVJawN6vQmQnNamk3
         c21HwxU+7mythsHQkSC4YGNw9qUfaNGpp4KLbN/BgkMDjr9EyaPFaHeTq643qZQbiUBg
         RexycvPhm4vWM5KcZpZ8oK83rGIJxmswZVh998L/wcUSDPltyTcDIcl/kz9noXY6oWTV
         WfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777634516; x=1778239316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYwcKF+O9BRV6I0nh/EUmrDeLL0Ut6fk04SddS0PCXg=;
        b=FA4XwVfmMmWwh2g1eoVg+uHab+6vmwU7JPflroA/lezkjs/OEJjuDHSuOKMbcx+Qv+
         ssvFMmMnd6/3lnYXlk7P2HCDXprKwmsIWPRx0asvyXAAbjNve6OcX6Ru12qaMRVmdRsF
         gYa2j9Eku3Yd7AEGcTe9tfF2atna9V2OzKe8RgUWVAebKzTJh8xxFYlcPxKXeNRnkwdU
         9Z9IcmVVhrshYGbtALCjWd1g/cYKEKjdSfUJPnVOSXiyXH402AiL3YrceM2i0qYxugIl
         BOulZnDHFOzit5Vjm8+7RKdU/J+H9QLF4jbI9LzTC5vJVbe+TfdSXyEfJN+QjcEdiwp6
         xmJA==
X-Forwarded-Encrypted: i=1; AFNElJ8rBak4FwVk1IECsGewM2/GIWbnB2U6OGMx4s2HtHGsVS9e/Aa+F/YxlYzDjLhMrNnvS1gsYh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDnuCsiANRRMQZFXlAkPrLaQhEtAdTZOzzdVmFXmMp558zfOcT
	Kr0gOTu/QGwgDLvy8tjGiGuDU+lo6mR5K1x7mTUIhExRFrcWBcH8JlIKqy5ROvlDMDLCOmbUFVI
	tXA==
X-Received: from wmog7.prod.google.com ([2002:a05:600c:3107:b0:488:a71c:cf48])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4594:b0:48a:52f2:a0f1
 with SMTP id 5b1f17b1804b1-48a8444fac4mr110930795e9.18.1777634515632; Fri, 01
 May 2026 04:21:55 -0700 (PDT)
Date: Fri,  1 May 2026 12:21:47 +0100
In-Reply-To: <20260501112149.2824881-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260501112149.2824881-1-tabba@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501112149.2824881-5-tabba@google.com>
Subject: [PATCH v2 4/6] KVM: arm64: Seed pkvm_ownership_selftest vcpu memcache
From: Fuad Tabba <tabba@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	qperret@google.com, vdonnefort@google.com, tabba@google.com, 
	catalin.marinas@arm.com, will@kernel.org, yaoyuan@linux.alibaba.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 179E24AC114
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242332-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The hypercall handlers call pkvm_refill_memcache() to top up the
hyp_vcpu memcache before invoking __pkvm_host_{share,donate}_guest().
pkvm_ownership_selftest invokes those functions directly with a
static selftest_vcpu that has an empty memcache.

Seed selftest_vcpu's memcache from the prepopulated selftest
pages, leaving the remainder for selftest_vm.pool. Required by
the memcache-sufficiency pre-check added in the following
patches.

Assisted-by: Gemini:gemini-3.1-pro review-prompts
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/kvm/hyp/nvhe/pkvm.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 7ed96d64d611..deee7947d694 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -751,16 +751,30 @@ static struct pkvm_hyp_vcpu selftest_vcpu = {
 struct pkvm_hyp_vcpu *init_selftest_vm(void *virt)
 {
 	struct hyp_page *p = hyp_virt_to_page(virt);
+	unsigned long min_pages, seeded = 0;
 	int i;
 
 	selftest_vm.kvm.arch.mmu.vtcr = host_mmu.arch.mmu.vtcr;
 	WARN_ON(kvm_guest_prepare_stage2(&selftest_vm, virt));
 
+	/*
+	 * Mirror pkvm_refill_memcache() for the share/donate pre-checks;
+	 * the selftest invokes those functions directly and would
+	 * otherwise see an empty memcache.
+	 */
+	min_pages = kvm_mmu_cache_min_pages(&selftest_vm.kvm.arch.mmu);
+
 	for (i = 0; i < pkvm_selftest_pages(); i++) {
 		if (p[i].refcount)
 			continue;
 		p[i].refcount = 1;
-		hyp_put_page(&selftest_vm.pool, hyp_page_to_virt(&p[i]));
+		if (seeded < min_pages) {
+			push_hyp_memcache(&selftest_vcpu.vcpu.arch.pkvm_memcache,
+					  hyp_page_to_virt(&p[i]), hyp_virt_to_phys);
+			seeded++;
+		} else {
+			hyp_put_page(&selftest_vm.pool, hyp_page_to_virt(&p[i]));
+		}
 	}
 
 	selftest_vm.kvm.arch.pkvm.handle = __pkvm_reserve_vm();
-- 
2.54.0.545.g6539524ca2-goog


