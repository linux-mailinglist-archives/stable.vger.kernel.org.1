Return-Path: <stable+bounces-166660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 079EFB1BD72
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 01:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A37D118A665E
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 23:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674A426056C;
	Tue,  5 Aug 2025 23:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1l8oO59i"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E787025A640
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 23:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754437293; cv=none; b=d9nJi7MP8HnAtdCDb8Ya95GsGfNL5p+cNjD/lTrBSwnpxBUNiXX8Riyfnz8W3uIej01L/kgsfczZ0pU/g6ncAo0nsYqMzo2Xvpry/1S883XimF5woeaca4mRqtuEtaR+D5RYmE1T3em1Qu82a/z/yIDy7gm1dEh3ZUtDWub9XDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754437293; c=relaxed/simple;
	bh=ZuU1pZTIVc9kG8ukS1mMjqkO4CYJdigw0zkilMJyIBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXz8YF5uUKfCNS/GGXFKph9hJVWlWdgSmPyYW5iH+1uXrguggwGuZivhfZukreXQga7tM/Ecr7K+i7AIm5bkEeR2rxc2gEz1TV3taI2s04t09umecEMy+36DRRsbUihQmCFD9GY+4ibUKAw6rF8/Z0DF+8rFUMG4Zo7gZDDOJjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1l8oO59i; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b0673b0a7cso250091cf.0
        for <stable@vger.kernel.org>; Tue, 05 Aug 2025 16:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754437290; x=1755042090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+S3bmPXejwFO1KMmyrSrq+aYMwqbrRLmpkvUdxnslc=;
        b=1l8oO59idod/0c6vmQe6e40Ie9dlAJWmtBKiYTGn658pHR6dCxffeVpEMa8TwT3COd
         +TCkOqNRImUf1exwyVK2RsvL9CiADXFAb0mqsp3y39+UWiMyZW1B6wtVwrRtMxQKGRPI
         M9RpptYDJFbG0LUSZok3TAnBSscwmMOGOzDVuYGoY5JqDJtLCHiRvC6Hk4U2VmhzjOkC
         t/pOAE7qT5xSmNFLU1xhagDWzRhkjKXe9Z0TlSGxZPczQVqxSO/n+pU4kfYD7mtTNP3M
         KPtUazVI5kHfmv/PKgDG/reCoaMESCdCc9KJHR7EyXtZiTjUmt5O8CBgpbD2XmWZ9F9P
         KzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754437290; x=1755042090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+S3bmPXejwFO1KMmyrSrq+aYMwqbrRLmpkvUdxnslc=;
        b=S/213LHWbJdbM9mZw2kIihwJSbRlgcrqoAaL8qD5vsbnI3E0zlyQzKsIDN9h145oXs
         i8+cDhTH8D7M3I2OsTGX+horGiXfd+X+FKSOE4ig8SrlugefXJZoii/Al151ujlZAIiN
         uKYVn02HpJYXByjcvSL2k6nLxLtlynRUY1x5puegyFyYLv0IsrFebBcejHNaB/8svILq
         DUkXcnlfNH3TrIi55Bvq+MLIwDdZUusM1C6mdd6kG0mNSGQFZg97c5GxG4DBQNhLjH/2
         dVa2VrGOjqNBUWrZFP8j9vTS0T9XaiVjVLhjnsTz4roPZQfRMefek5wo1s4C0XOBqG2s
         Nrtw==
X-Forwarded-Encrypted: i=1; AJvYcCU39z/m2miJuw1mKIHRjCiUDxZAg1qZ37RjLEUkxMzGZm2uJ03hjAqq8FeWCkdTANzGkEvKaMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynlrxQqWpnWnJXF31ysi4BlnNeWOJyKFSX4YkamVjrNi20gMMi
	ksaN5lcphPFhtnrzFd5zOGZ+d74DmWnQ7X3olD9cWWMZLJVEapVojCZji2uIMawKsHqriHH1PS3
	tUWsoi8Ekjl6lJKZJBSO7zxjW9MFIk8J6RIu88A1x
X-Gm-Gg: ASbGncvknAW66ft1rrT1Xp9Te7M6bOfZ8BuoqfeZi/17Rt/s3a+3loqcyog2zS+W1HK
	vp250Z32+suuhB8DGpE5uEt3GG5RBv66ahN7EE6fzrwFFJAo1ayJv//fyM2je5m+q6KkW4u9W2T
	z8riyEqviZYvg7S/V5Z0iXI5j1tJOFxs6MECI/8EaotI+QT4EfmDemyhpr9rVvmeeLR4I0cDGxp
	Hc0sDJWeDcXZmPyWxYgqDRTWnVLAMz2TdpmgpfBqJhHGLhF
X-Google-Smtp-Source: AGHT+IEEmBiUQbr0GQVcfi3phUF9vukRyuZfQf9xofLE27keKB1H1qrGIdFCVd6QbGW9E6OxiTrII591nTP7vFtRWWg=
X-Received: by 2002:ac8:7e90:0:b0:4ae:d2cc:ad51 with SMTP id
 d75a77b69052e-4b09261783cmr1338171cf.1.1754437289233; Tue, 05 Aug 2025
 16:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aIzMGlrR1SL5Y_Gp@x1.local> <CAJuCfpEqOUj8VPybstQjoJvCzyZtG6Q5Vr4WT0Lx_r3LFVS7og@mail.gmail.com>
 <aIzp6WqdzhomPhhf@x1.local> <CAJuCfpGWLnu+r2wvY2Egy2ESPD=tAVvfVvAKXUv1b+Z0hweeJg@mail.gmail.com>
 <aIz1xrzBc2Spa2OH@x1.local> <CAJuCfpFJGaDaFyNLa3JsVh19NWLGNGo1ebC_ijGTgPGNyfUFig@mail.gmail.com>
 <aI0Ffc9WXeU2X71O@x1.local> <CAJuCfpFSY3fDH36dabS=nGzasZJ6FtQ_jv79eFWVZrEWRMMTiQ@mail.gmail.com>
 <aI1ckD3KhNvoMtlv@x1.local> <CAJuCfpHcScutgGi3imYTJVXBqs=jcqZ5CkKKe=sfVHjUg0Y6RQ@mail.gmail.com>
 <aJIXlN-ZD_soWdP0@x1.local> <CAJuCfpFzP_W8i8pwL+-Uv-n+2LixgFrzqn2HsY_h-1kbP=g3JQ@mail.gmail.com>
 <CAJuCfpFEf92gTR+Jw+1wcCcT0fEt-SP193NHzpyxVXJA=VAwng@mail.gmail.com>
In-Reply-To: <CAJuCfpFEf92gTR+Jw+1wcCcT0fEt-SP193NHzpyxVXJA=VAwng@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 5 Aug 2025 16:41:18 -0700
X-Gm-Features: Ac12FXyFn6ZM5k32WyQsCctB41kkckIUGLUX8rOqsdud2EjylewU1LQBkK1P12w
Message-ID: <CAJuCfpFeSVq+hq4JRJStLgFfQgmS6SQ7zoFsj4=SeQT89r3TTw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] userfaultfd: fix a crash when UFFDIO_MOVE handles
 a THP hole
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, aarcange@redhat.com, 
	lokeshgidra@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 1:39=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Tue, Aug 5, 2025 at 7:57=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
> >
> > On Tue, Aug 5, 2025 at 7:39=E2=80=AFAM Peter Xu <peterx@redhat.com> wro=
te:
> > >
> > > On Mon, Aug 04, 2025 at 07:55:42AM -0700, Suren Baghdasaryan wrote:
> > > > On Fri, Aug 1, 2025 at 5:32=E2=80=AFPM Peter Xu <peterx@redhat.com>=
 wrote:
> > > > >
> > > > > On Fri, Aug 01, 2025 at 07:30:02PM +0000, Suren Baghdasaryan wrot=
e:
> > > > > > On Fri, Aug 1, 2025 at 6:21=E2=80=AFPM Peter Xu <peterx@redhat.=
com> wrote:
> > > > > > >
> > > > > > > On Fri, Aug 01, 2025 at 05:45:10PM +0000, Suren Baghdasaryan =
wrote:
> > > > > > > > On Fri, Aug 1, 2025 at 5:13=E2=80=AFPM Peter Xu <peterx@red=
hat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Aug 01, 2025 at 09:41:31AM -0700, Suren Baghdasar=
yan wrote:
> > > > > > > > > > On Fri, Aug 1, 2025 at 9:23=E2=80=AFAM Peter Xu <peterx=
@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Fri, Aug 01, 2025 at 08:28:38AM -0700, Suren Baghd=
asaryan wrote:
> > > > > > > > > > > > On Fri, Aug 1, 2025 at 7:16=E2=80=AFAM Peter Xu <pe=
terx@redhat.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, Aug 01, 2025 at 09:21:30AM +0200, David H=
ildenbrand wrote:
> > > > > > > > > > > > > > On 31.07.25 17:44, Suren Baghdasaryan wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Hi!
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Did you mean in you patch description:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > "userfaultfd: fix a crash in UFFDIO_MOVE with s=
ome non-present PMDs"
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Talking about THP holes is very very confusing.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > When UFFDIO_MOVE is used with UFFDIO_MOVE_MOD=
E_ALLOW_SRC_HOLES and it
> > > > > > > > > > > > > > > encounters a non-present THP, it fails to pro=
perly recognize an unmapped
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > You mean a "non-present PMD that is not a migra=
tion entry".
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > > hole and tries to access a non-existent folio=
, resulting in
> > > > > > > > > > > > > > > a crash. Add a check to skip non-present THPs=
.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > That makes sense. The code we have after this p=
atch is rather complicated
> > > > > > > > > > > > > > and hard to read.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOV=
E uABI")
> > > > > > > > > > > > > > > Reported-by: syzbot+b446dbe27035ef6bd6c2@syzk=
aller.appspotmail.com
> > > > > > > > > > > > > > > Closes: https://lore.kernel.org/all/68794b5c.=
a70a0220.693ce.0050.GAE@google.com/
> > > > > > > > > > > > > > > Signed-off-by: Suren Baghdasaryan <surenb@goo=
gle.com>
> > > > > > > > > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > > > > > > > > ---
> > > > > > > > > > > > > > > Changes since v1 [1]
> > > > > > > > > > > > > > > - Fixed step size calculation, per Lokesh Gid=
ra
> > > > > > > > > > > > > > > - Added missing check for UFFDIO_MOVE_MODE_AL=
LOW_SRC_HOLES, per Lokesh Gidra
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > [1] https://lore.kernel.org/all/2025073017073=
3.3829267-1-surenb@google.com/
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >   mm/userfaultfd.c | 45 +++++++++++++++++++++=
++++++++----------------
> > > > > > > > > > > > > > >   1 file changed, 29 insertions(+), 16 deleti=
ons(-)
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > diff --git a/mm/userfaultfd.c b/mm/userfaultf=
d.c
> > > > > > > > > > > > > > > index cbed91b09640..b5af31c22731 100644
> > > > > > > > > > > > > > > --- a/mm/userfaultfd.c
> > > > > > > > > > > > > > > +++ b/mm/userfaultfd.c
> > > > > > > > > > > > > > > @@ -1818,28 +1818,41 @@ ssize_t move_pages(st=
ruct userfaultfd_ctx *ctx, unsigned long dst_start,
> > > > > > > > > > > > > > >             ptl =3D pmd_trans_huge_lock(src_p=
md, src_vma);
> > > > > > > > > > > > > > >             if (ptl) {
> > > > > > > > > > > > > > > -                   /* Check if we can move t=
he pmd without splitting it. */
> > > > > > > > > > > > > > > -                   if (move_splits_huge_pmd(=
dst_addr, src_addr, src_start + len) ||
> > > > > > > > > > > > > > > -                       !pmd_none(dst_pmdval)=
) {
> > > > > > > > > > > > > > > -                           struct folio *fol=
io =3D pmd_folio(*src_pmd);
> > > > > > > > > > > > > > > +                   if (pmd_present(*src_pmd)=
 || is_pmd_migration_entry(*src_pmd)) {
> > > > > > > > > > > > >
> > > > > > > > > > > > > [1]
> > > > > > > > > > > > >
> > > > > > > > > > > > > > > +                           /* Check if we ca=
n move the pmd without splitting it. */
> > > > > > > > > > > > > > > +                           if (move_splits_h=
uge_pmd(dst_addr, src_addr, src_start + len) ||
> > > > > > > > > > > > > > > +                               !pmd_none(dst=
_pmdval)) {
> > > > > > > > > > > > > > > +                                   if (pmd_p=
resent(*src_pmd)) {
> > > > > > > > > > >
> > > > > > > > > > > [2]
> > > > > > > > > > >
> > > > > > > > > > > > > > > +                                           s=
truct folio *folio =3D pmd_folio(*src_pmd);
> > > > > > > > > > >
> > > > > > > > > > > [3]
> > > > > > > > > > >
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +                                           i=
f (!folio || (!is_huge_zero_folio(folio) &&
> > > > > > > > > > > > > > > +                                            =
              !PageAnonExclusive(&folio->page))) {
> > > > > > > > > > > > > > > +                                            =
       spin_unlock(ptl);
> > > > > > > > > > > > > > > +                                            =
       err =3D -EBUSY;
> > > > > > > > > > > > > > > +                                            =
       break;
> > > > > > > > > > > > > > > +                                           }
> > > > > > > > > > > > > > > +                                   }
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > ... in particular that. Is there some way to ma=
ke this code simpler / easier
> > > > > > > > > > > > > > to read? Like moving that whole last folio-chec=
k thingy into a helper?
> > > > > > > > > > > > >
> > > > > > > > > > > > > One question might be relevant is, whether the ch=
eck above [1] can be
> > > > > > > > > > > > > dropped.
> > > > > > > > > > > > >
> > > > > > > > > > > > > The thing is __pmd_trans_huge_lock() does double =
check the pmd to be !none
> > > > > > > > > > > > > before returning the ptl.  I didn't follow closel=
y on the recent changes on
> > > > > > > > > > > > > mm side on possible new pmd swap entries, if migr=
ation is the only possible
> > > > > > > > > > > > > one then it looks like [1] can be avoided.
> > > > > > > > > > > >
> > > > > > > > > > > > Hi Peter,
> > > > > > > > > > > > is_swap_pmd() check in __pmd_trans_huge_lock() allo=
ws for (!pmd_none()
> > > > > > > > > > > > && !pmd_present()) PMD to pass and that's when this=
 crash is hit.
> > > > > > > > > > >
> > > > > > > > > > > First for all, thanks for looking into the issue with=
 Lokesh; I am still
> > > > > > > > > > > catching up with emails after taking weeks off.
> > > > > > > > > > >
> > > > > > > > > > > I didn't yet read into the syzbot report, but I thoug=
ht the bug was about
> > > > > > > > > > > referencing the folio on top of a swap entry after re=
ading your current
> > > > > > > > > > > patch, which has:
> > > > > > > > > > >
> > > > > > > > > > >         if (move_splits_huge_pmd(dst_addr, src_addr, =
src_start + len) ||
> > > > > > > > > > >             !pmd_none(dst_pmdval)) {
> > > > > > > > > > >                 struct folio *folio =3D pmd_folio(*sr=
c_pmd); <----
> > > > > > > > > > >
> > > > > > > > > > > Here looks like *src_pmd can be a migration entry. Is=
 my understanding
> > > > > > > > > > > correct?
> > > > > > > > > >
> > > > > > > > > > Correct.
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > If we drop the check at [1] then the path that take=
s us to
> > > > > > > > > > >
> > > > > > > > > > > If my above understanding is correct, IMHO it should =
be [2] above that
> > > > > > > > > > > makes sure the reference won't happen on a swap entry=
, not necessarily [1]?
> > > > > > > > > >
> > > > > > > > > > Yes, in case of migration entry this is what protects u=
s.
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > split_huge_pmd() will bail out inside split_huge_pm=
d_locked() with no
> > > > > > > > > > > > indication that split did not happen. Afterwards we=
 will retry
> > > > > > > > > > >
> > > > > > > > > > > So we're talking about the case where it's a swap pmd=
 entry, right?
> > > > > > > > > >
> > > > > > > > > > Hmm, my understanding is that it's being treated as a s=
wap entry but
> > > > > > > > > > in reality is not. I thought THPs are always split befo=
re they get
> > > > > > > > > > swapped, no?
> > > > > > > > >
> > > > > > > > > Yes they should be split, afaiu.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > Could you elaborate why the split would fail?
> > > > > > > > > >
> > > > > > > > > > Just looking at the code, split_huge_pmd_locked() check=
s for
> > > > > > > > > > (pmd_trans_huge(*pmd) || is_pmd_migration_entry(*pmd)).
> > > > > > > > > > pmd_trans_huge() is false if !pmd_present() and it's no=
t a migration
> > > > > > > > > > entry, so __split_huge_pmd_locked() will be skipped.
> > > > > > > > >
> > > > > > > > > Here might be the major part of where confusion came from=
: I thought it
> > > > > > > > > must be a migration pmd entry to hit the issue, so it's n=
ot?
> > > > > > > > >
> > > > > > > > > I checked the code just now:
> > > > > > > > >
> > > > > > > > > __handle_mm_fault:
> > > > > > > > >                 if (unlikely(is_swap_pmd(vmf.orig_pmd))) =
{
> > > > > > > > >                         VM_BUG_ON(thp_migration_supported=
() &&
> > > > > > > > >                                           !is_pmd_migrati=
on_entry(vmf.orig_pmd));
> > > > > > > > >
> > > > > > > > > So IIUC pmd migration entry is still the only possible wa=
y to have a swap
> > > > > > > > > entry.  It doesn't look like we have "real" swap entries =
for PMD (which can
> > > > > > > > > further points to some swapfiles)?
> > > > > > > >
> > > > > > > > Correct. AFAIU here we stumble on a pmd entry which was all=
ocated but
> > > > > > > > never populated.
> > > > > > >
> > > > > > > Do you mean a pmd_none()?
> > > > > >
> > > > > > Yes.
> > > > > >
> > > > > > >
> > > > > > > If so, that goes back to my original question, on why
> > > > > > > __pmd_trans_huge_lock() returns non-NULL if it's a pmd_none()=
?  IMHO it
> > > > > > > really should have returned NULL for pmd_none().
> > > > > >
> > > > > > That was exactly the answer I gave Lokesh when he theorized abo=
ut the
> > > > > > cause of this crash but after reproducing it I saw that
> > > > > > pmd_trans_huge_lock() happily returns the PTL as long as PMD is=
 not
> > > > > > pmd_none(). And that's because it passes as is_swap_pmd(). But =
even if
> > > > > > we change that we still need to implement the code to skip the =
entire
> > > > > > PMD.
> > > > >
> > > > > The thing is I thought if pmd_trans_huge_lock() can return non-NU=
LL, it
> > > > > must be either a migration entry or a present THP. So are you des=
cribing a
> > > > > THP but with present bit cleared?  Do you know what is that entry=
, and why
> > > > > it has present bit cleared?
> > > >
> > > > In this case it's because earlier we allocated that PMD here:
> > > > https://elixir.bootlin.com/linux/v6.16/source/mm/userfaultfd.c#L179=
7
> > >
> > > AFAIU, this line is not about allocation of any pmd entry, but the pm=
d
> > > pgtable page that _holds_ the PMDs:
> > >
> > > static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsi=
gned long address)
> > > {
> > >         return (unlikely(pud_none(*pud)) && __pmd_alloc(mm, pud, addr=
ess))?
> > >                 NULL: pmd_offset(pud, address);
> > > }
> > >
> > > It makes sure the PUD entry, not the PMD entry, be populated.
> >
> > Hmm. Then I was reading this code completely wrong and need to rethink
> > what is happening here.
> >
> > >
> > > > but wouldn't that be the same if the PMD was mapped and then got
> > > > unmapped later? My understanding is that we allocate the PMD at the
> > > > line I pointed to make UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES case the sa=
me
> > > > as this unmapped PMD case. If my assumption is incorrect then we co=
uld
> > > > skip the hole earlier instead of allocating the PMD for it.
> > > >
> > > > >
> > > > > I think my attention got attracted to pmd migration entry too muc=
h, so I
> > > > > didn't really notice such possibility, as I believe migration pmd=
 is broken
> > > > > already in this path.
> > > > >
> > > > > The original code:
> > > > >
> > > > >                 ptl =3D pmd_trans_huge_lock(src_pmd, src_vma);
> > > > >                 if (ptl) {
> > > > >                         /* Check if we can move the pmd without s=
plitting it. */
> > > > >                         if (move_splits_huge_pmd(dst_addr, src_ad=
dr, src_start + len) ||
> > > > >                             !pmd_none(dst_pmdval)) {
> > > > >                                 struct folio *folio =3D pmd_folio=
(*src_pmd);
> > > > >
> > > > >                                 if (!folio || (!is_huge_zero_foli=
o(folio) &&
> > > > >                                                !PageAnonExclusive=
(&folio->page))) {
> > > > >                                         spin_unlock(ptl);
> > > > >                                         err =3D -EBUSY;
> > > > >                                         break;
> > > > >                                 }
> > > > >
> > > > >                                 spin_unlock(ptl);
> > > > >                                 split_huge_pmd(src_vma, src_pmd, =
src_addr);
> > > > >                                 /* The folio will be split by mov=
e_pages_pte() */
> > > > >                                 continue;
> > > > >                         }
> > > > >
> > > > >                         err =3D move_pages_huge_pmd(mm, dst_pmd, =
src_pmd,
> > > > >                                                   dst_pmdval, dst=
_vma, src_vma,
> > > > >                                                   dst_addr, src_a=
ddr);
> > > > >                         step_size =3D HPAGE_PMD_SIZE;
> > > > >                 } else {
> > > > >
> > > > > It'll get ptl for a migration pmd, then pmd_folio is risky withou=
t checking
> > > > > present bit.  That's what my previous smaller patch wanted to fix=
.
> > > > >
> > > > > But besides that, IIUC it's all fine at least for a pmd migration=
 entry,
> > > > > because when with the smaller patch applied, either we'll try to =
split the
> > > > > pmd migration entry, or we'll do move_pages_huge_pmd(), which int=
ernally
> > > > > handles the pmd migration entry too by waiting on it:
> > > > >
> > > > >         if (!pmd_trans_huge(src_pmdval)) {
> > > > >                 spin_unlock(src_ptl);
> > > > >                 if (is_pmd_migration_entry(src_pmdval)) {
> > > > >                         pmd_migration_entry_wait(mm, &src_pmdval)=
;
> > > > >                         return -EAGAIN;
> > > > >                 }
> > > > >                 return -ENOENT;
> > > > >         }
> > > > >
> > > > > Then logically after the migration entry got recovered, we'll eit=
her see a
> > > > > real THP or pmd none next time.
> > > >
> > > > Yes, for migration entries adding the "if (pmd_present(*src_pmd))"
> > > > before getting the folio is enough. The problematic case is
> > > > (!pmd_none(*src_pmd) && !pmd_present(*src_pmd)) and not a migration
> > > > entry.
> > >
> > > I thought we could have any of below here on the pmd entry:
> > >
> > >   (0) pmd_none, which should constantly have pmd_trans_huge_lock -> N=
ULL
> > >
> > >   (1) pmd pgtable entry, which must have PRESENT && !TRANS, so
> > >   pmd_trans_huge_lock -> NULL,
> > >
> > >   (2) pmd migration, pmd_trans_huge_lock -> valid
> > >
> > >   (3) pmd thp, pmd_trans_huge_lock -> valid
> > >
> > > I thought (2) was broken, which we seem to agree upon.. however if so=
 the
> > > smaller patch should fix it, per explanation in my previous reply.  O=
TOH I
> > > can't think of (4).
> >
> > The case I was hitting is (!pmd_none && !pmd_present &&
> > !is_pmd_migration_entry). My original thinking was that this entry was
> > newly allocated at the line I pointed earlier but now I'm not so sure
> > anymore.
>
> Hmm, now I can't reproduce this case... I'm pretty sure I've seen that
> case before but now I hit an occasional migration entry and that's
> all. I must have done something wrong when testing it before.

Ok, I let the reproducer run for half a day and it did not hit this
case, so I must have done something wrong during my initial
investigation. Sorry for the confusion. I could have sworn that I saw
this case but now it just does not happen.

With migration entry being the only case that leads to that
pmd_folio(), the only check we need to add is the "if
(pmd_present(*src_pmd))" before pmd_folio(). Would you like me to
check anything else or should I go ahead and post that fix?

>
> >
> > >
> > > Said that, I just noticed (3) can be broken as well - could it be a
> > > prot_none entry?  The very confusing part of this patch is it seems t=
o
> > > think it's pmd_none() here as holes:
> > >
> > >         if (pmd_present(*src_pmd) || is_pmd_migration_entry(*src_pmd)=
) {
> > >                 ...
> > >         } else {
> > >                 spin_unlock(ptl);
> > >                 if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES)) {
> > >                         err =3D -ENOENT;
> > >                         break;
> > >                 }
> > >                 /* nothing to do to move a hole */
> > >                 err =3D 0;
> > >                 step_size =3D min(HPAGE_PMD_SIZE, src_start + len - s=
rc_addr);
> > >         }
> > >
> > > But is it really?  Again, I don't think pmd_none() could happen with
> > > pmd_trans_huge_lock() returning the ptl.
> >
> > That is true, in the pmd_none() case pmd_trans_huge_lock() returns NULL=
.
> >
> > >
> > > Could you double check this?  E.g. with this line if that makes sense=
 to
> > > you:
> > >
> > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > index 8bf8ff0be990f..d2d4f2a0ae69f 100644
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
> > > @@ -1903,6 +1903,7 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx,=
 unsigned long dst_start,
> > >                                                           dst_addr, s=
rc_addr);
> > >                                 step_size =3D HPAGE_PMD_SIZE;
> > >                         } else {
> > > +                               BUG_ON(!pmd_none(*src_pmd));
> > >                                 spin_unlock(ptl);
> > >                                 if (!(mode & UFFDIO_MOVE_MODE_ALLOW_S=
RC_HOLES)) {
> > >                                         err =3D -ENOENT;
> > >
> > > I would expect it constantly BUG() here, if that explains my thoughts=
.
> >
> > I'll add this and check.
>
> This check does trigger and I logged pmd_val=3D0x8b3714067 and I think
> this is normal. _PAGE_BIT_PRESENT is set and _PAGE_BIT_PSE is not set,
> so is_swap_pmd()=3D=3Dfalse and pmd_trans_huge()=3D=3Dfalse, therefore
> pmd_trans_huge_lock() returns NULL.
>
>
> >
> > >
> > > Now I doubt it's a prot_none THP.. aka, a THP that got numa hint to b=
e
> > > moved.  If so, we may need to process it / move it / .. but we likely
> > > should never skip it.  We can double check the buggy pmd entry you hi=
t
> > > (besides migration entry) first.
> >
> > Let me log the flags of the entry when this issue happens. That should
> > provide more insights.
> > Thanks,
> > Suren.
> >
> > >
> > > Thanks,
> > >
> > > --
> > > Peter Xu
> > >

