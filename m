Return-Path: <stable+bounces-217817-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMQ7HDudnGmyJgQAu9opvQ
	(envelope-from <stable+bounces-217817-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 19:32:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9B817B8B7
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 19:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C7FF300F78A
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473A936683C;
	Mon, 23 Feb 2026 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVXER1qC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764736682B
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 18:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871542; cv=none; b=uDILIPnF++uwrOxJhMYypR+BZqZzivZjdwF2/9lmtWY4RDM8w7057BwcdPy4Fzdl7vO1TDzc5ohJcoxVxYRn7wgVE5hpdYQ191tbEejbQfXnobzuu/vQnXhJdjbyOF17lklPqXOsEm8shpu5Kd5ltY1J9/3XVxHYxi6cpM5YcBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871542; c=relaxed/simple;
	bh=v3+FRAqjRtsQmTAZeB7dmvPPRvfnEbhfGm1Zu6NB9/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aTdjxxVHtjzJ6Z6BRW9g4XEiH/0AdA3CDnZc12n4oMJpBPHmPTHtwOHEWrHFqAfFXutbAPY/A5JIRKZZlDPxlNgoqh/yhNWldEVE7LqT3z2PyteCCbhS1r+nHRE1IIIIkxrSSUyW55OQUFkaJRMxqxHPO5PFb6MzmqX0QJ53Ydg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVXER1qC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48371bb515eso59016895e9.1
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 10:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771871539; x=1772476339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HmyupKJdg6mPX/153MnpkbuujC4Mu/oGomWgUFW6jc4=;
        b=PVXER1qCePolvPccOocsNY0jOiwqm48E5P4NKrQfrW66/JwXxxy+U7BkovVsOCwcpK
         nS4BDvQtYdf3ij9RvejD1OCaareLnqtoJ3dNYOznMF4z3zjPMf7YBWC5jzOfnnl+2IR/
         AdoSc3CmblB1tWdVh/de9GMapVE5rfnHOsfGUKKIiNwbY2rhwh/V1U9w/KGqtkJLWWLn
         0kNWz3XWUhW1GHrVCCqqpgMIw5uUad7qz06kS9cuw0/FfEB2On9Vnsagu45gcBcS0KoR
         o6O8/IpbvZO5r5oSD0EkQHtL/7+8+tdoBw76fds/LqG9rtJeaNWUvDFL/ijTu2IiF6Xh
         2DfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771871539; x=1772476339;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmyupKJdg6mPX/153MnpkbuujC4Mu/oGomWgUFW6jc4=;
        b=XkCHDuFRhf8g2qxycVRGti/ox8tnQzT9dskow98uKnbBXODlZJeh+olMG9e5xQCiiy
         hCak66YMsZa0ux+j7RzDWPGFPtlk/tKf+lGfoRkaMoTYxKyX8mZS2GkSpZ5oNHqHzJZe
         R8wm1r0WRbTlP5jSN14RfD/zmLOlFxpJoH8wrhJcbAqCLTPfcTjekYCAoWcniNzccLZf
         /iXNHwwXZJtVhrlbWQx+LZ/Ma96qy5NjyMpVhCTwkJoTpeh0YslCWIzMAkn0+b3cQBct
         b4CvQHxPIQHc1wQc1+QAoHGGap34qlTdlsXDR9zxlNRaAWUGyDV1MNhRdAMXj0zyfnZr
         9XVw==
X-Forwarded-Encrypted: i=1; AJvYcCVyGZO1Q21y+cUBLUNSPT7OBwAUpPw1iiPfUqRVlgCG4BgPqzpFz/uIRzEMDHxcv4+hzqRpTB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh5y9Haw1gCKGk1OdCIWq7rLMFRTSvON+lhwfJxkyruVNz7LIE
	0nUfwd+UT4UgjuF4SmzkPGbQ/SPuzU2tg0CJPV5r2tv1gTfZNjE2Q9oC
X-Gm-Gg: ATEYQzwF2X4HcVKbA5Iqx0RvIc7CpXq0qd6cjr1JTEESe9UXcYd5RLMMqxK8lSAUW+G
	neTuXreIjb8JIL9cNjBNw1ST6CqvgTTphSgViwpZPY4WGBVEAudaAKCOliVyG9/LW0roqVnhwqS
	bnMmZeBfarWMl4NLIqSt1F/UfI8UCHk1IKWDVnvoI9hMp40sNNysj6w1Ne9wtsMmJCTHBctfFqK
	OJ4pzPn6z645OgySpURmktex5Rjwk7UTH747mYGOg73oOR4QCFYPT1ZApQr9LNfRtpZ/78Bwi/z
	Ui8dcc5eV84ma2+NCz8+pgUBW45pec75EyRKDHLfkH1/6fk3pus+7QYYLlb3FxxuOdmxWIIQWKu
	eZkL2nJe0PE5VoN76UEKzsYNs0Qjf4jnNcdlGRwOf4T5Bkt9/NgeNQGsmIjM/tZ1Guj9mbGAsJf
	/n/hjwSAcGYZNwyUOZf4J/aN7aic54S2V1sCY=
X-Received: by 2002:a5d:5f83:0:b0:439:5ee1:f64f with SMTP id ffacd0b85a97d-4396f17b4a4mr15751428f8f.46.1771871538812;
        Mon, 23 Feb 2026 10:32:18 -0800 (PST)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bf9f77sm22730111f8f.5.2026.02.23.10.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 10:32:17 -0800 (PST)
Message-ID: <b600e509-a58c-42e4-91bc-d5222638b48f@gmail.com>
Date: Mon, 23 Feb 2026 19:32:16 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] media: v4l2-flash: Enter LED off state after file
 handle closed
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: cy_huang@richtek.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bryan Wu <cooloney@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 roger-hy.wang@mediatek.com, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 laurent.pinchart@ideasonboard.com
References: <1106c60cb96786ade1f60c692e566c408d7d8174.1768209230.git.cy_huang@richtek.com>
 <f5980192-a878-47ed-9b38-8607fb7abdc2@gmail.com>
 <aZwhSj4jhEOUKZ3x@kekkonen.localdomain>
Content-Language: en-US
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <aZwhSj4jhEOUKZ3x@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[richtek.com,kernel.org,gmail.com,samsung.com,mediatek.com,vger.kernel.org,ideasonboard.com];
	TAGGED_FROM(0.00)[bounces-217817-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacekanaszewski@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A9B817B8B7
X-Rspamd-Action: no action

Hi Sakari,

On 2/23/26 10:43, Sakari Ailus wrote:
> Hi Jacek,
> 
> On Sat, Feb 21, 2026 at 04:48:48PM +0100, Jacek Anaszewski wrote:
>> Hi ChiYuan,
>>
>> On 1/12/26 10:20, cy_huang@richtek.com wrote:
>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>
>>> To make sure LED enter off state after file handle is closed, initiatively
>>> configure LED_MODE to NONE. This can guarantee whatever the previous state
>>> is torch or strobe mode, the final state will be off.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 42bd6f59ae90 ("media: Add registration helpers for V4L2 flash sub-devices")
>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>>> ---
>>> Still cannot pass patch integration check, send v3 patch to fix all.
>>>
>>> v3
>>> - Remove 'Reported-by' tag
>>> - Fix identation check for patch integration
>>>
>>> v2
>>> - Fix commit message redudant space cause patch robot parsing error
>>>
>>> Hi,
>>>     We encounter an issue. When the upper layer camera process is crashed,
>>> if the new process did not reinit the LED,  it will keeps the previous
>>> state whatever it's in torch or strobe mode
>>>
>>> OS will handle the resource management. So when the process is crashed
>>> or terminated, the 'close' API will be called to release resources.
>>> That's why we add the initiative action to trigger LED off in file
>>> handle close is called.
>>> ---
>>>    drivers/media/v4l2-core/v4l2-flash-led-class.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/media/v4l2-core/v4l2-flash-led-class.c b/drivers/media/v4l2-core/v4l2-flash-led-class.c
>>> index 355595a0fefa..46606f5cc192 100644
>>> --- a/drivers/media/v4l2-core/v4l2-flash-led-class.c
>>> +++ b/drivers/media/v4l2-core/v4l2-flash-led-class.c
>>> @@ -623,6 +623,12 @@ static int v4l2_flash_close(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
>>>    		return 0;
>>>    	if (led_cdev) {
>>> +		/* If file handle is released, make sure LED enter off state */
>>> +		ret = v4l2_ctrl_s_ctrl(v4l2_flash->ctrls[LED_MODE],
>>> +				       V4L2_FLASH_LED_MODE_NONE);
>>> +		if (ret)
>>> +			return ret;
>>> +
>>>    		mutex_lock(&led_cdev->led_access);
>>>    		if (v4l2_flash->ctrls[STROBE_SOURCE])
>>>
>>> base-commit: 8ac28a6642d1cc8bac0632222e66add800b027fa
>>
>> The patch itself looks good, but while at it I started wondering
>> if we shouldn't move below STROBE_SOURCE access before the lock.
>> I don't see now, why we placed it there.
>>
>> Adding Sakari.
> 
> Thanks for cc'ing me.
> 
> The behaviour this patch changes has been around for a decade or so. I
> wonder what breaks if we change it now. It works the same way as the sysfs
> LED API, too, and I think common behaviour between the two APIs was the
> reasoning back then as well.

The thing is that v4l2_flash_open() disables LED sysfs interface via
led_sysfs_disable() and v4l2_flash_close() enables it via 
led_sysfs_enable(). led_sysfs_{enable|disable}() modify the state of
LED_SYSFS_DISABLE flag.

Therefore it is only the led_sysfs_{enable|disable}() API that needs to
be called under led_access lock, since the LED subsystem sysfs handlers
test the LED_SYSFS_DISABLE flag under the same lock, and return -EBUSY
in case it is set.

The call to v4l2_flash_close() is synchronized internally in V4L2 core
I believe.

Therefore I think that we can safely move the
"if (v4l2_flash->ctrls[STROBE_SOURCE])" condition before the lock.

Otherwise we would have to put this new v4l2_ctrl_s_ctrl() call,
added in this patch also under the lock because why not. It would spark
questions in the future asking how it is different from the above
"v4l2_ctrl_s_ctrl(v4l2_flash->ctrls[LED_MODE]" case.

-- 
Best regards,
Jacek Anaszewski


