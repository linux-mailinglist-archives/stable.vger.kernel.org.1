Return-Path: <stable+bounces-260915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uB6WAWL2JGqsCQIAu9opvQ
	(envelope-from <stable+bounces-260915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 06:41:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A89964ECB2
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 06:41:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Hf8Zhvv3;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260915-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260915-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B57A3015D11
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 04:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72A4281503;
	Sun,  7 Jun 2026 04:40:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE2F26E165
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 04:40:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780807257; cv=none; b=F60p1YZpKZmEq5gDhaGfRRGw6A3REt8usua4beZscLpAO9SSw9nb2/hyMP+uGAVh9UQtBmqJsleAi2mrC1uTsjAd+lH/DrWq6+LMefOJoZSrPaDACXUUIc8XEToJcIyQbekjeJxE3TtpD42bhmzt9Jtqs2S8gLAjnYTaIP2mI00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780807257; c=relaxed/simple;
	bh=Y21+EH4olkZ0W3VEeqTwt1mc3gayS452DWRjjkYkSw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ph/Y74jyBNoyGeqX9UuRfuxyRZHPycQYwjgXM24j1kr3DzPYXa8uAePFbnJPHrPrgIQ+5FaciQVxdkJAO5BK6OXpVcIjJO5JR6BGGpwqy5GMLSSyMfjgdH6oZqwR0SkowO5en39q+CGZ6lwqER7UiAOYqDycwuOtrFQkblrWlKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf8Zhvv3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6127A1F00899
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 04:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780807256;
	bh=SWq1G1dCFVfHhbmYeBGwyQi6NWxRDwCcZeYwq8cdorI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Hf8Zhvv3b8O1X1//zu1GV0al1TL9L+AdXrsqyHbvsawjhd3jEwKGW1bmo3ORrA8JC
	 IDXF9Ii/yCNHc/XilB5KyJ/j/aNYasKmLre5WzEZFrXCUBq0IvZtnGA/pcxCg4T98y
	 G/LRWHEMkFY2eOZ9UNS6K36Me3MMJu5Pn9q3L96nBJubKUPiNyQJypo7ED0cTTxuBZ
	 VJ9tpdoKtQFGv2qCi4qcyrj+0azD0QKy6SBhsutjHH/qFGLgIiO6RUDDbctFKCvU+I
	 0lw7NWqQEmUxhA3ZzGXap6nQNvn8bz2ZFi90/qRz6LDjaxiEaY78exArkKWthGKgP8
	 62ccHvJs1thaA==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68d232e119dso5197939a12.0
        for <stable@vger.kernel.org>; Sat, 06 Jun 2026 21:40:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+X5cMb9OsimzWg1HX1WBo0ar5aV6VXjH29XfsXHAO9cqwhJZM5chfVdscObDuFoVrm1T8mpPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKmHJV0Lnfpw/VyeIjsJ85gD3F0q/25AJcFdxGxIKNCSmDfeZ7
	njp4oqm8rnPdxl64KoU9SdDfvUEdgrcpgjHhWSAfjzCwpKzzGei9gaC4B6I7v9WCidj/dZCBojS
	/zPddMBQfP4b/9b+uO4m/z6kabp4g+vA=
X-Received: by 2002:a05:6402:3202:b0:68c:dbd5:a6ee with SMTP id
 4fb4d7f45d1cf-68fa524d47fmr4879465a12.25.1780807255000; Sat, 06 Jun 2026
 21:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604123433.3182173-1-maqianga@uniontech.com>
In-Reply-To: <20260604123433.3182173-1-maqianga@uniontech.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 7 Jun 2026 12:40:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7pKtVioksaR7ZnM-9R3=TW_-AWhzFkC80GD+RW4uWWDQ@mail.gmail.com>
X-Gm-Features: AVVi8CeuJtDaxdTkNltjUq9KFPjViMKpJ_x4HVIrrS42wNtRf9wNYjmDqxDSE2Q
Message-ID: <CAAhV-H7pKtVioksaR7ZnM-9R3=TW_-AWhzFkC80GD+RW4uWWDQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: KVM: return full old CSR value from kvm_emu_xchg_csr()
To: Qiang Ma <maqianga@uniontech.com>
Cc: zhaotianrui@loongson.cn, maobibo@loongson.cn, kernel@xen0n.name, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-260915-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:maqianga@uniontech.com,m:zhaotianrui@loongson.cn,m:maobibo@loongson.cn,m:kernel@xen0n.name,m:kvm@vger.kernel.org,m:loongarch@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A89964ECB2

Applied, thanks.

Huacai

On Thu, Jun 4, 2026 at 8:47=E2=80=AFPM Qiang Ma <maqianga@uniontech.com> wr=
ote:
>
> The LoongArch CSRXCHG instruction returns the full old CSR value in rd
> after applying the masked update. kvm_emu_xchg_csr() currently masks
> the saved value before returning it to the guest, so rd receives only
> the bits selected by the write mask.
>
> That breaks the architectural behavior and makes a zero mask return 0
> instead of the previous CSR value. Keep the masked CSR update, but
> return the unmodified old CSR value.
>
> Fixes: da50f5a693ff ("LoongArch: KVM: Implement handle csr exception")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> ---
>  arch/loongarch/kvm/exit.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
> index 3b95cd0f989b..264813d45cbe 100644
> --- a/arch/loongarch/kvm/exit.c
> +++ b/arch/loongarch/kvm/exit.c
> @@ -103,7 +103,6 @@ static unsigned long kvm_emu_xchg_csr(struct kvm_vcpu=
 *vcpu, int csrid,
>                 old =3D kvm_read_sw_gcsr(csr, csrid);
>                 val =3D (old & ~csr_mask) | (val & csr_mask);
>                 kvm_write_sw_gcsr(csr, csrid, val);
> -               old =3D old & csr_mask;
>         } else
>                 pr_warn_once("Unsupported csrxchg 0x%x with pc %lx\n", cs=
rid, vcpu->arch.pc);
>
> --
> 2.20.1
>

