Return-Path: <stable+bounces-45164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A45508C6729
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 15:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59441285048
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 13:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B83B1272BF;
	Wed, 15 May 2024 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0f0T6zeU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B78126F1B
	for <stable@vger.kernel.org>; Wed, 15 May 2024 13:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715779005; cv=none; b=igUM7YVkLXVfV9eRT2s6GPJ6Tqtz5Rwf7rFZguv4karIaehDtHb3iKJqfucu55zWna+LsfXwTCJoKygU6JTqEdTOib+XKZeZy726N7Ae2LWv6U/UQFtSrEB3FpdlOqcC/A0elg3Y4daHlaDITlZd9TVUbRECBIgITK5rUCbaQwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715779005; c=relaxed/simple;
	bh=Nv5VngqdeVvWHqjAcczguyK/0wJN1Krb/aobvZPhYao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVWpB6z1Ec7JF14TwdDTZ7OjtV+WAmltJ91GpkuFuyB+PzjxiUQQiiseRNdLdQqHh48w/Ef9G2bIT/rM6qbPM5uL8iuZtbLwtqVKXarzY9qXst+7aBPZ8uyCNSwingVF77lVbgxVkx9uHvPOTN6K0+Us7qVkwQWxDLL/1uRBCUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0f0T6zeU; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f4e59081e6so3863651b3a.3
        for <stable@vger.kernel.org>; Wed, 15 May 2024 06:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715779003; x=1716383803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Bl5pZZSvHcWypBy/YQwOUekmFc++htbsX2zW49QzNc=;
        b=0f0T6zeUgE3+ViKbfsAyv0OZgxhCValEyxJ/cCSzoqwTvmTQmUKnmCGayzSBAI+LuY
         uFTr8Tq4asbcQSiVPHm4FH3robNI1tR2HuxWktyaEkEQlUMqjjIDpE8apYcMqe93CCVI
         iIhMPWYy16V8p8IjaFD0rCPGtkiR/ha6s6yaX2pgIQqR9uDHWJowgM9W3XDXtZu+uTC2
         JTYMYBt7N+nRP4rmyZBlyi53VjUvMlO7jiM9ccsBrMuxByG2AliZ7eNUwd4fgTSWx/pC
         Zh4KMJn7cyOMfo8rxZTNXh9VExEl3jaRxRLfTV1yxvx5YSeQ7nOAukKtOCUWrK2Tf97P
         1clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715779003; x=1716383803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Bl5pZZSvHcWypBy/YQwOUekmFc++htbsX2zW49QzNc=;
        b=vIYzlh/kMMKSH+RL98FSU+hIyow5bKPbhIVrcCJSNZru84iLG3neR5MBg0qvBRHbQd
         GA87zdxlhzWbfP+a1cUX3VDX+gWfBsFNLlV28vwtT7AfOSeiuhM+yfvLlYkqBpD5Jl5Z
         HXDe4f0IaWpnXjsQgXoVJbtx+kKGRFrE65giZMgWn8AMF05BHsR7GEx9o304wCveP2vI
         /9MW6y0QWRtRoflPwffecXLxITeE5B3KGujqF1nnE4K6KRN6DqJU35/AnJpQQzFdkMBu
         jlyCxjh6F6XPzzR8cZ6hunITE8+CBV72EwY65u8s5AFzaD6UY3v7JlNS+K68JL71ZcUR
         Onxw==
X-Forwarded-Encrypted: i=1; AJvYcCW6KmuiS+q4xyXm//DCU2bVw3juD0Jw90B4rvJ8jJIKsvOln6Dl5UUkncf7tP2VSdMkXNOM6VKd0XuyEVucTlS/gbcG0JWK
X-Gm-Message-State: AOJu0YzMvVnFdC4tfIYaW9aVBEmYm+/Xn+ivtpFIX387Pw50QCbkaJh7
	FxH+hPxytf8L+VvR9Jdo81jXYTt40jF+U447cnCQXns1rurSGzYYDySoOJDVFGjfg/hczGO3nof
	MKg==
X-Google-Smtp-Source: AGHT+IH3IiLvfRfW4eWlWsOEV+o4iu4WOH24iXjI941BU9qwtB5rjlqK4Unho1lC1TlNzO3tO3SF9w==
X-Received: by 2002:a05:6a21:680b:b0:1ac:e07f:e3aa with SMTP id adf61e73a8af0-1afde1b7264mr17270032637.48.1715779003108;
        Wed, 15 May 2024 06:16:43 -0700 (PDT)
Received: from google.com (57.92.83.34.bc.googleusercontent.com. [34.83.92.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a68c1asm11046375b3a.32.2024.05.15.06.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 06:16:42 -0700 (PDT)
Date: Wed, 15 May 2024 13:16:38 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] locking/atomic: fix trivial typo in comment
Message-ID: <ZkS1tv56BNi-l6wC@google.com>
References: <20240514224625.3280818-1-cmllamas@google.com>
 <ZkRuMcao7lusrypL@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkRuMcao7lusrypL@J2N7QTR9R3>

On Wed, May 15, 2024 at 10:11:29AM +0200, Mark Rutland wrote:
> Hi Carlos,
> 
> On Tue, May 14, 2024 at 10:46:03PM +0000, Carlos Llamas wrote:
> > For atomic_sub_and_test() the @i parameter is the value to subtract, not
> > add. Fix the kerneldoc comment accordingly.
> > 
> > Fixes: ad8110706f38 ("locking/atomic: scripts: generate kerneldoc comments")
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> >  include/linux/atomic/atomic-instrumented.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomic/atomic-instrumented.h
> > index debd487fe971..12b558c05384 100644
> > --- a/include/linux/atomic/atomic-instrumented.h
> > +++ b/include/linux/atomic/atomic-instrumented.h
> > @@ -1349,7 +1349,7 @@ atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
> >  
> >  /**
> >   * atomic_sub_and_test() - atomic subtract and test if zero with full ordering
> > - * @i: int value to add
> > + * @i: int value to subtract
> >   * @v: pointer to atomic_t
> 
> Whoops; sorry about that.
> 
> The atomic headers are generated, and this kerneldoc comment is
> generated from the template in scripts/atomic/kerneldoc/sub_and_test

Oh I see. Sorry, I wasn't aware of this.

> 
> You'll need to modify that then run:
> 
>   sh scripts/atomic/gen-atomics.sh
> 
> ... to regenerate all the affected instances of ${atomic}_sub_and_test()

Ok, let me go do that. Thanks!

> 
> Thanks,
> Mark.

