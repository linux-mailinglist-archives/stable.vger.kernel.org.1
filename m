Return-Path: <stable+bounces-33948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A93893C40
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29563B21CC9
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 14:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E85943AC2;
	Mon,  1 Apr 2024 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8EVMKlm"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A8410A03
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711982210; cv=none; b=iCYj2UodfU9nJDdCCh0Tfqg9SO3y8e8lf/p4JL4cHHCZJlAJYAkpkXr3OpCxfGnJJzUAqZ/r0BqItMVpCcnFBJrjOEvDOKU5svAYkYntS8OsKjc7ZXPuA0V0/03Z+5zKHyM2/FkEuNftaEPiflF0NQ031vdI+DTuB0hANvgalck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711982210; c=relaxed/simple;
	bh=EEmuc+b2AkAn41DgNIfZqUpWsbsfsG2NOQu7/VnUndE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eiu4B9pllaFVpMZy14JQBUYxNixTFaejYwWmabzHRMHtiC7lJh1k3+OkuktpbMe+vQfky8C3vCC/L0Pd80z4fe2BYN+7wNpzVsTV4CzL6TQ99zTee+G+50StGhTV5G9SSUzAQwaNQR94zys8SBdw1qmiON/DXm1Hhw5uMOssMzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O8EVMKlm; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42ee0c326e8so704291cf.0
        for <stable@vger.kernel.org>; Mon, 01 Apr 2024 07:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711982207; x=1712587007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pODHKe4h1pzV0fTG3f868sZOWbcBvAE1L0zwg0ZSk74=;
        b=O8EVMKlmu614FUhYR10OOX7t+G2oYXnPrwTTFNmThiGv39zBQeXcIEfLpIufoNAyVf
         NpA7J/olKwsE8EJKEyGEStYrTYUivofm66SyPL+70aCFtBKinGXFuDbaYKl/thCJ3PDD
         +/4whubZiGxF49VzTr7tVWp+YEFSj5kJlMzWcK0E8SdW8rlwClrrmGAUpPMgmtrSmmkb
         ng+qQTWCHevNRIqlA7jxyqjHq7vE7D2cwbMY2fQzka2oVkApu3Lqsp8tXDtxMVzW8YfF
         wulQ5+jeDNr/2f9CgwD8dNTgTPZXBYKVvTcKaQMv/zTNW0Eh8MUP/4i6SpAIlFPX/cM4
         l0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711982207; x=1712587007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pODHKe4h1pzV0fTG3f868sZOWbcBvAE1L0zwg0ZSk74=;
        b=mkO2rT+k2+p6zKj6zyV3NW7MTQSGHvk9+ywhGixDzPFkF5mhX9UvdEuMm15cpCrFms
         jlEekZ8Mk79zGHqCVgNShT6fjO81SswQJf2Ce4mUaMOCA7iqRp1D4NcKAI+InOAdqnrd
         WnZSDlxJTKWk84Xyfx/eORBz775tR0x5n613QfkGtahVX2BYy+CGoRcLtBNpUP/wPKuN
         lXonVkFQOHhpQLYkpsTitO/ogHOKYoS+MwZfq7CmLnWbxdZgBmyAgpO482AXb0NDjuMW
         XwTb8kZXsKhph67KKD99gVhARWoiRLES96ANEw+BU2WJCog0g4C7Q6Wv+Y5m12OPfjtf
         WDXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0k1QNrtfvJTkMyrgArzdyouWRwSxv44jQF4DANMM9RfJ+G/v2+STBHoVaqij3nO0UKBimTzaA2gycO2cnNaQ6YT+NBV/E
X-Gm-Message-State: AOJu0YxZVCUXUoqSd/gKNYvdOHxQrzzxthxAHGXB4Z2gqQi2FNkSQQII
	z+uOCbP2i+CziDIwhJ0Z8FhxfdiqNYKFYUOcSzw6gjvdT5XxsQ01EVmuZl3Rph1GJ2U5Oky6GCF
	nJSHT5ohZPwTRPSJLOoUNRwkr8DmJnx+FWZwn
X-Google-Smtp-Source: AGHT+IFIKGtehE7EtnkbuM+FGm+p/vKoFf3BbH+1VMoO4S3HYrVMe4yr936V9dflX6oN4dO9In0k2mzov9SRMoBv+Bg=
X-Received: by 2002:a05:622a:1e08:b0:432:b567:407d with SMTP id
 br8-20020a05622a1e0800b00432b567407dmr739326qtb.6.1711982207211; Mon, 01 Apr
 2024 07:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZgrAM4NjZQWZ2Jq6@archie.me> <2024040143-shrimp-congress-8263@gregkh>
 <ZgrD-XtaG9D8jFnA@archie.me>
In-Reply-To: <ZgrD-XtaG9D8jFnA@archie.me>
From: Greg Thelen <gthelen@google.com>
Date: Mon, 1 Apr 2024 07:36:08 -0700
Message-ID: <CAHH2K0apZttqAhMZ9H_fygUC_Oa9G5-4XYmmqZu-EWNOuqc4Xg@mail.gmail.com>
Subject: Re: Fwd: stable kernels 6.6.23 and 6.1.83 fails to build: error:
 unknown type name 'u32'
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Greg KH <greg@kroah.com>, Viktor Malik <vmalik@redhat.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, ncopa@alpinelinux.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, Linux Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 7:26=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com>=
 wrote:
>
> On Mon, Apr 01, 2024 at 04:15:25PM +0200, Greg KH wrote:
> > On Mon, Apr 01, 2024 at 09:09:55PM +0700, Bagas Sanjaya wrote:
> > > Hi,
> > >
> > > On Bugzilla, ncopa@alpinelinux.org reported resolve_btfids FTBFS regr=
ession
> > > on musl system [1]:
> > >
> > > > The latest releases fails to build with musl libc (Alpine Linux edg=
e and v3.19):
> > > >
> > > > ```
> > > > rm -f -f /home/ncopa/aports/main/linux-lts/src/build-lts.x86_64/too=
ls/bpf/resolve_btfids/libbpf/libbpf.a; ar rcs /home/ncopa/aports/main/linux=
-lts/src/build-lts.x86_64/tool
> > > > s/bpf/resolve_btfids/libbpf/libbpf.a /home/ncopa/aports/main/linux-=
lts/src/build-lts.x86_64/tools/bpf/resolve_btfids/libbpf/staticobjs/libbpf-=
in.o
> > > > In file included from main.c:73:
> > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux=
/btf_ids.h:7:9: error: unknown type name 'u32'
> > > >     7 |         u32 cnt;
> > > >       |         ^~~
> > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux=
/btf_ids.h:8:9: error: unknown type name 'u32'
> > > >     8 |         u32 ids[];
> > > >       |         ^~~
> > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux=
/btf_ids.h:12:9: error: unknown type name 'u32'
> > > >    12 |         u32 cnt;
> > > >       |         ^~~
> > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux=
/btf_ids.h:13:9: error: unknown type name 'u32'
> > > >    13 |         u32 flags;
> > > >       |         ^~~
> > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux=
/btf_ids.h:15:17: error: unknown type name 'u32'
> > > >    15 |                 u32 id;
> > > >       |                 ^~~
> > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux=
/btf_ids.h:16:17: error: unknown type name 'u32'
> > > >    16 |                 u32 flags;
> > > >       |                 ^~~
> > > > /home/ncopa/aports/main/linux-lts/src/linux-6.6/tools/include/linux=
/btf_ids.h:215:8: error: unknown type name 'u32'
> > > >   215 | extern u32 btf_tracing_ids[];
> > > >       |        ^~~
> > > > make[4]: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/tools=
/build/Makefile.build:98: /home/ncopa/aports/main/linux-lts/src/build-lts.x=
86_64/tools/bpf/resolve_btfids
> > > > /main.o] Error 1
> > > > make[4]: *** Waiting for unfinished jobs....
> > > > make[3]: *** [Makefile:83: /home/ncopa/aports/main/linux-lts/src/bu=
ild-lts.x86_64/tools/bpf/resolve_btfids//resolve_btfids-in.o] Error 2
> > > > make[2]: *** [Makefile:76: bpf/resolve_btfids] Error 2
> > > > make[1]: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/Makef=
ile:1354: tools/bpf/resolve_btfids] Error 2
> > > > make: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/Makefile=
:234: __sub-make] Error 2
> > > > ```
> > >
> > > Bisection led to upstream commit 9707ac4fe2f5ba ("tools/resolve_btfid=
s:
> > > Refactor set sorting with types from btf_ids.h") as the culprit.
> > >
> > > See the report on Bugzilla for the full thread and proposed fix.
> >
> > Is the proposed fix a commit to backport?
>
> Nope (see below).
>
> >
> > Digging through entries is not the easiest way to get things resolved..=
.
> >
>
> The reporter posted the fix as bug comment [1] instead (hint: include
> linux/types.h) but not submitted it to mailing lists first.
>
> Thanks.
>
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218647#c2
>
> --
> An old man doll... just what I always wanted! - Clara

Does https://lore.kernel.org/all/20240328110103.28734-1-ncopa@alpinelinux.o=
rg/
resolve this? It's staged in the bpf tree. Though I'm not sure when
it'll be merged upstream.

