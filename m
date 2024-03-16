Return-Path: <stable+bounces-28301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 673CC87D9D9
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 12:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989C21C20D60
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 11:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174C711CAB;
	Sat, 16 Mar 2024 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="h7qUh/J7"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E241912B71
	for <stable@vger.kernel.org>; Sat, 16 Mar 2024 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710587331; cv=none; b=PFvFbPITk6iapg2uyFFNSF8ICATDK0w4VWImB8yMz6pFz+zIkJ2WDc8i9M1b5ShmWzumBJ9JJXgDqYsErSPmHrP1ayIU8hg8oPF/wJkYogMBw+WeXSi2vTPizdJMnsqMfsJBQMH0BVP+NQfyRu6rjijjFXtQ0lUj0Cyb/o86xAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710587331; c=relaxed/simple;
	bh=uBbEGgt3sVA6Hj3MDAf8NM+xwRF1s30RYaZCFCFQ6RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdK2i0nGQXCQ9Sj2vMlp2tv64T+gVmNCITj2r/WorKSmta50NGIqJdK9UarGZRxQvdyBZ3YYsBODQ4Jqr9D+I+yU7RHHM6hAuqdNtC/k5ffjeMVv7jAxb9iCqFB5uAxTpsNIAZa1gy8dnG+qGXCJZbSulxhleMYSNrTz/icNG3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=h7qUh/J7; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=zITovDLEmPEbyfbHP+vL/sc6g6rBpWVxtEMKv0GSAFk=; b=h7qUh/J7HzG906vVvdfr+kyzVX
	03iR8NrFIrqFRd5Wwz2m48FKMcXPQMSO3LmW/9IlPvQJkOJ26lehPG9L24MF41sSC3qcBQNy9tax+
	Uetk2bfaL1jVFO49t+QUOTXzpcx+wLItPP6+m4HRavk8WyPxlE1O0+SW2ZE06eHBuZYf5udc8a6O/
	Z3L4vFIeREKcmG4pV9ujBLYAkZq9bPGT59IdXUIJ3+UsG7Y6XMwtR1sS3UJGD4Ja8ZeDGY015WzKp
	QPEFkOr2OQyV5Pz6bbasiSUWoa3qvLtYRM/rfLwBTJAV1X0LwV2sS9fNpUcOKN9HEWUqPtbJILxeC
	kMMO5n7g==;
Received: from 179-125-71-251-dinamico.pombonet.net.br ([179.125.71.251] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rlRu6-00BDCN-It; Sat, 16 Mar 2024 12:08:43 +0100
Date: Sat, 16 Mar 2024 08:08:33 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, kernel-dev@igalia.com
Subject: Re: [PATCH 5.15 0/5] Support static calls with LLVM-built kernels
Message-ID: <ZfV9sfN4oU6KF7mM@quatroqueijos.cascardo.eti.br>
References: <20240313104255.1083365-1-cascardo@igalia.com>
 <ZfVpPMl3JJakSHT1@sashalap>
 <ZfVuK/Gn6sFQXV3Z@quatroqueijos.cascardo.eti.br>
 <ZfV8Gh44eZI-Md_f@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfV8Gh44eZI-Md_f@sashalap>

On Sat, Mar 16, 2024 at 07:01:46AM -0400, Sasha Levin wrote:
> On Sat, Mar 16, 2024 at 07:02:19AM -0300, Thadeu Lima de Souza Cascardo wrote:
> > On Sat, Mar 16, 2024 at 05:41:16AM -0400, Sasha Levin wrote:
> > > On Wed, Mar 13, 2024 at 07:42:50AM -0300, Thadeu Lima de Souza Cascardo wrote:
> > > > Peter Zijlstra (4):
> > > >  arch: Introduce CONFIG_FUNCTION_ALIGNMENT
> > > >  x86/alternatives: Introduce int3_emulate_jcc()
> > > >  x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions
> > > >  x86/static_call: Add support for Jcc tail-calls
> > > >
> > > > Thomas Gleixner (1):
> > > >  x86/asm: Differentiate between code and function alignment
> > > 
> > > Is this not an issue on 6.1? I don't see d49a0626216b ("arch: Introduce
> > > CONFIG_FUNCTION_ALIGNMENT") in that tree.
> > > 
> > > --
> > > Thanks,
> > > Sasha
> > 
> > The fix is really the last patch, 923510c88d2b ("x86/static_call: Add support
> > for Jcc tail-calls"). I see that 6.1 got 3,4,5:
> > 
> > 9d80f3e60043 x86/static_call: Add support for Jcc tail-calls
> > c51a456b4179 x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions
> > 75c066485bcb x86/alternatives: Introduce int3_emulate_jcc()
> > 
> > I can resubmit the series without the first two patches if that is preferred.
> 
> I'm just curious why we needed the first two patches on 5.15 but not on 6.1.
> 
> -- 
> Thanks,
> Sasha
> 

Because 923510c88d2b uses ASM_FUNC_ALIGN, which requires those two. I
didn't look at the 6.1 backport for reference. There, it was removed. It
seems to be a requirement for depth tracking that would not be necessary in
5.15 either.

I will send a v2.

Cascardo.

