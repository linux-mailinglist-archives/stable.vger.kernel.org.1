Return-Path: <stable+bounces-81195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF65D991E39
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 13:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1081282D08
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 11:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4F1364A0;
	Sun,  6 Oct 2024 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4CLrmlr"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A99216EB5D
	for <stable@vger.kernel.org>; Sun,  6 Oct 2024 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728215842; cv=none; b=CjWHLNmE0i84XzFV7voNPrpGFyiTjIUwzZLmOQZj4YaWBKkib2rF33/xkVJOAwAVc1h9COih/gt2h5Bq2QueWcGFnKb+9rEvSelRZ4Q5riBwyuY2MI0Q2K/uCtlo/pAqTw0RFv5kS99yEYh5mpCcb/KRZETkNgQ5MuPjkmgjx2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728215842; c=relaxed/simple;
	bh=SAEP2mceIijkMWqgqpGe7krG5Meaeqo6fgwteGsKEa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWJtVTbEOe4lsJZ91SIjLoVGioT1l/SWWksboRa34cKfImMrNy+JzttowFQXdRdr1bhJ3mpBAPlZqCemVtqmUv29/bN2J9zHgdYb+w64hCKybZNNQqSIM3ZLKFvqNwHgS8lvsITtQpye2ZreNvEPcUIRhItMyIklXnoZUnYlQr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4CLrmlr; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e25ccd64be9so2886682276.2
        for <stable@vger.kernel.org>; Sun, 06 Oct 2024 04:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728215840; x=1728820640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAEP2mceIijkMWqgqpGe7krG5Meaeqo6fgwteGsKEa8=;
        b=D4CLrmlruS/CoWFYBQ135OCDZ12xSOHWI3ew28XckYymFTXTQQhhQ116p/Z+i+Zmg5
         0+KQhcaZqHYwBpurV2kghdfMqZUqlGl3cgLMd3ZrgrWIDucYG+r5ivapouQNk2qee3Wh
         BXop5N9NkNZAdo2Oiiog01dkeWoV7lxfnjdTY6fR2Vl01ILUO5Y/6Guub32iswzOLJMT
         YLA/M6QSc4czKhc9FuS4BxVt8qFN8uPmQih0AdBmeqXVLVklhnwawqAJZDwvfZZUgBFh
         rpk5FgrNoFwaAZiv67AqtMBUgGo82RSePVNncjIJXIibWeBt7JDqJ35Lk1KcStboSqtJ
         NRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728215840; x=1728820640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAEP2mceIijkMWqgqpGe7krG5Meaeqo6fgwteGsKEa8=;
        b=Z7z2Eq4eTFq5C1rBw5YDILLRsVpmWeZO+Ez3kKYXtDgi3P9FfHVEMW8vk3TKVDqSpV
         zuOaM96RUg2KoCqxnuMLc+UhIdMBI/jshjnccbUMVQ0jCsJ7/4Be//36NdFuWQ8eAAaV
         X2O3qfJLCRSdrVdNpjaQVuuytiOZbLwjZSoElOZnpujOkksYCeBE6g26A2UOJd3vqHHc
         +368G6iU04vmKzD2IRiJ8Uyqifk5y4DbtpweU95VrC3FST9Rwh1sMTAaVk2ZOXk0KQh0
         4E1txvdN2v5qBR92rzylwJWAE9my+WkmsU/btQolbod+OmyI+Nwu6PXkBfRLkWFGvTjk
         0nhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEyo2ZsKCGyxo5+tvJ81PTG+NT32hLSAz1byIbUfIIdyuQx+GrH8A0hrSkjI89s5OzSKVe1CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOui2K3WlmfNfpGa4abt3knsBu0HXK7+A+pglQQR6Yp942Hk27
	YrXWCOJAXKFUy2A37HNPEPIRICJwCpJ/cHDkqv5W3X7hWTgBr+YmaZkyutzBOWeOMKTKuaxskL0
	3jwNQpLTQHqeBd6Ee/Ku21JU/nAo=
X-Google-Smtp-Source: AGHT+IFemGvuLcSGtK8Fzrp3SRorEbBJEYDi2/qqgWCrVVAk/FBpY401X2FStVhWAZs/EJa8VAIZAKA/ziYG9a0X/h8=
X-Received: by 2002:a5b:8c7:0:b0:e28:b864:e97f with SMTP id
 3f1490d57ef6-e28b864ecb1mr1738367276.46.1728215840201; Sun, 06 Oct 2024
 04:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002125822.467776898@linuxfoundation.org> <20241002125838.303136061@linuxfoundation.org>
 <CADpNCvbW+ntip0fWis6zYvQ0btiP6RqQBLFZeKrAwdS8U2N=rw@mail.gmail.com>
 <2024100330-drew-clothing-79c1@gregkh> <A8D6C21F-ACAD-4083-900F-528EB3EB5410@oracle.com>
 <CADpNCvbKGAVcD9=m_YxA6qOF6e0kohOfVsKOqJeVmrYaq0Sd8w@mail.gmail.com>
 <2024100420-aflutter-setback-2482@gregkh> <CADpNCvYn9ACkumaMmq7xAj6EQuF6eYs174J+z81wv5WqzdWynA@mail.gmail.com>
 <2024100430-finalist-brutishly-a192@gregkh> <2024100416-dodgy-theme-ae43@gregkh>
 <8AC0ACC8-6A77-487E-B610-6A0777AFC08E@oracle.com> <CADpNCvZXyw25A3+DvMpECFoffWmcrFQ0Do5hhwbqftxTVr-+Mw@mail.gmail.com>
 <0CFAAF67-170F-4BA2-BC16-F9B40ADE7D35@oracle.com>
In-Reply-To: <0CFAAF67-170F-4BA2-BC16-F9B40ADE7D35@oracle.com>
From: Youzhong Yang <youzhong@gmail.com>
Date: Sun, 6 Oct 2024 07:57:08 -0400
Message-ID: <CADpNCvZ-X2NuxLBjJcPi14U-Jt44tS7TrbguavVxrhf5_5v1pg@mail.gmail.com>
Subject: Re: [PATCH 6.11 397/695] nfsd: fix refcount leak when file is
 unhashed after being found
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-stable <stable@vger.kernel.org>, 
	"patches@lists.linux.dev" <patches@lists.linux.dev>, Jeff Layton <jlayton@kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The precise explanation is in the commit message.

> I'm asking that you please apply and test these patches on
> v6.11 and v6.1, at the very least, before requesting that
> Greg apply these patches to the LTS kernels. Greg needs
> very clear instructions about how he should proceed, as
> well as some evidence that we are not asking him to apply
> patches that will break the target kernels.

It's very reasonable to have more tests. I 100% agree.

Per your request, I performed the testing under kernel 6.1 and 6.11.
We've already tested under kernel 6.6 using our test farm.

Conclusion: it works as expected - the issue reproduces without the
fix, it's no longer reproducible with the fix applied.

To Greg: please cherry-pick the commits 1, 2, 3, and 4 (see below for
what these commits are) and apply to kernel 6.1 all the way up to 6.11
if that's appropriate.

Here is how it's done:

- cherry-pick nfsd commit(s)
- build and install kernel
- run my reproducer
- check nfsd_file_allocations and nfsd_file_releases, see if it
reproduces or not

Commits to cherry-pick:

1. nfsd: add list_head nf_gc to struct nfsd_file
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D8e6e2ffa6569a205f1805cbaeca143b556581da6

2. nfsd: fix refcount leak when file is unhashed after being found
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D8a7926176378460e0d91e02b03f0ff20a8709a60

3. nfsd: remove unneeded EEXIST error check in nfsd_do_file_acquire
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D81a95c2b1d605743220f28db04b8da13a65c4059

4. nfsd: count nfsd_file allocations
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D700bb4ff912f954345286e065ff145753a1d5bbe

Note: commit #4 is very useful for detecting if a leak happens or not, othe=
rwise
it would be very time-consuming to find out. It's not needed but better to =
have.

Kernel 6.1.110 + commit 4
1st run:
nfsd_file_allocations: 811
nfsd_file_releases: 791
leaks? Yes
2nd run:
nfsd_file_allocations: 554
nfsd_file_releases: 548
leaks? Yes

Kernel 6.1.110 + commits 1,2,3,4
1st run:
nfsd_file_allocations: 816
nfsd_file_releases: 816
leaks? No
2nd run:
nfsd_file_allocations: 9755
nfsd_file_releases: 9755
leaks? No

Kernel 6.11.0 + commit 4
1st run:
nfsd_file_allocations: 3662
nfsd_file_releases: 3659
leaks? Yes
2nd run:
nfsd_file_allocations: 2177
nfsd_file_releases: 2175
leaks? Yes

Kernel 6.11.0 + commits 1,2,3,4
1st run:
nfsd_file_allocations: 2136
nfsd_file_releases: 2136
leaks? No
2nd run:
nfsd_file_allocations: 9094
nfsd_file_releases: 9094
leaks? No

On Fri, Oct 4, 2024 at 2:09=E2=80=AFPM Chuck Lever III <chuck.lever@oracle.=
com> wrote:
>
>
>
> > On Oct 4, 2024, at 1:59=E2=80=AFPM, Youzhong Yang <youzhong@gmail.com> =
wrote:
> >
> > The explanation of how it can happen is in the commit message. Using
> > list_head 'nf_lru' for two purposes (the LRU list and dispose list) is
> > problematic.
>
> "is problematic" is not an adequate or precise explanation
> of how the code is failing. But as I said, I'm not objecting,
> just noting that we don't understand why this change addresses
> the problem.
>
> In other words, we have test experience that shows the patch
> is safe to apply, but no deep explanation of why it is
> effective.
>
>
> > I also mentioned my reproducer in one of the e-mail
> > threads, here it is if it still matters:
> >
> > https://github.com/youzhongyang/nfsd-file-leaks
>
> I'm asking that you please apply and test these patches on
> v6.11 and v6.1, at the very least, before requesting that
> Greg apply these patches to the LTS kernels. Greg needs
> very clear instructions about how he should proceed, as
> well as some evidence that we are not asking him to apply
> patches that will break the target kernels.
>
> And, please confirm that 4/4 is needed. I can't see any
> obvious reason why it is necessary to prevent a leak.
>
>
> --
> Chuck Lever
>
>

