Return-Path: <stable+bounces-68118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 764379530B9
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9CB1F23991
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403E144376;
	Thu, 15 Aug 2024 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="bpWjlHb/"
X-Original-To: stable@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C917DA9E
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729553; cv=none; b=hydsA99oZ5z7h6Mpe5i10a0RLKkGUAwoECRGPYwjMX4RljwoPyKJ9MonNEHpn6priVS8SBW9Z8uSTyRpX6LrXM7tBvPkcEO3B1ukHJJxJhkWekMRRCtI5STNpe6zJTm+4Q/oE9Qja2liHn4snmAGdUqozHxgRsgOiE0av+9mEYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729553; c=relaxed/simple;
	bh=SL9UbB6BY971WgSh7TDdF+vgA1FH+hQcV3CHNTnsukk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlAlzdxllicosyiKRjSYjUQtIW1Vfm58uWTAkCChDAdxRekQ2mikWL5kvfSzBkSAPUWTzqD+ppFL41ikvI+Bbl8WV7z2T84SmIejvABkuOfxCn+oLlxoQoQhemdFYSjsu43m58pwXEAhRvDEUVJ4f0tHKaO0z1nCE3IXMrMVVUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=bpWjlHb/; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Wl5xB55gcz6CmLxR;
	Thu, 15 Aug 2024 13:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1723729548; x=1726321549; bh=fuo2MfYobtcR0nWDiWai+nk7
	zd6niHCDBqqGcwoxPeE=; b=bpWjlHb/ZTn0C0nrXQL08LPAmxvc7/Xgqeek83BM
	XIUUmNXjFbmvMZD5be+xet56o9xTzvuHt6cIuAOE6Dfw4zCBFV2qhnedYaf3msoN
	9iPJ4U+l65asgD5oeFiZs/ivUBxEtrWzYFZBvCFDfe3v5tp+kEELYGbOV8Ggh1ZZ
	Vk5EQ5MooTRDWnL23dlu5Ef/FzoGlYemohjKkd3rulh9z1CQYXZc0rQRfYyg8RAe
	KgyP8ygOvwOmmoyC2DTFMHw3Eau9SXlZ/heRHsCjDqPqG9lsNu74VH1cQslpVLMK
	Z6UoUrB5XLksL8MfBlYDZMKCSsVmrbw+HPc4N99ap1JO5Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id gW-8mGFeVjtO; Thu, 15 Aug 2024 13:45:48 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Wl5x70tvYz6CmM6c;
	Thu, 15 Aug 2024 13:45:46 +0000 (UTC)
Message-ID: <1198232d-51a2-4f1a-ba9d-776e2b73e6dc@acm.org>
Date: Thu, 15 Aug 2024 06:45:39 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 0/2] Two patches related to CPU hotplugging
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Stevens <stevensd@chromium.org>,
 Dongli Zhang <dongli.zhang@oracle.com>, Thomas Gleixner
 <tglx@linutronix.de>, stable@vger.kernel.org
References: <20240814182826.1731442-1-bvanassche@acm.org>
 <2024081536-corral-daylong-4838@gregkh>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <2024081536-corral-daylong-4838@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 1:37 AM, Greg Kroah-Hartman wrote:
> On Wed, Aug 14, 2024 at 11:28:24AM -0700, Bart Van Assche wrote:
>> Hi Greg,
>>
>> Please consider these two patches for the 6.6 kernel. These patches are
>> unmodified versions of the corresponding upstream commits.
> 
> Now applied, but what about older kernels as well?

Is anyone using suspend/resume in combination with managed interrupts
with older stable kernels? I submitted this series for the 6.6 stable
kernel because I want these patches to be merged in the Android 6.6
kernel branches. I'm not aware of any use cases for older Android
kernels for managed interrupts.

Thanks,

Bart.


