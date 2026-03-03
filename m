Return-Path: <stable+bounces-222911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKCeD3USp2k0cwAAu9opvQ
	(envelope-from <stable+bounces-222911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 17:55:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EFA1F430B
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 17:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F01E319067C
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 16:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BD5481A92;
	Tue,  3 Mar 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v+D4dOzE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A1847DFB4
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556635; cv=none; b=DgFTF9kTdrizeHcXNijS4METZpohLhIa4yCZKT/ZO3/cyZHrTtrEhRGWUWQMMhH8fNlLnzyCWJMSyKywfooxPAkN0wSKbupIEIxMoKuyJDPl008L4CH+EcQzV62sRbUk4wQ7mda4rPnarLPICVBdxzvdDvcey9th6w+wwGsFuPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556635; c=relaxed/simple;
	bh=hCyX9uSwl3jnp1a2q2tCc6hQMVokAPgBe3H9js5yKT4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fb9uOEQNa3LnaTkVNPOJVVdAYSamENggpVzyQ4a/dVSaZgE9k8HJvBd0E9PFwN07XybR9DzKdaWFZtVTpbegSpBBXkEu6pPcO4TWmhsgzQXp0m7kutl+cDssIFX2OaVtaTrYkDyywGHVd2zTsUwwJq0z9mWu7nFkar1z8RGDgCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v+D4dOzE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae50463ba8so100843285ad.0
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 08:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772556633; x=1773161433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/l2cZgMpviDP0V+61Og9F5X9FaDhWq9sL3pv6ZfXjns=;
        b=v+D4dOzE7HbUX2rTk/pdMP1PjIyfDK52y2AA1uTLflEfAPWoeWt3/h+7P3lOzhE9ep
         0CGGfXcd+/kbsB9tF+QVyVoKYhWLQ2uHNsVxuo2CvlI70OUVwjJrCJEjfZEx9MNf7w91
         60sUWkss8uasGo9863alX1/NTFFz3M+g4xC0y7xVBrHZ9Cgdz6wKZsf91aPB8i1xDeVw
         cwfugfV9iNZzewoQ6whTW5ULe0Okl4yPgYlniV//qioKNi2GWopKRWkjBJ6gWeV4K5rw
         B0uMvVOmCHW8kLb9Ho+PaZEV8CjIsXJi5FCwZWuSV8fNX1EiDokZwZWn0bUK4FvvLkO+
         dd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772556633; x=1773161433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/l2cZgMpviDP0V+61Og9F5X9FaDhWq9sL3pv6ZfXjns=;
        b=NB8bdMnrYJ2xb4fYbf5UXncYFfh9MWfDUZzQrEanXJUnaeRYMYpZwkQvdApmg9+bxI
         xEEgRiwsKQIlYTjnq2TlFE/VjjS74LTkSH3zvXlQ84Rv6TtpJ+G2MlbpjneHKM+ghvAy
         yN6h1YUI444IcHw8Yc9LU5eQt4A4jFmz30+3N7dOje6ZQOKs6wI7Z2B5dSoPg9jECEA7
         qWtmq/m292JewA1QBIm9BrUanxf+ksZknGu0bnnoMOhqRBwRC0kjM5AzW6sWI/x6vR3I
         zCMziQ+DgHAudR4K3HuYn+6QCuaF5kCaQmF23EDizwgyED5cUZ3UoAlzJoN//ZDJvLZ8
         cCBA==
X-Forwarded-Encrypted: i=1; AJvYcCWbs+W2DhC8e49SbdOVokjriX4G9ai2HJOqEilTb5XowWO3wflMWoTi7jaC1qTbJQuODE7mSHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzeJyqW7H4cNkClCq3kSbAuyF5UlPRBbg/UnDq+Ka77t3C1Iri
	+1MtofW3gYJ4DKMblQ7Sqosei/FC1pQowIglAQPawQWUIBMjczjcyh68WOfmy1bjyhciSrMATxk
	YW5J9ZA==
X-Received: from plki15.prod.google.com ([2002:a17:903:1a0f:b0:2ae:525a:f974])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b85:b0:2ae:517a:6c28
 with SMTP id d9443c01a7336-2ae517a8175mr78595715ad.29.1772556633152; Tue, 03
 Mar 2026 08:50:33 -0800 (PST)
Date: Tue, 3 Mar 2026 08:50:31 -0800
In-Reply-To: <20260303003421.2185681-13-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260303003421.2185681-1-yosry@kernel.org> <20260303003421.2185681-13-yosry@kernel.org>
Message-ID: <aacRVwsI0x_kDZ0u@google.com>
Subject: Re: [PATCH v7 12/26] KVM: nSVM: Clear tracking of L1->L2 NMI and soft
 IRQ on nested #VMEXIT
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Queue-Id: C7EFA1F430B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222911-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026, Yosry Ahmed wrote:
> KVM clears tracking of L1->L2 injected NMIs (i.e. nmi_l1_to_l2) and soft
> IRQs (i.e. soft_int_injected) on a synthesized #VMEXIT(INVALID) due to
> failed VMRUN. However, they are not explicitly cleared in other
> synthesized #VMEXITs.
> 
> soft_int_injected is always cleared after the first VMRUN of L2 when
> completing interrupts, as any re-injection is then tracked by KVM
> (instead of purely in vmcb02).
> 
> nmi_l1_to_l2 is not cleared after the first VMRUN if NMI injection
> failed, as KVM still needs to keep track that the NMI originated from L1
> to avoid blocking NMIs for L1. It is only cleared when the NMI injection
> succeeds.
> 
> KVM could synthesize a #VMEXIT to L1 before successfully injecting the
> NMI into L2 (e.g. due to a #NPF on L2's NMI handler in L1's NPTs). In
> this case, nmi_l1_to_l2 will remain true, and KVM may not correctly mask
> NMIs and intercept IRET when injecting an NMI into L1.
> 
> Clear both nmi_l1_to_l2 and soft_int_injected in nested_svm_vmexit() to
> capture all #VMEXITs, except those that occur due to failed consistency
> checks, as those happen before nmi_l1_to_l2 or soft_int_injected are
> set.

This last paragraph confused me a little bit.  I read "to capture all #VMEXITs"
as some sort of "catching" that KVM was doing.  I've got it reworded to this:

Clear both nmi_l1_to_l2 and soft_int_injected in nested_svm_vmexit(), i.e.
for all #VMEXITs except those that occur due to failed consistency checks,
as those happen before nmi_l1_to_l2 or soft_int_injected are set.

