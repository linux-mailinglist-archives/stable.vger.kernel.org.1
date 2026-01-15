Return-Path: <stable+bounces-209950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB530D2839D
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 20:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC9A2307F002
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 19:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7086631B832;
	Thu, 15 Jan 2026 19:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4N31qj9"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4775233993
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768506317; cv=none; b=Lg2oviO80UFfIHnAHhtGLAx7v7UZeZYSC1clFqOKbNY0nD1Eo3G2L4mUvYdRBms4u20A7eWmygOjKwW8IzSXFZzkP8Ofyu91o1/q5cYWP5Bmg5aRPUS1fP7Dj6GphbR2gKiBQjiggB1oulnudoQD/5Xs0p+Nm1aO19quaDQjnMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768506317; c=relaxed/simple;
	bh=wK0gwYsd13XO1vi/bU8PqHRYZ8BI0emom8T6gkMMojo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajmCngjNQv0XoCeB0UGqHFrmVWNh/bmTD57QtP9hcMnGd8Gg3V4yshresP92JtS4YXZtBuz1CxDQOZVUEWU9mKZZ8QfDZqgdvC0LdWrYHlG07euNfgzuvMlBqqksEQvnmC6mHOuA40cMh7+AOd5+2qZxjy3yvla2ZOzvte22u0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4N31qj9; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64455a2a096so1108400d50.3
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 11:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768506313; x=1769111113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7GsFDW3HeDyKihzotR4/NfBM14wwU30+97RfyEF1UY=;
        b=T4N31qj9tUsMaWJrS7LyUf6JFhaHgUoYPu+VabEHtqRnV3DDqKMEXYVqmYeLQ209dA
         Y/nHWTKoGS+r3wRdubnaff6sgl8ebJ4FlY7Pb2R2TR8rPAotykHHfWM6yTRAjrTKU6Bn
         b6uNenk3F7vfnffJfOsdTTnc5w4EBScmxPuHiwJPYxsp/bTqITNLl+Mmcq2UcXsz3HVn
         D8s23XGa/TFuC0f03jdHVseGsh9yDbHoq0vDRNi0Gd5hPbG8oZ+JwHG3lbNXMrupbKHn
         hpv7lCTrik/0I9ucC7f18coqeKiOjbLxmQfXmyRP85BTS0g3/EBsEFxAi0OlvPzZNh8x
         JIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768506313; x=1769111113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P7GsFDW3HeDyKihzotR4/NfBM14wwU30+97RfyEF1UY=;
        b=hKbReTu5Ak9YJ/YyxTmzdJedx1cKwCeXqaKneAAd+2FhUt1jZuI3BjlIymgGbn3Fz4
         xzo5JIj53Aw3w6HYKhuwo+zyBn5jenVpICuNTKHO5Nf/wZsMawJQrlWeoxwwNzy3eBQB
         MC/MaEHr8/wewBms+JaRmUlhC5OGXcllUMfuR3AS4lksITVnuRriOxy2FrtKUydnMamW
         bfWXdhiwvS7gk5kAhXFGD3r5ista91pUVuUm7PdKrpX+hXMumx5WZmUqU+YYf2YMI1Bd
         wLxSHRHE+nWSavLMe/pOz8wsc7NW2OzkeHZR32KmPfVojpf5IWZEtY30z3IkI+GQkL5t
         qXYA==
X-Forwarded-Encrypted: i=1; AJvYcCUaHuYKFwb4ByQNBcjR684xnp+drUNYmCZ+VefTFUqCABiHyEx131d3vgT+cnlv7pG770JGIS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvQrIMlRKGnxDQ6+eXQoJ8cNYjdLU2Z52K3Zal8xDz1AwcMu7+
	YNb/0aqwfvR2xOLV41TxmAFITDl8FBaTXKG2mGpUSYbBAeunT/TMJSMc
X-Gm-Gg: AY/fxX4MvrmBU/48FHtgL4Z74IWsvMtlueKqPfhTUdLo5A/RmTRzXrMNgVu2vx4O2+P
	+VziJ8Hj2ZxBgP8szS2oRaytPzEkO8Y0/47lfSClpfpyoRLqe1PLly55UBn/bt1bcevN2dvjVJU
	MWTGeLl8t9b3bAoblcWMncbD6c0/+9KT9TyujlgXSEWSNmab4LFQ3VDPZ//XQYQ+xsJnLMwg1jw
	AXn4tpymjeUm7UBc/M/1Q9mMh7ViMYntNTdqa0p1wyjtzBYO2PISHSxulQvMFDmWdWvrL6EiHxS
	WANz+u8gdDn1wfAmXmdaSIbi6+XUgO1RapR1uaXx4ovxrZ/CKoLE7r6s0QTYtIKX9Zm3JaZZGRI
	UvMVOabjsM9cr8WFuGWqPPrR+vb8XcpPMzoLT+pCZLHYrV+0C81BDNPCZoNoZFlwql4XvWPOi1I
	KNn8UtZ2Hl0A==
X-Received: by 2002:a05:690c:7288:b0:78f:b163:782 with SMTP id 00721157ae682-793c53eadd1mr14217807b3.58.1768506313106;
        Thu, 15 Jan 2026 11:45:13 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:56::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64916ffb951sm205444d50.2.2026.01.15.11.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 11:45:12 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Wupeng Ma <mawupeng1@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/hugetlb: Restore failed global reservations to subpool
Date: Thu, 15 Jan 2026 14:45:10 -0500
Message-ID: <20260115194511.836766-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115111946.4b50c5dbe6c6bd01638e4b16@linux-foundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 15 Jan 2026 11:19:46 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 15 Jan 2026 13:14:35 -0500 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

Hello Andrew, I hope you are doing well. Thank you for your help as always!

> > Commit a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
> > fixed an underflow error for hstate->resv_huge_pages caused by
> > incorrectly attributing globally requested pages to the subpool's
> > reservation.
> > 
> > Unfortunately, this fix also introduced the opposite problem, which would
> > leave spool->used_hpages elevated if the globally requested pages could
> > not be acquired. This is because while a subpool's reserve pages only
> > accounts for what is requested and allocated from the subpool, its
> > "used" counter keeps track of what is consumed in total, both from the
> > subpool and globally. Thus, we need to adjust spool->used_hpages in the
> > other direction, and make sure that globally requested pages are
> > uncharged from the subpool's used counter.
> > 
> > Each failed allocation attempt increments the used_hpages counter by
> > how many pages were requested from the global pool. Ultimately, this
> > renders the subpool unusable, as used_hpages approaches the max limit.
> > 
> > The issue can be reproduced as follows:
> > 1. Allocate 4 hugetlb pages
> > 2. Create a hugetlb mount with max=4, min=2
> > 3. Consume 2 pages globally
> > 4. Request 3 pages from the subpool (2 from subpool + 1 from global)
> > 	4.1 hugepage_subpool_get_pages(spool, 3) succeeds.
> > 		used_hpages += 3
> > 	4.2 hugetlb_acct_memory(h, 1) fails: no global pages left
> > 		used_hpages -= 2
> > 5. Subpool now has used_hpages = 1, despite not being able to
> >    successfully allocate any hugepages. It believes it can now only
> >    allocate 3 more hugepages, not 4.
> > 
> > Repeating this process will ultimately render the subpool unable to
> > allocate any hugepages, since it believes that it is using the maximum
> > number of hugepages that the subpool has been allotted.
> > 
> > The underflow issue that commit a833a693a490 fixes still remains fixed
> > as well.
> 
> Thanks, I submitted the above to the Changelog Of The Year judging
> committee.

: -) Thank you for the kind words!

> > Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > Cc: stable@vger.kernel.org
> 
> I'll add this to mm.git's mm-hotfixes queue, for testing and review
> input.

Sounds good to me! I'll wait a bit in case others have different concerns,
but I'll send out a new version which addresses your comments below (and
any future comments) in a day or two.

> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6560,6 +6560,7 @@ long hugetlb_reserve_pages(struct inode *inode,
> >  	struct resv_map *resv_map;
> >  	struct hugetlb_cgroup *h_cg = NULL;
> >  	long gbl_reserve, regions_needed = 0;
> > +	unsigned long flags;
> 
> This could have been local to the {block} which uses it, which would be
> nicer, no?

Definiely, I'll address this in v2!

> >  	int err;
> >  
> >  	/* This should never happen */
> > @@ -6704,6 +6705,13 @@ long hugetlb_reserve_pages(struct inode *inode,
> >  		 */
> >  		hugetlb_acct_memory(h, -gbl_resv);
> >  	}
> > +	/* Restore used_hpages for pages that failed global reservation */
> > +	if (gbl_reserve && spool) {
> > +		spin_lock_irqsave(&spool->lock, flags);
> > +		if (spool->max_hpages != -1)
> > +			spool->used_hpages -= gbl_reserve;
> > +		unlock_or_release_subpool(spool, flags);
> > +	}
> 
> I'll add [2/3] and [3/3] to the mm-new queue while discarding your
> perfectly good [0/N] :(
> 
> Please, let's try not to mix backportable patches with the
> non-backportable ones?

Oh no! Sorry, this is my first time Cc-ing stable so I wasn't aware of the
implications. In v2, I'll send the two out as separate patches, so that it's
easier to backport. I was just eager to send out 2/3 and 3/3 because I've
been waiting for a functional hugetlb patch to smoosh these cleanups into.

I'll be more mindful in the future.

Thank you again, I hope you have a great day!!
Joshua

