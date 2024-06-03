Return-Path: <stable+bounces-47868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C758D8301
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 14:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447832819B4
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 12:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA07212C550;
	Mon,  3 Jun 2024 12:56:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBAF12C482
	for <stable@vger.kernel.org>; Mon,  3 Jun 2024 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419375; cv=none; b=Ln3iOgt/1jRFlI6Kqmvh5hFhqQG2MbfPV4OK4WEgtkCyd/PxnE8QXr5fmz4G7ELsUTet2meESucjwsAJMwHi76ev0l30pcQrqaiPcGlfoUUAYwtmhPcvz/8YXAjOnb5oP69DnCGWemIxGogqqituaH+Yeld1eiukFy7V9MsUzEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419375; c=relaxed/simple;
	bh=yNrdoS5BVEbUpDcCue0s0K2D+12hETX9oi5sehZyogE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=msQdiic0Je5hLu9FJCB7xSwfLIZZza5zyblqQUMJIx5+iWoiP7+8AHKB9cqKOJJ+zHSJoYcJxRemKH1JkLxNv9CfHcb0zFrhmg+FBBmwLXjQAIyy8J0LYOS5Ocm1jR1qJB8sJfy2RXouwFwJaMzQx3rwGwuxkviV72Ss4//MC2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 453Ctj6e083962;
	Mon, 3 Jun 2024 21:55:45 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Mon, 03 Jun 2024 21:55:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 453CtjUW083958
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 3 Jun 2024 21:55:45 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2ddb1a36-73c3-47ec-be70-3af2ae04c4a6@I-love.SAKURA.ne.jp>
Date: Mon, 3 Jun 2024 21:55:44 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "nfc: nci: Fix kcov check in nci_rx_work()" has been added
 to the 6.1-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20240603121312.1839586-1-sashal@kernel.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240603121312.1839586-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Not for 6.1 and earlier kernels.

-------- Forwarded Message --------
Date: Sat, 11 May 2024 09:05:18 -0400
Subject: Re: Patch "nfc: nci: Fix kcov check in nci_rx_work()" has been added to the 6.1-stable tree
Message-ID: <Zj9tDunQd3BDcG2a@sashalap>

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

On 2024/06/03 21:13, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     nfc: nci: Fix kcov check in nci_rx_work()
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      nfc-nci-fix-kcov-check-in-nci_rx_work.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 


