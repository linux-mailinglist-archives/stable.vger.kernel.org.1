Return-Path: <stable+bounces-188998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA034BFC9FF
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 16:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5AF6E1E09
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 14:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5D634EEE6;
	Wed, 22 Oct 2025 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="XBtN2lNj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wi8ZyAIs"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7782434E76E;
	Wed, 22 Oct 2025 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143216; cv=none; b=oOHXhuLv8LIH6krSR9CBYiG71sIMvdowL6rgehnwbL1iydijh7LsB8pwTp/P+840WIy6iMVwdHJARbYCDrVu/zX0507dWDRyUYTgxfSGwUk1AQ8GLrvKPdtfY7w5VYCMvE/UilcBvx6OnhcIpejU2uT9RgzvuOv+CF9S+sPU+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143216; c=relaxed/simple;
	bh=njnMKnmAzBOYSt4qbFbbHsfQ3+1SX5N8fWPqY9xDRPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMd9f/B8O25jukzwnc7VPDzlHDDAxGCfZGE/k39ssfi+4XsHZHhCX8rB2L5NyUlEZt1v8jZIXQVTj3ga0h/pqFbOq1Wjz43XFIQL3clWO+6rf5iFuuL+yqrrtVxBVBgI/7c229Rmc3F9xu8kkATGH29D9GI6puUOothYhB1c1Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=XBtN2lNj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wi8ZyAIs; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 400357A00B5;
	Wed, 22 Oct 2025 10:26:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 22 Oct 2025 10:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761143213;
	 x=1761229613; bh=jOvRrxLI/PxVSWmhxM2KgyJk/X+u6+/Vmaw9PuxY40k=; b=
	XBtN2lNjCSSfXGaqXi0gx/hlO8WnexR6tUKWFw0W+Esl1w0VoLdaeTBIpl3+3SRt
	8k0rusGVLaZzq6WMIbQuyM0WTeGOvKbmHJjwdrvEfb9GrR896b9a+9tEVP/3sdpf
	paxsxPUnRdTFFnAtOtM07XbRfRVrG5HBEzRZC5uKdExsyRB/Bzp5lpOMbS7BkPih
	KmI1toWj9g8kClgqlGVd7rtTlylfX4nulaysdLtdZfm6WvkOnT4eDZOEZObwlbIe
	XvmLXVmfvHix8i5HNxPGoT1+fXs0nagnK9AITqKPBowKP+EmQHFKGhEf++nGCMZe
	YxA9ggHBJsJm8bv/iF/7zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761143213; x=
	1761229613; bh=jOvRrxLI/PxVSWmhxM2KgyJk/X+u6+/Vmaw9PuxY40k=; b=w
	i8ZyAIsZtLOryR2GGVNqeGZtf8OTyPOHf6pua9/Bnpk4edYPEghboe7XrCsnRwis
	WBKNNK16wl9riG2ABWUcXXmkWKAM1IVvWIdcAv7TTPWO+dumAHiiNHlmQnNI1YKU
	DrtJyS7tlvRrHh0MzxA3OGVC1hODIFU6Vuvuj1ilxlG9EMHHWOVZKI2iojCk4VWJ
	TG3TEuoKd1Iytp3ITeBTdouGLMRhifNM27Ck0KHTFXWf2Xmm+dlkq+dxEeUJ+jRh
	8OWM26Faoey1nPrM5mbxb0xSgnGKfPzk1lS/4MV0eBfqNl4q02z1X8mlKKLvd3yf
	2xr2nypxaOlNK4P7Xi2AA==
X-ME-Sender: <xms:rOn4aFjhzhWf5UKFXIQngaoA8wC5xpsjfdgvdKyzQz3Uj3wIGjqYUA>
    <xme:rOn4aCye09H1Qqwat59MyRiZ4WtcMmBzXAYGpX5Dv_8ePeV4HZsSBFpgnQhSeQNHN
    3hVy940u5n_SnfyubajrMH9x33xXWTfWkjLF6aOEp0l3DasAQ>
X-ME-Received: <xmr:rOn4aDwAZbrOopB1xYax-VhcTT1OpzDw9qNkcnPY-NQn_rQEMd01G0at>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeefkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpefgkeffie
    efieevkeelteejvdetvddtledugfdvhfetjeejieduledtfefffedvieenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomhdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehlvghonhdrhhifrghngheslhhinhhugidruggvvhdprhgtphhtthhopehsthgrsg
    hlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhu
    gidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrg
    htrdgtohhmpdhrtghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgv
    rdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgrnhgtvgdrhi
    grnhhgsehlihhnuhigrdguvghv
X-ME-Proxy: <xmx:rOn4aMqYobzJeKegfjkTb2Jig2imGUptMSQ-WOJVeXy52dqRTzyJLQ>
    <xmx:rOn4aGlJAiIhljC8Jzc8Rlme4sPAFf5x2PVyh9nJ_wFCv19LEn15gw>
    <xmx:rOn4aFxOsEdEjF2cBNW6DFm5xJ1ZddlhJYnaYAxsI3aZNGWcNn7iMw>
    <xmx:rOn4aL0O7gaLZH54F7WEnqsoInBzvSTsUEWRZEg_V-XeXCFJ2g7Eog>
    <xmx:ren4aATnIlNrUwkxxcWac1tUEZMNUOouhUXC6W31CVSQFSaRLN_PrAxB>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 10:26:52 -0400 (EDT)
Date: Wed, 22 Oct 2025 16:26:50 +0200
From: Greg KH <greg@kroah.com>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: stable@vger.kernel.org, akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, shuah@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH 6.1.y] selftests/mm: Move default_huge_page_size to
 vm_util.c
Message-ID: <2025102241-clubbed-smirk-8819@gregkh>
References: <20251022055138.375042-1-leon.hwang@linux.dev>
 <2025102230-scoured-levitator-a530@gregkh>
 <ff0b2bd4-2bb0-4d0b-8a9e-4a712c419331@linux.dev>
 <2025102210-detection-blurred-8332@gregkh>
 <70f8c6a1-cbb5-4a62-99aa-69b2f06bece2@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70f8c6a1-cbb5-4a62-99aa-69b2f06bece2@linux.dev>

On Wed, Oct 22, 2025 at 09:34:52PM +0800, Leon Hwang wrote:
> 
> 
> On 2025/10/22 16:20, Greg KH wrote:
> > On Wed, Oct 22, 2025 at 04:08:45PM +0800, Leon Hwang wrote:
> >>
> >>
> >> On 22/10/25 15:40, Greg KH wrote:
> >>> On Wed, Oct 22, 2025 at 01:51:38PM +0800, Leon Hwang wrote:
> >>>> Fix the build error:
> >>>>
> >>>> map_hugetlb.c: In function 'main':
> >>>> map_hugetlb.c:79:25: warning: implicit declaration of function 'default_huge_page_size' [-Wimplicit-function-declaration]
> >>>>    79 |         hugepage_size = default_huge_page_size();
> >>>>       |                         ^~~~~~~~~~~~~~~~~~~~~~
> >>>> /usr/bin/ld: /tmp/ccYOogvJ.o: in function 'main':
> >>>> map_hugetlb.c:(.text+0x114): undefined reference to 'default_huge_page_size'
> >>>>
> >>>> According to the latest selftests, 'default_huge_page_size' has been
> >>>> moved to 'vm_util.c'. So fix the error by the same way.
> >>>>
> >>>> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> >>>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >>>> ---
> >>>>  tools/testing/selftests/vm/Makefile      |  1 +
> >>>>  tools/testing/selftests/vm/userfaultfd.c | 24 ------------------------
> >>>>  tools/testing/selftests/vm/vm_util.c     | 21 +++++++++++++++++++++
> >>>>  tools/testing/selftests/vm/vm_util.h     |  1 +
> >>>>  4 files changed, 23 insertions(+), 24 deletions(-)
> >>>
> >>>
> >>> What commit id does this fix?  And again, why not just take the original
> >>
> >> Let me check which commit introduced the fix.
> >>
> >>> commits instead?
> >>
> >> I agree that taking the original commits would be preferable.
> >>
> >> However, it might involve quite a few patches to backport, which could
> >> be a bit of work.
> >
> > We can easily take lots of patches, don't worry about the quantity.  But
> > it would be good to figure out what caused this to break here, and not
> > in other branches.
> >
> 
> Hi Greg,
> 
> After checking with 'git blame map_hugetlb.c', the issue was introduced
> by commit a584c7734a4d (“selftests: mm: fix map_hugetlb failure on 64K
> page size systems”), which corresponds to upstream commit 91b80cc5b39f.
> This change appears to have caused the build error in the 6.1.y tree.
> 
> Comparing several stable trees shows the following:
> 
> - 6.0.y: not backported*
> - 6.1.y: backported
> - 6.2.y: not backported*
> - 6.3.y: not backported*
> - 6.4.y: not backported*
> - 6.5.y: not backported*
> - 6.6.y: backported
> - 6.7.y: backported
> 
> Given this, it might be preferable to revert a584c7734a4d in 6.1.y for
> consistency with the other stable trees (6.0.y, 6.2–6.5.y).

Ah, yeah, it looks like this commit was reverted from other stable
releases, as it shows up in the following releases:

	4.19.310 4.19.315 5.4.272 5.4.277 5.10.213 5.10.218 5.15.152 5.15.160 6.1.82 6.6.18 6.7.6

So a revert would be fine, want to submit it?

thanks,

greg k-h

