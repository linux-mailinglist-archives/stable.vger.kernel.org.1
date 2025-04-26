Return-Path: <stable+bounces-136745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D72A9DA6B
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 13:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB62F1BA032E
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 11:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2CB22A4D6;
	Sat, 26 Apr 2025 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ad7utoXy"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E75018FC92;
	Sat, 26 Apr 2025 11:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745666824; cv=none; b=PSI5sj8k9Oc/IJyzOq38+XaWQh2u7I7r300YxBhwBECMI0EQRMN5D0qAcA2g80o03/uh3WbcGR4+hq3enbuc20eyOH/DUAZ96SeczCh+u86fGbbzBBEyEJFZQVNxPK4zv1P3uA14mFkB0oful5JMDNETSKHPHnffZL6NA7jBTJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745666824; c=relaxed/simple;
	bh=oJvZyHm9yMSBIZeECglMbRhknnnZNzZ2Q25zBIYwsZo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=kn7LTilS3UTzb9hMAYz+VjO00pRcBSRJkJ3pqf2jvkp1EqbxYdcQ08cpGnW8r9S8BSmI8so4TYoME5UTNlV8BF1f2KiM//BdhxOuuu9HZmgQcWn7OZVs8UV5SPrUXpFMutrUfBYHVJAn7Plf0v5StcB1vp8ThT1P+tKyU5D7GVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ad7utoXy; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8594840E0192;
	Sat, 26 Apr 2025 11:26:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pQwgO5q8JoH2; Sat, 26 Apr 2025 11:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1745666816; bh=Vha8f2BYBVQOB+1w6jUZstPupboHp8JDFknDkTnrCiA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ad7utoXymv/IHEhm7v7WOMD2xdpP8Q1NWWE/NH69lilxB/JlVC2bLiOI/ZHq54Y3A
	 gIEZMW1mRbX7OzFZ+/xi6md3LaxyA/kEZuPaBVuMK+dfsM2tqZHR7orA/i6HwGWUtJ
	 DfpX8K5KQL0BQiZVXqSd3ADlJGH1ZHAYNWO7yS49Mcz8sxy5tf3nylopO0h9ctFTfR
	 q0kyVnt1Q5ssBsMVeCStnHYZGmI19dTDAyAMfj2Df92ayeHtJMfVXZsnE2FFUUjYrb
	 WgE6RrgzUPIyDrQKius4eU8k9F1y89iEOHaMR819DYHhqBMjgl8NOvOQYpmr3NkBuO
	 BWw7DBE61P4WF4lLBqWMYfdqf9vALsI3Qhz+UT1yzY82Az6WJCu0FakFN9u/UhI+Hh
	 Rc0Q47o63X191GgiipRNSuaJePNq9uzr2KIC/M3iFaopq5RFnYMudmSFA2dW7/oSfh
	 6jwQuZGiGcRkQ6/ytdcLTXR2fAw8u5dVwp1wQdswImKZd9zSsKdPpXoqOY0u8FQ+zr
	 EwkwlJ3M14E7+5rj696B9Ig6MhP7lzK9wSmsbrS1JtMZgekT/COzz20YhgXQtRCaX3
	 SYEQocfF5HqQhtJ+tDDTb38p1eOXperzmSRUvM2VdN1+VLjyzfGBHzTcfLTjmXnyJe
	 /eMazoc2MW51BAoYZrAOnGGE=
Received: from [IPv6:::1] (unknown [IPv6:2a02:3037:20b:53e8:6ccf:ad1c:d318:e478])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 82C8840E01DA;
	Sat, 26 Apr 2025 11:26:37 +0000 (UTC)
Date: Sat, 26 Apr 2025 14:26:32 +0300
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
CC: Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Max Grobecker <max@grobecker.info>, Ingo Molnar <mingo@kernel.org>,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, thomas.lendacky@amd.com, perry.yuan@amd.com,
 mario.limonciello@amd.com, riel@surriel.com, mjguzik@gmail.com,
 darwi@linutronix.de, Paolo Bonzini <pbonzini@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_CONFIG=5FX86=5FHYPERVISOR_=28was=3A_Re=3A_=5BPATC?=
 =?US-ASCII?Q?H_AUTOSEL_5=2E10_2/6=5D_x86/cpu=3A_Don=27t_clear_?=
 =?US-ASCII?Q?X86=5FFEATURE=5FLAHF=5FLM_flag_in_init=5Famd=5Fk8=28=29?=
 =?US-ASCII?Q?_on_AMD_when_running_in_a_virtual_machine=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aAwj_Tkqj4GtywDe@google.com>
References: <aAKaf1liTsIA81r_@google.com> <20250418191224.GFaAKkGBnb01tGUVhW@fat_crate.local> <aAfQbiqp_yIV3OOC@google.com> <20250422173355.GDaAfTA8GqnGBfDk7G@renoirsky.local> <aAfynEK3wcfQa1qQ@google.com> <20250423072017.GAaAiUsYzDOdt7cmp2@renoirsky.local> <aAj0ySpCnHf_SX2J@google.com> <20250423184326.GCaAk0zinljkNHa_M7@renoirsky.local> <aAqOmjQ_bNy8NhDh@google.com> <20250424203110.GCaAqfjnr-fogRgnt7@renoirsky.local> <aAwj_Tkqj4GtywDe@google.com>
Message-ID: <71D468BB-CE40-47DC-8E3D-74C336B15045@alien8.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 26, 2025 3:08:29 AM GMT+03:00, Sean Christopherson <seanjc@google=
=2Ecom> wrote:
>The kernel already can enforce policy=2E  Setting host breakpoints on gue=
st code
>is done through a dedicated ioctl(), and access to said ioctl() can be re=
stricted
>through various sandboxing methods, e=2Eg=2E seccomp=2E

Ok, makes sense=2E

>No, that would defeat the purpose of the check=2E  The X86_FEATURE_HYPERV=
ISOR has
>nothing to do with correctness, it's all about performance=2E  Critically=
, it's a
>static check that gets patched at runtime=2E  It's a micro-optimization f=
or bare
>metal to avoid a single cache miss (the __this_cpu_read(cpu_dr7))=2E  Rou=
ting
>through cc_platform_has() would be far, far heavier than calling hw_break=
point_active()=2E

Huh, we care so much about speed here?

--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

