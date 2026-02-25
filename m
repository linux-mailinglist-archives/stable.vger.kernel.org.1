Return-Path: <stable+bounces-218042-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGQ1GzZMnmkfUgQAu9opvQ
	(envelope-from <stable+bounces-218042-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:11:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1AA18E8F5
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F33873048575
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F50242D84;
	Wed, 25 Feb 2026 01:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kl/m2iyK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E282236F2
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 01:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771981850; cv=none; b=MnryV0T1G+Qs4bVrVLAzZsXnBtQ653pdeeFnJw5ddhok4G1YXqJL01wvWxM64Ohuy3b+0i72yoWP4qPypBjxVnGheRphQ/I+cnEQLufAQk0Yuub9mRX9r82NBXk08BgCQNf/27qeUczE4HChhRujF32y9FdvKkR6a6Wl90WQ6NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771981850; c=relaxed/simple;
	bh=8TUpTIJK01jMNbiipMA0m+eOJ8TCpHdfxoyoTUJJY/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o9Y7eIDPI6Kgwpvk2XAcfPmc2zT5hQfU/BopGsEyRCYvGVYlb0s4jVwunUeHftVOA3n/EA7ero0tDxRiNRkv7DSkf2BAey+b8N1FCwxsIE7/CdgwCcSb5LT8mSPvc2X0H2gHTxjFsKl72G8UPQB6Lcr/jg5d61zQMCDFWhxM1G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kl/m2iyK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3568090851aso39408924a91.1
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 17:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771981849; x=1772586649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=edEEerY/uuzLYfl/fhpg5DczSB8bH9VefhPRmYKeqP0=;
        b=Kl/m2iyKUOuiNyYFVHCnD3IPlK1Y45dVtNCw02Xw+UgFKNTe5z8jFoNLaW0UlRQl7E
         +al1VnCWLbf/X/0wvDek331HXdHIs1YvmU6l5Qr9PfxpXGgZvTQnPI+abNSQiy5tCO95
         W4YX6xbI0o37emUZ7cwhKx3aKT6S7cibE6XCeGVL68E6YKfRKDPS8tr7e+YbqzVdVzQg
         7ZuCZ7LpoLnAOnkUl/R2c8vv0TNYvk21DYMKYQ8fOmDU9nZugG5xRGtVSNcRbJQJ+2le
         pBF034mg6ma26sCu8zswlO1ZV0AIGhphVWk+/zGucM3cUuES4gw644mQqkV81rRBObES
         AayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771981849; x=1772586649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=edEEerY/uuzLYfl/fhpg5DczSB8bH9VefhPRmYKeqP0=;
        b=JrY67uqHr0sCczjm/G+z7jlY5QBHPT53bnmmBpxAwVoC89ilPJ9lrXH/uM+VF7SaKl
         ICb0DIC2oFvrdO6BvlD/yZ9AwbaKsu94CZx8DpfCmyF0vO27QZnRimbdkc1E6Sd8Jyu+
         BCMhPt5n4kEextfeRG0sqsYDhY/zPM6BuJOqRRFqTCC8BWgebIG7bBuCUvxVlej/7JfS
         95oa5oR3hon/n/LskrmzdKEpdjOhC5vxey/tYeKJA7Z6fiKxCq0/5vEgUpBWKi+f3agl
         Gx2tfOmw9XDqIZONv9d0aV8aPX60oU9Jasd7dFDYIUfBM2Le2Sx5HBOQ4rBNiDzkdSuV
         fcRg==
X-Forwarded-Encrypted: i=1; AJvYcCWIyqbRWCD17gET+dBCSFSvFsTYwUKwf3hy//WjKKD2c3sUaQS/sbV26J2fJqzRg6bmO9XG1qU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw71olKAllEZpg7LSHP+bu9JK+FlLSJfjDN8LuENWHv+EOhmutV
	GhkJY/Ma2uGjuxwbjQZ65wxYfUeT2Vp4/bscrgB71JAGfMxByRH1kHbGxPW0h5k4kk0MD8PicKS
	Zv//2LQ==
X-Received: from pgbcu9.prod.google.com ([2002:a05:6a02:2189:b0:bac:6acd:8182])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cfa8:b0:394:76a7:1cf1
 with SMTP id adf61e73a8af0-3959f27008emr678982637.3.1771981848784; Tue, 24
 Feb 2026 17:10:48 -0800 (PST)
Date: Tue, 24 Feb 2026 17:10:47 -0800
In-Reply-To: <CAO9r8zPbu1BsOsPU02YcCLDbRXZoDmVd8XiMHssSDnkjdDPC4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260223154636.116671-1-yosry@kernel.org> <20260223154636.116671-3-yosry@kernel.org>
 <CAO9r8zPsAMaiU794xoXDso3sdAM0_EN2PyE13vR4NqqEh9e2=g@mail.gmail.com>
 <aZ5ItfEUtIlVbzuQ@google.com> <CAO9r8zPbu1BsOsPU02YcCLDbRXZoDmVd8XiMHssSDnkjdDPC4g@mail.gmail.com>
Message-ID: <aZ5MF8_RK56C8B9Q@google.com>
Subject: Re: [PATCH v1 2/4] KVM: nSVM: Delay stuffing L2's current RIP into
 NextRIP until vCPU run
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
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
	TAGGED_FROM(0.00)[bounces-218042-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB1AA18E8F5
X-Rspamd-Action: no action

On Tue, Feb 24, 2026, Yosry Ahmed wrote:
> > > Doing this in svm_prepare_switch_to_guest() is wrong, or at least
> > > after the svm->guest_state_loaded check. It's possible to emulate the
> > > nested VMRUN without doing a vcpu_put(), which means
> > > svm->guest_state_loaded will remain true and this code will be
> > > skipped.
> > >
> > > In fact, this breaks the svm_nested_soft_inject_test test. Funny
> > > enough, I was only running it with my repro changes, which papered
> > > over the bug because it forced an exit to userspace after VMRUN due to
> > > single-stepping, so svm->guest_state_loaded got cleared and the code
> > > was executed on the next KVM_RUN, before L2 runs.
> > >
> > > I can move it above the svm->guest_state_loaded check, but I think I
> > > will just put it in pre_svm_run() instead.
> >
> > I would rather not expand pre_svm_run(), and instead just open code it in
> > svm_vcpu_run().  pre_svm_run() probably should never have been added, because
> > it's far from a generic "pre run" API.  E.g. if we want to keep the helper around,
> > it should probably be named something something ASID.
> 
> I sent a new version before I saw your response.. sorry.
> 
> How strongly do you feel about this? :P

Strong enough that I'll fix it up when applying, unless it's a sticking point on
your end.

E.g. one thing that I don't love is that the code never runs for SEV guests.
Which is fine, because in practice I can't imagine KVM ever supporting nested
SVM for SEV, but it adds unnecessary cognitive load, because readers need to
reason through why the code only applies to !SEV guests.

