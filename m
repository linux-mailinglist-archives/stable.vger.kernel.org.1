Return-Path: <stable+bounces-204179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1687DCE89FC
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 04:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1C1A3010AA7
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 03:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF972D7D41;
	Tue, 30 Dec 2025 03:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqEvotQ7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDD522301
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 03:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767064301; cv=none; b=AlOnDMdV4QcoLw1c3esXH3uxfge9P4Nd0phQ11Tj4KO4x2LhrjaHxicztFdyQ/ZGlFzhLG/U6uiy/EW2gzWT5kknZW8KvaWjEVicLnpSp4NGOBy1FvRVogY9MzEsBz1sAVpT0FBKa1gmlcXGpyD1rodyX7exJ+RK7ZAtoY/lH+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767064301; c=relaxed/simple;
	bh=7K67TIZEy2U0U3DZWra3k89yWWv897OTi9G58DY3XmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4v8uCBeXDvSPKn7NuxEiLcfZ0wudK+SuK+kaNfVQ9I8NXInBaeg5LY+Xg0l9qi7P+eD9aLFQVPbesg6UWF00Db+3OgAfd7kMSiRCH/EQsaeES3t9VE502ysC+BFsK5UM46FfgiiGDoWmrLuE2kx2GN2osiFPONNswHV0ih4QqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqEvotQ7; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64b791b5584so13897265a12.0
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 19:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767064298; x=1767669098; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DiRhcRlbpFOBBK2JpTcqKi0d0812oAOeRGVTOwYQuA=;
        b=WqEvotQ7sAI7SOEEB+jlHHjMdKr4j6Fq/lwj5E4a7rqY9LD7fOv4/tWJVubtGNvcvI
         J0/Nfmb9KchbtyZzD8VcC1CiEzKB5y9NUxbDDKBvl5utZuN8RV2jXuLSOa736q6N1gUW
         XBDocDcLXlK3GsnNpkwW33udI5hXPmBJK3uM1VGC4VZuxaIJeRcaFntfDKRgz4I6X6eT
         ScPgAab3769dVxy41rq+f3WYS/86Y34Vh2jxrT6dgm9/EbMBg5h1+hcLLxRXMp9Pnw8J
         xOhf3fwoPWF084GuC7xVqNKvJKM0FJqr5tPK/DZvo95sUQebWkQBuJya9LmU1QFept2a
         L+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767064298; x=1767669098;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DiRhcRlbpFOBBK2JpTcqKi0d0812oAOeRGVTOwYQuA=;
        b=w8klUm6I3kA8TrDJ8kTdKc501ug0xmnXYP/VrcSGAJOzAxGvHzrMdc5Ay9MCPZsVAy
         zt9bGuuZ5kOEDa8rK57fjbkyUozS+rI0/tw0lN9y9MLk9gSYOMxy0CFMz/AxLVsshoII
         nuVfyKaJHYSlVTlYmUXOhk4P3pfulHkTc0+YZN5wXwnJBIv7Q34IDCRfRdqml+l7oxJN
         sSFyZGeruL5uxVHqp53zXS1qkX1E7vZl/v3yvGvIWkoR/2SWEg5rjp286iZdKovzEKAy
         tw1t1DAnyWsqT7JLLmCLgDw4R2aAfYQQvqJHa2S1W+FgEATOMDO29viA18SpUoVP+gNK
         fjXg==
X-Forwarded-Encrypted: i=1; AJvYcCXQnaMTOMIwm9waoOBOcxH3vES/na+8toK3v8cyY+35QmaPqA/hldTUSgdnE8hWrW4uMSpuVFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXYP3Esr33CJc5rAK4+4upz5CHrOeOYqyqWOOQjpkDs21ZLNzw
	g9JR74UuPjW3jjWWq3NgjfM01/yjFArFbtcrPLPlUb3WzxBkM8iy/IAK
X-Gm-Gg: AY/fxX7rcfc2LaXWD/18STxksTi9TONgqaqpplmFjDi+96LxyIIJXtQUzkf+9iHUMnQ
	iWgSrb0y+9Tz8oJ8s0db+8BhK+WBGn6TGQllijJcPTQLMlKsstrGQo5J8lDOYkxuEowQHi/Ldx1
	XO7Su6SR+7NP45cUdfBbBNK1oEr9iJWam/WFgDqcsZlFT0HkPtFjzYIp027i8y0s5sDT1nVhjUr
	ZJXO3A2B90NcVsRaNaCvsmlaqcE0CKDX0+lm8f3KwP0Fu1HmuxDrEvVOTaGFixl3cRSuKZBkRMW
	pKhnkoED3uIL9+4SVSHi0zT0ddkQ1t6klXizXyWq6jPgtP2mF/OBFi72Km9zBgePXCdkabErKCo
	7FrEzG05oF/z54Wcr+qgKlgN8sgI9iH4QF/kEZcV2pEi5yhEqL77m5NMDv1ayyEfUdZjDSWrW0V
	X1pDQF0uS2rKUAsyZXlRVI
X-Google-Smtp-Source: AGHT+IHsUQNpWUEjNx6KW26F1I0kenUS17X45EJ8GhfnrGLAC5rT7euFwmFER4DhdRQ5jKqDuPLVXw==
X-Received: by 2002:a05:6402:520c:b0:64d:46f:343 with SMTP id 4fb4d7f45d1cf-64d046f075bmr27067918a12.12.1767064297563;
        Mon, 29 Dec 2025 19:11:37 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b91599721sm33317924a12.26.2025.12.29.19.11.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Dec 2025 19:11:37 -0800 (PST)
Date: Tue, 30 Dec 2025 03:11:35 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: gregkh@linuxfoundation.org
Cc: richard.weiyang@gmail.com, akpm@linux-foundation.org, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com,
	lance.yang@linux.dev, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
	stable@vger.kernel.org, ziy@nvidia.com
Subject: Re: FAILED: patch "[PATCH] mm/huge_memory: merge
 uniform_split_supported() and" failed to apply to 6.18-stable tree
Message-ID: <20251230031135.efpejaosso23ekke@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <2025122925-victory-numeral-2346@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025122925-victory-numeral-2346@gregkh>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Dec 29, 2025 at 01:33:25PM +0100, gregkh@linuxfoundation.org wrote:
>
>The patch below does not apply to the 6.18-stable tree.
>If someone wants it applied there, or to any other stable or longterm
>tree, then please email the backport, including the original git commit
>id to <stable@vger.kernel.org>.
>
>To reproduce the conflict and resubmit, you may use the following commands:
>
>git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
>git checkout FETCH_HEAD
>git cherry-pick -x 8a0e4bdddd1c998b894d879a1d22f1e745606215
># <resolve conflicts, build, test, etc.>
>git commit -s
>git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122925-victory-numeral-2346@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..
>
>Possible dependencies:
>
>

Hi, Greg

This one is not a fix to some bug.

We found a real bug during the mail discussion, which is 

    commit cff47b9e39a6abf03dde5f4f156f841b0c54bba0
    Author: Wei Yang <richard.weiyang@gmail.com>
    Date:   Wed Nov 19 23:53:02 2025 +0000
    
        mm/huge_memory: fix NULL pointer deference when splitting folio

It looks has been back ported to 6.18.y and 6.12.y.

>
>thanks,
>
>greg k-h
>
>------------------ original commit in Linus's tree ------------------
>
>>From 8a0e4bdddd1c998b894d879a1d22f1e745606215 Mon Sep 17 00:00:00 2001
>From: Wei Yang <richard.weiyang@gmail.com>
>Date: Thu, 6 Nov 2025 03:41:55 +0000
>Subject: [PATCH] mm/huge_memory: merge uniform_split_supported() and
> non_uniform_split_supported()
>
>uniform_split_supported() and non_uniform_split_supported() share
>significantly similar logic.
>
>The only functional difference is that uniform_split_supported() includes
>an additional check on the requested @new_order.
>
>The reason for this check comes from the following two aspects:
>
>  * some file system or swap cache just supports order-0 folio
>  * the behavioral difference between uniform/non-uniform split
>
>The behavioral difference between uniform split and non-uniform:
>
>  * uniform split splits folio directly to @new_order
>  * non-uniform split creates after-split folios with orders from
>    folio_order(folio) - 1 to new_order.
>
>This means for non-uniform split or !new_order split we should check the
>file system and swap cache respectively.
>
>This commit unifies the logic and merge the two functions into a single
>combined helper, removing redundant code and simplifying the split
>support checking mechanism.
>
>Link: https://lkml.kernel.org/r/20251106034155.21398-3-richard.weiyang@gmail.com
>Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>Reviewed-by: Zi Yan <ziy@nvidia.com>
>Cc: Zi Yan <ziy@nvidia.com>
>Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
>Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>Cc: Barry Song <baohua@kernel.org>
>Cc: Dev Jain <dev.jain@arm.com>
>Cc: Lance Yang <lance.yang@linux.dev>
>Cc: Liam Howlett <liam.howlett@oracle.com>
>Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>Cc: Nico Pache <npache@redhat.com>
>Cc: Ryan Roberts <ryan.roberts@arm.com>
>Cc: <stable@vger.kernel.org>

The Fixes tag and cc stable is not necessary here.

We didn't communicate well with Andrew, sorry for the confusion.

>Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>
>diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>index b74708dc5b5f..19d4a5f52ca2 100644
>--- a/include/linux/huge_mm.h
>+++ b/include/linux/huge_mm.h
>@@ -374,10 +374,8 @@ int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list
> 		unsigned int new_order, bool unmapped);
> int min_order_for_split(struct folio *folio);
> int split_folio_to_list(struct folio *folio, struct list_head *list);
>-bool uniform_split_supported(struct folio *folio, unsigned int new_order,
>-		bool warns);
>-bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
>-		bool warns);
>+bool folio_split_supported(struct folio *folio, unsigned int new_order,
>+		enum split_type split_type, bool warns);
> int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
> 		struct list_head *list);
> 
>@@ -408,7 +406,7 @@ static inline int split_huge_page_to_order(struct page *page, unsigned int new_o
> static inline int try_folio_split_to_order(struct folio *folio,
> 		struct page *page, unsigned int new_order)
> {
>-	if (!non_uniform_split_supported(folio, new_order, /* warns= */ false))
>+	if (!folio_split_supported(folio, new_order, SPLIT_TYPE_NON_UNIFORM, /* warns= */ false))
> 		return split_huge_page_to_order(&folio->page, new_order);
> 	return folio_split(folio, new_order, page, NULL);
> }
>diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>index 4118f330c55e..d79a4bb363de 100644
>--- a/mm/huge_memory.c
>+++ b/mm/huge_memory.c
>@@ -3593,8 +3593,8 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
> 	return 0;
> }
> 
>-bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
>-		bool warns)
>+bool folio_split_supported(struct folio *folio, unsigned int new_order,
>+		enum split_type split_type, bool warns)
> {
> 	if (folio_test_anon(folio)) {
> 		/* order-1 is not supported for anonymous THP. */
>@@ -3602,48 +3602,41 @@ bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
> 				"Cannot split to order-1 folio");
> 		if (new_order == 1)
> 			return false;
>-	} else if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>-	    !mapping_large_folio_support(folio->mapping)) {
>-		/*
>-		 * No split if the file system does not support large folio.
>-		 * Note that we might still have THPs in such mappings due to
>-		 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
>-		 * does not actually support large folios properly.
>-		 */
>-		VM_WARN_ONCE(warns,
>-			"Cannot split file folio to non-0 order");
>-		return false;
>-	}
>-
>-	/* Only swapping a whole PMD-mapped folio is supported */
>-	if (folio_test_swapcache(folio)) {
>-		VM_WARN_ONCE(warns,
>-			"Cannot split swapcache folio to non-0 order");
>-		return false;
>-	}
>-
>-	return true;
>-}
>-
>-/* See comments in non_uniform_split_supported() */
>-bool uniform_split_supported(struct folio *folio, unsigned int new_order,
>-		bool warns)
>-{
>-	if (folio_test_anon(folio)) {
>-		VM_WARN_ONCE(warns && new_order == 1,
>-				"Cannot split to order-1 folio");
>-		if (new_order == 1)
>-			return false;
>-	} else  if (new_order) {
>+	} else if (split_type == SPLIT_TYPE_NON_UNIFORM || new_order) {
> 		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
> 		    !mapping_large_folio_support(folio->mapping)) {
>+			/*
>+			 * We can always split a folio down to a single page
>+			 * (new_order == 0) uniformly.
>+			 *
>+			 * For any other scenario
>+			 *   a) uniform split targeting a large folio
>+			 *      (new_order > 0)
>+			 *   b) any non-uniform split
>+			 * we must confirm that the file system supports large
>+			 * folios.
>+			 *
>+			 * Note that we might still have THPs in such
>+			 * mappings, which is created from khugepaged when
>+			 * CONFIG_READ_ONLY_THP_FOR_FS is enabled. But in that
>+			 * case, the mapping does not actually support large
>+			 * folios properly.
>+			 */
> 			VM_WARN_ONCE(warns,
> 				"Cannot split file folio to non-0 order");
> 			return false;
> 		}
> 	}
> 
>-	if (new_order && folio_test_swapcache(folio)) {
>+	/*
>+	 * swapcache folio could only be split to order 0
>+	 *
>+	 * non-uniform split creates after-split folios with orders from
>+	 * folio_order(folio) - 1 to new_order, making it not suitable for any
>+	 * swapcache folio split. Only uniform split to order-0 can be used
>+	 * here.
>+	 */
>+	if ((split_type == SPLIT_TYPE_NON_UNIFORM || new_order) && folio_test_swapcache(folio)) {
> 		VM_WARN_ONCE(warns,
> 			"Cannot split swapcache folio to non-0 order");
> 		return false;
>@@ -3711,11 +3704,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> 	if (new_order >= old_order)
> 		return -EINVAL;
> 
>-	if (split_type == SPLIT_TYPE_UNIFORM && !uniform_split_supported(folio, new_order, true))
>-		return -EINVAL;
>-
>-	if (split_type == SPLIT_TYPE_NON_UNIFORM &&
>-	    !non_uniform_split_supported(folio, new_order, true))
>+	if (!folio_split_supported(folio, new_order, split_type, /* warn = */ true))
> 		return -EINVAL;
> 
> 	is_hzp = is_huge_zero_folio(folio);

-- 
Wei Yang
Help you, Help me

