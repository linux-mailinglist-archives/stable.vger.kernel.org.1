Return-Path: <stable+bounces-116783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B2CA39E3A
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 15:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E27188B269
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 14:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D392673A1;
	Tue, 18 Feb 2025 14:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="dmZkQFtk"
X-Original-To: stable@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BED1243361
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887530; cv=none; b=HIBwXi6YT3zYUtV4RiFsyh/cdwP8JhTCaDBy82EnoyHc+ld4hXc842Lisg6so6yJcq3/NyKPJzOGlwoyazsDtH3ESp10IT1hsX9Z1/Og8iunziSbmox3eRWsIa0MafqTgGiGoL7lmXx1R0lnvkJYAww1vVMvAbAkAj585lSbFqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887530; c=relaxed/simple;
	bh=EwSx/bh+nnBZLJnNK0uNF6Az2NoNYSQGHw8FzZF7sio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwX0/pM60GHZEzc4Y/woWGkWgYdEBnGjXFHOjLeMo6COmFWfrXeR3vDOvVYh+HdYSUCau7fuVQOo+2HPRmnRhT/VqJEFqiy+GBDA8/6fFwfuCRwczLzCcsqh/AQ4sGogK2lT4sQCVJd1fT5u9Ep2+EDiWun3SzpgC1/nKNCMizU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=dmZkQFtk; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tkODu-00GTLU-6U; Tue, 18 Feb 2025 15:05:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=DJHXXEaKqG4g8AFGupDRLgKRWLqyyNVFcX0schctweA=; b=dmZkQFtkSEI14KUwA+5CV0wFWz
	JTNycLBGPrQA7pSiOV2hBNZ1qzyDDZve1HfiaQPdTWpG0AtGs2HT4Tiuh+E+h92j0dq/6twIUdKfz
	jAF8RLCtCbP+LiPYxLwbqXcQSwwY0qtdMswc9NNG8hbHz/W7y3Eous9O07MqJAtrvI5d1V+fcrNFs
	UWNOioGpLxx67+CwTu9hFyVEvZCKSz188nF+g+RwKZOLWHYrl1ssdEcY6CK/7x1B3asrU06ErAq1T
	S/z5lMXNPuFxs+b6KGJV1WhflgkYJZJGN9Hb9RgjO2Qtp/EYbELjr+ubWGH7TANC96C7iSe+1XPVD
	36MI4Hwg==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tkODt-0008SG-K6; Tue, 18 Feb 2025 15:05:17 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tkODt-0049on-9B; Tue, 18 Feb 2025 15:05:17 +0100
Message-ID: <a6c77d41-4203-4aa7-8d4c-ed513bb6929d@rbox.co>
Date: Tue, 18 Feb 2025 15:05:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] vsock: fix use-after free and null-ptr-deref
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Luigi Leonardi <leonardi@redhat.com>, stable@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
References: <20250214-linux-rolling-stable-v1-0-d39dc6251d2f@redhat.com>
 <f7lr3ftzo66sl6phlcygh4xx4spga4b6je37fhawjrsjtexzne@xhhwaqrjznlp>
 <cf0ef7bc-4da9-492a-bc43-0c3e83c48d02@rbox.co>
 <ez2wnwdos73pxbbxanbs5pe2nawvgablvjvrpqldcpbuwy7jz4@y6vnlty435un>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <ez2wnwdos73pxbbxanbs5pe2nawvgablvjvrpqldcpbuwy7jz4@y6vnlty435un>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/25 09:35, Stefano Garzarella wrote:
> On Mon, Feb 17, 2025 at 08:45:57PM +0100, Michal Luczaj wrote:
>> On 2/17/25 12:18, Luigi Leonardi wrote:
>>> On Fri, Feb 14, 2025 at 06:53:54PM +0100, Luigi Leonardi wrote:
>>>> Hi all,
>>>>
>>>> This series contains two patches that are already available upstream:
>>>>
>>>> - The first commit fixes a use-after-free[1], but introduced a
>>>> null-ptr-deref[2].
>>>> - The second commit fixes it. [3]
>>>>
>>>> I suggested waiting for both of them to be merged upstream and then
>>>> applying them togheter to stable[4].
>>>>
>>>> It should be applied to:
>>>> - 6.13.y
>>>> - 6.12.y
>>>> - 6.6.y
>>>>
>>>> I will send another series for
>>>> - 6.1.y
>>>> - 5.15.y
>>>> - 5.10.y
>>>>
>>>> because of conflicts.
>>>>
>>>> [1]https://lore.kernel.org/all/20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co/
>>>> [2]https://lore.kernel.org/all/67a09300.050a0220.d7c5a.008b.GAE@google.com/
>>>> [3]https://lore.kernel.org/all/20250210-vsock-linger-nullderef-v3-0-ef6244d02b54@rbox.co/
>>>> [4]https://lore.kernel.org/all/2025020644-unwitting-scary-3c0d@gregkh/
>>>>
>>>> Thanks,
>>>> Luigi
>>>>
>>>> ---
>>>> Michal Luczaj (2):
>>>>      vsock: Keep the binding until socket destruction
>>>>      vsock: Orphan socket after transport release
>>>>
>>>> net/vmw_vsock/af_vsock.c | 12 +++++++++++-
>>>> 1 file changed, 11 insertions(+), 1 deletion(-)
>>>> ---
>>>> base-commit: a1856aaa2ca74c88751f7d255dfa0c8c50fcc1ca
>>>> change-id: 20250214-linux-rolling-stable-d73f0bed815d
>>>>
>>>> Best regards,
>>>> -- Luigi Leonardi <leonardi@redhat.com>
>>>>
>>>
>>> Looks like I forgot to add my SoB to the commits, my bad.
>>>
>>> For all the other stable trees (6.1, 5.15 and 5.10), there are some
>>> conflicts due to some indentation changes introduced by 135ffc7 ("bpf,
>>> vsock: Invoke proto::close on close()"). Should I backport this commit
>>> too?  There is no real dependency on the commit in the Fixes tag
>>> ("vsock: support sockmap"). IMHO, this would help future backports,
>>> because of indentation conficts! Otherwise I can simply fix the patches.
>>> WDYT?
>>
>> Just a note: since sockmap does not support AF_VSOCK in those kernels <=
>> 6.1, backporting 135ffc7 would introduce a (no-op) callback function
>> vsock_close(), which would then be (unnecessarily) called on every
>> vsock_release().
>>
> 
> But this is the same behavior we have now upstream (without considering 
> sockmap), right?

Oh, right, that's true.

> Do you see any potential problems?

No, nothing I can think of.

Note however that the comment above vsock_close() ("Dummy callback required
by sockmap. See unconditional call of saved_close() in sock_map_close().")
becomes somewhat misleading :)


