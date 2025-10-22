Return-Path: <stable+bounces-188930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C41BFADB5
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 10:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 308784E202B
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 08:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6652C307AE6;
	Wed, 22 Oct 2025 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="RQyNv3R1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sR7qicZ9"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E000D3064B7;
	Wed, 22 Oct 2025 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121254; cv=none; b=idjNOh87OCB0S3jOq2Bl8pUChe3JWTKLK3PpWyr+xlPFKL+qk399SzZLyCtopvNNpzMV6bT5I7Pv+idVFf/orhFsU/TXAdwI6GaPGR+g1NNWB8ZH1jaxAnqAmHA6OKqjKVQnqcotXz3b3bjrhAm/5nnKhV1L+1+/cN7UmKJAY2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121254; c=relaxed/simple;
	bh=SaXgF4JlzzCJ4zIHCtUVw5mm2cNNGDy7s63PbL/U9rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBFD7+yjsDfZw+BnLDZAYAixaFMk/W8LhjbubhUY5p1c+e5Zuv8momNwZ0HgfuN4gaLB6+iyyE0J0wMlrINjExomh0TwA9kx5W0TVSQSsJnTcQNEWtcEd2w01Q6xVmLqdhNxt0GE4WYaaqrizSwgdcHb3SHXaeR7d8yfcK2iaLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=RQyNv3R1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sR7qicZ9; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F27DE14001C9;
	Wed, 22 Oct 2025 04:20:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 22 Oct 2025 04:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761121250; x=1761207650; bh=uPC4ZvWHoZ
	pQ0FA8oprvgTzvGpj3Enck39VjaaCP7LI=; b=RQyNv3R1jkBd77W7ENqFkirfuU
	cvaWR7yqOgTuIVWKZUutJi41URla8X8U405KaHff63bl/kFDHR7io4U4s1gQqEz1
	dmjmv57cZIRMdOaSxMGRArYAubdpv6NwxdYL6jp/2/4AzSSQqVTmp4g/5hl/jFRi
	JsZWOKUyZryxPp09q0MK4Cj60gkntJG2D0F2u+lRIwe4T3oJ7PAeHMcq774KhkBK
	bEXUFu9TlgcBr9zAbFXxZQY3hnRaj7dzLEdXtQN69yfeTsRU3CT4P76RHXaBgWpm
	RWLqhWg1vl+y6COKrLoJFJkNTb7Tx1lbeSrI/OwUcWG6rpCmUsL/XpFBeNmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761121250; x=1761207650; bh=uPC4ZvWHoZpQ0FA8oprvgTzvGpj3Enck39V
	jaaCP7LI=; b=sR7qicZ9c5PnxW+VxYyhsnP9XcLrBfbc/awGfiyJDlmZ4UHqarU
	KozeOSwbOBDi+3zkskfFYy5+zJLG9OTChHYr0/4cv+83vAKFg3suBTzr5ghxGS3n
	RLnhXtUVXnAH9h7dlmqYwJIoIFH0k3LriH2f38vLnyZPnPtUBJBFSFCXoKYOgNmO
	jBmqBJDmqZq10y7vSKwTOyYafFD/GA3DsZWE0xlAB7eCssbWF+omWyQx3smsw5HD
	AZ4uwvFcyAtjUQVQOdXscwtROzO2218zvdjUWt+DmZibLqGKW6xsx5O3ePlDD8qV
	3cNAhZdHyJPGg6OZTcAiMaw5z5ohIwkFIQQ==
X-ME-Sender: <xms:4pP4aK8jqEfwKOq4EFFZBmz3K-FD3wSscM260pKPItpWa-DaRmxcew>
    <xme:4pP4aDcHI9eeDxqEs8dpejYouV14ZemsU65zAqAo0eoAD-I-ann5s7HGASFKmG_MP
    011lZQSNc1MgNsJIxhkVCLtnW0kctQEQK1D0_MmMsUqwXA0JQ>
X-ME-Received: <xmr:4pP4aOubuLV5MWkdsyEWlQONJmp9r48lo7ydBE012OtTVvQ8XfNNCC_I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeftdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvdevvd
    eljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhmpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheplhgvohhnrdhhfigrnhhgsehlihhnuhigrdguvghvpdhrtghpthhtohepshhtrggslh
    gvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhig
    qdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegurghvihgusehrvgguhhgrth
    drtghomhdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrghntggvrdihrg
    hngheslhhinhhugidruggvvh
X-ME-Proxy: <xmx:4pP4aE0cbiTkhkpo-euO6Vi41z_T7p0U3KfwGWeBTBGyi-kv0Rvi7A>
    <xmx:4pP4aDD6AekSYOMRUnqF6CarAHHdSQ0FrRTSh433D9lMfKOvhRCeRw>
    <xmx:4pP4aBdd1US3YSz3iNE9mnIDaovo72ekHpXk7QR5YMlYQJaQ92jPPA>
    <xmx:4pP4aFxWVdmYuQJJMnATsZurVvtofp8g5wbEo6ATVLcQSLvA_2prXg>
    <xmx:4pP4aFM5tPcaZAiYWSNb-vGqUe1nU82BwY6lkKdReyMjRZp6sGJauPjH>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 04:20:49 -0400 (EDT)
Date: Wed, 22 Oct 2025 10:20:48 +0200
From: Greg KH <greg@kroah.com>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: stable@vger.kernel.org, akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, shuah@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH 6.1.y] selftests/mm: Move default_huge_page_size to
 vm_util.c
Message-ID: <2025102210-detection-blurred-8332@gregkh>
References: <20251022055138.375042-1-leon.hwang@linux.dev>
 <2025102230-scoured-levitator-a530@gregkh>
 <ff0b2bd4-2bb0-4d0b-8a9e-4a712c419331@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff0b2bd4-2bb0-4d0b-8a9e-4a712c419331@linux.dev>

On Wed, Oct 22, 2025 at 04:08:45PM +0800, Leon Hwang wrote:
> 
> 
> On 22/10/25 15:40, Greg KH wrote:
> > On Wed, Oct 22, 2025 at 01:51:38PM +0800, Leon Hwang wrote:
> >> Fix the build error:
> >>
> >> map_hugetlb.c: In function 'main':
> >> map_hugetlb.c:79:25: warning: implicit declaration of function 'default_huge_page_size' [-Wimplicit-function-declaration]
> >>    79 |         hugepage_size = default_huge_page_size();
> >>       |                         ^~~~~~~~~~~~~~~~~~~~~~
> >> /usr/bin/ld: /tmp/ccYOogvJ.o: in function 'main':
> >> map_hugetlb.c:(.text+0x114): undefined reference to 'default_huge_page_size'
> >>
> >> According to the latest selftests, 'default_huge_page_size' has been
> >> moved to 'vm_util.c'. So fix the error by the same way.
> >>
> >> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  tools/testing/selftests/vm/Makefile      |  1 +
> >>  tools/testing/selftests/vm/userfaultfd.c | 24 ------------------------
> >>  tools/testing/selftests/vm/vm_util.c     | 21 +++++++++++++++++++++
> >>  tools/testing/selftests/vm/vm_util.h     |  1 +
> >>  4 files changed, 23 insertions(+), 24 deletions(-)
> > 
> > 
> > What commit id does this fix?  And again, why not just take the original
> 
> Let me check which commit introduced the fix.
> 
> > commits instead?
> 
> I agree that taking the original commits would be preferable.
> 
> However, it might involve quite a few patches to backport, which could
> be a bit of work.

We can easily take lots of patches, don't worry about the quantity.  But
it would be good to figure out what caused this to break here, and not
in other branches.

thanks,

greg k-h

