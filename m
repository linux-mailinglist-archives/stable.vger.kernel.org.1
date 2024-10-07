Return-Path: <stable+bounces-81249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9DE992A27
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 13:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490321F233D3
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 11:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D60E1BA86C;
	Mon,  7 Oct 2024 11:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzFq3Zos"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EB32AD05;
	Mon,  7 Oct 2024 11:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728300309; cv=none; b=j6DGxmFGMkiIOvqYiw06VM0aYUOgZ5Qq1n2sHSxnGuQLc7Jp5Xa1XNgy5K3QFs58ssBYPlC8CxRjrMNPCCJ1KbqvsE/YHZta8j+moHlaV2rn+XhUnnE5h28N5e/dhig53+lJWMn8jDcLtu4XfAxAya5G0/5GaTImgJGvkicVANw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728300309; c=relaxed/simple;
	bh=3gURbrJahiFU7zLSvTdD6+b0aJcNgqAjo6n+rtpfo1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mm4cTZYfx6totk2wVzgqa9meI7EIObnw0neyn3ERtaNp8YHOrSlsooYrtEO67R3gRy9F6/GJiBU4shV7vCfPHdRtKaIzenZNJjj9ZMo/87AM2WrvoEwGPWI7iwbr2rNfECW2S+p6t3IJX1aRQnEIaQ4IFj+2/wPsDi5xSvuhuEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzFq3Zos; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7db90a28cf6so3495191a12.0;
        Mon, 07 Oct 2024 04:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728300308; x=1728905108; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U3YexuiR3za6kMQkwo2K27sxCN4TTv4QAQuWzfsA9Do=;
        b=TzFq3ZosB4+T0UfgD/kChKNbgjexKy+30hTOtl19KNrPlJ+iDLqCoFGoKlm6EBrDwH
         H2VCtk9jLZPr3B0TP1pdPmGyUf9B+VL1WOjAa/B2UjvXumorVV15VDSa8xy7wMFJBbdc
         3gwEIL2ku3j/uvdOb62eATV8Ul96Ds1oKGzLBTiuMqy4rSFteEIIuEG4vIsyNGalvKmQ
         D1MpHfLVCNfMtaz4ouzXMgbao7UV707p5YEZrTBDX3/sjdSAWfVuyIsi8YOL0fh7Lplp
         oomBYGF8ZeVamp9w/djpNfGlHPRXf6wGIPNyul3P3Hns6SVQzXdFaYtxej1ljxvqWVtP
         tChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728300308; x=1728905108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3YexuiR3za6kMQkwo2K27sxCN4TTv4QAQuWzfsA9Do=;
        b=Wb+xw61fLNwGz6+TRUjzSXrM1EpHqt9ST7Fnx2Zs68i1QiwoSFL+agibIuE4M1sIQS
         11FvIftBBBp9ScbkZu3EkKRrNEJtkXqYQDOz+4bJ1bBKKhL5DywkR2/Gcrs6QVZ5IhhX
         t9WDd5kWEZySyMOGhpfNWnC04OiRglsFsOBsP5kR6m9aywxgyVqECcJzZ4djkIZYgv0D
         xrxukNKFB9UVeOLzd8ukGvGjNJhH701sK5BNYcdWrUgLmTX32Yt1bcvN4ikKLWokTWTU
         jnt/mCXR2TBQRGq9zVhtWYtpXjh+tCQLYZ5H4gdLe69QNSTmZHdKgAf0caLXpct5JGjC
         qrdA==
X-Forwarded-Encrypted: i=1; AJvYcCUkusydek80eHeF47SjQcEcvxwkqBqMp/rF4uiX8/q1XozAxYKc42ZxFfiwySZ2N0UzUSUQxZY0z/fM14M=@vger.kernel.org, AJvYcCX8EUr4ZrR8zhCgQQ4cfS8hhCFGw8fjb2rWsR/Lqbu7IrrwL1oW3boq2oJQsxZC0Kza6VcZIKTI@vger.kernel.org
X-Gm-Message-State: AOJu0YwHz7odcZt4Jg9GYC8DEidvePbe07Lpwxzo/mFpKmbcjer4rvBx
	jPCOJpErw2btzC4BWzJRjNftoJEbgmBsf4x8vbvnhSrnLASddNTzEGtsAg8v1Q0adpjUBSoyprt
	wYBUotOcZfGA8NRU+y77pSvxGhY/h8S8g
X-Google-Smtp-Source: AGHT+IF3CIKrBLV0mvm5p043y3wzMRFSX6+s7kpZqjTk4Z/J2XvAGUZ8zbk+MOjiyAzjg9TKwaKeWWLQ9sZtpNLNE9U=
X-Received: by 2002:a17:90b:4a49:b0:2d8:a943:87d1 with SMTP id
 98e67ed59e1d1-2e1b395fb43mr23220434a91.13.1728300307553; Mon, 07 Oct 2024
 04:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007065307.4158-1-aha310510@gmail.com> <2024100748-exhume-overgrown-bf0d@gregkh>
 <CAO9qdTFwaK36EKV1c8gLCgBG+BR5JmC6=PGk2a6YdHVrH9NukQ@mail.gmail.com> <2024100700-animal-upriver-fb7c@gregkh>
In-Reply-To: <2024100700-animal-upriver-fb7c@gregkh>
From: Jeongjun Park <aha310510@gmail.com>
Date: Mon, 7 Oct 2024 20:24:57 +0900
Message-ID: <CAO9qdTGSaJZ0oTmWqRouU45ur3drQVxRaH8aaBB99DXAoA40_A@mail.gmail.com>
Subject: Re: [PATCH] mm: remove the newlines, which are added for unknown
 reasons and interfere with bug analysis
To: Greg KH <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, usama.anjum@collabora.com, peterx@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Oct 07, 2024 at 05:57:18PM +0900, Jeongjun Park wrote:
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Oct 07, 2024 at 03:53:07PM +0900, Jeongjun Park wrote:
> > > > Looking at the source code links for mm/memory.c in the sample reports
> > > > in the syzbot report links [1].
> > > >
> > > > it looks like the line numbers are designated as lines that have been
> > > > increased by 1. This may seem like a problem with syzkaller or the
> > > > addr2line program that assigns the line numbers, but there is no problem
> > > > with either of them.
> > > >
> > > > In the previous commit d61ea1cb0095 ("userfaultfd: UFFD_FEATURE_WP_ASYNC"),
> > > > when modifying mm/memory.c, an unknown line break is added to the very first
> > > > line of the file. However, the git.kernel.org site displays the source code
> > > > with the added line break removed, so even though addr2line has assigned
> > > > the correct line number, it looks like the line number has increased by 1.
> > > >
> > > > This may seem like a trivial thing, but I think it would be appropriate
> > > > to remove all the newline characters added to the upstream and stable
> > > > versions, as they are not only incorrect in terms of code style but also
> > > > hinder bug analysis.
> > > >
> > > > [1]
> > > >
> > > > https://syzkaller.appspot.com/bug?extid=4145b11cdf925264bff4
> > > > https://syzkaller.appspot.com/bug?extid=fa43f1b63e3aa6f66329
> > > > https://syzkaller.appspot.com/bug?extid=890a1df7294175947697
> > > >
> > > > Fixes: d61ea1cb0095 ("userfaultfd: UFFD_FEATURE_WP_ASYNC")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > > > ---
> > > >  mm/memory.c | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > index 2366578015ad..7dffe8749014 100644
> > > > --- a/mm/memory.c
> > > > +++ b/mm/memory.c
> > > > @@ -1,4 +1,3 @@
> > > > -
> > >
> > > This sounds like you have broken tools that can not handle an empty line
> > > in a file.
> > >
> > > Why not fix those?
> >
> > As I mentioned above, there is no problem with addr2line's ability to parse
> > the code line that called the function in the calltrace of the crash report.
> >
> > However, when the source code of mm/memory.c is printed on the screen on the
> > git.kernel.org site, the line break character that exists in the first line
> > of the file is deleted and printed, so as a result, all code lines in the
> > mm/memory.c file are located at line numbers that are -1 less than the
> > actual line.
> >
> > You can understand it easily if you compare the source code of mm/memory.c
> > on github and git.kernel.org.
> >
> > https://github.com/torvalds/linux/blob/master/mm/memory.c
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/memory.c
> >
> > Since I cannot modify the source code printing function of the git.kernel.org
> > site, the best solution I can suggest is to remove the unnecessary line break
> > character that exists in all versions.
>
> I would recommend fixing the git.kernel.org code, it is all open source
> and can be fixed up, as odds are other projects/repos would like to have
> it fixed as well.
>

Oh, I just realized that this website is open source and written in C.

This seems to be the correct git repository, so I'll commit here.

https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/cgit.git

Regards,
Jeongjun Park

> thanks,
>
> greg k-h

