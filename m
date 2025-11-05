Return-Path: <stable+bounces-192547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59267C381CF
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 22:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C271B18C7BA2
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 21:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64572DF716;
	Wed,  5 Nov 2025 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="Bq6IqwNp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C30E2DF14D
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379647; cv=none; b=Kr6X3s3KVLaitO3CtfIgj125zrJlFyIPxErQGdnxCyjql4PSxaQ4HCCbC+mgbgzRTdbu3fM7UjWR2mv492guzdVLmzQv82xSqgLNgH8sXZnUDfTNxaxEbjr+dXVllpKICsU+wn3K2a60pDLulaN7zycQgbhu2pYu0HOs9FtGERU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379647; c=relaxed/simple;
	bh=a0DMhlWxuVqBCN0KBqdowbn/CLsjJL49e5yevm+zPx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5yYQucjs7T0mWN5HF3xsGsiPehFYkChQ+xKAbsm2Ix795WC+z463fOzvD4QrmhAjC5WyE2gq/x6OZzLjv+OWa4MXdb+EWzaMly+65QTccpaY+VvjOnrtBzhDPLu+OVHzsuBw14ZAfMEE4cuyqhN5zvkl6KUiX4ZOzqGN19dUBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=Bq6IqwNp; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6a42604093so26296a12.3
        for <stable@vger.kernel.org>; Wed, 05 Nov 2025 13:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1762379645; x=1762984445; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3NyO7+s0Q1YlVv+39EMFftmDuskfOkHuzdOZz8YwQ74=;
        b=Bq6IqwNpvkLU9d9NH58gSkILJMcVqv/EFNYedZWUfG4ZFDQVS4BYKP2E+U7VCX8qKz
         DpUZJMfjizy8+lxFwGLO/wkNnCPvwuJ68RNz28KLi2ub8kDMu7+CU1TpIKUrU1aXPJkh
         /iLNb9DMRPbj1qQ7baqXPC47Aaj/5IB7jFG290XrqWDjb46kL/5+PYZD0dPACrt2JIUY
         p86toIlTGhlWvkEWLy1epSYT1ER5tbEz/m2MxnJvKAS/eXf06AeLjXvQw1EUqezCIHgJ
         BwKvMekQMJANagYhGC46/cYU/RqhjzOBjHH1MSqsmN1JgWwbmaMKiK1Ox15ygqSYU49R
         rUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762379645; x=1762984445;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NyO7+s0Q1YlVv+39EMFftmDuskfOkHuzdOZz8YwQ74=;
        b=XDOtGAuX72CoG6bczCK9bjxQsXE9JDoLLh17g3b8f7qfq0vD+a0sraKTB7zlz1fE8s
         fdpeV2AmBeUGoV+nXmMSB575xKCGeKnBiwgTbwHcvRf2mIIvdDNLyIIG4eoX0RsgoFIJ
         5jlQNuIlSGiPnXDXm3+4tsuIjE+B0N/bOGFniaplgyAX4yE7K61vJ9PhWouPHu+XBIG/
         SUIIfuXy+rzLraRxL12/eYtFa78DT/qklWSMibIS5pgoLnV8G1aAxTOJMIXhnb1311AF
         rc9yiwhL5NIXsDY3xLQEno+S7BVl8ivfvHCp0Z4emCGLUzmDjwZDtwIY3lD+fjt+BEA8
         b9hQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/2bqwx2A++VqyaRZphMtk5jUv7T0d3K7X+VosMwBw2Leejsn8LH+S1tGXkxI4dbiGe6ik9iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6rD6JNnmcckJZK4xNU5fbto8BfSTUc8nBQEZuHUfoDQ7RHOLP
	6X5093C/RJm/leUJzE9xHo+Ss9SahRct1G7hfbOTguZoX5R7fBgL18ppcoQ3cLp5/b4=
X-Gm-Gg: ASbGncu/7M52Vcro0kbPmNwERAwL2PtnbKYf5QTT+BkEdQOX8vpLnMf47ZvHeh1Dpse
	JknF0caB1uPXK7pi3nCOv/sS3FBhgDJZI44lqqUKFaxVj1O9GVaGG3dZVpiXnd8g4/gxkX1DJ+N
	ILj+7HE9nZ+RhsggIGrCIvRcGVH8A5kslvV7v0iyLjCNZtJwzNixoa56M9lkDiHdmcVTL4q3gVg
	RzvymGczIUqYlFWcJtTBqdK1QKfAHDUQAUEVf9v+fQXYkvq87VSWzPUiryUYlmXSNLR+s4X0Rss
	yDUjp9fA84x/Um44dV4Hg4uY6+WMS1VXdFOu6rdiDlp0QZsD4vh36q1rrN9oBM8JC/ZvAbuyttT
	brUl7IsmsVMCu9fSdFAYW6gIlzcMKZLnriG4/BTnKlYvD+0oFnOPppeLWxU+Luwdx3bNWSg==
X-Google-Smtp-Source: AGHT+IGFQNfflrxSoXLFnSus/BEHD479ifwfdhVpXjNkWU1UacD8ijw1jHX3iuARmyJ9ksBMTvfybg==
X-Received: by 2002:a17:90b:1e0f:b0:341:abd4:b9f5 with SMTP id 98e67ed59e1d1-341abd4c08emr3186130a91.6.1762379645534;
        Wed, 05 Nov 2025 13:54:05 -0800 (PST)
Received: from telecaster ([2620:10d:c090:500::7:5bbb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68bf37bsm3952646a91.7.2025.11.05.13.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:54:03 -0800 (PST)
Date: Wed, 5 Nov 2025 13:54:02 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Samir M <samir@linux.ibm.com>, linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, dimitri.ledkov@surgut.co.uk,
	stable@vger.kernel.org, Nicolas Schier <nsc@kernel.org>,
	Alexey Gladkov <legion@kernel.org>, linux-debuggers@vger.kernel.org
Subject: Re: [mainline]Error while running make modules_install command
Message-ID: <aQvHehCLxrXGcH5k@telecaster>
References: <7fef7507-ad64-4e51-9bb8-c9fb6532e51e@linux.ibm.com>
 <56905387-ec43-4f89-9146-0db6889e46ab@linux.ibm.com>
 <20251105005603.GA769905@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251105005603.GA769905@ax162>

On Tue, Nov 04, 2025 at 05:56:03PM -0700, Nathan Chancellor wrote:
> + Nicolas and Alexey, just as an FYI.
> 
> Top of thread is:
> 
> https://lore.kernel.org/7fef7507-ad64-4e51-9bb8-c9fb6532e51e@linux.ibm.com/
> 
> On Tue, Nov 04, 2025 at 04:54:38PM +0530, Venkat Rao Bagalkote wrote:
> > IBM CI has also reported this error.
> > 
> > 
> > Error:
> > 
> > 
> > depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname
> > prefix
> >   INSTALL /boot
> > depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname
> > prefix
> > depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname
> > prefix
> > 
> > 
> > Git bisect is pointing to below commit as first bad commit.
> > 
> > 
> > d50f21091358b2b29dc06c2061106cdb0f030d03 is the first bad commit
> > commit d50f21091358b2b29dc06c2061106cdb0f030d03
> > Author: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>
> > Date:   Sun Oct 26 20:21:00 2025 +0000
> > 
> >     kbuild: align modinfo section for Secureboot Authenticode EDK2 compat
> 
> Thank you for the bisect. I can reproduce this with at least kmod 29.1,
> which is the version I can see failing in drgn's CI from Ubuntu Jammy
> (but I did not see it with kmod 34, which is the latest version in Arch
> Linux at the moment).
> 
> Could you and Omar verify if the following diff resolves the error for
> you? I think this would allow us to keep Dimitri's fix for the
> Authenticode EDK2 calculation (i.e., the alignment) while keeping kmod
> happy. builtin.modules.modinfo is the same after this diff as it was
> before Dimitri's change for me.
> 
> Cheers,
> Nathan
> 
> diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
> index ced4379550d7..c3f135350d7e 100644
> --- a/scripts/Makefile.vmlinux
> +++ b/scripts/Makefile.vmlinux
> @@ -102,11 +102,23 @@ vmlinux: vmlinux.unstripped FORCE
>  # modules.builtin.modinfo
>  # ---------------------------------------------------------------------------
>  
> +# .modinfo in vmlinux is aligned to 8 bytes for compatibility with tools that
> +# expect sufficiently aligned sections but the additional NULL bytes used for
> +# padding to satisfy this requirement break certain versions of kmod with
> +#
> +#   depmod: ERROR: kmod_builtin_iter_next: unexpected string without modname prefix
> +#
> +# Strip the trailing padding bytes after extracting the .modinfo sections to
> +# comply with what kmod expects to parse.
> +quiet_cmd_modules_builtin_modinfo = GEN     $@
> +      cmd_modules_builtin_modinfo = $(cmd_objcopy); \
> +                                    sed -i 's/\x00\+$$/\x00/g' $@
> +
>  OBJCOPYFLAGS_modules.builtin.modinfo := -j .modinfo -O binary
>  
>  targets += modules.builtin.modinfo
>  modules.builtin.modinfo: vmlinux.unstripped FORCE
> -	$(call if_changed,objcopy)
> +	$(call if_changed,modules_builtin_modinfo)
>  
>  # modules.builtin
>  # ---------------------------------------------------------------------------

Thanks for the quick fix, this worked for me on a machine with kmod
version 28.

Tested-by: Omar Sandoval <osandov@fb.com>

Thanks,
Omar

