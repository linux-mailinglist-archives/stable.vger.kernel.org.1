Return-Path: <stable+bounces-218041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H8KN6lKnmnXUQQAu9opvQ
	(envelope-from <stable+bounces-218041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:04:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B89218E821
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7A903054113
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8348023EA88;
	Wed, 25 Feb 2026 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufQROy/I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46610231A41
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771981269; cv=none; b=p19tgKAJVTVTaaLQ2ToDKlEcKFPOY3HUf3r6XR9krrAUr4VghPPGEnJoAK0BUVC2ww6obw8l4EkaBFIFaoKVURE6gmMLqwU7mzOel/U7A6xxSGtmFRkf1fJhcvVFuhZT9a4YgQBAGMMDhtqggFDIC1cTjQ6A4cXUGE/w+LYNWlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771981269; c=relaxed/simple;
	bh=TfYc7xs5AoCgDmaQhtHDFVfWTb2Pd0soWTYMVW9mmTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojy06i3rbf2um1SQtny2CN72ClfyEDt3lIt+WR0h0COcmklrkh7Amj8A+Ey/g3GmnkPT+iOQwlmtt1az/sYJK1t8QjKq85lMySU+rL/EER1i1KJKtEY8zFI+w8qWlmyQcGkWRv7Wu8Doe3TYz0b+i7upHVDSIIu4yPumuqOVdmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufQROy/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC737C19423
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 01:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771981268;
	bh=TfYc7xs5AoCgDmaQhtHDFVfWTb2Pd0soWTYMVW9mmTc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ufQROy/Ig/AH26DnmlNZauasxPdWt9cp0agPMOibBhlJlDXvRvUimvw/bxo8vPOHg
	 /WnkXZIdOzDLumKJIJPbeAAUyi3BfPZpVqwP5EOSSbAUR82DsZ9YUjjzj/KZOpO4xn
	 FKHqCoTFOVrobTK+PsUztnbCBnIIxM7UqgyIr1ZZXfpbcIU6Wm4lwAD0f2l4rv49Q/
	 r3gpJUlJoDpYH2GhqW1Hsd9JDiXN1BWnhAZKKcLc4MGGxXR6QRdDUXgnrBxgZHNjv+
	 V3f9WSDulglJhBW7wHcRjMo8qo2D5JiJs6pRqro+qDqoA+IITF0eioBJ8X7k1IVSkW
	 mt1j2qc99TcRQ==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65b9608a9adso10387847a12.3
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 17:01:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVuASWrdcjQ1jnyUj+v0UEiwJGBM6NeNXLiYGedNlKeWfWINFcwOzqEn6rJApELnHXzvyHwDuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy79MekRdef0hh/38t8127R2mia1+3vhoFod0wUgAO6UaE4xbeh
	j/IZFFahlgWqxJukQeNjc6iSa6kQbBk47Kx4eM6CgEpcwCS+Und9ZDWbbPeSCD3NjX4PojDsleX
	AHViImAGz51E+vjgjuoNPJgncr+ltjm0=
X-Received: by 2002:a17:907:d94:b0:b73:6d56:7332 with SMTP id
 a640c23a62f3a-b9341903c5amr36094266b.13.1771981267786; Tue, 24 Feb 2026
 17:01:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223154636.116671-1-yosry@kernel.org> <20260223154636.116671-3-yosry@kernel.org>
 <CAO9r8zPsAMaiU794xoXDso3sdAM0_EN2PyE13vR4NqqEh9e2=g@mail.gmail.com> <aZ5ItfEUtIlVbzuQ@google.com>
In-Reply-To: <aZ5ItfEUtIlVbzuQ@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 24 Feb 2026 17:00:56 -0800
X-Gmail-Original-Message-ID: <CAO9r8zPbu1BsOsPU02YcCLDbRXZoDmVd8XiMHssSDnkjdDPC4g@mail.gmail.com>
X-Gm-Features: AaiRm52m3EoNOeCo__hUjoDPDKy5FvTWAW3YBfoYKKtnhYo-R9J1u6Qj27WjJ5A
Message-ID: <CAO9r8zPbu1BsOsPU02YcCLDbRXZoDmVd8XiMHssSDnkjdDPC4g@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] KVM: nSVM: Delay stuffing L2's current RIP into
 NextRIP until vCPU run
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-218041-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B89218E821
X-Rspamd-Action: no action

> > Doing this in svm_prepare_switch_to_guest() is wrong, or at least
> > after the svm->guest_state_loaded check. It's possible to emulate the
> > nested VMRUN without doing a vcpu_put(), which means
> > svm->guest_state_loaded will remain true and this code will be
> > skipped.
> >
> > In fact, this breaks the svm_nested_soft_inject_test test. Funny
> > enough, I was only running it with my repro changes, which papered
> > over the bug because it forced an exit to userspace after VMRUN due to
> > single-stepping, so svm->guest_state_loaded got cleared and the code
> > was executed on the next KVM_RUN, before L2 runs.
> >
> > I can move it above the svm->guest_state_loaded check, but I think I
> > will just put it in pre_svm_run() instead.
>
> I would rather not expand pre_svm_run(), and instead just open code it in
> svm_vcpu_run().  pre_svm_run() probably should never have been added, because
> it's far from a generic "pre run" API.  E.g. if we want to keep the helper around,
> it should probably be named something something ASID.

I sent a new version before I saw your response.. sorry.

How strongly do you feel about this? :P

