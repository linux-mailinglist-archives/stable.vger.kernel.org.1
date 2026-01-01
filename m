Return-Path: <stable+bounces-204402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B14CECB52
	for <lists+stable@lfdr.de>; Thu, 01 Jan 2026 01:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 321843009406
	for <lists+stable@lfdr.de>; Thu,  1 Jan 2026 00:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FCD211290;
	Thu,  1 Jan 2026 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhPVW7U5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B049F19ABC6;
	Thu,  1 Jan 2026 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767227552; cv=none; b=eF8vzDcYpKnaxLDIs8eysl9Wpbahmueg9/A8UuCvWcfdwuxENObHkCspS4hHw/5MjiMSqObyV8TImh8bGEWsjVIsYK93/cPV3DgW9xSaHbyCY8aDXa3VOrlT6/QQt5NO4V+R5hdyOA17bHvORC6HK310ym4vBLOtiCa8qUcw1AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767227552; c=relaxed/simple;
	bh=k8MuGUV6krS1djDhkLddMbuWQjOZXzq/iMN57+HfM8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q71q9U9OxF43xmqhFo+GihG7W+1GvBTnNk9NADN/0/KAbm+U+gWrICUafAdvO/FeK/8cL6OC8pRkUihLe4Dm9+huKe8NMU0WmowFmFHeCTTK+ktyZ4IaVYyMx+ZftUysPamal3aZ7K1tO3OCXEkTzjIbvOI/x1ZZU4VDdfjKNA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhPVW7U5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56CBC113D0;
	Thu,  1 Jan 2026 00:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767227551;
	bh=k8MuGUV6krS1djDhkLddMbuWQjOZXzq/iMN57+HfM8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XhPVW7U5XZOD+IsSMMuKz4Zc9IrWo90xQkGrMVtJeIQF4yXv+IWZQPQCRAI+GZ6Jv
	 NSaxHLzKEjdiB3lx3o4YT/1XlEyUt2cSzPPlB64uIcOuvuZEQfM0UoUmvkY66msLht
	 DZrm3YNe2UH3RK5lcXZkHWMpkVR3STPSTuHQx9Brmo+5Um0QGyfLL30wyhn4+Uvbnu
	 LHPX9InCYpIhkUq+WFTdyxc688vrvFxncRe4+mKfN5hiG1S3PmQGDmIMsSFQMdfgPf
	 KEUqGgclXIg4O2gF4wjrio0F3gdeNC8egLMDFTVB2KyQA3hK4kAntCIxNc1B7PIxx9
	 2rJRkXKKBe+BQ==
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
Date: Wed, 31 Dec 2025 16:32:26 -0800
Message-ID: <20260101003227.84507-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231074638.2564302-1-pbutsykin@cloudlinux.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 31 Dec 2025 11:46:38 +0400 Pavel Butsykin <pbutsykin@cloudlinux.com> wrote:

> crypto_alloc_acomp_node() may return ERR_PTR(), but the fail path checks
> only for NULL and can pass an error pointer to crypto_free_acomp().
> Use IS_ERR_OR_NULL() to only free valid acomp instances.
> 
> Fixes: 779b9955f643 ("mm: zswap: move allocations during CPU init outside the lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavel Butsykin <pbutsykin@cloudlinux.com>
> ---
>  mm/zswap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 5d0f8b13a958..ac9b7a60736b 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -787,7 +787,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
>  	return 0;
>  
>  fail:
> -	if (acomp)
> +	if (!IS_ERR_OR_NULL(acomp))
>  		crypto_free_acomp(acomp);
>  	kfree(buffer);
>  	return ret;

I understand you are keeping NULL case to keep the old behavior.  But, seems
the case cannot happen to me for following reasons.

First of all, the old NULL check was only for crypto_alloc_acomp_node()
failure.  But crypto_alloc_acomp_node() seems not returning NULL, to by breif
look of the code.  And the failure check of crypto_alloc_acomp_node() is
actually doing only IS_ERR() check.

So, it seems IS_ERR() here is enough.  Or, if I missed a case that
crypto_alloc_acomp_node() returns NULL, the above crypto_alloc_acomp_node()
failure check should be updated to use IS_ERR_OR_NULL()?


Thanks,
SJ

[...]

