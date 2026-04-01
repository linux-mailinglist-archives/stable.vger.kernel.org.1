Return-Path: <stable+bounces-232869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDceKDmTzWklfAYAu9opvQ
	(envelope-from <stable+bounces-232869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 23:50:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69215380BA2
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 23:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 389FD3050BE7
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 21:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54C43806C5;
	Wed,  1 Apr 2026 21:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYWUMnru"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65777339872
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 21:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775080148; cv=none; b=T9rAmNpgiY46J9uQh6bZYjgGjlkGLJBRHxpixu6UTDbp/fl1wLEBigRqvwcc2OKWGuTGRomFb7cNCPWf+vagtAoOoc6PNNzNlitVGPgfTCME98SIRdbkvbAw2c3KdzyyI9Lt03WJnyt8gh1OfjwCFoTPxANBWC/Sbv+5QWC+lUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775080148; c=relaxed/simple;
	bh=xpfeRfEwx4Ob+LRv+rxTQXQuKagjWOR5soH19Grw50E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0/ly8fzHipz88iovkKqwNNJ1bJg+oOJLSIhkE1qKNYmQIKjbx9wI2TPprF62fBKXSr6/bCVcU8pqHXcC3ximz5gmpAF4YEt6sJtJRdrbJSYJ/KlcQS8Lk/qcvwx4NTcRssfBHyOe4azLmdlSBUI4Ujv/82N6OjL5z6syE+4O5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYWUMnru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274C9C2BCAF
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 21:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775080148;
	bh=xpfeRfEwx4Ob+LRv+rxTQXQuKagjWOR5soH19Grw50E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aYWUMnrujHEbIyJIvplE4bQcY/8+4yLzkrbOH+zOIVwK1G6QVst7EnEcnomrxjqGz
	 dyXGI3L7Miucrs00PNchjwyjtGdiexBhEGF0yhTWXHG7RqRNKbjtbUIKLIvBTEjwCW
	 nRnKyFOR4Yv6tjbaVQlkR92AsCLKdwrBgs1O79cdkQXZM9RanBKCmoL6hd60t+tiyw
	 4XJ3s5B0PfZRBoFt4rJvpdAOpAv2DW8RXxVIAn2bW3xPANqkaoGDuglBRKMYhrMdyA
	 bDM9bXpJomlhzw6o+bu8fX4VTZ9++8KmpEwg+m5AIzSD5EQlYyJf9dKVP3naPNmbpZ
	 B3qJ50yX5YiFw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so26082066b.2
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 14:49:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXjKY7m2uZWVhvBEI1V1ihjDsVW77Cf3HDawxDlB3MdjJEfIFoFHOM2M2gxnsHhZbFgV7Vdwcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpttsybIiQD0mhNk2fP51VWColiwWmTrSZiOTke3SEGYSAorAl
	67JJaBeeyJFlY7C6Uh7koKq6GGeyUope86N9TKXDdxt/lh83PUXsf+ob/rXzA37zD+dVWw3iCSI
	XcZMzMUz6PvKSfgfg5yol8Myvx/r+iqU=
X-Received: by 2002:a17:906:6296:b0:b98:7e30:8129 with SMTP id
 a640c23a62f3a-b9c13b17feamr385114766b.32.1775080146925; Wed, 01 Apr 2026
 14:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB29vr=U=SaQR9m_O_cZwEKAG2LTnbYGjE+uT0snUT7Jco_3bQ@mail.gmail.com>
 <ac1OXbMbAY4snEPg@google.com>
In-Reply-To: <ac1OXbMbAY4snEPg@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 1 Apr 2026 14:48:55 -0700
X-Gmail-Original-Message-ID: <CAO9r8zODkS5sViRaED9DS5UhuP2+wvUzCmF2L7MJuG0RUyEuRQ@mail.gmail.com>
X-Gm-Features: AQROBzDKnDKy3gn0pTOj-jM0BOZf9dJjxkiFcVhRMDXu0irBJUoilEaVnxen5aY
Message-ID: <CAO9r8zODkS5sViRaED9DS5UhuP2+wvUzCmF2L7MJuG0RUyEuRQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: nSVM: Snapshot vmcb12 save.rip to prevent TOCTOU race
To: Sean Christopherson <seanjc@google.com>
Cc: =?UTF-8?B?7ZmN6ri464+Z?= <jeon1691951@gmail.com>, kvm@vger.kernel.org, 
	pbonzini@redhat.com, gregkh@linuxfoundation.org, yosryahmed@google.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com,linuxfoundation.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232869-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69215380BA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > Add rip, rsp, and rax to struct vmcb_save_area_cached, snapshot them
> > in __nested_copy_vmcb_save_to_cache(), and replace all direct reads
> > of vmcb12->save.{rip,rsp,rax} with reads from the cached copy. This
> > ensures all consumers within a single nested VMRUN see consistent
> > register values.
>
> What is actually visibliy problematic?
>
> Assuming the worst case scenario is a WARN, then I'm very strongly inclined to
> either (a) not apply this patch at all and instead wait for Yosry's full series,
> or (b) have Yosry slot in the most minimal fix (e.g. for just RIP) in a stable@
> friendly location in his series.
>
> There are many, many nSVM issues that need to be fixed, many of which are functional
> problems for well-behaved setups.  For me, those are by far the priority.  I also
> want to fix the a guest-triggerable WARN_ON_ONCE(), but it's not urgent, and not
> something I want to spend a lot of effort on with respect to providing an LTS-friendly
> commit (though if we can get one cheaply, that'd be great).

I agree with Sean here, it's probably not worth fixing in LTS kernels.
The series has been in kvm-x86/next for a while and I don't think any
of us want to change that, it took a bit of work to get all the nSVM
patches there in good shape to begin with (and there's more pending
patches that depend on current kvm-x86/next).

That being said, I personally do not object to LTS-specific patches
(e.g. like the one attached), if Sean and Paolo think it's worth it. I
don't really have time to do that, but I can help with reviews
(although I will be OOO for the next 2 weeks). As Paolo said, be
careful that some older LTS trees do not even have the cached save
area, so they are broken in a much bigger way.

