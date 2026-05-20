Return-Path: <stable+bounces-252256-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI1yFqURDmoJ6AUAu9opvQ
	(envelope-from <stable+bounces-252256-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:55:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71681598E65
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DA80313FC5E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073FC3F7884;
	Wed, 20 May 2026 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bP1fWYxn"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAF13F23C5
	for <stable@vger.kernel.org>; Wed, 20 May 2026 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300200; cv=pass; b=E4O1Jc6+FbxvYiBuXC3CqFOPTv/qsQO4fRf6FQ2UKDMrZvBBg0RWK4ulszSClpsdzesI2NayrDx3WqyaGGDSKQaWQlguHkcwRG4HCf990huZF4PD4A/hMljbj8SRPjdTj1JAvAKa3noo36/tkJAXPk4u+krNIHzr9rvIA9VKw3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300200; c=relaxed/simple;
	bh=R4vRu/jv4R4pEMk8oOa5/8LoVk1VuOpHapbhfUE09yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pX8Qlc0N3a4DUkHkmWhKhZRovXgIl8sngk5TofHzc6YBWIE1BhVQAu4XJsT3Jhu4EnxJcNig/Vei7YL1zs+sc578jWggLpKPj4gW/+zw2W1cUY1Q+1wEJZU1tnPTxqoUcM4wWNF3crLxrFqQ0PiMBVgFwaOLyTAxEbXXgT9jg44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bP1fWYxn; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43fe62837baso3027493f8f.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 11:03:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779300198; cv=none;
        d=google.com; s=arc-20240605;
        b=GNmCQysToFR8fu2tZksTFiLVmn3Hn0NbB11r6lEplPJZ46wy7/oHfExdlPFV2OAGIG
         uje1Shkqpkyf9TA7mr2mV/4hw0oyKDTyTDE5wmPxDaxkU5+KaXiXhgK/4f1shsWkaKKR
         z11eUDPiGpW8RyyqtvZqk/Na3BRS9a4IJQXPAqmaj6G9JZAMy5AmHgwxmq1MzoQE/QuR
         pachDaMXZKAkOsaMQawCaJkS1999ikzKYwqHBCQzbJla4dGdNLyEsuNjcP8KaXm2nb7+
         DTlRSRDtLSp2iiTyp7RWQ3biIrr5U8OcQ/A6sPgd6jnuiSLw02rEC/q+382ekkzYIJ8W
         BgaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nKzvQK6jVRc5SBSzyOa/yyss0dPKvwx3nFjmc+hSUAw=;
        fh=iuM1bnysFz8Oa6VfqjpenKfYKxCpX9ZAz/0yWGW+kkQ=;
        b=CbBeAG6ak4ruWP31na0lvSC2i0Xtacwrkbq0hBvr6NWjB7kdz+hiIc2+wpR8wFpGDu
         syu24ponJ/lzhYmKKuLLHbNN/sKKyMMYTcstnOxWvp7zo9hhwDw37m3WpDkcQ1mCUozw
         WhtS8T9NSqMUrC6ntrZ+kWj1EoYFi7gW8Wa9H1qu2abZhiwweEB8ZPreUvqX6wa9i98J
         ND97ZhwLqTRYsY7bGC+O8q2iOkDWGme6lcM1rXnmmwHNldWEEYTL2w8/FlkGjgtV4fCc
         0syig5hQ2fwbq+eeAySKGVKbgnpmj4zjO3OpBHqo/cZJ535sxiVy+jlTMXor5SZKriVf
         fPuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779300198; x=1779904998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKzvQK6jVRc5SBSzyOa/yyss0dPKvwx3nFjmc+hSUAw=;
        b=bP1fWYxnfuspI5z/JaAgjx55C0/gbusKw0YNT6A2hz5D1lOHJ/3QyPA2NPwfHG+YDh
         hnc20rLOeiQjBfsWrA5pXroEuJB4LEGqan30k17AedMeF3J4CgBpib62ZeR9CdPvGptR
         usxvSbMr7dkhWVHz3SMDW7k5W5sXcrORZlMziijY7FVA+Y6MYUEYJRXu9gk8Px/AOwjW
         NlEbBFub5cTW9HMNIaj880cmVnh5LsxZcWpcux6a+rthvjFslLgQWcLdQ4BEIW/ezr5X
         oPUN1biQdajaluJMSKs9U0iCiYuasN0MiAoEG9GOuoGMfgHTV9dzVDN8J12G0/erS1qC
         qKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779300198; x=1779904998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nKzvQK6jVRc5SBSzyOa/yyss0dPKvwx3nFjmc+hSUAw=;
        b=cNh+8NG9gS5e4kERW0QKOOXOJUxujT9LfzuZcf/teCPC7QPeWjEzOjN8xUPHk5p/U9
         jBWRHXRFs5MH0yMTgGrFAFBDUPdRUAvTjtlrW3IeaN5eLDJvtDzy6cwbSQs1JuO6zjw9
         LtZZuBESwtlsjOMY8Kx+h6KVCcqSNCngm5Eg9SgTpQ8L6NsZx4w0Fvu8zvCibOU/mKEE
         TVg0YwAhDRhnwMVElxpf5kdP63/i6wjT/8fq3bkyNPcpUs7zVrxjclkFPZq8feGJPDM1
         zZAD5phguV96LPKfNk+4RKC0l5U6TCC5aUy+XIP7oB245oVSpqq+0sSghBLz6dHiFXA4
         847g==
X-Gm-Message-State: AOJu0YzItDPmOxi9rJcEBiplKJeKPf6n6SyM2lrUeJn/QRIc2Ir/a+QF
	/4DxZMLSsE/o/aThp48eajEqh9dEuf/BkRhl/HBD5zUZ/T3VStpWlO+293wkFlEW5V9R9qP4cA1
	GXJCXSjIb8lBvA+3UskcDvWD0sy/73F0=
X-Gm-Gg: Acq92OHrFCmXiNOK441fvJkACazE1T/uyYJO4XBOknTj6MRnVn8EjcmZzllYVYDJgJb
	+fyVwY1C8RSUNtk+DiCNhjRAt9RDZnu8S4VM4PadduJBP+YZVmMp4jzIJVAjt8WT9GOuL2ZnXVv
	ikEVSEI8vxRdVImXiDj6APwZDKdVXgqlbjwrKg/5iWzwCj8zzLSytUdRjmO7zbirkjZs2/zZWpe
	pkEbaNtASov8D+8vnj1miW17XXCMkBa4ge7/96/fOmP22Cw2gRHrCO3tHeM1tFc6uJIan7qmfmB
	x/H+/w==
X-Received: by 2002:a5d:49d2:0:b0:45e:739b:3e3b with SMTP id
 ffacd0b85a97d-45e739b3ed0mr21571398f8f.0.1779300197474; Wed, 20 May 2026
 11:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520162148.390695140@linuxfoundation.org> <20260520162158.293493405@linuxfoundation.org>
In-Reply-To: <20260520162158.293493405@linuxfoundation.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 20 May 2026 11:03:05 -0700
X-Gm-Features: AVHnY4I0oRD4H-nHPpGpN_31rOx9MKDL9wQCkgHb0aXOSidV1k_XTm-LjE_DV8A
Message-ID: <CAJnrk1bWJfT5hswsJ3X5HMZ=XLz5MO3pYXg6WkuYYvZ6ccS0Nw@mail.gmail.com>
Subject: Re: [PATCH 7.0 0446/1146] fuse: fix premature writetrhough request
 for large folio
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Horst Birthelmer <hbirthelmer@ddn.com>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252256-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ddn.com:email]
X-Rspamd-Queue-Id: 71681598E65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 9:45=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 7.0-stable review patch.  If anyone has any objections, please let me kno=
w.

I don't think this is needed for 7.0-stable or 6.18-stable as the bug
isn't triggerable until large folios are enabled, which fuse doesn't
support yet [1].

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/52674b2d-627f-428a-89f7-36c39caa7=
6fe@linux.alibaba.com/#t

>
> ------------------
>
> From: Jingbo Xu <jefflexu@linux.alibaba.com>
>
> [ Upstream commit 5223e0470e7bb7910038fe3d31171490e00fbbb9 ]
>
> When large folio is enabled and the initial folio offset exceeds
> PAGE_SIZE, e.g. the position resides in the second page of a large
> folio, after the folio copying the offset (in the page) won't be updated
> to 0 even though the expected range is successfully copied until the end
> of the folio.  In this case fuse_fill_write_pages() exits prematurelly
> before the request has reached the max_write/max_pages limit.
>
> Fix this by eliminating page offset entirely and use folio offset
> instead.
>
> Fixes: d60a6015e1a2 ("fuse: support large folios for writethrough writes"=
)
> Reviewed-by: Horst Birthelmer <hbirthelmer@ddn.com>
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/fuse/file.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 676fd9856bfbf..3939f90d1b4d2 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1242,7 +1242,6 @@ static ssize_t fuse_fill_write_pages(struct fuse_io=
_args *ia,
>  {
>         struct fuse_args_pages *ap =3D &ia->ap;
>         struct fuse_conn *fc =3D get_fuse_conn(mapping->host);
> -       unsigned offset =3D pos & (PAGE_SIZE - 1);
>         size_t count =3D 0;
>         unsigned int num;
>         int err =3D 0;
> @@ -1269,7 +1268,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io=
_args *ia,
>                 if (mapping_writably_mapped(mapping))
>                         flush_dcache_folio(folio);
>
> -               folio_offset =3D ((index - folio->index) << PAGE_SHIFT) +=
 offset;
> +               folio_offset =3D offset_in_folio(folio, pos);
>                 bytes =3D min(folio_size(folio) - folio_offset, num);
>
>                 tmp =3D copy_folio_from_iter_atomic(folio, folio_offset, =
bytes, ii);
> @@ -1299,9 +1298,6 @@ static ssize_t fuse_fill_write_pages(struct fuse_io=
_args *ia,
>                 count +=3D tmp;
>                 pos +=3D tmp;
>                 num -=3D tmp;
> -               offset +=3D tmp;
> -               if (offset =3D=3D folio_size(folio))
> -                       offset =3D 0;
>
>                 /* If we copied full folio, mark it uptodate */
>                 if (tmp =3D=3D folio_size(folio))
> @@ -1313,7 +1309,9 @@ static ssize_t fuse_fill_write_pages(struct fuse_io=
_args *ia,
>                         ia->write.folio_locked =3D true;
>                         break;
>                 }
> -               if (!fc->big_writes || offset !=3D 0)
> +               if (!fc->big_writes)
> +                       break;
> +               if (folio_offset + tmp !=3D folio_size(folio))
>                         break;
>         }
>
> --
> 2.53.0
>
>
>

