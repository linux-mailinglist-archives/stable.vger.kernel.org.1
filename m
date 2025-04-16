Return-Path: <stable+bounces-132817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBA0A8ADB6
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 03:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8891902EDA
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 01:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77820227BB5;
	Wed, 16 Apr 2025 01:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cYEmPHI4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245981C5D72;
	Wed, 16 Apr 2025 01:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744768735; cv=none; b=lM9NT41/psFnLWozxfsPoZb94iwuzp4KvDuEihh9a0Sh6XFxBNGCar/KwTSyhFMtEkMD2gaFWQlVxZbf3TyGyAuwXmW+pnu2ad8Kl+I77jn4g3P9sFcRZooOGI23SPfwqSWON0eWSbz0wBBM0WUNxAZOxah3vqsQoT4r9MmRtAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744768735; c=relaxed/simple;
	bh=L3o/7F4MZw2GsitKRi44JKWGnNf/gein/ZxWerdQGwY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ckng8wlBQKy0sbIxm7TTYtHWQHSq7XQxnjL/vNft/GhZFSxDjcddgQkj24GFsSnmrHOhzUtAfPT8uHeX3EO4mKmDj1V4r0jYPUFve3L68AHJ70WdD9rvu0BAntorQR7fkmL4YcmPfZd/mpAUSfSSdfCZmqfBKZOQEGH4RQiLGwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cYEmPHI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B8CC4CEE7;
	Wed, 16 Apr 2025 01:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744768732;
	bh=L3o/7F4MZw2GsitKRi44JKWGnNf/gein/ZxWerdQGwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cYEmPHI4kYr6oATSI+VqxPwKjliyvrgzgV1eiOpK0h3032kT0yDSJOHCchr263Y2Z
	 eulIy68ckZ1fI4XjPaFBXMym5A77qmLinC91yRqQ20zTlSYrtV5r5NvRJxrK/XzGyl
	 US6JelDMIjrRVMpLQTz9K+Xh9o6dxiMj1nr8hqC8=
Date: Tue, 15 Apr 2025 18:58:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: alexjlzheng@gmail.com
Cc: willy@infradead.org, andrea@betterlinux.com, fengguang.wu@intel.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, mengensun@tencent.com, Jinliang Zheng
 <alexjlzheng@tencent.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: fix ratelimit_pages update error in
 dirty_ratio_handler()
Message-Id: <20250415185851.e8d632f60ec5049f734ac2a8@linux-foundation.org>
In-Reply-To: <20250415090232.7544-1-alexjlzheng@tencent.com>
References: <20250415090232.7544-1-alexjlzheng@tencent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 17:02:32 +0800 alexjlzheng@gmail.com wrote:

> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> In the dirty_ratio_handler() function, vm_dirty_bytes must be set to
> zero before calling writeback_set_ratelimit(), as global_dirty_limits()
> always prioritizes the value of vm_dirty_bytes.

Can you please tell us precisely where global_dirty_limits()
prioritizes vm_dirty_bytes?  I spent a while chasing code and didn't
see how global_dirty_limits() gets to node_dirty_ok()(?).

> That causes ratelimit_pages to still use the value calculated based on
> vm_dirty_bytes, which is wrong now.
> 
> Fixes: 9d823e8f6b1b ("writeback: per task dirty rate limit")
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> Reviewed-by: MengEn Sun <mengensun@tencent.com>
> Cc: stable@vger.kernel.org

Please, as always, provide a description of the userspace-visible
effects of this bug?


