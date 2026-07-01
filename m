Return-Path: <stable+bounces-270094-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QRsgFt+SRGq6xAoAu9opvQ
	(envelope-from <stable+bounces-270094-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 06:09:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2B76E9A26
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 06:09:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ionos.com header.s=google header.b=Qs+ne3U7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270094-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-270094-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=ionos.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57AB03028606
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 04:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2882438F925;
	Wed,  1 Jul 2026 04:09:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C813138F620
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 04:08:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782878939; cv=pass; b=e8ZBnJLk/n6qZEHLg1vj6iD6ZBccZSM3y6g5bem3rRM0hYFqImTgwl3+8Fqoq9v/0f46MIQYg6GxmAVU0xEjL/0MKgPxoyChPpm/C6Fl7hshLQLtsBr9r48sjfC50Ns8xxwSNUWJoj+mqyQwVNtdB+zQnDyFO0LnWHyVGGhij1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782878939; c=relaxed/simple;
	bh=D+kbCD/ppYE47hx4avQKVjTJJVYTT9+t+s+Wi1vJscM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYxt9PfKDrzaZVDFiJi7buPBLPh8dfjQwW7F2iA/KtbLEVZLCZp+Jv0xl8yMHdwUHocqX3zKxr9Lg3C/y0P4yaeCGRx2PLZxCgP7vABHC84ZFTR7o4pwhYR3/DMxjEgVBnCKVNeqLASZd3WYsqAc34R9Z3eTFXi2UeME4WTQyts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Qs+ne3U7; arc=pass smtp.client-ip=209.85.208.43
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6984f4c25f8so26322a12.2
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 21:08:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782878929; cv=none;
        d=google.com; s=arc-20260327;
        b=AoD4NWKaZbzBw5Sj7mmV/Nm5VQhd9oHN2P79ie3ZqAmtq49JAgDRVvDbzMxeyQ0DEj
         3z+76qyxmcD3Qyn5mYP9Hx8anIfgiOZjxtDjDeg3DEe1sjVAYYowLdMFnIqkpwzeMWco
         XA068t+CJNrYuheNKdNu0gcdwPt6sGKJxwcPQVeIzoJI69+47vjtPkGIFO9Ftz/sM8BX
         psesiNjnSnHiXyQUyzZLToTmEDy5Yhea40tzZ4n++OFGETNjECpNE4DYGdZRy7SXZrhM
         BbMY1F/FkhyZZ+p3ChXZrs0KZ2c2Mj/DBghUqPfGJuMp/QMcHlxCG3twRDQqxVAHRd6F
         Q1ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6vchq38cxL71WHw3tQQOxmw2ltB/ceG06+rbRCiiw1M=;
        fh=N3gVuIw6HGvaEnLTRA+NOZ4W66ynM4MlOveIUh7EcQY=;
        b=fJeHh6puNoJAI9ntxOaTyyizSLhxKc/Y7vL5b15nto7JQwh8t6g5Cgse1fiN+sPjD5
         mc7w0PEAt2WWtbbCntRwlFAuj7tbPCZJGlpEIzNiEwMd70poeGo+H/4V+d3X+PMxrAWl
         RYaWO3GIE3TxSTW6DWuXoHFBASz+hvWYKGUlK27JkUi61ctS+umfgatS8h+BTLcWQmrJ
         4QE85swP0Tjmf7rWaA+QWp2U3EdO20HbPULxuL5bud6NsooF60lKJveuEfsOFwrCXkE5
         6iUkznQ24zLbJWRs5l7OTEXZQvs4sFAi3/wr8+4VhzBxhYkdiPgNbGLdvPuOEuTcIxep
         DFOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1782878929; x=1783483729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6vchq38cxL71WHw3tQQOxmw2ltB/ceG06+rbRCiiw1M=;
        b=Qs+ne3U7MkshHPC4bHvcJdaidkvugkhiva8YJkTacSQZsCc1I8XpThUOo1yGfpTp4Z
         7swhFqTmD5H0Upc9nzWeRBIjKz2IatROzoL2z+Ypc9Yt4ezUC8Yhf6NyTTkZqmGJr1qW
         G7CNOBa8MAywSsEtp8d54QtEK8HRUVJ4shm1TQ24iTa3j2cspN4n3Lw2Q195wkbftfI8
         La0QyjLpQgNAM975dsXw7xw/oqjjOFZzXiioMrhhbiTjvikhGHNlpu5oTVDQ7NrUwvax
         7jlhN4zVIK+UbOaU+ppgan/H20Z6g309Ep/225n31Ms87MJUlOhN66fac35K+tuFB2rh
         07cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782878929; x=1783483729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6vchq38cxL71WHw3tQQOxmw2ltB/ceG06+rbRCiiw1M=;
        b=L6LbkQuaojM8EtbHhSMTnP33UpwHn2DQWzKSIlsUwMcX79/CvrK1E52yKN2eJ574ei
         zyuFAiw1lZ8/eYOLK5mvPrsOWZMnfWrXj8+Rsdl4TQXUF5hznaqpdzaodkZKlHqX2Ewd
         3xcQwj888hOL50kXCvMDZaiNY8hzLlaIxx1QP/H66AlAjN30JbAgDBBMWfAJ0pgHgabo
         iVtXXTloHSC9r8UmB4Tac8cpXK15esRTD0mYVLjVIALMui4s0miNzXcCo2cVT63XXOiT
         q26KrBFr+Fx0hXGQAYw1gfbVgvnAWot9353ISA3ek+6EuLfh9pSYEmuWZKMQlB6ZIcIN
         wPmA==
X-Forwarded-Encrypted: i=1; AHgh+RrefbETWZ/3ntcHwYC08ZgYPRKwHqeY57UB0C+aqWTWwRffw6RGBaB1gkwlSWV8Ob56uWBEGts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsMHQD84ehuy0rEcWoBWjl+bcuP4KXFkIz6mUY/KYu5QLDK18P
	hDfCuU6Fm0y6BqbBDg0ceFxXNVNN6LJSMOAcbBIk4/FEm16dPiN6NVLHvOaHugHgqI5nA9XciCd
	uMyen/ES3+Is/0qoW7VF1B+N4qQ6F9hkUr42hh+sMZw==
X-Gm-Gg: AfdE7clUkjUI/ad9FHMFL83Dh6eUoLxDce9OHff3xJCikr922tPDaQVSsZn7i0+mrfq
	IIn7UY4idqbN7i0O9x/gKJPgG1ailaDMq/3nfpenIFH62OrnQzlzuc8WWqRUtQ+CyfJyNzoZdfL
	u09ZY+fWsaJNBt0vIoW3Bf4frs6B3Oq0e4Dwq72mUvvYgZt48h+YohlMDcg7T/05eOIM5VYVqu8
	T1mNJWocHQJkxKb6/7+C4mhv8nOJdZCQJGL6f8uar3kQywT4zFEecAHDeQSjI/dg8IJZLILften
	cSLOSFLBAnrd7N1ieuvtU6ObhJNvztuV0oQ3JfIq
X-Received: by 2002:a17:907:86ab:b0:c12:6ad8:821f with SMTP id
 a640c23a62f3a-c1287494f7emr160110666b.7.1782878928903; Tue, 30 Jun 2026
 21:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630114701.319917-1-jinpu.wang@ionos.com> <akPc2raibHy-QnPH@google.com>
In-Reply-To: <akPc2raibHy-QnPH@google.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 1 Jul 2026 06:08:37 +0200
X-Gm-Features: AVVi8CcwfTnPArhNbb4YNNCEyMd_9X9QQuMy-fDKlFrASSln7aEbe4qOJ5TyhMU
Message-ID: <CAMGffE=1-NnVQBgMnyiEhXD20TZ7z_-u0B4hpnC9qv6FOV6EcA@mail.gmail.com>
Subject: Re: [stable-6.12] KVM: SEV: Unmap and unpin the GHCB as needed on
 vCPU free
To: Sean Christopherson <seanjc@google.com>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[ionos.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270094-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:michael.roth@amd.com,m:thomas.lendacky@amd.com,m:pbonzini@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jinpu.wang@ionos.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ionos.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jinpu.wang@ionos.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:email,ionos.com:dkim,ionos.com:email,ionos.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF2B76E9A26

On Tue, Jun 30, 2026 at 5:12=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Tue, Jun 30, 2026, Jack Wang wrote:
> > From: Sean Christopherson <seanjc@google.com>
> >
> > commit a847a44f67eaf99faad905da38c080f0ba7ee02a upstream.
>
> Wrong hash, the upstream commit is db38bcb3311053954f62b865cd2d86e164b043=
51.
>
> > Unmap and unpin the GHCB as needed when freeing a vCPU.  If the VM is
> > destroyed after mapping+pinning the GHCB on #VMGEXIT, without re-runnin=
g
> > the vCPU, KVM will effectively leak the GHCB and any mappings created f=
or
> > the GHCB.
> >
> > Fixes: 291bd20d5d88 ("KVM: SVM: Add initial support for a VMGEXIT VMEXI=
T")
> > Cc: stable@vger.kernel.org
> > Tested-by: Michael Roth <michael.roth@amd.com>
> > Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> > Reviewed-by: Michael Roth <michael.roth@amd.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > Message-ID: <20260501202250.2115252-18-seanjc@google.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > Message-ID: <20260529183549.1104619-18-pbonzini@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Please document what you adjusted.  That matters very much, because I wou=
ld much
> rather backport 08385c5e1814 ("KVM: SEV: Move sev_free_vcpu() down below
> sev_es_unmap_ghcb()") than shuffle things around on the fly.  That was th=
e entire
> point of tagging 08385c5e1814 for stable.
>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
>
> NAK, I'll send backports of the two patches (I ended up doing them anyway=
s to
> figure out what was changing in this backport).
Understood, thanks for handling it.

Thx!

