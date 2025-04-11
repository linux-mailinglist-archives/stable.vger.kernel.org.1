Return-Path: <stable+bounces-132235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B39E5A85E36
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 15:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BAD316EB74
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 13:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41741F507;
	Fri, 11 Apr 2025 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnKC51aU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015AB2367A7
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 13:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744376628; cv=none; b=qDvXcQ5E2WOqp8uZ0C2Uxf7mdyTTvv4sei6KApwiNWFPGIXMjKomZBlw+4irns7K12n8smbr5tfY9EXfsLx/wbrGDajr91B/JUZsGF3Pl3DgLwZhvdyq6mgzaFmtrTIbv4rTEu0MlPO1OwbG2Wl5yUw22CmDV1jdo8lY2Y65/c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744376628; c=relaxed/simple;
	bh=/TYlkGa7AvtfkX2xb5KHnY2Y/I5rKHK2zNprRyc516s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNUYBUVTWjcaa2xZ2Bl/VfOCtTdnc2FzpH20rfO+mUXFZWFWuZQkICTqob/GLkhwqLB+chJNopVI1Ebgg7og3bvBn8RBjTHpdym0WBRgLul6UxXSdG96gFykiw67QzebhWdh8xUYyqZSy1taLxOG9E3vCRzkr4azkrMrU9nQHTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnKC51aU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7018DC4CEE5
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 13:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744376627;
	bh=/TYlkGa7AvtfkX2xb5KHnY2Y/I5rKHK2zNprRyc516s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AnKC51aUGqhJSZEaHzNUTtBI8d4uA6OsFjiNNWfOcjxNgKdFyfsl68my5hJzVHJ17
	 WnDN792VclmIFl/vNAecJ2yIVztleC7nFtdh+vDcNjxFH4JDAl3W5UFSY7euQJup4N
	 Xr3Ym+WNWhp/k8X4PgQFXsiI2EDLvXSOLdn0+lXAAkGkx9sYizFxG3q1iI1Zv6yfvY
	 y8OkSDmFkC06g/ZwKva5a48urBiRyo3+gpBAKl7MgmEaqKbnNdtmlY0klBIfHasBhs
	 6wN67cygDPdkZ3OTok4ikJ5gEOlIfweeK+b1FfcNKctC/LXDwKV5wL3vP4KIyh8pgo
	 2ieI9QYyWRCXw==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5eb92df4fcbso3517236a12.0
        for <stable@vger.kernel.org>; Fri, 11 Apr 2025 06:03:47 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxeq2YH3Q6bqpChIDFnKZR5Iq5dUzvWsuFtiVMIxL98oIbmle/K
	0MLzDIzmA6GApA7NSxOrldzjUyvMMR5KT78IEZ96jrqz8XIQG4TnyCTPXF0pgHBARKRyy6jsYt2
	vR6VUA2celvJ4v3vZ6OtcO8VQ4g==
X-Google-Smtp-Source: AGHT+IHogboNkxdIIEIS8kbhL3c0Y+7SolbdF4zAp+lDw0JS1pdOAjIx0wzf0HvAYMrjSUMMUGgtCvICr8ox2q8/x1Q=
X-Received: by 2002:a05:6402:1ec8:b0:5f2:f29c:b98c with SMTP id
 4fb4d7f45d1cf-5f36ff0e4c8mr1957508a12.32.1744376625951; Fri, 11 Apr 2025
 06:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410035543.1518500-1-anshuman.khandual@arm.com>
 <20250410035543.1518500-2-anshuman.khandual@arm.com> <CAL_JsqKNf5JOWDocjOqmKTi0DMzn1Q_=er1W9JNFuya6Awpikg@mail.gmail.com>
 <f9c54759-6e4e-4c00-8c68-ea73c8fe1fa5@arm.com>
In-Reply-To: <f9c54759-6e4e-4c00-8c68-ea73c8fe1fa5@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 11 Apr 2025 08:03:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKuxfMbg0U+hBosG-kA_D1+NN8JpBkOebDYAjccV6B6bg@mail.gmail.com>
X-Gm-Features: ATxdqUFMg4PoRNMHyix09HWL7xmAxFX2rZ_4Gtbd8WOPEh3Ra9FU9kwLY1uQCJs
Message-ID: <CAL_JsqKuxfMbg0U+hBosG-kA_D1+NN8JpBkOebDYAjccV6B6bg@mail.gmail.com>
Subject: Re: [PATCH 6.12.y 1/8] perf/arm_pmuv3: Add PMUv3.9 per counter EL0
 access control
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 11:24=E2=80=AFPM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 4/10/25 22:20, Rob Herring wrote:
> > On Wed, Apr 9, 2025 at 10:55=E2=80=AFPM Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> >>
> >> From: "Rob Herring (Arm)" <robh@kernel.org>
> >>
> >> Armv8.9/9.4 PMUv3.9 adds per counter EL0 access controls. Per counter
> >> access is enabled with the UEN bit in PMUSERENR_EL1 register. Individu=
al
> >> counters are enabled/disabled in the PMUACR_EL1 register. When UEN is
> >> set, the CR/ER bits control EL0 write access and must be set to disabl=
e
> >> write access.
> >>
> >> With the access controls, the clearing of unused counters can be
> >> skipped.
> >>
> >> KVM also configures PMUSERENR_EL1 in order to trap to EL2. UEN does no=
t
> >> need to be set for it since only PMUv3.5 is exposed to guests.
> >>
> >> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> >> Link: https://lore.kernel.org/r/20241002184326.1105499-1-robh@kernel.o=
rg
> >> Signed-off-by: Will Deacon <will@kernel.org>
> >> [cherry picked from commit 0bbff9ed81654d5f06bfca484681756ee407f924]
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >
> > This one doesn't belong in 6.12. It's a feature that landed in 6.13.
> > It's only the fixed instruction counter support that landed in 6.12.
>
> Are you suggesting that this patch is not required for 6.12.y backport ?

Yes.

> We need this commit for ID_AA64DFR0_EL1_PMUVer_V3P9 definition. Should
> this change be added in the last commit itself in the series instead ?

Ah, that's unfortunate. I suppose adding the hunk to the last commit
is the easiest. Not sure what the preference would be here.

Rob

