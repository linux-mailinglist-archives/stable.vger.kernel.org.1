Return-Path: <stable+bounces-159296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8768FAF6FAF
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 12:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5E51C47A12
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 10:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5382E11DD;
	Thu,  3 Jul 2025 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="bXnSup6a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nSUOFKLK"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECF31B95B;
	Thu,  3 Jul 2025 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751537196; cv=none; b=RMm86MahkTH30+YPsIpCWYIYVWfv0MioprKD4enAfVYKbwT+pxX7WSv+REnyJtpTF0ppMHjJ5Qj9e6ljZmFDMYigYy4ka4XeAZDNHdtD2Y0Vp3TUD8HEaw6ivrdNW2RkdJuDt+u//3TwwxOj9pY5CUZrTXExGM1s0FL/QZJOaP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751537196; c=relaxed/simple;
	bh=VLvsZbCMVCjlhFRnfBeprQJpihfEwzytG12xF52C9jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XK2Dljn7bzp7/0YqKokPOTpsrGTjmmuFQxrO0e0fj4MwyUXB5dGlR3tsP1p6/N12aUoo7MiOBznkCMqEzWdM+/2QaE1ZhV/nEnvCvC7weOFSNatN8uWc811lvpMyTbaI63b9Wj4vhtVvMvTiXyuDAF1rJYW86+02tbi5Y9uWgzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=bXnSup6a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nSUOFKLK; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F16F14000B9;
	Thu,  3 Jul 2025 06:06:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 03 Jul 2025 06:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751537194; x=1751623594; bh=9lrf5wzMoZ
	6J/QpHfivU+gednLxgwZTZ/c4/OmLJKLo=; b=bXnSup6aQieDoOuvAIMgY5JcDz
	LxThvKxitMaxLgrqGbilntah1YvrSP8RWMVLxvinNO8zo/xo9GZgbTkZv4QzCEdO
	Jzgu0MDRjTG8L/64LDPBVzZHUjrF9fPPkR6fY9r1LT4xsMObR/T9hwwwoYQpJQ1f
	38beKDam6zSnxoAfZsEwdksOnzrLiuDYwvRqH3MLLRyhH1j7Ug3yT36eqD43EZDD
	Dufax9oXZHRL8nVJPyestwDu4OFenpf0KySOJEzSClZoBCUd3inssJq+U7eYW4TP
	5nOCY0Kb7B1B54iwekU7bJz5HbtPx600Awiq5kziy5CJNL7Id4UqwjNxswcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751537194; x=1751623594; bh=9lrf5wzMoZ6J/QpHfivU+gednLxgwZTZ/c4
	/OmLJKLo=; b=nSUOFKLKBUBSel8rm8kefj5N/uEAiplic4esh2Ri1yHOt1p2hxF
	OGvQqL9m+marQ8ly3uW9RExA9B793bwlw7gTAGI3BwKzpvisDZJPyYUrdNtJNR2f
	fqdB3V2IliQhOlDs87w89cmgbXkONy5LaLheF/g9Kmw1XWcEpqiUl4couezFOYPp
	6KqqKZwx/jlvoTdtGlMV5wY9/WO7uq7x55gavQMwhBxOrb3H1YQ17XVMPwSH6qji
	UXVW1U2BmPeBvx/xLY+pfLSJareJ/TOyTFCiQ71rkVQh/kBJq8mziUnpXErNGJE1
	R0LJSezzFG8CyLDNn7HeOb78vhzk6qVucVQ==
X-ME-Sender: <xms:KVZmaGqupRg-M6qJ-_8KEAsiELlwvpEa9SFJsTfja2S1G5K5MLXDQA>
    <xme:KVZmaEqb7FZkS6DEfVL1RhtkqWOkUg64OfORzgjAZeqUtXmAyoHQ87MTHi1RQQjSH
    frqRBalgqv9Pg>
X-ME-Received: <xmr:KVZmaLPy2uGfuAdti_WIV8vQxw1sC_wH-dQa07Z6Yc-w-uHptvD1uPuLCyWGLcMVpXfFjr2ZYQvtwp4YByggqmjDIGn5l68>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecu
    ggftrfgrthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiffdvud
    effeelvedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtg
    homhdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegrhhgrfedutdehuddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtrggslhgvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhrvgiikhhisehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdroh
    hrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthht
    oheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KVZmaF6ULRxKtCv43SwrThS4tf5az2060MbroCT_GlOZnwzhEHwnEQ>
    <xmx:KVZmaF5koHkl5laVBkUVQklBHhcs6TxXzNLwdseVSas1XiLXYz7_7Q>
    <xmx:KVZmaFjMBW-ji12BxIqtxOLChPKNHElkDmYcePmLFQSxV7JTh_QLfQ>
    <xmx:KVZmaP6izJ50zmyiZmgbMvb0Tq1AakvbK0BAYVjBVff8OgDgIGHk0g>
    <xmx:KlZmaCFHBW7XdzBvpybxPSbNQA0gvAuktj4EOi_vhXEvr_raSXyColYC>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 06:06:33 -0400 (EDT)
Date: Thu, 3 Jul 2025 12:06:32 +0200
From: Greg KH <greg@kroah.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: stable@vger.kernel.org, urezki@gmail.com, akpm@linux-foundation.org,
	edumazet@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12.y] mm/vmalloc: fix data race in show_numa_info()
Message-ID: <2025070315-breezy-bogged-75f3@gregkh>
References: <20250702153428.352047-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702153428.352047-1-aha310510@gmail.com>

On Thu, Jul 03, 2025 at 12:34:28AM +0900, Jeongjun Park wrote:
> commit 5c5f0468d172ddec2e333d738d2a1f85402cf0bc upstream.
> 
> The following data-race was found in show_numa_info():
> 
> ==================================================================
> BUG: KCSAN: data-race in vmalloc_info_show / vmalloc_info_show
> 
> read to 0xffff88800971fe30 of 4 bytes by task 8289 on cpu 0:
>  show_numa_info mm/vmalloc.c:4936 [inline]
>  vmalloc_info_show+0x5a8/0x7e0 mm/vmalloc.c:5016
>  seq_read_iter+0x373/0xb40 fs/seq_file.c:230
>  proc_reg_read_iter+0x11e/0x170 fs/proc/inode.c:299
> ....
> 
> write to 0xffff88800971fe30 of 4 bytes by task 8287 on cpu 1:
>  show_numa_info mm/vmalloc.c:4934 [inline]
>  vmalloc_info_show+0x38f/0x7e0 mm/vmalloc.c:5016
>  seq_read_iter+0x373/0xb40 fs/seq_file.c:230
>  proc_reg_read_iter+0x11e/0x170 fs/proc/inode.c:299
> ....
> 
> value changed: 0x0000008f -> 0x00000000
> ==================================================================
> 
> According to this report,there is a read/write data-race because
> m->private is accessible to multiple CPUs.  To fix this, instead of
> allocating the heap in proc_vmalloc_init() and passing the heap address to
> m->private, vmalloc_info_show() should allocate the heap.
> 
> Link: https://lkml.kernel.org/r/20250508165620.15321-1-aha310510@gmail.com
> Fixes: 8e1d743 ("mm: vmalloc: support multiple nodes in vmallocinfo")

Same comments on the 6.15 version, why change this line?

thanks,

greg k-h

