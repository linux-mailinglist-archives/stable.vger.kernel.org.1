Return-Path: <stable+bounces-247405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCwDM7DCBmpdngIAu9opvQ
	(envelope-from <stable+bounces-247405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:52:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3088F54A271
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 153E230A0E98
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9960C38CFE7;
	Fri, 15 May 2026 06:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="knPfcEl0"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73948389441
	for <stable@vger.kernel.org>; Fri, 15 May 2026 06:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827745; cv=pass; b=T7XjuRV7LcEz3mXmBdj5W3C44Cg+d564B08iwgG5ZB9lr2Ga96OYdeku5ggjKC7Z+Tx41KflA2gEpKmsmuGrmbY9dxNL16bKDKIVfzDuNHDZCLO55L18P3LBx6/xezbCIs0uEf29DCauUucxrQjNXAKvyabxe8MYI5B5bkeSKSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827745; c=relaxed/simple;
	bh=f47kUb4LMQksQb+Wjk8JDEGBdcDr8vKzCh650ZNV8ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwlysXY2G0dHTn5eMR9GIM4CSJX5Sa6GCHGKyzLLmn/wpwh98NTaFvVQdhRc9nN9X8BAHs59xO7s8Wf5Dw9rRrUSLjgSkJqfMJ2nFSOCI54hfIpSUfZ5uUWrWvr108U7EQEayYpWD/bT/gsT0UGPGAjm0Eb5TDqpWhAHZD0EtQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=knPfcEl0; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-47cbd445021so5567833b6e.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 23:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778827742; cv=none;
        d=google.com; s=arc-20240605;
        b=gEKJIzZv57cRhns6hZ62DY62tbBUkcB4p6c0jxX1rMAy75eeK+GUdop9iqx4omFgk9
         rdr2NQC/58qcroPpSEalmlkMiqR7hE7eMNfWLwTvDMgPkoPX/WhyRVVsqUnjVifRD531
         5mFUPmjNQyVi6x/nvivCAEucqtEZ5c5q72IyY0u0ELmrYFGinfVkoOzh7JKOuY9e3+l+
         54y/jEiw4OFg3RDk6FvSr/TTSUsaVOyqWO0r01zbpOibaPeD+80tOATqkjgYtG/APZht
         bKuurpHRKliwvPQXDT+PEmcJEbOhKMrl9KF0/haQuydJ20d6SJlSTotBjAbCkiW4uWpe
         fSwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FHfxsuw0D4onwKk/YyQ8YkX6C3b41IlcaLUUVhpqyNo=;
        fh=MhcKuFzyrZ80amqYU3qOwoZXsTP/G/e661hhRXknsXg=;
        b=GA/44zWCCjvCYXeBRB49t9PInBS9ISg9chovNqxXvNtPDyiTkc6eks9rvYh0/w/Hz5
         mcPAXzwrepr1jRK5917+1Rjs9a4MT8dJFd3zk04VABGuPVJwRHUNaUqs5wQ9M+zFoPjI
         rqahpynL02ZjHw+xpPIppx52sz3YAJTaFkGEdA2DmP9lGf4LlNz1Rwy4HtccyocEsZZ4
         t9pkAkfnYW/ELKklWsEP1f3GKMlqJKPvSZErtCW+lK34YaozcVRbQV/Dw64QJXDUAsNa
         vTXa0kNDDz/zirPTDEHmFlEkgyfV5aJlG9cpqshbvDjjhGZF5k5KW9mpQ/UWXh7ef4I+
         dq8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1778827742; x=1779432542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHfxsuw0D4onwKk/YyQ8YkX6C3b41IlcaLUUVhpqyNo=;
        b=knPfcEl02ftbaeiJi2KIlRenZYGBmor5EMZNds7JZoR8XsNVclGeV1ItTj2vgGOl6C
         wVO8oq2seerbUzrAKkNOfEnqtKy7aK0iS48s7/4rm+yGOMLuT2NncUVrmqGVnL2bHINp
         AdmWaR3QT7NutJWR3SlZvOkCLAb1myi3rt/Wqo3GMEFJ3BOB8GjK5gv2KBk+gaE3eEht
         0XbVlKx5AUMTlvpXVL7gvUidHVHHAwK9mNFdNEQ2VzRgsrpWnW+Us2AG5xw4liwDInnn
         fUvCoRFga1krJaIln2HAr0wSuiMxY/9WNBaq6W6GdOs/7xKDFlvALrxBnRrEI2/+Vnj5
         SiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778827742; x=1779432542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FHfxsuw0D4onwKk/YyQ8YkX6C3b41IlcaLUUVhpqyNo=;
        b=b3R+AX7lqUCdOJhUd/UdLBluItLxW0aMfLx2w4v78s5mGnJBJAYNnxWPx5EYwy6fBG
         TlOgNlu/LVCLx6IiTBT/WK5mh1s8zO+gSlhBCCAn/sYG2BWvaIvk362avYAy9cDRCQk8
         FXKBtsU1DVvExsUCG2N62EjdhGmyKoVJEMdjemvWUw8skplxqpyI9iPc2RlxgdcLJVdv
         Ot35+oHGTfoFV5tbOvbrC3adbFBkKdi8vd7M8oxTYjDRdUYcFoIV5IbxC0kc02UB8Dyi
         rd+LYdFfPwOMYmXz+lJxi+wJMhmsnULkKwdsBbtrLgTUTTIqZ1v254hzAh/+nsF1KY5a
         VSJA==
X-Forwarded-Encrypted: i=1; AFNElJ/KZlkO+P9gnnATuybg/2xsUvdD3KS0Bwzk4OIYjo+IfTAE3YCCgxvJau03a/s3kLK9LDjd1i8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7x4iidTZSXuntD0M+C6cTn+6q3ydFy0H9mhI3MpeEQZxJ4NQ+
	fmTnYSzqX5g+ReSkY8FObdbhWJ5vveone8cTOhs8s5+awoCKoo6MVHvLmGK1OYa3CPL9JiZ11ap
	463Tk8BujfCClasYqXxY25x+Q+1+XRFDELJeCKidGXw==
X-Gm-Gg: Acq92OFfcoq8c6UqTf9wCTlLaJ4Jh8jNHk9l3aw46H6A48Yzryyjf5Om3GKXqz0SDDS
	Xe5tOx71SrxHZG33ATxaGXdvuvYrbS/rfvJK5p9fgMRSZG7eyyAfmH7GkWx7YkQSiRnf95cYeE0
	bcj0UEh8EfOuxUckLbjJchCv9V5eRl2ZddlYuGH6gMg7BmVkKFoavZ6IivF0nUcBNArwHLa7sT1
	XSCDd+7vaDPjZBj3CHggnHbT27VLCs8/CuaYK+PZvD2Rk4s0j6N0pD7DYjeMPW81g3j7uyD7Eov
	DxRPoj0AFS9ZeZ+y2uzw5/jDsOjS2pmyxrpkt9rqjxOulJ/zRs6faIKwlicoHiz9opUfLKzkM4F
	1HnWCafxQjwceVOADj905hE9Lqfxe0ba6tfMgqw==
X-Received: by 2002:a05:6820:627:b0:69b:95dd:46f0 with SMTP id
 006d021491bc7-69c9437cddemr1610219eaf.33.1778827742447; Thu, 14 May 2026
 23:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514173642.41448-1-osama.abdelkader@gmail.com> <20260514173642.41448-2-osama.abdelkader@gmail.com>
In-Reply-To: <20260514173642.41448-2-osama.abdelkader@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 15 May 2026 12:18:49 +0530
X-Gm-Features: AVHnY4LXgXrzLbMRAQUcA2m5MJLX3u-xm7PLLcuSO_7vFtenzJgf3TlQ9hZcJyI
Message-ID: <CAAhSdy2+CpDu4YFXVqSDji268fapqO3sgXOSUD+fNZs9Fdb2-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: kvm: return SBI_ERR_FAILURE for pmu_event_info OOM
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3088F54A271
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[brainfault-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[brainfault.org];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-247405-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anup@brainfault.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[brainfault-org.20251104.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brainfault-org.20251104.gappssmtp.com:dkim,mail.gmail.com:mid,brainfault.org:email]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 11:06=E2=80=AFPM Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:
>
> kvm_riscv_vcpu_pmu_event_info() returned -ENOMEM from the
> SBI extension handler, which caused kvm_riscv_vcpu_sbi_ecall()
> to abort KVM_RUN and surface the error to userspace instead of
> completing the ECALL with a negative SBI error in a0.
> Use SBI_ERR_FAILURE and the normal retdata path, matching other PMU
> handlers and kvm_sbi_ext_pmu_handler comment.
>
> Fixes: e309fd113b9f ("RISC-V: KVM: Implement get event info function")
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
> index 91aa0155a420..bb46dcbfb24d 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -501,8 +501,10 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *v=
cpu, unsigned long saddr_low
>         }
>
>         einfo =3D kzalloc(shmem_size, GFP_KERNEL);
> -       if (!einfo)
> -               return -ENOMEM;
> +       if (!einfo) {
> +               ret =3D SBI_ERR_FAILURE;
> +               goto out;
> +       }
>
>         ret =3D kvm_vcpu_read_guest(vcpu, shmem, einfo, shmem_size);
>         if (ret) {
> --
> 2.43.0
>

