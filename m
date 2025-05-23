Return-Path: <stable+bounces-146227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D965EAC2C16
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 01:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A8C17341E
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 23:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CFE21129D;
	Fri, 23 May 2025 23:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WXDhwOKC"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC44B2BD11
	for <stable@vger.kernel.org>; Fri, 23 May 2025 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748042263; cv=none; b=dZoifhFVsshzeGmKRlPQ5OmTs7s5dIHksD5W+PT4NZc8cxfFacUqk9m0E1idpMAAqV4mzwvN71AllTAmQ+KZK/TOZ+qBOXAdSoINEsNgfA1LK9tHTHqDjEKw3doj0ZVGtisDSE2S9tnhdNQE7IlEhF+Y/zTG6tA1rdHvYyuE0kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748042263; c=relaxed/simple;
	bh=O6K2/0x7iu9YT2H+h30F8d0KqYfLxiBQU4Axen1oHY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/kx5RCYcoKUITGFo6rzQP4sN771xSv9gE7iPNwC97AHElNzZs4JCuAMhnHmVeJpfPaT375yVeMDApwsCRzA076xOG9s16MMIYWniqjoGm5SqwNorpPPuMJRU2/tkZlFbBtWW3tjvTFcB/L8uI2dzbmn+ecsNy4rKmtfjzTzAu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WXDhwOKC; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <69d1a996-5eaa-4af9-978d-c59c70a95438@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748042249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qZk4d3NlLyLNzBpH6DEs8aWc6RcH+715DVdVutTcVNY=;
	b=WXDhwOKCn/7fB4jXPCL/wIQNrlMbeltALeSlBu8MdSWmxbdGpQ9QG1rAzg8xrlrF1jBubx
	P8DO+t3tEAu01fDybTNEQMxJ11gGGYCpSFNhsUwQTgOc6rP94eUT6bfvBUl8kj27py0jC6
	9RoPyrKV6K8UzIYOS2/tnXxRk1aDE0s=
Date: Fri, 23 May 2025 16:17:21 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Patch "bpf: Prevent unsafe access to the sock fields in the BPF
 timestamping callback" has been added to the 6.1-stable tree
To: Jason Xing <kerneljasonxing@gmail.com>, stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>
References: <20250522231656.3254864-1-sashal@kernel.org>
 <CAL+tcoBEGozJ1Zs2c0L-kG=ZTVfPGXdshQxs7nCxwr-NhZoUPw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoBEGozJ1Zs2c0L-kG=ZTVfPGXdshQxs7nCxwr-NhZoUPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/22/25 4:25 PM, Jason Xing wrote:
> On Fri, May 23, 2025 at 7:17 AM Sasha Levin <sashal@kernel.org> wrote:
>>
>> This is a note to let you know that I've just added the patch titled
>>
>>      bpf: Prevent unsafe access to the sock fields in the BPF timestamping callback
>>
>> to the 6.1-stable tree which can be found at:
>>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>       bpf-prevent-unsafe-access-to-the-sock-fields-in-the-.patch
>> and it can be found in the queue-6.1 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
> 
> Hi,
> 
> I'm notified that this patch has been added into many branches, which
> is against my expectations. The BPF timestaping feature was
> implemented in 6.14 and the patch you are handling is just one of them.
> 
> The function of this patch prevents unexpected bpf programs using this
> feature from triggering
> fatal problems. So, IMHO, we don't need this patch in all the
> older/stable branches:)
> 
> Thanks,
> Jason
> 
> 
>>
>>
>>
>> commit 00b709040e0fdf5949dfbf02f38521e0b10943ac
>> Author: Jason Xing <kerneljasonxing@gmail.com>
>> Date:   Thu Feb 20 15:29:31 2025 +0800
>>
>>      bpf: Prevent unsafe access to the sock fields in the BPF timestamping callback
>>
>>      [ Upstream commit fd93eaffb3f977b23bc0a48d4c8616e654fcf133 ]
>>
>>      The subsequent patch will implement BPF TX timestamping. It will

Agree. The patch is a preparation work for the new bpf tx timestamping feature. 
It is not stable material.

Thanks,
Martin

>>      call the sockops BPF program without holding the sock lock.
>>
>>      This breaks the current assumption that all sock ops programs will
>>      hold the sock lock. The sock's fields of the uapi's bpf_sock_ops
>>      requires this assumption.
>>
>>      To address this, a new "u8 is_locked_tcp_sock;" field is added. This
>>      patch sets it in the current sock_ops callbacks. The "is_fullsock"
>>      test is then replaced by the "is_locked_tcp_sock" test during
>>      sock_ops_convert_ctx_access().
>>
>>      The new TX timestamping callbacks added in the subsequent patch will
>>      not have this set. This will prevent unsafe access from the new
>>      timestamping callbacks.
>>
>>      Potentially, we could allow read-only access. However, this would
>>      require identifying which callback is read-safe-only and also requires
>>      additional BPF instruction rewrites in the covert_ctx. Since the BPF
>>      program can always read everything from a socket (e.g., by using
>>      bpf_core_cast), this patch keeps it simple and disables all read
>>      and write access to any socket fields through the bpf_sock_ops
>>      UAPI from the new TX timestamping callback.
>>
>>      Moreover, note that some of the fields in bpf_sock_ops are specific
>>      to tcp_sock, and sock_ops currently only supports tcp_sock. In
>>      the future, UDP timestamping will be added, which will also break
>>      this assumption. The same idea used in this patch will be reused.
>>      Considering that the current sock_ops only supports tcp_sock, the
>>      variable is named is_locked_"tcp"_sock.
>>
>>      Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
>>      Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
>>      Link: https://patch.msgid.link/20250220072940.99994-4-kerneljasonxing@gmail.com
>>      Signed-off-by: Sasha Levin <sashal@kernel.org>

