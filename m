Return-Path: <stable+bounces-238211-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKIpFUH632ntbAAAu9opvQ
	(envelope-from <stable+bounces-238211-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 22:51:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1818407B87
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 22:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA41D30C103C
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 20:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AF638B7C9;
	Wed, 15 Apr 2026 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dvRAq16f"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D6738B129
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 20:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286202; cv=none; b=to72uZSOd4yGMPF3Fu1GRrDJFb3U+Q9EbxqrDz31B30QRcChX1bJbSb4AOpPIHI7KYs+Tv+I4KVCdGVMEhmbBVJnII6cxFw+OUVFXQasyuKkkDk4CmLPJcjvc5Mgek9tvHPT0R+nxMLeNLPvlDt18vzqS3oufg5QWHCTHsWikDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286202; c=relaxed/simple;
	bh=XPyATpRpP6Fw9JKvgIKVLeMTg5EY/XceYweZor7TSdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qcR0XE3KS4OUmmVhmmVe5Ol3iUtgaJB+5XGgfw4U7E4ajlOP/DrimILXms5t5hrP4RthfeIbcS+iMuf60YQbRhA8So810KnSoIvmtLie0F4hH2hj6hdv4ddsSlsFnMznJz35NoezVQxtFelbVWgZyrZZDWJ99w8ufDO49dKIYuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dvRAq16f; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d86eb7c854so3601228a34.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 13:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776286198; x=1776890998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fXRmZFUi3/NUGdrIU0HiWh6hUGnEEJ0BOLVJoZTzlo4=;
        b=dvRAq16feIyt2mDV03XY9P99ydpDN+LnSgdDiu9LzSOVQYjkv8M+2Zh4CSGX03tki5
         GZ9ItndsswpCd4JWi37rzpFQK3Wp9xG98LETDEpwcKbfE9e9IV+KM8sYgPEKZd/yhhtO
         RQTxkPnXXE7dgnHiTjKGa+OrdeMcrYPxRLwZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776286198; x=1776890998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXRmZFUi3/NUGdrIU0HiWh6hUGnEEJ0BOLVJoZTzlo4=;
        b=tRaVLKegF2UtLeK0UetZBYLb/zdpX62MbZFMFLF5eDArdTN9AZmCdW5R82sJzrp3rT
         VmDSBZv3A+rbNTiLWu9IjevKpHcMPFIAhbrynHi3QRlKM+iFMw5k7z2WS6PncAv27Cug
         3gC/VFOsa/0DMnNWNVVYMdsn999PdcnvPrc0aDYI2FQh9RijRkVVnaawl/vYHwb3zgZp
         e4N0iXEi3tsc3CvQvUMhx0zy5t7/jcQgfSWhJ5bN6VrzGmCxYANf+vVIFJoyVxVOKIWG
         U0NJE2/gfTYCzJd5d2xV+OXi274l189JVmLDrtOm3TrGV/4tp7U6T2GI/tsxDKr2engq
         gdkA==
X-Forwarded-Encrypted: i=1; AFNElJ/Oa4FKVXYh3ttKcLawJDOL/AzKVahh1JjFl1LbPSbXEwG+DOwrejwmE+6f+eSUggu46W2eU20=@vger.kernel.org
X-Gm-Message-State: AOJu0YziBZ2tSy2wVyHpnTgGCoOslWZma2Aa13tlttBL/9b+CcfzzHHX
	f0fsf5bGfAfvHLDWXy8mmnmyj5Eq+Un+vpHEK34luLvoxJow4pkcfXi48pPkw6kX2UQ=
X-Gm-Gg: AeBDietHEHREk3SsJXJXf7wQB2pKZYVazUE0CfHSxGG4bhkoX/zsDcort66/WfqEvf6
	MUB4Ye+CyUtxcRyld5OF+8pPwfNn+TSEy/SXCaKckbh3YB2XXVMzPUUcP3wkY4JwJKoJuSu988O
	E5WXj0R3kaioJbxlHv23IuEsE+9BTJchlohOZ71E6RHyB9VZnZbneTBeR768lVO1Sad7VpLIU1I
	JqhRM8dm1fpjCk+rAVWFGcnc5KGTrgfbMKOyMNp1YlS66645r9qmG/WzUJsM73UJblO5TaoVB91
	Jrmy7nKou3Qtze3k6HtjzywtD0jggbW784hLDfIEvedMGx+H3xgqypHZaHbARdmBn0VL6skXQ0D
	rhhgue0CkskzzJSlC1+ZJ+xpRxfSuE3fsAjvOTMdqkXnt5yiOMj9UBIO8LCh0eCWEGHC0tWzVpV
	8CkLKtK5xv1m5ce5FXuyoj9gtQQOrzzVc=
X-Received: by 2002:a05:6820:168c:b0:681:22fd:a589 with SMTP id 006d021491bc7-68be5a636d6mr12796440eaf.11.1776286198589;
        Wed, 15 Apr 2026 13:49:58 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42689699dc8sm2210443fac.14.2026.04.15.13.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 13:49:56 -0700 (PDT)
Message-ID: <a189c5e7-9119-43ad-8a90-b96cc40fed06@linuxfoundation.org>
Date: Wed, 15 Apr 2026 14:49:56 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: vimc: fix reference leak on failed device
 registration
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260415154537.3451732-1-lgs201920130244@gmail.com>
 <75275f6e-8314-4dd6-a54e-95320c2224e2@linuxfoundation.org>
 <CANUHTR9j8-wHB8rE1zGLaUw4ZyNh2Mq3njFerBoUcVPWAh7w6A@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANUHTR9j8-wHB8rE1zGLaUw4ZyNh2Mq3njFerBoUcVPWAh7w6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-238211-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E1818407B87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/15/26 10:56, Guangshuo Li wrote:
> Hi Shuah,
> 
> Thanks for reviewing.
> 
> On Thu, 16 Apr 2026 at 00:01, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
> 
>>
>> Can you share your manual review?
>>
>> Can other static analysis tools for example scripts/coccinelle support
>> your findings?
>>

Did you try other static analysis tools in the kernel?

>>>
>>> Fixes: 4babf057c143f ("media: vimc: allocate vimc_device dynamically")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>>> ---
>>>    drivers/media/test-drivers/vimc/vimc-core.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/media/test-drivers/vimc/vimc-core.c b/drivers/media/test-drivers/vimc/vimc-core.c
>>> index 15167e127461..fee0c7a09c4f 100644
>>> --- a/drivers/media/test-drivers/vimc/vimc-core.c
>>> +++ b/drivers/media/test-drivers/vimc/vimc-core.c
>>> @@ -421,6 +421,7 @@ static int __init vimc_init(void)
>>>        if (ret) {
>>>                dev_err(&vimc_pdev.dev,
>>>                        "platform device registration failed (err=%d)\n", ret);
>>> +             platform_device_put(&vimc_pdev);
>>
>> Where does platform_device_get() happen when platform_device_register() fails?
>>
>> thanks,
>> -- Shuah
> 
> My manual review was based on the platform_device_register() call
> chain and its documented lifetime rules.
> 
> The relevant code path is:
> 
> ret = platform_device_register(&vimc_pdev);
> if (ret) {
> dev_err(&vimc_pdev.dev,
> "platform device registration failed (err=%d)\n", ret);
> return ret;
> }
> 
> and
> 
> int platform_device_register(struct platform_device *pdev)
> {
> device_initialize(&pdev->dev);
> setup_pdev_dma_masks(pdev);
> return platform_device_add(pdev);
> }
> 
> If platform_device_add() fails, platform_device_register() returns an
> error, but the reference initialized by device_initialize() is still
> owned by the caller. The API documentation for platform_device_register()
> also explicitly says:
> 
> "Never directly free @pdev after calling this function, even if it
> returned an error! Always use platform_device_put() to give up the
> reference initialised in this function instead."
> 
> So there is no matching platform_device_get() on the failure path.
> The reference comes from device_initialize(), and platform_device_put()
> is needed to drop that initial reference when registration fails.
> 
> That was also how I manually confirmed the issue after the tool report:
> I checked the platform_device_register() / platform_device_add()
> implementation and verified that the vimc failure path returns directly
> without calling platform_device_put().
> 
> I found this issue using a tool I recently developed. The scan was run
> on kernel version v7.0-1262-g4fa12523f7bc.

There are several calls to platform_device_register() all over the kernel.
Did your tool find all other cases or just this one?

thanks,
-- Shuah

