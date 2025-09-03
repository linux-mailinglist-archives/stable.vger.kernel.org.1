Return-Path: <stable+bounces-177665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DABB42B9A
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 23:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F06417623C
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 21:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1262EAD0B;
	Wed,  3 Sep 2025 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClZjpyKW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA522C235A
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934088; cv=none; b=tU6FNI8G1LrR87wHZVYWglEjKhrxxi+gJ9uwg+5bNeQrNAvo8tDMR9DpyQqZdKgj56dI6pTj6y8Sq2dtCHHkhqM8VnD9eDF4uTuF8sLGtvy1IT5TeTN716BAZKPSvhB7Yk9H8l11UzrM92KVtfNAqZ2JSB1GPbKpUbJgu0aGVi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934088; c=relaxed/simple;
	bh=4MXZl0VJ/IF+a02geJUNod5lzrf1oVb6NF5XHEnOCEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jP75Gk0Wlevq2yzb94AZ5QXL5OLcB7+p+lTXblZ12ca9Ar5oRnXbQqIUxzGyIiRCvreoqwjLBYSFIi1nmCmLGQ2SHckr0zPkVjBGBu2oh9n1/Byax8jQhc/huy1B36/oPex+zBceapmRFVsB/Typ18lc6rAiTxe+0BnWfs4EIkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClZjpyKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9D6C4CEF5;
	Wed,  3 Sep 2025 21:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756934086;
	bh=4MXZl0VJ/IF+a02geJUNod5lzrf1oVb6NF5XHEnOCEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ClZjpyKWkJt0awCh9NN9x48sf9IQUIXPOtYurFCukjyk4oby1SCAnmv9dtF+XQEzz
	 7t1nxz4BBTrYOpZjWoRs/OWj+IasnDEiCvkNixiNHdZmOgA9rNtAG4F2X9h//qcNZ1
	 RQ83KvEQYjJ5LsoqkimUImH6cubfE5mXmbtTVl47575ZnIrK4vjGnTYD4Ut2m6uSs7
	 4gaDWdI0/tmgDbPLI9XPMZOPwMqvLtxCtihjFoyhSSeqM6TG69F29St4p10ix7R81e
	 r7HRrm0N6dWs6fndZ6bho63B1CZ1ZvUWWaP8xntQ6nogfFDAK5M4WIOlymEJpGX6hg
	 4v20/Kjzlmnhw==
Date: Wed, 3 Sep 2025 14:14:42 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5.4 only] powerpc: boot: Remove unnecessary zero in label
 in udelay()
Message-ID: <20250903211442.GA2866185@ax162>
References: <20250902235234.2046667-1-nathan@kernel.org>
 <aLfdCkj4z99QmfMd@gate>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLfdCkj4z99QmfMd@gate>

On Wed, Sep 03, 2025 at 01:15:38AM -0500, Segher Boessenkool wrote:
> Hi!
> 
> On Tue, Sep 02, 2025 at 04:52:34PM -0700, Nathan Chancellor wrote:
> > When building powerpc configurations in linux-5.4.y with binutils 2.43
> > or newer, there is an assembler error in arch/powerpc/boot/util.S:
> > 
> >   arch/powerpc/boot/util.S: Assembler messages:
> >   arch/powerpc/boot/util.S:44: Error: junk at end of line, first unrecognized character is `0'
> >   arch/powerpc/boot/util.S:49: Error: syntax error; found `b', expected `,'
> >   arch/powerpc/boot/util.S:49: Error: junk at end of line: `b'
> > 
> > binutils 2.43 contains stricter parsing of certain labels [1].
> > 
> > Remove the unnecessary leading zero to fix the build.
> 
> To fix it by getting rid of this syntax error, you mean?  "00" is not a
> valid label name: a) it cannot be a symbol name, it starts with a digit;
> and b) it isn't a valid local label either.  As the manual says
> > To define a local label, write a label of the form ‘N:’ (where N
> > represents any non-negative integer).
> "0" is written "0", not as "00" (or "0-0" or even "0-0-0", hehe).

Sure, I have sent a v2 that hopefully makes it a little clearer that the
code in the kernel was already problematic under the existing rules.

https://lore.kernel.org/20250903211158.2844032-1-nathan@kernel.org/

Cheers,
Nathan

