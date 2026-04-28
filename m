Return-Path: <stable+bounces-241675-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHc4MHnK8GkKYwEAu9opvQ
	(envelope-from <stable+bounces-241675-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:55:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DFF48766B
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FC3632165F6
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0839449ED7;
	Tue, 28 Apr 2026 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gp/bnYUl"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27AA43637F
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386159; cv=pass; b=tQtcGvwDevOMneUVcjPcmI5dXb/YIFkUOUobvk02oXVl4VaF23DA6+6YU3VgQzLZL+7vDqZzCQnA+QGZMWkPGv2qf237QP6UNa8XnnM0QMLvb9OMjfx6KbkGvGLledSDHf8SnTTRexONJjprO2kTb+PY0S8dwBpSw9POoQLe28k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386159; c=relaxed/simple;
	bh=Lhrvsxcq8dhyXHcIWCHjE9nElfckc1204ADXSFXxPGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m723PQfgImPtxSjC/GQSfv/Z1QjaiPJA9EIHOYJdt4bY2i6/idPiDXftfJndLq+CJNOZdXslWp7Ep/VX9H/D1om3YFlo11Af5jRvjigkZ3hNPz3udDpusnH4B3ITOuXEsTCgxxnFVxI/kM1v0bToAubeKiFXfs6BlJTe6HOAfQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gp/bnYUl; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50e61648f10so656451cf.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 07:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777386156; cv=none;
        d=google.com; s=arc-20240605;
        b=Kn4w3Ry5cIk5A0HZLcz8uWYhrJQX4E0jX1Zil3dY0msOxA2jswPRpsFRsG8WB2Iwhw
         3lY8nNyILmcHYwjCq34UFIDoGZWxqtyzludL3AJSr23TWNOEqaHL0kGHtr9ZtoCIoKkb
         wpjpQ82z/uAh7+pCYhnU/zFXB1p9r2188Qj4QqGDuZEuOBQR7yt8as6vVy6iHBuXDI6v
         PRXDFe6y3VaVHzieNuIDtUurSnYvtJhXDRC/ARFC0vFlJvowFe7LSh9kPbrhS+J0i77I
         gA+xgaOVs++/Slcpj1FFdRH4brtSTlJoxiBAOSAzDvteW8Pm+2sVPjZglg5VkmiD8g0A
         eThw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uXGQeShfh02U1wpxLV3lnM8sw0Cqx8U4IJOmflxKdf4=;
        fh=j6rH0rr3apUECmGlJYZw68GJ7vEKNxczBah/w5YOD0I=;
        b=QTqtzKqW823Ma754QfhQvLNlPpzm6tjo7iBqUS1zGKBUReBR4hmEzZpRne71xXSvKS
         N9VMhjJITgM8GlkuoF7/nIbu2jYTPzLhjB1I6YwS+HdLgB3rhX0rOtDom79oBkpRd1Mz
         8fCYiJ6XG7e3UZqzZcKfwAqMDncN7dj46SSBgfsqYMOWZNkjVXAuH914Zg6BJGr6yCcO
         yiVeFSSXUID6MNXjyewlLnThCUFR5t+uPNnOklHO8MxXl8qrnduviQHOjPMWpwnQDg8K
         X6ypVLdv9mBCmEOiB7AqEkMLJm/ttPJTe4jHAOp0V/25dLNIlNLkHElyrPguN/ZiwCIy
         sYDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777386156; x=1777990956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXGQeShfh02U1wpxLV3lnM8sw0Cqx8U4IJOmflxKdf4=;
        b=gp/bnYUl0F+XQO2HKNDvLAFkWBchmSbxDpL/BMxv8PxVD5ccSXfd1EM4dlprfsJzef
         4RwnT0zLLycy5FQGSmVLZL+TAC6ByT5JEfJAh8yPc2jwD0iSzBuEuBx+BHcNcuydeoke
         VES0wqauZcGwIWpodgJIhe/s0Xw+pw+TiKwACNaQlOEAzkYkUpzpWqLAhzQAuWLEKhgP
         8zcn1KM1E0iUGE9qXp/ggJLByiGOVz6q8YGxTO7WLJ25rHXY2soD1QPFgymkJjvJYYKh
         ZKga6kSpxNVu+wp/CDzebhkQCfbludfTArkaN4dpMaVsfR97LQp4vq5+dcMtbUnDtcxK
         Etbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386156; x=1777990956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uXGQeShfh02U1wpxLV3lnM8sw0Cqx8U4IJOmflxKdf4=;
        b=lDFffgNzSTp4yLeDGZTcBZXjnXMylZenF9eWaMOAA2w0+lMGjaidlj++OuPAYqwmhA
         QG9w/jTJLHzL40PQEv31AQazgb0CzijXS8fiyZ51q7EL9tg9aG+/W9Onn6W9V8R/JVgs
         Yz6s3ZiuPm7WoZWeePh1MQwcQLUHE31sxpVuGQuBAx9z7LZyUop8HbOmRnFARoxjkz/z
         a1QYWXvV+NKRSXX13U9iWSgbm6KSOIkbLp7j+QQLs0gtO49j/WRQLYQ5T49pCUplO9Q+
         yQMxdB1N/ovlv18hXRJuBuItKFjKPvzs+Llnpbos1ILh/sh0jlO6Pco7ctzD0T3AanIC
         uT+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+stMrcc/G/f4aFPY1l4rI7EBG+VWQubicsNJeKxGR8aQZbPX2VeN6zY4XZU7dQ+O/w+hkoRc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/MbkOdpmvvTkufBNbcbL2sSyDdItKGJmO/fob5kywRKgK9iCp
	hVsaVLZwn9U5UrvSjU1ur+LEVRWJwQX3BQFW6AxxXa/XDEGyynqlvqrteYGSBlxWDveaaZOiwMt
	ouog9t0Xi69OqD9XIP7H2RE08U7hdCINWfw/jxJsD
X-Gm-Gg: AeBDieuW7/u58es0NXWJCOzunvAWom3FwzfwjNKtu2FQdqUq0snb/TGSW4/OG0wmcfy
	5oNo7v1F4PYFQVd7V3AaRVYU0tsmKsyPlCn/eZ3e4/hOnmGl3GW45UG018WT6a3y6VYUp0f9Bbz
	S1vTL6u1rLmLpWNO4nB2P2pVsdchvBdcBU2+WeZBaEjcfDGelbpk+rwO0dw0MG1jMPu52fVvA4u
	U5gF++jI+Yp6FE0HsEITI0WtW5i/ybAwJ+ZbwGvsA4LGuMM06WtwGhAsdIj24A7XTKZx3PLwPZY
	2vKlvxoFSstdH+LZU8qxjnO0gE+9YWN9A4oUzCAl5K9++hNHxdOpHuZKhzOlKks=
X-Received: by 2002:a05:622a:14a:b0:50f:be7b:923a with SMTP id
 d75a77b69052e-5100dd824admr13692471cf.9.1777386155175; Tue, 28 Apr 2026
 07:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428103008.696141-1-tabba@google.com> <20260428103008.696141-3-tabba@google.com>
 <afC7H1fu4vFzTRTt@willie-the-truck>
In-Reply-To: <afC7H1fu4vFzTRTt@willie-the-truck>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 28 Apr 2026 15:21:58 +0100
X-Gm-Features: AVHnY4IcRutI69cs69i--7xOx374S2gpBibzxSLDc-9Cnq9PVlW1EEta-ioTBlc
Message-ID: <CA+EHjTy=xvvBN0UyK2bO6J-GuUZnHRwjjdrhkK8Vr+iridWCfg@mail.gmail.com>
Subject: Re: [PATCH 2/8] KVM: arm64: Synchronise HCR_EL2 writes on the guest
 exit path
To: Will Deacon <will@kernel.org>
Cc: maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, qperret@google.com, 
	vdonnefort@google.com, catalin.marinas@arm.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 37DFF48766B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241675-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi Will,

On Tue, 28 Apr 2026 at 14:50, Will Deacon <will@kernel.org> wrote:
>
> On Tue, Apr 28, 2026 at 11:30:02AM +0100, Fuad Tabba wrote:
> > MSR HCR_EL2 is not self-synchronising. Per ARM DDI 0487 M.b K1.2.4
> > (p.K1-16823) and B2.6.1 (p.B2-297), a Context Synchronisation Event
> > is required between an HCR_EL2 write and any subsequent direct
> > register access at the same EL that depends on the new value being
> > in effect.
> >
> > On the entry path, the HCR_EL2 write in __activate_traps is followed
> > by further EL2 sysreg work (MDCR_EL2, CPTR_EL2, VBAR_EL2, and on the
> > speculative-AT errata path SCTLR_EL1/TCR_EL1) before ERET into the
> > guest. None of those intervening accesses depend on the new HCR_EL2
> > value, and ERET is a CSE per ARM DDI 0487 M.b D1.4.4.1 rule RBWCFK
> > (p. D1-7209) conditional on SCTLR_EL2.EOS=3D1, which is set
> > unconditionally by INIT_SCTLR_EL2_MMU_ON (see the prerequisite patch
> > in this series). The requirement is therefore satisfied implicitly
> > on the activate path.
> >
> > The deactivate path is different: after write_sysreg_hcr() in
> > __deactivate_traps() further EL2 sysreg work runs before any natural
> > CSE - on nVHE, __deactivate_cptr_traps and the VBAR_EL2 write; on
> > VHE, the timer context save which reads CNTP_CVAL_EL0 under the new
> > TGE/E2H, and the EL1 sysreg restore. Add an explicit isb() at each
> > of the two deactivate sites.
> >
> > The practical impact today is bounded: HCR_EL2.E2H does not toggle
> > in either path, and the trap bits being changed primarily affect
> > EL1&0 behaviour. But the architectural rule should be honoured.
> > Note that write_sysreg_hcr() itself already issues isb() on the
> > Ampere errata path (sysreg.h), confirming the architectural
> > expectation; the fast path optimises that away.
> >
> > The fix is at the call sites rather than inside write_sysreg_hcr()
> > because the macro has many users (e.g. the activate path, at.c,
> > hardirq.h, ptrauth alternatives) where the immediately-following
> > code either reaches ERET or has another CSE; making the macro emit
> > an unconditional ISB would impose unnecessary cost on those
> > well-formed users.
> >
> > Fixes: 9404673293b0 ("KVM: arm64: timers: Correctly handle TGE flip wit=
h CNTPOFF_EL2")
> > Signed-off-by: Fuad Tabba <tabba@google.com>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/switch.c | 11 +++++++++++
> >  arch/arm64/kvm/hyp/vhe/switch.c  | 11 +++++++++++
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe=
/switch.c
> > index 8d1df3d33595..9d7ead5a5503 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> > @@ -105,6 +105,17 @@ static void __deactivate_traps(struct kvm_vcpu *vc=
pu)
> >       __deactivate_traps_common(vcpu);
> >
> >       write_sysreg_hcr(this_cpu_ptr(&kvm_init_params)->hcr_el2);
> > +     /*
> > +      * MSR HCR_EL2 is not self-synchronising. Per ARM ARM K1.2.4 p.K1=
-16823
> > +      * and B2.6.1 p.B2-297, a Context Synchronisation Event is requir=
ed
> > +      * between an HCR_EL2 write and any subsequent direct register ac=
cess at
> > +      * the same EL that depends on the new value being in effect.
> > +      * The activate_traps path falls through to ERET (a CSE), but the
> > +      * deactivate path still executes further EL2 sysreg work (CPTR/V=
BAR
> > +      * writes below) before any natural CSE, so make the synchronisat=
ion
> > +      * explicit.
> > +      */
> > +     isb();
>
> Sorry, but I don't understand this. Please can you explain why you think
> that CPTR and VBAR have an ordering dependency on HCR_EL2? Preferably,
> the comment would talk about the specific fields that are relevant.

You're right, I misread the spec in my excitement to fix an issue
raised by my new and improved prompts. I went back to the access
pseudocode for the registers being written after write_sysreg_hcr():

- CPTR_EL2/VBAR_EL2 (nVHE) are direct EL2-only registers; their write
semantics at EL2 don't consult HCR_EL2.
- CPACR_EL1/VBAR_EL1/CNTP_CVAL_EL0 (VHE) redirect to their EL2
counterparts on ELIsInHost(EL2) =E2=80=94 i.e., HCR_EL2.E2H =E2=80=94 and E=
2H doesn't
toggle here. TGE isn't a condition for these EL2-level accesses.

So the whole "depends on the new value being in effect" doesn't
actually bite for any of the accesses I cited. I'll drop this patch.
The natural CSEs cover whatever real synchronisation is needed.

Cheers,
/fuad

>
> Will

