Return-Path: <stable+bounces-95951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6939DFD86
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 10:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49AD282B86
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 09:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41261F9F5D;
	Mon,  2 Dec 2024 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rlGdVCuo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D34381AA
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132800; cv=none; b=aDIq0aCykqwRKWRZN43IKrk8o4Q4SSOWSJVPPOK/hjvuwx0DYZnphSXV9E/oby0wfapbcbluKVu6uANaeP8eENiLbnP7+aexSoc6r+mKIOL4+gNr+O9capI/HaKGlTZIJEBdSOP+tv5DWT9pqWMxm4pWkuyhwe62DRb/JJ2LYD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132800; c=relaxed/simple;
	bh=wiHrQpS7kzxWIoB6aQ1C5cUPcQZ7TqyqyKy2FIVNT8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7TN1rRR2PhM0dxraOZaW7Bhe5hrMZ276+0CPNkHbJw8TOGRwMKhJ+NRVaBFIcuBVSx3tiP74tn3PnijSIDKyfFvlI7Ujk+vZdVy9pYbhy3DPbiXAVNTPvRoDO0NIv83+2XXuGUaZqibyROOeP0YFhkkhxiiX3TWNNdnRxqAjlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rlGdVCuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78187C4CED2;
	Mon,  2 Dec 2024 09:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733132799;
	bh=wiHrQpS7kzxWIoB6aQ1C5cUPcQZ7TqyqyKy2FIVNT8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rlGdVCuoCG+me94lUOrkNW1xAuRV7ddUFcHeoSkgMzQSePF2hAk7BgjFk7X8UXW7O
	 ycmtxLflpHQUn8VNHxidnKGbJIKrMNfTjZexaf3kJkAc7DhIp7lz2rqJTyIU932yTZ
	 jbzGQ93guMu/mRJL2vdh7dfuwbGMIHAI7OSefPwk=
Date: Mon, 2 Dec 2024 10:46:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ziwei Xiao <ziweixiao@google.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, pkaligineedi@google.com,
	hramamurthy@google.com
Subject: Re: [PATCH 6.1] gve: Fixes for napi_poll when budget is 0
Message-ID: <2024120230-wildcat-pumice-f0ce@gregkh>
References: <20241126184731.2497956-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126184731.2497956-1-ziweixiao@google.com>

On Tue, Nov 26, 2024 at 06:47:31PM +0000, Ziwei Xiao wrote:
> Netpoll will explicitly pass the polling call with a budget of 0 to
> indicate it's clearing the Tx path only. For the gve_rx_poll and
> gve_xdp_poll, they were mistakenly taking the 0 budget as the indication
> to do all the work. Add check to avoid the rx path and xdp path being
> called when budget is 0. And also avoid napi_complete_done being called
> when budget is 0 for netpoll.
> 
> The original fix was merged here:
> https://lore.kernel.org/r/20231114004144.2022268-1-ziweixiao@google.com
> Resend it since the original one was not cleanly applied to 6.1 kernel.
> 
> Fixes: f5cedc84a30d ("gve: Add transmit and receive support")
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_main.c | 7 +++++++
>  drivers/net/ethernet/google/gve/gve_rx.c   | 4 ----
>  drivers/net/ethernet/google/gve/gve_tx.c   | 4 ----
>  3 files changed, 7 insertions(+), 8 deletions(-)
> 

No git id? :(

