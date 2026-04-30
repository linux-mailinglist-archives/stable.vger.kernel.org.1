Return-Path: <stable+bounces-242099-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMW3ENpI82kMzAEAu9opvQ
	(envelope-from <stable+bounces-242099-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:19:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF3E4A2AF7
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAB67300E3D4
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 12:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039901C84A2;
	Thu, 30 Apr 2026 12:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rrsFK7Tq"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605343B19D5
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777551568; cv=pass; b=MG0GTotlZQIUzb5hCImzjABT+OFfQ2nYTV4axd6+hK4sr/46eT3Sig5J5O0mZYJ8PSjJ6eTm4LlJYk1pT4lrvqaMultqpFJ/JuabPR6C9clL4bK4fsVtkmwqJnNoL0jPoFWyn+k34S16uscKHumLEBCDBtOPrK/XufDcVwdP9Fk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777551568; c=relaxed/simple;
	bh=44cjooSElohMQFoXrm+AMIOG2x7f7KQkgD2E8+cShXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Imfl8oR01rQGGFjZC7ueAXz4/0xlb/lzpy8FPOu7lx+EG75LauaJjREtIUSji8Nu7kwrrmEtBIrUxKocupfpanN+QJWIzci+uIkXMn/EjYrrGnjVzNaE5UjZELklDM0HE279ny2CLj49skjQZDYjjmsOQ5i7Ke/GvfPJSGOcU6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rrsFK7Tq; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d864c23bdso642421cf.1
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 05:19:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777551566; cv=none;
        d=google.com; s=arc-20240605;
        b=iG80uajaPUa1n4lMgtZV9RzCV8lpqwtcom5cjjMuqCnFVj4CC+nR2EwjqzF2GoqQzE
         OXsU2CrJDOBSFe3POJch+fdcJMXSz19w7QkzrGYRKZ2076JJWynOUgkUiMJXm1VDKDm+
         /AlTaG4L/MzeVzzqb64P3nJpNtUWjWJrtjuqk8VTgNU7ZQ5GVWve5aNtWlFKc7nh6OAn
         dos0+8hWSJ7H/kI9EJ7axG9+3eDl8UW8Z79rvL6JmcEEZr8ry2Q0YiKcLQrOVF4OFBG4
         L4zzBYB8NXFoz0BrYP79UUrKxDaKCaNam0E8wVho8dwCZVb7OB/Jm1louov1Jfl3zcRc
         DV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wHRKEeAne5F8MKTBpMczt1Dq5nvrp7CkygWD8nWgp48=;
        fh=HGeJ7MVLWDA4QJREwj4G29ybiUDFAI0KA5yrzuxekN0=;
        b=QVimfp+BkLQMpc26iBBya+G+V4RZU/gF58ZfugWHWfNmGioReIV4ScR8ztP8MZdtX9
         QOJJzpmooLP9dPmhPd41JGWA1ztXqaKZ6yRzKBbPkO394VSjtaIQdr0pTNduGsVyOFNL
         JoDemTPVzZImw4EwYxdsKNORiZiaQKcmkKa3VVefnkUzs+pFyf74OasW5Z8MpySUnsjl
         QL9ctcnmJ+u/P2wcUWJUWlpSKjm6bV52ychxnZ6EhX1eif17zrJ2IjuY9YaSvS/0TQrb
         rwS04lwPOD388hdbCFtfKsdZgvNyKElwwhXB3k6M4FS68x2Kq2flKy7HvFRP/xaj0Aub
         XL8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777551566; x=1778156366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHRKEeAne5F8MKTBpMczt1Dq5nvrp7CkygWD8nWgp48=;
        b=rrsFK7TqHn5FCWaPmJee1+tFfgMfm1xo3XDQXAPqHjNFJXAdq2qdhKavu1F8wuNTD9
         xpHgGf9g4jWkqeT+Yh4+Xoo/5YnqvSvtfWS3dPawzZsbg207PzS8/AwMykqfjgU9FlG6
         kTA9pcK0W8zU7bO4/fkWPfDZtGDAJq3YtAzpp/Z51x5tR3pKbftjuZRCioYSGTXlmkIK
         lvrUxIgMUefXGLjNdDlUMiwbVWhUM3Sur6C16R8CsP3PlfGzqe95uLP08HBVJ073EKCr
         cnBzoprugEpMD0Kam7wwmXdxuzS/I4q5H5Xv6UBqcFZT68MC37oqcYifrLnxtehwe4oF
         zbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777551566; x=1778156366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wHRKEeAne5F8MKTBpMczt1Dq5nvrp7CkygWD8nWgp48=;
        b=pf8pVAViIgJVAaJKSmpgQn3jqNCe+2R6Dua1Que3bp2nfpS8vpCTtVp4k3LtOX8bB8
         hSYKuzPVP6gXFptKaWIBXwPrgK+UKgncICzBXfn1JpnHA+xfOTplCwLresp4YPExEcE9
         P6q3/Foc1cZN0kSzaW+siy8JY0tCbeKqhImGUDUy5t/ULvRd8A+jVXLxtFIl3wyA3zn9
         tWwrcwajE77JPeFFI6p0yJgPy2i8HrUvXq8YSz+QGnZmVWerjveDoGDet+opmi9dKIom
         /syxBqXRgXHmBsrJW9fhSp2pPQjatsvFUHtUoZrcMffYjDZHG08LZA06YMHYWe0/IL1J
         kHEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+OrWLFSy2tPitU2GpqTIKdJ4+IgSRRI8NnZ2rFl6os2ETrN18NwWQqylfzkRGtHcid1I87pRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAHPlC3mOSM/yL7x0Wi1NY+aB9zoIFLS4pLE5Ey+DymJY/bg2M
	SPmcb/MzXYs/Lkj3HyIPu708pcPtctTXSaY/hTzx3S6z12JxOMfxmtxCjueKrbTNVgiZUPca/15
	sgAvCdf4eMMnwZ6nTNB882CBWeqRtvz+pr5TKenJq
X-Gm-Gg: AeBDietvE5xeCLjzNjyTgeTAIimbP+ewUoPJ0YdVmnEU1p4vLvHE5x8z9roGrfnir95
	NK2PaSlr0xejx1sRCfS4UHrfWqB4YVWVlZZ02RISnktXO+3O6HUbla+8JJe5Zx1kNSECo9gcNPx
	YQ4Uc2Jz1CGdQv+2+37xYyV3e6lU4W9p8ELdxQwKKJfNaOfRmGNKOukOmhCG0Cd7JCYrEV4x6yb
	qw2LtY9CBRgcb2LOP8E9KBbu5VMGYPLLT64OEUsVNy1oLK44zDPnZR5U6WfwegkNg1f7JlvfnfR
	bD5A19FgVf4+gPD/p/35EaHYicPWxyDkf5rklBQp6B38PrpQ3WqtJbcwZ9I=
X-Received: by 2002:a05:622a:a6da:b0:4f3:5475:6b10 with SMTP id
 d75a77b69052e-5102830838amr13557601cf.8.1777551565713; Thu, 30 Apr 2026
 05:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428103008.696141-1-tabba@google.com> <20260428103008.696141-2-tabba@google.com>
 <afMb7uuPlUbLeu7k@willie-the-truck>
In-Reply-To: <afMb7uuPlUbLeu7k@willie-the-truck>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 30 Apr 2026 13:18:48 +0100
X-Gm-Features: AVHnY4KrIAjURaGJR0bOqEe6FW-ppWuYCbxV1LsE0PqXIXBObjOjW2F6E4sgXIQ
Message-ID: <CA+EHjTw6rx5rCVnR7Dfva3xmmgGjqUeUaT=3zDCEsN0J909Wsg@mail.gmail.com>
Subject: Re: [PATCH 1/8] KVM: arm64: Make EL2 exception entry and exit
 context-synchronization events
To: Will Deacon <will@kernel.org>
Cc: maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, qperret@google.com, 
	vdonnefort@google.com, catalin.marinas@arm.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: ABF3E4A2AF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242099-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi Will,


On Thu, 30 Apr 2026 at 10:08, Will Deacon <will@kernel.org> wrote:
>
> On Tue, Apr 28, 2026 at 11:30:01AM +0100, Fuad Tabba wrote:
> > SCTLR_EL2.EIS and SCTLR_EL2.EOS control whether exception entry and
> > exit at EL2 are Context Synchronisation Events (CSEs). Per ARM DDI
> > 0487 M.b, EIS is governed by D1.4.2 rule RBBSRF (p. D1-7205) and EOS
> > by D1.4.4.1 rule RBWCFK (p. D1-7209). D24.2.175 (p. D24-9754):
> >
> >   - !FEAT_ExS: the bit is RES1, so the entry/exit is unconditionally
> >     a CSE.
> >   - FEAT_ExS: the reset value is architecturally UNKNOWN; software
> >     must set the bit to make the entry/exit a CSE.
> >
> > INIT_SCTLR_EL2_MMU_ON in arch/arm64/include/asm/sysreg.h sets neither
> > bit. KVM/arm64 hot paths rely on ERET from EL2 being a CSE, and on
> > synchronous EL1->EL2 entry being a CSE, to elide explicit ISBs after
> > MSRs to context-switching system registers (HCR_EL2, HFGxTR_EL2,
> > HCRX_EL2, ZCR_EL2, CPACR_EL1, CPTR_EL2, SCTLR_EL1, ptrauth keys,
> > etc.); examples include the activate-traps path,
> > ptrauth_switch_to_guest, and the FPSIMD trap re-enable in
> > kvm_hyp_handle_fpsimd. On FEAT_ExS hardware those reliances are not
> > architecturally backed unless EOS=3D1 (and, for entry, EIS=3D1), and
> > whether they hold today depends on firmware initialisation outside
> > the kernel's control.
> >
> > Make the guarantee explicit: include SCTLR_ELx_EIS | SCTLR_ELx_EOS in
> > INIT_SCTLR_EL2_MMU_ON so that EL2 exception entry and exit are
> > unconditionally CSEs regardless of whether FEAT_ExS is implemented.
> > This matches the pairing in arch/arm64/kvm/config.c which treats EIS
> > and EOS together as RES1 under !FEAT_ExS.
> >
> > INIT_SCTLR_EL2_MMU_OFF is left unchanged: that path is used during
> > very early EL2 init and the EL2 MMU-off transition, neither of which
> > relies on these bits in the same way.
> >
> > Fixes: fe2c8d19189e ("KVM: arm64: Turn SCTLR_ELx_FLAGS into INIT_SCTLR_=
EL2_MMU_ON")
>
> I don't think this Fixes: tag is accurate:
>
> 1. That commit doesn't do anything with EIS/EOS afaict.
> 2. Back in 5.12 (when that thing landed), SCTLR_EL2_RES1 did actually
>    include EIS and EOS
>
> so I think the issue here might be that the auto-generated sysreg file
> quietly changes the RES1 definitions as bits get allocated, but the
> macros using the RES1 definition don't get updated. That's a pretty
> horrible pit that it feels like we might keep falling into :/
>
> Looking at 0a35bd285f43 ("arm64: Convert SCTLR_EL2 to sysreg
> infrastructure"), I think we ended up dropping a whole bunch of fields
> from the RES1 mask (which became 0!). Have you checked all of those?

You're right, fe2c8d19189e didn't touch EIS/EOS: the SCTLR_EL2_RES1
mask it pulled into INIT_SCTLR_EL2_MMU_ON already contained
BIT(11)/BIT(22). Looking at it, I _think_ it's this one:

  0a35bd285f43 ("arm64: Convert SCTLR_EL2 to sysreg infrastructure")

After that commit SCTLR_EL2_RES1 is auto-generated. Because the
sysreg tooling can only model unconditional RES1, and EIS/EOS are
RES1 only when !FEAT_ExS, the generated mask is UL(0). I'll fix the
Fixes: tag in v2.

On the wider question of the other bits dropped from the old mask,
I went through them against DDI 0487 M.b =C2=A7D24.2.175. The summary
(SCTLR_EL2 with E2H=3D0):

  bit  field    E2H=3D0 status                  kernel cares?
  -------------------------------------------------------------
   4   SA0      RES1 unconditionally          no
   5   CP15BEN  RES1 unconditionally          no
  11   EOS      RES1 iff !FEAT_ExS, else RW   yes (this fix)
  16   nTWI     RES1 unconditionally          no
  18   nTWE     RES1 unconditionally          no
  22   EIS      RES1 iff !FEAT_ExS, else RW   yes (this fix)
  23   SPAN     RES1 unconditionally          no
  28   nTLSMD   RES1 unconditionally          no
  29   LSMAOE   RES1 unconditionally          no

The seven non-EIS/EOS bits all fall under the "Otherwise: Reserved,
RES1" clause for the E2H=3D0 layout, with no feature guard. Writing 0
to them is a no-op, so dropping them from the mask should be harmless
I think. EIS and EOS are the only positions where the bit
becomes RW (with UNKNOWN reset) on FEAT_ExS hardware and the
kernel actively relies on the value being 1, which is what this
patch addresses.

I agree the auto-generator silently zeroing previously hand-rolled
RES1 masks is a real problem. Happy to look at either teaching the
sysreg infrastructure to express conditional RES1 (so config.c's
AS_RES1/FEAT_X facts can flow back into the header masks), or at
least adding a build-time check that flags any auto-generated
<REG>_RES1 that shrinks. After this series, though. Let me know if
you'd like me to take a stab.

What plan to changechange in v2:

1. Fixes: 0a35bd285f43 ("arm64: Convert SCTLR_EL2 to sysreg infrastructure"=
).
2. Add one paragraph in the commit message explaining that the bug
landed when SCTLR_EL2_RES1 was auto-generated to UL(0), with a
one-line justification that the other seven dropped bits are
unconditionally RES1 at E2H=3D0 and so harmless.
3. Code diff unchanged (still just adding SCTLR_ELx_EIS |
SCTLR_ELx_EOS to INIT_SCTLR_EL2_MMU_ON).

What do you think?

Cheers,
/fuad

> Will

