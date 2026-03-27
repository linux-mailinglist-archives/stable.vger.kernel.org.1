Return-Path: <stable+bounces-230654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFaMBEOFxmlALQUAu9opvQ
	(envelope-from <stable+bounces-230654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 14:25:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A13A1345254
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 14:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9185230DEE0D
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 13:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D923EBF08;
	Fri, 27 Mar 2026 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="2KSR4irP"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D48A3EC2DB
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774617392; cv=pass; b=OeoqSwoTDdO6nJdiwHUbuNRgJixH72xAL+16d4aARgFJcpwLrknvTj3NXTmyE0cxYMMo5zY4/MJtbVlTXLM0QUgsmKb9ONfu6uNynnnwtc+QZYcvqu1AP736yf9l+WzOz8DaX7TIVd304SxI3+SvsHpyacnRvPCVguf/7yljpBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774617392; c=relaxed/simple;
	bh=0npK+LpLA6BChEex8bv3MvWeonr79UU+n6b4CahqHrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKg+VsEh2Oe9gvLt/yoImSOmhAirsNopqcLmw/Z5jaLtICTRykNyhMZQAPrMs+VEj3sJhXNPoEa04ptXznik5IwCNFVQEq38k3jYc5HOpRqmon1EPIqJqaYIskUkm3JQ6lDOOE7U34qp0nM2DpROR6cmB8ou74JwSSYS2yAD0Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=2KSR4irP; arc=pass smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4671cbce32bso560955b6e.3
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 06:16:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774617389; cv=none;
        d=google.com; s=arc-20240605;
        b=OThPFNzG+lqu3F0m3aUG8G3IeNL1dAJeIGPka4sQMVyKlCXWO+48PVZ+dXjjgzAhNp
         oclhuhhjXYwSR64gtwe9hhYFiVadUpJ4VZ49Ex8iaz/RBWkzk+BeYEiTIAzAJF/SlsQ6
         NkmnYsk2ULkmriSUqDegmqqYhSlNHwdSfDKmR6161qLlCWFQrLb1C/a7N7ZspVZ3bVQ9
         yUa7GdEsT5tzUQHdaSs6zCKWU7iHMRBAvIORGkgmzOoL1Lh/d1QDUiHgBSz1M9cANhrH
         b3iOI23gnQiVcfHR98ACD3KdvPUKSQUjdU8A/wkW7Gky6mPSV7EYQAmwNRngJK6VAfTC
         aZSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LxsmBS0GOSp0jQyHQNaHHHPYwd9SwbtGqsQ8nHJmtNM=;
        fh=gtDvfeSCy0ibFP0r1a3el+4mdq1ZFYC1euY2Y/zZt3k=;
        b=J5tn9nsMt/Rv+VB2PPqECwUlBJ7zGakGdGatKCO/ZDJWewOHaE+QTBdaHAp0Z4Lbej
         8bNsIYda8Hcuw4LSpXTC1/XgydfHjNmfT6V13nMX0h6Q/oI/XhYGOIBuhR/++MvbpzTG
         7bwhAO31nfFsxCCilUbmZ+vynCX8sUCwvPV2OYrS79UuRYmpVP4IYYXO9TkVjZYseDMx
         W7Unr0oLP30vsxn/AV3OKsGNzqBdnGKRHcMjpK43ezxXTybRWlse+CGJd2yDeFhY65DS
         UbuX81/NlDZY+to5DZkIv6yvSTryHuX2sqcnacmfJxvE2962qDDRNvCtHxQDENhkov1W
         z26w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1774617389; x=1775222189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxsmBS0GOSp0jQyHQNaHHHPYwd9SwbtGqsQ8nHJmtNM=;
        b=2KSR4irPaxiQvIUfp42MQ5CEh/D/U6dAF5yrTV0Ix1lnCREHf138HtRDRT6v/PZ9bl
         AL0MWeyvWSajt7TxPxEO5YIiOC/m1KVatbYeDnQ9CHwwUkYzg+ykAu6v8B0qoKJAswq6
         JYuDNPssNZaq1ikzArHjwIcguSplps9nMNvXxajg3MPb6T5k1nESlQXrx8Y5LeVUeUJF
         WUw33E6tBiWMHcUCzhacVLGSAU4HSZ68VmUsc8DPVV2d+jYClrOx03yS4C16yTzosAEX
         wq6F9qt3XlVnwS4g6musHjvNX1o6rKFClzkFX7VW0s+9IruBSWJk7u25O7su1s9ruqjX
         QUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774617389; x=1775222189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LxsmBS0GOSp0jQyHQNaHHHPYwd9SwbtGqsQ8nHJmtNM=;
        b=Y59qr64E0O9/Sbgi2jDW3DTUf+IaIE1P4z3esOGRjQJ/IWxhVkLc9UYC2qMwRwbXVB
         z+Tdwup4ODhiTOs4mu3GC4IK12qAe4b8Uj7SV7dlkjnQMuRXOnAHsmda/THiGaZuQkk5
         L0s16lA7tFXSv+uJnJiTNQ8ooT5/SIdbAs4DLUdUn2oiMFEXeT1swWoR1p8hXOw7yZk8
         MRfGvmgVFIDQzwSGjB8J2xXumo/nfmLoX9UfJBHniBpsTKvKIogqvimD4Uv41Ch+metA
         /GEO9FVSWB3uG5aeP8+M3mAejQomTYM/qRDVcbyfLXeq2+zngX3s7BsYjuKorYOJp0pI
         iZzw==
X-Forwarded-Encrypted: i=1; AJvYcCW4G+vW9gAu+CT/puxHFH4g2ccAofGsLLLF994nvznZ5CD5t6UM9Bw8LwYPHqwDcBr4FpzayTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcIekT0wDqNfxg/IoexBJQyrXTMQREGi7wxZjMpZTCbpUr+5f5
	ASeav8J14yjJ90aoyiqENl52IMMrgEQy7I0zW6i8j2AQaVxCTifV5MRf3z3Tq4GurPjygXNHv5p
	PEUHhU89aTLEi7rw5cGdRk6rLmTg2giJzAo6Hh1VhUw==
X-Gm-Gg: ATEYQzxA85L6PDppcyY+E6xDDbpeQJW89u3brZf8jCg/TasVn7kwBv07mpacrTngdXG
	BVZrgY2a+pYegrrwS32EOWiMU/d0r2fYaFgu9qZ80rkaE+qS2eaTJ0+ycKRVS4yB4Bq0SwWHuJ/
	YWhF+/UOHfRX40Y8cJIrga9MJW8/Uph8wVvJadweD9EEFfBAV5deKosVKmNwiUeiMErNYqsD8nU
	smkiBaVnBtnagUcfXdo7xWAsl5lbAxS+9tylcHBn2lMd8RgXOMItKbYjubnmie0JmCEBlSUvS/w
	yRnZaozzxZi8w8mn2nB3GmZGiBArcxVRXKqfbw6ViF47IbG2J/Gmh25Ukva9OPQM7XO4X2/fhaS
	y1lSHvoMxECN1x+G4MUYRXY4J2g==
X-Received: by 2002:a05:6808:4f29:b0:467:32c1:acf1 with SMTP id
 5614622812f47-46a8a574768mr975177b6e.39.1774617389039; Fri, 27 Mar 2026
 06:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316151612.13305-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260316151612.13305-1-osama.abdelkader@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 27 Mar 2026 18:46:17 +0530
X-Gm-Features: AQROBzAiBWQwzRrAsNPun8GkheFgn7uHFWTVjZzHMuhgO-eFGjXm39iFGnN1dNM
Message-ID: <CAAhSdy1c=Bvso+ZCy_6a_1Bh8sznGDs9wErPQdqGWepgq8nQsg@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: kvm: fix vector context allocation leak
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Vincent Chen <vincent.chen@sifive.com>, Andy Chiu <andybnac@gmail.com>, 
	Greentime Hu <greentime.hu@sifive.com>, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[brainfault-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[brainfault.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230654-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[brainfault-org.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anup@brainfault.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,sifive.com,gmail.com,vger.kernel.org,lists.infradead.org];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,brainfault-org.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A13A1345254
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 8:46=E2=80=AFPM Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:
>
> When the second kzalloc (host_context.vector.datap) fails in
> kvm_riscv_vcpu_alloc_vector_context, the first allocation
> (guest_context.vector.datap) is leaked. Free it before returning.
>
> Fixes: 0f4b82579716 ("riscv: KVM: Add vector lazy save/restore support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Queued this patch for Linux-7.1

Thanks,
Anup

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

