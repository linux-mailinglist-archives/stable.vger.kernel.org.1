Return-Path: <stable+bounces-124921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4961CA68E5D
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077C43B083A
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 13:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EB5157A6B;
	Wed, 19 Mar 2025 13:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="cFOJbp/1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0l0JTfv1"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6F3158874;
	Wed, 19 Mar 2025 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742392761; cv=none; b=QR/CdE7Co/ItZ96tZlMWmRv+2CQRYaVPjmkYGx9gtE88PLQxdWc8eF9UOfw+91wVr36Kv496HMoRzFV8IktuNUuIdD1w3mF2PbsDzTLxUdhokRiqCM8iIha/ma6TOGNnecyVc3l2Cxp679iV+oN9gIN7EEAXQ1E0p5CHlmvCsNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742392761; c=relaxed/simple;
	bh=fPqz5Ggxgej3Es8iXSwsdFSApuVIaat2KWn0CxzLQps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3Kf4QiASduQEHBAjzMHHec1r7h5ksCqfZyUjH3036s1ScXwra/hAz1uxwlIU+pRF+rauGt4uCEEZCmq6LjoUQFc7O7sJ+mVzq5WN4yGQwGo+OAl4golpCF/wD1JZq2t701FuyYsCJMFSHHtudfc3RP4fzJ5b5r9Q3UkNDPNlT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=cFOJbp/1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0l0JTfv1; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D90BC1140211;
	Wed, 19 Mar 2025 09:59:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 19 Mar 2025 09:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742392757; x=1742479157; bh=Nqlr+Z98ri
	wp0drvCHX+D73L1Bd1v/TAt/cOBIOT5Xw=; b=cFOJbp/1Qz1SvGgphqc+TC1o6i
	JydDTk74cy97MyBMNIUHSrfN3P6b55S6u9gseZug21udEEq7tCvKw+1xDj0vSmLB
	bq/OeHiUXghFoGwe+8yRpM8SNmJPGwNpNyHfVJGeEAdSjXjTnwmZRDv2YLsOnjgR
	QuxRYslieHrrIFkTnAMOqdeAfBIXTnrLkDYfDJN0akfkRzlIhVN1gbymaKzdlSRL
	UXy0cyiCdVOn3//c+EhUGhjFFMJxbrdzbZabFei2u2ZqO9zzx+eg7HUrTIepq/Iy
	gyqh8XcAvCmPfIJLXr9cf/U+tX0pkxDO0G4iny/fhoh5+eHE3hiesGreotag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742392757; x=1742479157; bh=Nqlr+Z98riwp0drvCHX+D73L1Bd1v/TAt/c
	OBIOT5Xw=; b=0l0JTfv1Ca2Xy7ltxHnBKuuqkazgu4z0N4YkVZPLVXdNwg9Fxah
	6RYeHZ6OXgdE2UWsjVB+H5LVWM8hvjGn08hjUj8Ilq2dwjWaY48HEGSpwOsoH/za
	+BvfsL/u0adoo/p2V1jrwmmxbgqADY1m6iO35klbsE7mn6AXZ0NqOmEf/yH3vE4N
	8Bpqr6VkhKlY2qvOO0cI2Omc1qhXptYt6BXdmea/MU33DB8m0JLqwSi1bGoz//RR
	d+TKD5PIdMcUTJ1mBcZ8Q2SDSOtgbdCCZkzYxLbTWkb+/0iQ1bW6Hslw5NHgPvEg
	dzAkQ4YJ9Gs9VoJKInuIMJaP07CEC2M/F0g==
X-ME-Sender: <xms:tc3aZ3UIEFdPTE-H19gW7Wh5sW1qoC73alg2YJBoc_f-8RbPDUnjDA>
    <xme:tc3aZ_nTPgO806YaxlrIO-MhzW15ojHbFzdKf6PxztG0M3GETN0FxpYSCfRSdhDz0
    OyboMDQo2rKWQ>
X-ME-Received: <xmr:tc3aZzZPHiPNjvERcU0N2RrrKKX0njnRNdoCf8hms1ASLDkJ4wbeDrG4KZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecugg
    ftrfgrthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeu
    fefhgfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtih
    honhdrohhrghdprhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphht
    thhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsth
    grsghlvgdqtghomhhmihhtshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegsrgholhhinhdrfigrnhhgsehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpth
    htoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhg
X-ME-Proxy: <xmx:tc3aZyWqvU3CWVpdRvWQVeu-gCQ9ygd9YOYjceRym_ZCERxED1xlgw>
    <xmx:tc3aZxl0_qzaVXQxZ7PtW0UmpjSHW9_VJmT8dUFYONsWSTKVR8ivHA>
    <xmx:tc3aZ_eAmHrGdmeqYGjG5Bp-mAA0czYydqwN6zJM-4C6Wo4lJ9egIA>
    <xmx:tc3aZ7FkHr88j_652m-1ZxQ1_KusmvXm4NHRY-xylrcG7imEi-i60A>
    <xmx:tc3aZ0_zYGpnLgcDCTBbmApjGkkKBy6X8HsA22ML6Y4UhfuObKS-gNNa>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 09:59:16 -0400 (EDT)
Date: Wed, 19 Mar 2025 06:57:56 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>, stable@vger.kernel.org,
	stable-commits@vger.kernel.org, baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org
Subject: Re: Patch "mm: shmem: skip swapcache for swapin of synchronous swap
 device" has been added to the 6.13-stable tree
Message-ID: <2025031959-dense-surely-6975@gregkh>
References: <20250318112951.2053931-1-sashal@kernel.org>
 <850f7c3f-26f6-9d60-ac46-ccaf20661cf6@google.com>
 <20250318165340.bd86004687ceceb03cccfe7c@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318165340.bd86004687ceceb03cccfe7c@linux-foundation.org>

On Tue, Mar 18, 2025 at 04:53:40PM -0700, Andrew Morton wrote:
> On Tue, 18 Mar 2025 08:28:44 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
> > >     Cc: David Hildenbrand <david@redhat.com>
> > >     Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
> > >     Cc: Hugh Dickins <hughd@google.com>
> > >     Cc: Kairui Song <kasong@tencent.com>
> > >     Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> > >     Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> > >     Cc: Ryan Roberts <ryan.roberts@arm.com>
> > >     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > >     Stable-dep-of: 058313515d5a ("mm: shmem: fix potential data corruption during shmem swapin")
> > >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> > 
> > No, NAK to this one going to stable.
> 
> Permanent NAK to *any* mm.git patch going to stable unless that patch's
> changelog has an explicit cc:stable.

The commit:
	058313515d5a ("mm: shmem: fix potential data corruption during shmem swapin")
DID have an explicit cc: stable, and Sasha was just fixing it up as the
number of FAILED mm stable patches are pretty high.

I have dropped both of these from both queues now, thanks.

greg k-h

