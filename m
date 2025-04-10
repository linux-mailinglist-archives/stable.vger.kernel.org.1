Return-Path: <stable+bounces-132178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEE8A84A74
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 18:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F4819E6643
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 16:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FF61EDA33;
	Thu, 10 Apr 2025 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxocWqFw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737901AAA1E
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744303852; cv=none; b=XR/+p/ganmNEyWm3TvDmgY1EYSD7q9Kfq0cYl05ZJkG7mW6X7/r+eGQCn+INdfjTfIEtCw4OxmemGnX9uQfbFf+nuOlCx9WpTfTWr/k46wTL0Sn76Ls+aqB7X5QnkaP1QxcRRWAOXTq+OZkAbVauCis0lBr4bmtCygnQbudgG5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744303852; c=relaxed/simple;
	bh=2Ks6e1LWqByuxtPVbkL/0Dk30tzVBz32L4Hdq5PKfSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+kZTeyCB43DQsYEbVKtwwU5QkdCXkLK0dN0Zoz2I9Hh8SKHfd2stz/YrTvl6jhp/Bw3nllfH4jo7MgyYaHfojSnYfrH4eHQMsErRfXNHyX62lOuxnAIPHwh+3l2MSZMAPeVPspHGFagq6Jveb9LxYfyeRTQK4VHSf5vEzQHvO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxocWqFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CC3C4CEDD
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 16:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744303851;
	bh=2Ks6e1LWqByuxtPVbkL/0Dk30tzVBz32L4Hdq5PKfSA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GxocWqFwIIXfwcpEXEMhfbHDt9OFyvVyogNDe7Lm9ajp1UFm++biVmZ295NgczidS
	 QyAVIr9KWC9B0PabPBBwaUZ0mHVGu9UyQVNukAcLL8ioeUbIJj+VV+7Td9aHQL/dsb
	 V4QFXk4ku5JnJMXAlaON3A2hRAMYc6IaZPx1+sH+BHqQZY0gRQgPft8heuHDjVIIPz
	 Yltdp8HXjRxFBrdWcG1A1/hvEW/pDAfVHOk+SVggVs3ElaK5J/T1MgRtDrdJmufwNg
	 GJ+lhcGJT5AxKMjh8GIG/enwtyWMCAZO7xMiXupMqRVJPVJKjFaGt+u3iSPjlOnRfR
	 3Givi3CWBNqFg==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5f0c8448f99so2157272a12.1
        for <stable@vger.kernel.org>; Thu, 10 Apr 2025 09:50:51 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy8RYVOhT1kgjEC6ozWnGmS8Q8Wgad5m8ZEv/Eyanhcp1R9k/jU
	Ev/V1/KFnOmCx/wLPd8ud47KdlZWT1FTd3o5ImR2kTOqID3eaPr600X4rcjlgmw82+p0mHe/BcX
	FXyljYA8mbwIVpMu53GdmnYINgQ==
X-Google-Smtp-Source: AGHT+IGD3CNuh2LQCf94kIuCI3g/3XcdydDlf05a7bnGw/JRxbZqfmO4CSUVruPPkYlAMvrdfhH6YfCMnXFL49VKpqM=
X-Received: by 2002:a05:6402:27d1:b0:5de:4b81:d3fd with SMTP id
 4fb4d7f45d1cf-5f32926a296mr2952131a12.13.1744303850469; Thu, 10 Apr 2025
 09:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410035543.1518500-1-anshuman.khandual@arm.com> <20250410035543.1518500-2-anshuman.khandual@arm.com>
In-Reply-To: <20250410035543.1518500-2-anshuman.khandual@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 10 Apr 2025 11:50:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKNf5JOWDocjOqmKTi0DMzn1Q_=er1W9JNFuya6Awpikg@mail.gmail.com>
X-Gm-Features: ATxdqUGKQePw9RTUsm0El_hTN0fgKV5bM_yXdVO3GwFUHRHGF71qwtGcXFiUz4Q
Message-ID: <CAL_JsqKNf5JOWDocjOqmKTi0DMzn1Q_=er1W9JNFuya6Awpikg@mail.gmail.com>
Subject: Re: [PATCH 6.12.y 1/8] perf/arm_pmuv3: Add PMUv3.9 per counter EL0
 access control
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 10:55=E2=80=AFPM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> From: "Rob Herring (Arm)" <robh@kernel.org>
>
> Armv8.9/9.4 PMUv3.9 adds per counter EL0 access controls. Per counter
> access is enabled with the UEN bit in PMUSERENR_EL1 register. Individual
> counters are enabled/disabled in the PMUACR_EL1 register. When UEN is
> set, the CR/ER bits control EL0 write access and must be set to disable
> write access.
>
> With the access controls, the clearing of unused counters can be
> skipped.
>
> KVM also configures PMUSERENR_EL1 in order to trap to EL2. UEN does not
> need to be set for it since only PMUv3.5 is exposed to guests.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> Link: https://lore.kernel.org/r/20241002184326.1105499-1-robh@kernel.org
> Signed-off-by: Will Deacon <will@kernel.org>
> [cherry picked from commit 0bbff9ed81654d5f06bfca484681756ee407f924]
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

This one doesn't belong in 6.12. It's a feature that landed in 6.13.
It's only the fixed instruction counter support that landed in 6.12.

Rob

