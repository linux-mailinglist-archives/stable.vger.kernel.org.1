Return-Path: <stable+bounces-180558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D238B85F08
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 18:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A47767A8DA3
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 16:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FFD307AFE;
	Thu, 18 Sep 2025 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xodd5kAz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E9D220F5C;
	Thu, 18 Sep 2025 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212289; cv=none; b=YNu6Uit+44TAWoBpS9FqidR78QqeRAklqsuyOA7jBxG6aZfp5EVwtZFjkfg/NGSESfxRo8jOZGPVEe5jhqgeqKgfkc9kmDvDk+lb8M5GwpzDynBFXkBROjj2fMVA/F4rOd8mVCUTEQb+9K0CaWIg62cf4Hx2fT68QUGcSxGHiuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212289; c=relaxed/simple;
	bh=2txUjo5Nz+BSEMezG0q7gafb7Kyc4NK7ms7exwCmsW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUg4d/xQpp9ZsOLp9f7NVJL0wk5/USqI1P8zDCuVphpmcd73tX7GDpEuLKRieQ9JBO1Cj1VSBhuqj97RlfJO7hIW34AwuCMwk56KTZrJF8sGD+6Dd9Uf9PtrvZLtcuVzx8i0v8RvIOFxzkvIEC8706bUCAa54lowpxg3KIF9XcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xodd5kAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F107C4CEFA;
	Thu, 18 Sep 2025 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758212288;
	bh=2txUjo5Nz+BSEMezG0q7gafb7Kyc4NK7ms7exwCmsW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xodd5kAzjKSidzcOwUfy/6fgewF1HGJQg72D3CA1Jfn8yaBXgmNHGhwtZHLH6tZTs
	 06RrRksv86C9A5p//EY0jBHNijSo+rlFqmRQJy0ito+YkSHKxP180UwDIFBYORUhfc
	 7GWw8+4ctW8ex87yLMEMNtGFIxW9+rafkTppCi5t+VAZidIByTxkOY6k29NzrXcZR6
	 N6tSkfKNF/Pq6cYOezPUtu6tQBYxiKGnljn2xi3VcxNTPZCOVSd7yIN4AgK0CvTewq
	 FiHMhxNmvVDSBqwatqRTcG/vuOrVX8IwOrujatiodc+NR/4qu/GDxLDSlfmw98yU+8
	 yM4OfmaxoflDQ==
Date: Thu, 18 Sep 2025 17:18:04 +0100
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net-next] mptcp: reset blackhole on success with
 non-loopback ifaces
Message-ID: <20250918161804.GZ394836@horms.kernel.org>
References: <20250918-net-next-mptcp-blackhole-reset-loopback-v1-1-bf5818326639@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-net-next-mptcp-blackhole-reset-loopback-v1-1-bf5818326639@kernel.org>

On Thu, Sep 18, 2025 at 10:50:18AM +0200, Matthieu Baerts (NGI0) wrote:
> When a first MPTCP connection gets successfully established after a
> blackhole period, 'active_disable_times' was supposed to be reset when
> this connection was done via any non-loopback interfaces.
> 
> Unfortunately, the opposite condition was checked: only reset when the
> connection was established via a loopback interface. Fixing this by
> simply looking at the opposite.
> 
> This is similar to what is done with TCP FastOpen, see
> tcp_fastopen_active_disable_ofo_check().
> 
> This patch is a follow-up of a previous discussion linked to commit
> 893c49a78d9f ("mptcp: Use __sk_dst_get() and dst_dev_rcu() in
> mptcp_active_enable()."), see [1].
> 
> Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/4209a283-8822-47bd-95b7-87e96d9b7ea3@kernel.org [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Note: sending this fix to net-next, similar to commits 108a86c71c93
> ("mptcp: Call dst_release() in mptcp_active_enable().") and 893c49a78d9f
> ("mptcp: Use __sk_dst_get() and dst_dev_rcu() in mptcp_active_enable().").
> Also to avoid conflicts, and because we are close to the merge windows.

Reviewed-by: Simon Horman <horms@kernel.org>

