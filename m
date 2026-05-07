Return-Path: <stable+bounces-244606-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NFVCO/A/GnSTAAAu9opvQ
	(envelope-from <stable+bounces-244606-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 18:42:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 783BE4EC5E5
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 18:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01B043015E34
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 16:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14354402B90;
	Thu,  7 May 2026 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYo6HLmc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B98A250BF2
	for <stable@vger.kernel.org>; Thu,  7 May 2026 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778172139; cv=none; b=joTAWuFPtKjxVGOzHvjLa8ubV6JmqfG4IVA6ygSYhJOSLBciqjEAbCEkFcJw9VFcScj01pfcDyocxUqmfrQXNhXlck/SzreMPnBIHk82WKTWUfIaCrO/O6NVt0lVj4bu1Bk4kVy3L8hFe+a4hsoC0EBeTFtjCxE5oKjhNN+0LcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778172139; c=relaxed/simple;
	bh=u3ror31K/SolR44VKWPc2Q+Mua5QNfnvH8pM9AFqtMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Winw0YWnj8Z7FP4VLm2wLB97ZwIDZ9BE7ZQ/98vJXE+P4Km0vSK2Y+tlTJZcAHgZvBE+4g4BP+11jWmfAszDZPXr5MFxZMWwXElwCP5cz3IvlqVQGY9cFtAGrA103+dXVJnVWSrxSK1AJaca8r48rdoKTi5SXxMkY4XXZxiXQI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYo6HLmc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so894552f8f.0
        for <stable@vger.kernel.org>; Thu, 07 May 2026 09:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778172137; x=1778776937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DkH5pLwd4aVz/xgL9vdbm3vW9Cqx7RecqkkEDJ2Qoyw=;
        b=SYo6HLmcA/7cUnwilfUm6/CtbKmXwozCBUWp2IaNRmX/NhSO0flDRhIVU40qmuDRXA
         G6ax/sog78LNnmRqkSbUZ6fF6njKMC09dcMDFDgzOtjGJ9ZTP/m5OMEFlx9J8l7WWaOt
         T7n1p1pfneAeSea3eYFItA9dSEoAZ98J/s2uI3wOzT2E3NQALy+C7ddDl8gJQoK1NUPb
         l7KLUce7yWSiR/5LFiHRvfWefJt000+ijd8+2+9RBlekbob3rClAhbwcnNpKKZLj/5er
         09IZaNNBTPDCmpfhglVhYoyX2ojRKjuMeFS/FtJr3yLRT4jZwO/ICnaqtx5uyP5oA8mu
         ELlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778172137; x=1778776937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkH5pLwd4aVz/xgL9vdbm3vW9Cqx7RecqkkEDJ2Qoyw=;
        b=DBa+R5N6LD7dDDuK6ol7YlErs+982/xUjcJJDiypzqxK4KTxGNMX+pBX4G6CJdXeU5
         //tfujBSDfYET8G3DphIELl2SwNQEepHccU14JRoi1aS8bDU8gpSmba997YjbK3lz4gb
         o6PRgdGD8GMpctoyxEo0l4UzuUavoRacgfBl/k+z3YExRhEject2FYbthmgOpJ6F75WA
         tpCdsy89NnQoWefG6Gq3vhrOd2uHHjVYNBwRDSpw8M2wcUzFLhEf/ak5Teh2A1f/6zXC
         ehDe/gOkU15uzWH3pZG3+yHUSEKQU57T1IVd/OTol898Y1/ZO6dzCmD137/h4RU2fPwE
         KX3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9SAGlKkIr3ExuX8miEjISZ2djDGRvzZ8qn57JzAmQlAU/4PWe9Be13ASs2gyjAiW2dSW1Ohvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK/2RYM3mhiun/pepoj2bSE5mH6eUz99oNZIl04zURyN0m/Ly9
	EUSnfXn1vLI1mNhh0Sx2FWpADK5sZq+sNHEGWB4iV9JqQwA6+D2XIecq
X-Gm-Gg: AeBDievH0KzEN7VLpwtQ5Pnp9IFR6BZAcfyqkig8RmkxczMVTabor19ZGc52M/jRC6d
	LpybHmpljtAZr42HZ24xBjTy0aIT0inKJa3YZGwiltfPYNG3t3E46s7/sP4WOKFhqKLGUiRayCM
	ij9koHwzy4z+Guk2sbfmYSzptzmS7In0Ec806tAwyWn7sto+b+i9FOMSYwfjkICwqnqUiajLEct
	humLW0cPiHjjVjJ7CHgrmzya8Hm01RcwldAb56Vc+FdFskWCXlj1qpYxI45+wd0y+6a/GLJ7Xkq
	xAp1eNVGL6ZeqdcHcVsYl845w+kLue0iohyKeVqXylk9Ft1hErnQdIwE0A64H3TMYjB8/ZmfpvK
	gtxCLU/W3r0xClqTQumiTfHOtaUhadJUY8cECv2IOQEVthPw7jscAJqH46sHMTNyDfLgKl1ijFK
	q3NeaMlnmyLRQYvj6Rev6l8Ht+r6DP5r0ylw709Y/WuAUbCQT+qtqZsd9clWLEsdNtiv1Or0Ou
X-Received: by 2002:a5d:5f48:0:b0:43b:498f:dceb with SMTP id ffacd0b85a97d-4515b056b4dmr14242651f8f.9.1778172136625;
        Thu, 07 May 2026 09:42:16 -0700 (PDT)
Received: from ?IPV6:2a02:8109:8617:d700:d9bb:cdec:69e5:2f8e? ([2a02:8109:8617:d700:d9bb:cdec:69e5:2f8e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45412820340sm309996f8f.2.2026.05.07.09.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 09:42:16 -0700 (PDT)
Message-ID: <7a353450-770a-4820-ad23-8066b736d87e@gmail.com>
Date: Thu, 7 May 2026 18:42:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] media: i2c: alvium: Fix controls for WB/AWB
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: martin.hecht@avnet.eu, michael.roeder@avnet.eu, stable@vger.kernel.org,
 Tommaso Merciai <tomm.merciai@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260505142513.1551721-1-mhecht73@gmail.com>
 <afsJz1vVdd3o-pe9@kekkonen.localdomain>
 <37aa90a3-7909-4605-a0be-1545db1fadb0@gmail.com>
 <afsh2tmV5AFlMCML@kekkonen.localdomain>
Content-Language: en-US
From: Martin Hecht <mhecht73@gmail.com>
In-Reply-To: <afsh2tmV5AFlMCML@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 783BE4EC5E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_CC(0.00)[avnet.eu,vger.kernel.org,gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244606-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhecht73@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

Hi,

that patch has been superseded by patch 
20260507163443.39794-1-mhecht73@gmail.com what addresses more critical 
issues.

Martin

On 5/6/26 13:11, Sakari Ailus wrote:
> Hi Martin,
> 
> On Wed, May 06, 2026 at 12:16:13PM +0200, Martin Hecht wrote:
>> Hi Sakari,
>>
>> thank you for the comments.
>>
>> On 5/6/26 11:28, Sakari Ailus wrote:
>>> Hi Martin,
>>>
>>> Thanks for the patch.
>>>
>>> On Tue, May 05, 2026 at 04:25:10PM +0200, Martin Hecht wrote:
>>>> With that patch the controls for red-balance and blue-balance were created
>>>> only if the particular camera supports that. Otherwise the pointers on
>>>> the control variable are initialized with NULL to prevent side effects for
>>>> clustering with AWB control.
>>>>
>>>> Fixes: 0a7af872915e ("media: i2c: Add support for alvium camera")
>>>> Signed-off-by: Martin Hecht <mhecht73@gmail.com>
>>>> ---
>>>>    drivers/media/i2c/alvium-csi2.c | 37 ++++++++++++++++++++-------------
>>>>    1 file changed, 22 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
>>>> index b62b45a4f2fc..4c6934e9e177 100644
>>>> --- a/drivers/media/i2c/alvium-csi2.c
>>>> +++ b/drivers/media/i2c/alvium-csi2.c
>>>> @@ -2108,26 +2108,33 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
>>>>    						  0, 0, &alvium->link_freq);
>>>>    	ctrls->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
>>>
>>> This is a problem. Can you move setting the flags after checking the
>>> handler's error status? The functions adding controls may fail and this is
>>> simply a missing error check.
>>>
>>> Can you submit a fix, with a Fixes: tag and this patch should be rebased on
>>> the fix, please?
>>
>> I'm preparing a separate fix for that issue. It's the same situation also
>> for some other controls like pixel_rate and link_frequency but not only. Can
>> I combine that into one patch for fix only that in alvium_ctrl_init?
> 
> Please do.
> 


