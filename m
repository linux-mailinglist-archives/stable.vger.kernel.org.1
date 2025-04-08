Return-Path: <stable+bounces-131822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81451A813E0
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 19:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62986189C2C8
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 17:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043A1237163;
	Tue,  8 Apr 2025 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrYKoskr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81B723E23F
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744134064; cv=none; b=q6jVn8LAh+cHJcc6YG18JVgMa4YzHbXypKK9gJspmuhMHnp6WdjCcktves06IyNQZTVU9FxOVtuUF/JE6ZzKlltIS526jFTQPQeaQCp5/1Wh+k3jRFBugdQp2kGfAe7KRHfZ77gfpwyy/UgLrLBJqsrzFK+0uY7XucCYGebI21c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744134064; c=relaxed/simple;
	bh=+4bez8Lb/AEdQ+hxGBgDsjgjrMoNldVH1JCIS9ZeLvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6L7FLBEWVXyf7UWPUbakyTCn7Li8+CAxSSTctzHRqjH3w+vTf8Idh4MKdxqb+zaNCtJu2trDtP3/ScDQNIq7igeiTqO4rsVd6GMBVTIdydfrOrA6jHdTmVcEIDWLXQNiWhBIcwgBvABlhP0D82r/zLSL+3WR21EV1Hixo4YKCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrYKoskr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38746C4CEEA
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 17:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744134064;
	bh=+4bez8Lb/AEdQ+hxGBgDsjgjrMoNldVH1JCIS9ZeLvo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DrYKoskrccAe8UHsqvNgsAxB3ODRVwgEYPkjuYER26K2UM+Dqz37zIx712AFT3gyR
	 RX9gikDcNTcInJjJ/BrhDPYYBjHtvm/8o4bxKN3BGQp0be4Gf7hMwlxfVhnWwmKowB
	 gaC/yFxOC0mpon+DpmLuCYpdVZlLrppp3pfVMZmOcXOOV8FslGIux9ZBPjj+xJK4Y3
	 94TeF4MZOov9uzywNMPYIK0IhfLHYAm7M6u4GzpfAELoya+E6SWzKBoKs4HUfDKC+F
	 FuKKj+Jvk+lWyTFag606Phj7oNEpQiQto78CWvIJyMmE5xfM83RrNsWj6OBWz6COaq
	 B9AtXF0AO2PyQ==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5f0c8448f99so8299575a12.1
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 10:41:04 -0700 (PDT)
X-Gm-Message-State: AOJu0YzlqjzkwrZkFQo1ouvpL/RMdBRNBxjUzLNBmuJIk43oip4XpMXT
	F9PErW9FDf4bKWp007RdcZxMVA7wBpuZXTQsFYTEoaRQOK3uKzKsRTXalY3tR2/I9R60rat0KJG
	u4f6G4Lz093BHgrFFD0T6c0YMbQ==
X-Google-Smtp-Source: AGHT+IGxS3cOTDr/7KQG3TrAvkET7Ty0wwZX4R9ONSW7mjDQL80+XJsKTHVdK5SKpjH/vNL/JigCcaRDiS8c0R8UJy8=
X-Received: by 2002:a05:6402:50c6:b0:5ed:13ba:6538 with SMTP id
 4fb4d7f45d1cf-5f0b3b659b3mr14145629a12.6.1744134062857; Tue, 08 Apr 2025
 10:41:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408093859.1205615-1-anshuman.khandual@arm.com>
In-Reply-To: <20250408093859.1205615-1-anshuman.khandual@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 8 Apr 2025 12:40:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKYPgfjaBy848NAkDg7v5t7B-gcrLRrumemVYWThkk5cA@mail.gmail.com>
X-Gm-Features: ATxdqUFa8XdN8j_Xc216gE_DDngQ5LiUpEgwnuAb9LIMW5tkU1SveFM-gPpjenU
Message-ID: <CAL_JsqKYPgfjaBy848NAkDg7v5t7B-gcrLRrumemVYWThkk5cA@mail.gmail.com>
Subject: Re: [PATCH 6.13.y 0/7] arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 4:39=E2=80=AFAM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> This series adds fine grained trap control in EL2 required for FEAT_PMUv3=
p9
> registers like PMICNTR_EL0, PMICFILTR_EL0, and PMUACR_EL1 which are alrea=
dy
> being used in the kernel. This is required to prevent their EL1 access tr=
ap
> into EL2.
>
> The following commits that enabled access into FEAT_PMUv3p9 registers hav=
e
> already been merged upstream from 6.13 onwards.
>
> d8226d8cfbaf ("perf: arm_pmuv3: Add support for Armv9.4 PMU instruction c=
ounter")

This landed in v6.12, not 6.13. As 6.12 is LTS, it needs the backport.

> 0bbff9ed8165 ("perf/arm_pmuv3: Add PMUv3.9 per counter EL0 access control=
")
>
> The sysreg patches in this series are required for the final patch which
> fixes the actual problem.
>
> Anshuman Khandual (7):
>   arm64/sysreg: Update register fields for ID_AA64MMFR0_EL1
>   arm64/sysreg: Add register fields for HDFGRTR2_EL2
>   arm64/sysreg: Add register fields for HDFGWTR2_EL2
>   arm64/sysreg: Add register fields for HFGITR2_EL2
>   arm64/sysreg: Add register fields for HFGRTR2_EL2
>   arm64/sysreg: Add register fields for HFGWTR2_EL2
>   arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
>
>  Documentation/arch/arm64/booting.rst |  22 ++++++
>  arch/arm64/include/asm/el2_setup.h   |  25 +++++++
>  arch/arm64/tools/sysreg              | 103 +++++++++++++++++++++++++++
>  3 files changed, 150 insertions(+)
>
> --
> 2.30.2
>

