Return-Path: <stable+bounces-242450-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGLpIH3A9GkDEQIAu9opvQ
	(envelope-from <stable+bounces-242450-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 17:02:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF87D4AD79D
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 17:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 284EE300B447
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 15:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F123CF047;
	Fri,  1 May 2026 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2QBSiVK"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC093CEBB9
	for <stable@vger.kernel.org>; Fri,  1 May 2026 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647725; cv=pass; b=FUhroiVxvTPfTolnY9t9hknot2rI69YIcnfxM8tJ51OVzPVqbdd5UKeSB2mKENZJBy9Pd7eLqK1L8xUZsGM4J/J4qwZS5Jp1Qx6cibgySwkThltqWTcRLUZTRomjj5vAJPbMYx492jJj45v9Bl7R/X5TK5YwsOiwAdbgaC/l3us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647725; c=relaxed/simple;
	bh=yiYhJUMfNo18oK0obMw1l0Xm1WbS0b2LK8MKLVxr1fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZjZ0mhRegynCoF3EJaKo1y/Vwe1KFIbWfBmTFGcDk03Zlrj276Vy0ZVe3FcLtmtS4xL0lXB/ROF5mojsRCrZBX+GOYFzrUhZJUnQWtpt9gc9l/ZWAsm5RswckrrnpFaozl1Yd2Wazj4RSVk9FfpS7+U3g+LIqAEsOmrvw6wLA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2QBSiVK; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50d836552daso559561cf.0
        for <stable@vger.kernel.org>; Fri, 01 May 2026 08:02:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777647720; cv=none;
        d=google.com; s=arc-20240605;
        b=Po3/JlwxIOabkjtsAezz1C6sVwe0OmQiT1bXza7/N1FWGFDC/N3yv3pVWERUip8YyX
         D6mebgI9OE5ZiHxKY67aCA/ONd05B3Um9rGsKsTzT8o9o0aitSRco+wqtvSParWuVPR/
         MB3SlFNdAK71N0hazzzRRiudNBow0wC0MOgQL+WZTvEb3ZeVf2LxFUT6DNQLtzI7z10N
         hcKUcP9AQVZ1kT9RCsJcf+Cv1LLSc8bZwyCE3n4BcqQjPHI2VA9TLJc/y4lPXMo64C47
         MORJryZxDQmSI00v4QAZGjbPqCQx8q1SiR1WZsMS/Tb9lw8LP7xUsEvgyIqNKETtFMrH
         +PnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zc/yqiuFI8zLs6WNwYRHDaX4KurA8TMA/7iu8L3wyVY=;
        fh=ysPbFwuHB3Y3wWZqSvbczLZ6R9UJw6J2FNKQYtvuR80=;
        b=O3IwACDKsPC7eZ3ygn+Wy2IoH/oYye1XlgTh33AruhGKKanO45tSROBMDv9UM7vrPs
         0f1Ss2eDrlZhtzJQeRfq/v3POh5e1aaykUc+4smDFy9bGobhoI+CFqf9nsfbki4dthxn
         Lv8aT/G6pU8I315Ua6xX0PWzuAApKemTNLdFNFkA6usqRb5Dj75WGpAykH1Nxi3TSJOF
         /r864dBK1IMCyGBv+YcGFacDmYfAliykkdKpo3xgFoO/3vaakLrblnx9yoi6JFNn24CC
         eSV8K781CRS1SSyrgd47pV2pFXkXWZaISlPiumgW/rIx2iCtBBSYyKSDPBFf+2uydp2r
         VYNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777647720; x=1778252520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zc/yqiuFI8zLs6WNwYRHDaX4KurA8TMA/7iu8L3wyVY=;
        b=l2QBSiVKWuLHdCyMZ+9nZq0ENMiZi7aXAQYkl6DJsjxG3Q5H1r2Xn9FArjQI5s+Ndt
         HmdB8M1xexfGJlQzr7dZ/VXVrb6TceZXYAni2DOMi88ik86tjR8fksS1RFDS8jwogN8P
         KJF4xmqOWRhxULgpadBo8vpdW0yF2DIbkOZygr9hU/paGcApup0PIcT0m7Paacilxw5n
         kCoSG0XmOWfa9APWJWh+l/jCG9YBHHH/gNC8zKcGFswgMe4SGDvxFFa1XVmQzecmFzU7
         s5+60erqYSB0fATfC3gTUI3IxPeRkNG2hr2FbjTJy8rLV4ixFlViRX/JdMlybkE/4QiP
         utSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777647720; x=1778252520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zc/yqiuFI8zLs6WNwYRHDaX4KurA8TMA/7iu8L3wyVY=;
        b=cjg4Pg/uqPS4qCuUnMdiGCOqABNhirg7YlJubehXt7hSBniOnnuGxugBGw6qd0ULqn
         yDcB1Nouf/Ck1UFr1ProxI6qyaCVLDEaFx13CeqAu154ta/7thlGMTVOFo5bMpy0sUVM
         9TM8VZBdn/e/+3RHUCSU03G0zkm1q5lGswWykCoPmbZPZJ0cxd5ismowVywt6qcKop7M
         fLyV9LRZMGvF3/bDAfHVJlIPHPTM7on4hZoIVRehz/lV0SJU5UnaneFb81TZVbUiJFuE
         fviz7XjOh7PoFB2c29ZNseao/okLkmjZw4Dh5Vs7i8R4yJmu//zvomtzrVUi/O37AGBb
         gQYw==
X-Forwarded-Encrypted: i=1; AFNElJ9YYJKT1f34DbuwojIl2Wmr4lu13pQl+YIinrflvWUCylXRH0UoGvd7XpVytStpcbKckWoilho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzICOK8O0ENNcfk6j29PYZyDkuoJFYUvG+B5zRcmcf6cM4d+g8o
	0sqZbiDKpQgA9MXN2ucpS4uiPQmhLcUAsvo7ztoEssrK3H9brS8dTeieGaKOACrtJFM/e0/mwst
	y+JJSeyUZavf1NtTH54XxLZ7E/9ITVtOh4RPLm1Ix
X-Gm-Gg: AeBDietlqJjY1Y+UepbIkYzbrwvlJutUbT6L2BZDxZiokLBBzyeGNLD6knFmg+Wxlak
	D/TQgmSBxdODygpw6+GijtzVWsKJawn2pL2TPTL6Tf2RmNqIe/U0BUY21nbNrg/WTflAtOhhta1
	sCYrikqNlCwgUiTB0rXiAH5Vvkgyn3wanRre+u2Ri+XGDG6lneGte/uATTfh9uZfr/qet8PTo2d
	VNicwad1oZ0e4zH2v9Lo8k+NuImk1LwNHR3KHesYOWcmIgW/BTEHweWMcGIbaMK2Ey4kokN/Knj
	YX+7U3KIvYU4Z/sP97JTDNo36nrIEBMckfnRiLJPTKCkUpwZ+6tQ3UWmjPq43w==
X-Received: by 2002:a05:622a:5e17:b0:510:fa1:73c5 with SMTP id
 d75a77b69052e-5103da47567mr15438331cf.16.1777647719224; Fri, 01 May 2026
 08:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501112149.2824881-1-tabba@google.com> <20260501112149.2824881-2-tabba@google.com>
 <a7e2ac96-b710-40e5-a159-b49555bcf518@arm.com>
In-Reply-To: <a7e2ac96-b710-40e5-a159-b49555bcf518@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 1 May 2026 16:01:22 +0100
X-Gm-Features: AVHnY4INmeFm8QA4K3bkZ03la2-U8rDh6s5g7fQg4Z1xuyOvTM6dsAqgNAaZVmc
Message-ID: <CA+EHjTwgUF4AEw6WvxPiwMTtrTUEs1NjjuKso+VBChon2cdozQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] KVM: arm64: Make EL2 exception entry and exit
 context-synchronization events
To: Ben Horgan <ben.horgan@arm.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, qperret@google.com, 
	vdonnefort@google.com, catalin.marinas@arm.com, will@kernel.org, 
	yaoyuan@linux.alibaba.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: EF87D4AD79D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242450-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	SURBL_MULTI_FAIL(0.00)[mail.gmail.com:query timed out];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alibaba.com:email]

Hi Ben,

On Fri, 1 May 2026 at 14:47, Ben Horgan <ben.horgan@arm.com> wrote:
>
> Hi Fuad,
>
> On 5/1/26 12:21, Fuad Tabba wrote:
> > SCTLR_EL2.EIS and SCTLR_EL2.EOS control whether exception entry and
> > exit at EL2 are Context Synchronisation Events (CSEs). Per ARM DDI
> > 0487 M.b D24.2.175 (p. D24-9754):
> >
> >   - !FEAT_ExS: the bit is RES1, so the entry/exit is unconditionally
> >     a CSE.
> >   - FEAT_ExS: the reset value is architecturally UNKNOWN; software
> >     must set the bit to make the entry/exit a CSE.
> >
> > INIT_SCTLR_EL2_MMU_ON in arch/arm64/include/asm/sysreg.h sets neither
> > bit. KVM/arm64 hot paths rely on ERET from EL2 being a CSE, and on
> > synchronous EL1->EL2 entry being a CSE, to elide explicit ISBs after
> > MSRs to context-switching system registers (HCR_EL2, ZCR_EL2,
> > ptrauth keys, etc.). On FEAT_ExS hardware those reliances are not
> > architecturally backed unless EOS=1 (and, for entry, EIS=1).
> >
> > Until commit 0a35bd285f43 ("arm64: Convert SCTLR_EL2 to sysreg
> > infrastructure"), SCTLR_EL2_RES1 was a hand-rolled mask that
> > included BIT(11) (EOS) and BIT(22) (EIS), so INIT_SCTLR_EL2_MMU_ON
> > was setting both unconditionally. The conversion made
> > SCTLR_EL2_RES1 auto-generated; because the sysreg tooling only
> > models unconditionally-RES1 fields and EIS/EOS are RES1 only when
> > FEAT_ExS is absent, the auto-generated mask is UL(0). The seven
> > other bits dropped from the old mask (positions 4, 5, 16, 18, 23,
> > 28, 29) are unconditionally RES1 in the E2H=0 SCTLR_EL2 layout per
> > DDI 0487 M.b D24.2.175, so dropping them is harmless. EIS and EOS
> > are the only bits whose semantics changed for FEAT_ExS hardware
> > and where the kernel relies on the value being 1.
> >
> > Make the guarantee explicit: include SCTLR_ELx_EIS | SCTLR_ELx_EOS in
> > INIT_SCTLR_EL2_MMU_ON so that EL2 exception entry and exit are
> > unconditionally CSEs regardless of whether FEAT_ExS is implemented.
> > This matches the pairing in arch/arm64/kvm/config.c which treats EIS
> > and EOS together as RES1 under !FEAT_ExS.
>
> In v1 you also had this sentence:
>
> "INIT_SCTLR_EL2_MMU_OFF is left unchanged: that path is used during
> very early EL2 init and the EL2 MMU-off transition, neither of which
> relies on these bits in the same way."
>
> To me, it seems useful to keep that sentence as it makes it clear that INIT_SCTLR_EL2_MMU_OFF is purposely not changed.
> Or is there a reason why you dropped it? Perhaps it's just obvious to people more familiar with this code.

To be honest, I thought the commit message was quite long, and I
wanted to make it a bit more concise. I could re-introduce it if you
think it's helpful.

Cheers,
/fuad

> Thanks,
>
> Ben
>
> >
> > Fixes: 0a35bd285f43 ("arm64: Convert SCTLR_EL2 to sysreg infrastructure")
> > Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>
> > Assisted-by: Gemini:gemini-3.1-pro review-prompts
> > Signed-off-by: Fuad Tabba <tabba@google.com>
> > ---
> >  arch/arm64/include/asm/sysreg.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index 736561480f36..7aa08d59d494 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> > @@ -844,7 +844,7 @@
> >  #define INIT_SCTLR_EL2_MMU_ON                                                \
> >       (SCTLR_ELx_M  | SCTLR_ELx_C | SCTLR_ELx_SA | SCTLR_ELx_I |      \
> >        SCTLR_ELx_IESB | SCTLR_ELx_WXN | ENDIAN_SET_EL2 |              \
> > -      SCTLR_ELx_ITFSB | SCTLR_EL2_RES1)
> > +      SCTLR_ELx_ITFSB | SCTLR_ELx_EIS | SCTLR_ELx_EOS | SCTLR_EL2_RES1)
> >
> >  #define INIT_SCTLR_EL2_MMU_OFF \
> >       (SCTLR_EL2_RES1 | ENDIAN_SET_EL2)
>

