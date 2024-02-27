Return-Path: <stable+bounces-23884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4892868D68
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 11:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F43F1C22F1E
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 10:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BB7138485;
	Tue, 27 Feb 2024 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j8MOH3b/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB6A137C34;
	Tue, 27 Feb 2024 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029367; cv=none; b=t2hpFdJxm+VkzJ/DVp6C42wgg+kmwOZtNJ3xljqnqsmSCSjOx40PMb/5SNHEYV2bUOH8Nv0wItpFTXbYUeVa03LpVamhQMWZIFfEa3Ph8a0Hr8aHbDowWRLfv9t3Bz1qnpTVKePb/VV2+sUqTpqiGDgRquHpYtQVqmPY2C5HAng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029367; c=relaxed/simple;
	bh=qm8wFI+1Egat3oNnenRSK4qlJu5G+Cp4exr54+xDBiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0rHwvmJDo161jlGssSqgS+ts8oyBFQQ/gRxo+tzIDxev1JQzZa3YjW5DlVAE2qnl+qnFGE/kRZ0T9kw821U46YE/b0pKbebw6PkvylRsNh+8TWzIhhZpNjgsukv3DH6k+sZk4EHpaIoMlf+Q3f7cczvk7Z8tGy1GQJKB2UERx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j8MOH3b/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8178C433C7;
	Tue, 27 Feb 2024 10:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709029367;
	bh=qm8wFI+1Egat3oNnenRSK4qlJu5G+Cp4exr54+xDBiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j8MOH3b/WKzDkfzUyxkYLa3Pi+t5gogMbZ6rDLwqSMgruo7ApzCT5+oXSdnDSb78A
	 ShhZ+yr/melnfgL4sAFd0Dn0ziFvATQeHjr2O4u8wK3cYhgQQTO3C21dtcqx2V5drK
	 oakZuJL/b/SlpYPLqdtJftk7j73PF3mFfwJuWoCs=
Date: Tue, 27 Feb 2024 11:22:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Mat Martineau <martineau@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 6.6.y] mptcp: add needs_id for netlink appending addr
Message-ID: <2024022723-outshoot-unkind-734f@gregkh>
References: <2024022654-senate-unleaded-7ae3@gregkh>
 <20240226215620.757784-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226215620.757784-2-matttbe@kernel.org>

On Mon, Feb 26, 2024 at 10:56:21PM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Just the same as userspace PM, a new parameter needs_id is added for
> in-kernel PM mptcp_pm_nl_append_new_local_addr() too.
> 
> Add a new helper mptcp_pm_has_addr_attr_id() to check whether an address
> ID is set from PM or not.
> 
> In mptcp_pm_nl_get_local_id(), needs_id is always true, but in
> mptcp_pm_nl_add_addr_doit(), pass mptcp_pm_has_addr_attr_id() to
> needs_it.
> 
> Fixes: efd5a4c04e18 ("mptcp: add the address ID assignment bitmap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> (cherry picked from commit 584f3894262634596532cf43a5e782e34a0ce374)
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - conflicts in pm_netlink.c because the new helper function expected to
>    be on top of mptcp_pm_nl_add_addr_doit() which has been recently
>    renamed in commit 1e07938e29c5 ("net: mptcp: rename netlink handlers
>    to mptcp_pm_nl_<blah>_{doit,dumpit}").
>  - use mptcp_pm_addr_policy instead of mptcp_pm_address_nl_policy, the
>    new name after commit 1d0507f46843 ("net: mptcp: convert netlink from
>    small_ops to ops").
> ---
>  net/mptcp/pm_netlink.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)

Don't we also need a 5.15.y version of this commit?

All of the backports you sent are now queued up, thanks!

greg k-h

