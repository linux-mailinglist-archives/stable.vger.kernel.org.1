Return-Path: <stable+bounces-28634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 217A688720E
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 18:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544591C22E05
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 17:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7005FDA1;
	Fri, 22 Mar 2024 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NxNje5Gu"
X-Original-To: stable@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7504F5FB86;
	Fri, 22 Mar 2024 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711129426; cv=none; b=qPivCtDzBzIGgw8pe17mSwZ68V5V72YJTwwE5A6fzULmPp2NUfVGCL2hhApwKRupR2t1YooQztnsNkZlpH7u+G3yYrCtj6dQU+Az+7GOaZKwweiguhktTVawyeINwTJZ2iFDVXWdrRWvxqYIdEHwlV9xR+Bnf6VjSVBeXUxNhk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711129426; c=relaxed/simple;
	bh=m1fXwgDw423d9JzS0yBSZigM7s0TBgzERWcrWJKbcF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1qjV7sxgKRg7IcLHFUEYz/gHAdOLVZ7O1HNAJoZtov5Dg/eDy1/sSW1tx4rQnOpJRfME1Kp2ENiL+OGhph2JM0g72IHloXPSM38KvrS4scFO6YVPiKA+fJfw/89OTcPDgmfbCu9EiRG24iljMRTneFn0E+dM/BJHEHMvpDqjdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NxNje5Gu; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V1V735c8Pz6Cnk97;
	Fri, 22 Mar 2024 17:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711129421; x=1713721422; bh=m1fXwgDw423d9JzS0yBSZigM
	7s0TBgzERWcrWJKbcF4=; b=NxNje5GuPdUeDVDZEa4YOvg0810jP1POFixvSx6O
	4ucnANDOlp3BYs1xBoYhG2ssyXfnXaLxT3X2BZ2SnC4sLjopvYlIllWr5sv6RAyi
	Yf7PxnxlooeezS8D5yjpQRieP5/M3mgJp+04CXctwYz+3yppB9/nYip+vax14CrL
	YzW+z51qsBAaobiFTe6hboQZi3oHcCwog2zTAqLdblTWa58ah8nx803EjwfaKq2J
	UBxuZgEFFUBGJelJ2rshxbK6WFCXJcPG88dUi2j3mLmU+YrzKBNclE9aq9qXWrjY
	Y3k5jUpORLQ3BhJwA0VNTK40EquVnPeT3yCvr0dQuNzmWg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wu843SBdYDpB; Fri, 22 Mar 2024 17:43:41 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V1V700q1jz6Cnk95;
	Fri, 22 Mar 2024 17:43:39 +0000 (UTC)
Message-ID: <f02c32a3-ef59-46d0-bc62-e1f3e1a45406@acm.org>
Date: Fri, 22 Mar 2024 10:43:37 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: release scheduler resource when request completes
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org,
 linux-block@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
 kernel test robot <oliver.sang@intel.com>,
 Chuck Lever <chuck.lever@oracle.com>
References: <20240322174014.373323-1-bvanassche@acm.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240322174014.373323-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/24 10:40, Bart Van Assche wrote:
> commit e5c0ca13659e9d18f53368d651ed7e6e433ec1cf upstream.

This backport is intended for the 6.1 stable kernel series.

Thanks,

Bart.

