Return-Path: <stable+bounces-132236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3C3A85E3A
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 15:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614B516AD07
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 13:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B8225634;
	Fri, 11 Apr 2025 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jP//FU+k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E3E2367C0
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744376727; cv=none; b=L/qNLJsg669Ind0miHr2j2hfAfBFySmZZ0aNhrkWzvAG9QwOn60u+T2hh++PIuXd5/2+ZjGQs/k0T6oOSSS+CrPjBfiar2t8PIwl5Xgg/nACFyveAuO3nCLZPgIx6CDLUIwNQnJnyO4q0pWhnBqSu1z5wvcroVFS0EtrxdT8E9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744376727; c=relaxed/simple;
	bh=YWjhd/yLHGH4+sWhwxj4FmwcxtU/4s2RxWdP1PKBYRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqeLtvYsg6DU/hBQaqf52K927n8B4yi8kxFfDiLFhiq7aN7DQIiCGtfvZPs5cW411MZjVMm/9UzA8Pp5Ov30Vhv/uefQWDWGFwDdpU1dBV+35gs+eOzGuO+RwWn2qu3NSLYaBDK3fqetpLWZVk6k29eoWe1XHaUCTB92iIHuoIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jP//FU+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90293C4CEE7
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 13:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744376726;
	bh=YWjhd/yLHGH4+sWhwxj4FmwcxtU/4s2RxWdP1PKBYRo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jP//FU+kTAlhccQRxVKbZkOSW8PN/VAvUXdDFCUqx18wt20IVEoDqj/GjkUiUNYJm
	 KzFEFP9gUgKi1E3iOU9dlLmggRZaqYKKYAoX9SIkfe3BsXN2mcVKqeLxohALjBdGMD
	 TrN0dWDvHkzAw/gT1sZmQt68B2oVaaSDfgyKVWdvmJNwXW4EExMDQQ/eWLej+jo4be
	 T/H157sfu4exjeTQEAz0wUK86DOh4mq9/T5AopklkJaGx/tDSC65r9yXIVm5tMAgw7
	 ZKi75ES9Awns5PCmzE04+OGfcRR0VkwrlatB7f2mmuC6UjIQwX9i1sFlIR4b+mS6V9
	 ysEFOj4y8RNmQ==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so3048618a12.3
        for <stable@vger.kernel.org>; Fri, 11 Apr 2025 06:05:26 -0700 (PDT)
X-Gm-Message-State: AOJu0Yytgz/E6QG+2MD7VwC5ByCn8840c7SlUtS7R160UJS1HkxsQ1aH
	kQm1sZ9RMggUHerGCZwe+ZrrnbFb+ZfOgoybTmnX18q2YOVNDOLBFNyQJLEBUCJ0wQs2sHZnurS
	v9TFwHmwnXpj1LCxwgImyY02GpQ==
X-Google-Smtp-Source: AGHT+IE+Is7fOEMCISd5U0MI1JKvNY9uUUYtllu40xOobcXVSGtpRQMvH3NpjhZXc6BXfF/lZta6pKVjWWVB77+dOpQ=
X-Received: by 2002:a05:6402:3506:b0:5f0:9eb3:8e71 with SMTP id
 4fb4d7f45d1cf-5f37015b989mr2191734a12.27.1744376725075; Fri, 11 Apr 2025
 06:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410035543.1518500-1-anshuman.khandual@arm.com>
 <20250410035543.1518500-2-anshuman.khandual@arm.com> <CAL_JsqKNf5JOWDocjOqmKTi0DMzn1Q_=er1W9JNFuya6Awpikg@mail.gmail.com>
 <f9c54759-6e4e-4c00-8c68-ea73c8fe1fa5@arm.com> <CAL_JsqKuxfMbg0U+hBosG-kA_D1+NN8JpBkOebDYAjccV6B6bg@mail.gmail.com>
In-Reply-To: <CAL_JsqKuxfMbg0U+hBosG-kA_D1+NN8JpBkOebDYAjccV6B6bg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 11 Apr 2025 08:05:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKqkNXrMWNCD7zgTaS8XhzK5us-i83+7TjY0E88_vn-6Q@mail.gmail.com>
X-Gm-Features: ATxdqUEkgv4AyP-KMKbmrY8qzqYraay5ud4IflLUu55Bh4v74YtSlOlyd8Ntq3c
Message-ID: <CAL_JsqKqkNXrMWNCD7zgTaS8XhzK5us-i83+7TjY0E88_vn-6Q@mail.gmail.com>
Subject: Re: [PATCH 6.12.y 1/8] perf/arm_pmuv3: Add PMUv3.9 per counter EL0
 access control
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 8:03=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Thu, Apr 10, 2025 at 11:24=E2=80=AFPM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
> >
> >
> >
> > On 4/10/25 22:20, Rob Herring wrote:
> > > On Wed, Apr 9, 2025 at 10:55=E2=80=AFPM Anshuman Khandual
> > > <anshuman.khandual@arm.com> wrote:
> > >>
> > >> From: "Rob Herring (Arm)" <robh@kernel.org>
> > >>
> > >> Armv8.9/9.4 PMUv3.9 adds per counter EL0 access controls. Per counte=
r
> > >> access is enabled with the UEN bit in PMUSERENR_EL1 register. Indivi=
dual
> > >> counters are enabled/disabled in the PMUACR_EL1 register. When UEN i=
s
> > >> set, the CR/ER bits control EL0 write access and must be set to disa=
ble
> > >> write access.
> > >>
> > >> With the access controls, the clearing of unused counters can be
> > >> skipped.
> > >>
> > >> KVM also configures PMUSERENR_EL1 in order to trap to EL2. UEN does =
not
> > >> need to be set for it since only PMUv3.5 is exposed to guests.
> > >>
> > >> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > >> Link: https://lore.kernel.org/r/20241002184326.1105499-1-robh@kernel=
.org
> > >> Signed-off-by: Will Deacon <will@kernel.org>
> > >> [cherry picked from commit 0bbff9ed81654d5f06bfca484681756ee407f924]
> > >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > >
> > > This one doesn't belong in 6.12. It's a feature that landed in 6.13.
> > > It's only the fixed instruction counter support that landed in 6.12.
> >
> > Are you suggesting that this patch is not required for 6.12.y backport =
?
>
> Yes.
>
> > We need this commit for ID_AA64DFR0_EL1_PMUVer_V3P9 definition. Should
> > this change be added in the last commit itself in the series instead ?
>
> Ah, that's unfortunate. I suppose adding the hunk to the last commit
> is the easiest. Not sure what the preference would be here.

You could also change the comparison from <3.9 to <=3D3.8 and avoid
needing the definition.

Rob

