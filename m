Return-Path: <stable+bounces-95950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B463B9DFD84
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 10:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A57D282B4F
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 09:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAE01F9EB9;
	Mon,  2 Dec 2024 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oBl25Pkp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93E41F949
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132788; cv=none; b=EfA5YwpdgFGd71sCsHVLX/mFng+Lg9j3gn6kz1nYGOJC7S5LKiCnnG0jXXNJSrg0eqNWJHwSuH+0nHSUktju5KXCvUrdpzPhUPJ2aQ0V/yqknzUluFA++d1Wexie2A0+a3X2fM5YinLC2STOMkI3kezCQhB8i5UisGrs9pppXqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132788; c=relaxed/simple;
	bh=BXhoS0I2UqiljgQEYwbd6q0mLveGqS0zuTrXWb015d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkkNdZiLTIpRsHIPOTUOVL1rO3LeupDyI8nMPyJpHTvjllhSmJeUtx1czItNvM2VQBnTh7T4T61G6mqBonOufdwqlffvxnKl1YTK/sl6dnXR8PJbzu9FdkxB9O5YhTb7JZG4MlOz1cS7H8/RK855hh/a0XuWpfAGsjwEFDauylU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oBl25Pkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8059C4CED2;
	Mon,  2 Dec 2024 09:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733132788;
	bh=BXhoS0I2UqiljgQEYwbd6q0mLveGqS0zuTrXWb015d8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oBl25PkpQvyMmvTE1MiZ4OFm5Z7lX+md/xwhNnQJMdfBzghAM6+GIPUu9F757u8Tn
	 WWrUGW+3sYP200WoS8fZAkc3+oDNocLlwqmszAMr0EHXYAlFVEltjBEK8fi54KPvQZ
	 iATpjD8PIgk+woqyROL9uKfERtkb66FIIvAhCbWQ=
Date: Mon, 2 Dec 2024 10:46:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ziwei Xiao <ziweixiao@google.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, pkaligineedi@google.com,
	hramamurthy@google.com
Subject: Re: [PATCH 5.15] gve: Fixes for napi_poll when budget is 0
Message-ID: <2024120216-gains-available-f94f@gregkh>
References: <20241126191922.2504882-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126191922.2504882-1-ziweixiao@google.com>

On Tue, Nov 26, 2024 at 07:19:22PM +0000, Ziwei Xiao wrote:
> Netpoll will explicitly pass the polling call with a budget of 0 to
> indicate it's clearing the Tx path only. For the gve_rx_poll and
> gve_xdp_poll, they were mistakenly taking the 0 budget as the indication
> to do all the work. Add check to avoid the rx path and xdp path being
> called when budget is 0. And also avoid napi_complete_done being called
> when budget is 0 for netpoll.
> 
> The original fix was merged here:
> https://lore.kernel.org/r/20231114004144.2022268-1-ziweixiao@google.com
> Resend it since the original one was not cleanly applied to 5.15 kernel.
> 
> Fixes: f5cedc84a30d ("gve: Add transmit and receive support")
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> ---

No git id?  :(

