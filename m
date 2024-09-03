Return-Path: <stable+bounces-72854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031FE96A82D
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 611F6B21CC2
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3651A3057;
	Tue,  3 Sep 2024 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dKHr6GCS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9D5190463
	for <stable@vger.kernel.org>; Tue,  3 Sep 2024 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725394714; cv=none; b=MMYxTB53dgQok+VqC8ZX7szOESgZeSxVhREoAdOk1PzuOblE8jjYNtEkpTpWqPmgwILdrzW/ioHY0YijgRFCXsn6blkeaLs9U9hQBtwB8j9ThGi8MTAgD0D30T3NHu+jC+8ufuNybxa3U2LNaBJu+0MKymMh/6TCcua5eSCXLlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725394714; c=relaxed/simple;
	bh=hzAqGd3F7AgPkCeGGqromJaKIJXJKAOln3vKkvXFg18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxnBBo5nBT2uKKmYHWP988ceEXiG5f7Jkef82Vslgw+pL9udgxe+KSAEHhCPUyDOg6Z21JqKujZnOPJh0czIgmCHGbsDOdhBC17BZvlwKh1igL+gAa8VJLqbVCir0oWFtIND2cNGT7CIO/dvzg+4IjqL2tJQLSlKK9x+zfts+Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dKHr6GCS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8695cc91c8so581466966b.3
        for <stable@vger.kernel.org>; Tue, 03 Sep 2024 13:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725394711; x=1725999511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWbMfvcljod0JpxC0uK+HPRl2MlFSfhObh8ySh6Wf0c=;
        b=dKHr6GCSu1E9dNajNUGM0Ptso8C9KH3okxYNy/PRq31DIH+W5xkRJcZtW9nWI8FMMa
         ac4vifZuqMFzxV5ZET2InYh3QHaDCKr/hU5apSu9kx3/G45ReIXLcznxCr8ITIh0XTtu
         bS+oskDCQeTyGGwrTrM8yY79wNftAuweWMeYyczawGnDfs/6W6PhMaJaBUDVLRQiXRzb
         GwQP1bKf2lsR9WTBOMorz5vWqZbV1uk4M8Ex44/aKBM+iuHj5pLeyllcbDPYYCHhAFhL
         MGROiuGJjF8iTDHsm+PtTZ2HOMGfnjH9iIU2Aj9Og3Gt9bNwYu6hvoRhAEboKtnauURN
         LvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725394711; x=1725999511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWbMfvcljod0JpxC0uK+HPRl2MlFSfhObh8ySh6Wf0c=;
        b=K9QXo6zKCRXTb4t35U17gRNPspJvlsB/4+ECS0uvZuYYBHoYcOuYQ8l6B8zBH+oGoK
         /jLPibf6jQxwSHp6i4+744YxzARNI/zy1velzO9uyd4f4GqbBe6LckpOkrg1Cow63HYx
         8QiiFtDkG34l4rjkFphX39G7pYRo+3huCyVeBerTyQsJlVOtXY0tGy68luiMStZrdO6m
         B1jqhyPmNmWYNNowzuAy/0mc65H5rfc+Xpep941mGQY/Ed+rmBiZRcq7PPTUfaYpcnta
         I3e6vFnq9FrSyNY92zJT+G3zJyIgYwsE8S2zlcgyslAuhet5BRB5abZ+PHs6hiKWML2l
         6qQg==
X-Forwarded-Encrypted: i=1; AJvYcCUbt/shJ9IDKZ92hg9bVajWfdvKWxN75e6oI5aOW5AI3w/AV9X/khF3jvfWNZ7pQ8Nk4meLBwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFzYTCAI81t+a9YPFkzZRxPYkA6bXxrKZEHl5+sKgTayAGVKAi
	/m6HKXr7dUpguhhliGuIWVhOvaT8UiygJDpRAhpSYP/o6rvQ1lnahmZ5SeZ9uEU4kiFP6ADuhgX
	gnyu/G+whj4gnWr/6MTBCv9Yts5kfwnYuYOvY
X-Google-Smtp-Source: AGHT+IFYUH/hVNuhhP40aPgAS7zEvNZTSTwvvuFNeAMEV+ZwBawVLkqTESoQZXwhziKheUUQ5XgC8wxLk0fxSFgcBAI=
X-Received: by 2002:a17:907:9485:b0:a86:a41c:29b with SMTP id
 a640c23a62f3a-a897f78cc4emr1417395766b.8.1725394710002; Tue, 03 Sep 2024
 13:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902005945.34B0FC4CEC3@smtp.kernel.org> <CAJD7tkYtM8gQDX8RrT1cnkfDQ0dRv4woNY4jrwjc1oUuavbuTg@mail.gmail.com>
 <20240903125329.726489169d81399a954f7787@linux-foundation.org>
In-Reply-To: <20240903125329.726489169d81399a954f7787@linux-foundation.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 3 Sep 2024 13:17:52 -0700
Message-ID: <CAJD7tkZ9PQXKkt=74dGHZgfCLs+jRz8KPPv5UZ2z9NScwOdT1w@mail.gmail.com>
Subject: Re: [merged mm-hotfixes-stable] mm-memcontrol-respect-zswapwriteback-setting-from-parent-cg-too.patch
 removed from -mm tree
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, stable@vger.kernel.org, shakeel.butt@linux.dev, 
	roman.gushchin@linux.dev, nphamcs@gmail.com, muchun.song@linux.dev, 
	mkoutny@suse.com, mhocko@kernel.org, hannes@cmpxchg.org, me@yhndnzj.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 12:53=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 3 Sep 2024 10:53:21 -0700 Yosry Ahmed <yosryahmed@google.com> wro=
te:
>
> > > The inconsistency became more noticeable after I introduced the
> > > MemoryZSwapWriteback=3D systemd unit setting [2] for controlling the =
knob.
> > > The patch assumed that the kernel would enforce the value of parent
> > > cgroups.  It could probably be workarounded from systemd's side, by g=
oing
> > > up the slice unit tree and inheriting the value.  Yet I think it's mo=
re
> > > sensible to make it behave consistently with zswap.max and friends.
> > >
> > > [1] https://wiki.archlinux.org/title/Power_management/Suspend_and_hib=
ernate#Disable_zswap_writeback_to_use_the_swap_space_only_for_hibernation
> > > [2] https://github.com/systemd/systemd/pull/31734
> > >
> > > Link: https://lkml.kernel.org/r/20240823162506.12117-1-me@yhndnzj.com
> > > Fixes: 501a06fe8e4c ("zswap: memcontrol: implement zswap writeback di=
sabling")
> > > Signed-off-by: Mike Yuan <me@yhndnzj.com>
> > > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> > > Acked-by: Yosry Ahmed <yosryahmed@google.com>
> >
> > We wanted to CC stable here, it's too late at this point, right?
>
> It has cc:stable?
>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Cc: Michal Hocko <mhocko@kernel.org>
> > > Cc: Michal Koutn=C3=BD <mkoutny@suse.com>
> > > Cc: Muchun Song <muchun.song@linux.dev>
> > > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > > Cc: <stable@vger.kernel.org>
>
> ^^ here

Sorry for the noise, I'll go find an eye doctor.

