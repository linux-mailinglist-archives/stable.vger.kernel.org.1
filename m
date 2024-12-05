Return-Path: <stable+bounces-98770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C59D9E51DE
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 11:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16668282AF2
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 10:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B640D1DC74A;
	Thu,  5 Dec 2024 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EwaRXCfa"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E741DC18F;
	Thu,  5 Dec 2024 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733393673; cv=none; b=kT9wC66AXF72o7fAJKoWkEzgdsYzVaiOPHGJLC2MAsrvllaLr1d7ZX6FKDXnGZ6/+bDTfidJWfHxr8QUhPlR81Myj6lxto8WOs5YtrkdncVKfcScfxV5UKgpX7IaSQuj/3weXFEc3WPDWnv97G0EXmk6N1l9nuo0r7MiBAgb7Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733393673; c=relaxed/simple;
	bh=vc8tSJVclWUgVciwCbm9ORQlrRn2jqrHpZ134R7FF/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VR+91uoKUXCJa/p2M6Xb7nF3J/KxfJ3X0g3pUANVkyVtTtc9iRNk5ogeQxtiLPMN3wEThJ+KRRUYXcppuL1oFTAvUVK+gdChXgIavQwVLFHiboY6DxacCdarX4X/k6iyxH2TQ8pq5wYGbGRM4lDBKf04s9Of3KvdbBqn4RR9p8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EwaRXCfa; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=m6StHegZ6tGvbNYqRNSd5greVP+REzoM4PjmghzBUrE=;
	b=EwaRXCfaQIpm6bMHSUFx5qY2kHXpSYUXlvZY9lTlx8uvYLgqN8+akK6MiqWUvL
	CGY/rJvyEWix8gPhQidmH692VQHa1jsKI+ld6w8FmI0EmDPcNUJqK5gwJMlkX+8X
	8/LnyUUe1I0kHppFICDZKWCqU9QMMZgn7Kvbg/JKEJmZo=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3vzjffFFnLkzFAg--.22554S2;
	Thu, 05 Dec 2024 18:13:52 +0800 (CST)
From: MoYuanhao <moyuanhao3676@163.com>
To: matttbe@kernel.org,
	edumazet@google.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	geliang@kernel.org,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	martineau@kernel.org,
	moyuanhao3676@163.com,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: Check space before adding MPTCP options
Date: Thu,  5 Dec 2024 18:13:51 +0800
Message-Id: <20241205101351.34818-1-moyuanhao3676@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0f07b584-1013-4932-b155-cc0883ca7061@kernel.org>
References: <0f07b584-1013-4932-b155-cc0883ca7061@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgD3vzjffFFnLkzFAg--.22554S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1Utw47JF1UtF1DZFyDGFg_yoWrJrWUpr
	yUKFsYkr4kJ348Gr4IqF1vyr1Fva1rGrWDXw15Ww12y3s0gFyI9ryIyr4Y9F97Wr48Jw1j
	vr4UZ34fWa1UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU4MKAUUUUU=
X-CM-SenderInfo: 5pr13t5qkd0jqwxwqiywtou0bp/1tbiNgSsfmdRe0AlkAAAsY

Hi Matt and Eric,

>Hi MoYuanhao,

>On 05/12/2024 08:54, Eric Dumazet wrote:
>> On Thu, Dec 5, 2024 at 8:31 AM Mo Yuanhao <moyuanhao3676@163.com> wrote:
>>>
>>> 在 2024/12/4 19:01, Matthieu Baerts 写道:
>>>> Hi MoYuanhao,
>>>>
>>>> +Cc MPTCP mailing list.
>>>>
>>>> (Please cc the MPTCP list next time)
>>>>
>>>> On 04/12/2024 09:58, MoYuanhao wrote:
>>>>> Ensure enough space before adding MPTCP options in tcp_syn_options()
>>>>> Added a check to verify sufficient remaining space
>>>>> before inserting MPTCP options in SYN packets.
>>>>> This prevents issues when space is insufficient.
>>>>
>>>> Thank you for this patch. I'm surprised we all missed this check, but
>>>> yes it is missing.
>>>>
>>>> As mentioned by Eric in his previous email, please add a 'Fixes' tag.
>>>> For bug-fixes, you should also Cc stable and target 'net', not 'net-next':
>>>>
>>>> Fixes: cec37a6e41aa ("mptcp: Handle MP_CAPABLE options for outgoing
>>>> connections")
>>>> Cc: stable@vger.kernel.org
>>>>
>>>>
>>>> Regarding the code, it looks OK to me, as we did exactly that with
>>>> mptcp_synack_options(). In mptcp_established_options(), we pass
>>>> 'remaining' because many MPTCP options can be set, but not here. So I
>>>> guess that's fine to keep the code like that, especially for the 'net' tree.
>>>>
>>>>
>>>> Also, and linked to Eric's email, did you have an issue with that, or is
>>>> it to prevent issues in the future?
>>>>
>>>>
>>>> One last thing, please don’t repost your patches within one 24h period, see:
>>>>
>>>>    https://docs.kernel.org/process/maintainer-netdev.html
>>>>
>>>>
>>>> Because the code is OK to me, and the same patch has already been sent
>>>> twice to the netdev ML within a few hours, I'm going to apply this patch
>>>> in our MPTCP tree with the suggested modifications. Later on, we will
>>>> send it for inclusion in the net tree.
>>>>
>>>> pw-bot: awaiting-upstream
>>>>
>>>> (Not sure this pw-bot instruction will work as no net/mptcp/* files have
>>>> been modified)
>>>>
>>>> Cheers,
>>>> Matt
>>> Hi Matt,
>>>
>>> Thank you for your feedback!
>>>
>>> I have made the suggested updates to the patch (version 2):
>>>
>>> I’ve added the Fixes tag and Cc'd the stable@vger.kernel.org list.
>>> The target branch has been adjusted to net as per your suggestion.
>>> I will make sure to Cc the MPTCP list in future submissions.
>>>
>>> Regarding your question, this patch was created to prevent potential
>>> issues related to insufficient space for MPTCP options in the future. I
>>> didn't encounter a specific issue, but it seemed like a necessary
>>> safeguard to ensure robustness when handling SYN packets with MPTCP options.
>>>
>>> Additionally, I have made further optimizations to the patch, which are
>>> included in the attached version. I believe it would be more elegant to
>>> introduce a new function, mptcp_set_option(), similar to
>>> mptcp_set_option_cond(), to handle MPTCP options.
>>>
>>> This is my first time replying to a message in a Linux mailing list, so
>>> if there are any formatting issues or mistakes, please point them out
>>> and I will make sure to correct them in future submissions.
>>>
>>> Thanks again for your review and suggestions. Looking forward to seeing
>>> the patch applied to the MPTCP tree and later inclusion in the net tree.
>> 
>> We usually do not refactor for a patch targeting a net tree.
>
>Indeed, I agree with Eric. Even if the code looks good, more lines have
>been modified, maybe more risks, but also harder to backport to stable.

Thank you for your guidance. I agree with your points, and using the patch from version 1 seems safer.

Best regards,

MoYuanhao


