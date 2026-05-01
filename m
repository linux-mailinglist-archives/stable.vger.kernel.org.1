Return-Path: <stable+bounces-242329-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM3BKiWN9Gn/CAIAu9opvQ
	(envelope-from <stable+bounces-242329-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:23:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4B54ABFC7
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6565F3009084
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B7E39FCB3;
	Fri,  1 May 2026 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="InxzDZJA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530E339EF35
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777634514; cv=none; b=JtTo4ImF01w5sep/aTAN2ubASORz3CTrRNzXzThvIllnGEx9NWMq8DMmaPCI/piLdorjY4OHKR6P0FPQS9qkfFF+LQ8EGp+G2HuNjL8m8HoOBE3HYdr3u7jfaAFTVY9SotyYEGo+rPQH+wl68LLmsc0UYWdqzImbU9F5T+EJ/hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777634514; c=relaxed/simple;
	bh=zyuV3AiKNchX6U73Dh4EBSlCZOT6K6NOUGVwnjSVKJ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T3PWqyf+5jPWmB/kdyUzYVddJZwz1U/Av1FQviViZwpCs+F685TK60L4w3EAZCwIcrS1Gn7V8MmaZh3i0BTSBXAtBzlGf2rVtagWbEpYLsLOZnScJ3GsNYVFzOfjIHeQAaENSw0Ig0ehG5gOWrv/GfJggHpJH072PUogU1eZGv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=InxzDZJA; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-488d1b5bca0so9948005e9.2
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777634512; x=1778239312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hoZhqW+DbuvcNP5ZEEtFHwCo3yR5b+Lks488o9s6mbk=;
        b=InxzDZJAZ0mzlW4Tqv+rS5z97/6K28ATxhPbveGEv7gZCu2JGNnUcPYtfb0OcVAJRF
         uYAC5isXERMAD+3aCfTwNFosqu7eadgzqrmldY88FvPzKYBB65tMcqbBXfx8Yoze0U1E
         vaFYTVadLvu5ecrXWCtWTPvQhYhEmuz62d8TgalsZ00Xom7Z5VsIvLkGOBadn/Xse7YL
         95YUFPUqfYc7JC1PuvPpacSUrqBduqt8awuf/TG9cyS9puupRdAaMaeXX3SS+ENYxtG1
         czndlVAcZ1sW2TbVNHZ09o0dAOVg4LDjLjTNXTpRAztGmbFWs7bcFIT/fMP4UqYa2MWx
         ZAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777634512; x=1778239312;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hoZhqW+DbuvcNP5ZEEtFHwCo3yR5b+Lks488o9s6mbk=;
        b=A/ipb89BukXpOC6t2DKDc4Z111g+BKJFPy5Nm7OBJx7VNuBs5rIRAK5FsnXXHXpGF4
         srt6L1SZp3ZA/etfVyn66ToKX3RZ5DMHp51aVUZULViR8cXw5NpUCXpcI7IaJSfBYqj7
         7nC9hac70vJ0HIsoC83bdGNEmldFPLOjT3/5ujpuAKvkCTuqQ8Br9OtdeWexRnnkITZR
         5+JDwUJGEjyquiG/qb4yRt7cz5ZbF/iIwz6lnwH20XgRzjRNAn8fO5iRMLW5YHqlPwZR
         IqowkTHIT/11taSNmpakGnM7ZJSP9d+CUdH0h5DblWASxLNG/hQajIHNubdavi/fXips
         AWlg==
X-Forwarded-Encrypted: i=1; AFNElJ9VUP0D3z7ZPjiwm49vfFbiZKt/55SbU/w8QYXYQlWgKuVu+1ro+qoWJYM1RLW96Smn60BwUBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr2IH18jyi1XMcwFttmLSXsr2Lk9ayQayiEB7/qtHse6fiKnAp
	Rh5lx0ghlt92zMe1OCqU23FKLMANjQr8XHjl2SozKdJEIBp5Ksv0XyV93usEs0rwElGS5wrcUh/
	UgQ==
X-Received: from wmbhu22.prod.google.com ([2002:a05:600c:a296:b0:48a:5c24:d305])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a30b:b0:48a:58ae:993b
 with SMTP id 5b1f17b1804b1-48a8451cfe2mr82955875e9.16.1777634511757; Fri, 01
 May 2026 04:21:51 -0700 (PDT)
Date: Fri,  1 May 2026 12:21:44 +0100
In-Reply-To: <20260501112149.2824881-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260501112149.2824881-1-tabba@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501112149.2824881-2-tabba@google.com>
Subject: [PATCH v2 1/6] KVM: arm64: Make EL2 exception entry and exit
 context-synchronization events
From: Fuad Tabba <tabba@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	qperret@google.com, vdonnefort@google.com, tabba@google.com, 
	catalin.marinas@arm.com, will@kernel.org, yaoyuan@linux.alibaba.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6E4B54ABFC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242329-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,alibaba.com:email]

SCTLR_EL2.EIS and SCTLR_EL2.EOS control whether exception entry and
exit at EL2 are Context Synchronisation Events (CSEs). Per ARM DDI
0487 M.b D24.2.175 (p. D24-9754):

  - !FEAT_ExS: the bit is RES1, so the entry/exit is unconditionally
    a CSE.
  - FEAT_ExS: the reset value is architecturally UNKNOWN; software
    must set the bit to make the entry/exit a CSE.

INIT_SCTLR_EL2_MMU_ON in arch/arm64/include/asm/sysreg.h sets neither
bit. KVM/arm64 hot paths rely on ERET from EL2 being a CSE, and on
synchronous EL1->EL2 entry being a CSE, to elide explicit ISBs after
MSRs to context-switching system registers (HCR_EL2, ZCR_EL2,
ptrauth keys, etc.). On FEAT_ExS hardware those reliances are not
architecturally backed unless EOS=1 (and, for entry, EIS=1).

Until commit 0a35bd285f43 ("arm64: Convert SCTLR_EL2 to sysreg
infrastructure"), SCTLR_EL2_RES1 was a hand-rolled mask that
included BIT(11) (EOS) and BIT(22) (EIS), so INIT_SCTLR_EL2_MMU_ON
was setting both unconditionally. The conversion made
SCTLR_EL2_RES1 auto-generated; because the sysreg tooling only
models unconditionally-RES1 fields and EIS/EOS are RES1 only when
FEAT_ExS is absent, the auto-generated mask is UL(0). The seven
other bits dropped from the old mask (positions 4, 5, 16, 18, 23,
28, 29) are unconditionally RES1 in the E2H=0 SCTLR_EL2 layout per
DDI 0487 M.b D24.2.175, so dropping them is harmless. EIS and EOS
are the only bits whose semantics changed for FEAT_ExS hardware
and where the kernel relies on the value being 1.

Make the guarantee explicit: include SCTLR_ELx_EIS | SCTLR_ELx_EOS in
INIT_SCTLR_EL2_MMU_ON so that EL2 exception entry and exit are
unconditionally CSEs regardless of whether FEAT_ExS is implemented.
This matches the pairing in arch/arm64/kvm/config.c which treats EIS
and EOS together as RES1 under !FEAT_ExS.

Fixes: 0a35bd285f43 ("arm64: Convert SCTLR_EL2 to sysreg infrastructure")
Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>
Assisted-by: Gemini:gemini-3.1-pro review-prompts
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/include/asm/sysreg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 736561480f36..7aa08d59d494 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -844,7 +844,7 @@
 #define INIT_SCTLR_EL2_MMU_ON						\
 	(SCTLR_ELx_M  | SCTLR_ELx_C | SCTLR_ELx_SA | SCTLR_ELx_I |	\
 	 SCTLR_ELx_IESB | SCTLR_ELx_WXN | ENDIAN_SET_EL2 |		\
-	 SCTLR_ELx_ITFSB | SCTLR_EL2_RES1)
+	 SCTLR_ELx_ITFSB | SCTLR_ELx_EIS | SCTLR_ELx_EOS | SCTLR_EL2_RES1)
 
 #define INIT_SCTLR_EL2_MMU_OFF \
 	(SCTLR_EL2_RES1 | ENDIAN_SET_EL2)
-- 
2.54.0.545.g6539524ca2-goog


