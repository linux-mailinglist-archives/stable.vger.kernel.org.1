Return-Path: <stable+bounces-172865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C333AB3447D
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 16:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E2C188291D
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 14:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45756225791;
	Mon, 25 Aug 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9euI3nD"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CD22E63C;
	Mon, 25 Aug 2025 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133323; cv=none; b=mJzIjv+6Sni4eFxXaLzCf1KnlqVUca2m5a7K2douPbc9OE1VEo4U2siPig6YV7OOvZfVfR9Q7+WbwUTjZXviNfFFVt0nmrEKePuukRF3TCjd8LCrx/S2q8hKgSUuSXviqAenmfdxE5cu1uciXyttc8Ww0UZ0epwTHnu7G2f85BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133323; c=relaxed/simple;
	bh=6sFO7rT4Ru4cNwi2avrTSEgT/GSxCZcL3d0s9oT6jyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvqtfdCbAsVlIJEqGssZMg/8Rksa5ev2AHIrGfHEG+lbzgor1g75f995gEBqHMyxgWmaBbhmJy2qjSUuIjb51XN6GisP37uBc0cqtOyzUFLa7JIPyNgNFFBIq2WNKcHOoQ6fJq+RSYRfsVOCRuWEwDGI/ruGatMjDK2pkiUuEZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9euI3nD; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d603b674aso31400807b3.1;
        Mon, 25 Aug 2025 07:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756133320; x=1756738120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaBi4h9qQ27W+z3VVAxCvJfwUOkIuGF9RWMFwT6gLh0=;
        b=U9euI3nDbb9j9EsAOBI5d9ltdzPIAWjB8elGrSbjYAo8/4D12YbZdkevVsVfkX/CJT
         zMuVkvbDM7VcvaSJQoaWK2fBhUjD1DF/7Y/FZj6g8+zASTHlSh8o8ChZwV3rQDiqJdby
         UkmnaVtlS61U9FWqgdbfF2oD6q8BO7UXrwdmi0CLWb9oZMbr6GGXg1Cq03zPnhZ4spHp
         CRBV+Z6MQDNpPrYA+ahQ9FYUFC3BrP2D605+MBXiPpmUCrtaQKwegL49j0bTnMWAPXts
         sOw0+QeqDp/8GGMqlSt52b3bhn96czd2rBJH5DbCLWQFJFTPPaRnXzwcYSHUP/bQL0yx
         l5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133320; x=1756738120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaBi4h9qQ27W+z3VVAxCvJfwUOkIuGF9RWMFwT6gLh0=;
        b=KjZe6//6Cn85LAJe2sM60gaQFk9q1zKMtwDxv/+XaCRL0jQxrIL9RR5u+8VYzKHdxD
         muUgGnJazsLhFw8iWbq8eSBmvIFwHE7IDsGXeP7ilhZ6fwFsLx1J3q598CHdMjQpa2gd
         x4SyUlcMyoAgd/VBd6miq4AMTRFy9waERFdLHmgN9XU69he8uS+JLAu48P1zz2o27gHI
         RX+kdP0XU58tmi9SdHvAFdiUNiql9tiHi8ySIPDac+9U+p/UCV+HtPs+vT2bjtNuccBS
         RSAUg0fTj3KCQp/tQBvZ1ruL0034rXTpADjX1QpvQ/+8IjrKkkv+tq7FETKO57yNrnbK
         H2AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVepWN+7SSU0mSoYP6/vWdH1/t1gsZmYC3Qvpw/6tN9skhTrUvzP9RelGNxTYb1KdPS7LKHgxsh@vger.kernel.org, AJvYcCW93aqxPqblD/AfyIM9YDW/lxy/vcPblX501qaa6NTFFj4YWk6X+AoHgqf+d8YOVLWONDt3olmvHTj5fJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoNNyHWrJykTliKfy+g+VEgKfY5BwteTsvblQqMeez5EGjZGsO
	4z6a0cUydUN5J8VYvUbGFo+/k3tdDkgnkjfmnQy+shFpQ0DJT8GZXxDH
X-Gm-Gg: ASbGncuAhoItfI7/NdyouzJHXRS+dV1thvYAZGUlMVIVOHxcurlA37/m1uWuxpdk5B2
	uhfQroLh/5qilWSdqMM2gQmEMyYJRB7W9BSr9fCW8IP5Mpw8zIjOXcKodk437JMXlduglhiuzHG
	qDbBGQtHlVoQWUWu1Gw20UQEDi+lG302xJtrbZtz+mlsitR39G2mDO7+Scf+JztEiNmQ0rfHSaX
	Lq8U3fT5+e4QAGGYLmRHF6j/9dyXFgPZGRBS4hjvRcgC1pcS7rf5Gar8+cKDUBc8p0gguq2iXcn
	CTD8dl8jpJRx4gunuKOpEy+b+PT7i2UHVts9XtMovMSGB3FHa92NVzgCFYfWYb6hVzD4KpLq1jp
	oQjgGOfOycLos0gwugC8u+bY8+r2w2ReqCB+Z4vf/y+o5Z6lfduiSeA==
X-Google-Smtp-Source: AGHT+IFX6t2g2RWBiaV9FhXCN/YWOlqlLXpi8FKYaFoeKCWyWmCmS3h7Sg/R2hd57jDnYX+t3o6YZQ==
X-Received: by 2002:a05:690c:a87:b0:720:378:bed6 with SMTP id 00721157ae682-7200378d942mr77175157b3.41.1756133320165;
        Mon, 25 Aug 2025 07:48:40 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:43::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff173633esm17768947b3.27.2025.08.25.07.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:48:39 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: vbabka@suse.cz,
	akpm@linux-foundation.org,
	cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	harry.yoo@oracle.com,
	glittao@gmail.com,
	jserv@ccns.ncku.edu.tw,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/slub: Fix cmp_loc_by_count() to return 0 when counts are equal
Date: Mon, 25 Aug 2025 07:48:36 -0700
Message-ID: <20250825144838.4081382-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250825013419.240278-2-visitorckw@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 25 Aug 2025 09:34:18 +0800 Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> The comparison function cmp_loc_by_count() used for sorting stack trace
> locations in debugfs currently returns -1 if a->count > b->count and 1
> otherwise. This breaks the antisymmetry property required by sort(),
> because when two counts are equal, both cmp(a, b) and cmp(b, a) return
> 1.
> 
> This can lead to undefined or incorrect ordering results. Fix it by
> explicitly returning 0 when the counts are equal, ensuring that the
> comparison function follows the expected mathematical properties.
> 
> Fixes: 553c0369b3e1 ("mm/slub: sort debugfs output by frequency of stack traces")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  mm/slub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 30003763d224..c91b3744adbc 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -7718,8 +7718,9 @@ static int cmp_loc_by_count(const void *a, const void *b, const void *data)
>  
>  	if (loc1->count > loc2->count)
>  		return -1;
> -	else
> +	if (loc1->count < loc2->count)
>  		return 1;
> +	return 0;
>  }

Hello Kuan-Wei,

This is a great catch! I was thinking that in addition to separating out the
== case, we can also simplify the behavior by just opting to use the
cmp_int macro, which is defined in the <linux/sort.h> header, which is
already included in mm/slub.c. For the description, we have:

 * Return: 1 if the left argument is greater than the right one; 0 if the
 * arguments are equal; -1 if the left argument is less than the right one.

So in this case, we can replace the entire code block above with:

return cmp_int(loc2->count, loc1->count);

or

return -1 * cmp_int(loc1->count, loc2->count);

if you prefer to keep the position of loc1 and loc2. I guess we do lose
some interpretability of what -1 and 1 would refer to here, but I think
a comment should be able to take care of that.

Please let me know what you think. I hope you have a great day!
Joshua

