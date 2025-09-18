Return-Path: <stable+bounces-166918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C83B1F59F
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 19:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6EC1788B6
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 17:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9E52BE042;
	Sat,  9 Aug 2025 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsMAQkDF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BA7274B39;
	Sat,  9 Aug 2025 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754760090; cv=none; b=qmBTH8R1e1nk+2k0Z6kz9FIRVYBEe/EJoxDVu1ETNT1UBF1Uo93uXHM2twOyN3PxpZoKYKojNLMOE2RO2Qx2juPAAfIratqpl78jJ8tM76i98KHIRgYBi7evh1rrQRbCInBVH1BNzPUJYfM2bB1GjUmnvaIAqJ5jzfkYfvov9LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754760090; c=relaxed/simple;
	bh=vzsOXWB6o/AgKZQ5ZPGwT+gEQE1iQ0Le2CtU/ZEWVOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfUsePCmQweA/DABXq4BCnE0QeJuV5r1ZslqZnaRFN0VdaCfWcHL6ilPWJH5jH8Oq7kZkIcOpiIqR8Y/4pfnZSU7HlkjNVe0hdkvL9DCeBtiJOTHFStO8TGOjQPnU2CgMw2xH7OWsLUNYP1XRdpSfzz3YGOYsNx3KO5VnIthnls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsMAQkDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09102C4CEE7;
	Sat,  9 Aug 2025 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754760089;
	bh=vzsOXWB6o/AgKZQ5ZPGwT+gEQE1iQ0Le2CtU/ZEWVOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CsMAQkDFESkTvtOv9ZfGZW5fGPNV0LcDZ32/Y3OIz+sYWldwk8Tl+8bQ/bPuk7ZfP
	 hkHy5hw6av9sKwAZN39OYBELeswuRCZWeO3AkB1VfTGDYn804HFVbyX61aTMKZY6SB
	 mZutbiMIAMrlRTBQAtrTfBjDmUnxWucls+Tw5BfkeLGmkHj6VeAZEiNPRKRttFwn9C
	 RizNMJvbiOKl2L7ypemjP1NbY2uIAV96cAndLQj5HHzvNzkCnQy9DfntHLhHUlI9ph
	 uEOvzHg4W9EsnExlzIitWW54xwYDCWjCHGo1IWx3GCdeyLBWHSfbycMmCqRxOCmYTj
	 q9Jk8txklN+Cw==
Date: Sat, 9 Aug 2025 10:21:27 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] KEYS: trusted_tpm1: Compare HMAC values in constant
 time
Message-ID: <20250809172127.GA3339@quark>
References: <20250731212354.105044-1-ebiggers@kernel.org>
 <20250731212354.105044-2-ebiggers@kernel.org>
 <aJIKu7uD-nYQERKW@kernel.org>
 <20250805173227.GD1286@sol>
 <aJck_YVdFqZoRk--@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJck_YVdFqZoRk--@kernel.org>

On Sat, Aug 09, 2025 at 01:37:49PM +0300, Jarkko Sakkinen wrote:
> On Tue, Aug 05, 2025 at 10:32:27AM -0700, Eric Biggers wrote:
> > On Tue, Aug 05, 2025 at 04:44:27PM +0300, Jarkko Sakkinen wrote:
> > > On Thu, Jul 31, 2025 at 02:23:52PM -0700, Eric Biggers wrote:
> > > > To prevent timing attacks, HMAC value comparison needs to be constant
> > > > time.  Replace the memcmp() with the correct function, crypto_memneq().
> > > > 
> > > > Fixes: d00a1c72f7f4 ("keys: add new trusted key-type")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > > 
> > > Was crypto_memneq() available at the time?
> > 
> > No.  The Fixes commit is still correct, though, as it's the commit that
> > introduced the memcmp().  Technically it was still a bug at that time,
> > even if there wasn't a helper function available yet.
> 
> Add a remark to the commit message.

I don't know what the point is (both commits are over a decade old), but
sure I did that in v2.

- Eric

