Return-Path: <stable+bounces-83443-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1118C99A386
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 14:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B3F1F224F7
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 12:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34E721500F;
	Fri, 11 Oct 2024 12:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ig4ztrbY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DB71BDAA1
	for <stable@vger.kernel.org>; Fri, 11 Oct 2024 12:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648830; cv=none; b=CP8EyzGYqIVWYV2hUiQEIZd+4RrfIM43RHG6R6wuKDy2q01ApO0XBZyOySSgtszNQe9WSdIkWYOPF06WToevqzUUjrp3RapkNzQNBgrLL3yIT33fXMM/u1z6Rkvu8ldqH3fsfysiPhBW11afQDsNHN/1YlA9WX7/jgXR8KVnuN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648830; c=relaxed/simple;
	bh=RK8IPmYPg/uP9Y7E89x6DvioC+lFZfxWAqh8PRkUppI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0Js/ZCPP208p1xwKUklowfJ5B23yGMwAuqbhwrxl9znag13ScYLN+574pfxorW9vwfsjluOTtXEzgXakCkipaytvDzUoOwvic3frTXkYI0VN0Id/cVk+DNmxfRzjgJGkJ8L57C0Ix1cgN1P3R4fVfJVZSc9rTXEaCvzHPhbXW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ig4ztrbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A14DC4CEC3;
	Fri, 11 Oct 2024 12:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728648830;
	bh=RK8IPmYPg/uP9Y7E89x6DvioC+lFZfxWAqh8PRkUppI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ig4ztrbYNwhauLP4Qv9O7kd2XgxWB4HDUKs7fOEWuKCOLVT7QQ/ApiML1zljStTAU
	 n3aqYlY0D+0bm6hyWg4B0MGkdXoGLDjf7uSQsnuFn6YgkHrqqHY411DATl75frxGpn
	 EgdXs6CFQMEvPxhzuSwnnvPKn/yY0fRoPisnZAuuL3lJVxsKcyJp3eCxnOaq4dmAzm
	 vtegLlCLyUsdBghDrnn1l+lQ9xgq0gKDfpsw+8C9gSRUH9nNppAsWpk0JBo2qVyhNJ
	 qC1eajmG8fRlRZCYTET9DoK+20U9QFAO+Af+BMarLF5bHHQZFpFmjskfBkPvY11iX6
	 wqYofieSByr6Q==
Date: Fri, 11 Oct 2024 08:13:48 -0400
From: Sasha Levin <sashal@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: stable@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.11.y 1/2] zram: free secondary algorithms names
Message-ID: <ZwkWfP3I5WC69Z9_@sashalap>
References: <2024100723-syndrome-yeast-a812@gregkh>
 <20241009044639.812634-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241009044639.812634-1-senozhatsky@chromium.org>

On Wed, Oct 09, 2024 at 01:46:38PM +0900, Sergey Senozhatsky wrote:
>We need to kfree() secondary algorithms names when reset zram device that
>had multi-streams, otherwise we leak memory.
>
>[senozhatsky@chromium.org: kfree(NULL) is legal]
>  Link: https://lkml.kernel.org/r/20240917013021.868769-1-senozhatsky@chromium.org
>Link: https://lkml.kernel.org/r/20240911025600.3681789-1-senozhatsky@chromium.org
>Fixes: 001d92735701 ("zram: add recompression algorithm sysfs knob")
>Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
>Cc: Minchan Kim <minchan@kernel.org>
>Cc: <stable@vger.kernel.org>
>Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>(cherry picked from commit 684826f8271ad97580b138b9ffd462005e470b99)
>Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Queued up, thanks!

-- 
Thanks,
Sasha

