Return-Path: <stable+bounces-177667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23EBB42BB8
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 23:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3FF3B9D1A
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 21:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58722E92DA;
	Wed,  3 Sep 2025 21:19:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64979285053
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934391; cv=none; b=TLd2myxyeHEdpIzccHvSBWCFxNEQW6b8QBnZ+UOc/aCTIrYWx9xfT9mZbYkYjjsZnrRVmWTe7Gb1tX+0oSpxyGgPtZq3I9UlW4vZItk5L2UpCHmeZXfD7OaCQqOHh7GIAQlDKPfctwpN6Symcy/G8dXloAneSL6m25WHo8fQiU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934391; c=relaxed/simple;
	bh=njBNv6/ApiQEkfJpUQ5HjFlTilqYkPN5OcfryFury7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5+ed8pmd4hO2UIkLu1IKcAbHjwHlhqcnuNKBCxgSwMVQdEQ31GoSnNr74EJcAUGq1Zz/vMwifs+kN32PT78pzEXnwRlA29o+HCNiH3Gbo9mudxMNI45SfzFAgC/8/9TcIzI6P3IwwVZFH7djrMcGB008k73DYl3LA3duXjaA6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost [127.0.0.1])
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 583LJPdA3720201;
	Wed, 3 Sep 2025 16:19:25 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.18.1/8.18.1/Submit) id 583LJPZi3720200;
	Wed, 3 Sep 2025 16:19:25 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Wed, 3 Sep 2025 16:19:24 -0500
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
Message-ID: <aLiw3L76FR5k-Xen@gate>
References: <20250902235234.2046667-1-nathan@kernel.org>
 <aLfdCkj4z99QmfMd@gate>
 <20250903211442.GA2866185@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903211442.GA2866185@ax162>

Hi!

On Wed, Sep 03, 2025 at 02:14:42PM -0700, Nathan Chancellor wrote:
> On Wed, Sep 03, 2025 at 01:15:38AM -0500, Segher Boessenkool wrote:
> > On Tue, Sep 02, 2025 at 04:52:34PM -0700, Nathan Chancellor wrote:
> > > When building powerpc configurations in linux-5.4.y with binutils 2.43
> > > or newer, there is an assembler error in arch/powerpc/boot/util.S:
> > > 
> > >   arch/powerpc/boot/util.S: Assembler messages:
> > >   arch/powerpc/boot/util.S:44: Error: junk at end of line, first unrecognized character is `0'
> > >   arch/powerpc/boot/util.S:49: Error: syntax error; found `b', expected `,'
> > >   arch/powerpc/boot/util.S:49: Error: junk at end of line: `b'
> > > 
> > > binutils 2.43 contains stricter parsing of certain labels [1].
> > > 
> > > Remove the unnecessary leading zero to fix the build.
> > 
> > To fix it by getting rid of this syntax error, you mean?  "00" is not a
> > valid label name: a) it cannot be a symbol name, it starts with a digit;
> > and b) it isn't a valid local label either.  As the manual says
> > > To define a local label, write a label of the form ‘N:’ (where N
> > > represents any non-negative integer).
> > "0" is written "0", not as "00" (or "0-0" or even "0-0-0", hehe).
> 
> Sure, I have sent a v2 that hopefully makes it a little clearer that the
> code in the kernel was already problematic under the existing rules.
> 
> https://lore.kernel.org/20250903211158.2844032-1-nathan@kernel.org/

You forgot to cc: me on that :-)  I have it via linuxppc-dev@ of course.

Looks great, thank you!


Segher

