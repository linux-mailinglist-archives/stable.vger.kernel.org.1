Return-Path: <stable+bounces-192279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D51C2DD03
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 20:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C1C3AB779
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 19:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2BC296BA2;
	Mon,  3 Nov 2025 19:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8xEZ1y8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F53347C3;
	Mon,  3 Nov 2025 19:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197215; cv=none; b=HyP7mYwsUIXib8VqEfcq/WZcbcheqrgWAdDXACJ/7jqfzrNXOXn2uCscRJW2BM65XjC89TEhRuezPgfhxMjjh17XSo1puY3nvocs9XArOjD/yZDuOeFbuWvKOPFBPD3LwXaSQRXLuS5BkUdoQvl+8RZITNP0yNCnklMMPj+Rwhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197215; c=relaxed/simple;
	bh=XiAeU3u98Pp+UrHar7Za4ngxo18Gm/1MrUeT8PPHg6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7evPY9j3mMq/43nb9JsCzJIj0NZhtugBMK2JD9SsuGQbgKUkIrDyTtrFoKj9rofi2gOtjfDBo+eqlkdQRnwP0btuadf6z4F/sbUTmiPKJlODueSO8kUtE9OHehMi66RL70k/IAVprS8SGb36PwV8wmj35qWuOS+IFXbbwwCVas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8xEZ1y8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14FFC4CEE7;
	Mon,  3 Nov 2025 19:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762197214;
	bh=XiAeU3u98Pp+UrHar7Za4ngxo18Gm/1MrUeT8PPHg6c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n8xEZ1y8J6cxtveleBo5GxbX+lIsYV9UXMgEWHGZgcfGAgG2jScNwKRxv6pdCPdOx
	 TUNzn+KnpcNyOD56QFVaAA/u17Uc/3JrEZIpf3FfiTyKY8gr6eph9KtUJcYyN8fcMq
	 x16VBOAY25n550Y2Gnb3/veHiL9na1LGhNanT0NQqFrFqVrgcJtbPQ0+aYfrBXIz/f
	 el/r1pa+2wkifjHivdThr9lh3XgASOizYXstJNQYKZ9mwRZupSgGOIg7QCA4jPawFY
	 SX1HGlsNihzu9Jn1vMAkORszYZQLbycytCI8UxFIZyDZ0Vl0aE4O92OgWFHUwv5ymX
	 EzINhDeTaFHKQ==
Message-ID: <bbe84711-95b2-4257-9f01-560b4473a3da@kernel.org>
Date: Mon, 3 Nov 2025 20:13:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: Patch "mptcp: move the whole rx path under msk socket lock
 protection" has been added to the 6.12-stable tree
Content-Language: en-GB, fr-BE
To: gregkh@linuxfoundation.org, kuba@kernel.org, martineau@kernel.org,
 pabeni@redhat.com, sashal@kernel.org
Cc: stable-commits@vger.kernel.org, MPTCP Linux <mptcp@lists.linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <2025110351-praising-bounce-a06b@gregkh>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2025110351-praising-bounce-a06b@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg, Sasha,

On 03/11/2025 02:29, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     mptcp: move the whole rx path under msk socket lock protection
> 
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      mptcp-move-the-whole-rx-path-under-msk-socket-lock-protection.patch
> and it can be found in the queue-6.12 subdirectory.

Thank you for the backport!
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please drop this patch from the 6.12-stable tree: it causes troubles in
the MPTCP selftests: MPTCP to TCP connections timeout when MSG_PEEK is
used. Likely a dependence is missing, and it might be better to keep
only the last patch, and resolve conflicts. I will check that ASAP.

In the meantime, can you then drop this patch and the ones that are
linked to it please?

queue-6.12/mptcp-cleanup-mem-accounting.patch
queue-6.12/mptcp-fix-msg_peek-stream-corruption.patch
queue-6.12/mptcp-move-the-whole-rx-path-under-msk-socket-lock-protection.patch
queue-6.12/mptcp-leverage-skb-deferral-free.patch


> From stable+bounces-192095-greg=kroah.com@vger.kernel.org Mon Nov  3 08:27:43 2025
> From: Sasha Levin <sashal@kernel.org>
> Date: Sun,  2 Nov 2025 18:27:32 -0500
> Subject: mptcp: move the whole rx path under msk socket lock protection
> To: stable@vger.kernel.org
> Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>
> Message-ID: <20251102232735.3652847-1-sashal@kernel.org>
> 
> From: Paolo Abeni <pabeni@redhat.com>
> 
> [ Upstream commit bc68b0efa1bf923cef1294a631d8e7416c7e06e4 ]
> 
> After commit c2e6048fa1cf ("mptcp: fix race in release_cb") we can
> move the whole MPTCP rx path under the socket lock leveraging the
> release_cb.
> 
> We can drop a bunch of spin_lock pairs in the receive functions, use
> a single receive queue and invoke __mptcp_move_skbs only when subflows
> ask for it.
> 
> This will allow more cleanup in the next patch.
> 
> Some changes are worth specific mention:
> 
> The msk rcvbuf update now always happens under both the msk and the
> subflow socket lock: we can drop a bunch of ONCE annotation and
> consolidate the checks.
> 
> When the skbs move is delayed at msk release callback time, even the
> msk rcvbuf update is delayed; additionally take care of such action in
> __mptcp_move_skbs().
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Link: https://patch.msgid.link/20250218-net-next-mptcp-rx-path-refactor-v1-3-4a47d90d7998@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Stable-dep-of: 8e04ce45a8db ("mptcp: fix MSG_PEEK stream corruption")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


