Return-Path: <stable+bounces-56322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 710A691F855
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 10:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE961F2307F
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 08:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F103114E2F1;
	Tue,  2 Jul 2024 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r4nfYCWT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9220914E2E9
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719908641; cv=none; b=Nl4wMb7hKGhlI04EBgFZWCKZZFqS9GE2raDmeJ6z7kIZkQk2UY4mGm0roCNEgJAB0na7oTDoz8n9elLU3kIZSEsq1D26asqIHlrse6HYMhnl/0aHMJmXtGIg2iUlsn1OaXMsZS6LKRxR4qv0afH5irnX5yNS9aWgw+mTheTA5lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719908641; c=relaxed/simple;
	bh=HwuNYHhAlzi0weewNtA+GrJQ2bgQUTsIRBGXlc4jmqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTBuM+Gx2yP1RNeMHug4R30yfJ04IRmeXtg+d5JNB7ouWCCHVIhQrrr2IbJb7feKotXpGighh/0yOvHqZDjtTCqDIRh85bfWMxkJyp1Bd9SdoqOw48bR/B7QjNROWmxX9cEVeknttpFddHcITeqv4B9QN4yLHwbSOphMvhlYAyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r4nfYCWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C93C32781;
	Tue,  2 Jul 2024 08:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719908641;
	bh=HwuNYHhAlzi0weewNtA+GrJQ2bgQUTsIRBGXlc4jmqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4nfYCWT1+J0mPm9uDfzNSxZAN3aTyOSIGZvAtS7qc4lMZuBkYWLRqiA9vBs7Q3SS
	 2i5+zmACdi7ysz3rW1QDiuZH+BPlHXQ+KMh6NuQ9jYjRxIayisfht6zjcdGjKv+EYw
	 HZSepn1empIyvJKv/9byTT585VFs0UTEt2BdFHRo=
Date: Tue, 2 Jul 2024 10:23:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: stable@vger.kernel.org, alikernel-developer@linux.alibaba.com,
	Dust Li <dust.li@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>, mqaio@linux.alibaba.com
Subject: Re: Please backport d8616ee2affc ("bpf, sockmap: Fix
 sk->sk_forward_alloc warn_on in sk_stream_kill_queues") to linux-5.10.y
Message-ID: <2024070225-dictation-rebuff-be4b@gregkh>
References: <d11bc7e6-a2c7-445a-8561-3599eafb07b0@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d11bc7e6-a2c7-445a-8561-3599eafb07b0@linux.alibaba.com>

On Sun, Jun 30, 2024 at 08:55:56PM +0800, Wen Gu wrote:
> Hi stable team,
> 
> Could you please backport [1] to linux-5.10.y?
> 
> I noticed a regression caused by [2], which was merged to linux-5.10.y since v5.10.80.
> 
> After sock_map_unhash() helper was removed in [2], sock elems added to the bpf sock map
> via sock_hash_update_common() cannot be removed if they are in the icsk_accept_queue
> of the listener sock. Since they have not been accept()ed, they cannot be removed via
> sock_map_close()->sock_map_remove_links() either.
> 
> It can be reproduced in network test with short-lived connections. If the server is
> stopped during the test, there is a probability that some sock elems will remain in
> the bpf sock map.
> 
> And with [1], the sock_map_destroy() helper is introduced to invoke sock_map_remove_links()
> when inet_csk_listen_stop()->inet_child_forget()->inet_csk_destroy_sock(), to remove the
> sock elems from the bpf sock map in such situation.
> 
> [1] d8616ee2affc ("bpf, sockmap: Fix sk->sk_forward_alloc warn_on in sk_stream_kill_queues")
> (link: https://lore.kernel.org/all/20220524075311.649153-1-wangyufen@huawei.com/)
> [2] 8b5c98a67c1b ("bpf, sockmap: Remove unhash handler for BPF sockmap usage")
> (link: https://lore.kernel.org/all/20211103204736.248403-3-john.fastabend@gmail.com/)

As there is fuzz with this patch, please send a backported, and tested,
version of this patch so we can include it and properly show who it was
requested from.

thanks,

greg k-h

