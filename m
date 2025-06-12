Return-Path: <stable+bounces-152576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F68FAD7B07
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 21:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B413B3298
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 19:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60A12D3213;
	Thu, 12 Jun 2025 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMHBsc8W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2C47263C;
	Thu, 12 Jun 2025 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749756249; cv=none; b=mr264jo4PNDxgEEgu4rdHIuY/zpW45Q+OyuV+te+bao/23VlqiqNwd2cYMrwNSrbP1uNrn3qfck3EKexU8zKbi4c1nt6wStq74eZ3JTPdcUgmgmHWA0Hs8vQsVv95fxN24pnq92AK/i3fP5t8j4KvtnH7WwGyA6uACqjwDoD4xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749756249; c=relaxed/simple;
	bh=1ujS0CtRiI41ZT3byjEBQFaeY2woHS9rNSqWy4CtuWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qq1tw82OFb+aWIkYfXJ1CVQrMfg5fEJFK8Dneqf5m7ha1gNxOEMIIrTUbzKxARg+aGBc+PBdW3m3KdYSO0c0ep7GJbpS+HuV7VomhBaTaZwl7ibgGQ7XCGkelJOxvZUtBmqkoyMnhhRY2prt4d1WzYll/u/Pea9iZ5SSdrOpCOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMHBsc8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACE3C4CEEA;
	Thu, 12 Jun 2025 19:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749756249;
	bh=1ujS0CtRiI41ZT3byjEBQFaeY2woHS9rNSqWy4CtuWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EMHBsc8Wl2aPUvnYZrGV4VtIVqke9vaGN9TjdCR5Mbnp6RHkyDNAI6eX046CIVFWM
	 yKjk4a0j9QvWKnFl6H4RLfQxEpFDulKNFlCDu031+0mvoL4PLI/lSAXMp6TGX2u3Dz
	 q19341ieMlAaRjzr+j6Nnb5KaXzAnPDTyBhJEFLGZRlF86gl+CA+KgHd5VZTxuvDNX
	 oXJpluFHWI2V9CPHRSPXddX2gxiBXHWRbY9GvKHeFl0/oGAy8fG3lh80Q2NOdkjy2T
	 JZorlzTXYRPlZfPQl6BNeb9aNxwowyCkDbg944t0BdNG+CW1mnHnSm8cKirL8T1gWJ
	 tEW95qbiOQBpw==
Date: Thu, 12 Jun 2025 15:24:07 -0400
From: Sasha Levin <sashal@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, ij@kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: Patch "tcp: reorganize tcp_in_ack_event() and
 tcp_count_delivered()" has been added to the 6.6-stable tree
Message-ID: <aEspV8Ttk7uBM4Gx@lappy>
References: <20250522224433.3219290-1-sashal@kernel.org>
 <CANn89i+jADLAqpg-gOyHFZiFEb0Pks46h=9d8-FiPa1_HEv3YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+jADLAqpg-gOyHFZiFEb0Pks46h=9d8-FiPa1_HEv3YA@mail.gmail.com>

On Thu, Jun 12, 2025 at 01:40:57AM -0700, Eric Dumazet wrote:
>On Thu, May 22, 2025 at 3:44 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> This is a note to let you know that I've just added the patch titled
>>
>>     tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
>>
>> to the 6.6-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      tcp-reorganize-tcp_in_ack_event-and-tcp_count_delive.patch
>> and it can be found in the queue-6.6 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>>
>
>May I ask why this patch was backported to stable versions  ?
>
>This is causing a packetdrill test to fail.

Is this an issue upstream as well? Should we just drop it from stable?

-- 
Thanks,
Sasha

