Return-Path: <stable+bounces-43559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5168C3187
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 15:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94AF82811FE
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 13:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DAC50A6A;
	Sat, 11 May 2024 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otPqyYuT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9B15028C;
	Sat, 11 May 2024 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715432720; cv=none; b=juCmY6tQcpHqarxKWTJEH2eyFvkpZ4QvzT05MMKJgW910FuwMYV8BUKtJJLJPkNPT7cKepn1v62/T3Zt4Vw/7Du1R3qESDGG70vzmhe1mE0EMwRH25x2r90zIArPr9ZgIJ4FwiV/rhZrkIvkV9TreTVtmJK8skoYoUXh33vl4TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715432720; c=relaxed/simple;
	bh=tn9EHRkwoIVivB2fESZjJEFR9J9vIAQx3fBKBmVe5I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLLKi6YlopHP5YjL29S82zhhBTo4fvu36uyT1wMfDC/Tzyh9LrlYtOmqNK/KaugO362g8Nnn/qUhdrBbOU6Rj0tv+ksENLCzEssaBQfN5bflBz+plhj86OC5L6G+DhHDW2izSsWDarA4gcBFScjY7Zo2ra8IOIPtDj+6hGMhfBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otPqyYuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EC7C2BBFC;
	Sat, 11 May 2024 13:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715432719;
	bh=tn9EHRkwoIVivB2fESZjJEFR9J9vIAQx3fBKBmVe5I8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=otPqyYuTaQF9UP5MdCjh0dqnIwgYJj5/uDGkjb9mWgRpyuESlXjSowekuqmtaugnb
	 Jx7h2Efva+31fhNzDddQIxQustClTT6xUP8vo/bxRzA4dih1M2N8cDji4fdOJc4GDk
	 QzS0ubhNI/1S5silmJevnT+V7dXjWJR8CBA4fq3NAAazSJXFvfWhLhwg8+OhX+osVs
	 /0cCkQqOM1Ajqqbtha0Lxx+WoYUzIzN2whVF9d/kuC5zTHO/tE4rlbt0EYznNTkpMF
	 U28BuagiZL7pmBSssOcUz7sVwauq0vF7hwy1MEMCeSdMlQhe5ILJHJF87PxybjnkhL
	 88Kvm/m7XfNuw==
Date: Sat, 11 May 2024 09:05:18 -0400
From: Sasha Levin <sashal@kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: Patch "nfc: nci: Fix kcov check in nci_rx_work()" has been added
 to the 6.1-stable tree
Message-ID: <Zj9tDunQd3BDcG2a@sashalap>
References: <20240510213957.98499-1-sashal@kernel.org>
 <bf2120e1-abc5-4513-b7d0-e324a2e4572a@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bf2120e1-abc5-4513-b7d0-e324a2e4572a@I-love.SAKURA.ne.jp>

On Sat, May 11, 2024 at 07:53:00AM +0900, Tetsuo Handa wrote:
>On 2024/05/11 6:39, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     nfc: nci: Fix kcov check in nci_rx_work()
>>
>> to the 6.1-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      nfc-nci-fix-kcov-check-in-nci_rx_work.patch
>> and it can be found in the queue-6.1 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>
>I think we should not add this patch to 6.1 and earlier kernels, for
>only 6.2 and later kernels call kcov_remote_stop() from nci_rx_work().

Dropped, thanks!

-- 
Thanks,
Sasha

