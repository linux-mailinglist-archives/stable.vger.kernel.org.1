Return-Path: <stable+bounces-159141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD11EAEF881
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 14:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01045166581
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 12:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5263B274B21;
	Tue,  1 Jul 2025 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vbvw8o1x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5CA2741DA;
	Tue,  1 Jul 2025 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372788; cv=none; b=PwERSYqP4/d6k76eyc5IV9DwYfFt727pZeoi3pi786rnzNBBLNCXwl/LfoMOwGphWPz1U4RNf2pA/ky1UWqXhZbhQdGkZTNOohooAMeOaD/IyrqgdUFR4IEQTwTnADHp4AfjH/X9wRGFpS4dtyCWyN8/oWJ7draub396g+6C6Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372788; c=relaxed/simple;
	bh=KAGT4CwkJm+NjHDWcqMpsH6FZMYR4dCOxYZ98rmlaQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxkyPINY17AeStVS0Igzc+8h5YVxUNsL0L2GBnRAF7YdbnEqhwdVu4iVU1RFDu9mXzkyEvT95YnCVglMUTuXeJT/7BXGgrrsdKtKvV4nGHZjUqP+PrAdmsxMNZ5FwZnIEBaZSQpfxHaDrs29OoU9NgJx1p4F/7yuD8MC2XQpiCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vbvw8o1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDF8C4CEEB;
	Tue,  1 Jul 2025 12:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751372787;
	bh=KAGT4CwkJm+NjHDWcqMpsH6FZMYR4dCOxYZ98rmlaQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vbvw8o1xApRb50cC/Jrl5MGaOIG5dWbry91bLzzvvN0CcRDOtnInhOuKye8Cz1OsK
	 rxUPgnbfwVt8KePwcVMA7E8OVosULll14hzkpY8VW7QeOgsHC5KKYiEP4piRUGnL2y
	 miqGS5mBuxRZhShyuRXjjn5FYQhKfhMIxb/6+IY0=
Date: Tue, 1 Jul 2025 14:26:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
	Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>,
	Achill Gilgenast <fossdd@pwned.life>
Subject: Re: [REGRESSION] v6.12.35: (build) kallsyms.h:21:10: fatal error:
 execinfo.h: No such file or directory
Message-ID: <2025070104-ether-wipe-9c19@gregkh>
References: <20250701141026.6133a3aa@ncopa-desktop>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701141026.6133a3aa@ncopa-desktop>

On Tue, Jul 01, 2025 at 02:10:26PM +0200, Natanael Copa wrote:
> Hi!
> 
> I bumped into a build regression when building Alpine Linux kernel 6.12.35 on x86_64:
> 
> In file included from ../arch/x86/tools/insn_decoder_test.c:13:
> ../tools/include/linux/kallsyms.h:21:10: fatal error: execinfo.h: No such file or directory
>    21 | #include <execinfo.h>
>       |          ^~~~~~~~~~~~
> compilation terminated.
> 
> The 6.12.34 kernel built just fine.
> 
> I bisected it to:
> 
> commit b8abcba6e4aec53868dfe44f97270fc4dee0df2a (HEAD)
> Author: Sergio Gonz_lez Collado <sergio.collado@gmail.com>
> Date:   Sun Mar 2 23:15:18 2025 +0100
> 
>     Kunit to check the longest symbol length
>     
>     commit c104c16073b7fdb3e4eae18f66f4009f6b073d6f upstream.
>     
> which has this hunk:
> 
> diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
> index 472540aeabc2..6c2986d2ad11 100644
> --- a/arch/x86/tools/insn_decoder_test.c
> +++ b/arch/x86/tools/insn_decoder_test.c
> @@ -10,6 +10,7 @@
>  #include <assert.h>
>  #include <unistd.h>
>  #include <stdarg.h>
> +#include <linux/kallsyms.h>
>  
>  #define unlikely(cond) (cond)
>  
> @@ -106,7 +107,7 @@ static void parse_args(int argc, char **argv)
>         }
>  }
>  
> -#define BUFSIZE 256
> +#define BUFSIZE (256 + KSYM_NAME_LEN)
>  
>  int main(int argc, char **argv)
>  {
> 
> It looks like the linux/kallsyms.h was included to get KSYM_NAME_LEN.
> Unfortunately it also introduced the include of execinfo.h, which does
> not exist on musl libc.
> 
> This has previously been reported to and tried fixed:
> https://lore.kernel.org/stable/DB0OSTC6N4TL.2NK75K2CWE9JV@pwned.life/T/#t
> 
> Would it be an idea to revert commit b8abcba6e4ae til we have a proper
> solution for this?

Please get the fix in Linus's tree first and then we can backport it as
needed.

thanks,

greg k-h

