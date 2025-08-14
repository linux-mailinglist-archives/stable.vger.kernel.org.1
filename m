Return-Path: <stable+bounces-169577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A63EB26A3A
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 16:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9A016F6CB
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 14:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77592218592;
	Thu, 14 Aug 2025 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WPbVbgvx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB2202C3A
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755183044; cv=none; b=JIgqN+eHBaq0Thb6A57RyUftQHT7yQUzOKhZDFKKsNf6nx9RHIknr48x3Z+dUsNWuc8ezImr1vXNMwmNmKVYF8hQpczr2dA/Q2IumfpzRUlwilEudlf1cbV6FSYjb6k8vwXz9mGae5VLEoExqNN8r/OWPKKVl9fmhLYDkcMsvW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755183044; c=relaxed/simple;
	bh=zMKLfvYxyHlXKU2+2xgv7Jd1haLqSPUF1RejGOjP6zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3OZ8jxihZfaY9ElShxoeWwanV/JSBghhJnbvWDxZ3fsRmADUvogZ7o9klmHApilZEkS6NnlS91PApuEPs+YkSnkjm6vEKzFfuU7CuiIrxpa4nCVZ9SwKlysLRa3g/HKibaHGk9X/gzScohQ1aKJyI0pqGFXwCSOmLM94TrWsFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WPbVbgvx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9edf504e6so519941f8f.3
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755183041; x=1755787841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0vGIESpwE6sjQpjPwI0fN8WHW6LSr9CktyCHEaHrsyg=;
        b=WPbVbgvx1xhELTZHmnwkJCRlOuRV6h8r96yaxiBpdmDM4UZjwVovjsWGEK692DkXsw
         F/xyIs10St9AOB21NhiV9zAupBkslF5htHIpavw3KyDb8JhEp6t7cjORWay4as/1JSAP
         aX9lNLgB7UDK7gWLQgyze2CSpxBZtN/sCIF9zU2cvYFfodqJXiygAX81UfQ/MVuXmsWm
         VBzDHuqejkJOF2shbxXmfV3s8CgBZO3e/LhnQh5sx28Ke/m0cjzMv+m5I/mHUgqx2Tru
         GNveNx2ei1LQfmuBbU/Hpb7wzMMyl8z3c5Nv2B0ByXb+lK11utsBWUFUF41xEF7tX4T1
         Azqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755183041; x=1755787841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vGIESpwE6sjQpjPwI0fN8WHW6LSr9CktyCHEaHrsyg=;
        b=lGtofJvab0oiyR5F5otX3FcmzE/IA3fsNUR88+OEUDBRMAZ3lU3jjjnAtHMSIw/Kdd
         ASLdMkgxkh1GR43EtvVt9wuGbsiiSAXdYOO81EKZjfFlwN7D4ZBEU6jtvf1JYjkHpTvf
         j2MYZc/RYLDa1c4nfDjOowuDwZJJlxtRwed15RZt3/3MJBRIXkKBQvFdrDBcvgBLdowT
         J/5m2FulLirpWWg7WOyFiKwbLigdC5TR8jhUbF3sLJOAO9u4ccD9iPfPmSjyPw0G8F3C
         XjxObWnqRaifJ6C26+Lb7muyYeyTznQEwxQ3iZQ8NgGCzhgru0rnx0GmacG7pkUDA7l7
         KFUw==
X-Forwarded-Encrypted: i=1; AJvYcCUlAuwAXnY3g7Vp9q+LHDP/H7FBLOeu8GWIZNDZQv+/axCA9W++eyW2jrQniBjbVdkV7sv52iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwITEmpb9FegEnxK2xhMolznRW45MdD6CmxUByinR7ShkZu8tt
	dV1yteFLY884OWFRIWlRL/vxra+e9w+uSNALSXD+fGOHY2PrVOUp+6umpISBdp/AF5U=
X-Gm-Gg: ASbGncuU/9dZdMv2k4Bw9Og+dJD6jx2C2itBK2gMCzRkc1DAbM4GE98MsPaREbQ1d11
	0xLJ3vuBQ4KssKI3n7VJx72fBGV83Ki4bNw4gBzcZEcEFww/s5nem+O8V6oNyK+a5Zi+hAiVvCX
	tUwe/InQnymCR8x1CO+qM7hlTbglId++lN22/C///3qvW6z7lj52BuZpOwvX9PuQs9sLxASl6fO
	SPpzmPB9/9SWrfbYAIGwUa0JqlNRkXuDc4ImlEIdjWcAKKi2bHVYnkv6gkkq/TM5QGZhYjw0Hxy
	GvFZ2hyzJVJcgS36MbuCgaVx89Sqbjhrd4oTGwZqSkOf0b5edMUIOSD0855s7HVUi4f5VwzucDk
	dHNqIYxQtLbbwYU7MlLPMpif7Iu0=
X-Google-Smtp-Source: AGHT+IHh3EzdCyG/NhBNbMq/qJ6rj0vlsxozGvF3nkk+UdR4z/kGz0s6cc9K0QXKutX0yGrJTiEEog==
X-Received: by 2002:a05:6000:230a:b0:3b9:10af:59f2 with SMTP id ffacd0b85a97d-3b9edf34a5bmr2739927f8f.28.1755183040605;
        Thu, 14 Aug 2025 07:50:40 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b9132f00ecsm8850096f8f.24.2025.08.14.07.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:50:40 -0700 (PDT)
Date: Thu, 14 Aug 2025 17:50:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes.berg@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Kalle Valo <kvalo@kernel.org>,
	Aditya Kumar Singh <quic_adisi@quicinc.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Rameshkumar Sundaram <quic_ramess@quicinc.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jeff Chen <jeff.chen_1@nxp.con>, Bert Karwatzki <spasswolf@web.de>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Cathy Luo <cluo@marvell.com>, Xinmin Hu <huxm@marvell.com>,
	Avinash Patil <patila@marvell.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: mwifiex: use kcalloc to apply for chan_stats
Message-ID: <aJ33vFdOfMRDbpls@stanley.mountain>
References: <20250814131536.231945-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814131536.231945-1-rongqianfeng@vivo.com>

On Thu, Aug 14, 2025 at 09:15:31PM +0800, Qianfeng Rong wrote:
> Use kcalloc to allocate 'adapter->chan_stats' memory (max 900 bytes)
> instead of vmalloc for efficiency and zero-initialize it for security
> per Dan Carpenter's suggestion.
> 

This patch is okay, but lets re-write the commit message:

Subject: wifi: mwifiex: Initialize the chan_stats array to zero

The adapter->chan_stats[] array is initialized in
mwifiex_init_channel_scan_gap() with vmalloc(), which doesn't zero out
memory.  The array is filled in mwifiex_update_chan_statistics()
and then the user can query the data in mwifiex_cfg80211_dump_survey().

There are two potential issues here.  What if the user calls
mwifiex_cfg80211_dump_survey() before the data has been filled in.
Also the mwifiex_update_chan_statistics() function doesn't necessarily
initialize the whole array.  Since the array was not initialized at
the start that could result in an information leak.

Also this array is pretty small.  It's a maximum of 900 bytes so it's
more appropriate to use kcalloc() instead vmalloc().

regards,
dan carpenter


