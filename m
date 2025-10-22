Return-Path: <stable+bounces-188915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CDEBFAA30
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 09:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D62AD5070C0
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 07:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA312FB98E;
	Wed, 22 Oct 2025 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="S2CX+9xO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DU/wXHAj"
X-Original-To: stable@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581572FB61C;
	Wed, 22 Oct 2025 07:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118857; cv=none; b=VPFnHntlaG5tQU4fn85M0KMYIwuSi8nlNCHQ1twkcSaKFfYnRkSDszMJONA8rzHqJ+oaN4ktPcl2hFglcGnOJKXsHkq6cODLr1i8lzPFfba+jeNbe4mSNblwYrqFHt1XjA3SEmSpXxa+PyGt1xfOm7+Jj9x4TZHnXh8TUKulH/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118857; c=relaxed/simple;
	bh=ptsr+CkrEYXAO4QKKRWMvqPRb8OQOyW1l37qGvBpwuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kgy3igNi7wePPMhTDqEEvnHudDhWXHtgMLf2bGLTbrj0HeEsZB5z+Py7j6ePlpCzxbJtkxlbbNhTaxT5Brn7FjCScwDVCsNbANHMDwjdc1byr3PGkUK0QdyeJKQhCwqSDq8n1LaazT4DTa8VYNLEgfyDe0aJgc2NfX0xJ5j+m1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=S2CX+9xO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DU/wXHAj; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 42678EC0183;
	Wed, 22 Oct 2025 03:40:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 22 Oct 2025 03:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761118853; x=1761205253; bh=9u/6AOHdyJ
	KLm2MAVj/gg3WnnXnpnA5iTO0PKfyo/5U=; b=S2CX+9xO+lB5b8QIcajBhxlNP9
	B6S0lIMXmIEIHLe0mBNFn53EkW9n3eRhfYHhGyW6Q8HTO2V4HJKSYkXqUSGPpSOS
	mX7L0xZ+YAsYs6GU9T5KSu8wSHcB4zXguoOe+DpboeDuYh9qYO3Daznip60lTbyB
	pXe2flQNFYvMEEj2+YEd/OpC68yX2Ei8bG0LQueWg+93vvwZPmVv6rWKiZXjZJx1
	jb5aDkcBjo/8TSYZUAQv1BSxoYQ7P1l117xNRhFcTJzewh17ZIsCJC8zXBbD/c7J
	mkritEo8EsTxvYU7j+MXUwJt0AnWQPD7Rdz8tQPXX1lE2Db+QuvCZ8LGYjOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761118853; x=1761205253; bh=9u/6AOHdyJKLm2MAVj/gg3WnnXnpnA5iTO0
	PKfyo/5U=; b=DU/wXHAj0AuA/qtjvo2fDScseQKQ4OMji/CnkC7szRlxmbbDWCv
	rGNG16shMn0eboV1GejawCJ3DBb98pWeLiFmkfUyxOuG3L8XMcGd6WKwC5xoQxM/
	N89Dxj1/wOVspufdjh/9QFCP8Hs17ncM+JS8omOD8YATEfOXdBD9pHkJs4HhITAp
	nzdBxUPedvEersg9PedjWUqtfbqApJP8tyXeX0kE+0/nQTBTvN1M2zT8j9g1/8rW
	/2aZ/Dn1xSC9yFM4c8Xsa/QjGC9celo4R4dwI3rZ6d/5G9j0dDu1I04AGBfppGy4
	Fvp8WZ3ryPfGRX+A4sBCn3fmnGMi6vESRtg==
X-ME-Sender: <xms:hIr4aLlAkY4zwtHdoPYzDEThSSYDKiJbNeqGUBF3uWGWfisNuhE-tQ>
    <xme:hIr4aHlgs-mwtp1Qbf5F5Vbx43rgjXqeLQponxF18l-tPIyAk6l2KAXQQslts92Io
    Y8i2RWO00reWipJGVCjvMca-mJWS611MmQjkILGISo0w0VZmg>
X-ME-Received: <xmr:hIr4aAXpN9J0gX4tRVJFrMqBBVZeMpM2bqQwB9Uajdzv4o5A9N1MIWtK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeftddtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:hIr4aF9M30XQygfl7U-P6vIcPnB5h_FMk1MekPlYvg2aVh15tPH9og>
    <xmx:hIr4aNqd-8PMwOlgRSJEGQjZ-7PiXKIFBW3N7mIj5-3_hXb4R48Jjg>
    <xmx:hIr4aHnI4hZqJrIurvlLueaonGwfj55DByZl4_l256-hg_KTCc_0Fg>
    <xmx:hIr4aBYb3lFJsPbTSmNmiGw_1_Q0jffZuO2XT91gIVjladboH6cvqw>
    <xmx:hYr4aC1uwQoSH2P8BZR-2V4Ltoxt1wCMWv6d1hEpg4nNI-tMkewhJZof>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 03:40:52 -0400 (EDT)
Date: Wed, 22 Oct 2025 09:40:49 +0200
From: Greg KH <greg@kroah.com>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: stable@vger.kernel.org, akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, shuah@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH 6.1.y] selftests/mm: Move default_huge_page_size to
 vm_util.c
Message-ID: <2025102230-scoured-levitator-a530@gregkh>
References: <20251022055138.375042-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022055138.375042-1-leon.hwang@linux.dev>

On Wed, Oct 22, 2025 at 01:51:38PM +0800, Leon Hwang wrote:
> Fix the build error:
> 
> map_hugetlb.c: In function 'main':
> map_hugetlb.c:79:25: warning: implicit declaration of function 'default_huge_page_size' [-Wimplicit-function-declaration]
>    79 |         hugepage_size = default_huge_page_size();
>       |                         ^~~~~~~~~~~~~~~~~~~~~~
> /usr/bin/ld: /tmp/ccYOogvJ.o: in function 'main':
> map_hugetlb.c:(.text+0x114): undefined reference to 'default_huge_page_size'
> 
> According to the latest selftests, 'default_huge_page_size' has been
> moved to 'vm_util.c'. So fix the error by the same way.
> 
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/testing/selftests/vm/Makefile      |  1 +
>  tools/testing/selftests/vm/userfaultfd.c | 24 ------------------------
>  tools/testing/selftests/vm/vm_util.c     | 21 +++++++++++++++++++++
>  tools/testing/selftests/vm/vm_util.h     |  1 +
>  4 files changed, 23 insertions(+), 24 deletions(-)


What commit id does this fix?  And again, why not just take the original
commits instead?

thanks,

greg k-h

