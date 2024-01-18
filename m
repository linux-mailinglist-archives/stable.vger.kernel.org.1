Return-Path: <stable+bounces-12212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D746D831FBC
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 20:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15FCE1C2381F
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 19:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1890A2E624;
	Thu, 18 Jan 2024 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S3u/Av31"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450092E3FB
	for <stable@vger.kernel.org>; Thu, 18 Jan 2024 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705606155; cv=none; b=BvMsiot+3RT/THopZIatfjt5s7JTGlgwuFAR4xybmD0ngt8nIfxlHxmvUbZIe9pVEavq9ddxn1HRQLbO9pTAsmZqxKegsBgJMRw1KNZOFgPv/3zhBFJ5dIjf8cBSYGkiplpnEX6p3X6qKvYfgtBhOQyb+a34Xum8A+WbLcibMB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705606155; c=relaxed/simple;
	bh=EYGd/BtwuvtD8ZA8Nfy4r9pHo1JatfhJ33J3FjqEQrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ct61CzO4Zjp/xF6ROKaT/yNyl+/DpgNjyWmbvC84wO9Cp8DQ3WWIQR1OJfQorlTTrqzTgM58sWkkznlqUkQDBtAKh7fTJ18tXXLxYFAE2sQdORz06MkmFyLKR8Kl36YukukGTN6zjxowp7v8JeBmTJLG2h6nWXuGVRiLhVeU8GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S3u/Av31; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6db9e52bbccso38608b3a.3
        for <stable@vger.kernel.org>; Thu, 18 Jan 2024 11:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705606152; x=1706210952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+iomTbXqRTjibxPrZcFIaAB8B6frVBWEtPfgQV/mc1o=;
        b=S3u/Av314bbOChT4eb5WgE0aLJdxWthB6iKAfRqC1CA59rt1pW5unaFdmlBfnJeedP
         cjKM1qDTXCCKEWOWQ/gpWvnQ1lF68ASBYjP29kT5H8JdTUCwFmc6VyQb2X/vmXrXMwxs
         UJ8TaYXJmwBZZm1QPVI9I83uLnO2T05RK1mFQ5Z+KCub5WGV8YClTU0LrROXS66DJPK4
         vOZaoZOi84i22Fc8CIFEoz+yAafYtyh2QGmJbTMtxyFbkFHqyEhSYwRSfK88d/dUS3Q7
         BXg+rS7pRXpCypYQZy9KBWSoi2d58knqvFw0c94rEngi/mNKSBCm1cI6S9pyvHwFcXrh
         U77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705606152; x=1706210952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iomTbXqRTjibxPrZcFIaAB8B6frVBWEtPfgQV/mc1o=;
        b=kR2WXHbCvHyY1JJSqsRb7/PE9oe4rGhz/tMo/eEZlQoyGdu4KRzKyXtGDZRbR0aMaL
         KaTb8kK+aohxUWbRdk67Hlh9/mV2Vu9YUeZU16GMizKJ68Sj+VHrB1GpJtQJVIdZJYGC
         W9eaIxgY7HizYvz2oPUK+uT0ZWhZf094wEV67+1oEmlWa33GYH2XYPEWG6GH/GNoEwuS
         4mwG6XAn6l6KOsIlbIe/E+qTXc6ZF6pWerWcVVxh3dLVwlzp+y5IAQhws9x7tdIxdKz3
         Kz+XzCzC6FfzJ+v934m16RFnCG+id1GOM5Cru4ZaGnUsM6hdWjHl366KHjDfkxyeeJ2H
         W2bg==
X-Gm-Message-State: AOJu0Yz70Rpv0ZB6QI2AgVmUO3nBevuqLMB5F6+YNJTldDCrvBrxzbnm
	UQKCO3wLIUgrMl2vZSF8KSih3VIUJr+jQqL4a5vORPyzXodBk6Ut6rYXNFCGJw==
X-Google-Smtp-Source: AGHT+IEDU0f/LZTZf0+r3K8CSuUlFt617cPqAtIUeGN2vr636LX8vCpmJ6gjqngAJppnD0SbvlrATA==
X-Received: by 2002:a17:90a:e2c8:b0:290:45a7:3ed7 with SMTP id fr8-20020a17090ae2c800b0029045a73ed7mr158870pjb.3.1705606152436;
        Thu, 18 Jan 2024 11:29:12 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id oe15-20020a17090b394f00b002903a89ebb3sm716848pjb.31.2024.01.18.11.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:29:11 -0800 (PST)
Date: Thu, 18 Jan 2024 19:29:07 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Brian Swetland <swetland@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2 03/28] binder: fix race between mmput() and do_exit()
Message-ID: <Zal8A95q3jVl4nu5@google.com>
References: <20231201172212.1813387-1-cmllamas@google.com>
 <20231201172212.1813387-4-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201172212.1813387-4-cmllamas@google.com>

On Fri, Dec 01, 2023 at 05:21:32PM +0000, Carlos Llamas wrote:
> Task A calls binder_update_page_range() to allocate and insert pages on
> a remote address space from Task B. For this, Task A pins the remote mm
> via mmget_not_zero() first. This can race with Task B do_exit() and the
> final mmput() refcount decrement will come from Task A.
> 
>   Task A            | Task B
>   ------------------+------------------
>   mmget_not_zero()  |
>                     |  do_exit()
>                     |    exit_mm()
>                     |      mmput()
>   mmput()           |
>     exit_mmap()     |
>       remove_vma()  |
>         fput()      |
> 
> In this case, the work of ____fput() from Task B is queued up in Task A
> as TWA_RESUME. So in theory, Task A returns to userspace and the cleanup
> work gets executed. However, Task A instead sleep, waiting for a reply
> from Task B that never comes (it's dead).
> 
> This means the binder_deferred_release() is blocked until an unrelated
> binder event forces Task A to go back to userspace. All the associated
> death notifications will also be delayed until then.
> 
> In order to fix this use mmput_async() that will schedule the work in
> the corresponding mm->async_put_work WQ instead of Task A.
> 
> Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Sorry, I forgot to Cc: stable@vger.kernel.org.

--
Carlos Llamas

