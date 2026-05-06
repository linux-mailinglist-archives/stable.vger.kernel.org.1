Return-Path: <stable+bounces-244361-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNBLOkgW+2lGWgMAu9opvQ
	(envelope-from <stable+bounces-244361-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 12:22:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 077674D9471
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 12:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A4F18302516B
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 10:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99634402454;
	Wed,  6 May 2026 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAMIPBph"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87DA3D811B
	for <stable@vger.kernel.org>; Wed,  6 May 2026 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778062581; cv=none; b=gG8QaWSPIbZRwrPwm0JbmX0FcWpyZ6gM+wTpUubaXEFitWpj13foIo1fVUMIgTgjGe/Q3iuafIrz7FU0/ShcK5W8xq5hx2YPJjCgpkdO5RmlUSm2PoIEjlpS5SqNZO4z/W7i54snOnLg7J5FX4mx2vyxsEKf+Chp/2jAugjWJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778062581; c=relaxed/simple;
	bh=XHAbCn/groQfldwxdeD5Eyl+5lyhV01Ox5pQ7n8CcYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3dEQGd3D2UCZNJuTxWFvcY3LrJMevX6Hxf4M8aylYo8OPpx9XfBxt9PM5erDfswn2usWknvixMz7htS/uki/0QJSDwf+j6sAoU8F3Xui8r1Slo0LS+GYABqOUWFwmrfk9G5AuCYdnQKdtE7h443+qNT9hTp02s4H1rNf7tgdZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAMIPBph; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d73422431so5866770f8f.2
        for <stable@vger.kernel.org>; Wed, 06 May 2026 03:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778062575; x=1778667375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MP5zUKceXITgWBoyT5sfmWgOMBr2j3wdzx/KXPcZhWU=;
        b=cAMIPBphJHWJxDFDTWPUXNVXs0VWMNEXBeuA7JOHOKXe9hJMJy0IQtO6680AnEHH7j
         Tvb3In1d4aF/qGkx5t7cchChhQoby6y5wsXmdThsRSRI7C9P0F25ihjokCohMVOLFcPw
         aFZ9Kuq3se+nFO5vpkm2CnYbygvlQpjtpG7/uTYCJ+bszzzTY+OMyJXsvQwrMF1LfI0w
         hjG18jwO33PEH7yPHFQc41PzYN1/pSgbfFZXgWQU+lSuUALSf7+t08orkdMTuAObbcH2
         u43LPRazt8rzNkawTIRq8qfcq208P2uK22dFtRRS24KjoVSSPEq+Cyflryxhekbz8gEv
         EEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778062575; x=1778667375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MP5zUKceXITgWBoyT5sfmWgOMBr2j3wdzx/KXPcZhWU=;
        b=F69P/ATgQUf1Hfw5H4HwV3j789NQ9ecXYn5tn2CZ/bCBuaXMk1UZFgWNghMtTeWn2f
         y4IXUNSrRLTUtKUks2O5A3yt0+Njuj+3IOHIAH1KrFEWwCJkR9WLM/Lp5mxWqM2T1h4D
         LSNrejP4iBrpsi4Yws73Faj4ypJ0hPHU22cmy4Wqn3A1/T1Cmzzz+2T4BIK0TXI/YRyx
         02HDiadqZQTlg90FmmtMg5wEBPHJIvYxJB9Zto/KnYOwDVaVJJ4iG6so20GON6bUtZM4
         KUHsowTOD5hOdBJnP8fx5qjhG85fDoApI71z4COYbkNmxoGhUGmDUCDzACx2XTuzGOQk
         axQw==
X-Forwarded-Encrypted: i=1; AFNElJ8n2XJ15W8W4i8H+1FzBeQDcY7XVQvI9hSpmLso2wkf/N0CbVN839zTCxLklKSpvOM5SraTvFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylt6xWwZoX4GBq9bSYSc9MQyylT3vXYcEVSIWVQQi8/NvZZc/4
	8KZKGga3cITieDDdKkAdZe/IKx6yqJ1pSq6/+/riNjgA6xvH906Akq2u
X-Gm-Gg: AeBDieupw/RP49hiL3B2oSEF8TKm0uM7WEPq3reu2UM8d6p+PzxvQazWCf5bdvxlEfM
	RMJeLXK0quD2ts0mlnOQhmvc4zW65BpTyVXzX9xCswQcEL6NkqGbq/RZInS0UL5Co2GyBugv31Z
	H1sDPl3akw/oEG8szX55ViSD40OH8xh8/n5lj5eP9HVoUkBudaS68WAibdcB0vi62AdupoluyBS
	3szCyjA/CXinGLO+c8qfHi2yu5g+ysDiqrb4favk0qfaYCbQqECFjodxv/gjpz88eF8QIKxHWp+
	114aNrYZ/g8qJzoRWF6mGY3UN7eAkeeDznPoHdeJDE7tULs4KqKHwAaBCIG5JbfcUf4RiVZa7p9
	m33W791prHL+lKyPjN6rNCbMGBgKjIcBgMlpZY2HfClvqT7ysv/rpKuDStccOP0J0pULTVCqVOs
	dqj5raEElJ5z/+PRz1DI9YQ6FyrPTi3MDOQBspKv3YVUo94KhQLu402/nJUuoYWVOCOC5bVPIDI
	o7BpGvj
X-Received: by 2002:a05:6000:2681:b0:441:1e41:194 with SMTP id ffacd0b85a97d-4515b525426mr4784852f8f.17.1778062575284;
        Wed, 06 May 2026 03:16:15 -0700 (PDT)
Received: from ?IPV6:2a02:8109:8617:d700:a1d:902c:85c8:d272? ([2a02:8109:8617:d700:a1d:902c:85c8:d272])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4504f4857ffsm11043763f8f.0.2026.05.06.03.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 03:16:14 -0700 (PDT)
Message-ID: <37aa90a3-7909-4605-a0be-1545db1fadb0@gmail.com>
Date: Wed, 6 May 2026 12:16:13 +0200
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
Content-Language: en-US
From: Martin Hecht <mhecht73@gmail.com>
In-Reply-To: <afsJz1vVdd3o-pe9@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 077674D9471
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[avnet.eu,vger.kernel.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-244361-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhecht73@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hi Sakari,

thank you for the comments.

On 5/6/26 11:28, Sakari Ailus wrote:
> Hi Martin,
> 
> Thanks for the patch.
> 
> On Tue, May 05, 2026 at 04:25:10PM +0200, Martin Hecht wrote:
>> With that patch the controls for red-balance and blue-balance were created
>> only if the particular camera supports that. Otherwise the pointers on
>> the control variable are initialized with NULL to prevent side effects for
>> clustering with AWB control.
>>
>> Fixes: 0a7af872915e ("media: i2c: Add support for alvium camera")
>> Signed-off-by: Martin Hecht <mhecht73@gmail.com>
>> ---
>>   drivers/media/i2c/alvium-csi2.c | 37 ++++++++++++++++++++-------------
>>   1 file changed, 22 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
>> index b62b45a4f2fc..4c6934e9e177 100644
>> --- a/drivers/media/i2c/alvium-csi2.c
>> +++ b/drivers/media/i2c/alvium-csi2.c
>> @@ -2108,26 +2108,33 @@ static int alvium_ctrl_init(struct alvium_dev *alvium)
>>   						  0, 0, &alvium->link_freq);
>>   	ctrls->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> 
> This is a problem. Can you move setting the flags after checking the
> handler's error status? The functions adding controls may fail and this is
> simply a missing error check.
> 
> Can you submit a fix, with a Fixes: tag and this patch should be rebased on
> the fix, please?

I'm preparing a separate fix for that issue. It's the same situation 
also  for some other controls like pixel_rate and link_frequency but not 
only. Can I combine that into one patch for fix only that in 
alvium_ctrl_init?

> 
>>   
>> +	if (alvium->avail_ft.whiteb) {
>> +		ctrls->blue_balance = v4l2_ctrl_new_std(hdl, ops,
>> +							V4L2_CID_BLUE_BALANCE,
>> +							alvium->min_bbalance,
>> +							alvium->max_bbalance,
>> +							alvium->inc_bbalance,
>> +							alvium->dft_bbalance);
>> +		ctrls->red_balance = v4l2_ctrl_new_std(hdl, ops,
>> +						       V4L2_CID_RED_BALANCE,
>> +						       alvium->min_rbalance,
>> +						       alvium->max_rbalance,
>> +						       alvium->inc_rbalance,
>> +						       alvium->dft_rbalance);
>> +	} else {
>> +		/* set to NULL for v4l2_ctrl_auto_cluster if not existing */
>> +		ctrls->blue_balance	= NULL;
>> +		ctrls->red_balance = NULL;
> 
> Aren't the two NULL already before this?

You are right. It's zeroed before because __GFP_ZERO in devm_kzalloc. 
Will remove that redundant code.

> 
>> +	}
>> +
>>   	/* Auto/manual white balance */
>>   	if (alvium->avail_ft.auto_whiteb) {
>>   		ctrls->auto_wb = v4l2_ctrl_new_std(hdl, ops,
>>   						   V4L2_CID_AUTO_WHITE_BALANCE,
>>   						   0, 1, 1, 1);
>> -		v4l2_ctrl_auto_cluster(3, &ctrls->auto_wb, 0, false);
>> -	}
>> -
>> -	ctrls->blue_balance = v4l2_ctrl_new_std(hdl, ops,
>> -						V4L2_CID_BLUE_BALANCE,
>> -						alvium->min_bbalance,
>> -						alvium->max_bbalance,
>> -						alvium->inc_bbalance,
>> -						alvium->dft_bbalance);
>> -	ctrls->red_balance = v4l2_ctrl_new_std(hdl, ops,
>> -					       V4L2_CID_RED_BALANCE,
>> -					       alvium->min_rbalance,
>> -					       alvium->max_rbalance,
>> -					       alvium->inc_rbalance,
>> -					       alvium->dft_rbalance);
>> +
>> +		v4l2_ctrl_auto_cluster(3, &ctrls->auto_wb, 0, true);
>> +	}
>>   
>>   	/* Auto/manual exposure */
>>   	if (alvium->avail_ft.auto_exp) {
> 

BR Martin

