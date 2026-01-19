Return-Path: <stable+bounces-210363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE3ED3ACB9
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 15:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F82A302ECA4
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 14:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ADB37BE62;
	Mon, 19 Jan 2026 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T9sVnaHu"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236BF35BDAB
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833814; cv=none; b=kBLKvUJ53qG3Lfd2oWI+gP4oLZUxSFnm/QqB4a2zpkjKR9PwkZRvLv6OVJ77JphTTxo5bRo32hYNdyXgNDnRJAAGzEjQVoTK8fCE9NK/7QF4TZvg8om373/eCLE/yufy4lcshjtCYBTxo7mo8H+THOWjFbYVPDBxgVqKVkLJVFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833814; c=relaxed/simple;
	bh=r74QiyMl8GoaFf+6OYnD/LWemt+AkwY8ZRYKU002DU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0A6knP2ZRG8FEp8QLKZvXMWh+TJbhR9WQuqBfkHwrSXuEQfZsBds6B4r5+9t1mUXZQO+KNbJR4/U8n9g0eIr4NsiK9UodrKsJM6TY11UdVFx6rXS+U9+DqSgHidVKxHh3VWevOGmjDHj3qIX2cJw2zORGFF16/h3G7TLdcaQEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T9sVnaHu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4801c632109so1759375e9.2
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 06:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768833810; x=1769438610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RR1qVFyAeEiUAQEUT2CsZi2+KLdkWNNKKDhRLKnjZFk=;
        b=T9sVnaHu8HKWV2nja53/mX2sxq96PvFugzlb4RpV5reizs93t8+gWjvZWzrH7TN99K
         Flxj+SROdLZbU+H1TQG1orn62gu2C8PRGyAgVjx/XpSiQqnGNV1wHubHRQjOO4sX26bJ
         xij53RxZpKoqYadazfTMKZ1Oj//QIdHyf6sy5pJCq89wGYgHPJe77f5dAdXqdcJAX1ao
         gt4Fl/OJX0kr5s074MKHukruJ2jDZtRJCGsCF6iRTwZjzl4SkyIlgQA7bRP2meF4ztHg
         zk7Zfa+mhjILlKjYNVC90si0Er4Kwx7CEFv4xeEXvU+jKV7QwB6MuCNFERIKJC9ni6of
         3NYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768833810; x=1769438610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RR1qVFyAeEiUAQEUT2CsZi2+KLdkWNNKKDhRLKnjZFk=;
        b=gyc4uwmpMHSlyjGvsrv0YPlDo8VcYvz8pT/+Vg1hk4hg0kkGa9b0IXcHoOFuNCPy8U
         oQgu/ElqrjcNb5eVAA0uo8ptEPoRZEzJgq2yGaMePl9Ky9LRbTxe6uvIhnbHr3k1hy+F
         NAw8cIyGd9eYGA8paPlJbEHEBCLQbbtN5NAsw2ILC3YpSLX+XWnqti6NoKck1ned3Yai
         5kpUsip2/D9amT8Q2d+p41Zaoq47hX9/wh9HbOzefoVIPvPSYmiAPkKU1gn8kA1KeMU7
         0aPmizl7m0PyMTXXK7UYdadIZjRkT7hqvs6siRWMJ8/R4Qrvz2ZLOwE6ZogPPLnmygXl
         /3cg==
X-Forwarded-Encrypted: i=1; AJvYcCW1CLbTFd1W6RBcObEPnx2YJ8EsDyYIpSEzzIfQo1qcgMJGVZKFhb5mW0FxoW0dTFXJiTi+sHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPfW1eYN5X8e3MHpxOZmBklbwSLPfCgykCZBS4WzPoawaH4OUL
	kJglVpOVE5f5LDzlsZtDMRP29oPlfPKzrLaa53kCyzDrgY8ULXG7v+APh8rqEYBCEx4=
X-Gm-Gg: AY/fxX6qUxAk48cAG0CGP0s9OoCsh+qQSbFePjQVq8QBwv8jLw5BS8kn0FAGj8iuAod
	5cn0LQzE0oslpjTLpBtlnFHJjRAoqnjNTOWc3AavwRpvdxMQJtLrfq1tXyN3DxAVFzlfA+EpxAf
	LWpadI0vrTrQtFxufusC/wdcGaWK2RncHsUFtxfM0alYqN3+7Q6zXegrowV6RQkdpm4l0UHN4La
	VHOTVuxIueNrsI+p3vkuvZSrpuDgjVqkIvHqvuTJzAFnCLENQTmuoT+XHaJoBamXuJSZY59zo21
	AWAt0RJx58dM4HPPWeKHgm4ow9Ib7tEA9t+WF7kCym8OLHSk4o6s+Iwzpj0aZhM9ParjcGgRUJL
	wZVwT6KzCOKnT5JJ5JITf4iXuPGkgHRv/VjrfhdH0orHyzlIu4TLezLqmDcHnqEMnXyB/8T2AmN
	OAbRUY19NkYw==
X-Received: by 2002:a05:600c:4f4f:b0:475:d7b8:8505 with SMTP id 5b1f17b1804b1-4801e3743famr93063515e9.7.1768833810529;
        Mon, 19 Jan 2026 06:43:30 -0800 (PST)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dedacsm97891305ad.58.2026.01.19.06.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 06:43:29 -0800 (PST)
Date: Mon, 19 Jan 2026 22:43:26 +0800
From: Heming Zhao <heming.zhao@suse.com>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: markus.elfring@web.de, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ocfs2: fix NULL pointer dereference in
 ocfs2_get_refcount_rec
Message-ID: <5bflve5fog7jreyjzn4po47t2wzd6vomsmlkd6km44joogcybl@6vd2h5orgwge>
References: <cfd0e0eb-894e-48c7-948e-9300a19b9db7@web.de>
 <20260118190523.42581-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118190523.42581-1-jiashengjiangcool@gmail.com>

On Sun, Jan 18, 2026 at 07:05:23PM +0000, Jiasheng Jiang wrote:
> In ocfs2_get_refcount_rec(), the 'rec' pointer is initialized to NULL.
> If the extent list is empty (el->l_next_free_rec == 0), the loop skips
> assignment, leaving 'rec' as NULL and 'found' as 0.
> 
> Currently, the code skips the 'if (found)' block but proceeds directly to
> dereference 'rec' at line 767 (le64_to_cpu(rec->e_blkno)), causing a
> NULL pointer dereference panic.

Do you have reproduction steps to support your analysis?

there are two types of 'rb': leaf or tree.
the check 'if (!(le32_to_cpu(rb->rf_flags) & OCFS2_REFCOUNT_TREE_FL))'
handles leaf case and returns to the caller.
the subsequent code handles the 'tree' type, therefore, in theory,
el->l_next_free_rec should be ">= 1", and the execution should enter the
for-loop to assign the 'rec'.

Thanks,
Heming

> 
> This patch adds an 'else' branch to the 'if (found)' check. If no valid
> record is found, it reports a filesystem error and exits, preventing
> the invalid memory access.
> 
> Fixes: e73a819db9c2 ("ocfs2: Add support for incrementing refcount in the tree.")
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
> Changelog:
> 
> v1 -> v2:
> 
> 1. Add a Fixes tag.
> ---
>  fs/ocfs2/refcounttree.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
> index c92e0ea85bca..464bdd6e0a8e 100644
> --- a/fs/ocfs2/refcounttree.c
> +++ b/fs/ocfs2/refcounttree.c
> @@ -1122,6 +1122,11 @@ static int ocfs2_get_refcount_rec(struct ocfs2_caching_info *ci,
>  
>  		if (cpos_end < low_cpos + len)
>  			len = cpos_end - low_cpos;
> +	} else {
> +		ret = ocfs2_error(sb, "Refcount tree %llu has no extent record covering cpos %u\n",
> +				  (unsigned long long)ocfs2_metadata_cache_owner(ci),
> +				  low_cpos);
> +		goto out;
>  	}
>  
>  	ret = ocfs2_read_refcount_block(ci, le64_to_cpu(rec->e_blkno),
> -- 
> 2.25.1
> 
> 

