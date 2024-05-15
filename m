Return-Path: <stable+bounces-45128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 809EC8C61B0
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 09:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18B31C21D49
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 07:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F1843ABC;
	Wed, 15 May 2024 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1QoPqTuI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FA34316B
	for <stable@vger.kernel.org>; Wed, 15 May 2024 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758114; cv=none; b=VfN8of+s29uqr6I1J5cz3FWhGM7l2c/H7XJCjQk3/pjsEoer34W04W6y9cT791d4roJoifwdO0fff2yylEd9Esgkddgl36QhykPL3KVZ9bfSN9AvRuvJVDIU14tC8QXJv9tQJ/iIYPlqx8h+KEpYasXRGJTbzwCiL9xqlnY2rLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758114; c=relaxed/simple;
	bh=UzGsJREsrm5TsgJkDsjQE+/P0Hg32vH0deHEFYLx9jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhuww/hwPs2FruRb24nfVtri2hRg9/1m04SBxuMSK7rHoaShWX/rbe8BsWRJ4xwplwpsk54vBwjGj/ybFcry1ix0dPt8Wl4DlN2iX2Rsq4D4bjOZvAuUi7WQpdAS4EFWEeKlUskwUcoT6VfmVPoXZPoE0pUJecH5eB83H3BYvWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1QoPqTuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F73C116B1;
	Wed, 15 May 2024 07:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715758114;
	bh=UzGsJREsrm5TsgJkDsjQE+/P0Hg32vH0deHEFYLx9jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1QoPqTuIMe3rK+BG+0AJFNVEYXHZbud9XMQSQFMqXF4sYCV0DaRlhz4LlNeTn6foZ
	 ZfenlfwivzKWx8OklPNrTYQ1Qve95GY47/YfKGvGJOdZTeANjYN3WuQQgS91XmmX1L
	 VdiRmdqlKIZGDFdeAiLZAg11y0TN7kWBHWkzX1eA=
Date: Wed, 15 May 2024 09:28:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: stable@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
	Tony Luck <tony.luck@intel.com>, Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm,swapops: update check in is_pfn_swap_entry for
 hwpoison entries
Message-ID: <2024051523-transfer-buffed-7829@gregkh>
References: <2024042309-rural-overlying-190b@gregkh>
 <20240507092822.3460106-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507092822.3460106-1-linmiaohe@huawei.com>

On Tue, May 07, 2024 at 05:28:22PM +0800, Miaohe Lin wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> Tony reported that the Machine check recovery was broken in v6.9-rc1, as
> he was hitting a VM_BUG_ON when injecting uncorrectable memory errors to
> DRAM.
> 
> After some more digging and debugging on his side, he realized that this
> went back to v6.1, with the introduction of 'commit 0d206b5d2e0d
> ("mm/swap: add swp_offset_pfn() to fetch PFN from swap entry")'.  That
> commit, among other things, introduced swp_offset_pfn(), replacing
> hwpoison_entry_to_pfn() in its favour.
> 
> The patch also introduced a VM_BUG_ON() check for is_pfn_swap_entry(), but
> is_pfn_swap_entry() never got updated to cover hwpoison entries, which
> means that we would hit the VM_BUG_ON whenever we would call
> swp_offset_pfn() for such entries on environments with CONFIG_DEBUG_VM
> set.  Fix this by updating the check to cover hwpoison entries as well,
> and update the comment while we are it.
> 
> Link: https://lkml.kernel.org/r/20240407130537.16977-1-osalvador@suse.de
> Fixes: 0d206b5d2e0d ("mm/swap: add swp_offset_pfn() to fetch PFN from swap entry")
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Reported-by: Tony Luck <tony.luck@intel.com>
> Closes: https://lore.kernel.org/all/Zg8kLSl2yAlA3o5D@agluck-desk3/
> Tested-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Acked-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: <stable@vger.kernel.org>	[6.1.x]
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 07a57a338adb6ec9e766d6a6790f76527f45ceb5)
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/swapops.h | 105 ++++++++++++++++++++--------------------
>  1 file changed, 53 insertions(+), 52 deletions(-)

Now queued up, thanks.

greg k-h

