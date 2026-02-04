Return-Path: <stable+bounces-214337-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMArCDOKg2lWpAMAu9opvQ
	(envelope-from <stable+bounces-214337-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 19:04:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEA0EB5B4
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 19:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 641F63002FB1
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 18:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58FB41C303;
	Wed,  4 Feb 2026 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cof1xJgr"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642983EDACD
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228003; cv=pass; b=Bm0NKi4AEbxN68mPiiLzRyazmGjYAK1vBzl27+6nR35SF+cYB/pdaBUjHcrOoKzvqTc3K5uWRoGRMdKLrIdRKHYUPwLsDtgAne5RUohZOAMAaOnChgpT+ACVHn3SjVfiPvGveFPAIzEcO+YbSeJy1Kb4ryOcfq0igFPmiTmSpcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228003; c=relaxed/simple;
	bh=nu0prkPow/543fuY/eJ4hWetUCNzFcwZZriZRm+HJ5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jeI4F57YTEUQkjNnP3Cg8SPy9MGO8K19TwvL0ZJq5O+FtX4RK0EFGJFhrCANAI+aVxfX1xi9zpiP0S06Eo/Gtp65tirAsQM404cazbNXhke89eKzEIyZlCQLXxU//3TnP18X3lbCB964fwi7gGGyQP3NHsBBoBQpETGshccA3kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cof1xJgr; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-505d3baf1a7so11611cf.1
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 10:00:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770228002; cv=none;
        d=google.com; s=arc-20240605;
        b=OK6wHNG8xNI7sc7A28zspvxN4jF5SBl2LXHDhulKXz4Le3nQ8inYY2Rzi+35EfBELY
         +0eC0euDGYyKR6wqhs1XVvmEOaOklpFeWzMQfNlLURz8aG0/37NuCr0qGiYjmQblkX06
         McXg+xa4nLL46koBHzh81zRi47qd7f9aVu/thHitJiCr7F59d4guy8x7oHr/ke2vvQkp
         ofV4XOU4vI/FAGEm25D8hB8ZXw1ZNxgikL1jxteP0vsg9Ti32VpOmfni6CbOZGHBFMym
         6s1OapIH2C4s9legwaPAVSSeP4q0mfHbvAoVOkOOGIwZRIRM8REIiF6V0+h9uWpJguvV
         zeYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2p7u2RTqZKan3VXSwW8k5pV/NyWjfQlfJYnBz+zFXKU=;
        fh=sP0BSjztNZ/UOjxUJaa4mMgzlmmqujvgikHOEZtsMiE=;
        b=jHRwRqbyMF+hkxfI7RQBRb5BMXOJ3VqAlTb+Nl4Skvf8DkWY3F7gwsSUvzuhZE21Ps
         khP0fkE4EEU9YMLuQcfDRxkNhJFdg9I2tqGsEe4+kx/kzEyan6oFCJIq9mIFgJacf0TD
         P/B4msuDQ4IdT9EYtQpNRdjpsOR4HrkFLUaGluxNCTSNcJSJljHmOdgh04FdJs10XPzU
         2A9b+EjnG+CcpMQNac3bxyIhDUETNp20m3pyNDzoahMxNj5x1A3SaX0QnBNdrYAl7el4
         +Bd6DB+xU+60sNKkehdKfiT+F0r44R7tLIwYpMNFkVKOZFIT2p3XLm7nfQgFruIWLiOr
         rOjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770228002; x=1770832802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2p7u2RTqZKan3VXSwW8k5pV/NyWjfQlfJYnBz+zFXKU=;
        b=Cof1xJgr5ZBY0gKcyfJYMcEzQyjKp1FzJsAnVuPRBqmIJG6GWaHPsi87Dy+85pRPzb
         gO33eTq1tddY126MfWgWdO/dBSslEQPvSY4BLBfmyAjOvYZiVUBZsq7TMEKMEY2fA/Up
         ug8HP0vBUJYiS+Qk5scLTMgA+Xq0ryPPq4Qarsh9An9WHC1vbeInYM4LPFcHTwGcIxde
         qV3RELnyQZrHqbwBg8dFoJTKcZA5chL9nZ8abxYXXAJ/CFs8E+A4Pb+xu5OlrSh5mpkW
         5s7z82V1kYfDvu8VgLxdlGQ/1H0SW603o068oO96tn/fxcpxH5r4JwUtp9XDHoUFcIIs
         KOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770228002; x=1770832802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2p7u2RTqZKan3VXSwW8k5pV/NyWjfQlfJYnBz+zFXKU=;
        b=hRiegHkd7DIExz+sX5k2qjIvP0CgLZ3qs4F3TYdNj9HX50IZwu7MxH/aT8EHq2Cp1Z
         iD2FuvWdKqw0mvEBFq4O6N4PSo50gkUMjkci5DtQwC9qJBBZaNXGvPHXhV+Kj5a6Nkm+
         vYV6Ty3dI3k/n9eYwwd9Sz4Kkbis9wS12FXW0PJco7iO4Hq64Fzb5Cc+VbOUMBKpCF+c
         Ts/SMykVUYGc6iLHPuZE71UApQZFjIGFYa7gI8zWZeFRVCSMqHer1th3x3D62HttXEe4
         Wpe/41nQCOTRX72fFSNdxZxMKtlmPwoQoMkNXC11UspjD9hsvr8EuNeHyX67asiHbbxB
         vpPw==
X-Forwarded-Encrypted: i=1; AJvYcCX8BbcjJ8RGyVfmKMapYynCffZpvyOhfvTJ7JyHgUV9s4Y0U3sWqsSJ2sF1QTbWYEb7+LwuJY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR8jFqRTvkiONkH/s/ZZctMnLoO7MIz3bpcJzf1efC0tqiM9Z7
	+rYyoK9b5lVIWfl0bW1Ns5oPxAukGI49WOlyrMpqWsfGdNKJdrMOCUoVnOg7tB1d8E2ziBVfsp7
	i1O127WlsAFYdzRNluJnsqV8RfDd+SDiPukkPYDmT
X-Gm-Gg: AZuq6aIf73YCao+JeOMu9oIJxMI4oeUe56Xme7cwaRkGsnpLygFU64qH9GYAbKSqjuP
	sItrvY9mjjh3tuTc+xwIsadbxrQkWX1+uDqifom7RhlmAUohhdDZ8+11zMgKvUwug7lt8+JmjAd
	4Muj5rZYhCFoE2c7OF/pOLE6gfM0ktNvAGJ8Lgdb6KAdlpgWE/iD/ds7nwTyDMfRh1HE+DSydeU
	wYYPlOZhweFnflgm4iqdLLDNhqQLlYyZbQarO7gD8pIugzbyLO/1fdSKzbppJWdVNeafiQ=
X-Received: by 2002:a05:622a:50b:b0:4fb:e3b0:aae6 with SMTP id
 d75a77b69052e-5061d42d42cmr13353261cf.1.1770228001335; Wed, 04 Feb 2026
 10:00:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026020303-drippy-appliance-a74c@gregkh> <20260204002654.1462558-1-sashal@kernel.org>
 <2026020419-extortion-swinging-6394@gregkh> <CAJuCfpHGM0apXNe4nW_5vTNzEBLGvEHduoiHpHhs70+qmeFMLg@mail.gmail.com>
 <2026020427-germinate-pastor-aa8f@gregkh> <aYOIYOFoId9kY2Uh@laps>
In-Reply-To: <aYOIYOFoId9kY2Uh@laps>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 4 Feb 2026 09:59:48 -0800
X-Gm-Features: AZwV_QiA2HRy4WPKGacRX8ejQixat4dkO3sz_nYTwuIk75Q_FYcIOCzULMM6TdI
Message-ID: <CAJuCfpHx8H6Lp2zQjsMno-_2bwnC-Ea0Kyqhff511w5OrbZmtg@mail.gmail.com>
Subject: Re: [PATCH 6.18.y] kho: init alloc tags when restoring pages from
 reserved memory
To: Sasha Levin <sashal@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	Ran Xiaokai <ran.xiaokai@zte.com.cn>, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214337-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[soleen.com:email,mail.gmail.com:mid,zte.com.cn:email,linux.dev:email,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: 4FEA0EB5B4
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 9:56=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> On Wed, Feb 04, 2026 at 06:06:16PM +0100, Greg KH wrote:
> >On Wed, Feb 04, 2026 at 08:46:35AM -0800, Suren Baghdasaryan wrote:
> >> On Wed, Feb 4, 2026 at 1:59=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> >> >
> >> > On Tue, Feb 03, 2026 at 07:26:54PM -0500, Sasha Levin wrote:
> >> > > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >> > >
> >> > > [ Upstream commit e86436ad0ad2a9aaf88802d69b68f02cbd1f04a9 ]
> >> > >
> >> > > Memblock pages (including reserved memory) should have their alloc=
ation
> >> > > tags initialized to CODETAG_EMPTY via clear_page_tag_ref() before =
being
> >> > > released to the page allocator.  When kho restores pages through
> >> > > kho_restore_page(), missing this call causes mismatched
> >> > > allocation/deallocation tracking and below warning message:
> >> > >
> >> > > alloc_tag was not set
> >> > > WARNING: include/linux/alloc_tag.h:164 at ___free_pages+0xb8/0x260=
, CPU#1: swapper/0/1
> >> > > RIP: 0010:___free_pages+0xb8/0x260
> >> > >  kho_restore_vmalloc+0x187/0x2e0
> >> > >  kho_test_init+0x3c4/0xa30
> >> > >  do_one_initcall+0x62/0x2b0
> >> > >  kernel_init_freeable+0x25b/0x480
> >> > >  kernel_init+0x1a/0x1c0
> >> > >  ret_from_fork+0x2d1/0x360
> >> > >
> >> > > Add missing clear_page_tag_ref() annotation in kho_restore_page() =
to
> >> > > fix this.
> >> > >
> >> > > Link: https://lkml.kernel.org/r/20260122132740.176468-1-ranxiaokai=
627@163.com
> >> > > Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preserv=
ation")
> >> > > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >> > > Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> >> > > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> >> > > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >> > > Cc: Alexander Graf <graf@amazon.com>
> >> > > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> >> > > Cc: Suren Baghdasaryan <surenb@google.com>
> >> > > Cc: <stable@vger.kernel.org>
> >> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> >> > > ---
> >> > >  kernel/kexec_handover.c | 8 ++++++++
> >> > >  1 file changed, 8 insertions(+)
> >> > >
> >> > > diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> >> > > index 03d12e27189fc..db08c1a2e1f80 100644
> >> > > --- a/kernel/kexec_handover.c
> >> > > +++ b/kernel/kexec_handover.c
> >> > > @@ -260,6 +260,14 @@ static struct page *kho_restore_page(phys_add=
r_t phys)
> >> > >       if (info.order > 0)
> >> > >               prep_compound_page(page, info.order);
> >> > >
> >> > > +     /* Always mark headpage's codetag as empty to avoid accounti=
ng mismatch */
> >> > > +     clear_page_tag_ref(page);
> >> > > +     if (!is_folio) {
> >> > > +             /* Also do that for the non-compound tail pages */
> >> > > +             for (unsigned int i =3D 1; i < nr_pages; i++)
> >> > > +                     clear_page_tag_ref(page + i);
> >> > > +     }
> >> > > +
> >> >
> >> > Breaks the build :(
> >>
> >> Which config? I built both defconfig and CONFIG_MEM_ALLOC_PROFILING=3D=
y,
> >> they didn't fail. Could you please send me your failing config?
> >
> >is_folio is not defined in this function, how are you even building this
> >file?
>
> This is a stupid issue I've hit last time too: allmodconfig sets
> CONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dy which disables KHO.

Yeah, that's what hit me too. The file is not complied with defconfigs.

>
> I'll figure out a patch that still builds KHO if CONFIG_COMPILE_TEST is s=
et,
> unless someone beats be to it...
>
> --
> Thanks,
> Sasha

