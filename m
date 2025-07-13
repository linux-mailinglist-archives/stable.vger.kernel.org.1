Return-Path: <stable+bounces-161778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 903C1B03196
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 16:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE36A3BF1EE
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 14:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782812798ED;
	Sun, 13 Jul 2025 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MH930o9i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0442594;
	Sun, 13 Jul 2025 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752417487; cv=none; b=IrtBoQkXshqzf1sk+ExvDQ4tGDJXhHrmZTPIqjRe8eNWvXQEkjboGF5ysFvrNLFXwzakm9+O789YwZFooql6GlXNSJp/02XYUmD+l5dE/gFG4wqdMkTXvDR32qGDdRrqro8dX4LjYOwoO+ST1gVPOGtoGTCSjhJI4VXUYR6FFww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752417487; c=relaxed/simple;
	bh=NajD1l/bsB2+6VsPeV3W0eU4Dv/Twrg/RgHA3HjAY94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFUyceuNabiCXXyuV01yC0tkf5TtLfvVBWYlakUGCFdcTArDiE/YDrs3F2ag3jjytFRPvO3btOqwBQPvnlNfceg3lvrrOaV1jguMqIDXN9NfwO8BFBjFK+zoZG7+/ESCR5dSI4NU3gQQ1SU4liEj86e8JCPugWeYzReaibFKB6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MH930o9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3F0C4CEF4;
	Sun, 13 Jul 2025 14:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752417487;
	bh=NajD1l/bsB2+6VsPeV3W0eU4Dv/Twrg/RgHA3HjAY94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MH930o9i/1h2/VH65OzuNEG+t2VDXTRPe5YP4pnXDYGtkEbD/XSSU4qiSckrkpkPW
	 5D+3wVlnJRNv8Lus/NaLVIUhquTN3S49cOfjxbN079mdaXbIn2RMPigOM07rdSrrrm
	 V1MtnXgHwH0zXwrT2/ykP/gEa6fXAaouHS88/WQQ=
Date: Sun, 13 Jul 2025 16:38:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Achill Gilgenast <fossdd@pwned.life>
Cc: Natanael Copa <ncopa@alpinelinux.org>, stable@vger.kernel.org,
	regressions@lists.linux.dev,
	Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>
Subject: Re: [REGRESSION] v6.12.35: (build) kallsyms.h:21:10: fatal error:
 execinfo.h: No such file or directory
Message-ID: <2025071349-enforced-darkroom-164c@gregkh>
References: <20250701141026.6133a3aa@ncopa-desktop>
 <2025070104-ether-wipe-9c19@gregkh>
 <DBAZXHXZCG1H.2PHV0NWGFKJQ6@pwned.life>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBAZXHXZCG1H.2PHV0NWGFKJQ6@pwned.life>

On Sun, Jul 13, 2025 at 04:27:36PM +0200, Achill Gilgenast wrote:
> On Tue Jul 1, 2025 at 2:26 PM CEST, Greg Kroah-Hartman wrote:
> > On Tue, Jul 01, 2025 at 02:10:26PM +0200, Natanael Copa wrote:
> >> Hi!
> >> 
> >> I bumped into a build regression when building Alpine Linux kernel 6.12.35 on x86_64:
> >> 
> >> In file included from ../arch/x86/tools/insn_decoder_test.c:13:
> >> ../tools/include/linux/kallsyms.h:21:10: fatal error: execinfo.h: No such file or directory
> >>    21 | #include <execinfo.h>
> >>       |          ^~~~~~~~~~~~
> >> compilation terminated.
> >> 
> >> The 6.12.34 kernel built just fine.
> >> 
> >> I bisected it to:
> >> 
> >> commit b8abcba6e4aec53868dfe44f97270fc4dee0df2a (HEAD)
> >> Author: Sergio Gonz_lez Collado <sergio.collado@gmail.com>
> >> Date:   Sun Mar 2 23:15:18 2025 +0100
> >> 
> >>     Kunit to check the longest symbol length
> >>     
> >>     commit c104c16073b7fdb3e4eae18f66f4009f6b073d6f upstream.
> >>     
> >> which has this hunk:
> >> 
> >> diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
> >> index 472540aeabc2..6c2986d2ad11 100644
> >> --- a/arch/x86/tools/insn_decoder_test.c
> >> +++ b/arch/x86/tools/insn_decoder_test.c
> >> @@ -10,6 +10,7 @@
> >>  #include <assert.h>
> >>  #include <unistd.h>
> >>  #include <stdarg.h>
> >> +#include <linux/kallsyms.h>
> >>  
> >>  #define unlikely(cond) (cond)
> >>  
> >> @@ -106,7 +107,7 @@ static void parse_args(int argc, char **argv)
> >>         }
> >>  }
> >>  
> >> -#define BUFSIZE 256
> >> +#define BUFSIZE (256 + KSYM_NAME_LEN)
> >>  
> >>  int main(int argc, char **argv)
> >>  {
> >> 
> >> It looks like the linux/kallsyms.h was included to get KSYM_NAME_LEN.
> >> Unfortunately it also introduced the include of execinfo.h, which does
> >> not exist on musl libc.
> >> 
> >> This has previously been reported to and tried fixed:
> >> https://lore.kernel.org/stable/DB0OSTC6N4TL.2NK75K2CWE9JV@pwned.life/T/#t
> >> 
> >> Would it be an idea to revert commit b8abcba6e4ae til we have a proper
> >> solution for this?
> >
> > Please get the fix in Linus's tree first and then we can backport it as
> > needed.
> 
> The patch now landed in Linus's tree as a95743b53031 ("kallsyms: fix
> build without execinfo"). Please backport it into the stable trees.

Already all queued up!

Thanks for letting us know.

greg k-h

