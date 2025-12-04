Return-Path: <stable+bounces-200050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA81CA49B1
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 17:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C08830CB02F
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 16:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CDF2F5A1C;
	Thu,  4 Dec 2025 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R7jiWBse"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246E22F360A
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764866509; cv=none; b=dv6bR7D2MaXWoht8bRgstRP4egpaWJOOkYaH5XAvzue7eSRtHs/fmtFRQHIUs8ZUviNTCia/muuDykxEzlXhTz3LwifU/PbM7SUoEuQMHfGOPQ8nsI5sooi7ywJ+jdOf7xeSD1RpRLGumHf1WkY68/PruRezFgNdQIPy6leI4DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764866509; c=relaxed/simple;
	bh=YB1C7DkMSinNdnzH7I3t3ZAHZwfsDDhhtbZkbhvfSNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNdD8VUwK0pQ8xa65skha02YsxQ+/uWCpgJNUn/zH5tIKLxH9hVE8mFgv6kRjE9uy0k002VY9NzM7hWtb66zQT2lf2kZB6bctcWOQ4Ow/F+bGyPLEQMKddOKWiZvp2Rpk7jDAr496P3s21MqqMgzipIf14HJ1AFgY5Ma0JWjU0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R7jiWBse; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29852dafa7dso188375ad.1
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 08:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764866507; x=1765471307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjuSnkBD0IVIOLRTQnrL0682xix69tJWGGO5uidnVxE=;
        b=R7jiWBsetWmeOcAABiO4t3WOvUx2DiAX3AryDgWW8zRlVUD1v6opV6SEeLVYi055mD
         wgQuB+UbecFLDnoagP4GRpZ/UMJGhyviGsQb7sDAV56gZDdxmsQma8q7+5CzGnLvfwBV
         mXV3RBCncDFEbrbNIO/FCPPxegIdGbHc0yFDYBtBGeC0Dw7DT/mX1nVNNmY6L9mb3lTk
         sFTfDarLrp2oJHigUCVXKygBGO4CSQjI8n1H/6bjaIqPPc4VgZ30pif7kUM9xl0oN7/o
         N5PNeHA+5fPqgkliMw6Se69CQ1szX381CfAyBASlEKkkkakNRveJ24NxYKl/2xuVaiEI
         5QNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764866507; x=1765471307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EjuSnkBD0IVIOLRTQnrL0682xix69tJWGGO5uidnVxE=;
        b=CM7R48/spDjBy4IRFo2qlNVx+O1rwllXU67i6mhw+0so02++9xvcRxM8nEeGC/PKnw
         1mZ19pbNlyjJhv8mF0cuNlBRtOt8nh7PcwIKMU0Da+eGZynNFSA33z/EPBrrhxs+E0u6
         HdiGJNxBpuzVZCovr1ms0Pzjma2CH8Bm/2z552VMkP/XyX0c5qtMR7ezo/zvs48dUNkN
         6peojT4vHtdNH2cUxVGKkdkAqgQWPaaiPkooWEa/jh6FQpH0mD+B+ObKk0ndfj5X0Urx
         gC4W2fEUV4MH+sCNS2uO0Bv7h2rXvL/wQSSKCgj2iPEhkvRN1oeBj+6LmQTJHTOrUYUZ
         /5yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY4RY9q6KMiIZHjMDp18OI+1dkwvn5K5WElUrc6fdZ8Pqz9Z08lCuNKERbCWRErYnP7aPHTp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbsA2QXJWRhBnxmvbfda4Y2fRdZBIbrPcU9WaLDRIEVRLTFbkO
	V8YAnPqMKcTwGdWRtTOpXlZvt9TIcjmMEYetV7yt/7jtncbQRttgBtgiveG7VKefqlAPqoJN2JR
	UniTXWu5SzdPZNsTvg8/A7+O79ke+6sqOL01Mc7IC
X-Gm-Gg: ASbGncuNNxfoIo4xt6GK/YcjalRjX/2Bqm8Eas8mmKuWRp0w5bZ/9uLMPO0U6onRMuv
	YJVR78leCloT9Tgkj4cBm/urexhsI8kUuBtx3aD2TLDc52HF9mR9QqKYy9UsAqWLG1MIAxIzomE
	8VQdqt5Brubru98zsxj5iQ48Mx8c/mqHLIdbRCB6MesnoKlwK5BZkWIgHBFX+RTWDXVDHjn9iQt
	p7UTpznqnSnQQ2l+nCCSNj7n/Of8HhXrO5Pj5kbTJZJmasdPOaXOhHKpHsSO0uLftZKPCbE7/iO
	yGwiSlZsm93EdxpashcHrkf9fw==
X-Google-Smtp-Source: AGHT+IGB4VDrYuoPAUMN4jdtPF4MsiTB+YfIIGTM7FDzOCTr5PbhMfbfHwGSSFWdn7xBIbJUGur0zLxxwwAbeW3miIM=
X-Received: by 2002:a17:903:18d:b0:299:c367:9e02 with SMTP id
 d9443c01a7336-29dbf0d1cf3mr662555ad.17.1764866506966; Thu, 04 Dec 2025
 08:41:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203152414.082328008@linuxfoundation.org> <41e4124d-8cb3-44b9-871b-8fa64b54b303@sirena.org.uk>
 <b4d4d33e-07d8-4868-abc5-4161a63bb948@gmail.com> <2025120440-evaporate-crawlers-ac2a@gregkh>
In-Reply-To: <2025120440-evaporate-crawlers-ac2a@gregkh>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 Dec 2025 08:41:35 -0800
X-Gm-Features: AWmQ_bk-K1qeRoUMPQSlwjJdae7gffM_FzBGnzxiSDL13KhmyHwTUpQOp0fU0SU
Message-ID: <CAP-5=fWpMfGHina4t_=wSTRX2V1i1zCyv2dRqve8nYLugsj2Gw@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/392] 5.15.197-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, achill@achill.org, 
	sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 8:38=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 03, 2025 at 10:51:17AM -0800, Florian Fainelli wrote:
> > On 12/3/25 10:46, Mark Brown wrote:
> > > On Wed, Dec 03, 2025 at 04:22:30PM +0100, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 5.15.197 relea=
se.
> > > > There are 392 patches in this series, all will be posted as a respo=
nse
> > > > to this one.  If anyone has any issues with these being applied, pl=
ease
> > > > let me know.
> > >
> > > I'm seeing a build failure in the KVM selftests on arm64 with this, d=
ue
> > > to dddac591bc98 (tools bitmap: Add missing asm-generic/bitsperlong.h
> > > include):
> > >
> > > aarch64-linux-gnu-gcc -Wall -Wstrict-prototypes -Wuninitialized -O2 -=
g -std=3Dgnu9
> > > 9 -fno-stack-protector -fno-PIE -I../../../../tools/include -I../../.=
./../tools/
> > > arch/arm64/include -I../../../../usr/include/ -Iinclude -I. -Iinclude=
/aarch64 -I
> > > ..   -pthread  -no-pie    dirty_log_perf_test.c /build/stage/build-wo=
rk/kselftes
> > > t/kvm/libkvm.a  -o /build/stage/build-work/kselftest/kvm/dirty_log_pe=
rf_test
> > > In file included from ../../../../tools/include/linux/bitmap.h:6,
> > >                   from dirty_log_perf_test.c:15:
> > > ../../../../tools/include/asm-generic/bitsperlong.h:14:2: error: #err=
or Inconsis
> > > tent word size. Check asm/bitsperlong.h
> > >     14 | #error Inconsistent word size. Check asm/bitsperlong.h
> > >        |  ^~~~~
> > > In file included from ../../../../usr/include/asm-generic/int-ll64.h:=
12,
> > >                   from ../../../../usr/include/asm-generic/types.h:7,
> > >                   from ../../../../usr/include/asm/types.h:1,
> > >                   from ../../../../tools/include/linux/bitops.h:5,
> > >                   from ../../../../tools/include/linux/bitmap.h:8:
> > > ../../../../usr/include/asm/bitsperlong.h:20:9: warning: "__BITS_PER_=
LONG" redefined
> > >     20 | #define __BITS_PER_LONG 64
> > >        |         ^~~~~~~~~~~~~~~
> > > In file included from ../../../../tools/include/asm-generic/bitsperlo=
ng.h:5:
> > > ../../../../tools/include/uapi/asm-generic/bitsperlong.h:12:9: note: =
this is the location of the previous definition
> > >     12 | #define __BITS_PER_LONG 32
> > >        |         ^~~~~~~~~~~~~~~
> >
> > Yes this also affects building "perf".
>
> Now dropped, thanks.

Thanks, fwiw I agree dropping is the right fix.

Ian

> greg k-h
>

