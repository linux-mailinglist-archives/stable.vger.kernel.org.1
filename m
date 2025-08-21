Return-Path: <stable+bounces-172182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C53B2FF9A
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCCBA06B8A
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815A7278146;
	Thu, 21 Aug 2025 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA9HLcNd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376862E1F1B;
	Thu, 21 Aug 2025 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791916; cv=none; b=hDkgNlUff9b41D4Qvd7Nfd/QUs8mS5OC2n8CasowVgAMXl239q9WxXzULvs03byQc5js21g3e8kRBRXXpzBjgorYonebOHG6ejrKXvM/cK6lNMXOcmRs/BMadYtpVLrAX9Nl3kR0+5O1U/NgwMyoQXDCEl8KNEDwTs6/9EtV3OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791916; c=relaxed/simple;
	bh=bP/JIPfZE0+HTDUGADbV9HkxcIqfv0r/PjlTY88pRt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+jktPfXk9ji8vUTi7jD1EEzm94ViSTJiGHAbfECkFFEvu6HqgI/BvA7mOxu1+1BbnqpD14YQdOmu3+OHyYCewfjd5fFWlOOUKkCQanJRr2S25wW6/nsmbzpu6S2JO5spWcxg7umvEm5tv+teAlO8J72qQIgs1azCj8QzUW3u5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CA9HLcNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0C3C4CEEB;
	Thu, 21 Aug 2025 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755791915;
	bh=bP/JIPfZE0+HTDUGADbV9HkxcIqfv0r/PjlTY88pRt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CA9HLcNdWGreQdR/bOKT3h4J4RPEjFT6PqTpNQ6bviQdIcRNWjWLo/eM/I6Wbzt+W
	 I4iQoqeqT/fgPPvvVT83BIJQrD4Jd71Gjcsam6nIYIi2ilknP2dzeft4n2M25gCV6D
	 kNTtDeFKxvNUMG7PJbtDNWIiFEU1jjkD94Ekwh1CYrbpW0f1RxAeblY3Cgj7utlatV
	 85lQuSJcenxUUCH0IjE0HPaTMC5/atOlWMe348626sZ5mrCtyw/iTV84KVhmHBpK3y
	 DCHeamXOEuXVodv0UUUzZTCspCSVHOZTD6qF4hemf4zWNyz8/oqUikz/Wezlml1s0K
	 GRXyIzLNRnw4w==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm/damon/core: set quota->charged_from to jiffies at first charge window
Date: Thu, 21 Aug 2025 08:58:33 -0700
Message-Id: <20250821155833.57597-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CABFDxMHgOPt5zx3q=KRxGGfp86R4V0AgO+FrHDftqLYoG20BWw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 20:06:58 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> On Thu, Aug 21, 2025 at 2:41 PM SeongJae Park <sj@kernel.org> wrote:
[...]
> > Let's restart.  Could you please rewrite the commit log for this patch and send
> > the draft as a reply to this?
> >
> > We can further discuss on the new draft if it has more things to improve.  And
> > once the discussion is finalized, you can post v4 of this patch with the
> > updated commit message.
> 
> Good Idea. This is the draft for commit message. Also, Thank you for
> your patience and understanding.

Thank you for accepting my humble suggestion.

> 
> Kernel initialize "jiffies" timer as 5 minutes below zero, as shown in
> include/linux/jiffies.h
> 
> /*
>  * Have the 32 bit jiffies value wrap 5 minutes after boot
>  * so jiffies wrap bugs show up earlier.
>  */
>  #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
> 
> And jiffies comparison help functions cast unsigned value to signed to
> cover wraparound
> 
>  #define time_after_eq(a,b) \
>   (typecheck(unsigned long, a) && \
>   typecheck(unsigned long, b) && \
>   ((long)((a) - (b)) >= 0))
> 
> When quota->charged_from is initialized to 0, time_after_eq() can incorrectly
> return FALSE even after reset_interval has elapsed. This occurs when
> (jiffies - reset_interval) produces a value with MSB=1, which is interpreted
> as negative in signed arithmetic.
> 
> This issue primarily affects 32-bit systems because:
> On 64-bit systems: MSB=1 values occur after ~292 million years from boot
> (assuming HZ=1000), almost impossible.
> 
> On 32-bit systems: MSB=1 values occur during the first 5 minutes after boot,
> and the second half of every jiffies wraparound cycle, starting from day 25
> (assuming HZ=1000)
> 
> When above unexpected FALSE return from time_after_eq() occurs, the
> charging window will not reset. The user impact depends on esz value
> at that time.
> 
> If esz is 0, scheme ignores configured quotas and runs without any
> limits.
> 
> If esz is not 0, scheme stops working once the quota is exhausted. It
> remains until the charging window finally resets.
> 
> So, change quota->charged_from to jiffies at damos_adjust_quota() when
> it is considered as the first charge window. By this change, we can avoid
> unexpected FALSE return from time_after_eq()

This new draft looks good to me.  I find nothing to further modify.  Could you
please send v3 of this patch with the above commit log?


Thanks,
SJ

[...]

