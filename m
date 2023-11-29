Return-Path: <stable+bounces-3178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559F97FE052
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 20:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83DD21C20A83
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 19:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212815DF3E;
	Wed, 29 Nov 2023 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYQrR4dv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88FA5DF15
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 19:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FC1C433C8;
	Wed, 29 Nov 2023 19:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701286238;
	bh=t0NHC4p6jkhmjMqTOpVR77Yts8xhz2M546nw0RiHw3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BYQrR4dvO1DG4ac2JAREZKvCfpj2w+u7EMxSC1AGHajQCR6XSUWqYunouMr+hZnHc
	 tOqP7ayqRAcT0KXzqHv6FY+qCbfO4Ccdp+Y7Y55EawLKtEWpk+yCVHO+cOU3B94fMx
	 INWcIBm8apRD3GswF9GL03zr7b3Omx72BkikYagMa73TKsG1bZVfRfZLZK7hr0L0Kz
	 iWMUVIt1XakLChFEoXJLmFW1tTvD8eb/2KuuQzI1eslVbi2x6S5TEc/OKoIa7QjoqY
	 08jdwBmmvAvlOQbbabGy0vtKJvqsVsDY3lNaSqAvpj+C7qERwF4pxdb8LJih651wNW
	 MsXzJ42lnvQRQ==
Date: Wed, 29 Nov 2023 14:30:36 -0500
From: Sasha Levin <sashal@kernel.org>
To: Peilin Ye <yepeilin.cs@gmail.com>
Cc: stable-commits@vger.kernel.org, peilin.ye@bytedance.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Cong Wang <cong.wang@bytedance.com>, stable@vger.kernel.org
Subject: Re: Patch "bpf: Fix dev's rx stats for bpf_redirect_peer traffic"
 has been added to the 6.6-stable tree
Message-ID: <ZWeRXIIx5mjBnXG0@sashalap>
References: <20231129025247.890789-1-sashal@kernel.org>
 <20231129060508.GA17429@n191-129-154.byted.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231129060508.GA17429@n191-129-154.byted.org>

On Wed, Nov 29, 2023 at 06:05:17AM +0000, Peilin Ye wrote:
>+Cc: Cong Wang <cong.wang@bytedance.com>
>
>Hi all,
>
>On Tue, Nov 28, 2023 at 09:52:46PM -0500, Sasha Levin wrote:
>>
>> This is a note to let you know that I've just added the patch titled
>>
>>     bpf: Fix dev's rx stats for bpf_redirect_peer traffic
>>
>> to the 6.6-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      bpf-fix-dev-s-rx-stats-for-bpf_redirect_peer-traffic.patch
>> and it can be found in the queue-6.6 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>Seems like only patch 1, 2 and 5 in this [1] series are selected?  We
>also need patch 4, upstream commit 6f2684bf2b44 ("veth: Use tstats
>per-CPU traffic counters").  Otherwise the fix won't work, and the code
>will be wrong [2] .
>
>We should've included a "Depends on patch..." note for stable in the
>commit message.

I'll take it too, thanks!

-- 
Thanks,
Sasha

