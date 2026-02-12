Return-Path: <stable+bounces-215986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aClUC8ghjmm+/wAAu9opvQ
	(envelope-from <stable+bounces-215986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 19:54:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86048130718
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 19:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A165D305595F
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 18:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B5D263C8C;
	Thu, 12 Feb 2026 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3+zm171y"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06BE1FCF41
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770922426; cv=pass; b=XjvUVOSxlxaIw8v+pach74HI4FPvps111IbNDsJm4yURjmiVaMCbE9NGzp4nCKwQvDCWkHX5tPoR3b7HRpdF9JS2B4apsfNI/eh6Hi6+0g+CR5G4dG7fXeCzdEKqfrzwRvOu/C8IGUQuN91UxbKZI7PAnAfBvrjtRD6oxtblO40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770922426; c=relaxed/simple;
	bh=XMDd4/Tmzy2G8avag+KjNC0MlH3sj+OcJMh3Za8Ln/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClIFbFVSkMuRtRkl5Bb8krycoStkUshEQaLpsgM8kEu3fn721sBF9j+sYmvzLPEsNKFy+fdCdrbZTflp4ZBUpAsYXwvm6QnOqilgvAmcKBxH5EDJSA7qMJMVbPyCmwE8EYcdA9uE50HXbOwaAK0cNWiAcPgC6vwhNF6o8JlT53U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3+zm171y; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506a355aedfso46081cf.0
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 10:53:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770922423; cv=none;
        d=google.com; s=arc-20240605;
        b=Z/JkRbl84A42JVyE8zWUoP9P+K3EQoEMHjKO6D7VJZHmpJwj7Y9BpYdCeUqGU3IR9H
         Qu5SUALYShr+x26SxgMMfOqFwyLJ1MknZmjyP/t4TNkNJm+ZPykJ1pyDffJ/Vh6brtXa
         otRTupkpzkkn2NXZnCSuCspwLj9myxWKxYQQECuzMGn+WtwGJ+8NElOODwW9botIWYP8
         LAxZZxJs40GmGZmksM4xeexm3FnFj4imzXg1mhrDsFo3FlFR13efqd2+8wz58tlGdxAd
         OERVmH3ona+Ld3hzGMztxW5i2evyLJwM7Zw/7i+eVZ/nnrHf8FHDQ3gXBujol0S8hNjg
         aXYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KxJxh9FSjNvMYBpkVXl2+9DScVhBboCfxSSFZplOIEM=;
        fh=utiHSKmqJR+RPE6gt6jYYQvGwBmKt6kdzGBge7QAoEw=;
        b=Fnu4P9JBWwDdiTby26HHmLLJwEeKBw0GA5umbzw3xAfiCB6auFWnj8o3Lk/TTAwP05
         r7EU4CUDDp621blRVDhMPtfNYPZ/epNw5I3B/hvyV4lTzQwHhWcZMtgHRm1D274x3nOU
         DSMpYwyMR/O0r62E6tLUr7Mr0i+vv1Zm8Xfld6tb3I+Dbgdbwpz1CfVdjZ2xx/Bf+Z9E
         m0AtcIsmFhOm0sS4/UX9evGB1AbV/ixQXt5UMGRFoPLmPNY6NLK6iBqrkFd3X1U0NYK4
         N85zcLRCpuawWFV33ygUGWHdl1zofPPaZ0p3Xx6pTHBjFV+TMtVZMhoR8DbrcpGlFXbV
         QCZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770922423; x=1771527223; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KxJxh9FSjNvMYBpkVXl2+9DScVhBboCfxSSFZplOIEM=;
        b=3+zm171yQW8K6tOAgJvkM+q310AaKYjo9yInlOeveJxmH8/O6XAfLvrqCxClXcy/LE
         ZmOrj1u5t5dDZoGH56PBwbLD2dTUUKKZaNV++x1u8XyWwszJirh9oc1KsbvNe0HtO24K
         Zden75YQEpas5CE6Az/96Su0ojm0oj7HOOPvYJ5w9y6InZE/mCBQWUiCgEVqYzlawHld
         3YX8RmVcuEuaOkUnfex+ETKuBz39Nt3LjoODAO+OTo/jllGGSkDJCL5D51fM4WRqzSUR
         yzNZnmhxESi/uIBPqFG2MckzLdxBakzon6ARVoYiRQuIn7ZiBPExyEMJBVk21oIpKYik
         iDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770922423; x=1771527223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxJxh9FSjNvMYBpkVXl2+9DScVhBboCfxSSFZplOIEM=;
        b=LdbDEfYROxD6mjwTnurm+JlC6WMgIBDMVJfrlhwY7/cEoaqrJOhjJqbJ9pRwssnLuy
         Avv7hZ/qorIpJefKFF1omiHl8sr/UNv4XGs9qaMn0VdFnKXUq6Zu7cPSBZwEdLBtb2bg
         kvWgsNR7kfLerUqgJ/BKGgctcQPKmQ0/MtNs6OM3nA7Kl3Wu2U84TSAm3mBCUmc7Miu9
         4rl9uPavHIR9FQN1nkm2eRNhi6YQGtSdaWJU8a9UlxAdFEPOjiAmfvpYi78FDnz1kYJr
         QFwOfABq2Bns/w/2sox2c0zfObn3oUDVzCc5Vc2QGpPL4zFj3LtKN4WeOldvOXUSYscs
         yiOg==
X-Forwarded-Encrypted: i=1; AJvYcCXONQfsZCMBZkq0rvLb9CORAFaowiT+UrsNItEvR3y2Mh+QJDXqp/Oi/bWPTxsJkEcsVNvfH40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDS2OQQw8HOzKN320eBOaDM5UiX5r8zQx3dgoNieKCNIo3aULE
	Dyf564NmgNhaA1UL14xi7m63+Dfx8t3pw9i59p5lWGOOmarMxwtLrKahDYRkQjjzWmsW9EHWKIr
	Pa2uiwufRZgZJZC1EP0PhR4CUJLcLo7nRp+luKRpr
X-Gm-Gg: AZuq6aJ1KCUjSd8XFkPF+fflEmiVseU6IPJqlpLh9MtPIa7bnXux3eB405cumRol6qU
	cX0DSKQDE9dybtsSEs1sw09orpC8oG5Wn5RrRXlQaNCe9mRhExmyoT2LjBP+DpXpDAGcU+XFse6
	9izAU1Wu5ppLOYmcm2S2Ncc7B7rKM4rqOsgBNhT1GTl4+V7plixlfLz86uWxYol/Q32bAPzRFml
	WihwBntpHC0sTPFBMOhRenTt1S3GnpSsdb5cecHFkpJ+45wjSNXSrWxq70lO4rGstvW+x3CuVwN
	q8z/562MW6+gkYhBgRQ=
X-Received: by 2002:ac8:5ace:0:b0:503:2e98:7842 with SMTP id
 d75a77b69052e-506a5089fd7mr798601cf.4.1770922422056; Thu, 12 Feb 2026
 10:53:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212090252.158689-1-tabba@google.com> <20260212090252.158689-2-tabba@google.com>
 <86jywib98e.wl-maz@kernel.org> <CA+EHjTz-JU2gDfziCY2SguK9=6gGSCL5TN_U_C7FiZ5i0JTZqQ@mail.gmail.com>
 <86ikc2asa8.wl-maz@kernel.org>
In-Reply-To: <86ikc2asa8.wl-maz@kernel.org>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 12 Feb 2026 18:53:05 +0000
X-Gm-Features: AZwV_QgjHAKlb2oJ6cTtVmiD8glUdVPUVPAc_uYr3UsDjUESaoBBPSZwwkWqYwc
Message-ID: <CA+EHjTwLcxB1e_FZsw_Semoj8tjMBUKZFM8+Vbo+64+=T4GN-Q@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-215986-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 86048130718
X-Rspamd-Action: no action

/fuad

On Thu, 12 Feb 2026 at 15:35, Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 12 Feb 2026 09:41:22 +0000,
> Fuad Tabba <tabba@google.com> wrote:
> >
> > Hi Marc,
> >
> > On Thu, 12 Feb 2026 at 09:29, Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > Hi Fuad,
> > >
> > > On Thu, 12 Feb 2026 09:02:50 +0000,
> > > Fuad Tabba <tabba@google.com> wrote:
> > > >
> > > > When CONFIG_ARM64_POE is disabled, KVM does not save/restore POR_EL1.
> > > > However, ID_AA64MMFR3_EL1 sanitisation currently exposes the feature to
> > > > guests whenever the hardware supports it, ignoring the host kernel
> > > > configuration.
> > >
> > > This is the umpteenth time we get caught by this. PAN was the latest
> > > instance until this one. Maybe an approach would be to have a default
> > > override when a config option is not enabled, so that KVM is
> > > consistent with the rest of the kernel?
> >
> > I spoke to Will about this, and one thing he'll look into is whether
> > this value in `struct arm64_ftr_reg` can be made consistent with the
> > cpu configuration itself (in cpufeature.c itself) . This would avoid
> > the problem altogether if possible. The question is whether the kernel
> > needs to somehow know that a certain feature exists even if it's
> > disabled in the config...
> >
> > If he thinks it's not doable at that level, I'll look into
> > alternatives to make it correct by construction.
>
> What I currently have for that is rather ugly:
>
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 72f39cecce93a..3bde0ad5ea972 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -971,6 +971,7 @@ struct arm64_ftr_reg *get_arm64_ftr_reg(u32 sys_id);
>  extern struct arm64_ftr_override id_aa64mmfr0_override;
>  extern struct arm64_ftr_override id_aa64mmfr1_override;
>  extern struct arm64_ftr_override id_aa64mmfr2_override;
> +extern struct arm64_ftr_override id_aa64mmfr3_override;
>  extern struct arm64_ftr_override id_aa64pfr0_override;
>  extern struct arm64_ftr_override id_aa64pfr1_override;
>  extern struct arm64_ftr_override id_aa64zfr0_override;
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 1a7eec542675b..32069da9651bf 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -778,6 +778,7 @@ static const struct arm64_ftr_bits ftr_raz[] = {
>  struct arm64_ftr_override __read_mostly id_aa64mmfr0_override;
>  struct arm64_ftr_override __read_mostly id_aa64mmfr1_override;
>  struct arm64_ftr_override __read_mostly id_aa64mmfr2_override;
> +struct arm64_ftr_override __read_mostly id_aa64mmfr3_override;
>  struct arm64_ftr_override __read_mostly id_aa64pfr0_override;
>  struct arm64_ftr_override __read_mostly id_aa64pfr1_override;
>  struct arm64_ftr_override __read_mostly id_aa64zfr0_override;
> @@ -850,7 +851,8 @@ static const struct __ftr_reg_entry {
>                                &id_aa64mmfr1_override),
>         ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2,
>                                &id_aa64mmfr2_override),
> -       ARM64_FTR_REG(SYS_ID_AA64MMFR3_EL1, ftr_id_aa64mmfr3),
> +       ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64MMFR3_EL1, ftr_id_aa64mmfr3,
> +                              &id_aa64mmfr3_override),
>         ARM64_FTR_REG(SYS_ID_AA64MMFR4_EL1, ftr_id_aa64mmfr4),
>
>         /* Op1 = 0, CRn = 10, CRm = 4 */
> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> index 85bc629270bd9..202e165a4680c 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -51,6 +51,7 @@ PI_EXPORT_SYM(id_aa64isar2_override);
>  PI_EXPORT_SYM(id_aa64mmfr0_override);
>  PI_EXPORT_SYM(id_aa64mmfr1_override);
>  PI_EXPORT_SYM(id_aa64mmfr2_override);
> +PI_EXPORT_SYM(id_aa64mmfr3_override);
>  PI_EXPORT_SYM(id_aa64pfr0_override);
>  PI_EXPORT_SYM(id_aa64pfr1_override);
>  PI_EXPORT_SYM(id_aa64smfr0_override);
> diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
> index e5ea280452c3b..b8dbe02e53171 100644
> --- a/arch/arm64/kernel/pi/idreg-override.c
> +++ b/arch/arm64/kernel/pi/idreg-override.c
> @@ -24,10 +24,12 @@
>  static u64 __boot_status __initdata;
>
>  typedef bool filter_t(u64 val);
> +typedef void cfg_override_t(struct arm64_ftr_override *);
>
>  struct ftr_set_desc {
>         char                            name[FTR_DESC_NAME_LEN];
>         PREL64(struct arm64_ftr_override, override);
> +       PREL64(cfg_override_t,          cfg_override);
>         struct {
>                 char                    name[FTR_DESC_FIELD_LEN];
>                 u8                      shift;
> @@ -106,6 +108,22 @@ static const struct ftr_set_desc mmfr2 __prel64_initconst = {
>         },
>  };
>
> +static void __init cfg_mmfr3_override(struct arm64_ftr_override *override)
> +{
> +#ifndef CONFIG_ARM64_POE
> +       override->mask |= ID_AA64MMFR3_EL1_S1POE_MASK;
> +#endif
> +}
> +
> +static const struct ftr_set_desc mmfr3 __prel64_initconst = {
> +       .name           = "id_aa64mmfr3",
> +       .override       = &id_aa64mmfr3_override,
> +       .cfg_override   = cfg_mmfr3_override,
> +       .fields         = {
> +               {}
> +       },
> +};
> +
>  static bool __init pfr0_sve_filter(u64 val)
>  {
>         /*
> @@ -221,6 +239,7 @@ PREL64(const struct ftr_set_desc, reg) regs[] __prel64_initconst = {
>         { &mmfr0        },
>         { &mmfr1        },
>         { &mmfr2        },
> +       { &mmfr3        },
>         { &pfr0         },
>         { &pfr1         },
>         { &isar1        },
> @@ -398,14 +417,19 @@ void __init init_feature_override(u64 boot_status, const void *fdt,
>  {
>         struct arm64_ftr_override *override;
>         const struct ftr_set_desc *reg;
> +       cfg_override_t *cfg_override;
>         int i;
>
>         for (i = 0; i < ARRAY_SIZE(regs); i++) {
>                 reg = prel64_pointer(regs[i].reg);
>                 override = prel64_pointer(reg->override);
> +               cfg_override = prel64_pointer(reg->cfg_override);
>
>                 override->val  = 0;
>                 override->mask = 0;
> +
> +               if (cfg_override)
> +                       cfg_override(override);
>         }
>
>         __boot_status = boot_status;
>
>
> which works, but is not super friendly.

Ouch! Yeah, no easy solutions here. For now, as a fix to be able to
backport, would you like me to respin this without the change to
kvm_has_s1poe(), or with that change as a separate patch?

Cheers,
/fuad
> Looking at the arm64_ftr_reg structure, this could work if
> FTR_VISIBLE_IF_IS_ENABLED() didn't simply put "HIDDEN" when the
> feature is not present, but forced things to be disabled
> altogether. The problem is that "HIDDEN" means not shown to userspace,
> and that we have plenty of HIDDEN features that must make it into KVM.
>
> I'll have a think.
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

