Return-Path: <stable+bounces-247404-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNhrNIrCBmpdngIAu9opvQ
	(envelope-from <stable+bounces-247404-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:51:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B5154A246
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 806D430779F6
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06BD38CFE7;
	Fri, 15 May 2026 06:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="koHsNHUM"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D615033F8A5
	for <stable@vger.kernel.org>; Fri, 15 May 2026 06:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827742; cv=pass; b=geRplOFuVlQhbZHqfUeIeaDnwaSrGNEPqdC9R1k96bN/WbsOZL+bH9XrdeWtCyQ05KcyOJqdEseMkEQPszTS6AMIidzGTwVej0srlP1HU1dr4ye7Pfm9Aanv5N+HPpKk4qCl5+pIPfOLktkWcrEfMI9+jRo/pOjpRRtDKQ9Qp2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827742; c=relaxed/simple;
	bh=E9V+J9hi7Arb7De8BmQ9YEa/mNzSRMFI2i3CqjTC1XA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PN+vz33e7Qq3EAN5+NR1sqVU8UeJEEyjjLs9GpxvbjP/TqNJnEz3yoKQLcxJv8Jguq979Vx4i+rKBpmas1aLZKC3SiWV2979ZN9Dy1AVzqTKjiXS+IXT/5WyR32+nGxxrqvA3YDS/iWWTdfGd7seRTe/CJxW6cadG7oY6RsfNAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=koHsNHUM; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-439e43d16bdso1724676fac.2
        for <stable@vger.kernel.org>; Thu, 14 May 2026 23:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778827739; cv=none;
        d=google.com; s=arc-20240605;
        b=M7pFpdchYoAHvOVsppkwdhijOI8vUppolpMNOk+vjO/GxCKAKrr5juoHEioLpBqu5y
         xusEs/FKculOevu0p3lcZvKWCfP3/Ki6iLq0pFlbPJWy+0dPIHa4W236Uiou2fn6m4cI
         nXlYTgA2yux2tLxEXdBIcvgyid68d+Y/4Xb0zsIegedPiIbVsTp7xNu4rWO946F4fd5g
         7HNLS6/yOlioyFb7QbRuQAGS1/SBCo4uI37AD54NtKExbzJPXXhg7xnaVRvOo9bbedZb
         hfT8ILObhuEu6RVNNqsM4XNpP2Ri51D6Z6d25xJDXg88HPJxGIVoiw0guvcYiD1/Pfdr
         ekJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MJZeZoi3lwfWnxM/Nl8ZViqM1Fkj9v9XGZB4s5D/a8M=;
        fh=6oLKzTYiaD9EEJ9zsY4aieHSrw9FbZt+luxTqpHjCE4=;
        b=azSven+NNBiDeW4QTBHoUMgR4hVtuHPUGoalNV01+wJjZnrKigDRyQ9BxtMNc+To3J
         MRkplUWNe9wTSP0SY1mM6UFqrlmKrhancMjuIW/QLB3N3ddP4B63nRhVPhW1fM0sJ2+s
         dB6WvQxWZA8U5xZULWThVBLWE6d8n0pW0gu6Y3tDjPuuWu5zJHYPJIL2pMPIPmufxwJ2
         xUtuXvaMJY87Of2RycqXg18JHfLldksks9yvlnEe11ftE9iiXMGxMxJV+bZAaCw4F2QP
         b2ZmLAr/sc09RGIpAgrZWhVcPQWITkITFbp14bHyvnJe6t480yuaLcYuamo65BGHyaKQ
         Puxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1778827739; x=1779432539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJZeZoi3lwfWnxM/Nl8ZViqM1Fkj9v9XGZB4s5D/a8M=;
        b=koHsNHUMGgkk8JaCgt/Gul9wYhDvrT6uOoY8hVOustGCMDXeoRtJTXDc3zR4g0cyK/
         DkQtitzRvt7BrsYx+q4mqHoexyaliGHUbbuMl+h79r1gFh+AdXU7sOW6Hk7ZuMSL35u0
         yI9nRDlHYQBCx2IgnhssitWiqaLv4gUZ6jGxdPdXvYeWcrHWOdd7D/vfsCbmUnl9tGu7
         JKLc82WJswAL2JY3s23ky7Q71ydhWwdJSUz754loBX/xeC8bZ/k8TIRY4NZPXmIKtwyH
         7p2lzTqBuPeFJl+omF2/L62nIDbVWo+t3SWzziwHnUCmdVWv/LGs3Rr8Tbnt7yKvrqnd
         ZF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778827739; x=1779432539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MJZeZoi3lwfWnxM/Nl8ZViqM1Fkj9v9XGZB4s5D/a8M=;
        b=U1D6IixBIR5Cvug0W1yfQBMx52QMEOQCWaCeiJQHm3V23SH6hgwNYrb1LVtyjo/0ak
         zYpPN8wh4pSo392AZJRrnNYMuvtmvddTO9KFklmI3JrRV5YNzECJeh++f9fo6g6jaWf2
         dYIWQUv2moh/ajSmdMtzf2Arls/TarNkqAMqruRhyq4j5gMWIbYmzqPYvvuBo8/jEA01
         cq9eGTB4kgdWPSMQRmACKcPGU2qkN8RILwleifvSzAtsi27IgOqDBOcWOQm5118DPHCV
         NTmsZM/SLHNQadAjiNBTpcBfepezDvZqkAqa1jIGTAgVTEQPtnVxxvfvTJVxH/uXoAAp
         LGgA==
X-Forwarded-Encrypted: i=1; AFNElJ8BH3luBaxFzVIQ5kfwkgwsQh930dG9Y9p3kpRELHQzhgySIMRlDYpAxPcx26eCDX51KPjUAAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXVUdIM6Zh6T55FyH3jvv9fe3RwAV4LSc/ITeVEJBxIzYcHYIF
	jyHDOTQpNY4289w1qx1HCBNGbFK148TU8eYambkH+wcQ4DtOro4sWIUpC0dnVHfUF9VzD/PI2Xr
	KuuQFADEMZ+EqXNkLx70ghHsnm/f6UksUVSYYlcMRHA==
X-Gm-Gg: Acq92OEFTAcm/v4vUv+v7/QrFahRVmVO7ulo4MxdPyhpA88dsyhbfTW4kzonExTlvga
	GUVA0kwDfpSeHVpPlX6f90aHKiBrURXPqmsKStvlFzoR3XFkfMpBAyP/n78rIV7lL3GITRLVu2c
	lIMFS5KYRUnKfQMcVU+rDBj5BsH4+G2pkbRxACfJlE6jzZvBOLmaklEUW28Nl6Mt11pmNE74/Am
	iqOxQsG2OPfZ/tL8G9I9MOFCoc90vTospVgIS+oJS++J0x6ERnnLhnTnccbLzEDR5ZaT7Bauhxg
	8IslzN13ODq+S2ZHn4/MMP/wIO5X5zJaEWpW/d3hdfLxXR1/XCLugSTbv4EpqBGoXRv8Hh63fIb
	Fa8VcTg+gSNq3dWC+JB7ojPe9gJI=
X-Received: by 2002:a05:6820:174b:b0:696:29cd:bf4b with SMTP id
 006d021491bc7-69c94b454admr1633046eaf.51.1778827738723; Thu, 14 May 2026
 23:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514173642.41448-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260514173642.41448-1-osama.abdelkader@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 15 May 2026 12:18:45 +0530
X-Gm-Features: AVHnY4K8xzqoM5FY20mXX1nYOkYmhUWalyMOR_lK2NDzbN1JIwAiJwlW_5f4ndQ
Message-ID: <CAAhSdy1W_cQW0NfA6b3hX8CGtShZPgwbk1hhRB0jns6Dm+b9gg@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: kvm: return SBI_ERR_FAILURE for
 pmu_snapshot_set_shmem OOM
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 72B5154A246
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[brainfault-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[brainfault.org];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-247404-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anup@brainfault.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[brainfault-org.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brainfault-org.20251104.gappssmtp.com:dkim,mail.gmail.com:mid,brainfault.org:email]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 11:06=E2=80=AFPM Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:
>
> kvm_riscv_vcpu_pmu_snapshot_set_shmem() returned -ENOMEM from the
> SBI extension handler, which caused kvm_riscv_vcpu_sbi_ecall() to
> abort KVM_RUN and surface the error to userspace instead of
> ompleting the ECALL with a negative SBI error in a0.
> Use SBI_ERR_FAILURE and the normal retdata path, matching other PMU
> handlers and kvm_sbi_ext_pmu_handler comment.
>
> Fixes: c2f41ddbcdd7 ("RISC-V: KVM: Implement SBI PMU Snapshot feature")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this as fix for Linux-7.1-rcX

Thanks,
Anup


> ---
>  arch/riscv/kvm/vcpu_pmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index a935ed96bc17..91aa0155a420 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -453,8 +453,10 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm=
_vcpu *vcpu, unsigned long s
>         }
>
>         kvpmu->sdata =3D kzalloc(snapshot_area_size, GFP_ATOMIC);
> -       if (!kvpmu->sdata)
> -               return -ENOMEM;
> +       if (!kvpmu->sdata) {
> +               sbiret =3D SBI_ERR_FAILURE;
> +               goto out;
> +       }
>
>         /* No need to check writable slot explicitly as kvm_vcpu_write_gu=
est does it internally */
>         if (kvm_vcpu_write_guest(vcpu, saddr, kvpmu->sdata, snapshot_area=
_size)) {
> --
> 2.43.0
>

