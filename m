Return-Path: <stable+bounces-242331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBHFDrOP9Gn/CAIAu9opvQ
	(envelope-from <stable+bounces-242331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:34:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 877D94AC106
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DD1F30D0D1A
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A653A3E68;
	Fri,  1 May 2026 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vHfB7CXn"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874BD3A1E7F
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777634518; cv=none; b=RYpN43DX3HptWE2mkeZCb+8Mpun9JP1xVsPYnJ+HdgUHZy36e6iE62wft2wUACW3Qp5BiEz7c+NMCUHW2e7EcmFCsv9oBL7dxUVJQZBbzNojj7ZXsQjcXnYxUpggo+chLLcTvyhYDXPT8Tjb/Jk03C1D5RtdoqBcHuiLeTI4GEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777634518; c=relaxed/simple;
	bh=W4DGq5FQ3yG9XVJf1X8noklkNaBHnhoJ5jehTTSaoHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tth9alVyF3c2gBtgNocTLQi5iPs68hEFDvB6gF9ZFwksskZ9YyXT3BY79AvJk74abCUPFsXhYXuDKOXRC8YSqRdVm1VhdgGGJDO3Sboflloj+z77+Ouo2GD5GuBRR5HP9lRZfaSnnZRA/76COk2UrVmTkUek3NUUrt5cVFUdxBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vHfB7CXn; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43cfedb10a8so1066587f8f.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777634515; x=1778239315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pkGXruA+MAauMM9ApRELF9QcQ1O0uA1Qqp7VMYhHPII=;
        b=vHfB7CXnA6HLfD/TQSlsdnUza/QkrhrPkWjeLuLrUwN1rj3Ql5BWVHMNtfDNgFtWM/
         mk8gzq6ZzILMF3Qmi/FB+RyjSqwXd2EcQa+xC2p7YIQPeN2dPBBzXfi6KUgnhPdGkzTJ
         R4cygR6MTJVgwD/vjj/4Rvf/z10Eon/uXTolBp0PKA5bZLxC03M15luMl3U0F/aXlLG5
         /vTXLfq7Yn6bL/vbRNZlNXkj2PYFS7s17e2Bbe/rLWwU+X3x3Zxwq/t+caHgqHWoUGMD
         yaV128rNrKUBbqSCuDAAFy8blYpp+9Q+d7Jt58E4t6YeYbCl8P5fimfljiw7D3jKuExh
         OStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777634515; x=1778239315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pkGXruA+MAauMM9ApRELF9QcQ1O0uA1Qqp7VMYhHPII=;
        b=nAHI1FgSZuzQuY8jo8AioW4F7y/yxQOVNvQAZGixCEcbr8eGG//Hxb0YyJSPihJ+XI
         X9BQRGcOL8tW/65uz88IQ4RHC4R4c8uIVu26iVJ44gz3g+cJDE88VQ0lHdiSk0SIFVPS
         IF6i5WyPZMYgdnZCESIYFqDKJEfifJEfm1FpmYx2WRwXWBHh/R2ChBR+/9zOGW6Ok/Jq
         z4FPR9Bqqy3wtjoyQIegNQp2NYDoidRSq+sTNlQBMcdNdSpf0w9SLoQlqhmDJ9LB9LVO
         j+CyKa1ozJCqNg/Qa5GJ1C/DiJ3nRsC7Ncb2bxZGWvfbrodDe1U+3vnMvj/jOh82SIQw
         5WjA==
X-Forwarded-Encrypted: i=1; AFNElJ+YHFTeIxjDNcv7ohNleYVCJIQUqIoq7y+tYMDSIn0ylPG5dY34fGhVwxqCYety8tcM0mqQcx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUklTQfCuHQhk0i2x2022w+AgnBeC1+JA311ANqdMNI47Mb9zE
	E1J+nEPW1JQ/P6VXzIH3WAYTbtC2xXS6/IGjefRxf3WQy6iMp49H2G4TV8kf6BESWyC0Mal2uch
	qLQ==
X-Received: from wrcz10.prod.google.com ([2002:a05:6000:454a:b0:44a:2a68:f4aa])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:24c5:b0:43d:71f4:7ed5
 with SMTP id ffacd0b85a97d-4493cc3fdffmr11707041f8f.17.1777634514643; Fri, 01
 May 2026 04:21:54 -0700 (PDT)
Date: Fri,  1 May 2026 12:21:46 +0100
In-Reply-To: <20260501112149.2824881-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260501112149.2824881-1-tabba@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501112149.2824881-4-tabba@google.com>
Subject: [PATCH v2 3/6] KVM: arm64: Fix __deactivate_fgt macro parameter typo
From: Fuad Tabba <tabba@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	qperret@google.com, vdonnefort@google.com, tabba@google.com, 
	catalin.marinas@arm.com, will@kernel.org, yaoyuan@linux.alibaba.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 877D94AC106
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
	TAGGED_FROM(0.00)[bounces-242331-lists,stable=lfdr.de];
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
Assisted-by: Gemini:gemini-3.1-pro review-prompts
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


