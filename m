Return-Path: <stable+bounces-56321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94C291F30F
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 10:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B084B21C38
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 08:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADB314B950;
	Tue,  2 Jul 2024 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T53a1L4b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5A116419
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719908577; cv=none; b=h+i7sD/Vx5HWCBayqYkpbfsUPDSXZknSFgIxv03tCo1dP9r+dypt8CSfK6VgbFcNi0s2sGimQsDssCLDsp6Z+wx6kBdoKD3uH6o2tqmpkzLHLlRip13YTfQgd+elBI/FoU+jIvja0iApQCj7SNhRVWwLTn5m+ICIqltX4TwGyXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719908577; c=relaxed/simple;
	bh=c3WJZ4kCJmtSs2qMg3I9PyF6yTxnaIAVtvLfjy2xJ0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qM71DtEGSfysQKd8x4tgqvFqLe5j+HJPfnCm5m3AkXjj7S4UGOa8YArCtHXNfE2ePkCcVhowk2walX+HYw2EAFXV8riGL0MDTwsSN/89Yf4dfEoiK0o8Zlqw7sFw9PbtSKo3+4SaMETYBeyJVayRYRWpPhOCaYc7z0hGiQW/1zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T53a1L4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0B8C116B1;
	Tue,  2 Jul 2024 08:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719908576;
	bh=c3WJZ4kCJmtSs2qMg3I9PyF6yTxnaIAVtvLfjy2xJ0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T53a1L4bQWulJ/rNTXwOM15foT0jALhUTSEHTCLYPSZdIuOA0Y6WCkzvFo71MpbnL
	 VkBZ7ADYOYEeDK5IbCaSaF5fQ0T4PQzlCvF+9+fZ8OKEs/sJZ6ZSpwVcFfDOXAmDfH
	 0KhjgWyl+oe14beukPEr6voCXzA0Wini/wixV2r0=
Date: Tue, 2 Jul 2024 10:22:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: stable@vger.kernel.org, alikernel-developer@linux.alibaba.com,
	Dust Li <dust.li@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>, mqaio@linux.alibaba.com
Subject: Re: Please backport d8616ee2affc ("bpf, sockmap: Fix
 sk->sk_forward_alloc warn_on in sk_stream_kill_queues") to linux-5.10.y
Message-ID: <2024070221-clergyman-oversold-d24a@gregkh>
References: <d11bc7e6-a2c7-445a-8561-3599eafb07b0@linux.alibaba.com>
 <e66d3dd0-4d16-463f-a567-b5f5f8da6a92@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e66d3dd0-4d16-463f-a567-b5f5f8da6a92@linux.alibaba.com>

On Tue, Jul 02, 2024 at 10:07:56AM +0800, Wen Gu wrote:
> 
> 
> On 2024/6/30 20:55, Wen Gu wrote:
> > Hi stable team,
> > 
> > Could you please backport [1] to linux-5.10.y?
> > 
> > I noticed a regression caused by [2], which was merged to linux-5.10.y since v5.10.80.
> > 
> > After sock_map_unhash() helper was removed in [2], sock elems added to the bpf sock map
> > via sock_hash_update_common() cannot be removed if they are in the icsk_accept_queue
> > of the listener sock. Since they have not been accept()ed, they cannot be removed via
> > sock_map_close()->sock_map_remove_links() either.
> > 
> > It can be reproduced in network test with short-lived connections. If the server is
> > stopped during the test, there is a probability that some sock elems will remain in
> > the bpf sock map.
> > 
> > And with [1], the sock_map_destroy() helper is introduced to invoke sock_map_remove_links()
> > when inet_csk_listen_stop()->inet_child_forget()->inet_csk_destroy_sock(), to remove the
> > sock elems from the bpf sock map in such situation.
> > 
> > [1] d8616ee2affc ("bpf, sockmap: Fix sk->sk_forward_alloc warn_on in sk_stream_kill_queues")
> > (link: https://lore.kernel.org/all/20220524075311.649153-1-wangyufen@huawei.com/)
> > [2] 8b5c98a67c1b ("bpf, sockmap: Remove unhash handler for BPF sockmap usage")
> > (link: https://lore.kernel.org/all/20211103204736.248403-3-john.fastabend@gmail.com/)
> > 
> > Thanks!
> > Wen Gu
> 
> Hi stable team,
> 
> Just want to confirm that the backport of this patch is consistent with the stable tree rules
> as I thought. And is there any other information I need to provide? :)

Please relax, you sent this on Sunday and asked about it on Tuesday,
barely 1 day later?

greg k-h

