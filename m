Return-Path: <stable+bounces-74044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D92F971DE5
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 17:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFCE1F21D7D
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 15:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98FB3B791;
	Mon,  9 Sep 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATKhvfzR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6476A7494;
	Mon,  9 Sep 2024 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895087; cv=none; b=OwStyUqGJaQpOc+bRAPBw0CxNsr0uRd3IoKZ3zALqa1ySj1Y8Yar/HAHMSnQZ3zCV7/Iq5zgdygJRLRUlNt7QWdT9AYZYdbUqaHjb5mTDKZEFBOeSY1KXKTX/LXyS//rClCozr+mmoyDkWWAVIlvmzeh7DyilOgIWFcx1gNV2r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895087; c=relaxed/simple;
	bh=Js7pJHqvAC8bf2m3H5AGeYUP3ZgPfE8LKRDdpay16/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7wjKa1+pZbpLr3nSz9Ln/G8YVhcEok9xGLYN6gXKPsYHo5VH9eEsX+gRwld30uS4lWmXOka3N5ZooWlsuc9/3UYID4RVD3F4fbRGNkDXcOwzNUPI+skE+TssEZDqY+v6c+HCQ1/S7QwKKWd/cQAeheHSQJQ2w5vr3pAlQ0oWY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATKhvfzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB54C4CEC5;
	Mon,  9 Sep 2024 15:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725895087;
	bh=Js7pJHqvAC8bf2m3H5AGeYUP3ZgPfE8LKRDdpay16/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ATKhvfzR8+ML2oD+jbTLDmvr6JfR6Qq6O5PUxAOIXGurbgRJp9vWVCdY4E1pKXyy4
	 STEU/BJcptCcl/lwK8JkX8jNehjG6dxcvt4a12x9fbPj9k/ZIubVpGFHJoRPfjI6aj
	 63TaAlWOWSrj6B/kRfTp9kKRthpJytZI+r0vegyj8WWOIy8YVzdnsGVzTnZ7fY4fxn
	 1UlVwyms+3+flDDOE6kV1k5V9FIA4g0bewDNb0auAkz5yOU+OJPTZn3f1dcwr2qs28
	 sypj1nSucCTIJw14Byb7vjftQndMA6+M/d7ysEmnVHcYYXmmfLIHAwMEphwlJDy8Uv
	 ijQH2HnDrNQvA==
Date: Mon, 9 Sep 2024 11:18:05 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Patch "userfaultfd: fix checks for huge PMDs" has been added to
 the 6.1-stable tree
Message-ID: <Zt8Rrcr3MBOUXCLp@sashalap>
References: <20240909124838.1803757-1-sashal@kernel.org>
 <CAG48ez3GBwDc=RWVixeNW8Ppt4J2dOk0wUdEjoYZ0x3_1ToyAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3GBwDc=RWVixeNW8Ppt4J2dOk0wUdEjoYZ0x3_1ToyAA@mail.gmail.com>

On Mon, Sep 09, 2024 at 04:47:09PM +0200, Jann Horn wrote:
>On Mon, Sep 9, 2024 at 2:48 PM Sasha Levin <sashal@kernel.org> wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     userfaultfd: fix checks for huge PMDs
>>
>> to the 6.1-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
>Thanks for the backport!
>
>Are you also doing the backport for older trees, or should someone
>else take care of that?

I'll do that, thanks!

-- 
Thanks,
Sasha

