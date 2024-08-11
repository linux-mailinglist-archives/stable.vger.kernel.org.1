Return-Path: <stable+bounces-66372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC88B94E1F5
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 17:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87C76B20E44
	for <lists+stable@lfdr.de>; Sun, 11 Aug 2024 15:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5CC14A624;
	Sun, 11 Aug 2024 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1a+vO72"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEE07F6;
	Sun, 11 Aug 2024 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723391185; cv=none; b=BPl+fQL9BjF4gvI1cBdaOpmuOH5XnRel0BF+7H3hiw/PMFcAzAOBAXXZDhiK+6YBN8/1QD7/Rug6Tp7h6cJZJbm5GuK3tJNW3nY6YnXaIbGZFwSpOgzVYxXVx4p6sZmJbjM0fsZ0FYBN3qll4OeOi86PI9rBjGzawRAEc+koU8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723391185; c=relaxed/simple;
	bh=CRfYkOqSSRpBV+j9j3p2R9tMob7B7SdfSAEcSEsyNQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUCFGJkoa7nWUJqAPIiyFlRjeKKL5ZA3M/N9JeKZJrFERerJTveqwm0YKiL0cCPViratZKVxURZ2+VLtZAEG6FcNOCuGKkq+2PvWmHjrTJHGJWJxNevrByTraoDUE7c71WzGLanrlXCkqNLSRrMdP3XgMeEkKYbllCURXSSOgHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1a+vO72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59DCC4AF0F;
	Sun, 11 Aug 2024 15:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723391185;
	bh=CRfYkOqSSRpBV+j9j3p2R9tMob7B7SdfSAEcSEsyNQU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e1a+vO722KWhKRzsdkSJMV2E/OitihmExzLmMEoBs9cBlq1Pba3dixj1qqC68t+vc
	 hA8eA6aIF02vULd01ByhQHoMRP5o+iXUixnc561PRhIiUFPfrAiA6IE4ZQhP/uhv2A
	 dbya4RQpQwioNDIuDJO0Rjs87XycDc/eAolMQpxy+mEjdg+sVAS9QGlTbA8bhboyCj
	 QR70ca2vkDa1LRrgJJixmtLh1xWEvlQmF3uPPFXYfKjIIrJ3u+IFbiz+zKWajYbo6v
	 oc115mHFIFtJO1ZuYIMAZK3sLlycwjpNMXUbvqfvMlfpfPq4PfEImiMhbB+zEvpf6N
	 AlcZ107QzvHVw==
Message-ID: <7180dcdb-694f-4014-9828-8baced3bfa7a@kernel.org>
Date: Sun, 11 Aug 2024 17:46:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: Patch "selftests: mptcp: join: ability to invert ADD_ADDR check"
 has been added to the 6.10-stable tree
Content-Language: en-GB
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: Mat Martineau <martineau@kernel.org>
References: <20240811125614.1262228-1-sashal@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240811125614.1262228-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sasha, Greg,

On 11/08/2024 14:56, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     selftests: mptcp: join: ability to invert ADD_ADDR check
> 
> to the 6.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      selftests-mptcp-join-ability-to-invert-add_addr-chec.patch
> and it can be found in the queue-6.10 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 469e6fe99988649029b7f136218d5c3d8854e705
> Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Date:   Wed Jul 31 13:05:58 2024 +0200
> 
>     selftests: mptcp: join: ability to invert ADD_ADDR check
>     
>     [ Upstream commit bec1f3b119ebc613d08dfbcdbaef01a79aa7de92 ]
>     
>     In the following commit, the client will initiate the ADD_ADDR, instead
>     of the server. We need to way to verify the ADD_ADDR have been correctly
>     sent.
>     
>     Note: the default expected counters for when the port number is given
>     are never changed by the caller, no need to accept them as parameter
>     then.
>     
>     The 'Fixes' tag here below is the same as the one from the previous
>     commit: this patch here is not fixing anything wrong in the selftests,
>     but it validates the previous fix for an issue introduced by this commit
>     ID.

Sorry, I just realised I forgot to add the "Cc: Stable" on all patches
from this series :-/

This patch and "selftests: mptcp: join: test both signal & subflow"
should be backported with the other patches modifying files in
net/mptcp. Without them, the two patches that have just been added to
the queue will just make the selftests failing.

Is it then possible to drop these two patches from the 6.10, 6.6 and 6.1
queues for the moment please? I can send patches for these versions
later on.

  selftests-mptcp-join-ability-to-invert-add_addr-chec.patch: 6.10, 6.6
  selftests-mptcp-join-test-both-signal-subflow.patch: 6.10, 6.6 and 6.1

>     Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
>     Reviewed-by: Mat Martineau <martineau@kernel.org>
>     Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>     Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-6-c8a9b036493b@kernel.org
>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


