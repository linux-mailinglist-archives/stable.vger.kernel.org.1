Return-Path: <stable+bounces-81185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5809D991BA0
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 02:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE2F1F2254E
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 00:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C8EA926;
	Sun,  6 Oct 2024 00:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrfUTm/T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AFD63A9;
	Sun,  6 Oct 2024 00:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728174677; cv=none; b=hWw+Ck+OnxIgBYSMXnN+1saDhQkkxnKhdHo4ONkf16uxNER+clCyvvR+LAgGt8w0BABEXciR7ohMN1wDb5Utv8h6MO6LPE8E+C5q3Zywlyh4b4T2xIDCKIdXBgxWy2Dk6rOccOyANlevx3WDB67YNd2Ko3JzjMj3zBPUUbxkelI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728174677; c=relaxed/simple;
	bh=VXl4zJaR9dYOWEMOJjKEEWKAU5Qywq67Lx6ITJ62o5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uz3aZVGJ9+McankWBAyaP2VS1KhWwpS1YQ2e4VhlVjYOWIFY3x+9tVtnBHjvx3peXDmw1UFflqB9DKejQSLw9yl7mJmGZOvXbcm24/wb6g5Bp6E4Od56M42ceKzrQw+TdMZqfbHI6NO2zy+9sj97RIGkH+cUExszxivpGFadLFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrfUTm/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF1CC4CEC2;
	Sun,  6 Oct 2024 00:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728174677;
	bh=VXl4zJaR9dYOWEMOJjKEEWKAU5Qywq67Lx6ITJ62o5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZrfUTm/TW1THHBWFKQgGWyVbHKmLa2zC0td7+u3ZbUpp5q/HqZd5mq+XGVr5EQc8/
	 dvzR3+tuh3jknA22ZWkBdvv7xqpf9qJP9kA3SR5FH1KpKWjWKaHVGSXjohhaw7emwG
	 OkQg+nJNeSlvlw/XdH8LEi7OKvuK8W3Va5qrp7LDg0Sqt8ChzRVF454hju/R8Kx3zB
	 wzTBkyFhg8YaUiU8TbX42gCyslEOkwKOaPlGt9xIeo48STebiHTdG20K0P10VchfBv
	 zwqpLpTz6lUOSl5ypbXpvoBcEEgpSiVZASlJvWqkQJxomq8L66SEbLMvsqVo/NyiO4
	 A2OnwY5M5j4CA==
Date: Sat, 5 Oct 2024 20:31:15 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>, borisp@nvidia.com,
	john.fastabend@gmail.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.6 054/139] net: tls: wait for async completion
 on last message
Message-ID: <ZwHaU1RSwk_7zOpy@sashalap>
References: <20240925121137.1307574-1-sashal@kernel.org>
 <20240925121137.1307574-54-sashal@kernel.org>
 <20241002055025.5d9ee0a4@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241002055025.5d9ee0a4@kernel.org>

On Wed, Oct 02, 2024 at 05:50:25AM -0700, Jakub Kicinski wrote:
>On Wed, 25 Sep 2024 08:07:54 -0400 Sasha Levin wrote:
>> From: Sascha Hauer <s.hauer@pengutronix.de>
>>
>> [ Upstream commit 54001d0f2fdbc7852136a00f3e6fc395a9547ae5 ]
>>
>> When asynchronous encryption is used KTLS sends out the final data at
>> proto->close time. This becomes problematic when the task calling
>> close() receives a signal. In this case it can happen that
>> tcp_sendmsg_locked() called at close time returns -ERESTARTSYS and the
>> final data is not sent.
>>
>> The described situation happens when KTLS is used in conjunction with
>> io_uring, as io_uring uses task_work_add() to add work to the current
>> userspace task. A discussion of the problem along with a reproducer can
>> be found in [1] and [2]
>>
>> Fix this by waiting for the asynchronous encryption to be completed on
>> the final message. With this there is no data left to be sent at close
>> time.
>
>I wouldn't backport this, it may cause perf regressions.

Dropped, thanks!

-- 
Thanks,
Sasha

