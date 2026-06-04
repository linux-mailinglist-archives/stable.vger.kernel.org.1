Return-Path: <stable+bounces-260552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nPBFDuvBIWp1NAEAu9opvQ
	(envelope-from <stable+bounces-260552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 20:20:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 859936428DF
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 20:20:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ECpNZDCQ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260552-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260552-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA1BC305EAAA
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 18:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590493C0A1C;
	Thu,  4 Jun 2026 18:13:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EE03A759C
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 18:13:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596814; cv=pass; b=Xw/qCSmqyOpdjZVfhuh733IEY11HcsSSH6mB6BwcsSa87ZJU7qSPgztEVERbqgyxHKjBqXadHCW6zv2daPo5+EODcJfBDdhZFHctcPdjco0lyRwWAJN5SBJNgdP3IwKaALRmlp7xViYcXiiuexGn5ZkHrXUDJjdA/BMpt2X46Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596814; c=relaxed/simple;
	bh=r7aiLnJmSQE/TEAofXn2LNNOIhJcr0OcXIdWzKOEMtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJdLj4kV+jARJAUSIBxjxkNhwxD+iH0MO12tus88xHk2vfak/5hzldL5nay814dfqowWjbWx1+rDR0rqT0nbACtYFGsqcqRC10IZfM4xS8Wny8Apn+xUO7y3ZdkXfRHSX12DZOMAa9jL+TzeAyrncA0R9M8l/Hu3seyRuEqqJBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECpNZDCQ; arc=pass smtp.client-ip=209.85.128.175
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7de68222e96so10127157b3.2
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 11:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780596811; cv=none;
        d=google.com; s=arc-20240605;
        b=gL1kypQ+kA5CxzklTJEDOnfAfEZbQdbBk/PxYAawU94dnZmmzNoF0d/cTtcePHHwSO
         n6MKOXzNm9Vq9r/qUdCxgcl525jByT4Vjl65CCB+X4olw3bKwWQ98xCGDa2x98KjWXDp
         QAFE461qigHjvueJFOnWfE0LQagXhMxvShmzx8trovbmd/laXI+DTEZ8esT1UVhPHQ0i
         7zQ+vS5VcakOry7gXGFznTPmbfddu2VT6CO6Tpp8Y4zS1qN7iZkhBCsybbkVHTif91rq
         gY/7GiKbYpDpK+G3upRVYZcu2WMwbRl2t4tbFbQV0gFcYpsNPc5uiwcE2ihIMTIP7/Gn
         fIXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iFruEHEl8U8mG9W44aSlL4o+Qsuz+gyVd37nvoBW4iY=;
        fh=ZDxjQ1OIbSWSxaroJKQu4QaT+chqS3z06oqwzFlNjAw=;
        b=c1/dmI395+dE2Ng+X1/iGZFAqDFR9wEQ+g8HrsX8cJZQnKZsEHy9mMY4iGcTNRU223
         yQK/w9FG3pSQbwbEAZRGHUC2pWBkm8O+iJrX5SWjTajx3+CFb7MSKaAyRAG+qobzqnzk
         VlskGcHNTYtWdePhEXYw9QBKKOwVTnrF/NI6i8FDFPOLUfoTYcmEGybts94hB7N/NxyL
         JFynyAdJUopEeFLhbKj8yVNgfZLp+TvXltk1fGCGvg3ksbZnRsY88pL19uGep21Qc5/H
         r1g/TWgpadkubmfdnENDT8Z53z5xdfFFnJUCrcF5U0ZzCCTaLSNaj3n5Jgc0w4tht6eN
         TY3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780596811; x=1781201611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFruEHEl8U8mG9W44aSlL4o+Qsuz+gyVd37nvoBW4iY=;
        b=ECpNZDCQISmYYP84Hh3BhXYaUqwxFAgec1YEKU/o0PmvajJMQ17hP5fy60GEirVvJ7
         cWBBSKWHn4XocHCiv90fMb3ZWkZwtZ38+CvehSNhlRo/01n0+f/I4m1kllE1CMgbHZRo
         wSbvZGc8ZpXXbXNJ7adVxrkAj2BLI/ZaZWxvTk8iBgqBSrYudj2Lid/z/Tr729Zty/s3
         agM7niCsVBrfcYUAcu8JR6n61HDr5b+sKUTWgIXWFilhJG9iPj94Qsrc7KE9UGMrPwx7
         8qthZxwXcMhaxeExqRPjplPo51u9cNSUJgaiR7fl+a7kyJRqOnBXf7RI0tnoP/MK+wBz
         vLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780596811; x=1781201611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iFruEHEl8U8mG9W44aSlL4o+Qsuz+gyVd37nvoBW4iY=;
        b=n6xNuEUq2gD0uLb713i90WLR+2bkmZw71mb+pSvfBP+Z/qCZQoa9zG2m9bq7rVSYKm
         /+GMCIGAGKyrdKRER25xtqgBlquNlqNpRZVH0gY/2QhxydT264ohUz5xlHnpUpfwtfg0
         78GtdP814x3Ch8/1m8Xag5r+yzUDoOOma3r+7FQUsfIKEtk5PlQonKG+Zi0erCB3a/sV
         Jw7z/M7OCYAna57WY8uTrPEEbEo6r4Rq4tFva8S78xJlgyFh+l9vx7ZpBq9i4dZGgN/C
         MV11I9XNY3cJsMnVXT307EupUtYfEWQN1yd3Nop+Azckp+1M+u/uA/7l2Nr0dnbNWSwj
         r2TA==
X-Forwarded-Encrypted: i=1; AFNElJ9tKtVIHOjgWDYX/IrSu33FmlBE+EA4IkWsG83WoeSu75CbRww3lTbhdhMmwjY2m/YxO0GywVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZvbfnHN8FQSHGPBr/GvznsJYrWsX0+V3+7T8cSsR2XWGIEPxv
	QY5pvsiCdW/wDfuPuORFKcT38xxxOkiXXDPD6HMfbsjTK5zlA0o3U2Yyhp0SBiCij1nMvg42fBO
	3iEr0ZAD3TSA0jb8oKCT/PauF43CJR4g=
X-Gm-Gg: Acq92OGjx3o5X7uMvD9BKAsG7/25RECXRdEKeT0If9Qx+vsqDXRwhHUzuXJWZYLSSOC
	Awngyrmnitv0smPnvvznS7LVyQ+e3IGIMjNo6QBR6OSuGGw8C7aWouAZrlCw/TNyBwWU9CCjGKL
	Ict/Aoop0abmEDi82nbME9aBI/tUVwM22k0aE6NCTGBUJvqUub0hnncsSOvzWFg3M79enNGxvQo
	wKcjA1vI0Jy8ExQEAxlSNdAicOOH/ISEFseNBXTdUeCr40x5ls5pZ/6Q1xuOzRwp0jMxOXoeDJm
	l+VUKNuWNwcjnBJTr6Q=
X-Received: by 2002:a05:690c:6a12:b0:7bd:7c16:170e with SMTP id
 00721157ae682-7ed0dc9a14fmr305207b3.22.1780596811259; Thu, 04 Jun 2026
 11:13:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604151153.2488051-1-gnq25@mails.tsinghua.edu.cn> <20260604151153.2488051-2-gnq25@mails.tsinghua.edu.cn>
In-Reply-To: <20260604151153.2488051-2-gnq25@mails.tsinghua.edu.cn>
From: Magneto <magneto712003@gmail.com>
Date: Thu, 4 Jun 2026 23:43:19 +0530
X-Gm-Features: AVHnY4JkyXdU41yKdGlaIvP3bPb_0C-R0eBTkcgq9jckSbHdmHQXWlodnAPuYpI
Message-ID: <CALdn3FES+6N28KiHdzCyeddQd+LTfQ3gTsw2TM6Y42amwUbeyg@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Keep dynamic inner array lookups nullable
To: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, dxu@dxuuu.xyz, 
	stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:gnq25@mails.tsinghua.edu.cn,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:dxu@dxuuu.xyz,m:stable@vger.kernel.org,m:john.fastabend@gmail.com,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-260552-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[magneto712003@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[magneto712003@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,dxuuu.xyz,vger.kernel.org,gmail.com,linux.dev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tsinghua.edu.cn:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 859936428DF

On Thu, Jun 4, 2026 at 9:00=E2=80=AFPM Nuiqi Gui <gnq25@mails.tsinghua.edu.=
cn> wrote:
>
> An ARRAY_OF_MAPS can use an array created with BPF_F_INNER_MAP as its
> inner map template. A concrete inner array with a different max_entries
> value can then replace the template.
>
> After a successful outer map lookup, the verifier represents the
> resulting map pointer using the inner map template. Const-key lookup
> nullness elision consequently uses the template max_entries even though
> the runtime helper uses the concrete inner map max_entries.
>
> Do not elide lookup result nullness for maps marked with BPF_F_INNER_MAP,
> because the template max_entries does not prove that the key is in bounds
> for the concrete runtime map.
>
> Fixes: d2102f2f5d75 ("bpf: verifier: Support eliding map lookup nullness"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---
>  kernel/bpf/verifier.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7fb88e1cd7c4d..bffe12d0bb289 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8471,7 +8471,7 @@ static int get_constant_map_key(struct bpf_verifier=
_env *env,
>         return 0;
>  }
>
> -static bool can_elide_value_nullness(enum bpf_map_type type);
> +static bool can_elide_value_nullness(const struct bpf_map *map);
>
>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                           struct bpf_call_arg_meta *meta,
> @@ -8621,7 +8621,7 @@ static int check_func_arg(struct bpf_verifier_env *=
env, u32 arg,
>                 err =3D check_helper_mem_access(env, regno, key_size, BPF=
_READ, false, NULL);
>                 if (err)
>                         return err;
> -               if (can_elide_value_nullness(meta->map.ptr->map_type)) {
> +               if (can_elide_value_nullness(meta->map.ptr)) {
>                         err =3D get_constant_map_key(env, reg, key_size, =
&meta->const_map_key);
>                         if (err < 0) {
>                                 meta->const_map_key =3D -1;
> @@ -10225,9 +10225,12 @@ static void update_loop_inline_state(struct bpf_=
verifier_env *env, u32 subprogno
>   * lookup return value nullness check. This is possible if the key
>   * is statically known.
>   */
> -static bool can_elide_value_nullness(enum bpf_map_type type)
> +static bool can_elide_value_nullness(const struct bpf_map *map)
>  {
> -       switch (type) {
> +       if (map->map_flags & BPF_F_INNER_MAP)
> +               return false;

One small nit: the can_elide_value_nullness() function comment appears
to be out of sync with the updated parameter.

