Return-Path: <stable+bounces-177567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C467B4151F
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 08:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B218B680087
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 06:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A682D97A5;
	Wed,  3 Sep 2025 06:20:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FE62D7DD7
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 06:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756880431; cv=none; b=ZOQ3KF8MzcbfrwYZuemodW8M2jenE0Ml5ZOuVjMhA48C9goepeR+vfAe07JeF8mV5OV/x+C2TNdcmco7crtMbqQBLWNCzgJDPsgWBmCxTBKL4ki7ewDkly1dUcFqyY/iRBGFqYhO2uN+10dQftfR8TfRr3uhuzrqXXNktGDusgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756880431; c=relaxed/simple;
	bh=PIqPs8lmJilw2Je9Qc+CrdNULZ5cvaDwuCkWg9+greA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnQNye5CEGdpuZXApi1flqJ57PROAJun6Y6FRo6FPAye15cz3KjaBBfQzFj/+oGVIH5SWViw/Szq7BXJusTQJNo6aA2TpkvdQeJ5wQ0GhboVwjitOfpWTPikVTP/MH0H8c08BFeBK9dVCmRKMWFNwaVDnbWLHAPdGpQfbEaLgg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 5836FdIZ3679080;
	Wed, 3 Sep 2025 01:15:39 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 5836FcKJ3679079;
	Wed, 3 Sep 2025 01:15:38 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 3 Sep 2025 01:15:38 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5.4 only] powerpc: boot: Remove unnecessary zero in label
 in udelay()
Message-ID: <aLfdCkj4z99QmfMd@gate>
References: <20250902235234.2046667-1-nathan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250902235234.2046667-1-nathan@kernel.org>

Hi!

On Tue, Sep 02, 2025 at 04:52:34PM -0700, Nathan Chancellor wrote:
> When building powerpc configurations in linux-5.4.y with binutils 2.43
> or newer, there is an assembler error in arch/powerpc/boot/util.S:
> 
>   arch/powerpc/boot/util.S: Assembler messages:
>   arch/powerpc/boot/util.S:44: Error: junk at end of line, first unrecognized character is `0'
>   arch/powerpc/boot/util.S:49: Error: syntax error; found `b', expected `,'
>   arch/powerpc/boot/util.S:49: Error: junk at end of line: `b'
> 
> binutils 2.43 contains stricter parsing of certain labels [1].
> 
> Remove the unnecessary leading zero to fix the build.

To fix it by getting rid of this syntax error, you mean?  "00" is not a
valid label name: a) it cannot be a symbol name, it starts with a digit;
and b) it isn't a valid local label either.  As the manual says
> To define a local label, write a label of the form ‘N:’ (where N
> represents any non-negative integer).
"0" is written "0", not as "00" (or "0-0" or even "0-0-0", hehe).


Segher

