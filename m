Return-Path: <stable+bounces-194699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A3CC586DA
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 16:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CBEDC352ECA
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B472E8DEA;
	Thu, 13 Nov 2025 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRrfucok"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70930264F81;
	Thu, 13 Nov 2025 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047202; cv=none; b=t+5ZIvc1yJxuD3ua+Dk2TlijkaGcufZoyORnd2QZGHIUB7NbTmkS0srNge638AWLQxcmSNafFAvSty07HPp5pVmGWHYm6Led0g640COMXLuyaNwsNQMVqdQM6eQW63WoRkHihZIG9GpIyg+C9KG/gRZ28zZmxdyY1Sie3JwvBO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047202; c=relaxed/simple;
	bh=lWYhbavprkT3U9nZXKkesHRb9Y0PC/NemTNV0+uAcaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=diq56RwR5JZfROGbNKRG889MWFFFpZFTj5O5WV4S6VhqhhPBNA3A7UZvrrb9rR6xG6vSV+LfKpgSOhPkIW6uEr4BaTopRlkcWB9sPNpWrPacSVkKUnoGKm72gye5NiFHhhRwcOUFwRWO/rd//TFD0QA3BBuGsnFzivxoucYwIqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRrfucok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D70C4CEF8;
	Thu, 13 Nov 2025 15:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763047200;
	bh=lWYhbavprkT3U9nZXKkesHRb9Y0PC/NemTNV0+uAcaI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mRrfucok2Ntrq4u+nF5na/T140QwG94RXgPIwX81QtT+ro5IOP+JfWj4ExGTKDhpx
	 wibxCg+MXTvxezSyilx4YcnEUl2nrVNiPe0S9TRcCabAdRp2o4l0XpB3/XSFwmQgpc
	 OfGQDutQ0FPEm3b+75eM7/OZggIfuz5PrXnZrG0zhRu89IPTeTdwLcPNwQtZdS4m6Y
	 uh69YNf6UlBqJwMCeehbf0UJfQTBW9KehJICFpyKw//SpnF7iYLLlHwKYQ8dCruXjp
	 SqVxdSx0xRmCyuqQtXtN9vxctyv7x44xuJlmat8klBW7nZ2h8WHWu86CjwzF6UySbt
	 W4hSuuf6dyNWQ==
Message-ID: <48bbe998-982c-4dbd-b261-83c076ebcb7a@kernel.org>
Date: Thu, 13 Nov 2025 16:19:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: Patch "mptcp: drop bogus optimization in __mptcp_check_push()"
 has been added to the 5.15-stable tree
Content-Language: en-GB, fr-BE
To: gregkh@linuxfoundation.org, sashal@kernel.org
Cc: stable-commits@vger.kernel.org, geliang@kernel.org, kuba@kernel.org,
 martineau@kernel.org, pabeni@redhat.com,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 MPTCP Linux <mptcp@lists.linux.dev>
References: <2025110310-scapegoat-magnetic-3cf8@gregkh>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2025110310-scapegoat-magnetic-3cf8@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg, Sasha,

On 03/11/2025 02:38, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     mptcp: drop bogus optimization in __mptcp_check_push()
> 
> to the 5.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      mptcp-drop-bogus-optimization-in-__mptcp_check_push.patch
> and it can be found in the queue-5.15 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Can you please drop this patch from v5.15? It looks like it is causing
some issues with MP_PRIO tests. I think that's because back then, the
path is selected differently, with the use of 'msk->last_snd' which will
bypass some decisions to where to send the next data.

I will try to check if another version of this patch is needed for v5.15.

Cheers,
Matt


(I kept the patch below just in case some people from the MPTCP ML want
to react.)

> From stable+bounces-192087-greg=kroah.com@vger.kernel.org Mon Nov  3 05:15:58 2025
> From: Sasha Levin <sashal@kernel.org>
> Date: Sun,  2 Nov 2025 15:15:50 -0500
> Subject: mptcp: drop bogus optimization in __mptcp_check_push()
> To: stable@vger.kernel.org
> Cc: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
> Message-ID: <20251102201550.3588174-1-sashal@kernel.org>
> 
> From: Paolo Abeni <pabeni@redhat.com>
> 
> [ Upstream commit 27b0e701d3872ba59c5b579a9e8a02ea49ad3d3b ]
> 
> Accessing the transmit queue without owning the msk socket lock is
> inherently racy, hence __mptcp_check_push() could actually quit early
> even when there is pending data.
> 
> That in turn could cause unexpected tx lock and timeout.
> 
> Dropping the early check avoids the race, implicitly relaying on later
> tests under the relevant lock. With such change, all the other
> mptcp_send_head() call sites are now under the msk socket lock and we
> can additionally drop the now unneeded annotation on the transmit head
> pointer accesses.
> 
> Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Tested-by: Geliang Tang <geliang@kernel.org>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Link: https://patch.msgid.link/20251028-net-mptcp-send-timeout-v1-1-38ffff5a9ec8@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ split upstream __subflow_push_pending modification across __mptcp_push_pending and __mptcp_subflow_push_pending ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  net/mptcp/protocol.c |   13 +++++--------
>  net/mptcp/protocol.h |    2 +-
>  2 files changed, 6 insertions(+), 9 deletions(-)
> 
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1137,7 +1137,7 @@ static void __mptcp_clean_una(struct soc
>  			if (WARN_ON_ONCE(!msk->recovery))
>  				break;
>  
> -			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> +			msk->first_pending = mptcp_send_next(sk);
>  		}
>  
>  		dfrag_clear(sk, dfrag);
> @@ -1674,7 +1674,7 @@ void __mptcp_push_pending(struct sock *s
>  
>  			mptcp_update_post_push(msk, dfrag, ret);
>  		}
> -		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> +		msk->first_pending = mptcp_send_next(sk);
>  	}
>  
>  	/* at this point we held the socket lock for the last subflow we used */
> @@ -1732,7 +1732,7 @@ static void __mptcp_subflow_push_pending
>  
>  			mptcp_update_post_push(msk, dfrag, ret);
>  		}
> -		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> +		msk->first_pending = mptcp_send_next(sk);
>  	}
>  
>  out:
> @@ -1850,7 +1850,7 @@ static int mptcp_sendmsg(struct sock *sk
>  			get_page(dfrag->page);
>  			list_add_tail(&dfrag->list, &msk->rtx_queue);
>  			if (!msk->first_pending)
> -				WRITE_ONCE(msk->first_pending, dfrag);
> +				msk->first_pending = dfrag;
>  		}
>  		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d\n", msk,
>  			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,
> @@ -2645,7 +2645,7 @@ static void __mptcp_clear_xmit(struct so
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	struct mptcp_data_frag *dtmp, *dfrag;
>  
> -	WRITE_ONCE(msk->first_pending, NULL);
> +	msk->first_pending = NULL;
>  	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list)
>  		dfrag_clear(sk, dfrag);
>  }
> @@ -3114,9 +3114,6 @@ void __mptcp_data_acked(struct sock *sk)
>  
>  void __mptcp_check_push(struct sock *sk, struct sock *ssk)
>  {
> -	if (!mptcp_send_head(sk))
> -		return;
> -
>  	if (!sock_owned_by_user(sk)) {
>  		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
>  
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -325,7 +325,7 @@ static inline struct mptcp_data_frag *mp
>  {
>  	const struct mptcp_sock *msk = mptcp_sk(sk);
>  
> -	return READ_ONCE(msk->first_pending);
> +	return msk->first_pending;
>  }
>  
>  static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


