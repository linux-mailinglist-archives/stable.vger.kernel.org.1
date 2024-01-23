Return-Path: <stable+bounces-15541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B50839208
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 16:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C255B22B1A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 15:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756785D8F5;
	Tue, 23 Jan 2024 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bZhT6h4X"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE5A5FDB4
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022374; cv=none; b=ZhKHKylO0y5jRSKv2fXWjdkVMr5Kl3UmkL4s1neAuVOfFgVl6SRbOSbslBNUZAH+9mWjK4aCvfR2cyZmP1o/YBhHJdAVjgQyWuyfkhfFiKLzS2iQBDVjphgGUoqrcr0F1umoRGRTYud5z35UW9ouPiNbckm7tudT6hJCBu0TqlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022374; c=relaxed/simple;
	bh=Hvxo1xL/yAymti2UB/udHZzJ/RVBSls+IizfWvbqLak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=so8X4eFq8BVBE/K733E+dHx/B41BcmTJKGMy+ot4gtYPE4ENkt7AN6hIzRnlV/83TQMujnry0iVRaAhWWk6qIBEKG3Cn8LVoPPQSxFWKB96OcEh3KQ8h7J2yvkGE252M/BujTZDDC8aqzba2R881gcixdZ7NjhzQXU0ihC0VDQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bZhT6h4X; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d7610c5f4aso11932075ad.3
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 07:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706022371; x=1706627171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Glva58k+YPNkEy53xnJkJEf4Saze9aPKJ5KXvwWKR8=;
        b=bZhT6h4X1y0xIYlsTCZj5rtLeRLEQ8Kx7vuZafOeJmlHtwEBGHYa/tEw1NgvW1DgsW
         eZe2EHlpxuHEnF3ofpooglR5LY/jyKx+X4JHPJk3rYFR7V45LgCqHCEaVm69VUAjEMoj
         m0rnJlwnYuTggR2Tqawm0r7sZOkkVA0cr48QiCkt6hUTqbVMS2HqxkSxAHCzWNFlbvyZ
         6hLw6qe8uDB/Nk7eFhuXdFwgfCZcvCefjqTMn5IMlWLYnMsz0iaCdFshocF8sogePQJV
         OcBcPaAEgjMyb1LJOB87FIcc93i52w6NGCCux1eE4tODAE5gYD0xwoU2Mu/PMCXdAPam
         zS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706022371; x=1706627171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Glva58k+YPNkEy53xnJkJEf4Saze9aPKJ5KXvwWKR8=;
        b=c7SuZisTjLvE+9iJVcDuqL5374EstGlvjf6/0On6u8Uuxm6tnEYDdsmPc6qi4ga9kP
         429v3JOHUELZeYbqr+gl/+vm4U11oSaa4A3dBHu5TPQroQzyGi95OkwPdqCrGTeHXzJH
         mQY3UycZmmSlT7Q79mgdJP8oy1GEzF43+NvqqIwfAcbZMR0FaX4FJUPHCXpCZTB+sdNR
         Dl5Ov+46KS/JGULiCzHLMaaeMUMN4ApoP1n1Cl0scAS9z65jner/DRfbNpo7R1oHNrxN
         3ZtRGxAp0UaiHV/uwC/c2IhTSrvQk03nu4S4tvYWR4svgvICJWleL3T9kSsOOYQEU5fj
         wMUw==
X-Gm-Message-State: AOJu0YyI9E2mrIWr/wXsYhbwNSUl7uQgvMTJijpAM5RkB/hl6BJLa/l4
	VN54+CorAdXBHCMhAxlv/xOwzI6+mRf5LyETFURAubydzi99dqaIUytKotW/eQ==
X-Google-Smtp-Source: AGHT+IFaUu6MulGNobBRg7zVXgcE4Zx+tJD59jwWQePg9cWYYloysGr59cpxq43TgRsCpLZqR0LAmA==
X-Received: by 2002:a17:902:ec8b:b0:1d7:4f89:b107 with SMTP id x11-20020a170902ec8b00b001d74f89b107mr4053062plg.134.1706022370847;
        Tue, 23 Jan 2024 07:06:10 -0800 (PST)
Received: from google.com (77.62.105.34.bc.googleusercontent.com. [34.105.62.77])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c25500b001d756bc2396sm3253890plg.192.2024.01.23.07.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:06:09 -0800 (PST)
Date: Tue, 23 Jan 2024 15:06:06 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Martijn Coenen <maco@android.com>, Todd Kjos <tkjos@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 167/194] binder: print warnings when detecting oneway
 spamming.
Message-ID: <Za_V3pUCssU9we2u@google.com>
References: <20240122235719.206965081@linuxfoundation.org>
 <20240122235726.366071549@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122235726.366071549@linuxfoundation.org>

On Mon, Jan 22, 2024 at 03:58:17PM -0800, Greg Kroah-Hartman wrote:
> 5.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Martijn Coenen <maco@android.com>
> 
> [ Upstream commit 261e7818f06ec51e488e007f787ccd7e77272918 ]
> 
> The most common cause of the binder transaction buffer filling up is a
> client rapidly firing oneway transactions into a process, before it has
> a chance to handle them. Yet the root cause of this is often hard to
> debug, because either the system or the app will stop, and by that time
> binder debug information we dump in bugreports is no longer relevant.
> 
> This change warns as soon as a process dips below 80% of its oneway
> space (less than 100kB available in the configuration), when any one
> process is responsible for either more than 50 transactions, or more
> than 50% of the oneway space.
> 
> Signed-off-by: Martijn Coenen <maco@android.com>
> Acked-by: Todd Kjos <tkjos@google.com>
> Link: https://lore.kernel.org/r/20200821122544.1277051-1-maco@android.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Stable-dep-of: c6d05e0762ab ("binder: fix unused alloc->free_async_space")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

I think we should drop this patch from the 5.4 stable queue. I assume it
was pulled in as a dependency of patch c6d05e0762ab ("binder: fix unused
alloc->free_async_space"). However, I have instead fixed the conflicts
for that backport here:
https://lore.kernel.org/all/20240122235725.449688589@linuxfoundation.org/

I was not aware that this patch was being backported and now we have the
following missing hunk in this v5.4 series:

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index abff1bafcc43..9b5c4d446efa 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -344,8 +344,7 @@ static bool debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
                        continue;
                if (!buffer->async_transaction)
                        continue;
-               total_alloc_size += binder_alloc_buffer_size(alloc, buffer)
-                       + sizeof(struct binder_buffer);
+               total_alloc_size += binder_alloc_buffer_size(alloc, buffer);
                num_buffers++;
        }


Dropping this patch fixes this problem. After all it doesn't fix
anything so we don't need it here.

Sorry for all the binder backporting mess.

Thanks,
Carlos Llamas

