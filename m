Return-Path: <stable+bounces-104364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD08E9F341B
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 16:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15249166F70
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B8D13B2A4;
	Mon, 16 Dec 2024 15:11:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE98C1304AB;
	Mon, 16 Dec 2024 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361916; cv=none; b=dKiawCVcK21FaH9ewWrQt+RuFcW2XC3io70aoVxcK47W7Wrkq5/bM8A0CF3GxhbUHCSsGpetHezxRcIqmUGzx7A91qrfH1Wo1i6zIG/4DCNwdgO+WXeQv3vbCs7GAptWtOQqkoJjVNSjhccibzA61tNio1aukiSzlHYrErZ/Xnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361916; c=relaxed/simple;
	bh=Jx6QYS2SEDaeGnvm5m97QyzoPEnFg9TIsVRBCdljucg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NE81+fnVPUcF1a6NXRabPF249dUSHCTbTiVKDSZz/WiTqS1rhonkd9SS2rjBddiUZL27Uql1htL6gAtLZCGzIGNdTyjkk98aR98JNp9LCxMYC6iyfdnJP0ediSc6q57IzctNCH6eR4ge5dlmXwxZ6RHqoeFfYNdzD5TX2KFBx4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A9CB113E;
	Mon, 16 Dec 2024 07:12:21 -0800 (PST)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C4613F528;
	Mon, 16 Dec 2024 07:11:52 -0800 (PST)
Date: Mon, 16 Dec 2024 15:11:46 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Peter Collingbourne <pcc@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/sme: Move storage of reg_smidr to
 __cpuinfo_store_cpu()
Message-ID: <Z2BDMpPYRFfio8lr@J2N7QTR9R3.cambridge.arm.com>
References: <20241214-arm64-fix-boot-cpu-smidr-v1-1-0745c40772dd@kernel.org>
 <87a5cysfci.wl-maz@kernel.org>
 <709a0e75-0d0c-4bff-b9fd-3bbb55c97bd5@sirena.org.uk>
 <Z2Agntn52mY5bSTp@J2N7QTR9R3>
 <855dbb91-db37-4178-bd0b-511994d3aef7@sirena.org.uk>
 <Z2A502_EpqvLYN8g@J2N7QTR9R3.cambridge.arm.com>
 <864j33sn60.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <864j33sn60.wl-maz@kernel.org>

On Mon, Dec 16, 2024 at 02:44:07PM +0000, Marc Zyngier wrote:
> On Mon, 16 Dec 2024 14:31:47 +0000,
> Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > On Mon, Dec 16, 2024 at 01:23:55PM +0000, Mark Brown wrote:
> > > On Mon, Dec 16, 2024 at 12:44:14PM +0000, Mark Rutland wrote:
> > > 
> > > > ... didn't matter either way, and using '&boot_cpu_data' was intended to
> > > > make it clear that the features were based on the boot CPU's info, even
> > > > if you just grepped for that and didn't see the surrounding context.
> > > 
> > > Right, that was my best guess as to what was supposed to be going on
> > > but it wasn't super clear.  The code could use some more comments.
> > > 
> > > > I think the real fix here is to move the reading back into
> > > > __cpuinfo_store_cpu(), but to have an explicit check that SME has been
> > > > disabled on the commandline, with a comment explaining that this is a
> > > > bodge for broken FW which traps the SME ID regs.
> > > 
> > > That should be doable.
> > > 
> > > There's a few other similar ID registers (eg, we already read GMID_EL1
> > > and MPAMIDR_EL1) make me a bit nervous that we might need to generalise
> > > it a bit, but we can deal with that if it comes up.  Even for SME the
> > > disable was added speculatively, the factors that made this come up for
> > > SVE are less likely to be an issue with SME.
> > 
> > FWIW, I had a quick go (with only the SME case), and I think the shape
> > that we want is roughly as below, which I think is easy to generalise to
> > those other cases.
> > 
> > MarcZ, thoughts?
> > 
> > Mark.

[... dodgy patch was here ...]

> I don't think blindly applying the override at this stage is a good
> thing. Specially not the whole register, and definitely not
> non-disabling values.
> 
> It needs to be done on a per feature basis, and only to disable
> things.
> 
> See the hack I posted for the things I think need checking.

Understood; sorry for the noise -- we raced when replying and I only
spotted your reply after sending this. I think I'm more in favour of the
revert option now; I've repled with more details at:

  https://lore.kernel.org/linux-arm-kernel/Z2BCI61c9QWG7mMB@J2N7QTR9R3.cambridge.arm.com/T/#m8d6ace8d6201591ca72d51cf14c4a605e7d98a88

Mark.

