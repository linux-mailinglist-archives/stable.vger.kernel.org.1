Return-Path: <stable+bounces-204482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60010CEEC6F
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 15:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B454300F312
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 14:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E870A21ABD7;
	Fri,  2 Jan 2026 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXgNzwE1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A590F20E005;
	Fri,  2 Jan 2026 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767364793; cv=none; b=lByCAXmaTwuVA2ML2EJNsVOPWiqRV9YyMh4dpbIj//e/UE64YdNxeQ6VAZDOI3Zw3XHnOcK4GajZGUUJT8iRtQrI6lNkaN7/zbs8B4wAE9Bhzj3zndaKpGu0TC/Inl4PQ25gLnlATmW3thQbydyVtCJ4cO02d4isA7k0KKj4a8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767364793; c=relaxed/simple;
	bh=NFZVoW1OohheL/BZDD6iCVBR2TX6b8zaD6eMYXzwGC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0oPmbnwpZI7Rl2DKGlxVFjztVTdb/tM/4IScLeuUXWwb6pbJMG80jTGJcNv1s5qhWt0CzoloLIJFvY+cxEIVQyiLYMaNypyf9yGmwU8xSiI3xfz7P+MU9v6kKNkMT2zDGih6dsurceKPMlZtLEztiWIvCYohJZEbxaAq6S+NKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXgNzwE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388D9C116B1;
	Fri,  2 Jan 2026 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767364793;
	bh=NFZVoW1OohheL/BZDD6iCVBR2TX6b8zaD6eMYXzwGC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RXgNzwE1SI2gpupR21FN6yuKt9r1m+RG+oRnu4dmMGaqYzlROAwmSbKIxdJyAAY8y
	 A2qostlhny+u7wwk9+qnCK+iHV6Rg8x6+vkCkqvPsZRE5WGcs7IvAuD5aNxb9+aKsU
	 tja4L1XojxOxK6owOsA+H09OrqC91aszlbF2o8Zuog9sxHD4Ywd3pkvuMAwJQb3wKC
	 nvKbyPM13uaCtR4yArs7ZCrEx1iCFkdIwrjaRPyordGYipEg/86e5AVKfFq5eRy5A0
	 FTCyCwWMNQUSUQCHwYB3pVrP/KA+5xQXztKFWvrX9wF9inBePMp1gFnnpCQM/1tvMn
	 qrSiKGdQVvMlg==
From: SeongJae Park <sj@kernel.org>
To: Pavel Butsykin <pbutsykin@cloudlinux.com>
Cc: SeongJae Park <sj@kernel.org>,
	hannes@cmpxchg.org,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/zswap: fix error pointer free in zswap_cpu_comp_prepare()
Date: Fri,  2 Jan 2026 06:39:44 -0800
Message-ID: <20260102143945.52356-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <baefc4db-2e2f-4b20-b44c-eeaadfaa1c1e@cloudlinux.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2 Jan 2026 10:51:01 +0400 Pavel Butsykin <pbutsykin@cloudlinux.com> wrote:

> On 1/1/26 04:32, SeongJae Park wrote:
> > On Wed, 31 Dec 2025 11:46:38 +0400 Pavel Butsykin <pbutsykin@cloudlinux.com> wrote:
> > 
> >> crypto_alloc_acomp_node() may return ERR_PTR(), but the fail path checks
> >> only for NULL and can pass an error pointer to crypto_free_acomp().
> >> Use IS_ERR_OR_NULL() to only free valid acomp instances.
> >>
> >> Fixes: 779b9955f643 ("mm: zswap: move allocations during CPU init outside the lock")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Pavel Butsykin <pbutsykin@cloudlinux.com>
> >> ---
> >>   mm/zswap.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/zswap.c b/mm/zswap.c
> >> index 5d0f8b13a958..ac9b7a60736b 100644
> >> --- a/mm/zswap.c
> >> +++ b/mm/zswap.c
> >> @@ -787,7 +787,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
> >>   	return 0;
> >>   
> >>   fail:
> >> -	if (acomp)
> >> +	if (!IS_ERR_OR_NULL(acomp))
> >>   		crypto_free_acomp(acomp);
> >>   	kfree(buffer);
> >>   	return ret;
> > 
> > I understand you are keeping NULL case to keep the old behavior.  But, seems
> > the case cannot happen to me for following reasons.
> > 
> > First of all, the old NULL check was only for crypto_alloc_acomp_node()
> > failure.  But crypto_alloc_acomp_node() seems not returning NULL, to by breif
> > look of the code.  And the failure check of crypto_alloc_acomp_node() is
> > actually doing only IS_ERR() check.
> > 
> > So, it seems IS_ERR() here is enough.  Or, if I missed a case that
> > crypto_alloc_acomp_node() returns NULL, the above crypto_alloc_acomp_node()
> > failure check should be updated to use IS_ERR_OR_NULL()?
> > 
> 
> We have 'goto fail;' right before crypto_alloc_acomp_node() for the case 
> where kmalloc_node fails to allocate memory. In that case, 'acomp' will 
> still be initialized to NULL.

Ah, you are right.  Thank you for fixing this.  Please feel free to add

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

