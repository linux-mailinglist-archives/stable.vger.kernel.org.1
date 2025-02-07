Return-Path: <stable+bounces-114248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE826A2C36A
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 14:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9D73A8BFD
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 13:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC311E105E;
	Fri,  7 Feb 2025 13:21:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4E89454
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738934515; cv=none; b=PKUGOsFot/SgywEkzBBlpIy+/CTjr0WrHrI4hqr7Qtlx76sy4mwycr4K/8sg7JANrmR89Ube8saRDmz33cxdl5IxlwuozbvOsaMZ8AB788vTaPpqbIjQVpHSQVSqfoVYbtfm2fY3TuIevXmw14c7QFjTOMZrbIbTOq0rQWkE6g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738934515; c=relaxed/simple;
	bh=ifpbEzvaiityzTAih2Bn5/h3XUw1EEdgWa0J+aamdcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpAvjKRr2mXSH0Eq0BoejAhyKOSdnqyUi39ijvkF/SZUNqhT4lDTIqnhtCGQsM00zvI1T8zdXctGDiVBkbhyFmxtOzaSr/Ov8JDa+UPJhc2/6D42D7++Bi2Pju/ilH7w5yF8q5PF0WwHNMhXN7I8BocDl3ePrepTcEKYwW61WsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEB8E113E;
	Fri,  7 Feb 2025 05:22:15 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A0E43F63F;
	Fri,  7 Feb 2025 05:21:50 -0800 (PST)
Date: Fri, 7 Feb 2025 13:21:44 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
	catalin.marinas@arm.com, eauger@redhat.com, eric.auger@redhat.com,
	fweimer@redhat.com, jeremy.linton@arm.com, maz@kernel.org,
	oliver.upton@linux.dev, pbonzini@redhat.com, stable@vger.kernel.org,
	tabba@google.com, wilco.dijkstra@arm.com
Subject: Re: [PATCH v2 1/8] KVM: arm64: Unconditionally save+flush host
 FPSIMD/SVE/SME state
Message-ID: <Z6YI6IvG_N4txgz7@J2N7QTR9R3>
References: <20250206141102.954688-1-mark.rutland@arm.com>
 <20250206141102.954688-2-mark.rutland@arm.com>
 <20250207122748.GA4839@willie-the-truck>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207122748.GA4839@willie-the-truck>

On Fri, Feb 07, 2025 at 12:27:51PM +0000, Will Deacon wrote:
> On Thu, Feb 06, 2025 at 02:10:55PM +0000, Mark Rutland wrote:
> > There are several problems with the way hyp code lazily saves the host's
> > FPSIMD/SVE state, including:
> > 
> > * Host SVE being discarded unexpectedly due to inconsistent
> >   configuration of TIF_SVE and CPACR_ELx.ZEN. This has been seen to
> >   result in QEMU crashes where SVE is used by memmove(), as reported by
> >   Eric Auger:
> > 
> >   https://issues.redhat.com/browse/RHEL-68997
> > 
> > * Host SVE state is discarded *after* modification by ptrace, which was an
> >   unintentional ptrace ABI change introduced with lazy discarding of SVE state.
> > 
> > * The host FPMR value can be discarded when running a non-protected VM,
> >   where FPMR support is not exposed to a VM, and that VM uses
> >   FPSIMD/SVE. In these cases the hyp code does not save the host's FPMR
> >   before unbinding the host's FPSIMD/SVE/SME state, leaving a stale
> >   value in memory.
> 
> How hard would it be to write tests for these three scenarios? If we
> had something to exercise the relevant paths then...
>
> > ... and so this eager save+flush probably needs to be backported to ALL
> > stable trees.
> 
> ... this backporting might be a little easier to be sure about?

For the first case I have a quick and dirty test, which I've pushed to
my arm64/kvm/fpsimd-tests branch in my kernel.org repo:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/
  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git

For the last case it should be possible to do something similar, but I
hadn't had the time to dig in to the KVM selftests infrastructure and
figure out how to confiugre the guest appropriately.

For the ptrace case, the same symptoms can be provoked outside of KVM
(and I'm currently working to fix that). From my PoV the important thing
is that this fix happens to remove KVM from the set of cases the other
fixes need to care about.

FWIW I was assuming that I'd be handling the upstream backports, and I'd
be testing with the test above and some additional assertions hacked
into the kernel for testing.

Mark.

