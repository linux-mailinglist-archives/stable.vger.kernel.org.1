Return-Path: <stable+bounces-125579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AE3A693E6
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23EC882402
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C1D1D5161;
	Wed, 19 Mar 2025 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGiz8tZk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5931C0DED;
	Wed, 19 Mar 2025 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398789; cv=none; b=T5onyNK7NhJaefoQhFW83m4HBnct3kZbrecPbLOSIK7SN1HJUhhKSe8tyQkCNDGPL2SliQBA7noL2t+J+5BDnnxVvuIifnLrUc3yaXmsAYWevTUbDPSqyXnrsTdwno1ByKAJgU0WLI57x6Aisokb5vfUzKfD1Aa5+PQmc5me8WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398789; c=relaxed/simple;
	bh=83bujgNrQMKv2tBRheguoh8xgosbiV/jEvNTMO/lef8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1uodNWeLeS+sbYDAq9UBNaGcaATZmtwJ49PlCW+07Fm5YV90yPmx7hcuk9e5ivlL1bBmfR3tZatMDzdImgOnytT48L1UjTBNv/q8lUcB9782nnyq3+xG69/hPs7FmpQYn61T2WL/lhRAMe9FsdlQXc2KYAyBz4TmmRiBMpgotM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGiz8tZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537B7C4CEE4;
	Wed, 19 Mar 2025 15:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742398789;
	bh=83bujgNrQMKv2tBRheguoh8xgosbiV/jEvNTMO/lef8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lGiz8tZkOyg1dx9uk1AZdMn4SwY42ggxGjWYkHAeIybNN/aWCEPjyoYh7RcT27aoF
	 AzUG7yZL6yl7JiewcEpXS1YnQX5jTG2oBQW4KMJKeyYA5ukznPJdxQS2Jr5dx8VXPz
	 atmRIEjQHxUxJ+KYrNib9NLlEmqVwuc2ggAIXdOZD+9x4glCVqMmLjWb2ybs7gipzS
	 SR0gm3x8eS0O6qGnVWBpvH6G+jM6tu5oOl3PfLloiL368j5v+GwNdI/Y2gF9YqZUA1
	 W6YSHpgeu1VSbA9ubuXUtTkRJaCfGhtAD1jCt/YAjGHeD049wJEJJZ3uTGK+7gIGDa
	 jRBhNNMmOGebQ==
Date: Wed, 19 Mar 2025 15:39:41 +0000
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
Message-ID: <20250319153941.GE768132@kernel.org>
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


