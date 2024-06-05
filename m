Return-Path: <stable+bounces-47966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 128548FC16B
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 03:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804DC1F22AFB
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 01:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961B75381E;
	Wed,  5 Jun 2024 01:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Hxkyx8sL"
X-Original-To: stable@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7D21EA90;
	Wed,  5 Jun 2024 01:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717552228; cv=none; b=QmhVcWrt/tCkQGTOll7Y2GIfrswtCb6FGpdHfkQYBcUeBBpRntdCNOgxNL5kmgpEmPjqMtAHBLGM01UeHB5A+R+zPZpas/ezkhh2bs5tVflSRvY3MSLHGWhIylRYrpWz+y7Tv5/eWEFYvGQ2Yhzu3GItPd72lUpoKxjcpf30Cnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717552228; c=relaxed/simple;
	bh=wiYlHVeG4AaZZJLXAG6ZRjDlQz1eZ6PuZbqVvypnGE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JE6l4p33GQUgel+T0d5scQ1saiKXY7O5Znqj7FFZF3bnj/s+eF2VzTHgJvJOjfhI4z88+96e8XpJQaFQjScYXKHak/Qa2umLGTJpC0Gxe4bQcOziagb0hGmvEUC58yDbdQCDcRzQfje2s8Dw+qT8/Ihc9hOYSQxvBCDSjQRbcAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Hxkyx8sL; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=WW1ZNac0TFlG7g1kL0NU0w4KXCa2jpQ7zO7pcZhQA4A=;
	b=Hxkyx8sLiJ0I8H4qYtQtVCgkjTga566eY0InrKyplNDhH8xUc0TxOdMFST+f/l
	SZk9nY0RmeoX0HNkMNqcYrY9/XcuOk2DUImYYW0WMMVXWnqJHuQzoJEUZXdnfTGq
	5AsGy2YaT+Uprq2pCruDFCHE3CjZv55dAlVJqLhGkGBI8=
Received: from [192.168.1.25] (unknown [183.195.6.89])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wD3X40sxF9mnxd5HA--.11617S2;
	Wed, 05 Jun 2024 09:49:33 +0800 (CST)
Message-ID: <0618805b-2f7a-473d-b9fb-aea39a1ef659@163.com>
Date: Wed, 5 Jun 2024 09:49:32 +0800
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
Content-Language: en-US
From: Lk Sii <lk_sii@163.com>
In-Reply-To: <5df56d58-309a-4ff1-9a41-818a3f114bbb@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3X40sxF9mnxd5HA--.11617S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Jw1rXw45WF18Kr1DJw4rAFb_yoW7Zr45pF
	WUGF1DtF4Utr1Fkr10yw1IgFyYvwnIkF18Wr1DGrW5Ja98ZF95ArWxKr45uF98urZ7Ww1j
	va1DX3sF9r90kaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jxl1kUUUUU=
X-CM-SenderInfo: 5onb2xrl6rljoofrz/1tbiExH0NWXAlduPwAAAsn



On 2024/6/4 23:18, Krzysztof Kozlowski wrote:
> On 04/06/2024 16:25, Lk Sii wrote:
>>
>>
>> On 2024/5/22 00:02, Krzysztof Kozlowski wrote:
>>> On 16/05/2024 15:31, Zijun Hu wrote:
>>>> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
>>>> serdev") will cause below regression issue:
>>>>
>>>> BT can't be enabled after below steps:
>>>> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
>>>> if property enable-gpios is not configured within DT|ACPI for QCA6390.
>>>>
>>>> The commit is to fix a use-after-free issue within qca_serdev_shutdown()
>>>> by adding condition to avoid the serdev is flushed or wrote after closed
>>>> but also introduces this regression issue regarding above steps since the
>>>> VSC is not sent to reset controller during warm reboot.
>>>>
>>>> Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
>>>> once BT was ever enabled, and the use-after-free issue is also fixed by
>>>> this change since the serdev is still opened before it is flushed or wrote.
>>>>
>>>> Verified by the reported machine Dell XPS 13 9310 laptop over below two
>>>> kernel commits:
>>>
>>> I don't understand how does it solve my question. I asked you: on which
>>> hardware did you, not the reporter, test?
>>> It seems Zijun did NOT perform any tests obviously.
>> All these tests were performed by reporter Wren with her machine
>> "Dell XPS 13 9310 laptop".
> 
> Wren != Zijun.
> 
>>
>> From previous discussion, it seems she have tested this change
>> several times with positive results over different trees with her
>> machine. i noticed she given you reply for your questions within
>> below v1 discussion link as following:
>>
>> Here are v1 discussion link.
>> https://lore.kernel.org/linux-bluetooth/d553edef-c1a4-4d52-a892-715549d31ebe@163.com/T/#m7371df555fd58ba215d0da63055134126a43c460
>>
>> Here are Krzysztof's questions.
>> "I asked already *two times*:
>> 1. On which kernel did you test it?
>> 2. On which hardware did you test it?"
>>
>> Here are Wren's reply for Krzysztof's questions
>> "I thought I had already chimed in with this information. I am using a
>> Dell XPS 13 9310. It's the only hardware I have access to. I can say
>> that the fix seems to work as advertised in that it fixes the warm boot
>> issue I have been experiencing."
> 
> I asked Zijun, not Wren. I believe all this is tested or done by
> Qualcomm on some other kernel, so that's my question.
>
Zijun is the only guy from Qualcomm who ever joined our discussion,
he ever said he belongs to Bluetooth team, so let us suppose the term
"Qualcomm" you mentioned above is Zijun.

from discussion history. in fact, ALL these tests were performed by
reporter Wren instead of Zijun, and there are also NOT Zijun's Tested-by
tag, so what you believe above is wrong in my opinion.

Only Zijun and reporter were involved during those early debugging days,
Zijun shared changes for reporter to verify with reporter's machine,
then Zijun posted his fixes after debugging and verification were done.

> That's important because Wren did not test particular scenarios, like
> PREEMPT_RT or RB5 hardware, but Zijun is claiming problems are solved.
> Maybe indeed solved, but if takes one month and still not answer which
> kernel you are using, then I am sure: this was nowhere tested by Zijun
> on the hardware and on the kernel the Qualcomm wants it to be.
> 
>>
>>>> commit e00fc2700a3f ("Bluetooth: btusb: Fix triggering coredump
>>>> implementation for QCA") of bluetooth-next tree.
>>>> commit b23d98d46d28 ("Bluetooth: btusb: Fix triggering coredump
>>>> implementation for QCA") of linus mainline tree.
>>>
>>> ? Same commit with different hashes? No, it looks like you are working
>>> on some downstream tree with cherry picks.
>>>
>> From Zijun's commit message, for the same commit, it seems
>> bluetooth-next tree has different hashes as linus tree.
>> not sure if this scenario is normal during some time window.
>>> No, test it on mainline and answer finally, after *five* tries, which
>>> kernel and which hardware did you use for testing this.
>>>
>>>
>> it seems there are two issues mentioned with Zijun's commit message.
>> regression issue A:  BT enable failure after warm reboot.
>> issue B:  use-after-free issue, namely, kernel crash.
>>
>> @Krzysztof
>> which issue to test based on your concerns with mainline tree?
> 
> No one tested this on non-laptop platform. Wren did not, which is fine.
> Qualcomm should, but since they avoid any talks about it for so long
> (plus pushy comments during review, re-spinning v1 suggesting entire
> discussion is gone), I do not trust their statements at all.
>

For issue A:
reporter's tests are enough in my opinion.
Zijun ever said that "he known the root cause and this fix logic was
introduced from the very beginning when he saw reporter's issue
description" by below link:
https://lore.kernel.org/lkml/1d0878e0-d138-4de2-86b8-326ab9ebde3f@quicinc.com/

> So really, did anything test it on any Qualcomm embedded platform?
> Anyone tested the actual race visible with PREEMPT_RT?
> For issue B, it was originally fixed and verified by you,
it is obvious for the root cause and current fix solution after
our discussion.

luzi also ever tried to ask you if you have a chance to verify issue B
with your machine for this change.

> Why Zijun cannot provide answer on which kernel was it tested? Why the
> hardware cannot be mentioned?
> 
i believe zijun never perform any tests for these two issues as
explained above.
> Best regards,
> Krzysztof


