Return-Path: <stable+bounces-125577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BB7A693BF
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D4E17493C
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D601D5161;
	Wed, 19 Mar 2025 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5LHvrIL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969C01B2194;
	Wed, 19 Mar 2025 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398716; cv=none; b=EjpOdSHTUhLNgQKx8pqxAWqQJJNYTl5wBoV8t7lWeRQAhNhDfmUpgTjd/ubZuktu7m5LKzOXAwao+SftqWG+rbQEtMqGi7oa1V1Jp0Pk+BPuBhCQ/Flx4mAyUpCgR+qPDQhgUToGyz67asYx38LZmmsl/QUQ1Wn53EM88TSucu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398716; c=relaxed/simple;
	bh=as2ZkZvOluIbSg38wCPRNZQ5xEj8hkiuVt3mJbCXsao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGNhc3yPtabS5WObf3lmMZF6FWbZtNkTRhF9PozBIcXKTSIEVvey00hJ/J+0olu1UoQImTxQVsyO2UUjk8W19B2rEcz3MFmSs0IJd6ABeLcMhJMmyI1/HId+uXlyAt0FX2mICsKh25Ii7al31PljsuY9QsiNnItKyZweffX21N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5LHvrIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804DBC4CEE4;
	Wed, 19 Mar 2025 15:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742398715;
	bh=as2ZkZvOluIbSg38wCPRNZQ5xEj8hkiuVt3mJbCXsao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R5LHvrILkseNYAW1bWJ3owkyzvyT6NLQiaLDNWIkbrqR6hN+AVvYSdkk4jwoy2rEk
	 46aa1PmG5X/nc1ZhUY81ejmMB38aQjGNkun9p/M67+Ou6R/BRQHbLZ/UfJwaizhPdf
	 MA6/e0wjMZSG657f97PgzPuFCSmeGTXiU/tpYE9cm8SWJZ63EYdPvmqyOj26hRfqbp
	 Ym1XmHLAN9d24mKPQz95IIfCFsQvU0ddpkbPBgmhGHOiAUrGk2xmsoTa76BpZ1yWL1
	 F0f20lXIp9kp/qKUgGCcUVYBYOiBgM5xEUc3O+CtaMI2x/vkCFiZbRdBOpJn+2qGoq
	 CjscnfQoUZb7w==
Date: Wed, 19 Mar 2025 15:38:27 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 2/3] mptcp: sockopt: fix getting IPV6_V6ONLY
Message-ID: <20250319153827.GC768132@kernel.org>
References: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-0-122dbb249db3@kernel.org>
 <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-2-122dbb249db3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-2-122dbb249db3@kernel.org>

On Fri, Mar 14, 2025 at 09:11:32PM +0100, Matthieu Baerts (NGI0) wrote:
> When adding a socket option support in MPTCP, both the get and set parts
> are supposed to be implemented.
> 
> IPV6_V6ONLY support for the setsockopt part has been added a while ago,
> but it looks like the get part got forgotten. It should have been
> present as a way to verify a setting has been set as expected, and not
> to act differently from TCP or any other socket types.
> 
> Not supporting this getsockopt(IPV6_V6ONLY) blocks some apps which want
> to check the default value, before doing extra actions. On Linux, the
> default value is 0, but this can be changed with the net.ipv6.bindv6only
> sysctl knob. On Windows, it is set to 1 by default. So supporting the
> get part, like for all other socket options, is important.
> 
> Everything was in place to expose it, just the last step was missing.
> Only new code is added to cover this specific getsockopt(), that seems
> safe.
> 
> Fixes: c9b95a135987 ("mptcp: support IPV6_V6ONLY setsockopt")
> Cc: stable@vger.kernel.org
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/550
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Hi Matthieu, all,

TBH, I would lean towards this being net-next material rather than a fix
for net. But that notwithstanding this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

