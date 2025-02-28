Return-Path: <stable+bounces-119900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D51A49270
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F341893BA1
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 07:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886BA1C5D44;
	Fri, 28 Feb 2025 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXmOQ+li"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427F1276D12;
	Fri, 28 Feb 2025 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740728995; cv=none; b=n7ZrXXfVCGIaZDHA+Kk6M6RiUfn+eersogX9UpQ+3STJnBGvTvNEI4oD6iUqvDJmuoA8OumWFgSWylEbkTZfyVjclQm30d60R+Pj1cB6cSp/y2cs3evlBpjzOUcGO4FaHKR+uGkfWNShLXYU2yfDgb+NklSpMRw6X/35IcNg07Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740728995; c=relaxed/simple;
	bh=xzGvdO43Cac4M6XX0CA56Ipu7nb2OamXUYgl7cM5MO8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vEzD7WfZW4PJ1JPNs/WnChpyCYJ64X+E0zF0X7KFgyK6OhOk+NOZSGnKTABRuj+MpQGNVH/pe7/46fU3lg1hZA5AZOEjHSnAyJB7jw0gJN2MbH7vZLFhpIoifq2JGTCHfwvQlX8ipo90QidApGpQD12uE4zjwnnXpI/uWdfXGGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXmOQ+li; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378D8C4CED6;
	Fri, 28 Feb 2025 07:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740728994;
	bh=xzGvdO43Cac4M6XX0CA56Ipu7nb2OamXUYgl7cM5MO8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=fXmOQ+liaBjt83yS6u1Y8xTveBBDC/B1qEvF3qiOHD9yBNbELufUsfyatX6lT9/3n
	 pGqr0wh2iS+smnG5ZLB/5pSt86omomTP4f7FDPsal7GI0wbA/TlHiyXy5vF7g744kh
	 gvFnI8huaurFi8YEt8lnW7W7dMXhmgJZbD2pWzS10tAcKHN+IpZReAirx1meK7M6rC
	 5aaRJTJIiPgxhjMHNIYuZaWk8cCf8Ya7XButpxWpUVPrubgu2tUB0zoMYarykIDQlB
	 AJbYND239U/g9BGuJI/DJmGuG2DXuUMAm1wugMYVa+HJJ15XCFi0RcEVLTyFfX25ve
	 p+YPvVZw5fuPQ==
Message-ID: <0e24eabc-c9e7-40c4-a793-b8ba6579cf77@kernel.org>
Date: Fri, 28 Feb 2025 15:49:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, stable@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix the missing write pointer correction
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20250227212401.152977-1-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250227212401.152977-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/28 5:24, Jaegeuk Kim via Linux-f2fs-devel wrote:
> If checkpoint was disabled, we missed to fix the write pointers.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 1015035609e4 ("f2fs: fix changing cursegs if recovery fails on zoned device")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

