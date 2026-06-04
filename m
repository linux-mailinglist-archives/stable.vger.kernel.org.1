Return-Path: <stable+bounces-260526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id juLQCk6aIWryJgEAu9opvQ
	(envelope-from <stable+bounces-260526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 17:31:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA13641745
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 17:31:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=wA9qdrxo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260526-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260526-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC21631D8BBC
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 15:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DAE345729;
	Thu,  4 Jun 2026 15:12:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63DE33CEA5
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 15:12:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585944; cv=none; b=aUKNeMT4gSvR9rL12pFqyM5MSLl7hgtcKpBtuTMp0R9/6ArPfvXshbknkYO+XyHdIuuegrd9uFPzoV/Nyl61dhDOmAggPzXCf/H6YIffz7Dt6g1z2onsgNQsmoMOue1+fsslTJB22aJONacvZ2jHB8Lxwf6C34F92YEVT5mav8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585944; c=relaxed/simple;
	bh=VOtZe9auUIFqOGjFKwEy505Yv47yMzIefquCiVyONS0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TRkXK0v2dFQlEAGKDaQdMaRwzuztRWw3Y7U7ca8zMLXtBwcxJM1IFBEfw+h8VNfEANOqjSGSt09Xdj6SqErUBrX0VNo9Rabc3jnEnTorQ8M1PL+3+YXQzu9qoXGHmLGNDA+fQOgnIR/dWbtDOYd7uXN41kBf9dXZc5LTjrnuF18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wA9qdrxo; arc=none smtp.client-ip=209.85.221.74
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-460198535bcso586918f8f.3
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 08:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780585941; x=1781190741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oEYxqRws0IUSMm1LUk7BAiLRYO6LZtAhsNNeVVpZ2Ss=;
        b=wA9qdrxoiHSkA8ve72Ph2nPURaulcS31GnwhRjWm37i6B5nXbr0kIvIFUSjKIEtAqb
         Zy+PQg/ESXfu4L3n31dyTPHVYyi3505oLvMKQmKzQ/VzooEEeIIHuKiZzPlSJWexNunI
         jP27W23GenIzM0m4h+jXp6fPWzYNSR6S7KUiq0E0H1ukJcMZZKfUuxTK7+eHNrI46jVy
         Lv/FidaoXwT6BoVu0+MDMhYGjclOQvTlRVGvzsoP2CSr91mWZNnhKfkJRNLbPNBFYi+f
         CqLPmXMYZoqQObsyTGf7TBmWVD0WWqB4alfFIXLoB/Py2b/Qs2StVTxv5+PSkVulY4Da
         QH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585941; x=1781190741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEYxqRws0IUSMm1LUk7BAiLRYO6LZtAhsNNeVVpZ2Ss=;
        b=XmBiihs6RM0449p8ayIsp2n27Yfsr4c8e5parFjaav15EG8XZ/3ofDfMhsGeLKOvMW
         5rOgdBUUdmTRs6Rr1zIdWD2YkR5oSbzW1zQ6HcarzAnfja2pPt+oh1HcU29wR52oUd2z
         bonh0X5hE22UOzeglGd4Dhwj009kFOA1EleGnUF552DIWu13VXlVnfMNaL6XpY5omnpL
         NI+WLPB62Ji5qWQZ0R1y1yKcPgoLM4TiAkDZdtgrFdExlsBOiK1fuScGeBNFWvlIkVsz
         4FwVOf4VmxtDr8MErorUtlD9T5XckryNbPKBbhrK38MeZlsWcHIPwrsox+hcjTwO4fUR
         Dq0w==
X-Forwarded-Encrypted: i=1; AFNElJ9CPUgdLbkMif2247cHsDMZiX30JCFmJjT7c2kIh68f0AciJr/83+pV1cuM0xBSymzlERYuu8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM0Y8sPEu3kGe2AqVq7LWn9J8/w0zeEoaNmpYTGARJApDZspRV
	e4c2ysn5sQnHEogEnyyMI4XImaehpnqbfxlptB2WGh8wdubSpdGrIy7lMQ2bINVHi4ubXl2w5A=
	=
X-Received: from wrxa17.prod.google.com ([2002:a05:6000:1011:b0:45e:f34b:e7e2])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:508c:0:b0:45e:e513:f451
 with SMTP id ffacd0b85a97d-460216bdfc2mr10238730f8f.7.1780585940926; Thu, 04
 Jun 2026 08:12:20 -0700 (PDT)
Date: Thu,  4 Jun 2026 17:11:56 +0200
In-Reply-To: <20260604151151.150377-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604151151.150377-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172; i=ardb@kernel.org;
 h=from:subject; bh=dgwiIv5ocMLxRg+g7B0P7cuef9P7d1jooOl8YYuWFh8=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtx6j7/xBdu7ww3VF8umHhOrTxmv1X/ehmmq7us1DyOv
 i0p29bWUcrCIMbFICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACaiuJuRoTl9/jm1B92rg88s
 qn5ctuPIxa2HebZOu21xL9pGok+oyYThv/c2me2fBNfc1z/w6F3xuZ0hWWpsYfkRcSH9aW1urJd 4WAE=
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604151151.150377-11-ardb+git@google.com>
Subject: [PATCH v2 4/5] KVM: arm64: Omit tag sync on stage-2 mappings of the
 zero page
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, Mark Brown <broonie@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260526-lists,stable=lfdr.de,git];
	FORGED_RECIPIENTS(0.00)[m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:will@kernel.org,m:catalin.marinas@arm.com,m:ardb@kernel.org,m:kevin.brodsky@arm.com,m:broonie@kernel.org,m:maz@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ardb@google.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BA13641745

From: Ard Biesheuvel <ardb@kernel.org>

Commit

   f620d66af316 ("arm64: mte: Do not flag the zero page as PG_mte_tagged")

removed the PG_mte_tagged flag from the zero page, but missed a KVM code
path that may set this flag on the zero page when it is used in a
stage-2 CoW mapping of anonymous memory.

So disregard the zero page explicitly in sanitise_mte_tags().

Fixes: f620d66af316 ("arm64: mte: Do not flag the zero page as PG_mte_tagged")
Cc: <stable@vger.kernel.org> # 5.10.x
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kvm/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index d089c107d9b7..445d6cf035c9 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1479,6 +1479,11 @@ static void sanitise_mte_tags(struct kvm *kvm, kvm_pfn_t pfn,
 	if (!kvm_has_mte(kvm))
 		return;
 
+	if (is_zero_pfn(pfn)) {
+		WARN_ON_ONCE(nr_pages != 1);
+		return;
+	}
+
 	if (folio_test_hugetlb(folio)) {
 		/* Hugetlb has MTE flags set on head page only */
 		if (folio_try_hugetlb_mte_tagging(folio)) {
-- 
2.54.0.1032.g2f8565e1d1-goog


