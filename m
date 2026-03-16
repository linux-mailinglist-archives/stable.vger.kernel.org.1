Return-Path: <stable+bounces-225578-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBvyAZEhuGmdZQEAu9opvQ
	(envelope-from <stable+bounces-225578-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:28:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7435E29C57C
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87B57301D071
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D121039EF09;
	Mon, 16 Mar 2026 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yz5OSt/1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F43225A38
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674556; cv=pass; b=pYKK52S5VJ3qXCNZSTLsK5Iy9elBBo1ef8OxpGUnV0bHDdGEELXznjzMSjKN/UlHukJCK9puZQLxuIftUi/wCxkwQCS1zZQhg1o/H2v/J5DxNzm/MEr3FsKzXdVmrkBenlBQaVqTQpt7Ysw59FJKVTr0YfeMU9AZfvRIGophTro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674556; c=relaxed/simple;
	bh=OBnmjwFTw76SUK1D+KXgI7Q8sf+FZbI4wRJvGKqBkFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RN4ELK0Qi7v3gpNj6T+kcj7dwFOlaYeXY64YdtwrQKufY/74TqPLlT6rWUcU9fXqQ2egiDVmAmv8VImfjhR9gPp42wCB3r0FtoztWbDhoauAMnFNJzwlDWJXO4Qg08Fj1SVCAFZcLZlt1qNcVOm932ErQtoWprRtHTNTFw3ZvYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yz5OSt/1; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8d7f22d405so598378066b.0
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 08:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773674554; cv=none;
        d=google.com; s=arc-20240605;
        b=Lq9B/UIlZDfJpruyszZ8cqYLBBw3cy1BexnTP4Iv0VPIKaSlVDyqwh9BFRK1iIkxtw
         i6rYAQl1EPgWjcajsOZcQ9jALvytXA4eGvfJ7TSXqnCPPNTkZ+cwxTmTD16AVCHzkItW
         r9YuGfNIQI1vjyvbhoqYFw089bYX9JxDhBaErq+VysCe4ojfLgUlhA6V9X4ztBnqrTsK
         j7vNXqJvmYP2AbaSkXp5hH+1Y0XdqWrWeSe77C2g9Ru2noPUi2UhPX83woFfXFk5TUBa
         ojTR4eTSPNeBHklNHCajmfAKMbMFQP7IdZR7wYzJGjTosXIxZGryzuFaurIAtBtLAiWq
         Q93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Aela138P2UA6HOSTxLhqrmtMIrzMEnb2IdbvAjDcPFg=;
        fh=x9+jzKhXcWym5TwhonEviCsSDqvQOUZDP2MkpfqlW1Y=;
        b=ePdzcbdEyWPAJpe8w4SM3iley6ZZ4VegZ8SIxemaO7sh9qkPQtdnGNQPA6qPHWQCBa
         KV8CZVTkuA2zezOGceN3nkG5RSQ6DkroqF4yTwdIPq32qEDvobjNljMX2LcrlnCg955o
         6/D1jS9xed67kqy9ueT+agWDEA5p8CpalKfjUWQQKPRZKsy0LELO7PwFzYFoRfpkP153
         NRwMhPMoR/W7JQgrKGpmPZkB8MMFCunowhxw1MXCz2XciPUZW4MZGcVbyVig0GhtLcQc
         7xNY4INCS6T6o40kFevGf91iEKnHgpJKmLuH78pSjyJMO90N62a9o2d1r1mn40KOUl5E
         qOww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773674554; x=1774279354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aela138P2UA6HOSTxLhqrmtMIrzMEnb2IdbvAjDcPFg=;
        b=Yz5OSt/1nv4X6Rsusw0R9fyGiYTq39uQ2j4X8MZLlLPg3IZmM30NvodV7IwL4HwdJF
         GW9OjFKRwXOzYson7VkRUacEzfgh3SnbKYjpz5qgcCnaZ3yBieCoMw/4nhN52FReqBFn
         oAThtXB5tPf+P589BxQgEhp4iAK4Cr+9z8A8Y2MVBDcP7yaqztsl5RhxOTe5EAtltTw4
         BWdzop7sQTAlPMgaDSg2oFfh8ofMd3LZ4cRNHzHty5vbYPOtc6boRgxfCot+eRhMaPJz
         7/BQr/M0r3/ugOOXGr22808wJdiPKDFZ4cfUvLYG1I8NYfkmtXqtJG3sfsAbgi5IoRQS
         cKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674554; x=1774279354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aela138P2UA6HOSTxLhqrmtMIrzMEnb2IdbvAjDcPFg=;
        b=Xm5iX/QwV/vmJubdZCf86+QpsUp9Z8+AkKGI86DhgWdlzlLjs+UmmR7ZR+ERP6PnWD
         wuT4y31Vfe+wWpg03wE1AeaFFkkp2NJ8i0lOgUni+NWC9ZOVvUHe32aLjipucOgVyan0
         LRhWONoNz6n2FRvrFsCLTqJKeLhij0vmVG2BsnzvOGrFLOHfL8HuPzExpFh6D/gdbFSQ
         omb9FtVU6RqBHZkI6lIazwoM09Qi5uKGmZtSpjmW41VMbVNnToOZTs4OROkkoloRGGgC
         yDpXeXK9X0B1qTlHt5aoxLE3x4Q4PaOuH3miEC6+ypQzkNPTI9AqrLJRKrg2o40SfRTi
         1tQA==
X-Forwarded-Encrypted: i=1; AJvYcCWo2j5j/Cy8GNUIz4U3lmi0jXnHlajZkPjqIC8mFCZ2i6/D3/adne4BLzk5I1pLO63oW1ICbUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeA9Q2YpgHSNPMTDtTD7WjXcjvHxAytQCoFOAjtzhjY857TI/h
	sMBmQbiXi3je41SBOuYQIq3YGjQiTzHObS6PZFazK4YuqunpxpQcBO6S/8KGDS+DLMWpwj+QkT3
	txCyJgUb1yGMUYMkuBf8YZxbzbPcdnlo=
X-Gm-Gg: ATEYQzzVguh8vxZxjttL/Uoh20Gg/+JrrMsNP6hmNEJMs1bmF68fHW7AxLCFzh1OLVC
	7naF4Hk8Ol5gsabHXYwqbZP+gILKGlzbhBIeZ11aqe51aENsiYXJgfSErc8bSgh7sE1wwT7tZd0
	2NYMETF+Laj/jOu5GA920jx03QwhM62mslYcHVYJ0QrKEJBGdXH/xvJjsEbxLpcnnqY3k8Zg2EK
	s0AG8tnSqvLjigi7cRwyUrR6DNWJLvmG9iX6rGl2ga5wSCnACcb7kVw43oZlO84frDSk3Iicu06
	LXyXGEs=
X-Received: by 2002:a17:907:94d4:b0:b97:464:9553 with SMTP id
 a640c23a62f3a-b97650d8e72mr936440266b.17.1773674553492; Mon, 16 Mar 2026
 08:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316151612.13305-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260316151612.13305-1-osama.abdelkader@gmail.com>
From: Andy Chiu <andybnac@gmail.com>
Date: Mon, 16 Mar 2026 10:22:21 -0500
X-Gm-Features: AaiRm510yNIk-2AFg7p9AlWX6hUz5FX6ePJRq44wcScAeWIThYKeskTelXRSBP4
Message-ID: <CAFTtA3MXQdQodaurFOz0PneuHEbY2j+yfQyWgqT9gWMBS1cZjQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: kvm: fix vector context allocation leak
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Vincent Chen <vincent.chen@sifive.com>, 
	Greentime Hu <greentime.hu@sifive.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225578-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andybnac@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7435E29C57C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Osama,

Thanks for spotting this,

On Mon, Mar 16, 2026 at 10:16=E2=80=AFAM Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:
>
> When the second kzalloc (host_context.vector.datap) fails in
> kvm_riscv_vcpu_alloc_vector_context, the first allocation
> (guest_context.vector.datap) is leaked. Free it before returning.
>
> Fixes: 0f4b82579716 ("riscv: KVM: Add vector lazy save/restore support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Andy Chiu <andybnac@gmail.com>

> ---
> v2:
> - Add Fixes: tag
> - Add Cc: stable@vger.kernel.org
> ---
>  arch/riscv/kvm/vcpu_vector.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index 05f3cc2d8e31..5b6ad82d47be 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
> @@ -80,8 +80,11 @@ int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcp=
u *vcpu)
>                 return -ENOMEM;
>
>         vcpu->arch.host_context.vector.datap =3D kzalloc(riscv_v_vsize, G=
FP_KERNEL);
> -       if (!vcpu->arch.host_context.vector.datap)
> +       if (!vcpu->arch.host_context.vector.datap) {
> +               kfree(vcpu->arch.guest_context.vector.datap);
> +               vcpu->arch.guest_context.vector.datap =3D NULL;
>                 return -ENOMEM;
> +       }
>
>         return 0;
>  }
> --
> 2.43.0
>

