Return-Path: <stable+bounces-125576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DD4A693D7
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106713B1598
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D521D79B8;
	Wed, 19 Mar 2025 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WS9tYJEx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017D61D5CF9;
	Wed, 19 Mar 2025 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398634; cv=none; b=txji9lxuPvk4kHBsQoTIlbwcDOOpbuxc2xyMQERmQUCT5sgTazjbUYoVEHuyPSNwVz+eU3nK0qm8dg99UUYFGvAEzWx1o5OlxsKJQWheRrdwn4CwQ0gRyh4vL5hyeC8A0632m6daqY1Q2F+mal2HKPQtEtZkLcnk8gUGkMxqH+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398634; c=relaxed/simple;
	bh=83bujgNrQMKv2tBRheguoh8xgosbiV/jEvNTMO/lef8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBGGEJHGq+uwXhyoFnK3Iw1g8GYlNDfIPbLRadIy+IfMb8GJmXizl+aHjVUMxs6Cn1apEqrHbY64qeJPocgto1yivbFkiQkHMoy5KlhuHYi5kThbvpjOYy1sokzCkL8CqHJbxT9ac4o4sXWaHfX0S+w/+rpj/7+3DfO0zhQVDSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WS9tYJEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3347DC4CEEA;
	Wed, 19 Mar 2025 15:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742398633;
	bh=83bujgNrQMKv2tBRheguoh8xgosbiV/jEvNTMO/lef8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WS9tYJExgn75ZVlX3FwX7jiNdk569mkWlRGYUoJgUkjb1AX/WFjOPPvINruexgBKz
	 M8XCNgSBUJNPDLGRoC24uFdfIW46An81dsD3p/N4rJNaXo+6ftN190gbB99EqGA0ep
	 D0qNSgF/Tfxrvzx0AJj8s5Nb8rR7D16VOm4lC+buvA1QIXFi7gxTqLamZuzYzmzPrl
	 blNQliVD2qaiB5rlIVMPKqimYoZlbkxrE62aVk1Unl9X+uVX/RLNUI6B9ouTtANOkE
	 Z/PmZsXrtOZa64Ln7YWiAOq1x9O76X4gnZzLtkImtLHWntK3GowD3UUkZULLjNRhvl
	 dZGAUn1u3wVdg==
Date: Wed, 19 Mar 2025 15:37:05 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arthur Mongodin <amongodin@randorisec.fr>, stable@vger.kernel.org
Subject: Re: [PATCH net 1/3] mptcp: Fix data stream corruption in the address
 announcement
Message-ID: <20250319153705.GB768132@kernel.org>
References: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-0-122dbb249db3@kernel.org>
 <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-1-122dbb249db3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-1-122dbb249db3@kernel.org>

On Fri, Mar 14, 2025 at 09:11:31PM +0100, Matthieu Baerts (NGI0) wrote:
> From: Arthur Mongodin <amongodin@randorisec.fr>
> 
> Because of the size restriction in the TCP options space, the MPTCP
> ADD_ADDR option is exclusive and cannot be sent with other MPTCP ones.
> For this reason, in the linked mptcp_out_options structure, group of
> fields linked to different options are part of the same union.
> 
> There is a case where the mptcp_pm_add_addr_signal() function can modify
> opts->addr, but not ended up sending an ADD_ADDR. Later on, back in
> mptcp_established_options, other options will be sent, but with
> unexpected data written in other fields due to the union, e.g. in
> opts->ext_copy. This could lead to a data stream corruption in the next
> packet.
> 
> Using an intermediate variable, prevents from corrupting previously
> established DSS option. The assignment of the ADD_ADDR option
> parameters is now done once we are sure this ADD_ADDR option can be set
> in the packet, e.g. after having dropped other suboptions.
> 
> Fixes: 1bff1e43a30e ("mptcp: optimize out option generation")
> Cc: stable@vger.kernel.org
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Arthur Mongodin <amongodin@randorisec.fr>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> [ Matt: the commit message has been updated: long lines splits and some
>   clarifications. ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


