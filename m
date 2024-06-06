Return-Path: <stable+bounces-48293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22568FE6E2
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BEC4281EB2
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 12:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B0E195B15;
	Thu,  6 Jun 2024 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NkFjAdcN"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38548194AE0;
	Thu,  6 Jun 2024 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717678573; cv=none; b=b0uCKawWHj0VDa2+hLa5DK7k2rFZdGH7PHWYRnONyrs3pJ1Sb16NyLUtjYHe62VtF8OToPM58bL2Myiac37V1Uvk+vy0Obsy3KsXRS8qZxzO9ip1oQWmzXSi5ays7gK3oQQ/ibvTKE0dW16zDMMVTZNglKZop/tkx46vZOXxHqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717678573; c=relaxed/simple;
	bh=cEVrspVFLlAdphidp+ueWsk+T+6siYuuBszC9SCLjPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roYtEbAtGlSItyuV/G+sJgPIbqyUqLLXGc0h+HJdw+LSgFZWnI8yv7RzBP+I+XWvSIId78WNypSH03E0MUityzo098dmyMDXszz+ejb8xokUH8tBVgcJuXAoKV/Rn6iZywSmhonDOdPczDV28p9OCqRWhxvMeockiVVFgUZyOLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NkFjAdcN; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=7vKOefyFBAgQHTWauKj2f/7nx/nSq5Db9+JQLNepCxI=;
	b=NkFjAdcNw7otoFP2mDb40z6wy0AemNkZMbUqNiEAWPVCtw7rlEIHm6PcYvxV45
	2YbCDdobn7pSYabxQC5utxRche3++3MgHfAdCsy0bYGpGb9YJc4EKnuCfJdghd27
	0xybfgQNVlwEfYcgCR4y4XjcCwkj+UnG98B+0HpRUYdTE=
Received: from [192.168.1.25] (unknown [183.195.6.89])
	by gzga-smtp-mta-g2-4 (Coremail) with SMTP id _____wDXHyCPsWFm_XfQCA--.26956S2;
	Thu, 06 Jun 2024 20:54:39 +0800 (CST)
Message-ID: <fc035bd7-c9e3-458f-b419-f4ac50322d02@163.com>
Date: Thu, 6 Jun 2024 20:54:39 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: Fix BT enable failure again for
 QCA6390 after warm reboot
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Zijun Hu <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, wt@penguintechs.org,
 regressions@lists.linux.dev, pmenzel@molgen.mpg.de, stable@vger.kernel.org
References: <1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com>
 <7927abbe-3395-4a53-9eed-7b4204d57df5@linaro.org>
 <29333872-4ff2-4f4e-8166-4c847c7605c1@163.com>
 <5df56d58-309a-4ff1-9a41-818a3f114bbb@linaro.org>
 <0618805b-2f7a-473d-b9fb-aea39a1ef659@163.com>
 <3d27add1-782c-4c19-9d84-d0074113c7a2@linaro.org>
Content-Language: en-US
From: Lk Sii <lk_sii@163.com>
In-Reply-To: <3d27add1-782c-4c19-9d84-d0074113c7a2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDXHyCPsWFm_XfQCA--.26956S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jw1rXw4rZr13WF1rWF1fXrb_yoWxuw1kpF
	WUGF1Dtr4UJr1Fyr1Iyr1xKFyYywnrtF18Wrn8GrWUJa90vF1rJr4Iqr45uF98urWxWF1j
	va1DX3sF9ryDCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYiiDUUUUU=
X-CM-SenderInfo: 5onb2xrl6rljoofrz/1tbishL1NWVODiNtPwAAs0



On 2024/6/5 15:14, Krzysztof Kozlowski wrote:
> On 05/06/2024 03:49, Lk Sii wrote:
>>
>>
>> On 2024/6/4 23:18, Krzysztof Kozlowski wrote:
>>> On 04/06/2024 16:25, Lk Sii wrote:
>>>>
>>>>
>>>> On 2024/5/22 00:02, Krzysztof Kozlowski wrote:
>>>>> On 16/05/2024 15:31, Zijun Hu wrote:
>>>>>> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
>>>>>> serdev") will cause below regression issue:
>>>>>>
>>>>>> BT can't be enabled after below steps:
>>>>>> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
>>>>>> if property enable-gpios is not configured within DT|ACPI for QCA6390.
>>>>>>
>>>>>> The commit is to fix a use-after-free issue within qca_serdev_shutdown()
>>>>>> by adding condition to avoid the serdev is flushed or wrote after closed
>>>>>> but also introduces this regression issue regarding above steps since the
>>>>>> VSC is not sent to reset controller during warm reboot.
>>>>>>
>>>>>> Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
>>>>>> once BT was ever enabled, and the use-after-free issue is also fixed by
>>>>>> this change since the serdev is still opened before it is flushed or wrote.
>>>>>>
>>>>>> Verified by the reported machine Dell XPS 13 9310 laptop over below two
>>>>>> kernel commits:
>>>>>
>>>>> I don't understand how does it solve my question. I asked you: on which
>>>>> hardware did you, not the reporter, test?
>>>>> It seems Zijun did NOT perform any tests obviously.
>>>> All these tests were performed by reporter Wren with her machine
>>>> "Dell XPS 13 9310 laptop".
>>>
>>> Wren != Zijun.
>>>
>>>>
>>>> From previous discussion, it seems she have tested this change
>>>> several times with positive results over different trees with her
>>>> machine. i noticed she given you reply for your questions within
>>>> below v1 discussion link as following:
>>>>
>>>> Here are v1 discussion link.
>>>> https://lore.kernel.org/linux-bluetooth/d553edef-c1a4-4d52-a892-715549d31ebe@163.com/T/#m7371df555fd58ba215d0da63055134126a43c460
>>>>
>>>> Here are Krzysztof's questions.
>>>> "I asked already *two times*:
>>>> 1. On which kernel did you test it?
>>>> 2. On which hardware did you test it?"
>>>>
>>>> Here are Wren's reply for Krzysztof's questions
>>>> "I thought I had already chimed in with this information. I am using a
>>>> Dell XPS 13 9310. It's the only hardware I have access to. I can say
>>>> that the fix seems to work as advertised in that it fixes the warm boot
>>>> issue I have been experiencing."
>>>
>>> I asked Zijun, not Wren. I believe all this is tested or done by
>>> Qualcomm on some other kernel, so that's my question.
>>>
>> Zijun is the only guy from Qualcomm who ever joined our discussion,
>> he ever said he belongs to Bluetooth team, so let us suppose the term
>> "Qualcomm" you mentioned above is Zijun.
>>
>> from discussion history. in fact, ALL these tests were performed by
>> reporter Wren instead of Zijun, and there are also NOT Zijun's Tested-by
>> tag, so what you believe above is wrong in my opinion.
> 
> Patch author is supposed to test the code. Are you implying that
> Qualcomm Bluetooth team cannot test the patch on any of Qualcomm
> Bluetooth devices?
> 
i guess Zijun did not test the patch on himself based on below reasons:
1) the patch has been tested by reporter with report's machine.
2) perhaps, Zijun is confident about his patch based on his experience.
3) perhaps, it is difficult for Zijun to find a suitable machine to
perform tests, and test machines must have QCA6390 *embedded* and use
Bluez solution.

>>
>> Only Zijun and reporter were involved during those early debugging days,
>> Zijun shared changes for reporter to verify with reporter's machine,
>> then Zijun posted his fixes after debugging and verification were done.
>>
>>> That's important because Wren did not test particular scenarios, like
>>> PREEMPT_RT or RB5 hardware, but Zijun is claiming problems are solved.
>>> Maybe indeed solved, but if takes one month and still not answer which
>>> kernel you are using, then I am sure: this was nowhere tested by Zijun
>>> on the hardware and on the kernel the Qualcomm wants it to be.
>>>
>>>>
>>>>>> commit e00fc2700a3f ("Bluetooth: btusb: Fix triggering coredump
>>>>>> implementation for QCA") of bluetooth-next tree.
>>>>>> commit b23d98d46d28 ("Bluetooth: btusb: Fix triggering coredump
>>>>>> implementation for QCA") of linus mainline tree.
>>>>>
>>>>> ? Same commit with different hashes? No, it looks like you are working
>>>>> on some downstream tree with cherry picks.
>>>>>
>>>> From Zijun's commit message, for the same commit, it seems
>>>> bluetooth-next tree has different hashes as linus tree.
>>>> not sure if this scenario is normal during some time window.
>>>>> No, test it on mainline and answer finally, after *five* tries, which
>>>>> kernel and which hardware did you use for testing this.
>>>>>
>>>>>
>>>> it seems there are two issues mentioned with Zijun's commit message.
>>>> regression issue A:  BT enable failure after warm reboot.
>>>> issue B:  use-after-free issue, namely, kernel crash.
>>>>
>>>> @Krzysztof
>>>> which issue to test based on your concerns with mainline tree?
>>>
>>> No one tested this on non-laptop platform. Wren did not, which is fine.
>>> Qualcomm should, but since they avoid any talks about it for so long
>>> (plus pushy comments during review, re-spinning v1 suggesting entire
>>> discussion is gone), I do not trust their statements at all.
>>>
>>
>> For issue A:
>> reporter's tests are enough in my opinion.
>> Zijun ever said that "he known the root cause and this fix logic was
>> introduced from the very beginning when he saw reporter's issue
>> description" by below link:
>> https://lore.kernel.org/lkml/1d0878e0-d138-4de2-86b8-326ab9ebde3f@quicinc.com/
>>
>>> So really, did anything test it on any Qualcomm embedded platform?
>>> Anyone tested the actual race visible with PREEMPT_RT?
>>> For issue B, it was originally fixed and verified by you,
>> it is obvious for the root cause and current fix solution after
>> our discussion.
>>
>> luzi also ever tried to ask you if you have a chance to verify issue B
>> with your machine for this change.
> 
> I tried, but my setup is incomplete since ~half a year and will remain
> probably for another short time, depending on ongoing work on power
> sequencing. Therefore I cannot test whether anything improves or
> deteriorates regarding this patch.
> 
>>
>>> Why Zijun cannot provide answer on which kernel was it tested? Why the
>>> hardware cannot be mentioned?
>>>
>> i believe zijun never perform any tests for these two issues as
>> explained above.
> 
> yeah, and that was worrying me.
>
Only RB5 has QCA6390 *embedded* among DTS of mainline kernel, but we
can't have a RB5 to test.

Don't worry about due to below points:
1) Reporter have tested it with her machine
2) issue B and relevant fix is obvious after discussion.

> Best regards,
> Krzysztof


