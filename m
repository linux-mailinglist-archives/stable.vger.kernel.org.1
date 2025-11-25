Return-Path: <stable+bounces-196834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 53391C82FD6
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 02:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E12B34BCBE
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 01:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9DB1E834E;
	Tue, 25 Nov 2025 01:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPoiGAmj"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F7E191484
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 01:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764033056; cv=none; b=ECDhh8/r9sTq8FUYgFAL+8Ki+fwn1zwlxFCmFI19kf3XTgQY7QUbgwpNM7uOvGuTuXVKQ8HsvZWevVgLI9prj+TUAkpt8OIuPlV391bEQEa7atezvv/Pe9mfIvAhldyNv981WZyxLLqQFkkI/JVMXCVYmA3bAHTPS3PMow4tD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764033056; c=relaxed/simple;
	bh=gg2LWcJmlQnDKVI253sVC6rFkfFxBkJ9WkBHYjcuBdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsEQITEUSxx8lGlbOUR0PrMau2iwVeJmpo1HNp5aVDHJeaO/Q8Z6rd4oHBGMbHErG5TvQCXn4q/KN8yVHgd2p7BhuZdvfD/iBFP56g5lfAR2t2IBcyayGxrgar/frvbq8QxS311ZVgOg/FcJZVRVZHiJQih8GGZ59tVxrwPyZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPoiGAmj; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee14ba3d9cso49534131cf.1
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 17:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764033053; x=1764637853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsgChq6O0wKjJChpqYW4kr3HbE1+hmbVANep3Kkz0K8=;
        b=DPoiGAmjVroR8ALggnWLocJFp6TDSUyIKFr7Q2jwVMnGTPfhArdOWeHxI+8k0C2iHc
         BGfGQpHE3Gfquc7X6S1sOW99kp5XZZdMdAwKZkcuyWkJtXZ2URLXIXSjE2iVpE2IJilj
         uCduxEjNdxFsLIGNGg0FEHHJCK0n75//unZE7kHeMwIsU6RKIPyIFbg2Xzi26bWuRSMB
         2oiacAb6mwUCg2KYObTnJxgW3HMXDIaf2kNuHHKiV+FGRX4IxCP9wQzNTNpyPlqylrvg
         WcP8vzBd9T4sSpLSJ92fxABtsmCBapOeItVcBg0k+craGba7ugNWT5XIW2xxyvs1PJYy
         SqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764033053; x=1764637853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NsgChq6O0wKjJChpqYW4kr3HbE1+hmbVANep3Kkz0K8=;
        b=SaXAi5H04v9Q0Z1iUBz+xyUt2lDcWBW2Qrh0yDPj3fZEmZRc1tqrLh2937HeinRA+n
         Uz6Z8SMZqUzzlqn/p7uDtMs3Q+4kOvO8sJmniYGjHpXd6n95F/73tTLR7pZ8K/Rx5whE
         LPlWusoYmIK3AInSuZ3F4mT9Rdl8LEqBCADZ0ufSwJVSgtu2oJXnuDmgcp5oPWK7+Tcb
         DvwknST9Q+VclUk6WtiCbGKsfsqEmN3YXWeJdk1zyvGwwDMXhhvghJqjBvkGD7IKlpcO
         bsYRCVWEObYfJQMh3BCKHLq5ayW+DLwmXqgbId/1juC/koK6t3mBPh/qGTMzHQp3lSCu
         DgIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL3Z04hYqXD4gAkSEVBqhJjLXsNov/DgXB1AI0lNA10UwETD79srCVRZF2SvL0nowzDVmCcRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIOx72ukdyufXyBBKNLqGQFXwQv1AHFuk8QD5DOkCFQyASdIRd
	Q1mcQgd9a+Ifa4NQcKxZPIKbjwRrUeboLLtDFib1IUtk//Kj2HYfn4PEQ8XHrEO1VWktgyGh9Gw
	e9ohFoSgIDOpJZzKcnl/mBBIwzIVrKS1kHVORlNw=
X-Gm-Gg: ASbGnctgPClMFMVoJwLphfboNYVvD5gV/j+RFSOynIWYtH3Zn/jhSjCPeUQrW7zeixQ
	daKtX+MNqw3jblZPdneojfTDhbipvcIEWYVr3LVM8quDF7xAXtpL5URpyWg8T2R8HGtDqb6NchA
	44mN6Pvj+U7qJG2h/3dUuWyFP0J6NCiEzheez05PpCqn+KKHoXp+5Q00RbV4mVSj2VsiKnyl8/z
	sdiDqXw8rq2Oac6xhuNYjp4FQxtYZzQobLBgSVT7GRJvFBdPYpjKIDGbhVib5E8fW6tjg==
X-Google-Smtp-Source: AGHT+IGZVKMiOfKr+qR5oAOuuoGjPw3a99Gd8R5iy/goYmjUN3mlBPM3amn8zp6bIqVzLx2vLsce3VFkRzsep0Dwiqs=
X-Received: by 2002:ac8:5790:0:b0:4e8:92ff:753 with SMTP id
 d75a77b69052e-4ee58821e17mr176484991cf.24.1764033053038; Mon, 24 Nov 2025
 17:10:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120184211.2379439-1-joannelkoong@gmail.com>
 <20251120184211.2379439-3-joannelkoong@gmail.com> <5c1630ac-d304-4854-9ba6-5c9cc1f78be5@kernel.org>
 <CAJnrk1Zsdw9Uvb44ynkfWLBvs2vw7he-opVu6mzJqokphMiLSQ@mail.gmail.com> <f8da9ee0-f136-4366-b63a-1812fda11304@kernel.org>
In-Reply-To: <f8da9ee0-f136-4366-b63a-1812fda11304@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 24 Nov 2025 17:10:42 -0800
X-Gm-Features: AWmQ_bmmIvZ3_5WG3LWnwaKKEddKemGd4go_OocJaMHW8jVM0bwo8vf-i-aMZng
Message-ID: <CAJnrk1aJeNmQLd99PuzWVp8EycBBNBf1NZEE+sM6BY_gS64DCw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] fs/writeback: skip inodes with potential writeback
 hang in wait_sb_inodes()
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, shakeel.butt@linux.dev, 
	athul.krishna.kr@protonmail.com, miklos@szeredi.hu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 5:58=E2=80=AFAM David Hildenbrand (Red Hat)
<david@kernel.org> wrote:
>
> On 11/20/25 22:20, Joanne Koong wrote:
> > On Thu, Nov 20, 2025 at 12:23=E2=80=AFPM David Hildenbrand (Red Hat)
> > <david@kernel.org> wrote:
> >>
> >> On 11/20/25 19:42, Joanne Koong wrote:
> >>> During superblock writeback waiting, skip inodes where writeback may
> >>> take an indefinite amount of time or hang, as denoted by the
> >>> AS_WRITEBACK_MAY_HANG mapping flag.
> >>>
> >>> Currently, fuse is the only filesystem with this flag set. For a
> >>> properly functioning fuse server, writeback requests are completed an=
d
> >>> there is no issue. However, if there is a bug in the fuse server and =
it
> >>> hangs on writeback, then without this change, wait_sb_inodes() will w=
ait
> >>> forever.
> >>>
> >>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>> Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and inter=
nal rb tree")
> >>> Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
> >>> ---
> >>>    fs/fs-writeback.c | 3 +++
> >>>    1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> >>> index 2b35e80037fe..eb246e9fbf3d 100644
> >>> --- a/fs/fs-writeback.c
> >>> +++ b/fs/fs-writeback.c
> >>> @@ -2733,6 +2733,9 @@ static void wait_sb_inodes(struct super_block *=
sb)
> >>>                if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
> >>>                        continue;
> >>>
> >>> +             if (mapping_writeback_may_hang(mapping))
> >>> +                     continue;
> >>
> >> I think I raised it in the past, but simply because it could happen, w=
hy
> >> would we unconditionally want to do that for all fuse mounts? That jus=
t
> >> seems wrong :(
> >
> > I think it's considered a userspace regression if we don't revert the
> > program behavior back to its previous version, even if it is from the
> > program being incorrectly written, as per the conversation in [1].
> >
> > [1] https://lore.kernel.org/regressions/CAJnrk1Yh4GtF-wxWo_2ffbr90R44u0=
WDmMAEn9vr9pFgU0Nc6w@mail.gmail.com/T/#m73cf4b4828d51553caad3209a5ac92bca78=
e15d2
> >
> >>
> >> To phrase it in a different way, if any writeback could theoretically
> >> hang, why are we even waiting on writeback in the first place?
> >>
> >
> > I think it's because on other filesystems, something has to go
> > seriously wrong for writeback to hang, but on fuse a server can easily
> > make writeback hang and as it turns out, there are already existing
> > userspace programs that do this accidentally.
>
> Sorry, I only found the time to reply now. I wanted to reply in more
> detail why what you propose here does not make sense to me.

No worries at all, thank you for taking the time to write out your thoughts=
.

>
> I understand that it might make one of the weird fuse scenarios (buggy
> fuse server) work again, but it sounds like we are adding more hacks on
> top of broken semantics. If we want to tackle the writeback problem, we
> should find a proper way to deal with that for good.

I agree that this doesn't solve the underlying problem that folios
belonging to a malfunctioning fuse server may be stuck in writeback
state forever. To properly and comprehensively address that and the
other issues (which you alluded to a bit in section 3 below) would I
think be a much larger effort, but as I understand it, a userspace
regression needs to be resolved more immediately. I wasn't aware that
if the regression is caused by a faulty userspace program, that rule
still holds, but I was made aware of that. Even though there are other
ways that sync could be held up by a faulty/malicious userspace
program prior to the changes that were added in commit 0c58a97f919c
("fuse: remove tmp folio for writebacks and internal rb tree"), I
think the issue is that that commit gives malfunctioning servers
another way, which may be a way that some well-intended but buggy
servers could trigger, which is considered a regression. If it's
acceptable to delay addressing this until the actual solution that
addresses the entire problem, then I agree that this patchset is
unnecessary and we should just wait for the more comprehensive
solution.

>
>
> (1) AS_WRITEBACK_MAY_HANG semantics
>
> As discussed in the past, writeeback of pretty much any filesystem might
> hang forever on I/O errors.
>
> On network filesystems apparently as well fairly easily.
>
> It's completely unclear when to set AS_WRITEBACK_MAY_HANG.
>
> So as writeback on any filesystem may hang, AS_WRITEBACK_MAY_HANG would
> theoretically have to be set on any mapping out there.
>
> The semantics don't make sense to me, unfortuantely.

I'm not sure what a better name here would be unfortunately. I
considered AS_WRITEBACK_UNRELIABLE and AS_WRITEBACK_UNSTABLE but I
think those run into the same issue where that could technically be
true of any filesystem (eg the block layer may fail the writeback, so
it's not completely reliable/stable).

>
>
> (2) AS_WRITEBACK_MAY_HANG usage
>
> It's unclear in which scenarios we would not want to wait for writeback,
> and what the effects of that are.
>
> For example, wait_sb_inodes() documents "Data integrity sync. Must wait
> for all pages under writeback, because there may have been pages dirtied
> before our sync call ...".
>
> It's completely unclear why it might be okay to skip that simply because
> a mapping indicated that waiting for writeback is maybe more sketchy
> than on other filesystems.
>
> But what concerns me more is what we do about other
> folio_wait_writeback() callers. Throwing in AS_WRITEBACK_MAY_HANG
> wherever somebody reproduced a hang is not a good approach.

If I'm recalling this correctly (I'm looking back at this patchset [1]
to trigger my memory), there were 3 cases where folio_wait_writeback()
callers run into issues: reclaim, sync, and migration. The reclaim
issue is addressed. For the migration case, I don't think this results
in any user-visible regressions. Not that the migration case is not a
big issue, I think we should find a proper fix for it, but the
migration stall is already easily caused by a server indefinitely
holding a folio lock, so the writeback case didn't add this stall as a
new side effect.

[1] https://lore.kernel.org/linux-fsdevel/20241122232359.429647-1-joannelko=
ong@gmail.com/
>
> We need something more robust where we can just not break the kernel in
> weird ways because user space is buggy or malicious.
>
>
> (3) Other operations
>
> If my memory serves me right, there are similar issues on readahead. It
> wouldn't surprise me if there are yet other operations where fuse Et al
> can trick the kernel into hanging forever.
>
> So I'm wondering if there is more to this than just "writeback may hang".
>
>
>
> Obviously, getting the kernel to hang, controlled by user space that
> easily, is extremely unpleasant and probably the thing that I really
> dislike about fuse. Amir mentioned that maybe the iomap changes from
> Darrick might improve the situation in the long run, I would hope it
> would allow for de-nastifying fuse in that sense, at least in some
> scenarios.
>
>
> I cannot really say what would be better here (maybe aborting writeback
> after a short timeout), but AS_WRITEBACK_MAY_HANG to then just skip
> selected waits for writeback is certainly something that does not make
> sense to me.
>
>
> Regarding the patch here, is there a good reason why fuse does not have
> to wait for the "Data integrity sync. Must wait for all pages under
> writeback ..."?
>
> IOW, is the documented "must" not a "must" for fuse? In that case,

Prior to the changes added in commit 0c58a97f919c ("fuse: remove tmp
folio for writebacks and internal rb tree"), fuse didn't ensure that
data was written back for sync. The folio was marked as not under
writeback anymore, even if it was still under writeback.

> having a flag that states something like that that
> "AS_NO_WRITEBACK_WAIT_ON_DATA_SYNC" would probable be what we would want
> to add to avoid waiting for writeback with clear semantics why it is ok
> in that specific scenario.

Having a separate AS_NO_WRITEBACK_WAIT_ON_DATA_SYNC mapping flag
sounds reasonable to me and I agree is more clearer semantically.

>
> Hope that helps, and happy to be convinced why AS_WRITEBACK_MAY_HANG is
> the right thing to do in this way proposed here.

This was helpful, thanks for your thoughts!

>
> --
> Cheers
>
> David

