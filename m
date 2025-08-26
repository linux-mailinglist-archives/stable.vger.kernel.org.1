Return-Path: <stable+bounces-176393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BD1B36DC0
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 17:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A797B7B002F
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380292C08DB;
	Tue, 26 Aug 2025 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=helsinkinet.fi header.i=@helsinkinet.fi header.b="ikikVToc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.dnamail.fi (sender103.dnamail.fi [83.102.40.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E188D2BE7DD;
	Tue, 26 Aug 2025 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.102.40.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222267; cv=none; b=VH3bM+dAT6EYUkXGQyhr3rKfffq4mWsAGpBdIrANPi4mEA7tvpTcS+hylJhhjYja71vErUk6sxyy1iK3/GrkBNcTz8zjenXhWqkBZADPdmYAHp1Xk6hCjJEMsOoYLtGS7vc65ZjgtZm+CEAJKBCc4TCVwEVSrjFYAvz9kOcIVfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222267; c=relaxed/simple;
	bh=NmSdFKTj9xVwuySbEcS37rlFvHtyWLgZSp2yT4nbZ80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bb5lo3K4s5WMk0cTy7kbpAAXqVn2nftzlvQ3xW9wsT3cLei41PXBlVVEN2SLXNTnsF69UyuR8RF/1fOtcfVROpArAePPZ5vcr03e6eI/IAYlOVttZvBuoVv7dHsMHgEHNbAAGYQMIr6J0vhOd6d2GT3tALui1TRKnOqc7lmt9LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=helsinkinet.fi; spf=pass smtp.mailfrom=helsinkinet.fi; dkim=pass (2048-bit key) header.d=helsinkinet.fi header.i=@helsinkinet.fi header.b=ikikVToc; arc=none smtp.client-ip=83.102.40.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=helsinkinet.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helsinkinet.fi
Received: from localhost (localhost [127.0.0.1])
	by smtp.dnamail.fi (Postfix) with ESMTP id 581684099FCA;
	Tue, 26 Aug 2025 18:22:47 +0300 (EEST)
X-Virus-Scanned: X-Virus-Scanned: amavis at smtp.dnamail.fi
Received: from smtp.dnamail.fi ([83.102.40.157])
 by localhost (dmail-psmtp02.s.dnaip.fi [127.0.0.1]) (amavis, port 10024)
 with ESMTP id PMmFasO9h_Mq; Tue, 26 Aug 2025 18:22:46 +0300 (EEST)
Received: from [192.168.101.100] (87-92-210-146.rev.dnainternet.fi [87.92.210.146])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: oak@dnamail.internal)
	by smtp.dnamail.fi (Postfix) with ESMTPSA id 07BBC4098E80;
	Tue, 26 Aug 2025 18:22:45 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.dnamail.fi 07BBC4098E80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=helsinkinet.fi;
	s=2025-03; t=1756221766;
	bh=0ZzURsXTLX0DDS5HbIBIn3UNXnqo4LEOYM+sCHUpw2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ikikVTocvPhK5wXgSPzJAa2a2o1eYRSTgQlUYoELt1PKZxJZE+q4epf9ruyyHNBPk
	 WzB+SNoEvaG5U5U4TuU6pWwc4SVma3uISzw14du1XSRy9gz8yoqnfjbNsHtepjRf9h
	 VnSXXALIB/CPVB/WkmI3Dz58KjwcbooTVfARsvtRUHKfewJtJxjFG8LdZe8GxlpArX
	 KrtkQwB66SZR8XlaGMtfykrTzZNeEg4IvZue+PXNI+XNxThO9/+lH3H9T0NuEn56bH
	 bMTVOFJ+3ODpxKpVbwB/2xlGoH6+NDpvYSNw18mIhcAvv1GPEjw8mZ9L8NcGj/906s
	 vjLl3BPVka/cQ==
Message-ID: <1a5ce56a-d0d0-481e-b663-a7b176682a65@helsinkinet.fi>
Date: Tue, 26 Aug 2025 18:22:45 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
To: Finn Thain <fthain@linux-m68k.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lance Yang <lance.yang@linux.dev>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Will Deacon <will@kernel.org>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
Content-Language: en-US
From: Eero Tamminen <oak@helsinkinet.fi>
In-Reply-To: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Finn & Lance,

On 25.8.2025 5.03, Finn Thain wrote:
> Some recent commits incorrectly assumed the natural alignment of locks.
> That assumption fails on Linux/m68k (and, interestingly, would have failed
> on Linux/cris also). This leads to spurious warnings from the hang check
> code. Fix this bug by adding the necessary 'aligned' attribute.
[...]
> Reported-by: Eero Tamminen <oak@helsinkinet.fi>
> Closes: https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com/
> Fixes: e711faaafbe5 ("hung_task: replace blocker_mutex with encoded blocker")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
> I tested this on m68k using GCC and it fixed the problem for me. AFAIK,
> the other architectures naturally align ints already so I'm expecting to
> see no effect there.

Yes, it fixes both of the issues (warnings & broken console):
	Tested-by: Eero Tamminen <oak@helsinkinet.fi>

(Emulated Atari Falcon) boot up performance with this is within normal 
variation.


On 23.8.2025 10.49, Lance Yang wrote:
 > Anyway, I've prepared two patches for discussion, either of which should
 > fix the alignment issue :)
 >
 > Patch A[1] adjusts the runtime checks to handle unaligned pointers.
 > Patch B[2] enforces 4-byte alignment on the core lock structures.
 >
 > Both tested on x86-64.
 >
 > [1] 
https://lore.kernel.org/lkml/20250823050036.7748-1-lance.yang@linux.dev
 > [2] https://lore.kernel.org/lkml/20250823074048.92498-1-
 > lance.yang@linux.dev

Same goes for both of these, except that removing warnings makes minimal 
kernel boot 1-2% faster than 4-aligning the whole struct.


	- Eero


