Return-Path: <stable+bounces-180649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D59B892B5
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 12:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6624E1BC7ED3
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 11:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DF830AD18;
	Fri, 19 Sep 2025 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gqjhmq5q"
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C08430AD17
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279572; cv=none; b=rj11WG1SBTXMBg8L0cB68Sd/dbUFGY4VPxQz7zu414Ebsl70Ca8cGwVJUhqFPicBr0sWb5FLZboeymCvfZ4kO6JDPP5oTSV89QRVAEPL513gwDa04vkEhDf5Fcd404mT9gWB1WO8b2bRr0oa1H+161KppbbKDe8DDeddOlfnZDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279572; c=relaxed/simple;
	bh=CEmWUjF/TcCalxhAWDKk5hHQFMQ5iziper/nDpqO7EE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gukZdIE9aRpxeDdaqGs+JQQa9ShlKHZGE0mZI7r9Z6tjRTNZS6NJ01dTznIBIJqok8qTYf14FYqozlJsfezDxUYz2X21W0CEHys3bUWjxFvIevUKQ4pPDafQmKLqFi3rjdjyd4Rgf/2xRcQuCirzX1rgOfEdhABdkXlXpztFdqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gqjhmq5q; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <61e38165-fa9f-4078-8499-a9c12449ae95@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758279558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5S5/N031pPAmIyQyocHUR2GyX0QYA4EnllETjaaSvE=;
	b=Gqjhmq5q6xtIVttmXVuKaqlsz6rOWtQpQcV2nlsvHunmqsR9J05wQQeV1zEq6dLWqZD0V+
	zJ6pILm4IZ7fdiXfj0jpi4DXZfBAjGiFGgCOjFpBhJAZIvLmIBwGAa7ia8+clXmsUlZx2W
	qRAX1sFNAhKqyFQ1fFqGK/GNUzVobSY=
Date: Fri, 19 Sep 2025 11:59:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3] net: nfc: nci: Add parameter validation for packet
 data
To: Deepak Sharma <deepak.sharma.472935@gmail.com>, krzk@kernel.org
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev,
 syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
References: <20250919064545.4252-1-deepak.sharma.472935@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250919064545.4252-1-deepak.sharma.472935@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19/09/2025 07:45, Deepak Sharma wrote:
> Syzbot reported an uninit-value bug at nci_init_req for commit
> 5aca7966d2a7 ("Merge tag 'perf-tools-fixes-for-v6.17-2025-09-16'..).
> 
> This bug arises due to very limited and poor input validation
> that was done at nic_valid_size(). This validation only
> validates the skb->len (directly reflects size provided at the
> userspace interface) with the length provided in the buffer
> itself (interpreted as NCI_HEADER). This leads to the processing
> of memory content at the address assuming the correct layout
> per what opcode requires there. This leads to the accesses to
> buffer of `skb_buff->data` which is not assigned anything yet.
> 
> Following the same silent drop of packets of invalid sizes at
> `nic_valid_size()`, add validation of the data in the respective
> handlers and return error values in case of failure. Release
> the skb if error values are returned from handlers in
> `nci_nft_packet` and effectively do a silent drop
> 
> Possible TODO: because we silently drop the packets, the
> call to `nci_request` will be waiting for completion of request
> and will face timeouts. These timeouts can get excessively logged
> in the dmesg. A proper handling of them may require to export
> `nci_request_cancel` (or propagate error handling from the
> nft packets handlers).
> 
> Reported-by: syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=740e04c2a93467a0f8c8
> Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation)
> Tested-by: syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
> Signed-off-by: Deepak Sharma <deepak.sharma.472935@gmail.com>
> ---
> v3:
>   - Move the checks inside the packet data handlers
>   - Improvements to the commit message
> 
> v2:
>   - Fix the release of skb in case of the early return
> 
> v1:
>   - Add checks in `nci_ntf_packet` on the skb->len and do early return
>     on failure
> 

LGTM,
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

