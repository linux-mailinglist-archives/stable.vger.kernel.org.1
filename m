Return-Path: <stable+bounces-169494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A22B25A74
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 06:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997406883B5
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 04:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EB21FBCA7;
	Thu, 14 Aug 2025 04:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zJzVGlIh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED1379FE
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 04:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755145588; cv=none; b=mlR/rZmm2LiBUkRrs8y0kAyqfEwOPPHsGCqyaNIFQdgZqWWVuaUZJRAjRDJL9+8iqbA7gtGUZmFIDnOlhK+roJi1tYzg2KLYR1Hy/tYax8xwPKnh/GitAVpEWDO4N6bSWGXnlG4/xkodJa6g+gQWTDgS7gEAhnlQKJFjeyk+AL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755145588; c=relaxed/simple;
	bh=M+zbR6R1Nm/4pCp0B7gheJGuNDaXY/XrNqF/Pyj8bmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xgynju76i+cXpeQ7zV3KlBpkSucF0pjYKSa+gSacgI9Gph0XqIaOmFctB6H/bnY+bFaN7fzI0cDYvCCCRBO/cRv0PtBwxt4OaMsnZP2uyKWRcR9JbDJ369/MeS+zPvigx9fOFLAZJABEWOtRQntHZg9IDbH4IBNtl/nK+hr/Sms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zJzVGlIh; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e2eb6ce24so524080b3a.3
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 21:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755145586; x=1755750386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Y4+VbSY2gENC6vjJLIhD6H5q5HP7szxm2F2pf2ubmU=;
        b=zJzVGlIhOOZynWHY+t7mRu8y3SWCOAPEcC0ucyRK12R+yWvC05JlQ3kKWYyoFTS4W0
         3Rtv6Iiq4omT8z/bs3GsfWgiDZWRllOvEorxYQyaqYSZBST4JzvcdF7Tkc/HRTy7OqrE
         cPY4tIZwxUWgmIyA9MTBZzOtualAg954lX8N8/6lEkkHfECN1oGAdT4s9WxkGVzE0mam
         1Q8xRe9atpVbOcHoWfEUaMpqA/ouqwq+KvMxpzJu8Ys4nAF5e2i63sW0JRvZZohyarRd
         8gfz8Sa84PUTu8vHnHURHgz1Uf6j93ow6VqxmC9hILfGqwi3SSD1FxJKh8YMCsJvizhd
         7pVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755145586; x=1755750386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Y4+VbSY2gENC6vjJLIhD6H5q5HP7szxm2F2pf2ubmU=;
        b=Q+6jmvn5+/0ym8a6ZVr8fOtb8DdP0dNZtCbTtawUrT7KPqkJweWokvj2ttAStHHPX3
         LRNlUHAtm9Hn+EzVEDIDVDzzU0jbz5Dj1/QcAH6AflDUEfAGr6i0LGvxRmt8x0Yvm+Er
         R0AOKnbbOnX5TSueP55UffGAtFSS3lW1Nzm0WfeTTa44mTChkFE/hVBWMgHgtM7OkDri
         pB6YGqRrwtBTwqND38Mkg3pnAKAa2vhRECWRGKRa7GC92OlaWruK/ggjO7xQEYvnyVrO
         vTzpTxev3sLHUnt5GIqsn7HKS9151iXDeTAuLKbBGtXmoPIEbV4tBAQ1MuqdjOZEtLcV
         dkIw==
X-Gm-Message-State: AOJu0Ywx+2ka/8mVL+VNQNJ6vpQe7Vt0L0i6fZ6+ZOidQ/seCnhekdk+
	hfzL/9qUCp8kKzg+taDG2dUiMh5kEEf+23hCDW96AYCozEhxHF52X78SyUitU7iawPhUEzxbJMM
	80q6p
X-Gm-Gg: ASbGnctG1xPpk/7KMTykyezdB9KJERKQG+SkYKKKy060DOZ8JQicBB0pU36ooFTX3cK
	s/IZTwd01Qyppc7ZQt4S7ox9DlG0sZfEGaVdhSIv+MrPH96HHF3LANJ2hRHfgrbko6VJJtlvzxJ
	5kRN3Je35sckwwvlS0Ka0lctb8jl0K6yAPHgEV65WH7JYb1BhPx0pN//V5Qto9n5ZwRA844SPOq
	jJIJsGZtKEMlsprlnTCAPVaPi+IE3tJWlp/freDttujPAkLkJwYSSCTIyp8reFQH5Kwu6t1DWuB
	q+U3225gb6+QKQh+FyBLExh94JiHmh1h2NsyXqqmollwTsRl9fUwuu3vUVqDQdce7KDXXKuIt3C
	R849SRDJCVYMu7IZ+kp9ZZOogO3GTJPgtrQE=
X-Google-Smtp-Source: AGHT+IHTIvSY9FFJNBppNNZLO9sn/8s0tAcL4Le93FVv9JRJ529BpdCYJLpwI72ZJr0ZEnJN7dNv2g==
X-Received: by 2002:a05:6a00:1304:b0:740:aa31:fe66 with SMTP id d2e1a72fcca58-76e2f8cf708mr2713273b3a.4.1755145585869;
        Wed, 13 Aug 2025 21:26:25 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e2037acf2sm3493102b3a.112.2025.08.13.21.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 21:26:25 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:56:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Baptiste Lepers <baptiste.lepers@gmail.com>
Cc: stable@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: cpumask: Mark CpumaskVar as transparent
Message-ID: <20250814042622.t2qx6mlelntxi77b@vireshk-i7>
References: <20250812144215.64809-1-baptiste.lepers@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812144215.64809-1-baptiste.lepers@gmail.com>

On 12-08-25, 16:42, Baptiste Lepers wrote:
> Unsafe code in CpumaskVar's methods assumes that the type has the same
> layout as `bindings::cpumask_var_t`. This is not guaranteed by
> the default struct representation in Rust, but requires specifying the
> `transparent` representation.
> 
> Fixes: 8961b8cb3099a ("rust: cpumask: Add initial abstractions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>
> ---
>  rust/kernel/cpumask.rs | 1 +
>  1 file changed, 1 insertion(+)

Applied. Thanks.

-- 
viresh

