Return-Path: <stable+bounces-28296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FF887D9B7
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 11:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37441C20B9A
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 10:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47794101CA;
	Sat, 16 Mar 2024 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LP4cGXK1"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31417171AD
	for <stable@vger.kernel.org>; Sat, 16 Mar 2024 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710583361; cv=none; b=I9z3+fGbl+orDabMIkHnVHeORzU37qcoNGKPzn2TeoFslkTXmJ4mjEXq3x1VHy722bY1kVag0Ue5TSMliYCb50LbKbj520sMyRveSRmIRilVElTCI0ZUblmovweJPVHKtbnnnczSJ2hUFntGE0P6XcP15V69+kkT6sO77HovNYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710583361; c=relaxed/simple;
	bh=nKK4XAfWJTStwasEG2ouHoqelNTjNwvlay0ioA059pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upnAzmlz6QyqSFNh85H04d4jmLn36/92gOR9MqLH4GTE662p4b1qMxggIwwlGaDUANX38b5CbJjwUV2LxR2NuTSFcnla672D82BDc3f3HnOTSIiF8da0zEsyBT5HIkTabHUouU5ZNzuuVb4n+whceDNr87P4SiX/wy0XbKaRJ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LP4cGXK1; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3Kkg5T2Rg6iLBfWgmx9RjQlSml/GOLN0J9ci0677nD8=; b=LP4cGXK1WSdEbx/XaxN52rQ66J
	WaCg1AXnsD9QcaDN5bW1vR5d9R8v2VLgbo8kdT1IsBIH7vC4RGvu8Z2ODfqyxHIPtPAePqclwoG2l
	DEiDMCRZy2v5piSAZN9s8u5zoTO8y9XYJMV5V/gPk+4IgDIQgULn7E6LsmHjHkWe8dM5meaXHmTfG
	DvrPmVTS1N+sS9KMcp8kG3zVHbEtQ4zAQmItn/4JvVYR3+8hYzG4L0WgjFlbeBHu/5iN8hHBpp8JJ
	UjxxlYvcITsvMnNNUpTmjSJ566FAQ158riIW5QtF8DHFoi3AcNVzOrM6LDjsQv1I85Fj9RLCTS48/
	f4fl8xgg==;
Received: from [179.93.183.101] (helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rlQs0-00BC4z-Bi; Sat, 16 Mar 2024 11:02:28 +0100
Date: Sat, 16 Mar 2024 07:02:19 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, kernel-dev@igalia.com
Subject: Re: [PATCH 5.15 0/5] Support static calls with LLVM-built kernels
Message-ID: <ZfVuK/Gn6sFQXV3Z@quatroqueijos.cascardo.eti.br>
References: <20240313104255.1083365-1-cascardo@igalia.com>
 <ZfVpPMl3JJakSHT1@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfVpPMl3JJakSHT1@sashalap>

On Sat, Mar 16, 2024 at 05:41:16AM -0400, Sasha Levin wrote:
> On Wed, Mar 13, 2024 at 07:42:50AM -0300, Thadeu Lima de Souza Cascardo wrote:
> > Peter Zijlstra (4):
> >  arch: Introduce CONFIG_FUNCTION_ALIGNMENT
> >  x86/alternatives: Introduce int3_emulate_jcc()
> >  x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions
> >  x86/static_call: Add support for Jcc tail-calls
> > 
> > Thomas Gleixner (1):
> >  x86/asm: Differentiate between code and function alignment
> 
> Is this not an issue on 6.1? I don't see d49a0626216b ("arch: Introduce
> CONFIG_FUNCTION_ALIGNMENT") in that tree.
> 
> -- 
> Thanks,
> Sasha

The fix is really the last patch, 923510c88d2b ("x86/static_call: Add support
for Jcc tail-calls"). I see that 6.1 got 3,4,5:

9d80f3e60043 x86/static_call: Add support for Jcc tail-calls
c51a456b4179 x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions
75c066485bcb x86/alternatives: Introduce int3_emulate_jcc()

I can resubmit the series without the first two patches if that is preferred.

Thanks.
Cascardo.

