Return-Path: <stable+bounces-215932-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGcUMo+gjWky5gAAu9opvQ
	(envelope-from <stable+bounces-215932-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 10:42:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9F712BF90
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 10:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DFB8308F616
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 09:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B332E0407;
	Thu, 12 Feb 2026 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q1qqUXK4"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511452DE6F9
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770889321; cv=pass; b=DCTYHl+LXIL2imZvFwpmGYxrRyhD2vscCq+8SQoG4nFSvL27O0XwI5X0tFDMSADppNs55+eKPkIqDu4+Iw6Uc9JcxFm1BTkJZTYtsqUULx9JNe8q71EkWnWBV81Yorsr3XIJ4W6g6DhAI95xaBRNjbKAKdgFONCgtzKUIIIZlWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770889321; c=relaxed/simple;
	bh=zmTrhOt5I67WnfOpJVUIewScgn5nhORqAKcL5d/sLMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bxmu9GydEz9eCkNmKtVSmREaGzNo3HTWgrDAy1b3tVUkU6pP9uuCLhUg3pmvjRcnji7+o+b5Y1zFPE+ixuNzF2sBKJ2Yl6Dc4kfHOYdMxBCo1FCEV7PZXZQ/PE41Oa0ijdYXtfjRZRuVM7tz/mbCW7nR9cZb3MPQR+WfWeMOVTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q1qqUXK4; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-505d3baf1a7so315161cf.1
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 01:42:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770889319; cv=none;
        d=google.com; s=arc-20240605;
        b=E+EdiS6Sy/+2f+19Irj6Pg7HEukfBR900jy596YVCWo8RR7HQlE5cfilacWhz4GNB0
         FQA8H9kzhkoYW6ZCGs499AWpujPZA6OYOOWxbQ4M3kVfVxWatOadpeHzdCdixFyICO/q
         zTFtuEmHnugzwuENWN9dJUHplQ++2qiMAOrr+uaV+ufgRDIHvi83wudPMlHkhgymhUvJ
         uvjOeqYElpfB4C4TrXrJR5RG/nqahQo1M38+NGUFm2uV8H5dMqO+SYo8u23hwHqsF9dH
         fD8ojooCusOvbG1eoI+CNOJck5MUCTVrOETjTV2WMGCmP7IyyGoVRMZpvRwFwIUr/0Df
         Q1ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VcH9GZLlhn0MK8AoO+gKd8YN91XeUHOY861U71nMAN8=;
        fh=BjRq9pe6fW6KSNFuNqrpLADClV1cT6u1nUHnXUrvG94=;
        b=Asdf86+Np/EI+qhbc3mQ+IWdaDjUXThWjXqA2OYUmDTpAzIpoGApK0u9BK6rcCW9bW
         +Do7J5d+PrwumGw9NygYWC6wlhGPSDE4WpQYNhvwdaydMTsjd5N1DysgPsuWgS7XFNkg
         RvjlAqvF7XROWSGTj1bracLK9PNdKNBOMnaQt97P6c38t62jJpHqIClS+7NAVwnfXvJR
         oPwdLCT6tSojppc3mrneVcSKGMuYS4ZhtehXlTVTNa+36T2GA7P1mV2KqNe/Pd0DIh/X
         BO6YYpQnxoIhNR9cbjx3Mno//hFNqvj4nG8urlNSJyz1llG0cjN0jHtpBCwaRoZNBauD
         xD1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770889319; x=1771494119; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VcH9GZLlhn0MK8AoO+gKd8YN91XeUHOY861U71nMAN8=;
        b=Q1qqUXK4GwTcaceRdFfqh9QZbR37YdU9ouTMJt5eBKeRjCGpi63sXYBFYRZlwZDZRE
         HY1t5bFgnYX/mxL+SKccaOxT8xW46mXj8ncPRQ5mPj841cxzCrCO99N+58VYc/1OY55k
         WCbyo84fa2YrEn9OKswvMUUhzBGtkakhRxbWUltkJr4NcGm+5Sx7MUkMVSpdW9CBP44X
         x3nmfigvcA3Zor6jBc+P4tsWbNuXOz2izgNaaNIr6Pr1q9LJHDg4Oz3SHVKewjc7bk7w
         sAZ2bfI+ASQXit0qcQPOP/UnC4a0tO9f0J8/MK5ELmzG1Q9djSHh+GYuXZ8cr5zRnrX0
         oYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770889319; x=1771494119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcH9GZLlhn0MK8AoO+gKd8YN91XeUHOY861U71nMAN8=;
        b=gNkJy0ohg6g61MbbCzK6tKfouTtE7qpQHJrun7Q0kfWaAwIDhg8sUbkIXSnUuPx0E+
         /1KGksh0l6WECzXrycn2D3Lm40XvgTB4kPVDEaTFLGLhOAMH/xcsL/14K8VA2Ax4anRl
         Gu9T7EtcCicOXbdVWiEeBQL8UfIaI74P9wcWVq9M6bYpFVJbbe9kJ6lXTd1grZktDN8P
         iaGrQXA1enJXTAkmp9nSTB4wJWzRAxzyfLl3NV2+wWEywKCyXdsf0hbYdDlEC0VuT8+3
         qAj67t0zCp7bZkn0zj8Fz/C5fOkIrY6RL+5Y/JN/sRkmoVsSfxf8bAImgmBqVxhnVLBW
         8d9g==
X-Forwarded-Encrypted: i=1; AJvYcCWR/Fc4Bcc1TQ9uxoUEne6wYw1FLSwJsipbxMC1Er42rlS1mi+o3OWomV+t/toOCpV/dL87/mw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5tm+c4HRFoCXwn9Yn3rdf949R6VIWZl5fzGEYrgy5uTj99dwH
	xMhIySYpG/GCk5VbavcEvPt4LaCmjTjW9o83MdwCdgJgGj/1faPWA1FS6uvdAHRI6zJpmDfs1Pi
	2bptw3i4w4G3pyDwawaYGU1aSgeTtvdunye+jS4a2
X-Gm-Gg: AZuq6aJVLzppqjIMItL3KamZ+qbZtaUJ85vr3cnBFRcsxQdYXJIS/+m1ZXtMMp0gww9
	c9hTh5rspXj1iS4W+QwzsSczRn49wX2y+iTIaZTYEadbMx47y68IK5/cJNqM51MFs3tDHToifjy
	ASB+LMO2+ENX9//hhH+KWzh65ddkZDaeTXBWmThuUWJhogurFj3AnPGh5U14nlzHFoayL7GDwD7
	6LNjp6Xwck7KLbMY3YOeTbtQHqw3qUHUx5xB9G64U3xyFRQTgfPHfxx/bcDdxYEo9yCKM7tqMyo
	3SVmY0Av
X-Received: by 2002:a05:622a:4f8e:b0:506:9852:75ec with SMTP id
 d75a77b69052e-506985282abmr2869311cf.9.1770889318777; Thu, 12 Feb 2026
 01:41:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212090252.158689-1-tabba@google.com> <20260212090252.158689-2-tabba@google.com>
 <86jywib98e.wl-maz@kernel.org>
In-Reply-To: <86jywib98e.wl-maz@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 12 Feb 2026 09:41:22 +0000
X-Gm-Features: AZwV_QiSeFqGPiRC70jpUcnw67INjoq4qSM1niKSMpmtbfB7i8EWB8CCB6Ry2n4
Message-ID: <CA+EHjTz-JU2gDfziCY2SguK9=6gGSCL5TN_U_C7FiZ5i0JTZqQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] KVM: arm64: Hide S1POE from guests when not
 supported by the host
To: Marc Zyngier <maz@kernel.org>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-215932-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 0E9F712BF90
X-Rspamd-Action: no action

Hi Marc,

On Thu, 12 Feb 2026 at 09:29, Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Fuad,
>
> On Thu, 12 Feb 2026 09:02:50 +0000,
> Fuad Tabba <tabba@google.com> wrote:
> >
> > When CONFIG_ARM64_POE is disabled, KVM does not save/restore POR_EL1.
> > However, ID_AA64MMFR3_EL1 sanitisation currently exposes the feature to
> > guests whenever the hardware supports it, ignoring the host kernel
> > configuration.
>
> This is the umpteenth time we get caught by this. PAN was the latest
> instance until this one. Maybe an approach would be to have a default
> override when a config option is not enabled, so that KVM is
> consistent with the rest of the kernel?

I spoke to Will about this, and one thing he'll look into is whether
this value in `struct arm64_ftr_reg` can be made consistent with the
cpu configuration itself (in cpufeature.c itself) . This would avoid
the problem altogether if possible. The question is whether the kernel
needs to somehow know that a certain feature exists even if it's
disabled in the config...

If he thinks it's not doable at that level, I'll look into
alternatives to make it correct by construction.

> >
> > If a guest detects this feature and attempts to use it, the host will
> > fail to context-switch POR_EL1, potentially leading to state corruption.
> >
> > Fix this by masking ID_AA64MMFR3_EL1.S1POE and preventing KVM from
> > advertising the feature when the host does not support it, i.e.,
> > system_supports_poe() is false.
> >
> > Fixes: 70ed7238297f ("KVM: arm64: Sanitise ID_AA64MMFR3_EL1")
> > Signed-off-by: Fuad Tabba <tabba@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_host.h | 3 ++-
> >  arch/arm64/kvm/sys_regs.c         | 3 +++
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index ac7f970c7883..7af72ca749a6 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -1592,7 +1592,8 @@ void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
> >       (kvm_has_feat((k), ID_AA64MMFR3_EL1, S1PIE, IMP))
> >
> >  #define kvm_has_s1poe(k)                             \
> > -     (kvm_has_feat((k), ID_AA64MMFR3_EL1, S1POE, IMP))
> > +     (system_supports_poe() &&                       \
> > +      kvm_has_feat((k), ID_AA64MMFR3_EL1, S1POE, IMP))
>
> Why do we need to further key this on system_supports_poe()? I can see
> this is a potential optimisation, but I don't think this is part of
> the minimal fix.

I did this to be consistent with similar checks, e.g., kvm_has_fpmr().
I can remove it or put it in a separate patch, whichever you prefer.

>
> >
> >  #define kvm_has_ras(k)                                       \
> >       (kvm_has_feat((k), ID_AA64PFR0_EL1, RAS, IMP))
> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index 88a57ca36d96..237e8bd1cf29 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -1816,6 +1816,9 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
> >                      ID_AA64MMFR3_EL1_SCTLRX |
> >                      ID_AA64MMFR3_EL1_S1POE |
> >                      ID_AA64MMFR3_EL1_S1PIE;
> > +
> > +             if (!system_supports_poe())
> > +                     val &= ~ID_AA64MMFR3_EL1_S1POE;
>
> How about S1PIE? It seems to have a similar problem, in the sense that
> it has extra state. But I guess because we don't put it behind a
> config option, we context-switch it anyway and all is good?

Like you said, S1PIE doesn't have a config option. I thought if I were
to add one to S1PIE, then why not add one to the other features that
don't have config options... It is conceivable that a config option
might be added in the future, but like you noted above, I think we
need a deeper fix that nips this problem in the bud.

Let's see if Will thinks that we can fix this at the `arm64`
cpufeature layer, rather than somewhere in KVM.

Cheers,
/fuad

> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

