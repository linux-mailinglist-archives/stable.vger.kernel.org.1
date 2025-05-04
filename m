Return-Path: <stable+bounces-139570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5030DAA8862
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 19:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9C517685E
	for <lists+stable@lfdr.de>; Sun,  4 May 2025 17:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CB21E5219;
	Sun,  4 May 2025 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="2s3BJqNT"
X-Original-To: stable@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E981DDA00
	for <stable@vger.kernel.org>; Sun,  4 May 2025 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746379089; cv=none; b=JQkNa9DLD2CLeFafSxZaF6NOKM8eN04giVUkGiShWSXb7ZkkXPIj9aMgdafM622J09HwNkV0qUclRQfGbldYyOy+DOCPbC/6c/gJCxgw6JYrh88/vPIEysE+LbtgrDCO/bDGOfZzDHQn5gadBg3bdwGfhfVKhd1MPWVJbeJCYFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746379089; c=relaxed/simple;
	bh=CdvLne7i5IYq79xXte5THCZ7ybAIKa+F9DQBiwQ3S0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6qR9alE/WU+3gG5y79/BGtXkLNbTfIGlaXfvu9izi5Io98B+TwYQi1ehE7ZeaCf6+QUOc5k10+XVXQZh44Q3JCzT91qG+RNfIAtR1U/cTrxfnFCzVly+2JADNesFHcSq3yr1ZaiBfQ7GZSh0OUy+YzARWRUC+PQx2RkXTLtfHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=2s3BJqNT; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4ZrB8x3JZZzm0yVY;
	Sun,  4 May 2025 17:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1746378864; x=1748970865; bh=8bzTeEJKNHHiV/xidXJRqCxW
	4HfVFwiwPa0MkO4/ZHM=; b=2s3BJqNTYWd/hEuF48TsjzlXrAy5/wVJetllhJ5h
	t4uLlrTc1GFByCJIcOx7909rcfo8QkhKiCubnlPqQnCICdfjsQvWTloCgA/B3Zz2
	eP0ZWIepC/cNnC0IwE1xTpDB2pVGP3uhnYTobOnnno7RTXywZcDpCmh5U/YyL/ro
	LszIQyFKV/BPDt0+uTKnE5vyi1f2MkVw7jM8ram5TBpUtmVsJrFm5UoEPIx2epkH
	As/3SyaVsf9rCkJbtpRO7YNviuUyZTD1NYUCUbc54Io+mnnxY8zH3qmxboQwJsX7
	8Jtje5u90hUXfP+8VC9CXy8hUgRY2ktHMI7i6WfcpCFjeQ==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id o5Cx2BFtI3S5; Sun,  4 May 2025 17:14:24 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4ZrB8q6CwHzm0yQj;
	Sun,  4 May 2025 17:14:18 +0000 (UTC)
Message-ID: <f0833f7a-d7e7-4177-93bf-709bb24de7ef@acm.org>
Date: Sun, 4 May 2025 10:14:17 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Preserve the request order in the block layer
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250418175401.1936152-1-bvanassche@acm.org>
 <2025042223-subsiding-parka-b064@gregkh>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <2025042223-subsiding-parka-b064@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/25 4:51 AM, Greg Kroah-Hartman wrote:
> On Fri, Apr 18, 2025 at 10:53:58AM -0700, Bart Van Assche wrote:
>> Hi Greg,
>>
>> In kernel v6.10 the zoned storage approach was changed from zoned write
>> locking to zone write plugging. Because of this change the block layer
>> must preserve the request order. Hence this backport of Christoph's
>> "don't reorder requests passed to ->queue_rqs" patch series. Please
>> consider this patch series for inclusion in the 6.12 stable kernel.
>>
>> See also https://lore.kernel.org/linux-block/20241113152050.157179-1-hch@lst.de/.
> 
> You sent this twice, right?  I'll grab this "second" version as I'm
> guessing they were the same?

(took the past two weeks off)

Hi Greg,

stable@vger.kernel.org was not Cc-ed the first time I sent this series,
hence the resend. Both series are indeed identical.

Thank you,

Bart.

