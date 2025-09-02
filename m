Return-Path: <stable+bounces-176939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CCCB3F6BA
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 09:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859CA16F01A
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 07:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B315C2E7167;
	Tue,  2 Sep 2025 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcwEE84K"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52722E6CDD
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798206; cv=none; b=LaCIH7jPHBAIBKFukNEXhmqNb0mAN3D0EoGzamwAEeoRfb8nuTaIdJx1ITYizcCZEy2HgRDBynf1gMqj1SWPM279Y1J0tVGoj1QbSDqCGnO4GqNqL+dCyf2TKcpFT3zfE7si9HMNlPkk+z6jFl+rJAGCA3B+gpClsEig6FtFAH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798206; c=relaxed/simple;
	bh=2n/SisMV09Hm94CbM/DLU+eQEpBb/49IdprBdPzTK3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbrNJdWb2s8dpBcyhPqZdHcS4CCgpjMcOzfOqj4/HNAcBhhGCK5bCpD0G/+rjzntKjpZIfZArQ5o0qLeQlxtdstyD+JJ4OX6ma32PJti1SsdgvLEaMGZgm8OejA9+0Oo/AXPcgMqZwBBx/tHR0jJZHouciiKh3elai6dQzK+NuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcwEE84K; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61caf8fc422so8909514a12.2
        for <stable@vger.kernel.org>; Tue, 02 Sep 2025 00:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756798203; x=1757403003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx2F/ziatheZ/yDLUW5J1nHGpoaepympUGoXb3XJsW8=;
        b=GcwEE84K+jfrJN2riFJVPC5zA3ykDfAnGnuoSNwso2C/6B76ZkCJXqOq0a6byRt4HV
         NzR/dG71zDR2IgLEFCr4xxPAFvA9Yo+6EEUE5LfAh+ie6FNfocY1hPUQbL2ESHu63yGs
         Ept0/S8vp0wWPDXApOezHlkf66Oe8aDZLDg/Djl2BA+0xbcwi4PCACvTRiEe4TztDq73
         AJwG7iwqyZOoHRtmXcGNDqIjtabMQfb5lFIRBJTg+mcnfRaj1mXLyzVltSncgYsmnY0Z
         0TvTPorKBXQ0Atw/RuPTUnKvp7dxBT7j7i0PJHgrJhv//JgLL6ka1HQRJQblEjU07+OD
         zKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756798203; x=1757403003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jx2F/ziatheZ/yDLUW5J1nHGpoaepympUGoXb3XJsW8=;
        b=fOb2c552yHqO2qVDqP/Ep4MpGIG5fI3VLICl9a7RlgVsBXr53TCtH1/aPd27c2/OK9
         2pb+dh0IRV62OOAmeZkED9vLhJaJ8Stob1urn3tWRS7SPsI+jKYMsHr0SShovxtGOMx1
         4AxY4OzN6IWpVqAsh9YthjyICSQitUvOpIFDL7hdUFKnNHejlpp6zYcLhMHDOXXQaY93
         3KKst5kTOrhhuApcmJsMM/dS8LQaiCuzqagMFAU2GacXl4uNASJAF3KjrngtsU828nr1
         xF8OceRoOG6qg62gqfv1u0gA6kdunBatOHK+ePFmB4W8MuO4Xvv/g+qlpWxELyOTHbyq
         Mi7A==
X-Forwarded-Encrypted: i=1; AJvYcCWbBPZ33oxvs2zXtHYy4mTUWOqGYZapz9NZqIw3OewcEaJNiGiQt0uGPdy8njLPsOPPTZ4PmM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjdJKJWFDbGF7QezYpjoG/KUpBGq58leZPRXtKRGKVn9lYjF9B
	uNLRcpCZZipyfe6yW0RiLOoUglJKvss29ckZRCogM+4dGmRAQQS2+hVnBhoeRuwrBsF6xLJoycH
	mz+iW9yckrfe38va829b5u4vi5HR0y9A=
X-Gm-Gg: ASbGncttj/9Fr40f42Oll1D6M3nL4UNcQaBJk2VdFK/rySwX81SKDVbULHO1NSex3ql
	0k/gRA0jTeI+wdkUlovpaaYk17A7BUrnGO1aJ+fBqA7A63aC0E6MhU16j8a+cpPiwyshx0D/JTT
	UIGzkpUS2veBiOx6OAVtcWOlrWP7O0yzyoMzLazPw7du9kqvKTi77mgNlJjVZTRqLnE94BdhoqG
	Ur4uAs=
X-Google-Smtp-Source: AGHT+IGrqDVYtQAWyZAjkQeNO80jGrHFAyTANY25G2+Q6rAh2gqJ1LnU6F0ka2DjwSH1oiWYFHwAKBwZxlEiujPkudw=
X-Received: by 2002:a05:6402:51cb:b0:618:2733:1a52 with SMTP id
 4fb4d7f45d1cf-61d26997500mr8458024a12.8.1756798202674; Tue, 02 Sep 2025
 00:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025011112-racing-handbrake-a317@gregkh> <20250901153559.14799-1-nmanthey@amazon.de>
 <20250901153559.14799-2-nmanthey@amazon.de> <2025090114-bodacious-daffodil-2f2e@gregkh>
 <2025090116-repent-living-b7de@gregkh> <ac90cc6067bc7a50d7eb0d606b3dc3718f35b9d9.camel@amazon.de>
In-Reply-To: <ac90cc6067bc7a50d7eb0d606b3dc3718f35b9d9.camel@amazon.de>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 2 Sep 2025 09:29:50 +0200
X-Gm-Features: Ac12FXw5df76rHZEaiiW3AYx94duqeS25Kc4HsjtpB445hEyTIfABLzc53iIEmo
Message-ID: <CAOQ4uxgmc0jexG4uiKT-6rYriqucB6egeFOj0CUUHQQOdg7J4g@mail.gmail.com>
Subject: Re: [PATCH 6.1.y 1/1] fs: relax assertions on failure to encode file handles
To: "Manthey, Norbert" <nmanthey@amazon.de>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, 
	"syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com" <syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com>, 
	"dima@arista.com" <dima@arista.com>, "Yagmurlu, Oemer Erdinc" <oeygmrl@amazon.de>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 9:20=E2=80=AFAM Manthey, Norbert <nmanthey@amazon.de=
> wrote:
>
> On Mon, 2025-09-01 at 22:00 +0200, Greg Kroah-Hartman wrote:
> > CAUTION: This email originated from outside of the organization. Do not=
 click links or open
> > attachments unless you can confirm the sender and know the content is s=
afe.
> >
> >
> >
> > On Mon, Sep 01, 2025 at 09:54:03PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Sep 01, 2025 at 03:35:59PM +0000, Norbert Manthey wrote:
> > > > From: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > commit 974e3fe0ac61de85015bbe5a4990cf4127b304b2 upstream.
> > > >
> > > > Encoding file handles is usually performed by a filesystem >encode_=
fh()
> > > > method that may fail for various reasons.
> > > >
> > > > The legacy users of exportfs_encode_fh(), namely, nfsd and
> > > > name_to_handle_at(2) syscall are ready to cope with the possibility
> > > > of failure to encode a file handle.
> > > >
> > > > There are a few other users of exportfs_encode_{fh,fid}() that
> > > > currently have a WARN_ON() assertion when ->encode_fh() fails.
> > > > Relax those assertions because they are wrong.
> > > >
> > > > The second linked bug report states commit 16aac5ad1fa9 ("ovl: supp=
ort
> > > > encoding non-decodable file handles") in v6.6 as the regressing com=
mit,
> > > > but this is not accurate.
> > > >
> > > > The aforementioned commit only increases the chances of the asserti=
on
> > > > and allows triggering the assertion with the reproducer using overl=
ayfs,
> > > > inotify and drop_caches.
> > > >
> > > > Triggering this assertion was always possible with other filesystem=
s and
> > > > other reasons of ->encode_fh() failures and more particularly, it w=
as
> > > > also possible with the exact same reproducer using overlayfs that i=
s
> > > > mounted with options index=3Don,nfs_export=3Don also on kernels < v=
6.6.
> > > > Therefore, I am not listing the aforementioned commit as a Fixes co=
mmit.
> > > >
> > > > Backport hint: this patch will have a trivial conflict applying to
> > > > v6.6.y, and other trivial conflicts applying to stable kernels < v6=
.6.
> > > >
> > > > Reported-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
> > > > Tested-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
> > > > Closes: https://lore.kernel.org/linux-unionfs/671fd40c.050a0220.473=
5a.024f.GAE@google.com/
> > > > Reported-by: Dmitry Safonov <dima@arista.com>
> > > > Closes: https://lore.kernel.org/linux-
> > > > fsdevel/CAGrbwDTLt6drB9eaUagnQVgdPBmhLfqqxAf3F+Juqy_o6oP8uw@mail.gm=
ail.com/
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > Link: https://lore.kernel.org/r/20241219115301.465396-1-amir73il@gm=
ail.com
> > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> > > I never signed off on the original commit, so why was this added?
>
> This cherry-pick is not for the upstream commit, but for the backport on =
the 6.6 tree. The
> respective commit hash is given in the backport line. Is this additional =
information you would like
> to have in the commit message?
>
> > >
> > > >
> > > > (fuzzy picked from commit f47c834a9131ae64bee3c462f4e610c67b0a000f)
> > > > Applied with LLM-adjusted hunks for 1 functions from us.amazon.nova
> > > > - Changed the function call from `exportfs_encode_fid` to `exportfs=
_encode_inode_fh` to match
> > > > the destination code.
> >
> > Wait, that was just fuzz matching, the real body didn't even change.
> >
> > > > - Removed the warning message as per the patch.
> >
> > I do not understand this change, what exactly was this?
>
> I need to rewrite (here: drop) this manually. The LLM was also describing=
 the content of the
> original patch, not only the diff it created.
>
> >
> > > Please put this in the proper place, and in the proper format, if you
> > > want to add "notes" to the backport.
>
> IIUC, the changes applied to the patch so that it applies should come abo=
ve my SOB, no? What's the
> format requirement (except the 80-100 char limit)?
>
> I am aware of the discussions about AI generated code. I wanted to explic=
itly mention the AI use, if
> it was used as backporting helper. Do you suggest to still move this into=
 the notes section of the
> commit and sent patch, instead of having this in the commit itself?
>
> > >
> > > But really, it took a LLM to determine an abi change?  That feels lik=
e
> > > total overkill as you then had to actually manually check it as well.
> > > But hey, it's your cpu cycles to burn, not mine...
>
> I prefer reviewing the code instead of writing/massaging all of it, and o=
n success have the change
> tested/validated automatically before I reviewing.
>
> >
> >
> > Again, total overkill, 1 minute doing a simple git merge resolution
> > would have done the same thing, right?
>

1 minute is a lot of time when multiplied by the number of "almost
cleanly applied"
backports ;)

> For this example, yes, I agree. There are more complex commits where this=
 works as well.
>
> >
> > confused as to why this took a whole new tool?  We have good merge
> > resolution tools for git these days, what's wrong with using one of the
> > many ones out there?
>
> There is nothing wrong using any other tool. The git-llm-pick tool allows=
 to automatically backport
> more commits and supports user specified validation for the changes. The =
LLM is only the last
> attempt. A human needs to review the output either way, and eventually do=
 the
> backport interactively.
>

First of all, this is not the first project that attempts to apply
"semantic" patches
that can deal with a lot more fuzz than git apply can. Long before the LLM =
buzz.

I personally find LLM to be quite useful for some of the more boring
of my tasks.
Translation and understanding semantics is what LLM does best, so deploying
it for stable backports could be very productive IMO, as long as the
result is tested
reviewed and signed off by a human developer who understands what the patch
is doing.

Thanks,
Amir.

