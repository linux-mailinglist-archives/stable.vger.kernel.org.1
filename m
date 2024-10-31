Return-Path: <stable+bounces-89398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4129B77EB
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 10:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D6A8B261CF
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 09:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5986198838;
	Thu, 31 Oct 2024 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGLX1NZD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A26197A81;
	Thu, 31 Oct 2024 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368249; cv=none; b=Y/waqhqY76EGZWRSIWOpughdXTg3MLigktqt/W1RPbKIZc8gIKibHrd7AG9xZ4pthEO18VV1KcBDG/lHD5g7CPrfyZ3DNLuZNQUEMl0KpFQQisKSmq6hFadhRK8yiz/OJyNkTiqP6LCfhXjfyHmmmzXCRb027rlV0oVeavA59OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368249; c=relaxed/simple;
	bh=1SfMoq9aQDPstkesMct3OWKZK5E4xbvfUSf6uoOtSq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZF6doVD8ZHqtYFVeSw8Wj73GzSIT2boDj77sAWslyLb7RmT/IUXzL9+FfBCm/zDINN/HE4ZlNhK0Ii2dd1vHqktUQHOZRzXbHnOSY4yczXhKEjv7CdSqERVYpzW388GYqYEtD/sSO/n+u71GpIrKpV7GcqkFo33qASo2BlOIv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGLX1NZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996BAC4CED0;
	Thu, 31 Oct 2024 09:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730368249;
	bh=1SfMoq9aQDPstkesMct3OWKZK5E4xbvfUSf6uoOtSq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGLX1NZDTSK3O6Wl5vFevq5jODfed+vvbcU5URvZwVeqrPcjwu6K67yRvHmqZoIwd
	 SQsirCaYnFCLHSeF3dx+7CSkkAmryh1EcrluFdTcgbDKtuPA0BSHk1E4mhalkd5M35
	 utkXiYmujB+bOqBSDFC7tOVwY4u7J7YyFTPy0oY2/MXvz+v0/8VGhoTAAue50LvJxT
	 gfNk+nNaYeB7EboaAFbajX+fyTIzQPoG1IjnnEZ2ZquhudSdyR+LLsSbHbKwg8ARfP
	 Rm+hONCoiv9QrdkkiWYYF3PRhlUbPC38rrjLg+0F3wR0o/kq2m83HPfxqKlyihnoJI
	 hd8YHmOJW6UoA==
Date: Thu, 31 Oct 2024 10:50:44 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Andrei Vagin <avagin@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ucounts: fix counter leak in inc_rlimit_get_ucounts()
Message-ID: <ZyNS9J7TOQ84AkYz@example.org>
References: <20241031045602.309600-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031045602.309600-1-avagin@google.com>

On Thu, Oct 31, 2024 at 04:56:01AM +0000, Andrei Vagin wrote:
> The inc_rlimit_get_ucounts() increments the specified rlimit counter and
> then checks its limit. If the value exceeds the limit, the function
> returns an error without decrementing the counter.
> 
> Fixes: 15bc01effefe ("ucounts: Fix signal ucount refcounting")
> Tested-by: Roman Gushchin <roman.gushchin@linux.dev>
> Co-debugged-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Andrei Vagin <avagin@google.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Alexey Gladkov <legion@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrei Vagin <avagin@google.com>
> ---
>  kernel/ucount.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 8c07714ff27d..16c0ea1cb432 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -328,13 +328,12 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
>  		if (new != 1)
>  			continue;
>  		if (!get_ucounts(iter))
> -			goto dec_unwind;
> +			goto unwind;
>  	}
>  	return ret;
> -dec_unwind:
> +unwind:
>  	dec = atomic_long_sub_return(1, &iter->rlimit[type]);
>  	WARN_ON_ONCE(dec < 0);
> -unwind:
>  	do_dec_rlimit_put_ucounts(ucounts, iter, type);
>  	return 0;
>  }

Agree. The do_dec_rlimit_put_ucounts() decreases rlimit up to iter but
does not include it.

Except for a small NAK because the patch changes goto for get_ucounts()
and not for rlimit overflow check.

Acked-by: Alexey Gladkov <legion@kernel.org>

-- 
Rgrds, legion


