Return-Path: <stable+bounces-192135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F14C29CBB
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 02:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC583AF903
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 01:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38BD27B341;
	Mon,  3 Nov 2025 01:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fcAPA2Pt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602F027A91F;
	Mon,  3 Nov 2025 01:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134092; cv=none; b=dYoH8pISWTPnNeagZbDIS2NA3PwRNV13qC6LnheE/FpQedKkuQ0D9A1fa7ufqjH8eQQtFCqIRmm8j8sWR4UlJvnFDLDNVa9Td30FFmZvKkZoTEi/QOx+NXXpebVShiHcWpAL58FUQCa6UD7TRLQBHPoCMGf/PZC2aYnHMSZKnoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134092; c=relaxed/simple;
	bh=TvTMLqLHXgFzDqChHE1XhzmqVdyZgm1nslxo4aqMoaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiEKIRewCDznr/TBNViYJM/tsu3PLaMTbHkQ7HTbfth3RGdI0Akch7ugu4pr3MqosXGKW+SeIpdo0CR2JzNG+XNP6Fw54AJpxs2/nTqO9UhDkWMu8PIHdujTubjVEWXRzIAo6IOD+/9EymWu50ephUYW5zhRdNCxxH4vKB7IKRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fcAPA2Pt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D77C116C6;
	Mon,  3 Nov 2025 01:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762134092;
	bh=TvTMLqLHXgFzDqChHE1XhzmqVdyZgm1nslxo4aqMoaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fcAPA2PtpeGb9EF9XogatXVegtU7Da7wcaAb1BeQprbSJrI4OwnL3vqbmR6REzeGf
	 QNkTmMmQbOscycpi6Ojw4f+aC9Cf1JL9g5TXcHio6jUkmNwCsdgIwmHdLnZ9mrLuCY
	 /Pdd6f0ka6EkWTRwWolNPiy6pHuKhoEv2lh1Rd4o=
Date: Mon, 3 Nov 2025 10:41:14 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	MPTCP Upstream <mptcp@lists.linux.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5.15.y 2/3] arch: back to -std=gnu89 in < v5.18
Message-ID: <2025110343-unbiased-hydration-f828@gregkh>
References: <20251017-v5-15-gcc-15-v1-0-da6c065049d7@kernel.org>
 <20251017-v5-15-gcc-15-v1-2-da6c065049d7@kernel.org>
 <2025102015-alongside-kiwi-6f75@gregkh>
 <a23607ec-e1a2-45b6-bc80-01deec03d6f0@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a23607ec-e1a2-45b6-bc80-01deec03d6f0@kernel.org>

On Mon, Oct 20, 2025 at 05:58:12PM +0200, Matthieu Baerts wrote:
> Hi Greg,
> 
> On 20/10/2025 15:30, Greg Kroah-Hartman wrote:
> > On Fri, Oct 17, 2025 at 06:24:01PM +0200, Matthieu Baerts (NGI0) wrote:
> >> Recent fixes have been backported to < v5.18 to fix build issues with
> >> GCC 5.15. They all force -std=gnu11 in the CFLAGS, "because [the kernel]
> >> requests the gnu11 standard via '-std=' in the main Makefile".
> >>
> >> This is true for >= 5.18 versions, but not before. This switch to
> >> -std=gnu11 has been done in commit e8c07082a810 ("Kbuild: move to
> >> -std=gnu11").
> >>
> >> For a question of uniformity, force -std=gnu89, similar to what is done
> >> in the main Makefile.
> >>
> >> Note: the fixes tags below refers to upstream commits, but this fix is
> >> only for kernels not having commit e8c07082a810 ("Kbuild: move to
> >> -std=gnu11").
> >>
> >> Fixes: 7cbb015e2d3d ("parisc: fix building with gcc-15")
> >> Fixes: 3b8b80e99376 ("s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS")
> >> Fixes: b3bee1e7c3f2 ("x86/boot: Compile boot code with -std=gnu11 too")
> >> Fixes: ee2ab467bddf ("x86/boot: Use '-std=gnu11' to fix build with GCC 15")
> >> Fixes: 8ba14d9f490a ("efi: libstub: Use '-std=gnu11' to fix build with GCC 15")
> >> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >> ---
> >> Note:
> >>   An alternative is to backport commit e8c07082a810 ("Kbuild: move to
> >>   -std=gnu11"), but I guess we might not want to do that for stable, as
> >>   it might introduce new warnings.
> > 
> > I would rather do that, as that would allow us to make things align up
> > and be easier to support over the next two years that this kernel needs
> > to be alive for.  How much work would that entail?
> 
> Good question. I'm not an expert in this area, but I just did a quick
> test: I backported commit e8c07082a810 ("Kbuild: move to -std=gnu11")
> and its parent commit 4d94f910e79a ("Kbuild: use
> -Wdeclaration-after-statement"). A build with 'make allyesconfig' and
> GCC 5.15 looks OK to me, no warnings.
> 
> But when looking a bit around, I noticed these patches have already been
> suggested to be backported to v5.15 in 2023, but they got removed --
> except the doc update, see patch 3/3 -- because they were causing build
> issues with GCC 8 and 12, see:
> 
>  https://lore.kernel.org/a2fbbaa2-51d2-4a8c-b032-5331e72cd116@linaro.org
> 
> I didn't try to reproduce the issues, but maybe we can re-add them to
> the v5.15 queue, and ask the CIs to test that?
> 
> Note that even if we do that, the first patch will still be needed to
> have GCC 15 support in v5.15.

Ok, 5.15.y and 5.10.y will be alive for a while, so I'll go queue these
up now as odds are, I'll end up hitting this issue myself :)

thanks for the patches!

greg k-h

