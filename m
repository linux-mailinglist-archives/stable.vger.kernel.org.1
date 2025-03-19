Return-Path: <stable+bounces-125578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5DBA693DF
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCD31895505
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AADA1CD1E0;
	Wed, 19 Mar 2025 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvZ+f/1O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AD21AD3E5;
	Wed, 19 Mar 2025 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398770; cv=none; b=lSbUOjSFWn+eRdPFD4VHKGmpV8FVoaJxQcCGxuUXnuVV4Xj/CD9CQVmkUTEseMbNdxdotVdT8wNhfXcYcs0p7wJtLdZTI5UnWajYRICO1Mu6gDe8CEaXl5+h7w5gtfzPFk0yShp+gfjoAQ+qq4F05BSS68EaQ/6W2DIxSG44m/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398770; c=relaxed/simple;
	bh=o1ic6L1CqLNAJzp6vQKIGs1gmnQABp+JM0hSJcQ0/xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijmbEBe0+1iML6DMBJpoohWru5BHZ+i9JEacPEVhMQbG7KuD13cX/RXdbAwtVKFux7Q4e3h5Wol7z+sBcUc018ZtDQVeZrKhf35FlepozzTRf/SbXVxc7FBB9OKcHzqDpEoMIOYrb+RTIMmxTyc+PRiZjW/NFe586yk/FHTX21w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvZ+f/1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AA3C4CEE4;
	Wed, 19 Mar 2025 15:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742398769;
	bh=o1ic6L1CqLNAJzp6vQKIGs1gmnQABp+JM0hSJcQ0/xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvZ+f/1O2eD0Z+NMQDUBI6IF8i3o7RVjRyo+MFioyhjsiqRDuVD6SrqKgbF9OHOtN
	 m0XMDRV5vvdLyIAg90CF1osdk+4Dm5fflvIp13mAY5rfw2Cxdszx8PukY4AYjeUCGe
	 ASWL2hYQgjENWnCmUFMVo9pWODt5JvYoHQoNZIn+lT8vSuTaYfIhwWmx60BMNh3tFI
	 uywxxKc9/XcRTvnHkXaea8sy+nqRfs6OOIgLURlg6eVFaVHyx2/yJSpSR+vvureZaI
	 ojRm5dVWIshC0KJvPZNiScAs5H+fdaORvus+wlQ7k2eNUNodZG1iqxnPgdqyww7Lwb
	 jqJW8Ysw8iMfA==
Date: Wed, 19 Mar 2025 15:39:20 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 3/3] mptcp: sockopt: fix getting freebind &
 transparent
Message-ID: <20250319153920.GD768132@kernel.org>
References: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-0-122dbb249db3@kernel.org>
 <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-3-122dbb249db3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-3-122dbb249db3@kernel.org>

On Fri, Mar 14, 2025 at 09:11:33PM +0100, Matthieu Baerts (NGI0) wrote:
> When adding a socket option support in MPTCP, both the get and set parts
> are supposed to be implemented.
> 
> IP(V6)_FREEBIND and IP(V6)_TRANSPARENT support for the setsockopt part
> has been added a while ago, but it looks like the get part got
> forgotten. It should have been present as a way to verify a setting has
> been set as expected, and not to act differently from TCP or any other
> socket types.
> 
> Everything was in place to expose it, just the last step was missing.
> Only new code is added to cover these specific getsockopt(), that seems
> safe.
> 
> Fixes: c9406a23c116 ("mptcp: sockopt: add SOL_IP freebind & transparent options")
> Cc: stable@vger.kernel.org
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Hi Matthieu, all,

As per my comment on patch 2/3, I would lean towards this being net-next
material rather than a fix for net. But that notwithstanding this looks
good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


