Return-Path: <stable+bounces-217796-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJsaK+2MnGmdJQQAu9opvQ
	(envelope-from <stable+bounces-217796-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:22:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A9C17AB70
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C985E30101F8
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 17:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23708331226;
	Mon, 23 Feb 2026 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qr+WzQzQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E902F60CC
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867327; cv=none; b=mQsRyPg00ciwGGpb8+gvhgtVFCA/bF9KsSw0f4aEpKnevoJu7rCdYA2e2vxaSz6KB4CAWfg4h3u13KFD9hgYc4+dYl4hh4LGSFHLhlvVM9MZBYQHWMUjypeaJRoSIAOinFYBT9Dx4QML2tGPKSz6cwY5tay+MAzkB0RhFFME/Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867327; c=relaxed/simple;
	bh=9OOWpG0ivjp12xj5kOLDESJOJ/tOXEg8NufUZP4qUn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A37JDcaP1R7jM+pnMobsUa3kZ+Q1XP2N8JfAOtUvseRNxRelHPiYyopMBgVUBr9uKYCW8O7rvHQ7tsavzQQe8FmGrWI0M3j0qVRghedRc55CSG6ztgSjmYLVEyDsqxdSgNR6dfVrWI3qkLjXF0EFRsR+FyZ0nylN6b5BvpSgh/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qr+WzQzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6C6C19423
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 17:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771867327;
	bh=9OOWpG0ivjp12xj5kOLDESJOJ/tOXEg8NufUZP4qUn0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qr+WzQzQAvr8gmJYJXvgYtfD3T8fjlhPvTPLTalFuGeBdPFV/WGkuvBe/kgNuKYuQ
	 6RCjSx6CGQqTspwjCvcQs1TtA2gfJGxby4FIv20Zf7mIJ5STSKmwVbbfrbIsHH/iyI
	 snP3JZIi0OLobAWtKX8fqPRqxJXWyincafISFffeX/OmgvxQ0NmO7zkJYueGz2IHRP
	 P0TVrHGSmYGz0JPtoBxePYlFuL0cxuYsBdofeywQF9avmGnJ3WezA4jR9EWmJHjBEp
	 3V48o8Y9WPwJpm3jbPKnAxczj7sWWwhiwogd8kP81xxBHVvTmtcWsDmZVOhvQjYIGM
	 v7AYHKcU/fFvA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b885e8c6727so809831766b.1
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 09:22:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWaaYMmUwzdxyv/m3jPXmouIaSSE25tgYHenM6OajjhtBvqg2sgQq0ag8y7UtCpSvywTHHwHGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE6XDsemeXlYP+fQebRyIiFVQkohnzB5FU2GU3cmwzcFGldRUJ
	dehi+tDziydmIVQL8K3JBuptxzrPVdi5S69/Fi68eE3GzxECKdqysI98qk6SZ6bcKqXZlqfwzgn
	9MuH37lY0Q3QsAJlQnG57CfPJD0St994=
X-Received: by 2002:a17:907:9405:b0:b8f:c684:db28 with SMTP id
 a640c23a62f3a-b9080f5081emr529638766b.12.1771867326496; Mon, 23 Feb 2026
 09:22:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aYqOkvHs3L-AX-CG@google.com> <4g25s35ty23lx2je4aknn6dg4ohviqhkbvvel4wkc4chhgp6af@kbqz3lnezo3j>
 <aYuE8xQdE5pQrmUs@google.com> <ck57mmdt5phh64cadoqxylw5q2b72ffmabmlzmpphaf27lbtxw@4kscovf6ahve>
 <aYvIpwjsJ50Ns4ho@google.com> <mxn6y6og34ejncnsvdapcoep4ewcnwnheszhwkp2undkqcu5zv@bpmseexuug5z>
 <aYvPwH8JcRItaQRI@google.com> <smsla7jgdncodh57uh7dihumnteu5sgxyzby2jc6lcp3moayzf@ixqj4ivmlgb2>
 <aZj2V9-noq10b5CM@google.com> <ftjb625b4wsz5vdty3fcxqanuxriiqcewqkzp2ml2hc4eojuoc@ewhboiiqmcd4>
 <aZyHeKp2Dzzrjb5C@google.com>
In-Reply-To: <aZyHeKp2Dzzrjb5C@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 23 Feb 2026 09:21:55 -0800
X-Gmail-Original-Message-ID: <CAO9r8zMm185sTzhSZL4pfi5GAT2z33W-nPOaxDVq+AF-wePHUA@mail.gmail.com>
X-Gm-Features: AaiRm51k__3TarTHRw4JVSUnX05rOFmwAWLHi27G3uT1pXKuAO74W1BQd9t7tZI
Message-ID: <CAO9r8zMm185sTzhSZL4pfi5GAT2z33W-nPOaxDVq+AF-wePHUA@mail.gmail.com>
Subject: Re: [PATCH 1/4] KVM: nSVM: Sync next_rip to cached vmcb12 after VMRUN
 of L2
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217796-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51A9C17AB70
X-Rspamd-Action: no action

> > > > > Oh, good point.  In that case, I think it makes sense to add the flag asap, so
> > > > > that _if_ it turns out that KVM needs to consume a field that isn't currently
> > > > > saved/restored, we'll at least have a better story for KVM's that save/restore
> > > > > everything.
> > > >
> > > > Not sure I follow. Do you mean start serializing everything and setting
> > > > the flag ASAP (which IIUC would be after the rework we discussed),
> > >
> > > Yep.
> >
> > I don't think it matters that much when we start doing this. In all
> > cases:
> >
> > 1. KVM will need to be backward-compatible.
> >
> > 2. Any new features that depend on save+restore of those fields will be
> > a in a new KVM that does the 'full' save+restore (assuming we don't let
> > people add per-field flags).
> >
> > The only scenario that I can think of is if a feature can be enabled at
> > runtime, and we want to be able to enable it for a running VM after
> > migrating from an old KVM to a new KVM. Not sure how likely this is.
>
> The scenario I'm thinking of is where we belatedly realize we should have been
> saving+restoring a field for a feature that is already supported, e.g. gpat.  If
> KVM saves+restores everything, then we don't have to come up with a hacky solution
> for older KVM, because it already provides the desired behavior for the "save",
> only the "restore" for the older KVM is broken.
>
> Does that make sense?  It makes sense in my head, but I'm not sure I communicated
> the idea very well...

Kinda? What I am getting at is that we'll always have an old KVM that
doesn't save everything that we'll need to handle. I think the
scenario you have in mind is where we introduce a feature *after* we
start saving everything, and at a later point realize we didn't add
proper "restore" support, but the "save" support must have always been
there.

gPAT is not a good example because it's in the "save" area :P

But yeah, I see your point. It's not very straightforward now because
what we save comes from the cache, and we only cache what we need for
the current set of features. So this will need to be done on top of
the rework we've been discussing, where vmcb02 starts being the source
of truth instead of the cache, then we just (mostly) save vmcb02's
control area as-is.

