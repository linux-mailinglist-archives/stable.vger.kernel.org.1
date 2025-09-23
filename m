Return-Path: <stable+bounces-181452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B578BB952CF
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 11:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA50178B8D
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 09:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F3F31C584;
	Tue, 23 Sep 2025 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rdsOOVRD"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F4C3203A1
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758618722; cv=none; b=nIvScfvFywqChBFN4rioUxiI4BRNzqT4f/Ecx5eyTxdUCBVWa7nWUCA8BJb8TTJV3Rxuuqlm3e2px18G7yONz+2A9T8mxx12lIksWhiKUkwIiMKsqs/Srt/U5aE9+vV9jewWfsRF9Q9Bgm72peo7qFsB/cw2a1lY3oV16twFveA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758618722; c=relaxed/simple;
	bh=lO6XNYKk1A+drbqhtT/FltmXv4UgeVDxFYhm3l/Dofw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mp/J5iwu+8ru1oxmCvTzhrxTGaOgSJkJ+gDJNu6UWF48Y/ulr6dkdU/zxSTlPTt1DnjmOwtQzx6bYcE1y1DQVvo7LliMrPVLc2yUfQMyKrRbPbHPrqVO05PweQ/kP7ulGsX9X6zQGJhqT8r9LkM9FTr3aHXu/cnieq8H4yRm3FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rdsOOVRD; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-ea5bcc26849so4009352276.1
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 02:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758618716; x=1759223516; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1g6i16D4bYNhzUvc3NCMZjroQ5BzhD+L2h8rh53wGx0=;
        b=rdsOOVRDPWagD3UUroO6C18KISW2RQ5fiZIkQDhnpzZXfjSxFYiT4v9PMkBODfQAZj
         x3lHnNJMDmvlpSceTo6EPsIPiDVxOY95BnIdrM4ExftXEFfte+QMO9KBVM2Z9p4phuEm
         RrXEwxUa+BoLyzTBPPMJdpWhOa0BMfVTifRItnofzLUi38yTv10RjSNPoYdU/d9j/++c
         gs7++0ZSAp1fnXeZJkBk1JrLXQyBy+ZgosQKqY9ZJYyB8XhK8fBQiNGxtYl67f08T1Tq
         aFgKEabsZ0wv0pdOqiv2WrXTWPbQughUbJ5ADPTbMnDgvOyXzKqAgFCEv1FSHEOVs5wc
         iuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758618716; x=1759223516;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1g6i16D4bYNhzUvc3NCMZjroQ5BzhD+L2h8rh53wGx0=;
        b=tUHlez+/If1Y5yfqZWpJ0xNHq/HMJHczIgOfkaq6it5bct5dE9wALMPpNnvq0pgulN
         l+kpowqdIDTiaLB/qniodWoX31n2HMIj2rHb7DnoxemaKwfYhcZj7jTC42+R9yB/Q4Pg
         7pSKK+f98WIs7XTYmm4zwp12/Lc5jkb49sUtVObWOuPgAL9ncmDKJCOS8tvQOPpqkuW9
         10Bu8InNGGlAdLfiEAHwHi2cRKgeY8XfIK4X5aCccXrRpktzxlzbPcGDJ9mfNHsqzq+g
         cq3lTB+96qwCewvEgbY0HYn3riEMseY6S6Farrl2jD5R+bjWbITRyzMQoWm9/HY+ZRw1
         6g2g==
X-Forwarded-Encrypted: i=1; AJvYcCX3OE7OlW16HNB6iaPrmFqUo6L+3qPfjPELSVfmmHEPz8AhWSMJhIagX7cUrRjIKoI3l4MCp+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQxY+CjaAW+Y1/6U4TQc3fecR/M7Rtdq4DPoWZXSu7TFsoo+TC
	fGb8bpiCHu9D9clJXB2PhD28OvdlZ0BcL8gPL8pTXboyQdRjK+S/Sh9TXiLi9skfCQ==
X-Gm-Gg: ASbGnctm5uGXuAX16/A+W6SJDaagDoBkT4T/+lRdKAEiKBWD5CNk5tcE8ZToPyln8Ow
	vlfjiHgZ0LltKsDNmBUW6WmlpeBQhFbIZ81eqDadmI68vCzpuUWPuPI9+k+Vb66mqN8BjNj1vD0
	EqDwC3Htu8JjERsX3evG1hR5hAsnNw7XRc0R/akJ5c0SrAj4Ifc/n4RgCkFvmMdVBbhtfKnk73a
	rpYvpC/5i4KMYc1N7aSn610G2gfSYf6lrFIJ7kb5cRkOI8NZtjfdh4CeQkoHg2XZq71AlTWajnL
	Psv6CkzyIIxegP3KVHNvKpph8Svt2duaJhO05nDN6S0o6CQjLbFF7kogNmNautE8XUXi1J8oQZb
	R04Ky7Fz2lt6R4qfKGdhHhhkdLbuSZTsJMBEMd+rI9RkNcR3x+oX+960rfcQ87vLGRQNF31cZTg
	NqM412KkAdq6+R1A==
X-Google-Smtp-Source: AGHT+IE+43mDWjc1QUxjSzKPYUViD3zDfGYxWARaGe403kbwzj+BdYLUOXxtV8Pghl+F0EVHj5V+kg==
X-Received: by 2002:a05:6902:2742:b0:e98:9eaa:d036 with SMTP id 3f1490d57ef6-eb33077246emr1535504276.39.1758618715386;
        Tue, 23 Sep 2025 02:11:55 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce971473sm4857284276.23.2025.09.23.02.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:11:53 -0700 (PDT)
Date: Tue, 23 Sep 2025 02:11:39 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Greg KH <gregkh@linuxfoundation.org>
cc: Sasha Levin <sashal@kernel.org>, Will Deacon <will@kernel.org>, 
    Hugh Dickins <hughd@google.com>, Greg KH <gregkh@linuxfoundation.org>, 
    stable@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Axel Rasmussen <axelrasmussen@google.com>, Chris Li <chrisl@kernel.org>, 
    Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
    Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>, 
    Keir Fraser <keirf@google.com>, Konstantin Khlebnikov <koct9i@gmail.com>, 
    Li Zhe <lizhe.67@bytedance.com>, 
    "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
    Peter Xu <peterx@redhat.com>, Rik van Riel <riel@surriel.com>, 
    Shivank Garg <shivankg@amd.com>, Vlastimil Babka <vbabka@suse.cz>, 
    Wei Xu <weixugc@google.com>, yangge <yangge1116@126.com>, 
    Yuanchu Xie <yuanchu@google.com>, Yu Zhao <yuzhao@google.com>, 
    Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12.y] mm: folio_may_be_lru_cached() unless
 folio_test_large()
In-Reply-To: <aNFjZVvcOaXLJh82@laps>
Message-ID: <67da8221-7382-818b-3a82-52d7903b1cd3@google.com>
References: <2025092142-easiness-blatancy-23af@gregkh> <20250921154134.2945191-1-sashal@kernel.org> <2025092135-collie-parched-1244@gregkh> <b7e6758f-9942-81ca-c5fd-1753ce49aa32@google.com> <aNEbqzso0rloTd-V@willie-the-truck> <aNFjZVvcOaXLJh82@laps>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-1581705103-1758618713=:5004"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-1581705103-1758618713=:5004
Content-Type: text/plain; charset=US-ASCII

On Mon, 22 Sep 2025, Sasha Levin wrote:
> On Mon, Sep 22, 2025 at 10:49:31AM +0100, Will Deacon wrote:
> >On Sun, Sep 21, 2025 at 09:05:35PM -0700, Hugh Dickins wrote:
> >> On Sun, 21 Sep 2025, Greg KH wrote:
> >> > On Sun, Sep 21, 2025 at 11:41:34AM -0400, Sasha Levin wrote:
> >> > > From: Hugh Dickins <hughd@google.com>
> >> > >
> >> > > [ Upstream commit 2da6de30e60dd9bb14600eff1cc99df2fa2ddae3 ]
> >> > >
> >> > > mm/swap.c and mm/mlock.c agree to drain any per-CPU batch as soon as a
> >> > > large folio is added: so collect_longterm_unpinnable_folios() just
> >> > > wastes
> >> > > effort when calling lru_add_drain[_all]() on a large folio.
> >> > >
> >> > > But although there is good reason not to batch up PMD-sized folios, we
> >> > > might well benefit from batching a small number of low-order mTHPs
> >> > > (though
> >> > > unclear how that "small number" limitation will be implemented).
> >> > >
> >> > > So ask if folio_may_be_lru_cached() rather than !folio_test_large(), to
> >> > > insulate those particular checks from future change.  Name preferred to
> >> > > "folio_is_batchable" because large folios can well be put on a batch:
> >> > > it's
> >> > > just the per-CPU LRU caches, drained much later, which need care.
> >> > >
> >> > > Marked for stable, to counter the increase in lru_add_drain_all()s from
> >> > > "mm/gup: check ref_count instead of lru before migration".
> >> > >
> >> > > Link:
> >> > > https://lkml.kernel.org/r/57d2eaf8-3607-f318-e0c5-be02dce61ad0@google.com
> >> > > Fixes: 9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate
> >> > > pages allocated from CMA region")
> >> > > Signed-off-by: Hugh Dickins <hughd@google.com>
> >> > > Suggested-by: David Hildenbrand <david@redhat.com>
> >> > > Acked-by: David Hildenbrand <david@redhat.com>
> >> > > Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
> >> > > Cc: Axel Rasmussen <axelrasmussen@google.com>
> >> > > Cc: Chris Li <chrisl@kernel.org>
> >> > > Cc: Christoph Hellwig <hch@infradead.org>
> >> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> >> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> >> > > Cc: John Hubbard <jhubbard@nvidia.com>
> >> > > Cc: Keir Fraser <keirf@google.com>
> >> > > Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> >> > > Cc: Li Zhe <lizhe.67@bytedance.com>
> >> > > Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> >> > > Cc: Peter Xu <peterx@redhat.com>
> >> > > Cc: Rik van Riel <riel@surriel.com>
> >> > > Cc: Shivank Garg <shivankg@amd.com>
> >> > > Cc: Vlastimil Babka <vbabka@suse.cz>
> >> > > Cc: Wei Xu <weixugc@google.com>
> >> > > Cc: Will Deacon <will@kernel.org>
> >> > > Cc: yangge <yangge1116@126.com>
> >> > > Cc: Yuanchu Xie <yuanchu@google.com>
> >> > > Cc: Yu Zhao <yuzhao@google.com>
> >> > > Cc: <stable@vger.kernel.org>
> >> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >> > > [ adapted to drain_allow instead of drained ]
> >> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> >> > > ---
> >> >
> >> > Does not apply as it conflicts with the other mm changes you sent right
> >> > before this one :(
> >>
> >> Thanks for grabbing all these, I'm sorry they are troublesome.
> >>
> >> Though I'm usually able to work out what to do from the FAILED mails,
> >> in this case I'd just be guessing without the full contexts.
> >> So I'll wait until I see what goes into the various branches of
> >> linux-stable-rc.git before checking and adjusting where necessary.
> >>
> >> (As usual, I'll tend towards minimal change, where Sasha tends
> >> towards maximal backporting of encroaching mods: we may disagree.)
> >>
> >> The main commits contributing to the pinning failures that Will Deacon
> >> reported were commits going into 5.18 and 6.11.  So although I stand
> >> by my Fixes tag, I'm likely to conclude that 5.15 and 5.10 and 5.4
> >> are better left stable without any of it.
> >
> >That suits me. 6.1, 6.6 and 6.12 are the main ones that I'm concerned
> >with from the Android side.
> 
> I'll hold off on backports then :)

Sure :)

I'm fading: let me explain and send what I have so far.

6.16.9-rc1 is fine, no further change needed from me, thanks.

6.12.49-rc1 is okay with what's in it already,
but needs the missing three patches on top, attached.

0001*patch and 0003*patch are actually just clean cherry-picks, I expect
the 0001*patch FAILED originally because of needing a Stable-dep, which
later did get into the rc1 tree.  If you prefer, feel free to ignore
my attached 0001*patch and 0003*patch (with my additional Signoffs),
cherry-pick for yourself, and just apply my 0002*patch between them.

6.6.108-rc1 (not yet posted, but there in linux-stable-rc.git):
sensibly does not yet contain any of the lrudrain series, I'm assembling
them, but just hit a snag - I've noticed that the 6.6-stable mm/gup.c
collect_longterm_unpinnable_pages(), which I'm patching, contains a mod
which was later reverted in Linus's tree, the revert was marked for stable
but I expect it ended up as FAILED, so I need to spend more time looking
into that (6.14 1aaf8c122918 reverted by 6.16 517f496e1e61): not tonight.

After I've settled 6.6, I'll move on to 6.1, but no further.

Hugh
---1463770367-1581705103-1758618713=:5004
Content-Type: text/x-patch; name=0001-mm-gup-local-lru_add_drain-to-avoid-lru_add_drain_al.patch
Content-Transfer-Encoding: BASE64
Content-ID: <a835e636-79db-c258-b18f-74e58c153f0c@google.com>
Content-Description: 
Content-Disposition: attachment; filename=0001-mm-gup-local-lru_add_drain-to-avoid-lru_add_drain_al.patch

RnJvbSA3YWZmYzYzMDM1OTYzOTE3ZTI1YTc5OGE4YzIyMDY1Y2QwNmRjZWZi
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSHVnaCBEaWNraW5z
IDxodWdoZEBnb29nbGUuY29tPg0KRGF0ZTogTW9uLCA4IFNlcCAyMDI1IDE1
OjE2OjUzIC0wNzAwDQpTdWJqZWN0OiBbUEFUQ0ggMS8zXSBtbS9ndXA6IGxv
Y2FsIGxydV9hZGRfZHJhaW4oKSB0byBhdm9pZA0KIGxydV9hZGRfZHJhaW5f
YWxsKCkNCg0KWyBVcHN0cmVhbSBjb21taXQgYTA5YThhMWZiYjM3NGUwMDUz
Yjk3MzA2ZGE5ZGJjMDViZDM4NDY4NSBdDQoNCkluIG1hbnkgY2FzZXMsIGlm
IGNvbGxlY3RfbG9uZ3Rlcm1fdW5waW5uYWJsZV9mb2xpb3MoKSBkb2VzIG5l
ZWQgdG8gZHJhaW4NCnRoZSBMUlUgY2FjaGUgdG8gcmVsZWFzZSBhIHJlZmVy
ZW5jZSwgdGhlIGNhY2hlIGluIHF1ZXN0aW9uIGlzIG9uIHRoaXMNCnNhbWUg
Q1BVLCBhbmQgbXVjaCBtb3JlIGVmZmljaWVudGx5IGRyYWluZWQgYnkgYSBw
cmVsaW1pbmFyeSBsb2NhbA0KbHJ1X2FkZF9kcmFpbigpLCB0aGFuIHRoZSBs
YXRlciBjcm9zcy1DUFUgbHJ1X2FkZF9kcmFpbl9hbGwoKS4NCg0KTWFya2Vk
IGZvciBzdGFibGUsIHRvIGNvdW50ZXIgdGhlIGluY3JlYXNlIGluIGxydV9h
ZGRfZHJhaW5fYWxsKClzIGZyb20NCiJtbS9ndXA6IGNoZWNrIHJlZl9jb3Vu
dCBpbnN0ZWFkIG9mIGxydSBiZWZvcmUgbWlncmF0aW9uIi4gIE5vdGUgZm9y
IGNsZWFuDQpiYWNrcG9ydHM6IGNhbiB0YWtlIDYuMTYgY29tbWl0IGEwM2Ri
MjM2YWViZiAoImd1cDogb3B0aW1pemUgbG9uZ3Rlcm0NCnBpbl91c2VyX3Bh
Z2VzKCkgZm9yIGxhcmdlIGZvbGlvIikgZmlyc3QuDQoNCkxpbms6IGh0dHBz
Oi8vbGttbC5rZXJuZWwub3JnL3IvNjZmMjc1MWYtMjgzZS04MTZkLTk1MzAt
NzY1ZGI3ZWRjNDY1QGdvb2dsZS5jb20NClNpZ25lZC1vZmYtYnk6IEh1Z2gg
RGlja2lucyA8aHVnaGRAZ29vZ2xlLmNvbT4NCkFja2VkLWJ5OiBEYXZpZCBI
aWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCkNjOiAiQW5lZXNoIEt1
bWFyIEsuViIgPGFuZWVzaC5rdW1hckBrZXJuZWwub3JnPg0KQ2M6IEF4ZWwg
UmFzbXVzc2VuIDxheGVscmFzbXVzc2VuQGdvb2dsZS5jb20+DQpDYzogQ2hy
aXMgTGkgPGNocmlzbEBrZXJuZWwub3JnPg0KQ2M6IENocmlzdG9waCBIZWxs
d2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4NCkNjOiBKYXNvbiBHdW50aG9ycGUg
PGpnZ0B6aWVwZS5jYT4NCkNjOiBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0Bj
bXB4Y2hnLm9yZz4NCkNjOiBKb2huIEh1YmJhcmQgPGpodWJiYXJkQG52aWRp
YS5jb20+DQpDYzogS2VpciBGcmFzZXIgPGtlaXJmQGdvb2dsZS5jb20+DQpD
YzogS29uc3RhbnRpbiBLaGxlYm5pa292IDxrb2N0OWlAZ21haWwuY29tPg0K
Q2M6IExpIFpoZSA8bGl6aGUuNjdAYnl0ZWRhbmNlLmNvbT4NCkNjOiBNYXR0
aGV3IFdpbGNveCAoT3JhY2xlKSA8d2lsbHlAaW5mcmFkZWFkLm9yZz4NCkNj
OiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQpDYzogUmlrIHZhbiBS
aWVsIDxyaWVsQHN1cnJpZWwuY29tPg0KQ2M6IFNoaXZhbmsgR2FyZyA8c2hp
dmFua2dAYW1kLmNvbT4NCkNjOiBWbGFzdGltaWwgQmFia2EgPHZiYWJrYUBz
dXNlLmN6Pg0KQ2M6IFdlaSBYdSA8d2VpeHVnY0Bnb29nbGUuY29tPg0KQ2M6
IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+DQpDYzogeWFuZ2dlIDx5
YW5nZ2UxMTE2QDEyNi5jb20+DQpDYzogWXVhbmNodSBYaWUgPHl1YW5jaHVA
Z29vZ2xlLmNvbT4NCkNjOiBZdSBaaGFvIDx5dXpoYW9AZ29vZ2xlLmNvbT4N
CkNjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6
IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQpb
IENsZWFuIGNoZXJyeS1waWNrIG5vdyBpbnRvIHRoaXMgdHJlZSBdDQpTaWdu
ZWQtb2ZmLWJ5OiBIdWdoIERpY2tpbnMgPGh1Z2hkQGdvb2dsZS5jb20+DQot
LS0NCiBtbS9ndXAuYyB8IDE1ICsrKysrKysrKysrLS0tLQ0KIDEgZmlsZSBj
aGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvbW0vZ3VwLmMgYi9tbS9ndXAuYw0KaW5kZXggZTliZTdj
NDk1NDJhLi40ZGQwZWI3MDk4OGIgMTAwNjQ0DQotLS0gYS9tbS9ndXAuYw0K
KysrIGIvbW0vZ3VwLmMNCkBAIC0yMzU2LDggKzIzNTYsOCBAQCBzdGF0aWMg
dW5zaWduZWQgbG9uZyBjb2xsZWN0X2xvbmd0ZXJtX3VucGlubmFibGVfZm9s
aW9zKA0KIAkJc3RydWN0IHBhZ2VzX29yX2ZvbGlvcyAqcG9mcykNCiB7DQog
CXVuc2lnbmVkIGxvbmcgY29sbGVjdGVkID0gMDsNCi0JYm9vbCBkcmFpbl9h
bGxvdyA9IHRydWU7DQogCXN0cnVjdCBmb2xpbyAqZm9saW87DQorCWludCBk
cmFpbmVkID0gMDsNCiAJbG9uZyBpID0gMDsNCiANCiAJZm9yIChmb2xpbyA9
IHBvZnNfZ2V0X2ZvbGlvKHBvZnMsIGkpOyBmb2xpbzsNCkBAIC0yMzc2LDEw
ICsyMzc2LDE3IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIGNvbGxlY3RfbG9u
Z3Rlcm1fdW5waW5uYWJsZV9mb2xpb3MoDQogCQkJY29udGludWU7DQogCQl9
DQogDQotCQlpZiAoZHJhaW5fYWxsb3cgJiYgZm9saW9fcmVmX2NvdW50KGZv
bGlvKSAhPQ0KLQkJCQkgICBmb2xpb19leHBlY3RlZF9yZWZfY291bnQoZm9s
aW8pICsgMSkgew0KKwkJaWYgKGRyYWluZWQgPT0gMCAmJg0KKwkJCQlmb2xp
b19yZWZfY291bnQoZm9saW8pICE9DQorCQkJCWZvbGlvX2V4cGVjdGVkX3Jl
Zl9jb3VudChmb2xpbykgKyAxKSB7DQorCQkJbHJ1X2FkZF9kcmFpbigpOw0K
KwkJCWRyYWluZWQgPSAxOw0KKwkJfQ0KKwkJaWYgKGRyYWluZWQgPT0gMSAm
Jg0KKwkJCQlmb2xpb19yZWZfY291bnQoZm9saW8pICE9DQorCQkJCWZvbGlv
X2V4cGVjdGVkX3JlZl9jb3VudChmb2xpbykgKyAxKSB7DQogCQkJbHJ1X2Fk
ZF9kcmFpbl9hbGwoKTsNCi0JCQlkcmFpbl9hbGxvdyA9IGZhbHNlOw0KKwkJ
CWRyYWluZWQgPSAyOw0KIAkJfQ0KIA0KIAkJaWYgKCFmb2xpb19pc29sYXRl
X2xydShmb2xpbykpDQotLSANCjIuNTEuMC41MzQuZ2M3OTA5NWMwY2EtZ29v
Zw0KDQo=

---1463770367-1581705103-1758618713=:5004
Content-Type: text/x-patch; name=0002-mm-revert-mm-gup-clear-the-LRU-flag-of-a-page-before.patch
Content-Transfer-Encoding: BASE64
Content-ID: <96e8754e-ba98-0060-18b7-01c79d0ee945@google.com>
Content-Description: 
Content-Disposition: attachment; filename=0002-mm-revert-mm-gup-clear-the-LRU-flag-of-a-page-before.patch

RnJvbSAzOTUzMWM3ZWYzN2Q5Mjc5ZGEyY2JkYzZiOWQ3YmE3MzgyNGE4ZTZi
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSHVnaCBEaWNraW5z
IDxodWdoZEBnb29nbGUuY29tPg0KRGF0ZTogTW9uLCA4IFNlcCAyMDI1IDE1
OjE5OjE3IC0wNzAwDQpTdWJqZWN0OiBbUEFUQ0ggMi8zXSBtbTogcmV2ZXJ0
ICJtbS9ndXA6IGNsZWFyIHRoZSBMUlUgZmxhZyBvZiBhIHBhZ2UgYmVmb3Jl
DQogYWRkaW5nIHRvIExSVSBiYXRjaCINCg0KWyBVcHN0cmVhbSBjb21taXQg
YWZiOTllOWY1MDA0ODUxNjBmMzRiOGNhZDZkMzc2M2FkYTNlODBlOCBdDQoN
ClRoaXMgcmV2ZXJ0cyBjb21taXQgMzNkZmU5MjA0ZjI5OiBub3cgdGhhdA0K
Y29sbGVjdF9sb25ndGVybV91bnBpbm5hYmxlX2ZvbGlvcygpIGlzIGNoZWNr
aW5nIHJlZl9jb3VudCBpbnN0ZWFkIG9mIGxydSwNCmFuZCBtbG9jay9tdW5s
b2NrIGRvIG5vdCBwYXJ0aWNpcGF0ZSBpbiB0aGUgcmV2aXNlZCBMUlUgZmxh
ZyBjbGVhcmluZywNCnRob3NlIGNoYW5nZXMgYXJlIG1pc2xlYWRpbmcsIGFu
ZCBlbmxhcmdlIHRoZSB3aW5kb3cgZHVyaW5nIHdoaWNoDQptbG9jay9tdW5s
b2NrIG1heSBtaXNzIGFuIG1sb2NrX2NvdW50IHVwZGF0ZS4NCg0KSXQgaXMg
cG9zc2libGUgKEknZCBoZXNpdGF0ZSB0byBjbGFpbSBwcm9iYWJsZSkgdGhh
dCB0aGUgZ3JlYXRlcg0KbGlrZWxpaG9vZCBvZiBtaXNzZWQgbWxvY2tfY291
bnQgdXBkYXRlcyB3b3VsZCBleHBsYWluIHRoZSAiUmVhbHRpbWUNCnRocmVh
ZHMgZGVsYXllZCBkdWUgdG8ga2NvbXBhY3RkMCIgb2JzZXJ2ZWQgb24gNi4x
MiBpbiB0aGUgTGluayBiZWxvdy4gIElmDQp0aGF0IGlzIHRoZSBjYXNlLCB0
aGlzIHJldmVyc2lvbiB3aWxsIGhlbHA7IGJ1dCBhIGNvbXBsZXRlIHNvbHV0
aW9uIG5lZWRzDQphbHNvIGEgZnVydGhlciBwYXRjaCwgYmV5b25kIHRoZSBz
Y29wZSBvZiB0aGlzIHNlcmllcy4NCg0KSW5jbHVkZWQgc29tZSA4MC1jb2x1
bW4gY2xlYW51cCBhcm91bmQgZm9saW9fYmF0Y2hfYWRkX2FuZF9tb3ZlKCku
DQoNClRoZSByb2xlIG9mIGZvbGlvX3Rlc3RfY2xlYXJfbHJ1KCkgKGJlZm9y
ZSB0YWtpbmcgcGVyLW1lbWNnIGxydV9sb2NrKSBpcw0KcXVlc3Rpb25hYmxl
IHNpbmNlIDYuMTMgcmVtb3ZlZCBtZW1fY2dyb3VwX21vdmVfYWNjb3VudCgp
IGV0YzsgYnV0IHBlcmhhcHMNCnRoZXJlIGFyZSBzdGlsbCBzb21lIHJhY2Vz
IHdoaWNoIG5lZWQgaXQgLSBub3QgZXhhbWluZWQgaGVyZS4NCg0KTGluazog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW0vRFUwUFIwMU1CMTAz
ODUzNDVGNzE1M0YzMzQxMDA5ODE4ODgyNTlBQERVMFBSMDFNQjEwMzg1LmV1
cnByZDAxLnByb2QuZXhjaGFuZ2VsYWJzLmNvbS8NCkxpbms6IGh0dHBzOi8v
bGttbC5rZXJuZWwub3JnL3IvMDU5MDVkN2ItZWQxNC02OGIxLTc5ZDgtYmRl
YzMwMzY3ZWJhQGdvb2dsZS5jb20NClNpZ25lZC1vZmYtYnk6IEh1Z2ggRGlj
a2lucyA8aHVnaGRAZ29vZ2xlLmNvbT4NCkFja2VkLWJ5OiBEYXZpZCBIaWxk
ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCkNjOiAiQW5lZXNoIEt1bWFy
IEsuViIgPGFuZWVzaC5rdW1hckBrZXJuZWwub3JnPg0KQ2M6IEF4ZWwgUmFz
bXVzc2VuIDxheGVscmFzbXVzc2VuQGdvb2dsZS5jb20+DQpDYzogQ2hyaXMg
TGkgPGNocmlzbEBrZXJuZWwub3JnPg0KQ2M6IENocmlzdG9waCBIZWxsd2ln
IDxoY2hAaW5mcmFkZWFkLm9yZz4NCkNjOiBKYXNvbiBHdW50aG9ycGUgPGpn
Z0B6aWVwZS5jYT4NCkNjOiBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0BjbXB4
Y2hnLm9yZz4NCkNjOiBKb2huIEh1YmJhcmQgPGpodWJiYXJkQG52aWRpYS5j
b20+DQpDYzogS2VpciBGcmFzZXIgPGtlaXJmQGdvb2dsZS5jb20+DQpDYzog
S29uc3RhbnRpbiBLaGxlYm5pa292IDxrb2N0OWlAZ21haWwuY29tPg0KQ2M6
IExpIFpoZSA8bGl6aGUuNjdAYnl0ZWRhbmNlLmNvbT4NCkNjOiBNYXR0aGV3
IFdpbGNveCAoT3JhY2xlKSA8d2lsbHlAaW5mcmFkZWFkLm9yZz4NCkNjOiBQ
ZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQpDYzogUmlrIHZhbiBSaWVs
IDxyaWVsQHN1cnJpZWwuY29tPg0KQ2M6IFNoaXZhbmsgR2FyZyA8c2hpdmFu
a2dAYW1kLmNvbT4NCkNjOiBWbGFzdGltaWwgQmFia2EgPHZiYWJrYUBzdXNl
LmN6Pg0KQ2M6IFdlaSBYdSA8d2VpeHVnY0Bnb29nbGUuY29tPg0KQ2M6IFdp
bGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+DQpDYzogeWFuZ2dlIDx5YW5n
Z2UxMTE2QDEyNi5jb20+DQpDYzogWXVhbmNodSBYaWUgPHl1YW5jaHVAZ29v
Z2xlLmNvbT4NCkNjOiBZdSBaaGFvIDx5dXpoYW9AZ29vZ2xlLmNvbT4NCkNj
OiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6IEFu
ZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQpbIFJl
c29sdmVkIGNvbmZsaWN0cyBpbiBhcHBseWluZyB0aGUgcmV2ZXJ0IHRvIHRo
aXMgdHJlZSBdDQpTaWduZWQtb2ZmLWJ5OiBIdWdoIERpY2tpbnMgPGh1Z2hk
QGdvb2dsZS5jb20+DQotLS0NCiBtbS9zd2FwLmMgfCA1MSArKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAx
IGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9tbS9zd2FwLmMgYi9tbS9zd2FwLmMNCmlu
ZGV4IDU5ZjMwYTk4MWM2Zi4uZDRjYjQ4OThmNTczIDEwMDY0NA0KLS0tIGEv
bW0vc3dhcC5jDQorKysgYi9tbS9zd2FwLmMNCkBAIC0xOTUsNiArMTk1LDEw
IEBAIHN0YXRpYyB2b2lkIGZvbGlvX2JhdGNoX21vdmVfbHJ1KHN0cnVjdCBm
b2xpb19iYXRjaCAqZmJhdGNoLCBtb3ZlX2ZuX3QgbW92ZV9mbikNCiAJZm9y
IChpID0gMDsgaSA8IGZvbGlvX2JhdGNoX2NvdW50KGZiYXRjaCk7IGkrKykg
ew0KIAkJc3RydWN0IGZvbGlvICpmb2xpbyA9IGZiYXRjaC0+Zm9saW9zW2ld
Ow0KIA0KKwkJLyogYmxvY2sgbWVtY2cgbWlncmF0aW9uIHdoaWxlIHRoZSBm
b2xpbyBtb3ZlcyBiZXR3ZWVuIGxydSAqLw0KKwkJaWYgKG1vdmVfZm4gIT0g
bHJ1X2FkZCAmJiAhZm9saW9fdGVzdF9jbGVhcl9scnUoZm9saW8pKQ0KKwkJ
CWNvbnRpbnVlOw0KKw0KIAkJZm9saW9fbHJ1dmVjX3JlbG9ja19pcnFzYXZl
KGZvbGlvLCAmbHJ1dmVjLCAmZmxhZ3MpOw0KIAkJbW92ZV9mbihscnV2ZWMs
IGZvbGlvKTsNCiANCkBAIC0yMDcsMTQgKzIxMSwxMCBAQCBzdGF0aWMgdm9p
ZCBmb2xpb19iYXRjaF9tb3ZlX2xydShzdHJ1Y3QgZm9saW9fYmF0Y2ggKmZi
YXRjaCwgbW92ZV9mbl90IG1vdmVfZm4pDQogfQ0KIA0KIHN0YXRpYyB2b2lk
IF9fZm9saW9fYmF0Y2hfYWRkX2FuZF9tb3ZlKHN0cnVjdCBmb2xpb19iYXRj
aCBfX3BlcmNwdSAqZmJhdGNoLA0KLQkJc3RydWN0IGZvbGlvICpmb2xpbywg
bW92ZV9mbl90IG1vdmVfZm4sDQotCQlib29sIG9uX2xydSwgYm9vbCBkaXNh
YmxlX2lycSkNCisJCXN0cnVjdCBmb2xpbyAqZm9saW8sIG1vdmVfZm5fdCBt
b3ZlX2ZuLCBib29sIGRpc2FibGVfaXJxKQ0KIHsNCiAJdW5zaWduZWQgbG9u
ZyBmbGFnczsNCiANCi0JaWYgKG9uX2xydSAmJiAhZm9saW9fdGVzdF9jbGVh
cl9scnUoZm9saW8pKQ0KLQkJcmV0dXJuOw0KLQ0KIAlmb2xpb19nZXQoZm9s
aW8pOw0KIA0KIAlpZiAoZGlzYWJsZV9pcnEpDQpAQCAtMjIyLDggKzIyMiw4
IEBAIHN0YXRpYyB2b2lkIF9fZm9saW9fYmF0Y2hfYWRkX2FuZF9tb3ZlKHN0
cnVjdCBmb2xpb19iYXRjaCBfX3BlcmNwdSAqZmJhdGNoLA0KIAllbHNlDQog
CQlsb2NhbF9sb2NrKCZjcHVfZmJhdGNoZXMubG9jayk7DQogDQotCWlmICgh
Zm9saW9fYmF0Y2hfYWRkKHRoaXNfY3B1X3B0cihmYmF0Y2gpLCBmb2xpbykg
fHwgZm9saW9fdGVzdF9sYXJnZShmb2xpbykgfHwNCi0JICAgIGxydV9jYWNo
ZV9kaXNhYmxlZCgpKQ0KKwlpZiAoIWZvbGlvX2JhdGNoX2FkZCh0aGlzX2Nw
dV9wdHIoZmJhdGNoKSwgZm9saW8pIHx8DQorCQkJZm9saW9fdGVzdF9sYXJn
ZShmb2xpbykgfHwgbHJ1X2NhY2hlX2Rpc2FibGVkKCkpDQogCQlmb2xpb19i
YXRjaF9tb3ZlX2xydSh0aGlzX2NwdV9wdHIoZmJhdGNoKSwgbW92ZV9mbik7
DQogDQogCWlmIChkaXNhYmxlX2lycSkNCkBAIC0yMzIsMTMgKzIzMiwxMyBA
QCBzdGF0aWMgdm9pZCBfX2ZvbGlvX2JhdGNoX2FkZF9hbmRfbW92ZShzdHJ1
Y3QgZm9saW9fYmF0Y2ggX19wZXJjcHUgKmZiYXRjaCwNCiAJCWxvY2FsX3Vu
bG9jaygmY3B1X2ZiYXRjaGVzLmxvY2spOw0KIH0NCiANCi0jZGVmaW5lIGZv
bGlvX2JhdGNoX2FkZF9hbmRfbW92ZShmb2xpbywgb3AsIG9uX2xydSkJCQkJ
CQlcDQotCV9fZm9saW9fYmF0Y2hfYWRkX2FuZF9tb3ZlKAkJCQkJCQkJXA0K
LQkJJmNwdV9mYmF0Y2hlcy5vcCwJCQkJCQkJCVwNCi0JCWZvbGlvLAkJCQkJ
CQkJCQlcDQotCQlvcCwJCQkJCQkJCQkJXA0KLQkJb25fbHJ1LAkJCQkJCQkJ
CQlcDQotCQlvZmZzZXRvZihzdHJ1Y3QgY3B1X2ZiYXRjaGVzLCBvcCkgPj0g
b2Zmc2V0b2Yoc3RydWN0IGNwdV9mYmF0Y2hlcywgbG9ja19pcnEpCVwNCisj
ZGVmaW5lIGZvbGlvX2JhdGNoX2FkZF9hbmRfbW92ZShmb2xpbywgb3ApCQlc
DQorCV9fZm9saW9fYmF0Y2hfYWRkX2FuZF9tb3ZlKAkJCVwNCisJCSZjcHVf
ZmJhdGNoZXMub3AsCQkJXA0KKwkJZm9saW8sCQkJCQlcDQorCQlvcCwJCQkJ
CVwNCisJCW9mZnNldG9mKHN0cnVjdCBjcHVfZmJhdGNoZXMsIG9wKSA+PQlc
DQorCQlvZmZzZXRvZihzdHJ1Y3QgY3B1X2ZiYXRjaGVzLCBsb2NrX2lycSkJ
XA0KIAkpDQogDQogc3RhdGljIHZvaWQgbHJ1X21vdmVfdGFpbChzdHJ1Y3Qg
bHJ1dmVjICpscnV2ZWMsIHN0cnVjdCBmb2xpbyAqZm9saW8pDQpAQCAtMjYy
LDEwICsyNjIsMTAgQEAgc3RhdGljIHZvaWQgbHJ1X21vdmVfdGFpbChzdHJ1
Y3QgbHJ1dmVjICpscnV2ZWMsIHN0cnVjdCBmb2xpbyAqZm9saW8pDQogdm9p
ZCBmb2xpb19yb3RhdGVfcmVjbGFpbWFibGUoc3RydWN0IGZvbGlvICpmb2xp
bykNCiB7DQogCWlmIChmb2xpb190ZXN0X2xvY2tlZChmb2xpbykgfHwgZm9s
aW9fdGVzdF9kaXJ0eShmb2xpbykgfHwNCi0JICAgIGZvbGlvX3Rlc3RfdW5l
dmljdGFibGUoZm9saW8pKQ0KKwkgICAgZm9saW9fdGVzdF91bmV2aWN0YWJs
ZShmb2xpbykgfHwgIWZvbGlvX3Rlc3RfbHJ1KGZvbGlvKSkNCiAJCXJldHVy
bjsNCiANCi0JZm9saW9fYmF0Y2hfYWRkX2FuZF9tb3ZlKGZvbGlvLCBscnVf
bW92ZV90YWlsLCB0cnVlKTsNCisJZm9saW9fYmF0Y2hfYWRkX2FuZF9tb3Zl
KGZvbGlvLCBscnVfbW92ZV90YWlsKTsNCiB9DQogDQogdm9pZCBscnVfbm90
ZV9jb3N0KHN0cnVjdCBscnV2ZWMgKmxydXZlYywgYm9vbCBmaWxlLA0KQEAg
LTM1NCwxMCArMzU0LDExIEBAIHN0YXRpYyB2b2lkIGZvbGlvX2FjdGl2YXRl
X2RyYWluKGludCBjcHUpDQogDQogdm9pZCBmb2xpb19hY3RpdmF0ZShzdHJ1
Y3QgZm9saW8gKmZvbGlvKQ0KIHsNCi0JaWYgKGZvbGlvX3Rlc3RfYWN0aXZl
KGZvbGlvKSB8fCBmb2xpb190ZXN0X3VuZXZpY3RhYmxlKGZvbGlvKSkNCisJ
aWYgKGZvbGlvX3Rlc3RfYWN0aXZlKGZvbGlvKSB8fCBmb2xpb190ZXN0X3Vu
ZXZpY3RhYmxlKGZvbGlvKSB8fA0KKwkgICAgIWZvbGlvX3Rlc3RfbHJ1KGZv
bGlvKSkNCiAJCXJldHVybjsNCiANCi0JZm9saW9fYmF0Y2hfYWRkX2FuZF9t
b3ZlKGZvbGlvLCBscnVfYWN0aXZhdGUsIHRydWUpOw0KKwlmb2xpb19iYXRj
aF9hZGRfYW5kX21vdmUoZm9saW8sIGxydV9hY3RpdmF0ZSk7DQogfQ0KIA0K
ICNlbHNlDQpAQCAtNTEwLDcgKzUxMSw3IEBAIHZvaWQgZm9saW9fYWRkX2xy
dShzdHJ1Y3QgZm9saW8gKmZvbGlvKQ0KIAkgICAgbHJ1X2dlbl9pbl9mYXVs
dCgpICYmICEoY3VycmVudC0+ZmxhZ3MgJiBQRl9NRU1BTExPQykpDQogCQlm
b2xpb19zZXRfYWN0aXZlKGZvbGlvKTsNCiANCi0JZm9saW9fYmF0Y2hfYWRk
X2FuZF9tb3ZlKGZvbGlvLCBscnVfYWRkLCBmYWxzZSk7DQorCWZvbGlvX2Jh
dGNoX2FkZF9hbmRfbW92ZShmb2xpbywgbHJ1X2FkZCk7DQogfQ0KIEVYUE9S
VF9TWU1CT0woZm9saW9fYWRkX2xydSk7DQogDQpAQCAtNjg1LDEwICs2ODYs
MTAgQEAgdm9pZCBscnVfYWRkX2RyYWluX2NwdShpbnQgY3B1KQ0KIHZvaWQg
ZGVhY3RpdmF0ZV9maWxlX2ZvbGlvKHN0cnVjdCBmb2xpbyAqZm9saW8pDQog
ew0KIAkvKiBEZWFjdGl2YXRpbmcgYW4gdW5ldmljdGFibGUgZm9saW8gd2ls
bCBub3QgYWNjZWxlcmF0ZSByZWNsYWltICovDQotCWlmIChmb2xpb190ZXN0
X3VuZXZpY3RhYmxlKGZvbGlvKSkNCisJaWYgKGZvbGlvX3Rlc3RfdW5ldmlj
dGFibGUoZm9saW8pIHx8ICFmb2xpb190ZXN0X2xydShmb2xpbykpDQogCQly
ZXR1cm47DQogDQotCWZvbGlvX2JhdGNoX2FkZF9hbmRfbW92ZShmb2xpbywg
bHJ1X2RlYWN0aXZhdGVfZmlsZSwgdHJ1ZSk7DQorCWZvbGlvX2JhdGNoX2Fk
ZF9hbmRfbW92ZShmb2xpbywgbHJ1X2RlYWN0aXZhdGVfZmlsZSk7DQogfQ0K
IA0KIC8qDQpAQCAtNzAxLDEwICs3MDIsMTEgQEAgdm9pZCBkZWFjdGl2YXRl
X2ZpbGVfZm9saW8oc3RydWN0IGZvbGlvICpmb2xpbykNCiAgKi8NCiB2b2lk
IGZvbGlvX2RlYWN0aXZhdGUoc3RydWN0IGZvbGlvICpmb2xpbykNCiB7DQot
CWlmIChmb2xpb190ZXN0X3VuZXZpY3RhYmxlKGZvbGlvKSB8fCAhKGZvbGlv
X3Rlc3RfYWN0aXZlKGZvbGlvKSB8fCBscnVfZ2VuX2VuYWJsZWQoKSkpDQor
CWlmIChmb2xpb190ZXN0X3VuZXZpY3RhYmxlKGZvbGlvKSB8fCAhZm9saW9f
dGVzdF9scnUoZm9saW8pIHx8DQorCSAgICAhKGZvbGlvX3Rlc3RfYWN0aXZl
KGZvbGlvKSB8fCBscnVfZ2VuX2VuYWJsZWQoKSkpDQogCQlyZXR1cm47DQog
DQotCWZvbGlvX2JhdGNoX2FkZF9hbmRfbW92ZShmb2xpbywgbHJ1X2RlYWN0
aXZhdGUsIHRydWUpOw0KKwlmb2xpb19iYXRjaF9hZGRfYW5kX21vdmUoZm9s
aW8sIGxydV9kZWFjdGl2YXRlKTsNCiB9DQogDQogLyoqDQpAQCAtNzE3LDEw
ICs3MTksMTEgQEAgdm9pZCBmb2xpb19kZWFjdGl2YXRlKHN0cnVjdCBmb2xp
byAqZm9saW8pDQogdm9pZCBmb2xpb19tYXJrX2xhenlmcmVlKHN0cnVjdCBm
b2xpbyAqZm9saW8pDQogew0KIAlpZiAoIWZvbGlvX3Rlc3RfYW5vbihmb2xp
bykgfHwgIWZvbGlvX3Rlc3Rfc3dhcGJhY2tlZChmb2xpbykgfHwNCisJICAg
ICFmb2xpb190ZXN0X2xydShmb2xpbykgfHwNCiAJICAgIGZvbGlvX3Rlc3Rf
c3dhcGNhY2hlKGZvbGlvKSB8fCBmb2xpb190ZXN0X3VuZXZpY3RhYmxlKGZv
bGlvKSkNCiAJCXJldHVybjsNCiANCi0JZm9saW9fYmF0Y2hfYWRkX2FuZF9t
b3ZlKGZvbGlvLCBscnVfbGF6eWZyZWUsIHRydWUpOw0KKwlmb2xpb19iYXRj
aF9hZGRfYW5kX21vdmUoZm9saW8sIGxydV9sYXp5ZnJlZSk7DQogfQ0KIA0K
IHZvaWQgbHJ1X2FkZF9kcmFpbih2b2lkKQ0KLS0gDQoyLjUxLjAuNTM0Lmdj
NzkwOTVjMGNhLWdvb2cNCg0K

---1463770367-1581705103-1758618713=:5004
Content-Type: text/x-patch; name=0003-mm-folio_may_be_lru_cached-unless-folio_test_large.patch
Content-Transfer-Encoding: BASE64
Content-ID: <43cf7cbc-aa3e-155b-cd89-40599e7f6534@google.com>
Content-Description: 
Content-Disposition: attachment; filename=0003-mm-folio_may_be_lru_cached-unless-folio_test_large.patch

RnJvbSA3NDUwNTQ0YmM4MjBiMGM4ODRhMTBlMjM0OGI4NTE0MTY2ZGFiNWNi
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSHVnaCBEaWNraW5z
IDxodWdoZEBnb29nbGUuY29tPg0KRGF0ZTogTW9uLCA4IFNlcCAyMDI1IDE1
OjIzOjE1IC0wNzAwDQpTdWJqZWN0OiBbUEFUQ0ggMy8zXSBtbTogZm9saW9f
bWF5X2JlX2xydV9jYWNoZWQoKSB1bmxlc3MgZm9saW9fdGVzdF9sYXJnZSgp
DQoNClsgVXBzdHJlYW0gY29tbWl0IDJkYTZkZTMwZTYwZGQ5YmIxNDYwMGVm
ZjFjYzk5ZGYyZmEyZGRhZTMgXQ0KDQptbS9zd2FwLmMgYW5kIG1tL21sb2Nr
LmMgYWdyZWUgdG8gZHJhaW4gYW55IHBlci1DUFUgYmF0Y2ggYXMgc29vbiBh
cyBhDQpsYXJnZSBmb2xpbyBpcyBhZGRlZDogc28gY29sbGVjdF9sb25ndGVy
bV91bnBpbm5hYmxlX2ZvbGlvcygpIGp1c3Qgd2FzdGVzDQplZmZvcnQgd2hl
biBjYWxsaW5nIGxydV9hZGRfZHJhaW5bX2FsbF0oKSBvbiBhIGxhcmdlIGZv
bGlvLg0KDQpCdXQgYWx0aG91Z2ggdGhlcmUgaXMgZ29vZCByZWFzb24gbm90
IHRvIGJhdGNoIHVwIFBNRC1zaXplZCBmb2xpb3MsIHdlDQptaWdodCB3ZWxs
IGJlbmVmaXQgZnJvbSBiYXRjaGluZyBhIHNtYWxsIG51bWJlciBvZiBsb3ct
b3JkZXIgbVRIUHMgKHRob3VnaA0KdW5jbGVhciBob3cgdGhhdCAic21hbGwg
bnVtYmVyIiBsaW1pdGF0aW9uIHdpbGwgYmUgaW1wbGVtZW50ZWQpLg0KDQpT
byBhc2sgaWYgZm9saW9fbWF5X2JlX2xydV9jYWNoZWQoKSByYXRoZXIgdGhh
biAhZm9saW9fdGVzdF9sYXJnZSgpLCB0bw0KaW5zdWxhdGUgdGhvc2UgcGFy
dGljdWxhciBjaGVja3MgZnJvbSBmdXR1cmUgY2hhbmdlLiAgTmFtZSBwcmVm
ZXJyZWQgdG8NCiJmb2xpb19pc19iYXRjaGFibGUiIGJlY2F1c2UgbGFyZ2Ug
Zm9saW9zIGNhbiB3ZWxsIGJlIHB1dCBvbiBhIGJhdGNoOiBpdCdzDQpqdXN0
IHRoZSBwZXItQ1BVIExSVSBjYWNoZXMsIGRyYWluZWQgbXVjaCBsYXRlciwg
d2hpY2ggbmVlZCBjYXJlLg0KDQpNYXJrZWQgZm9yIHN0YWJsZSwgdG8gY291
bnRlciB0aGUgaW5jcmVhc2UgaW4gbHJ1X2FkZF9kcmFpbl9hbGwoKXMgZnJv
bQ0KIm1tL2d1cDogY2hlY2sgcmVmX2NvdW50IGluc3RlYWQgb2YgbHJ1IGJl
Zm9yZSBtaWdyYXRpb24iLg0KDQpMaW5rOiBodHRwczovL2xrbWwua2VybmVs
Lm9yZy9yLzU3ZDJlYWY4LTM2MDctZjMxOC1lMGM1LWJlMDJkY2U2MWFkMEBn
b29nbGUuY29tDQpGaXhlczogOWE0ZTlmM2IyZDczICgibW06IHVwZGF0ZSBn
ZXRfdXNlcl9wYWdlc19sb25ndGVybSB0byBtaWdyYXRlIHBhZ2VzIGFsbG9j
YXRlZCBmcm9tIENNQSByZWdpb24iKQ0KU2lnbmVkLW9mZi1ieTogSHVnaCBE
aWNraW5zIDxodWdoZEBnb29nbGUuY29tPg0KU3VnZ2VzdGVkLWJ5OiBEYXZp
ZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCkFja2VkLWJ5OiBE
YXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCkNjOiAiQW5l
ZXNoIEt1bWFyIEsuViIgPGFuZWVzaC5rdW1hckBrZXJuZWwub3JnPg0KQ2M6
IEF4ZWwgUmFzbXVzc2VuIDxheGVscmFzbXVzc2VuQGdvb2dsZS5jb20+DQpD
YzogQ2hyaXMgTGkgPGNocmlzbEBrZXJuZWwub3JnPg0KQ2M6IENocmlzdG9w
aCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4NCkNjOiBKYXNvbiBHdW50
aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCkNjOiBKb2hhbm5lcyBXZWluZXIgPGhh
bm5lc0BjbXB4Y2hnLm9yZz4NCkNjOiBKb2huIEh1YmJhcmQgPGpodWJiYXJk
QG52aWRpYS5jb20+DQpDYzogS2VpciBGcmFzZXIgPGtlaXJmQGdvb2dsZS5j
b20+DQpDYzogS29uc3RhbnRpbiBLaGxlYm5pa292IDxrb2N0OWlAZ21haWwu
Y29tPg0KQ2M6IExpIFpoZSA8bGl6aGUuNjdAYnl0ZWRhbmNlLmNvbT4NCkNj
OiBNYXR0aGV3IFdpbGNveCAoT3JhY2xlKSA8d2lsbHlAaW5mcmFkZWFkLm9y
Zz4NCkNjOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQpDYzogUmlr
IHZhbiBSaWVsIDxyaWVsQHN1cnJpZWwuY29tPg0KQ2M6IFNoaXZhbmsgR2Fy
ZyA8c2hpdmFua2dAYW1kLmNvbT4NCkNjOiBWbGFzdGltaWwgQmFia2EgPHZi
YWJrYUBzdXNlLmN6Pg0KQ2M6IFdlaSBYdSA8d2VpeHVnY0Bnb29nbGUuY29t
Pg0KQ2M6IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+DQpDYzogeWFu
Z2dlIDx5YW5nZ2UxMTE2QDEyNi5jb20+DQpDYzogWXVhbmNodSBYaWUgPHl1
YW5jaHVAZ29vZ2xlLmNvbT4NCkNjOiBZdSBaaGFvIDx5dXpoYW9AZ29vZ2xl
LmNvbT4NCkNjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NClNpZ25lZC1v
ZmYtYnk6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5v
cmc+DQpbIENsZWFuIGNoZXJyeS1waWNrIG5vdyBpbnRvIHRoaXMgdHJlZSBd
DQpTaWduZWQtb2ZmLWJ5OiBIdWdoIERpY2tpbnMgPGh1Z2hkQGdvb2dsZS5j
b20+DQotLS0NCiBpbmNsdWRlL2xpbnV4L3N3YXAuaCB8IDEwICsrKysrKysr
KysNCiBtbS9ndXAuYyAgICAgICAgICAgICB8ICA0ICsrLS0NCiBtbS9tbG9j
ay5jICAgICAgICAgICB8ICA2ICsrKy0tLQ0KIG1tL3N3YXAuYyAgICAgICAg
ICAgIHwgIDIgKy0NCiA0IGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L3N3YXAuaCBiL2luY2x1ZGUvbGludXgvc3dhcC5oDQppbmRleCBmM2Uw
YWMyMGMyZTguLjYzZjg1YjNmZWUyMyAxMDA2NDQNCi0tLSBhL2luY2x1ZGUv
bGludXgvc3dhcC5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3N3YXAuaA0KQEAg
LTM4Miw2ICszODIsMTYgQEAgdm9pZCBmb2xpb19hZGRfbHJ1X3ZtYShzdHJ1
Y3QgZm9saW8gKiwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICopOw0KIHZvaWQg
bWFya19wYWdlX2FjY2Vzc2VkKHN0cnVjdCBwYWdlICopOw0KIHZvaWQgZm9s
aW9fbWFya19hY2Nlc3NlZChzdHJ1Y3QgZm9saW8gKik7DQogDQorc3RhdGlj
IGlubGluZSBib29sIGZvbGlvX21heV9iZV9scnVfY2FjaGVkKHN0cnVjdCBm
b2xpbyAqZm9saW8pDQorew0KKwkvKg0KKwkgKiBIb2xkaW5nIFBNRC1zaXpl
ZCBmb2xpb3MgaW4gcGVyLUNQVSBMUlUgY2FjaGUgdW5iYWxhbmNlcyBhY2Nv
dW50aW5nLg0KKwkgKiBIb2xkaW5nIHNtYWxsIG51bWJlcnMgb2YgbG93LW9y
ZGVyIG1USFAgZm9saW9zIGluIHBlci1DUFUgTFJVIGNhY2hlDQorCSAqIHdp
bGwgYmUgc2Vuc2libGUsIGJ1dCBub2JvZHkgaGFzIGltcGxlbWVudGVkIGFu
ZCB0ZXN0ZWQgdGhhdCB5ZXQuDQorCSAqLw0KKwlyZXR1cm4gIWZvbGlvX3Rl
c3RfbGFyZ2UoZm9saW8pOw0KK30NCisNCiBleHRlcm4gYXRvbWljX3QgbHJ1
X2Rpc2FibGVfY291bnQ7DQogDQogc3RhdGljIGlubGluZSBib29sIGxydV9j
YWNoZV9kaXNhYmxlZCh2b2lkKQ0KZGlmZiAtLWdpdCBhL21tL2d1cC5jIGIv
bW0vZ3VwLmMNCmluZGV4IDRkZDBlYjcwOTg4Yi4uZDEwNTgxN2EwYzlhIDEw
MDY0NA0KLS0tIGEvbW0vZ3VwLmMNCisrKyBiL21tL2d1cC5jDQpAQCAtMjM3
NiwxMyArMjM3NiwxMyBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBjb2xsZWN0
X2xvbmd0ZXJtX3VucGlubmFibGVfZm9saW9zKA0KIAkJCWNvbnRpbnVlOw0K
IAkJfQ0KIA0KLQkJaWYgKGRyYWluZWQgPT0gMCAmJg0KKwkJaWYgKGRyYWlu
ZWQgPT0gMCAmJiBmb2xpb19tYXlfYmVfbHJ1X2NhY2hlZChmb2xpbykgJiYN
CiAJCQkJZm9saW9fcmVmX2NvdW50KGZvbGlvKSAhPQ0KIAkJCQlmb2xpb19l
eHBlY3RlZF9yZWZfY291bnQoZm9saW8pICsgMSkgew0KIAkJCWxydV9hZGRf
ZHJhaW4oKTsNCiAJCQlkcmFpbmVkID0gMTsNCiAJCX0NCi0JCWlmIChkcmFp
bmVkID09IDEgJiYNCisJCWlmIChkcmFpbmVkID09IDEgJiYgZm9saW9fbWF5
X2JlX2xydV9jYWNoZWQoZm9saW8pICYmDQogCQkJCWZvbGlvX3JlZl9jb3Vu
dChmb2xpbykgIT0NCiAJCQkJZm9saW9fZXhwZWN0ZWRfcmVmX2NvdW50KGZv
bGlvKSArIDEpIHsNCiAJCQlscnVfYWRkX2RyYWluX2FsbCgpOw0KZGlmZiAt
LWdpdCBhL21tL21sb2NrLmMgYi9tbS9tbG9jay5jDQppbmRleCBjZGUwNzZm
YTdkNWUuLjhjOGQ1MjJlZmRkNSAxMDA2NDQNCi0tLSBhL21tL21sb2NrLmMN
CisrKyBiL21tL21sb2NrLmMNCkBAIC0yNTUsNyArMjU1LDcgQEAgdm9pZCBt
bG9ja19mb2xpbyhzdHJ1Y3QgZm9saW8gKmZvbGlvKQ0KIA0KIAlmb2xpb19n
ZXQoZm9saW8pOw0KIAlpZiAoIWZvbGlvX2JhdGNoX2FkZChmYmF0Y2gsIG1s
b2NrX2xydShmb2xpbykpIHx8DQotCSAgICBmb2xpb190ZXN0X2xhcmdlKGZv
bGlvKSB8fCBscnVfY2FjaGVfZGlzYWJsZWQoKSkNCisJICAgICFmb2xpb19t
YXlfYmVfbHJ1X2NhY2hlZChmb2xpbykgfHwgbHJ1X2NhY2hlX2Rpc2FibGVk
KCkpDQogCQltbG9ja19mb2xpb19iYXRjaChmYmF0Y2gpOw0KIAlsb2NhbF91
bmxvY2soJm1sb2NrX2ZiYXRjaC5sb2NrKTsNCiB9DQpAQCAtMjc4LDcgKzI3
OCw3IEBAIHZvaWQgbWxvY2tfbmV3X2ZvbGlvKHN0cnVjdCBmb2xpbyAqZm9s
aW8pDQogDQogCWZvbGlvX2dldChmb2xpbyk7DQogCWlmICghZm9saW9fYmF0
Y2hfYWRkKGZiYXRjaCwgbWxvY2tfbmV3KGZvbGlvKSkgfHwNCi0JICAgIGZv
bGlvX3Rlc3RfbGFyZ2UoZm9saW8pIHx8IGxydV9jYWNoZV9kaXNhYmxlZCgp
KQ0KKwkgICAgIWZvbGlvX21heV9iZV9scnVfY2FjaGVkKGZvbGlvKSB8fCBs
cnVfY2FjaGVfZGlzYWJsZWQoKSkNCiAJCW1sb2NrX2ZvbGlvX2JhdGNoKGZi
YXRjaCk7DQogCWxvY2FsX3VubG9jaygmbWxvY2tfZmJhdGNoLmxvY2spOw0K
IH0NCkBAIC0yOTksNyArMjk5LDcgQEAgdm9pZCBtdW5sb2NrX2ZvbGlvKHN0
cnVjdCBmb2xpbyAqZm9saW8pDQogCSAqLw0KIAlmb2xpb19nZXQoZm9saW8p
Ow0KIAlpZiAoIWZvbGlvX2JhdGNoX2FkZChmYmF0Y2gsIGZvbGlvKSB8fA0K
LQkgICAgZm9saW9fdGVzdF9sYXJnZShmb2xpbykgfHwgbHJ1X2NhY2hlX2Rp
c2FibGVkKCkpDQorCSAgICAhZm9saW9fbWF5X2JlX2xydV9jYWNoZWQoZm9s
aW8pIHx8IGxydV9jYWNoZV9kaXNhYmxlZCgpKQ0KIAkJbWxvY2tfZm9saW9f
YmF0Y2goZmJhdGNoKTsNCiAJbG9jYWxfdW5sb2NrKCZtbG9ja19mYmF0Y2gu
bG9jayk7DQogfQ0KZGlmZiAtLWdpdCBhL21tL3N3YXAuYyBiL21tL3N3YXAu
Yw0KaW5kZXggZDRjYjQ4OThmNTczLi5mZjg0NjkxNWRiNDUgMTAwNjQ0DQot
LS0gYS9tbS9zd2FwLmMNCisrKyBiL21tL3N3YXAuYw0KQEAgLTIyMyw3ICsy
MjMsNyBAQCBzdGF0aWMgdm9pZCBfX2ZvbGlvX2JhdGNoX2FkZF9hbmRfbW92
ZShzdHJ1Y3QgZm9saW9fYmF0Y2ggX19wZXJjcHUgKmZiYXRjaCwNCiAJCWxv
Y2FsX2xvY2soJmNwdV9mYmF0Y2hlcy5sb2NrKTsNCiANCiAJaWYgKCFmb2xp
b19iYXRjaF9hZGQodGhpc19jcHVfcHRyKGZiYXRjaCksIGZvbGlvKSB8fA0K
LQkJCWZvbGlvX3Rlc3RfbGFyZ2UoZm9saW8pIHx8IGxydV9jYWNoZV9kaXNh
YmxlZCgpKQ0KKwkJCSFmb2xpb19tYXlfYmVfbHJ1X2NhY2hlZChmb2xpbykg
fHwgbHJ1X2NhY2hlX2Rpc2FibGVkKCkpDQogCQlmb2xpb19iYXRjaF9tb3Zl
X2xydSh0aGlzX2NwdV9wdHIoZmJhdGNoKSwgbW92ZV9mbik7DQogDQogCWlm
IChkaXNhYmxlX2lycSkNCi0tIA0KMi41MS4wLjUzNC5nYzc5MDk1YzBjYS1n
b29nDQoNCg==

---1463770367-1581705103-1758618713=:5004--

