Return-Path: <stable+bounces-18787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A61E2848F95
	for <lists+stable@lfdr.de>; Sun,  4 Feb 2024 18:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF84282EB2
	for <lists+stable@lfdr.de>; Sun,  4 Feb 2024 17:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D37F22F13;
	Sun,  4 Feb 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8MbO1Au"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487811DFD1
	for <stable@vger.kernel.org>; Sun,  4 Feb 2024 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707066311; cv=none; b=Yg/G7ugra8gyLIw7OSqnwR0F7ZZmTFGaVWQChaZ7lVl6lutnoHIMZ/d1U5C3etCRkMtL6E7LyTDGrCv+AHmJ7Oo6GKfT4hmqqrJliCYHVoHu/qqFSr9c+C34GVOictACLv/C19RmwOeqpfZuPTpqMeqBsCHGsMr8ApZ9e8x4Z0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707066311; c=relaxed/simple;
	bh=OJY2Z7GeLF5gRMgZ6b4Eh8+Cp0hyoE5Ou4mz6Ggp1lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3VifVGnuB8Ifa41bv5XWk2Lm8vcYLbzWOvPlZzU6ji16Ita2kAQ3TYPTcpE65gR86yIO58BKmhAEH3q96y1aUYZBw+lJ/Gi+DZedkDQYkuJE4K8JgIrL0+6NOE0UkY0WWbyXh5b93qgt/J4jOgVcz/J+7TIXRJJpskX0XZdmR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8MbO1Au; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fd446d4ceso7542745e9.2
        for <stable@vger.kernel.org>; Sun, 04 Feb 2024 09:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707066307; x=1707671107; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eJMhgOzGwLI5F/l/xOOqs7PhILelC0Armbxpu9oooo8=;
        b=L8MbO1Au0oQOM4vz5BcDgEgzy+flyevmNiifHA9o6HpdFJbliBIc/Zmm1shDxF658q
         nhzcetmxZZk3fWaOlqCDChtzTUXTdTAaRRGKGfsnHRfe0juqzPAD3/jrZWUAqxAQN4b8
         V91IWDEKcPhdSrCV8Eyx4uQNj9hLH2n/ZsIQfgNRGyWFDcphkEGJcErwqSAJkWQDdbdw
         IfG5LtcQ9jOo7p69ZPlPteMI/ctbBOh6OIPmiBYZ9DWgW6fMg24f+Po3xgkP8RVAYr2i
         Sf3CuhfHB93BJeMy9uzBuoj53WKvao5wEB4wMnuN7H2y4n3+ir1ULp/pYKMjrEGolMHk
         OM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707066307; x=1707671107;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJMhgOzGwLI5F/l/xOOqs7PhILelC0Armbxpu9oooo8=;
        b=u2/NwxOx4Mg9RYLBd0GyovDzfNAWA1+eKPqeqAjdfOkey8blUY60nucqraauSyLQim
         1/rBKEoep5m7ixv3mkTW5QBY40DrpOqE+IEIPcp3BinQwNCDUpJ3EGUCuVd7Wk5sy5dq
         zHfuFoSabBK4dkLU5quqQeMUX+wsv4P7ibmMO1gBVGmdQnGfsVKHMgJ6yJpyTqWz7JYh
         mK/NcLrEEz/kvmtIPU0NAhD4D4J+2CE1Ye2V2UdvGaIakfm+07nwhr5G0x8C2v4Wx4l2
         eVsEgVf6x2rlb1DqKknyz5h1jsv1vaxPbNp9KoREnt8R3Dj6CfDUCekry5jaS52CF+ws
         Pr2w==
X-Gm-Message-State: AOJu0YwiEwTBB5mavbzvJ8yJO1ccOPJYR3USGZ8fX53d1WRM6/Dir308
	uJZDf68Nve45Py1Kscx930dxFUfk3viqRYXYLQQB2LBjRNfMdZpn
X-Google-Smtp-Source: AGHT+IEbYGGTE5h5lNAVVelk18KpMSi3Sl8/srRpgopRFpHyGNcWRmKPwHIja1uEABVbpME6hrgIdw==
X-Received: by 2002:a05:600c:1c06:b0:40e:f9df:3531 with SMTP id j6-20020a05600c1c0600b0040ef9df3531mr3118876wms.8.1707066307149;
        Sun, 04 Feb 2024 09:05:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUSePcdbCXDf+NVAqWVarrU5Nb3YJiaR7nwnSHBECX4UAhzn8mOzE2eiJeiFRZ0/EkHLCr79RKxOCBtvaTvi3x2yoh5HG08pMyFRD3d/zznkiFBEY9E4H9XS/59cEKlMplBfcxuj8rKDZwb+SKDWjOWbjWD2alySye0UafClgYa41LB/bzxI2PKzYctGmGFMMz2Vm7jbY/0OqLGHY5qnx57nU2lTTgce2jJS/x2aFoT2LCAHqpgpxBz5pVN/ot80iPGZH6YL2Tu/ok=
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id z7-20020a05600c0a0700b0040ee2460966sm6158845wmp.24.2024.02.04.09.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 09:05:06 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id B8590BE2DE0; Sun,  4 Feb 2024 18:05:05 +0100 (CET)
Date: Sun, 4 Feb 2024 18:05:05 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Justin Forbes <jforbes@fedoraproject.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, stable@vger.kernel.org,
	patches@lists.linux.dev, Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 6.6 003/331] docs: kernel_feat.py: fix potential command
 injection
Message-ID: <Zb_DwdZ3PUr1VbBg@eldamar.lan>
References: <20240129170014.969142961@linuxfoundation.org>
 <20240129170015.067909940@linuxfoundation.org>
 <ZbkfGst991YHqJHK@fedora64.linuxtx.org>
 <87h6iudc7j.fsf@meer.lwn.net>
 <CAFbkSA2tft--ejgJ58o3G-OxNqnm-C6fK4-kXThsN92NYF8V0A@mail.gmail.com>
 <2024020151-purchase-swerve-a3b3@gregkh>
 <CAFbkSA25o88DjaWHc3GRk5vkvANnpi-NJ61XJudz4=ARTyrhtw@mail.gmail.com>
 <CAFbkSA3M74kvF+v_URm593xSnJTVzeKmy2K6dw0WQYw7BDdwmg@mail.gmail.com>
 <CAFbkSA3vHDn-Pk9fB6PbWeniGHH6W3bo=jQ9utE9xh88S8bzxA@mail.gmail.com>
 <1a160e5f-d5ce-4711-b683-808ab87b289b@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a160e5f-d5ce-4711-b683-808ab87b289b@oracle.com>

Hi,

On Thu, Feb 01, 2024 at 05:34:25PM +0100, Vegard Nossum wrote:
> 
> On 01/02/2024 16:07, Justin Forbes wrote:
> > On Thu, Feb 1, 2024 at 8:58 AM Justin Forbes <jforbes@fedoraproject.org> wrote:
> > > On Thu, Feb 1, 2024 at 8:41 AM Justin Forbes <jforbes@fedoraproject.org> wrote:
> > > > On Thu, Feb 1, 2024 at 8:25 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > > On Thu, Feb 01, 2024 at 06:43:46AM -0600, Justin Forbes wrote:
> > > > > > On Tue, Jan 30, 2024 at 10:21 AM Jonathan Corbet <corbet@lwn.net> wrote:
> > > > > > > Justin Forbes <jforbes@fedoraproject.org> writes:
> > > > > > > > On Mon, Jan 29, 2024 at 09:01:07AM -0800, Greg Kroah-Hartman wrote:
> > > > > > > > > 6.6-stable review patch.  If anyone has any objections, please let me know.
> > > > > > > > > 
> > > > > > > > > ------------------
> > > > > > > > > 
> > > > > > > > > From: Vegard Nossum <vegard.nossum@oracle.com>
> > > > > > > > > 
> > > > > > > > > [ Upstream commit c48a7c44a1d02516309015b6134c9bb982e17008 ]
> > > > > > > > > 
> > > > > > > > > The kernel-feat directive passes its argument straight to the shell.
> > > > > > > > > This is unfortunate and unnecessary.
> 
> [...]
> 
> > > > > > > > This patch seems to be missing something. In 6.6.15-rc1 I get a doc
> > > > > > > > build failure with:
> > > > > > > > 
> > > > > > > > /builddir/build/BUILD/kernel-6.6.14-332-g1ff49073b88b/linux-6.6.15-0.rc1.1ff49073b88b.200.fc39.noarch/Documentation/sphinx/kerneldoc.py:133: SyntaxWarning: invalid escape sequence '\.'
> > > > > > > >    line_regex = re.compile("^\.\. LINENO ([0-9]+)$")
> > > > > > > 
> > > > > > > Ah ... you're missing 86a0adc029d3 (Documentation/sphinx: fix Python
> > > > > > > string escapes).  That is not a problem with this patch, though; I would
> > > > > > > expect you to get the same error (with Python 3.12) without.
> > > > > > 
> > > > > > Well, it appears that 6.6.15 shipped anyway, with this patch included,
> > > > > > but not with 86a0adc029d3.  If anyone else builds docs, this thread
> > > > > > should at least show them the fix.  Perhaps we can get the missing
> > > > > > patch into 6.6.16?
> > > > > 
> > > > > Sure, but again, that should be independent of this change, right?
> > > > 
> > > > I am not sure I would say independent. This particular change causes
> > > > docs to fail the build as I mentioned during rc1.  There were no
> > > > issues building 6.6.14 or previous releases, and no problem building
> > > > 6.7.3.
> > > 
> > > I can confirm that adding this patch to 6.6.15 makes docs build again.
> > 
> > I lied, it just fails slightly differently. Some of the noise is gone,
> > but we still have:
> > Sphinx parallel build error:
> > UnboundLocalError: cannot access local variable 'fname' where it is
> > not associated with a value
> > make[2]: *** [Documentation/Makefile:102: htmldocs] Error 2
> > make[1]: *** [/builddir/build/BUILD/kernel-6.6.15/linux-6.6.15-200.fc39.noarch/Makefile:1715:
> > htmldocs] Error 2
> 
> The old version of the script unconditionally assigned a value to the
> local variable 'fname' (not a value that makes sense to me, since it's
> literally assigning the whole command, not just a filename, but that's a
> separate issue), and I removed that so it's only conditionally assigned.
> This is almost certainly a bug in my patch.
> 
> I'm guessing maybe a different patch between 6.6 and current mainline is
> causing 'fname' to always get assigned for the newer versions and thus
> make the run succeed, in spite of the bug.
> 
> Something like the patch below (completely untested) should restore the
> previous behaviour, but I'm not convinced it's correct.
> 
> 
> Vegard
> 
> diff --git a/Documentation/sphinx/kernel_feat.py
> b/Documentation/sphinx/kernel_feat.py
> index b9df61eb4501..15713be8b657 100644
> --- a/Documentation/sphinx/kernel_feat.py
> +++ b/Documentation/sphinx/kernel_feat.py
> @@ -93,6 +93,8 @@ class KernelFeat(Directive):
>          if len(self.arguments) > 1:
>              args.extend(['--arch', self.arguments[1]])
> 
> +        fname = ' '.join(args)
> +
>          lines = subprocess.check_output(args,
> cwd=os.path.dirname(doc.current_source)).decode('utf-8')
> 
>          line_regex = re.compile(r"^\.\. FILE (\S+)$")

We have as well a documention build problem in Debian, cf.
https://buildd.debian.org/status/fetch.php?pkg=linux&arch=all&ver=6.6.15-1&stamp=1707050360&raw=0
though not yet using python 3.12 as default.

Your above change seems to workaround the issue in fact, but need to
do a full build yet.

Regards,
Salvatore

