Return-Path: <stable+bounces-254642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEzhJL8sF2rd7wcAu9opvQ
	(envelope-from <stable+bounces-254642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:41:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 096585E8647
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 699D0304DEA1
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 17:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2641A44DB69;
	Wed, 27 May 2026 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cPUVaU6b"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43823E9F95
	for <stable@vger.kernel.org>; Wed, 27 May 2026 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903658; cv=none; b=Ibg4eqNY8LLrrdtJnW9G4ilh3vk3O63rg9VfvVmNHSHbKBxwRliZ9D1hOiePmx88iFvuG4hvBGUrwC7T3C+Rku6oYFRsQy0NlTjQaEDHhrbWJEd0IfGeKxHAxf9UcMvS4hqHefgMSQTwfF7LKoO0KUS9QBugaicjsNCMd+20nVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903658; c=relaxed/simple;
	bh=NesVSvxjeriy8JrLCo02bPpWiXiqhTNJcG0UfxEm1oI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=swzWXa9Z3NufDwpP3NMjCtudMe5qU8+BL1S96UmdvMl3Gev2oh1RnAjqg2SWG5MEx8fP75MW0oD1OQeor98s6U55KxFc9obsfV0Q8+HvCRAr2n4TqyJmzIfqjK05mn1hSLxKq37kPCydipiJdTrRwrINDKp8aEhD5EUrYTtUrrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cPUVaU6b; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba268cb5e6so126506335ad.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 10:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779903656; x=1780508456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qag9lBdsZqOV4kYaafONmBvRHghB6X57fmrdhvqCEr4=;
        b=cPUVaU6bGwz4572efz4CeNyXF5ddFGzV2VlGRiZS+OCUQzyH73RTx7A90eC19tpFHA
         +Nesg50Wx0A6WUMsFePr/Cj8tyya9dukxGgm4xNlqdQnL7vhP8v/kcovDj4Z5O3kLz2R
         moPdMWYvLA48inVJXO9vh7WGpEbfhuFmMJ7sqK+U3o7CWlTL4rBaxV2LrDethOcJSP/j
         B0TNsh5FKMcW7gbcCcn2zX1aof0hpRscnaJCre9fRrT5QWQJi8a40ArFCpdbHRVuDxml
         6C2CpNC/kJR5Uj/4QqIkj5qmvN2zyLIPHMG19YaUZrGaRigXkTxFN2j3t+exzgbvcGDH
         Or3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779903656; x=1780508456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qag9lBdsZqOV4kYaafONmBvRHghB6X57fmrdhvqCEr4=;
        b=E/7aDqrticUiU7Z+vDa/HWO55vfAzzz0+F+PzGq9h5if1KqxdF+yy2OBRuCg46ar6N
         h1o+IO0GJEj160bc6IxwDo7n4ZLSfA46nggS87wM1sANQeZtUyxhaGxCeyy7JAgUkFNW
         pMKV7GwkyjhcIdjKca4bJ0AqfijV53Qq/6a7a3FVk8H0V+wy3o4IEnAjudulHT8OQUNo
         BnTybSTzv0sk75jiC98gsZHxlAZp9DJQ+2f3Ld3PogFIaNp89uWsFTAEj1hgxVw6pC4r
         IglINr6l0nUhZBac8LVUQL8qyIQyFz5ebbBHtBiB43qBU7Njayhg1VNM7NKcEdPt/ZnR
         4l0Q==
X-Forwarded-Encrypted: i=1; AFNElJ9MQsIxF3A0wLE4tFrjmNVO6TZWMq2g1sh4c3Is5DQ5O2txJw/23/ABfbKW+y0964tgrrrlXkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcVRkV52TY188f0rKPDZXW2PgLapLwTH1RaU1Doy8vJYF/Pi3i
	2ctMN34N7FdqxlxBlbXRRr/zffVMNQFLHgnCg0lEDfBLAyiAJVv7AjBC9i+5I+E+oEGQLNOL4ZJ
	Ojv+D6Q==
X-Received: from pgii35.prod.google.com ([2002:a63:2223:0:b0:c79:22b6:a344])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9d91:b0:39f:9eb3:1d09
 with SMTP id adf61e73a8af0-3b328ee2e52mr24673521637.37.1779903655856; Wed, 27
 May 2026 10:40:55 -0700 (PDT)
Date: Wed, 27 May 2026 10:40:55 -0700
In-Reply-To: <ahcY4S7shzG_kDt6@Gautams-MacBook-Pro.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518044150.34632-1-gautam@linux.ibm.com> <agu2UAi6lWclxFYh@google.com>
 <ahcY4S7shzG_kDt6@Gautams-MacBook-Pro.local>
Message-ID: <ahcsp0tfST5AGdMb@google.com>
Subject: Re: [PATCH v2] KVM: PPC: Kconfig: Enable CONFIG_VPA_PMU with KVM
From: Sean Christopherson <seanjc@google.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, atrajeev@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254642-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux.ibm.com,gmail.com,ellerman.id.au,kernel.org,lists.ozlabs.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 096585E8647
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026, Gautam Menghani wrote:
> On Mon, May 18, 2026 at 06:01:04PM -0700, Sean Christopherson wrote:
> > On Mon, May 18, 2026, Gautam Menghani wrote:
> > > Enable CONFIG_VPA_PMU with KVM to enable its usage. Currently, the
> > > vpa-pmu driver cannot be used since it is not enabled in distro configs.
> > 
> > That seems like a problem to take up with distros, no?
> 
> Rather than enabling individually for different distros, wouldn't it be
> better if it is enabled with KVM automatically? I can rephrase the
> commit log to emphasize that this config option is only relevant for
> KVM (similar to CONFIG_KVM_BOOK3S_HV_PMU).

Not if you can't turn it off.  As proposed, CONFIG_VPA_PMU gets forced to
whatever CONFIG_KVM_BOOK3S_64_HV is set to.  At that point, the existence of
the VPA_PMU Kconfig is pointless.

If you want it enabled by _default_, then turn it on by default, e.g.

diff --git arch/powerpc/platforms/pseries/Kconfig arch/powerpc/platforms/pseries/Kconfig
index f7052b131a4c..74910ce3a541 100644
--- arch/powerpc/platforms/pseries/Kconfig
+++ arch/powerpc/platforms/pseries/Kconfig
@@ -154,6 +154,7 @@ config HV_PERF_CTRS
 config VPA_PMU
        tristate "VPA PMU events"
        depends on KVM_BOOK3S_64_HV && HV_PERF_CTRS
+       default m
        help
          Enable access to the VPA PMU counters via perf. This enables
          code that support measurement for KVM on PowerVM(KoP) feature.

