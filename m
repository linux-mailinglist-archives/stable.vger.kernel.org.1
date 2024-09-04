Return-Path: <stable+bounces-73062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B3596C03A
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43F41F20FFE
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6E51DB929;
	Wed,  4 Sep 2024 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GSzytot1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884FF144316;
	Wed,  4 Sep 2024 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459705; cv=none; b=BkWhEnvpC+w0YbC84qjqIMdBjNIIdNPxIKU2TE47D8DNZ8s4hLqiNmj5BS+BwkjileICDxLo+jRVj8fES60O+dWjhhxfpeGAgq5BhiZf6uUdbb2FVQYMhK09BCGYU4iLB2k6QOH3Bo5KKUMPDeGo09Ws7JwjBHPpOhefNJvRFu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459705; c=relaxed/simple;
	bh=dIcoyQ4TPbYdiMU4v1ziu+Uxu266LzxsMwfPWRDPxLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3QcghyvDWxv4Au3RYqeToeb5I5gzHtDd78ehOdsRKBkqjl2a5jUp22Q6bRXHaNTTKHeisUz4Puqfmt6NTMKm6QAK3zaDCAk9T79pfb3ezUpI/u5y2Vkf5XREW0SjH+RWAypQ4MoxurPAi1CykTPKY8Z9obODaDprUyG64331uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GSzytot1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765DEC4CEC2;
	Wed,  4 Sep 2024 14:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725459705;
	bh=dIcoyQ4TPbYdiMU4v1ziu+Uxu266LzxsMwfPWRDPxLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GSzytot1Ei/gMrQX4jokWEMhaOlcp7A7bNpDJ21BkKt5NjM8oAVy3vGkyMaaMJof0
	 qSfKQw6cWWkJpivWklWQ+J7y8P+kd5z3xmaJXtEsyvc7fKRZyvAdteE5+yOSWzVj21
	 H8fOzJ6fxI6VDrBWyS3T7KrcEubHSj4dzInGg7AY=
Date: Wed, 4 Sep 2024 16:21:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.6.y] mptcp: avoid duplicated SUB_CLOSED events
Message-ID: <2024090439-sanction-unlimited-edd3@gregkh>
References: <2024083026-snooper-unbundle-373f@gregkh>
 <20240903101747.3377518-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240903101747.3377518-2-matttbe@kernel.org>

On Tue, Sep 03, 2024 at 12:17:48PM +0200, Matthieu Baerts (NGI0) wrote:
> commit d82809b6c5f2676b382f77a5cbeb1a5d91ed2235 upstream.
> 
> The initial subflow might have already been closed, but still in the
> connection list. When the worker is instructed to close the subflows
> that have been marked as closed, it might then try to close the initial
> subflow again.
> 
>  A consequence of that is that the SUB_CLOSED event can be seen twice:
> 
>   # ip mptcp endpoint
>   1.1.1.1 id 1 subflow dev eth0
>   2.2.2.2 id 2 subflow dev eth1
> 
>   # ip mptcp monitor &
>   [         CREATED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
>   [     ESTABLISHED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
>   [  SF_ESTABLISHED] remid=0 locid=2 saddr4=2.2.2.2 daddr4=9.9.9.9
> 
>   # ip mptcp endpoint delete id 1
>   [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
>   [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
> 
> The first one is coming from mptcp_pm_nl_rm_subflow_received(), and the
> second one from __mptcp_close_subflow().
> 
> To avoid doing the post-closed processing twice, the subflow is now
> marked as closed the first time.
> 
> Note that it is not enough to check if we are dealing with the first
> subflow and check its sk_state: the subflow might have been reset or
> closed before calling mptcp_close_ssk().
> 
> Fixes: b911c97c7dc7 ("mptcp: add netlink event support")
> Cc: stable@vger.kernel.org
> Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> [ Conflict in protocol.h due to commit f1f26512a9bf ("mptcp: use plain
>   bool instead of custom binary enum") and more that are not in this
>   version, because they modify the context and the size of __unused. The
>   conflict is easy to resolve, by not modifying data_avail type. ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/protocol.c | 6 ++++++
>  net/mptcp/protocol.h | 3 ++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e4d446f32761..ba6248372aee 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2471,6 +2471,12 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>  		     struct mptcp_subflow_context *subflow)
>  {
> +	/* The first subflow can already be closed and still in the list */
> +	if (subflow->close_event_done)
> +		return;
> +
> +	subflow->close_event_done = true;
> +
>  	if (sk->sk_state == TCP_ESTABLISHED)
>  		mptcp_event(MPTCP_EVENT_SUB_CLOSED, mptcp_sk(sk), ssk, GFP_KERNEL);
>  
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index ecbea95970f6..b9a4f6364b78 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -500,7 +500,8 @@ struct mptcp_subflow_context {
>  		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
>  		valid_csum_seen : 1,        /* at least one csum validated */
>  		is_mptfo : 1,	    /* subflow is doing TFO */
> -		__unused : 10;
> +		close_event_done : 1,       /* has done the post-closed part */
> +		__unused : 9;
>  	enum mptcp_data_avail data_avail;
>  	bool	scheduled;
>  	u32	remote_nonce;
> -- 
> 2.45.2
> 
> 

Now applied.

