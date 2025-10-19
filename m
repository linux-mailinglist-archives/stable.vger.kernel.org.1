Return-Path: <stable+bounces-187909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FA9BEE82B
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 17:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D8CB4E8D5D
	for <lists+stable@lfdr.de>; Sun, 19 Oct 2025 15:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011E72EB874;
	Sun, 19 Oct 2025 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YCb3pyJw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE692EB861;
	Sun, 19 Oct 2025 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760886215; cv=none; b=dZhcnwDOnShEoqgn+jToU2j5cON4KtqEsduFQuE2mriNzgCnnl0Dw/FqTmFqwfPXSq8g10Bskq9/duK+XVFjCn+tfgD+i3C2vEZAjQwVIFXycwHXNnxdZktUSHxXmiKLiX4HwDem/kObHfgN2HuufwnWJlQcF8z8/eAPHFVWo7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760886215; c=relaxed/simple;
	bh=CvUdrAhJKrAFPUNmEfVgBrHXrqkfuXKEui6HESMt9gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D22CDUN7uQF5ZJ7HcRBj8rAfQIMR0EwngYgdLaeCO/fvdmK3xrGwKNT81c4i9F3fTlRnmHVfBYMLmJBR1/9/gu1V1n2DB5sry+wM8KbP+YHL/aiQ6GQyg8NBdLFLMOmSFcu61hZHbjzja72ZgCWy3R8lwohytqet1SQcq77RIMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=YCb3pyJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C015C4CEF1;
	Sun, 19 Oct 2025 15:03:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YCb3pyJw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1760886208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jir822fJVXvlFL1pNOJ9mf5/pCTgHfz0MI2r7sxik9s=;
	b=YCb3pyJw9PTsualD3YKs1UTSHYeVss1rYlK6EUPUxqfqb2QS9dOJHNCOLB64NY3Bjd+zhp
	ncMsXdgBHYZuIY0hjF7i61ytYmSlKahfU9p0Wy4sfF6C3IMclpYyVqrPiR0FQxChK0G+fJ
	BWLWbKuckw00Wc5YxzAAyc2ThTnVY6A=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bc093c64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 19 Oct 2025 15:03:28 +0000 (UTC)
Date: Sun, 19 Oct 2025 17:03:25 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Gregory Price <gourry@gourry.net>, x86@kernel.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
	mario.limonciello@amd.com, riel@surriel.com, yazen.ghannam@amd.com,
	me@mixaill.net, kai.huang@intel.com, sandipan.das@amd.com,
	darwi@linutronix.de, stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/amd: Disable RDSEED on AMD Zen5 because of an
 error.
Message-ID: <aPT9vUT7Hcrkh6_l@zx2c4.com>
References: <20251018024010.4112396-1-gourry@gourry.net>
 <20251018100314.GAaPNl4ngomUnreTbZ@fat_crate.local>
 <aPT5rnbfP5efmo4I@zx2c4.com>
 <20251019150027.GAaPT9Cz6NjB9S2d2a@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251019150027.GAaPT9Cz6NjB9S2d2a@fat_crate.local>

On Sun, Oct 19, 2025 at 05:00:27PM +0200, Borislav Petkov wrote:
> On Sun, Oct 19, 2025 at 04:46:06PM +0200, Jason A. Donenfeld wrote:
> > While your team is checking into this, I'd be most interested to know
> > one way or the other whether this affects RDRAND too.
> 
> No it doesn't, AFAIK. The only one affected is the 32-bit or 16-bit dest
> operand version of RDSEED. Again, AFAIK.

Oh good. So on 64-bit kernels, the impact to random.c is zilch.

Jason

