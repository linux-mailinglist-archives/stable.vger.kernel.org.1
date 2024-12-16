Return-Path: <stable+bounces-104338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F8C9F30C2
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 13:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDC6188438E
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 12:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45715204C3A;
	Mon, 16 Dec 2024 12:44:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6781B2194;
	Mon, 16 Dec 2024 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734353062; cv=none; b=SIUV4aiu/S3ClIW4ksICG3yMU3Uj3wwY5h59BpIZPX2nm3C5tE7BDnl94wFGBYMRcpKa+GSnknx0raeXQnyfdg/o9sZoDo23/et9ncQbU3+lxzx1oN6rVJN2aLL3xyMKpK4GQ9ByFHwWcmyStaKxlBG4oB5fspDywF6paZk/ykg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734353062; c=relaxed/simple;
	bh=mdyk0+RTCkImQZ5q/Ftw31UReT/oCA3ZYluQFsHcnfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+mMbsxXNwLMJ2NusIGkquY3XSgp9ISAO7EpxcWWHIYQ+cbBk+3BlwPx1BP9d7kjc/4t0xNPVYU17E4jHVwIJiEUGuDmStix98u8txnOBIMLYrdNd9v6RrL4YIIObzjuP33Ti5P3IJQneCZSkJzxltm3PCo+i/vOkxfR0T/X+9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFC18113E;
	Mon, 16 Dec 2024 04:44:46 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D5163F58B;
	Mon, 16 Dec 2024 04:44:16 -0800 (PST)
Date: Mon, 16 Dec 2024 12:44:14 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Peter Collingbourne <pcc@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/sme: Move storage of reg_smidr to
 __cpuinfo_store_cpu()
Message-ID: <Z2Agntn52mY5bSTp@J2N7QTR9R3>
References: <20241214-arm64-fix-boot-cpu-smidr-v1-1-0745c40772dd@kernel.org>
 <87a5cysfci.wl-maz@kernel.org>
 <709a0e75-0d0c-4bff-b9fd-3bbb55c97bd5@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <709a0e75-0d0c-4bff-b9fd-3bbb55c97bd5@sirena.org.uk>

On Mon, Dec 16, 2024 at 12:17:54PM +0000, Mark Brown wrote:
> On Sat, Dec 14, 2024 at 10:56:13AM +0000, Marc Zyngier wrote:
> 
> > I don't understand the need to single out SMIDR_EL1. It seems to only
> > make things even more fragile than they already are by adding more
> > synchronisation phases.
> 
> > Why isn't the following a good enough fix? It makes it plain that
> > boot_cpu_data is only a copy of CPU0's initial boot state.
> 
> That would work but it's not clear to me that that is what the intent is
> here.  The current ordering seemed like a strange enough decision to be
> deliberate, though I couldn't identify the reasoning.

The original intent was that __cpuinfo_store_cpu() read *all* of a CPU's
implemented ID regs, and init_cpu_features() initialised the expected
system features based on the boot CPU's ID regs.

The expectation was that init_cpu_features() would only consume the
register values, and would not alter the cpuinfo_arm64 values, so the
order of:

	boot_cpu_data = *info;
	init_cpu_features(&boot_cpu_data);

... didn't matter either way, and using '&boot_cpu_data' was intended to
make it clear that the features were based on the boot CPU's info, even
if you just grepped for that and didn't see the surrounding context.

I think the real fix here is to move the reading back into
__cpuinfo_store_cpu(), but to have an explicit check that SME has been
disabled on the commandline, with a comment explaining that this is a
bodge for broken FW which traps the SME ID regs.

Mark.

