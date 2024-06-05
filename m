Return-Path: <stable+bounces-47974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB098FC43C
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 09:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99CE1F2307A
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 07:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB0E18C33D;
	Wed,  5 Jun 2024 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zWDTpQxh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A30918C336
	for <stable@vger.kernel.org>; Wed,  5 Jun 2024 07:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571670; cv=none; b=CpLOAS6dwS5LA2W4KFg8S3aZoFGMEcnveUq41gCqlE/khE/aIlgpBoiqXlPjDuQjUHXHdqJ1pn963knionjvDfVBKWoibBL58mgz5kjXYKMwnqw18u1y4AqcyG49sjqaM0nAh7A6jrS5RDpnoiwAPI/aN3l6MBpL3FsCTVP7gWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571670; c=relaxed/simple;
	bh=7gfKGkLLinmKptBXlFhQDA9jvY3M8WabnmHCh2jx9Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M48Y+hBVRMvR+xwRIOcg7VNnIsaKABIynA/yva9XRRBySbDMasSYpd6a91ukrF4ZgvdppckJ93zfJwQt+9qm9B40QaRg8bIkskHqneZyZ2FL8oaFahqjvt1aZi4wFEeGsZmwxwCbxXfA6SfTQgiG3L1lmlBuQvVRg97xa7JEdnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zWDTpQxh; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-35e573c0334so291710f8f.1
        for <stable@vger.kernel.org>; Wed, 05 Jun 2024 00:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717571667; x=1718176467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qtyh0MFjbxsRtdPcXS5/KqH5XPxTZWd1pjFmJgm7Usw=;
        b=zWDTpQxh0oza54nSfe7uxHXQNIHKmFYX9lHty1L2w2UUbabyMFZ45vK7rYrQns8mvd
         qnFY8NriFLIZ2fWOp/EcuyE0+PU5C3g6PhgYBPucCYaPz0ZGDovGsH3OL80IQbNen0SI
         gGdl0bIbdRIN8PIC50qIh0hBfHdHlQlhz2RaHGH61JK6m9ql4Swkk8wncFGMzBOeZ2se
         GT1Msyd0klFeMAqrkMJPxECyX+oTb60+Q4lJ04QCDPQtIGX0xieuRyLIAxwjaK8i0jrE
         ULpE7XwqYI+CyJ4qwySMlZBHBHNW7iEqSbtg+tY1sm3AkbiTsLl56VoVwlb6etMMdrAK
         fwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717571667; x=1718176467;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qtyh0MFjbxsRtdPcXS5/KqH5XPxTZWd1pjFmJgm7Usw=;
        b=pJu4YFV/QSBs7CgxiXsF/ugkuYiTFYxvmFwshl6ISuk6zIWQnXpRS+lfzCdzsullKW
         qRtEckMGD3HqbumCAR85hteejdjbMH1QvqyklM4+2wFRUMWDp0gaZ7F/+a10X1uPRxpj
         GKKJrM96+fxwWx+D6IRHawgzMTNmfySx3qsDrpmeWbkiZX01o2HiV3u8T3lyPpFYFduv
         I9FF6Ucd0sTsT1yr1ICaDpxei8GKAvlmWPjpSkOCwstJPl00Zcet2eHiYhVLv8d9b+Gq
         W0NLLZWOyMYsWVC5Z50Sw+6xVdOFdz7kX9nSUmW3UUrFLBgJhADOYDeZn5OtJka8XrnX
         WXvA==
X-Forwarded-Encrypted: i=1; AJvYcCVywxL/UwqRjYj5b6ptfsPELe8nm9OVcBQb8eLfb8YewagpCHoQIfs1YK983aIuJrd8+1Q2bD5dlrqsEzIO9/Xd9VP6Kepp
X-Gm-Message-State: AOJu0Yy4mQkvYjasntRPrxDe49Eg1BrAY7RkPxqWknDN+LsMn2Q3TYO4
	JONtU8efry4zmuxu6lk1h/OVUolOsrU1sEkHN3PeIN0ZpSLq4Y5V+9s1t9jHyIM=
X-Google-Smtp-Source: AGHT+IGkCexM7BfvOAMH5aT2dnjwoCvRP+O42hTsPG57AQNBqJWJ90JPUZP9QyW4bE/IUwPwANy0kA==
X-Received: by 2002:a5d:4c48:0:b0:34f:8f7c:8fe2 with SMTP id ffacd0b85a97d-35e7c52d3c6mr3901922f8f.10.1717571666827;
        Wed, 05 Jun 2024 00:14:26 -0700 (PDT)
Received: from [192.168.2.24] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215812de8dsm9638595e9.25.2024.06.05.00.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 00:14:26 -0700 (PDT)
Message-ID: <3d27add1-782c-4c19-9d84-d0074113c7a2@linaro.org>
Date: Wed, 5 Jun 2024 09:14:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: Fix BT enable failure again for
 QCA6390 after warm reboot
To: Lk Sii <lk_sii@163.com>, Zijun Hu <quic_zijuhu@quicinc.com>,
 luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, wt@penguintechs.org,
 regressions@lists.linux.dev, pmenzel@molgen.mpg.de, stable@vger.kernel.org
References: <1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com>
 <7927abbe-3395-4a53-9eed-7b4204d57df5@linaro.org>
 <29333872-4ff2-4f4e-8166-4c847c7605c1@163.com>
 <5df56d58-309a-4ff1-9a41-818a3f114bbb@linaro.org>
 <0618805b-2f7a-473d-b9fb-aea39a1ef659@163.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <0618805b-2f7a-473d-b9fb-aea39a1ef659@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/06/2024 03:49, Lk Sii wrote:
> 
> 
> On 2024/6/4 23:18, Krzysztof Kozlowski wrote:
>> On 04/06/2024 16:25, Lk Sii wrote:
>>>
>>>
>>> On 2024/5/22 00:02, Krzysztof Kozlowski wrote:
>>>> On 16/05/2024 15:31, Zijun Hu wrote:
>>>>> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
>>>>> serdev") will cause below regression issue:
>>>>>
>>>>> BT can't be enabled after below steps:
>>>>> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
>>>>> if property enable-gpios is not configured within DT|ACPI for QCA6390.
>>>>>
>>>>> The commit is to fix a use-after-free issue within qca_serdev_shutdown()
>>>>> by adding condition to avoid the serdev is flushed or wrote after closed
>>>>> but also introduces this regression issue regarding above steps since the
>>>>> VSC is not sent to reset controller during warm reboot.
>>>>>
>>>>> Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
>>>>> once BT was ever enabled, and the use-after-free issue is also fixed by
>>>>> this change since the serdev is still opened before it is flushed or wrote.
>>>>>
>>>>> Verified by the reported machine Dell XPS 13 9310 laptop over below two
>>>>> kernel commits:
>>>>
>>>> I don't understand how does it solve my question. I asked you: on which
>>>> hardware did you, not the reporter, test?
>>>> It seems Zijun did NOT perform any tests obviously.
>>> All these tests were performed by reporter Wren with her machine
>>> "Dell XPS 13 9310 laptop".
>>
>> Wren != Zijun.
>>
>>>
>>> From previous discussion, it seems she have tested this change
>>> several times with positive results over different trees with her
>>> machine. i noticed she given you reply for your questions within
>>> below v1 discussion link as following:
>>>
>>> Here are v1 discussion link.
>>> https://lore.kernel.org/linux-bluetooth/d553edef-c1a4-4d52-a892-715549d31ebe@163.com/T/#m7371df555fd58ba215d0da63055134126a43c460
>>>
>>> Here are Krzysztof's questions.
>>> "I asked already *two times*:
>>> 1. On which kernel did you test it?
>>> 2. On which hardware did you test it?"
>>>
>>> Here are Wren's reply for Krzysztof's questions
>>> "I thought I had already chimed in with this information. I am using a
>>> Dell XPS 13 9310. It's the only hardware I have access to. I can say
>>> that the fix seems to work as advertised in that it fixes the warm boot
>>> issue I have been experiencing."
>>
>> I asked Zijun, not Wren. I believe all this is tested or done by
>> Qualcomm on some other kernel, so that's my question.
>>
> Zijun is the only guy from Qualcomm who ever joined our discussion,
> he ever said he belongs to Bluetooth team, so let us suppose the term
> "Qualcomm" you mentioned above is Zijun.
> 
> from discussion history. in fact, ALL these tests were performed by
> reporter Wren instead of Zijun, and there are also NOT Zijun's Tested-by
> tag, so what you believe above is wrong in my opinion.

Patch author is supposed to test the code. Are you implying that
Qualcomm Bluetooth team cannot test the patch on any of Qualcomm
Bluetooth devices?

> 
> Only Zijun and reporter were involved during those early debugging days,
> Zijun shared changes for reporter to verify with reporter's machine,
> then Zijun posted his fixes after debugging and verification were done.
> 
>> That's important because Wren did not test particular scenarios, like
>> PREEMPT_RT or RB5 hardware, but Zijun is claiming problems are solved.
>> Maybe indeed solved, but if takes one month and still not answer which
>> kernel you are using, then I am sure: this was nowhere tested by Zijun
>> on the hardware and on the kernel the Qualcomm wants it to be.
>>
>>>
>>>>> commit e00fc2700a3f ("Bluetooth: btusb: Fix triggering coredump
>>>>> implementation for QCA") of bluetooth-next tree.
>>>>> commit b23d98d46d28 ("Bluetooth: btusb: Fix triggering coredump
>>>>> implementation for QCA") of linus mainline tree.
>>>>
>>>> ? Same commit with different hashes? No, it looks like you are working
>>>> on some downstream tree with cherry picks.
>>>>
>>> From Zijun's commit message, for the same commit, it seems
>>> bluetooth-next tree has different hashes as linus tree.
>>> not sure if this scenario is normal during some time window.
>>>> No, test it on mainline and answer finally, after *five* tries, which
>>>> kernel and which hardware did you use for testing this.
>>>>
>>>>
>>> it seems there are two issues mentioned with Zijun's commit message.
>>> regression issue A:  BT enable failure after warm reboot.
>>> issue B:  use-after-free issue, namely, kernel crash.
>>>
>>> @Krzysztof
>>> which issue to test based on your concerns with mainline tree?
>>
>> No one tested this on non-laptop platform. Wren did not, which is fine.
>> Qualcomm should, but since they avoid any talks about it for so long
>> (plus pushy comments during review, re-spinning v1 suggesting entire
>> discussion is gone), I do not trust their statements at all.
>>
> 
> For issue A:
> reporter's tests are enough in my opinion.
> Zijun ever said that "he known the root cause and this fix logic was
> introduced from the very beginning when he saw reporter's issue
> description" by below link:
> https://lore.kernel.org/lkml/1d0878e0-d138-4de2-86b8-326ab9ebde3f@quicinc.com/
> 
>> So really, did anything test it on any Qualcomm embedded platform?
>> Anyone tested the actual race visible with PREEMPT_RT?
>> For issue B, it was originally fixed and verified by you,
> it is obvious for the root cause and current fix solution after
> our discussion.
> 
> luzi also ever tried to ask you if you have a chance to verify issue B
> with your machine for this change.

I tried, but my setup is incomplete since ~half a year and will remain
probably for another short time, depending on ongoing work on power
sequencing. Therefore I cannot test whether anything improves or
deteriorates regarding this patch.

> 
>> Why Zijun cannot provide answer on which kernel was it tested? Why the
>> hardware cannot be mentioned?
>>
> i believe zijun never perform any tests for these two issues as
> explained above.

yeah, and that was worrying me.

Best regards,
Krzysztof


