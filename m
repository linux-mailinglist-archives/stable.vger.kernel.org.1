Return-Path: <stable+bounces-12214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF02831FC9
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 20:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660B12896AA
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 19:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EF72E40E;
	Thu, 18 Jan 2024 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xrWtmYjx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F352E405
	for <stable@vger.kernel.org>; Thu, 18 Jan 2024 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705606434; cv=none; b=ZVneEO1yv7WtVp/1M6Z1i9OnLoqTgaqedChOpnju8l1JVL/7NN3K6csKWan6y8Or4uQJHLtWWVNq11ND0Mz+xODZdV2UxMw5pZS+1ccNx/tJfFUx3jFRyfLZqKOEwZXTFMbpotswa7aTB6+GqFpVNkPSZ+1MoU9YcFc4iav11tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705606434; c=relaxed/simple;
	bh=r7q6DvUCmOsKy6+NbzdyWEddN1onz2OiEikraaSBQa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPcjxGVIT987L+MZOROXaIS5XcJ7uJ6lC/PAZo640+XYgXhrm+HEl/fCzrIV2A58HX+rvnqTrsNGZr5s4ghuqsW8L6An/16eev80YDL6hBNFHuIwvuy0CIhI5po4HPt+bToHuTO1MN5pGLN1VevQIaAjZ0yb+hwcwZQZit78rPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xrWtmYjx; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cf87cdc4c5so12887a12.1
        for <stable@vger.kernel.org>; Thu, 18 Jan 2024 11:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705606432; x=1706211232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Eimo1bLVuQLA4eG0D77yPQYKlmdquXBMxi8UiFbf2o=;
        b=xrWtmYjxlRDgwio8cVAuZuud2MlU+7JhxUcN0Ti5h8hRFE1KRppD3jfPWJnGwPRhtf
         qZrPkU+/9K78O1UN1eHMjLSyN5y/2ismXyRnfXodrHXErTA5pmO1KpFbNs8V0DNc3Wn1
         I1x0tSB/oT/yjTWZwOa3CJHZgPFZt5rHs5qJEUHoqvsar/asz3Bdq/PRA5t9QND0PDpd
         7/6P9OCVoyfwyxOc+/Y4xGHfVROp24UNV8SkhBefa8ax4gfEIvSywlMYpyMRP2Z/Jexp
         R0l3VQQpruMTpyBxInjz66O0I6YA62hw+X37kmeRNp28Snil3A/PzGF7tLLaTbRWXy6+
         l83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705606432; x=1706211232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Eimo1bLVuQLA4eG0D77yPQYKlmdquXBMxi8UiFbf2o=;
        b=h13vfeU2NnnyOVNcAtDqwB9+/LPyH6qRJGmQQmoLrDXj50Teyd/fKdHXhuUS3HtOva
         AKKLnum1hanO6z5AoNZtoc6yRuTEXNN+AukU6FXDAEqJ0wxpksVlLU4ZkERUvIkan9JA
         tSH6oO+3ctiQ9J32PXygN9uLSgrbbZHCiLHt7zevpZFquwjx1VuiHNJw10kKnCw2RfOa
         i0hu46t7SU7EbFX4ztS482jE855t0IQXdWZaizXthSTSJnFfD5nBeVWSkg8Uj4SLuhnI
         wOTodFDOD7mz6NqkdlMMvfuYZsHzfw1GV5IqS+Xq3vHFJhRneY4azV/Ei2FMWfyL8aZ+
         nVug==
X-Gm-Message-State: AOJu0YxmRj1h4VMibycqbgZpkImxGWMvsrF64GA34xzTsfdxqv78ffJn
	U8Bz4pHfWatgkDjG5kTgO4Hd07MfszJNAC5aylo/hFPtzRsPI1hz7irNvTVteA==
X-Google-Smtp-Source: AGHT+IFm9T/UtIOxxsCVJCtWVKQaeNLEt/TFaVJP4JjyAFEswkIgviQqSjaT4nzdAULA0wxSJrb57w==
X-Received: by 2002:a17:902:dacc:b0:1d4:69a5:edbb with SMTP id q12-20020a170902dacc00b001d469a5edbbmr1528056plx.48.1705606432321;
        Thu, 18 Jan 2024 11:33:52 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id ee6-20020a17090afc4600b002868abc0e6dsm2261384pjb.11.2024.01.18.11.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:33:51 -0800 (PST)
Date: Thu, 18 Jan 2024 19:33:48 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Sherry Yang <sherryy@android.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 05/28] binder: fix unused alloc->free_async_space
Message-ID: <Zal9HFZcC3rFjogI@google.com>
References: <20231201172212.1813387-1-cmllamas@google.com>
 <20231201172212.1813387-6-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201172212.1813387-6-cmllamas@google.com>

On Fri, Dec 01, 2023 at 05:21:34PM +0000, Carlos Llamas wrote:
> Each transaction is associated with a 'struct binder_buffer' that stores
> the metadata about its buffer area. Since commit 74310e06be4d ("android:
> binder: Move buffer out of area shared with user space") this struct is
> no longer embedded within the buffer itself but is instead allocated on
> the heap to prevent userspace access to this driver-exclusive info.
> 
> Unfortunately, the space of this struct is still being accounted for in
> the total buffer size calculation, specifically for async transactions.
> This results in an additional 104 bytes added to every async buffer
> request, and this area is never used.
> 
> This wasted space can be substantial. If we consider the maximum mmap
> buffer space of SZ_4M, the driver will reserve half of it for async
> transactions, or 0x200000. This area should, in theory, accommodate up
> to 262,144 buffers of the minimum 8-byte size. However, after adding
> the extra 'sizeof(struct binder_buffer)', the total number of buffers
> drops to only 18,724, which is a sad 7.14% of the actual capacity.
> 
> This patch fixes the buffer size calculation to enable the utilization
> of the entire async buffer space. This is expected to reduce the number
> of -ENOSPC errors that are seen on the field.
> 
> Fixes: 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---

Sorry, I forgot to Cc: stable@vger.kernel.org.

--
Carlos Llamas

