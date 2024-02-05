Return-Path: <stable+bounces-18805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134C684926E
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 03:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC7E1C21EDF
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 02:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F666635;
	Mon,  5 Feb 2024 02:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="ExX0Oboy"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711C98F40
	for <stable@vger.kernel.org>; Mon,  5 Feb 2024 02:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707100602; cv=none; b=GTexpXuSCK5soqCVPu3KrSItcsc3/X9aO2JuwScROj/bYZ47UDbgTCfYQA4fi4/BxoWkmb5dLnVkavKINv56hquBqL/krSNWnpiRNefWzobLaXcx0hPQNPDYdheJf0TWk51JxTctE8kobY/st4vePalNxs03qI18xDJCo3sRAeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707100602; c=relaxed/simple;
	bh=moawmu/R7SkvIszsNA58WWtFqtAPtbcjuG7SFFT/lew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rtn++yJI3zZWoVr58M+q3G00/qUxhVEDP5rfMdWPTWBALcJ+7/dnbie/Cj79eubI7plg0HubYPnNz5+6wYjkOV2xg/ljI+AXpEut6aKtM0xlSPA9joJAN+note17xRhc6yW1p+qj9mTADx7C3yvdxxAmPs/gDL8G/nQ4+nkQXB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=ExX0Oboy; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-363afc38a1cso8917285ab.3
        for <stable@vger.kernel.org>; Sun, 04 Feb 2024 18:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1707100599; x=1707705399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qU9GWODvVKB+EFUVXJYWQXMFFmQ70Fyp511xtLl9Zc=;
        b=ExX0Oboy0lc7ndQ1/6jdMKOlNoyZ3iQKW52WDmK9P8u5KOh4UqD9KD5rfyCRuQ+ir+
         fQCd71PU1oCHjWEHRJJW19pDgzzh0ESRPxkNFJp8H0AIBYcCAmaur7RMdMt3KnrkRXp5
         SZrkqsAWuXCWNQx1dA9NrHaLk7JMDc/swiC1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707100599; x=1707705399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8qU9GWODvVKB+EFUVXJYWQXMFFmQ70Fyp511xtLl9Zc=;
        b=QYpFbiRddMRVD80Ej3HVcD7hfmeBdB4ma/yrRJ9LcSg2HFnZdjQtdAPg/anEvIto43
         CFz86TF2UrpDlSyFNA73NFDN2GJcKNIoEuHFCSK1EQDMgJoEbGgucsLTbWBAv0kb6Meu
         KPLvAgKfAxV6Hq3R9tBtj4LFT1hGwGNJyqVhxBtlMFIvI5zm6vcKuyNj1EBsZbtzJDxe
         l1c0sOoZ6pInHgLHjSsERzsIImoKVKM4F4Fwj+YQlCQO8IDftsqrNAlQz7ZxcQSU5XMV
         k2tadPRzWSCeokovitI29KyDprS1UNVL3vpBaeSAYtzJdWKe/lOwrNuwBM5AVj4cUBQ6
         TURg==
X-Gm-Message-State: AOJu0YzZoDsGOPb9giOSJVXh0JF1hJQgDOE7iDmsRZQ7ud1bPuAASRD8
	WUyE0Yhralw9mhvhZx0pQw0usIBigKBBblQR+DcjQ4GlnIi6dFg+7lEWpjIGFNxUTPUpZg4pybI
	Tvw==
X-Google-Smtp-Source: AGHT+IFXp/tQHaqKFqsOz0WWXfZ6ponFRPtFelvcvnecMgjx5ZnysvgSrQPArEZHimh0TtuygwwxQw==
X-Received: by 2002:a92:d842:0:b0:363:c1e5:300b with SMTP id h2-20020a92d842000000b00363c1e5300bmr4649198ilq.11.1707100599134;
        Sun, 04 Feb 2024 18:36:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXinqwjmdDC8qd896cj+Z5HReJfw++cbCq2QahpniAYdKF872g4o125P4O51y79/fDqd92Nv/fWVuLYzie2B64cEEnpk8AB
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id o4-20020a056638124400b00471261d7d5dsm699838jas.19.2024.02.04.18.36.38
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 18:36:38 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-363c503de95so2628035ab.2
        for <stable@vger.kernel.org>; Sun, 04 Feb 2024 18:36:38 -0800 (PST)
X-Received: by 2002:a92:c612:0:b0:363:8560:977d with SMTP id
 p18-20020a92c612000000b003638560977dmr9984128ilm.3.1707100597756; Sun, 04 Feb
 2024 18:36:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbkfGst991YHqJHK@fedora64.linuxtx.org> <87h6iudc7j.fsf@meer.lwn.net>
 <CAFbkSA2tft--ejgJ58o3G-OxNqnm-C6fK4-kXThsN92NYF8V0A@mail.gmail.com>
 <2024020151-purchase-swerve-a3b3@gregkh> <CAFbkSA25o88DjaWHc3GRk5vkvANnpi-NJ61XJudz4=ARTyrhtw@mail.gmail.com>
 <CAFbkSA3M74kvF+v_URm593xSnJTVzeKmy2K6dw0WQYw7BDdwmg@mail.gmail.com>
 <CAFbkSA3vHDn-Pk9fB6PbWeniGHH6W3bo=jQ9utE9xh88S8bzxA@mail.gmail.com>
 <1a160e5f-d5ce-4711-b683-808ab87b289b@oracle.com> <Zb_DwdZ3PUr1VbBg@eldamar.lan>
 <Zb_0NEeCqok8icwz@eldamar.lan> <2024020402-scotch-upchuck-9e11@gregkh>
In-Reply-To: <2024020402-scotch-upchuck-9e11@gregkh>
From: Justin Forbes <jforbes@fedoraproject.org>
Date: Sun, 4 Feb 2024 20:36:26 -0600
X-Gmail-Original-Message-ID: <CAFbkSA08Wo-rWJiOXf4BmNu_nXFX6gQriW5J09L8KzSHUU1j9g@mail.gmail.com>
Message-ID: <CAFbkSA08Wo-rWJiOXf4BmNu_nXFX6gQriW5J09L8KzSHUU1j9g@mail.gmail.com>
Subject: Re: [PATCH 6.6 003/331] docs: kernel_feat.py: fix potential command injection
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Jonathan Corbet <corbet@lwn.net>, stable@vger.kernel.org, patches@lists.linux.dev, 
	Jani Nikula <jani.nikula@intel.com>, Sasha Levin <sashal@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 7:29=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Feb 04, 2024 at 09:31:48PM +0100, Salvatore Bonaccorso wrote:
> > On Sun, Feb 04, 2024 at 06:05:05PM +0100, Salvatore Bonaccorso wrote:
> > > Hi,
> > >
> > > On Thu, Feb 01, 2024 at 05:34:25PM +0100, Vegard Nossum wrote:
> > > >
> > > > On 01/02/2024 16:07, Justin Forbes wrote:
> > > > > On Thu, Feb 1, 2024 at 8:58=E2=80=AFAM Justin Forbes <jforbes@fed=
oraproject.org> wrote:
> > > > > > On Thu, Feb 1, 2024 at 8:41=E2=80=AFAM Justin Forbes <jforbes@f=
edoraproject.org> wrote:
> > > > > > > On Thu, Feb 1, 2024 at 8:25=E2=80=AFAM Greg Kroah-Hartman
> > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > > On Thu, Feb 01, 2024 at 06:43:46AM -0600, Justin Forbes wro=
te:
> > > > > > > > > On Tue, Jan 30, 2024 at 10:21=E2=80=AFAM Jonathan Corbet =
<corbet@lwn.net> wrote:
> > > > > > > > > > Justin Forbes <jforbes@fedoraproject.org> writes:
> > > > > > > > > > > On Mon, Jan 29, 2024 at 09:01:07AM -0800, Greg Kroah-=
Hartman wrote:
> > > > > > > > > > > > 6.6-stable review patch.  If anyone has any objecti=
ons, please let me know.
> > > > > > > > > > > >
> > > > > > > > > > > > ------------------
> > > > > > > > > > > >
> > > > > > > > > > > > From: Vegard Nossum <vegard.nossum@oracle.com>
> > > > > > > > > > > >
> > > > > > > > > > > > [ Upstream commit c48a7c44a1d02516309015b6134c9bb98=
2e17008 ]
> > > > > > > > > > > >
> > > > > > > > > > > > The kernel-feat directive passes its argument strai=
ght to the shell.
> > > > > > > > > > > > This is unfortunate and unnecessary.
> > > >
> > > > [...]
> > > >
> > > > > > > > > > > This patch seems to be missing something. In 6.6.15-r=
c1 I get a doc
> > > > > > > > > > > build failure with:
> > > > > > > > > > >
> > > > > > > > > > > /builddir/build/BUILD/kernel-6.6.14-332-g1ff49073b88b=
/linux-6.6.15-0.rc1.1ff49073b88b.200.fc39.noarch/Documentation/sphinx/kerne=
ldoc.py:133: SyntaxWarning: invalid escape sequence '\.'
> > > > > > > > > > >    line_regex =3D re.compile("^\.\. LINENO ([0-9]+)$"=
)
> > > > > > > > > >
> > > > > > > > > > Ah ... you're missing 86a0adc029d3 (Documentation/sphin=
x: fix Python
> > > > > > > > > > string escapes).  That is not a problem with this patch=
, though; I would
> > > > > > > > > > expect you to get the same error (with Python 3.12) wit=
hout.
> > > > > > > > >
> > > > > > > > > Well, it appears that 6.6.15 shipped anyway, with this pa=
tch included,
> > > > > > > > > but not with 86a0adc029d3.  If anyone else builds docs, t=
his thread
> > > > > > > > > should at least show them the fix.  Perhaps we can get th=
e missing
> > > > > > > > > patch into 6.6.16?
> > > > > > > >
> > > > > > > > Sure, but again, that should be independent of this change,=
 right?
> > > > > > >
> > > > > > > I am not sure I would say independent. This particular change=
 causes
> > > > > > > docs to fail the build as I mentioned during rc1.  There were=
 no
> > > > > > > issues building 6.6.14 or previous releases, and no problem b=
uilding
> > > > > > > 6.7.3.
> > > > > >
> > > > > > I can confirm that adding this patch to 6.6.15 makes docs build=
 again.
> > > > >
> > > > > I lied, it just fails slightly differently. Some of the noise is =
gone,
> > > > > but we still have:
> > > > > Sphinx parallel build error:
> > > > > UnboundLocalError: cannot access local variable 'fname' where it =
is
> > > > > not associated with a value
> > > > > make[2]: *** [Documentation/Makefile:102: htmldocs] Error 2
> > > > > make[1]: *** [/builddir/build/BUILD/kernel-6.6.15/linux-6.6.15-20=
0.fc39.noarch/Makefile:1715:
> > > > > htmldocs] Error 2
> > > >
> > > > The old version of the script unconditionally assigned a value to t=
he
> > > > local variable 'fname' (not a value that makes sense to me, since i=
t's
> > > > literally assigning the whole command, not just a filename, but tha=
t's a
> > > > separate issue), and I removed that so it's only conditionally assi=
gned.
> > > > This is almost certainly a bug in my patch.
> > > >
> > > > I'm guessing maybe a different patch between 6.6 and current mainli=
ne is
> > > > causing 'fname' to always get assigned for the newer versions and t=
hus
> > > > make the run succeed, in spite of the bug.
> > > >
> > > > Something like the patch below (completely untested) should restore=
 the
> > > > previous behaviour, but I'm not convinced it's correct.
> > > >
> > > >
> > > > Vegard
> > > >
> > > > diff --git a/Documentation/sphinx/kernel_feat.py
> > > > b/Documentation/sphinx/kernel_feat.py
> > > > index b9df61eb4501..15713be8b657 100644
> > > > --- a/Documentation/sphinx/kernel_feat.py
> > > > +++ b/Documentation/sphinx/kernel_feat.py
> > > > @@ -93,6 +93,8 @@ class KernelFeat(Directive):
> > > >          if len(self.arguments) > 1:
> > > >              args.extend(['--arch', self.arguments[1]])
> > > >
> > > > +        fname =3D ' '.join(args)
> > > > +
> > > >          lines =3D subprocess.check_output(args,
> > > > cwd=3Dos.path.dirname(doc.current_source)).decode('utf-8')
> > > >
> > > >          line_regex =3D re.compile(r"^\.\. FILE (\S+)$")
> > >
> > > We have as well a documention build problem in Debian, cf.
> > > https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&arch=3Dall&ver=
=3D6.6.15-1&stamp=3D1707050360&raw=3D0
> > > though not yet using python 3.12 as default.
> > >
> > > Your above change seems to workaround the issue in fact, but need to
> > > do a full build yet.
> >
> > For Debian I'm temporarily reverting from the 6.6.15 upload:
> >
> > e961f8c6966a ("docs: kernel_feat.py: fix potential command injection")
> >
> > This is not the best solution, but unbreaks several other builds.
> >
> > The alternative would be to apply Vegard's workaround or the proper
> > solution for that.
>
> What is the "proper" solution here?  Does 6.8-rc3 work?  What are we
> missing to be backported here?

I am not sure what the "proper"fix was, but as I mentioned with
6.6.15, this patch broke the build with 6.6.15, but 6.7.3 and newer
were fine.  I think the fix came in through another path incidentally,
but Vegard mentioned a possible fox for 6.6 kernels.  Realistically,
Fedora has moved on to 6.7.x now, but I do still test 6.6.x stable rcs
and while I reported that 6.6.16 was good, it was only because I saw
no regressions from 6.6.15. The docs failure from this patch still
exists.

Justin

> thanks,
>
> greg k-h
>

