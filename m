Return-Path: <stable+bounces-104533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B379F510F
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D863D188C304
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 16:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324B714AD29;
	Tue, 17 Dec 2024 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJtdd9Wh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5747A14A0A3
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734453100; cv=none; b=MCcMk/3LHSK3s+bux6TnxJyqjpVZQ1TkBHYBM2Ma1VXo4WIW15V0MYlGLLof7EZcTneUFzprqPX/yFjILz6oA8+0Xdd11w4WJtvzYpccXpIXsDOvRI/hISjS8RtHd7NRJw2oqnPQXM6uGQShO2ZPDs+Lg3AnMGhei2CTXyDl+4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734453100; c=relaxed/simple;
	bh=6NK+z3FpBQ4dkU1zWgFEJ2Zy0a5kaq2ol65YQrQVycM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTBI36rgb8naQRUjeOsGdZv8cbo78PH6rLrEGFOGOVh3bBWgv4J6XdBlOOvh8noH7ndxFHyXI5GzAZj6HxFQNrsn86djhVqlHaoGINnmB03ain+xkazdkyeSZwRPyqHsgaYvfOeethvgHiQfnkPb7q2cWVNIB1TVr0UCMGHh2Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uJtdd9Wh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2155c25e9a4so135325ad.1
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 08:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734453098; x=1735057898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbbarN/Rdy7B5sGVq7bbZZ+SWYVMjVxy+N4dBbT/+3Q=;
        b=uJtdd9Wh6OReJOzg9E+5y+SvG7XqG0yTy360CjLcY0vvk2NKN/oQzoNbh+qMJDKyzY
         Ow18yks25Yfx/ISExH7MBOkjpYEhmnvPA3Wt3z0yJ15BshYlALr7uMW8EwXUPdJLgiKk
         jHohbEdvGkVFaoXdUKvetY4N6+JVUO+g/AiIzQwVv4/NIq6WIYXMwzFniz45fig5oUX+
         LgQKcarSk+eutNXwVl1+KXvJ4ZFEjtJYqBklC43wEv+RCtSy+0pNhP4+y5B92wdiQoEa
         ODfqJ+YAN0AWvJMHitInXXV80R/NoOGLWPdnKkDSIqAARwDWKj9vZppzgdrfqY+GcgJm
         waeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734453098; x=1735057898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbbarN/Rdy7B5sGVq7bbZZ+SWYVMjVxy+N4dBbT/+3Q=;
        b=B5AFwtg5mOY3wnSih8HaTHjNNEdZ0DOzzv0XOZovM3EL2FAysF6XbEX2oLrfCkT8Ht
         mHCIoTF36BFDhwAF7EgNqvEGsR5z4g+oAqooM9UVBvCfiiF8Qa6gmxvE5y4VfzDeaaE7
         f8sSUEnK4Db7LkcJDU5a89Ieodgp3XddV2KVS/mAAXwl3nDP+LxQwZU6dDgDd6i5VIu+
         u+dfusOSMwXZcWKQzbo6+G+JGzifFMXaktXserVx7TSJbJPechJsdBWNg353HHWfGeBH
         Sd0j+Car89gLea4F07MjVjMzNj36abBBdb33ixpiE/y7TmCfw1SejSHB7G+5dYtQ8Pza
         S3tQ==
X-Gm-Message-State: AOJu0YwtN9o7J9CifkM9wY6N4OpaER4s7lU25JVhCv8RvZR8MNxcThUe
	V77s6++sTeDSCBInDXWUzpLTIKk5qHEgp1yo7PGH9fQ1jwUMhS0hpLxNJQokw3jKyPpbRxldjIX
	yq7vgPuyDqlvXoBrjwGPAer53FBDcUSje0btO
X-Gm-Gg: ASbGncsdjEHYTOqI75/mwiJfXZW5S197xGs+63qJExbFDnSZtqEuoZ0x1dCrmeIyJ6X
	yAphlgGIU8GSMy66+Yw2GiqaBJKXT+fl0rHd/
X-Google-Smtp-Source: AGHT+IF6zBycCZgZ37K0c0Mqt5KJZFgdpLPzxa4ka10RBRwmmEZmWl6gZSB2IrjVjllJ9HN8WQ+yjoAvN3boMOxpI+Y=
X-Received: by 2002:a17:902:c409:b0:215:7152:36e4 with SMTP id
 d9443c01a7336-218cb220b48mr2367185ad.27.1734453097470; Tue, 17 Dec 2024
 08:31:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426080548.8203-1-xuewen.yan@unisoc.com> <20241016-kurieren-intellektuell-50bd02f377e4@brauner>
 <ZxAOgj9RWm4NTl9d@google.com> <Z1saBPCh_oVzbPQy@google.com>
 <CADyq12y=MGzcvemZTVVGN4yhzr2ihr96OB-Vpg0yvrtrewnFDg@mail.gmail.com> <2024121705-unrigged-sanitary-7b19@gregkh>
In-Reply-To: <2024121705-unrigged-sanitary-7b19@gregkh>
From: Brian Geffon <bgeffon@google.com>
Date: Tue, 17 Dec 2024 11:31:01 -0500
Message-ID: <CADyq12ynffJLMFJvzf-hsq3OYiLG=TtRVOWev_nBVtOjK91pPw@mail.gmail.com>
Subject: Re: [RFC PATCH] epoll: Add synchronous wakeup support for ep_poll_callback
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "# v4 . 10+" <stable@vger.kernel.org>, Xuewen Yan <xuewen.yan@unisoc.com>, 
	Christian Brauner <brauner@kernel.org>, jack@suse.cz, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, cmllamas@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com, jing.xia@unisoc.com, 
	xuewen.yan94@gmail.com, viro@zeniv.linux.org.uk, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	lizeb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 10:34=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, Dec 17, 2024 at 09:30:51AM -0500, Brian Geffon wrote:
> > On Thu, Dec 12, 2024 at 12:14=E2=80=AFPM Brian Geffon <bgeffon@google.c=
om> wrote:
> > >
> > > On Wed, Oct 16, 2024 at 03:05:38PM -0400, Brian Geffon wrote:
> > > > On Wed, Oct 16, 2024 at 03:10:34PM +0200, Christian Brauner wrote:
> > > > > On Fri, 26 Apr 2024 16:05:48 +0800, Xuewen Yan wrote:
> > > > > > Now, the epoll only use wake_up() interface to wake up task.
> > > > > > However, sometimes, there are epoll users which want to use
> > > > > > the synchronous wakeup flag to hint the scheduler, such as
> > > > > > Android binder driver.
> > > > > > So add a wake_up_sync() define, and use the wake_up_sync()
> > > > > > when the sync is true in ep_poll_callback().
> > > > > >
> > > > > > [...]
> > > > >
> > > > > Applied to the vfs.misc branch of the vfs/vfs.git tree.
> > > > > Patches in the vfs.misc branch should appear in linux-next soon.
> > > > >
> > > > > Please report any outstanding bugs that were missed during review=
 in a
> > > > > new review to the original patch series allowing us to drop it.
> > > > >
> > > > > It's encouraged to provide Acked-bys and Reviewed-bys even though=
 the
> > > > > patch has now been applied. If possible patch trailers will be up=
dated.
> > > > >
> > > > > Note that commit hashes shown below are subject to change due to =
rebase,
> > > > > trailer updates or similar. If in doubt, please check the listed =
branch.
> > > > >
> > > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.g=
it
> > > > > branch: vfs.misc
> > > >
> > > > This is a bug that's been present for all of time, so I think we sh=
ould:
> > > >
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Cc: stable@vger.kernel.org
> > >
> > > This is in as 900bbaae ("epoll: Add synchronous wakeup support for
> > > ep_poll_callback"). How do maintainers feel about:
> > >
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Cc: stable@vger.kernel.org
> >
> > Dear stable maintainers, this fixes a bug goes all the way back and
> > beyond Linux 2.6.12-rc2. Can you please add this commit to the stable
> > releases?
> >
> > commit 900bbaae67e980945dec74d36f8afe0de7556d5a upstream.
>

Hi Greg,

> How is this a bugfix?  It looks like it is just a new feature being
> added to epoll, what bug does it "fix"?

The bug this fixes is that epoll today completely ignores the WF_SYNC
flag. The end result is the same, the wakee is woken, but the kernel has
several places where a synchronous wakeup is expected and with epoll
this isn't honored. However, it is honored with poll, select, recvmsg, etc.
Ultimately, epoll is inconsistent with other polling methods and this
inconsistency can lead to unexpected and surprising scheduling properties
based on the mechanism used in userspace.

For example, f467a6a664 ("pipe: fix and clarify pipe read wakeup logic")
highlighted the importance of sync wakeups for pipes, should GNU make
start using epoll we would see the same regression that resulted in this
fix from Linus.

>
> confused,
>
> greg k-h

Thanks,
Brian

