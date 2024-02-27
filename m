Return-Path: <stable+bounces-23849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DDE868B64
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E05D1F266DC
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F56136983;
	Tue, 27 Feb 2024 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="5fY/3uPW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EDYN7L4t"
X-Original-To: stable@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA33B131750
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024111; cv=none; b=e1BzE9uPgSi0FdIDyDkVtX7858CnHVXwfkKR/cJ52K3Xe9Wii+yb968iQimKYLtpO5zjpKHboPdLiENJoUvpiBL212nyipm2LsMBU+mVCyRcgHi2idHZqBj+hkCT5QByDt5DvQHTAKyM7qdbnJlPTVOTP/Wvzcec1XMKaFrzo2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024111; c=relaxed/simple;
	bh=qwDA0HXUvfyQMWy0/XBdETMfISuhqWIagSADmGkZdAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoCC90B7UwPtNUuiIo8d1qZ7DPBg1Q2kKF6DLzPZnUBqHePSzgLuVYskCFL1NeAF5duDpnjr0/2yWSg19Q7UPX88+GFXwOo/pQtHoVZcWtbSCyAiUmGgCMKytJSjTOmnQpo1Ysll3Lxd8YHuk02fQc0WrPn0rA/45sti6Fufpfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=5fY/3uPW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EDYN7L4t; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DA17711400E2;
	Tue, 27 Feb 2024 03:55:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 27 Feb 2024 03:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709024108; x=1709110508; bh=n9unWy7SY3
	ug6oeuBh4XHno3rvft+LdGilWhhhIKTkA=; b=5fY/3uPWBguZ6IIIZfAE+zl9rl
	cWeL74f1PdMyWUeY4giiwzOYJVpSq4mF6oI0Hfi7NqSfgWRGZFp5vn22JhkHNV+W
	KnvCtoY/eFKjFq1wDwe4szNht4cBtOAFb4YUUfYn0FYm9phOZRNVl6FLg9zHXarh
	Brrjdysbsim5xIbMefjFX5C3zhdk0keNK12f212EJzfzB0E91tw6Nj1XedoMSMyV
	WbCemMgGEeBa1FUexUa2qQ37keCbSwQJv5mWtFAdwprDhFHyz3jBv0kVTzSnnmts
	+sV1udFDVr2q2Q/1cObGmztY1GuDnjktSlZ29Dj2z1mv+cK44U/BT7aUn8VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709024108; x=1709110508; bh=n9unWy7SY3ug6oeuBh4XHno3rvft
	+LdGilWhhhIKTkA=; b=EDYN7L4t5503QAGWY2fMGVH6tfNm5A65gf478Yo9pL27
	gIDh72+uiJFgS6hm9+2euCYr7EzSR7icnmxkXJceMZoCkYdmsQYA2W2I8czTZVev
	tZ18dHqMzpwuYm0vsYxlUW+/VleBPxsNjKDc8xPTmPJJI1+lNdQSxFGgerc+gx6K
	poPFP9AFDlIyRDz+GwpfEx8FmiwugcKx3JcSqH9zMPZzZmQBrQaSucx6AuKGjqfb
	zXG4VEhUmNcMULRqPi9TkI5dMXR3VZq/1aKLpybHYQFDP0Ayf6HCMdxPP0vAfcb+
	qRuWIHJgmXCEraYGHaixgqZDUz9xv6BKe/By0gY8og==
X-ME-Sender: <xms:bKPdZUxdA-xTXLVsG9qvtPOtRUkLtkXkYMgBp8ZvJYmphpavWAM6EQ>
    <xme:bKPdZYQdR7Vi3R2bMhMQoZYxEH2GSGmaVpz9Aa9GIrcgsJiYKRpb01FTq3yFCm0E4
    mebDEU5lBcuVw>
X-ME-Received: <xmr:bKPdZWWB3Lhvw10vft4ugz-FbVOdBVedWczElMPCp0kKNu1sNr6VPBqoZzl0szLbV3IkOvbG9Mkv0W3JYoRL0DzsgrPMO3qKIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeefgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:bKPdZShCI_bislyxjSgwGtABjantK00U04xhKr9ryCN40l7sZG-1sA>
    <xmx:bKPdZWDflmOGamPhrkW0VmuFXgzQVjmzq8T1sO2NHEw0BpuffNzAJg>
    <xmx:bKPdZTL4U6GpiCF0-zhjyIRrdbR9aOUEU2MDZ62xOBZXXE6sj30Qeg>
    <xmx:bKPdZebZ5iNC9r78faPKlKK48H4ax7duSg0qILni_lcQ5Dhwsm2pSA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 03:55:07 -0500 (EST)
Date: Tue, 27 Feb 2024 09:55:05 +0100
From: Greg KH <greg@kroah.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: stable@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: zswap: fix missing folio cleanup in writeback race
 path
Message-ID: <2024022755-amplify-vocation-854e@gregkh>
References: <2024022611-tropics-deferred-2483@gregkh>
 <20240226221017.1332778-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226221017.1332778-1-yosryahmed@google.com>

On Mon, Feb 26, 2024 at 10:10:17PM +0000, Yosry Ahmed wrote:
> In zswap_writeback_entry(), after we get a folio from
> __read_swap_cache_async(), we grab the tree lock again to check that the
> swap entry was not invalidated and recycled.  If it was, we delete the
> folio we just added to the swap cache and exit.
> 
> However, __read_swap_cache_async() returns the folio locked when it is
> newly allocated, which is always true for this path, and the folio is
> ref'd.  Make sure to unlock and put the folio before returning.
> 
> This was discovered by code inspection, probably because this path handles
> a race condition that should not happen often, and the bug would not crash
> the system, it will only strand the folio indefinitely.
> 
> Link: https://lkml.kernel.org/r/20240125085127.1327013-1-yosryahmed@google.com
> Fixes: 04fc7816089c ("mm: fix zswap writeback race condition")
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit e3b63e966cac0bf78aaa1efede1827a252815a1d)
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

What tree is this for?

thanks,

greg k-h

