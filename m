Return-Path: <stable+bounces-235693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFi6EasH2mnbxwgAu9opvQ
	(envelope-from <stable+bounces-235693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 10:34:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B16C33DEFBA
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 10:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 617DF301FCA8
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 08:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A422DF126;
	Sat, 11 Apr 2026 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSF/JNNW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4D11F91D6
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775896486; cv=none; b=revZjVfS5ObpC8cdY1phA5xndZOAuAAzotLuJt2CIEfv72gVh3c+YogSfVUrQ1f72t8KpyXz/TMfDSdTj2J0+B+p1+6IGV4bxXEgP66HZ7/A3zjYKWLGBTmOemeVVlknTt04CeAuXK8IgNAGcI0r/4K2xm3AthlecIW56tpVEZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775896486; c=relaxed/simple;
	bh=DyLwqEKuL5KjE62apaGDYRhTFIbG0PtD0EFlCVYwDYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbLebxDA981PZ9Wu30wTu3/iChV+SKaiYqAO8oWZBpTdNqmSstCEuz5QQYMiZq0HNwq82tYflQFh40XBWitkau1U5AlxoIYyFOSaCcHrrBRmLc+kaNnJJqXCFxG9AHsscssKS2NwPqtrRPT+HDCWNtFcCPG3cFRj05SNNbj7paI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSF/JNNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDC2C4AF0B
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 08:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775896485;
	bh=DyLwqEKuL5KjE62apaGDYRhTFIbG0PtD0EFlCVYwDYI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CSF/JNNWVwUIaY1xWB14OJy6Zk2UQD4MbZgxqg57MgnDkG9l10IgeLnTtnnoAitun
	 DqZ2QisMMxf8NHO1XGqfsu+UNW+06MGObukefV6OIRHrxuNqjLqvsdYUb9iqzjTrmH
	 fzM/4zjGFWIYkZ6YAucJ5GbB5y8mncJ3ONFxb9nL1YRwRY3hX4kEIB4XyazpBybiDX
	 SIm2UoWViqxhypNEF9v2eGOmdwjF1qM24YtuVRLglsSAosKKljLT6E8sJQa2oC/1C2
	 NT6V5efZ4zBuQzVHpxDiKwUujYqLODp1oxjkgTLnr5odB/EGVmroL0abcFrBeNZ0Bi
	 3eEOtEoFYS95w==
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50dedb18ea0so304621cf.3
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 01:34:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFw2OMFDTg6zmRzPCDgB68avN2Gt3Do5iduPU3dPDEwXJJD7bwaM+zHlgAaZ3YHq8jkGP3h+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAM9FzBpIktrEvPz1VOTMcw29BaL9E3ZaJ3rwFG/f8KFgb4rkk
	tE9NyEcc6GxoL87pWWyIA0o+Z9fPAGYjHxPrX9bKFJjqjFecDVzAE3OobWWzOb3vIB+b2Zf/PGB
	4dj+CTlFE+Toizdqjk8RxXBB3FT7P+9A=
X-Received: by 2002:a05:622a:13c9:b0:50d:912c:c2cb with SMTP id
 d75a77b69052e-50dd5cf4e97mr93506381cf.42.1775896485079; Sat, 11 Apr 2026
 01:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411062152.2092967-1-lgs201920130244@gmail.com> <CAGsJ_4wLSLy_vZjGYiJpTEOBXtyTTTVdTr-wW+sKKb5b0S0Bhw@mail.gmail.com>
In-Reply-To: <CAGsJ_4wLSLy_vZjGYiJpTEOBXtyTTTVdTr-wW+sKKb5b0S0Bhw@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Sat, 11 Apr 2026 16:34:33 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xjwA3juUUJyUPgMyYfo7VB1BTejTDyDeQC5=QK+=yTWg@mail.gmail.com>
X-Gm-Features: AQROBzAxFAwPtnvyQ5Fnb7CV7PLVzXzgQ7HWh1trE8tDGJlU8llE8h5X1dE7giE
Message-ID: <CAGsJ_4xjwA3juUUJyUPgMyYfo7VB1BTejTDyDeQC5=QK+=yTWg@mail.gmail.com>
Subject: Re: [PATCH] mm: thp: Fix refcount leak in thpsize_create() error path
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235693-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baohua@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B16C33DEFBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 11, 2026 at 4:32=E2=80=AFPM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Sat, Apr 11, 2026 at 2:22=E2=80=AFPM Guangshuo Li <lgs201920130244@gma=
il.com> wrote:
> >
> > After kobject_init_and_add(), the lifetime of the embedded struct
> > kobject is expected to be managed through the kobject core reference
> > counting.
> >
> > In thpsize_create(), if kobject_init_and_add() fails, thpsize is freed
> > directly with kfree() rather than releasing the kobject reference with
> > kobject_put(). This may leave the reference count of the embedded struc=
t
> > kobject unbalanced, resulting in a refcount leak and potentially leadin=
g
> > to a use-after-free.
> >
> > Fix this by using kobject_put(&thpsize->kobj) in the failure path and
> > letting thpsize_release() handle the final cleanup.
> >
> > Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface=
")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>
> I=E2=80=99m fine with the patch, but could you send a v2 to drop
> the err label, which is no longer used? Alternatively,
> could you rename err_put to err?
>
> @@ -825,9 +825,8 @@ static struct thpsize *thpsize_create(int order,
> struct kobject *parent)
>         }
>
>         return thpsize;
> -err_put:
> -       kobject_put(&thpsize->kobj);
>  err:
> +       kobject_put(&thpsize->kobj);
>         return ERR_PTR(ret);
>  }

Sorry, my mistake=E2=80=94err is still used by kzalloc_obj.

Reviewed-by: Barry Song <baohua@kernel.org>

