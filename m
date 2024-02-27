Return-Path: <stable+bounces-23879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171DA868CEC
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 11:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487371C21C22
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 10:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90DC138491;
	Tue, 27 Feb 2024 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0yGoRApH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4388137C5B
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 10:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028387; cv=none; b=svzY6aOT98FiSFJfwz1GYkveSXxs/dflHhzwk553Pqn+u2woDvZRk6Z4HJt4kp8YYD1mtLoXYV9Qyh//JXaRNR3Kn+2EkRGmyPaji3h3qsG6v+tvJzW9eFSjegU40xU6FBI0HiOaZC4NYQcW8yoQgVN+WSjR2emWkaCZ3qx4nSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028387; c=relaxed/simple;
	bh=M3NdsVo95laEu923zs177JBGWlhJLHLVZSM0/ADUCxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHbxCYIAUOhxM2JF1L0wUPLLInL9n7UPa42ZB2ATb3KRH5orUI92QGYkxgfKouL9D8Xba8jNfahQSN69eb98J/9gV+ol2rivftlNN5rHlgZK9vQljmDPzQS3km3XwP8jJZJZQvBnE05C0XmL9r2J19x9srqKPRZeTNwrTKqKofI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0yGoRApH; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-564fc495d83so4691016a12.0
        for <stable@vger.kernel.org>; Tue, 27 Feb 2024 02:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709028384; x=1709633184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTjhpxBAi+EZvlGkENyHmYw/Enjk34FKIFkLYuIoKp0=;
        b=0yGoRApHCVv1Fz6Rjl4UDumq0Dyj1WrMnRAlmNnNqliSyudZ1uMDMHqnezfyQKhzua
         odiVjX39VMFqYgYnrRi+aYp+6zUe4197SBvRJJOtrDCv3utcexbk2DNmSljOm/R+i2jh
         QUcMgBgK3Uba8ZHWXZ87rvupAx+R+CQ0XIapGmcYdW9IL5w4qyfY6JHxeZNPa3WzxfNW
         Kn0gVfEdDOtssNXAbZ5rEbZs9r8BE+LLB0ofzlB+UyXZhDmLk3j1ZUmOgNsoneQ5ifOz
         kajJZBhVprlsplx3VaBzk9xyHZ/D3UtJs3oS86/aIY950u0hAEDr1tjBOyih9LM4TqDR
         3n0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709028384; x=1709633184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTjhpxBAi+EZvlGkENyHmYw/Enjk34FKIFkLYuIoKp0=;
        b=R2clqL5ERXB3Gy3ZhnkEguEuCT2XCze5uEJ4RRKGCApErbRv1/ZWxdPs3VbDC+7Sz+
         lI/djWVJm/rdoNboDuYAMAt0DKmY/F5LuFS5HBE6Nmn79fCcKh0BOkAi3TH+2tD8i6QZ
         m7E57c0fxcq9NBPcUTmtU2S1kbTBrsTr55kL575G0b++aFjnNWRU25eh8v/rgdeKFWvr
         /3Irc/eMlkoxl0ghr3H5uX/2lvdEGQagGoO1HaABeUtBekgraKcmaMd552Z5QxFcaeLg
         lJsLKgHRQQoPoH5xROHs9MKQI1BGeV5Fv5EQW0KEIrMyCIqEiKLCXHqHGbpipTxBGpkP
         CoMw==
X-Gm-Message-State: AOJu0YwxMaexRKSphLkSPDg0mECOKj4aZibBEoJBvlNC/vA4U/CDX7oq
	6vyY0t4E7SzXe7GEPmG6irKonbY5DIbJTULMM9t+jFo6DndQXMuFTeJjF5IVhtr/a2mq8FJ8spf
	GFbf3S9h6+6gY6wx6jk8FzdwzNOhfXvmoN4gh
X-Google-Smtp-Source: AGHT+IETeuuQlx6BGo79MA0thUeEJKUFoux72fAf2+YQBsSrQY4wfPVzIsLsF85im+mAocS+zqVk0xjzIriwuAHWm6k=
X-Received: by 2002:a17:906:e59:b0:a3f:b26e:147 with SMTP id
 q25-20020a1709060e5900b00a3fb26e0147mr6575250eji.51.1709028384021; Tue, 27
 Feb 2024 02:06:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024022612-uncloak-pretext-f4a2@gregkh> <20240226220340.1238261-1-yosryahmed@google.com>
 <2024022740-affidavit-conjoined-cbfe@gregkh>
In-Reply-To: <2024022740-affidavit-conjoined-cbfe@gregkh>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 27 Feb 2024 02:05:48 -0800
Message-ID: <CAJD7tkZmKvFA68S8yRbT2khCVC3o8ax92Q+PmgNhQDiWwah05w@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] mm: zswap: fix missing folio cleanup in writeback
 race path
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 12:56=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Mon, Feb 26, 2024 at 10:03:40PM +0000, Yosry Ahmed wrote:
> > In zswap_writeback_entry(), after we get a folio from
> > __read_swap_cache_async(), we grab the tree lock again to check that th=
e
> > swap entry was not invalidated and recycled.  If it was, we delete the
> > folio we just added to the swap cache and exit.
> >
> > However, __read_swap_cache_async() returns the folio locked when it is
> > newly allocated, which is always true for this path, and the folio is
> > ref'd.  Make sure to unlock and put the folio before returning.
> >
> > This was discovered by code inspection, probably because this path hand=
les
> > a race condition that should not happen often, and the bug would not cr=
ash
> > the system, it will only strand the folio indefinitely.
> >
> > Link: https://lkml.kernel.org/r/20240125085127.1327013-1-yosryahmed@goo=
gle.com
> > Fixes: 04fc7816089c ("mm: fix zswap writeback race condition")
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> > Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > (cherry picked from commit e3b63e966cac0bf78aaa1efede1827a252815a1d)
> >
> > Change-Id: I0aef4c659c6a29b45d78bf6a7e8330c7ab246f15
>
> Why is Change-Id: in here?  checkpatch.pl should have warned you of that =
:(
>
> Please fix and resend.

Sorry I usually generate the patches with git format-patch then run
checkpatch.pl, I followed the instructions in the "failed to apply"
patch and forgot the run checkpatch.pl on the commit.

I resent this.

