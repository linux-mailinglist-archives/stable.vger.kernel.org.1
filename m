Return-Path: <stable+bounces-206232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5520FD004E2
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 23:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7858A3017F3E
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 22:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3182C29BDA0;
	Wed,  7 Jan 2026 22:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbL6ENFf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jiw8eIUm"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA92F227BB5
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 22:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767824905; cv=none; b=WccgexSAafTcPWqOqGId2gfPI1JsoeDWwnCJdfeUdmTzgBoCs+kFQYq50dTYwuQV7t8wQl9Rp2kAdp2SsfzVZgwCMPLLR+y6iJdcXauOQvxotEawCeeDBe+JDZr21LXppPcdv7jmRh6unLRv8UhOTKo3So2aEhkyOcqSEE5mBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767824905; c=relaxed/simple;
	bh=aATYOib07sWLOsKiGdtXxigGqpXRH3ZwpLwkMd7SvIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DKirSJyWi1YBZ6h3juKr4SL5uaHCmf39BnFclsbKGnkOIqjjhvXEZVL8FGH/J/8WrikmmYCSmJ7v/DhbbFTzepzKYOTARNmDCXIAQmWVkjD9GU+d0FYT07fikkmnt5B2TdmE+66nCOs97n2R9NSTkHcnkjfEt7vaKqDvR/4YVCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UbL6ENFf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jiw8eIUm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767824901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVkHTijtpd5br1d+tZXZATxNXfNYRkyffv87kQYQsNw=;
	b=UbL6ENFfrhoFj5yd6+OjuZTZ0IIsgN18EAj88GnSD47ACsDKXt01NGyrH1+H6JnENOU3Xy
	YmmUbHY2XJ532K2mw5uBsuuXnUp4W4u0DKBDIPx/5QCvRd7+q8MEgGMQMg84Z5IJWQ9HY6
	PlDyztFDoo5e89k386J/WYl2VRDMFEc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-e38GF0V2PLmshu9Qhe7pwg-1; Wed, 07 Jan 2026 17:28:20 -0500
X-MC-Unique: e38GF0V2PLmshu9Qhe7pwg-1
X-Mimecast-MFC-AGG-ID: e38GF0V2PLmshu9Qhe7pwg_1767824899
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477563a0c75so13470675e9.1
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 14:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767824899; x=1768429699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVkHTijtpd5br1d+tZXZATxNXfNYRkyffv87kQYQsNw=;
        b=Jiw8eIUmOPD/imUMccVHh3dg1yAjIKv5GOOsWt9lqWHbqhfMBK0Da9xB3AINYDx0py
         zt3zux77he4wbtdaY80GLrLi0DtcisSysXKJMgYEKn8URqRe2g/awrv5Cb+Qkzq3ORJJ
         3Yb+ozb+0HQVpcUQmQFo6KH3smLiB2f+epuicvp/QeuHfdWGGVaSzXVK1GSh2UQcymTf
         eHRRyxjX2bCgGcKqIU6GQnA2pvzZsjWTgVpmKZiYT7CJ2dT6MiuO5iG3JFjxAQC03C91
         LO7eKDBALB+lt8QD+IaP4AcCiwRg8QRuYC5L7xkiKgSe2W2+n8SF/adoCU4blQBlZew9
         TSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767824899; x=1768429699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mVkHTijtpd5br1d+tZXZATxNXfNYRkyffv87kQYQsNw=;
        b=m0gdvCZHtI387mHZDlYuR7GoiU76OWSVthwNCadvefNui5JTFFtVW4UZAt2OM7QPHH
         u5G3e/bxuKYYZdYymmvEEVTSi7d3oJw6WEJ0xJQ/ToxP0BPxqqbMdtKrkye35uQQPogM
         t4ScZp6tA759SzwIC/bioEaCAQZcfdvki45s3F5j0bLodGqZ5yGT8DW/73bWMfxWzni3
         hRQluKzXCRgO/pEaVhiO8l9pY2wP8dZ1hOAEK2ji8l4g8ynLbazwP2Nah2mNJBIG3xjI
         Cw6b5VAAzL2HPK62d7QJKyzkSm3SpwqlatVkLSv208DAIB3Zn40TwCs38hUMsSv6wegC
         lyWg==
X-Forwarded-Encrypted: i=1; AJvYcCWmV1wnm/AV1WzpOplpwhb+pYWiiO+ttU1XE6q1Em00QpkFv76N+NwTD3ONKyyMluAZbn409yc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy28zdTUOwmwlsD1Di+hujC9j6lXfQCJkOt2jqLBp8jWlH0mxsQ
	dIieQ/9L307rYJSfkQf19sA7l2ds51JKkI9FnHsB/E8iT2TmJSoiuLJ8WDJm1ScgyFZAjdITo7z
	i/VUchIwBEkZy7TceIImgdNgZmuBMZNEKbYJ2fthT5NcpWwiXMxXZ8MWpQas70Pabd4ElcfWfuo
	Lmzeu+Y9yLo0oywkn2o+Iy/G385Lc+4vb2
X-Gm-Gg: AY/fxX635hf1LHIjcsOVbb4eq7LtjTpdY11KLrWIARMtdbHUjBxwhXnT9oyH4obu1Ox
	b9zZVOpc4Fq9tSeiyJ3zZG77q60rUnDKuZCupUrt7VGqIdAFQ4xTxEybWvkLnZjOwNF6+k66WA4
	1nyT3wEXyKaPlunlreOUYGavZwc/uOCLVib+ZBQeE1QWT9Ct2vR7hYQBO1jsEp7dxcdjcJ9KaK6
	V46AhXQl+YNUwGO9mO2jKIpgZLrJteQTtvAbtNzy/XnmKQr5m/RlncSPH5J1o5mnhCuDA==
X-Received: by 2002:a05:600c:46cc:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-47d84b41034mr50774715e9.31.1767824899190;
        Wed, 07 Jan 2026 14:28:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8oZ6T0f25giXXaK3zr72HpUxA+svjIZykRBSrHqHHQIs52WZrfeuqWY5jyHz0B4PduVyOu4c7ILznTVYWndg=
X-Received: by 2002:a05:600c:46cc:b0:45d:e28c:875a with SMTP id
 5b1f17b1804b1-47d84b41034mr50774565e9.31.1767824898727; Wed, 07 Jan 2026
 14:28:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260101090516.316883-1-pbonzini@redhat.com> <20260101090516.316883-3-pbonzini@redhat.com>
 <aVxRAv888jsmQJ8-@google.com>
In-Reply-To: <aVxRAv888jsmQJ8-@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 7 Jan 2026 23:28:07 +0100
X-Gm-Features: AQt7F2puFbK4SdwO10BfREF8NRqeyrqBEt8DtB3vAkNfI090_t10EvoI38O8u9Y
Message-ID: <CABgObfZSchPMdqSvvVPgy9s5-TkHHZpLPHNYSsK-YHRye0SAaw@mail.gmail.com>
Subject: Re: [PATCH 2/4] selftests: kvm: replace numbered sync points with actions
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 1:02=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
> > @@ -244,6 +254,7 @@ int main(int argc, char *argv[])
> >       memset(addr_gva2hva(vm, xstate), 0, PAGE_SIZE * DIV_ROUND_UP(XSAV=
E_SIZE, PAGE_SIZE));
> >       vcpu_args_set(vcpu, 3, amx_cfg, tiledata, xstate);
> >
> > +     int iter =3D 0;
>
> If we want to retain "tracing" of guest syncs, I vote to provide the info=
rmation
> from the guest, otherwise I'll end up counting GUEST_SYNC() calls on my f=
ingers
> (and run out of fingers) :-D.

I had a similar idea, but I was too lazy to implement it because for a
very linear test such as this one, "12n" in vi does wonders...

> E.g. if we wrap all GUEST_SYNC() calls in a macro, we can print the line =
number
> without having to hardcode sync point numbers.

... but there are actually better reasons than laziness and linearity
to keep the simple "iter++".

First, while using line numbers has the advantage of zero maintenance,
the disadvantage is that they change all the time as you're debugging.
So you are left slightly puzzled if the number changed because the
test passed or because of the extra debugging code you added.

Second, the iteration number is probably more useful to identify the
places at which the VM was reentered (which are where the iteration
number changes), than to identify the specific GUEST_SYNC that failed;
from that perspective there's not much difference between line
numbers, manually-numbered sync points, or incrementing a counter in
main().

Paolo

> # ./x86/amx_test
> Random seed: 0x6b8b4567
> GUEST_SYNC line 164, save/restore VM state
> GUEST_SYNC line 168, save/restore VM state
> GUEST_SYNC line 172, save/restore VM state
> GUEST_SYNC line 175, save tiledata
> GUEST_SYNC line 175, check TMM0 contents
> GUEST_SYNC line 175, save/restore VM state
> GUEST_SYNC line 181, before KVM_SET_XSAVE
> GUEST_SYNC line 181, after KVM_SET_XSAVE
> GUEST_SYNC line 182, save/restore VM state
> GUEST_SYNC line 186, save/restore VM state
> GUEST_SYNC line 210, save/restore VM state
> GUEST_SYNC line 224, save/restore VM state
> GUEST_SYNC line 231, save/restore VM state
> GUEST_SYNC line 234, check TMM0 contents
> GUEST_SYNC line 234, save/restore VM state
> UCALL_DONE
>
> ---
>  tools/testing/selftests/kvm/x86/amx_test.c | 55 +++++++++++++---------
>  1 file changed, 33 insertions(+), 22 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/x86/amx_test.c b/tools/testing/s=
elftests/kvm/x86/amx_test.c
> index 37b166260ee3..9593ecd47d28 100644
> --- a/tools/testing/selftests/kvm/x86/amx_test.c
> +++ b/tools/testing/selftests/kvm/x86/amx_test.c
> @@ -131,19 +131,27 @@ static void set_tilecfg(struct tile_config *cfg)
>  }
>
>  enum {
> +       TEST_SYNC_LINE_NUMBER_MASK =3D GENMASK(15, 0),
> +
>         /* Retrieve TMM0 from guest, stash it for TEST_RESTORE_TILEDATA *=
/
> -       TEST_SAVE_TILEDATA =3D 1,
> +       TEST_SAVE_TILEDATA =3D BIT(16),
>
>         /* Check TMM0 against tiledata */
> -       TEST_COMPARE_TILEDATA =3D 2,
> +       TEST_COMPARE_TILEDATA =3D BIT(17),
>
>         /* Restore TMM0 from earlier save */
> -       TEST_RESTORE_TILEDATA =3D 4,
> +       TEST_RESTORE_TILEDATA =3D BIT(18),
>
>         /* Full VM save/restore */
> -       TEST_SAVE_RESTORE =3D 8,
> +       TEST_SAVE_RESTORE =3D BIT(19),
>  };
>
> +#define AMX_GUEST_SYNC(action)                                         \
> +do {                                                                   \
> +       kvm_static_assert(!((action) & TEST_SYNC_LINE_NUMBER_MASK));    \
> +       GUEST_SYNC((action) | __LINE__);                                \
> +} while (0)
> +
>  static void __attribute__((__flatten__)) guest_code(struct tile_config *=
amx_cfg,
>                                                     struct tile_data *til=
edata,
>                                                     struct xstate *xstate=
)
> @@ -153,29 +161,29 @@ static void __attribute__((__flatten__)) guest_code=
(struct tile_config *amx_cfg,
>         GUEST_ASSERT(this_cpu_has(X86_FEATURE_XSAVE) &&
>                      this_cpu_has(X86_FEATURE_OSXSAVE));
>         check_xtile_info();
> -       GUEST_SYNC(TEST_SAVE_RESTORE);
> +       AMX_GUEST_SYNC(TEST_SAVE_RESTORE);
>
>         /* xfd=3D0, enable amx */
>         wrmsr(MSR_IA32_XFD, 0);
> -       GUEST_SYNC(TEST_SAVE_RESTORE);
> +       AMX_GUEST_SYNC(TEST_SAVE_RESTORE);
>         GUEST_ASSERT(rdmsr(MSR_IA32_XFD) =3D=3D 0);
>         set_tilecfg(amx_cfg);
>         __ldtilecfg(amx_cfg);
> -       GUEST_SYNC(TEST_SAVE_RESTORE);
> +       AMX_GUEST_SYNC(TEST_SAVE_RESTORE);
>         /* Check save/restore when trap to userspace */
>         __tileloadd(tiledata);
> -       GUEST_SYNC(TEST_SAVE_TILEDATA | TEST_COMPARE_TILEDATA | TEST_SAVE=
_RESTORE);
> +       AMX_GUEST_SYNC(TEST_SAVE_TILEDATA | TEST_COMPARE_TILEDATA | TEST_=
SAVE_RESTORE);
>
>         /* xfd=3D0x40000, disable amx tiledata */
>         wrmsr(MSR_IA32_XFD, XFEATURE_MASK_XTILE_DATA);
>
>         /* host tries setting tiledata while guest XFD is set */
> -       GUEST_SYNC(TEST_RESTORE_TILEDATA);
> -       GUEST_SYNC(TEST_SAVE_RESTORE);
> +       AMX_GUEST_SYNC(TEST_RESTORE_TILEDATA);
> +       AMX_GUEST_SYNC(TEST_SAVE_RESTORE);
>
>         wrmsr(MSR_IA32_XFD, 0);
>         __tilerelease();
> -       GUEST_SYNC(TEST_SAVE_RESTORE);
> +       AMX_GUEST_SYNC(TEST_SAVE_RESTORE);
>         /*
>          * After XSAVEC, XTILEDATA is cleared in the xstate_bv but is set=
 in
>          * the xcomp_bv.
> @@ -199,7 +207,7 @@ static void __attribute__((__flatten__)) guest_code(s=
truct tile_config *amx_cfg,
>         GUEST_ASSERT(!(xstate->header.xstate_bv & XFEATURE_MASK_XTILE_DAT=
A));
>         GUEST_ASSERT((xstate->header.xcomp_bv & XFEATURE_MASK_XTILE_DATA)=
);
>
> -       GUEST_SYNC(TEST_SAVE_RESTORE);
> +       AMX_GUEST_SYNC(TEST_SAVE_RESTORE);
>         GUEST_ASSERT(rdmsr(MSR_IA32_XFD) =3D=3D XFEATURE_MASK_XTILE_DATA)=
;
>         set_tilecfg(amx_cfg);
>         __ldtilecfg(amx_cfg);
> @@ -213,17 +221,17 @@ static void __attribute__((__flatten__)) guest_code=
(struct tile_config *amx_cfg,
>         GUEST_ASSERT(!(get_cr0() & X86_CR0_TS));
>         GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) =3D=3D XFEATURE_MASK_XTILE_D=
ATA);
>         GUEST_ASSERT(rdmsr(MSR_IA32_XFD) =3D=3D XFEATURE_MASK_XTILE_DATA)=
;
> -       GUEST_SYNC(TEST_SAVE_RESTORE);
> +       AMX_GUEST_SYNC(TEST_SAVE_RESTORE);
>         GUEST_ASSERT(rdmsr(MSR_IA32_XFD_ERR) =3D=3D XFEATURE_MASK_XTILE_D=
ATA);
>         GUEST_ASSERT(rdmsr(MSR_IA32_XFD) =3D=3D XFEATURE_MASK_XTILE_DATA)=
;
>         /* Clear xfd_err */
>         wrmsr(MSR_IA32_XFD_ERR, 0);
>         /* xfd=3D0, enable amx */
>         wrmsr(MSR_IA32_XFD, 0);
> -       GUEST_SYNC(TEST_SAVE_RESTORE);
> +       AMX_GUEST_SYNC(TEST_SAVE_RESTORE);
>
>         __tileloadd(tiledata);
> -       GUEST_SYNC(TEST_COMPARE_TILEDATA | TEST_SAVE_RESTORE);
> +       AMX_GUEST_SYNC(TEST_COMPARE_TILEDATA | TEST_SAVE_RESTORE);
>
>         GUEST_DONE();
>  }
> @@ -275,7 +283,6 @@ int main(int argc, char *argv[])
>         memset(addr_gva2hva(vm, xstate), 0, PAGE_SIZE * DIV_ROUND_UP(XSAV=
E_SIZE, PAGE_SIZE));
>         vcpu_args_set(vcpu, 3, amx_cfg, tiledata, xstate);
>
> -       int iter =3D 0;
>         for (;;) {
>                 vcpu_run(vcpu);
>                 TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> @@ -285,13 +292,14 @@ int main(int argc, char *argv[])
>                         REPORT_GUEST_ASSERT(uc);
>                         /* NOT REACHED */
>                 case UCALL_SYNC:
> -                       ++iter;
>                         if (uc.args[1] & TEST_SAVE_TILEDATA) {
> -                               fprintf(stderr, "GUEST_SYNC #%d, save til=
edata\n", iter);
> +                               fprintf(stderr, "GUEST_SYNC line %d, save=
 tiledata\n",
> +                                       (u16)(uc.args[1] & TEST_SYNC_LINE=
_NUMBER_MASK));
>                                 tile_state =3D vcpu_save_state(vcpu);
>                         }
>                         if (uc.args[1] & TEST_COMPARE_TILEDATA) {
> -                               fprintf(stderr, "GUEST_SYNC #%d, check TM=
M0 contents\n", iter);
> +                               fprintf(stderr, "GUEST_SYNC line %d, chec=
k TMM0 contents\n",
> +                                       (u16)(uc.args[1] & TEST_SYNC_LINE=
_NUMBER_MASK));
>
>                                 /* Compacted mode, get amx offset by xsav=
e area
>                                  * size subtract 8K amx size.
> @@ -304,12 +312,15 @@ int main(int argc, char *argv[])
>                                 TEST_ASSERT(ret =3D=3D 0, "memcmp failed,=
 ret=3D%d", ret);
>                         }
>                         if (uc.args[1] & TEST_RESTORE_TILEDATA) {
> -                               fprintf(stderr, "GUEST_SYNC #%d, before K=
VM_SET_XSAVE\n", iter);
> +                               fprintf(stderr, "GUEST_SYNC line %d, befo=
re KVM_SET_XSAVE\n",
> +                                       (u16)(uc.args[1] & TEST_SYNC_LINE=
_NUMBER_MASK));
>                                 vcpu_xsave_set(vcpu, tile_state->xsave);
> -                               fprintf(stderr, "GUEST_SYNC #%d, after KV=
M_SET_XSAVE\n", iter);
> +                               fprintf(stderr, "GUEST_SYNC line %d, afte=
r KVM_SET_XSAVE\n",
> +                                       (u16)(uc.args[1] & TEST_SYNC_LINE=
_NUMBER_MASK));
>                         }
>                         if (uc.args[1] & TEST_SAVE_RESTORE) {
> -                               fprintf(stderr, "GUEST_SYNC #%d, save/res=
tore VM state\n", iter);
> +                               fprintf(stderr, "GUEST_SYNC line %d, save=
/restore VM state\n",
> +                                       (u16)(uc.args[1] & TEST_SYNC_LINE=
_NUMBER_MASK));
>                                 state =3D vcpu_save_state(vcpu);
>                                 memset(&regs1, 0, sizeof(regs1));
>                                 vcpu_regs_get(vcpu, &regs1);
>
> base-commit: bc6eb58bab2fda28ef473ff06f4229c814c29380
> --
>


