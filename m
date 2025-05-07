Return-Path: <stable+bounces-141968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40333AAD55C
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 07:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634A81BA596B
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 05:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68031E2843;
	Wed,  7 May 2025 05:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="arN62r5g"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB811D88D7
	for <stable@vger.kernel.org>; Wed,  7 May 2025 05:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746596425; cv=none; b=Q5Xtx1UseYOLLzcQFrLPjei7a7HD1wFjA2RRJI4PXnXKVedx56dI5/bcaBtM7u2V2rAv2b5GrwNq6xE+Y2hBmZHnXx1vViMmvsZuUQ24jDrtyd1Uem6nctSs2w7VYV+10b1nfIUT1OQiB+iBenRWV9gEQrXabV7g5SQe6W1Md/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746596425; c=relaxed/simple;
	bh=x3IqRI7+6yI79hXX7qqhAUMFTsRrFTkDJXXi7bNOyZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHZ8ZvuMxqap76rHQLd/br4PXjq/70ihT8kt8zS9WF5eJ4V5j0AFuMQGLRZk3tYhEwJ/fbBmLg9ZuECsXAajIuGAzYHSntl1rAE5bVJQSRxthRK4RrvT9SBQ1IL2983jV335GN6CiIUwA5w5tQ36Qve1EdeGDXTK2ZeDwzrf8Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=arN62r5g; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso5979549a91.0
        for <stable@vger.kernel.org>; Tue, 06 May 2025 22:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746596423; x=1747201223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=outIt2Tzb0nU9gZ1BTuUgZWqA3ZwKfB1X1BxnDdScyQ=;
        b=arN62r5gJKX8AcntZ6H2WL6LJ6wopt/fDDVMuf43byRJI1UcTrPPBW5aelVGnjIccI
         ulP/6SHciVQ6pIY8zr9L9yAanXQKWPESwrc0ZeKFuZAGnInONxA7Y3XQMLw+phUvQA5U
         HuelkMjzmq0nUwdAVKtVWkDSLdcQMpqrrYimI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746596423; x=1747201223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=outIt2Tzb0nU9gZ1BTuUgZWqA3ZwKfB1X1BxnDdScyQ=;
        b=s3nCHwJd4pM8VlJiHHaZEvpBoMwkzjAzkOi+1iooRKOgw3gfFlyLOsGVJpZXz6dl8x
         u9eH95g1jZ4QOWJ0aK4u8iYe5bat9joFdjemUqJVDlTwnjc+6UV/ENabfL9iiA45byAF
         Xr+ZQZ6XdXJz5hyFT2OnnUCx818YVQDta0v0w2bjr8qywSwuxZqL8SscReVIoWtU38rH
         sDXrSBj0BOWPQkQZT2nJjF4Ap7jSJAZ4q1K2DUE1I71M1gFA+BrJxU/gibWu0ZpKGce3
         7yFEjx05ES6J8klItxTxcoJEaxh8soUagjN8RMaSI0G4tw3RibtMexfO1pGVxWQLKOm8
         XROw==
X-Forwarded-Encrypted: i=1; AJvYcCW61JrHMRYOz1SjinAHea5zWZa3GjebQK0l0r4dZpWyQ/e7Rh4FCQpCsqE0cN1zzDQ8ZH6rNJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylrDxIR/SprvbZL27Z3v1FXdNuwXM5BfLLpwis1VFvsgjWgO7a
	cV/QtRa2HTTmVaYmvwXlY8HsPvt/vum51dR+6OHXJj+Gar47QHwByUfyH6Gx8w==
X-Gm-Gg: ASbGncuA3uetZjjuzihV7sa5McYB5mDHVEAa9AvVfZ+70E+9LlxIA/T7jQJEKUKaJ/1
	kWdbdswyRmAsyK+G87Rayq6Pjh3KfVYuOsv2LXQz4B0JFHuxffVuSC0MImeClWY0eGpk/7Mb4g1
	nSDQ/KAgr+9ArWazy2kN4K20RryhyA9qk6JKQSK8vEfimOO74flqnl9czLq+D/g0UE2GMEp728e
	Jk2baZF7epMLiYHHkzgIr+skgfUSttlt2I0/+x9VGrQi7dnZzOMYbGALZND5P/zI9gJm6n2FbIY
	loqAiyu2LkSaLFQQq9t9jluiA2ydxDiPzhPdkuAZ0h46
X-Google-Smtp-Source: AGHT+IHDckEhV3VdKPDU2NI16nX908GbEl4+N4IQWfDv6w/TD99gxmV6rqQ8kPZ25udKGxGZw/Yeeg==
X-Received: by 2002:a17:90b:3882:b0:2ee:7c65:ae8e with SMTP id 98e67ed59e1d1-30aac185045mr3372912a91.11.1746596423308;
        Tue, 06 May 2025 22:40:23 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:284f:37bc:f484:cbc6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30aaead24bdsm1014185a91.32.2025.05.06.22.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 22:40:22 -0700 (PDT)
Date: Wed, 7 May 2025 14:40:17 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Vitaly Wool <vitaly.wool@konsulko.se>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Igor Belousov <igor.b@beldev.am>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] zsmalloc: don't underflow size calculation in
 zs_obj_write()
Message-ID: <o5xq2ojelmu5tuhiea56xctpnm7thfpkzxd56acxewbws4hwac@zgixe7zk27de>
References: <20250504110650.2783619-1-senozhatsky@chromium.org>
 <20250506135650.GA276050@cmpxchg.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506135650.GA276050@cmpxchg.org>

On (25/05/06 09:56), Johannes Weiner wrote:
> Could you please include user-visible effects and circumstances that
> Igor reported? Crash, backtrace etc, 16k pages etc. in the changelog?
> 
> This type of information helps tremendously with backports, or finding
> this patch when encountering the issue in the wild.

Fair enough.   I'll send a v2 with updated commit message.

