Return-Path: <stable+bounces-47930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 034338FB53E
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 16:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C42CB239E1
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 14:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958C612CDB5;
	Tue,  4 Jun 2024 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pduH/RRB"
X-Original-To: stable@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BEE171C9;
	Tue,  4 Jun 2024 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511190; cv=none; b=t+C4zzPygpJWSry9OGV/keEARCgWBm/QBzr2wA2OkskIT5K2h0xF4bfTsEIuuemY1CJbiXQkJFSEP7StUJ4+LkcW8Vvp3POq8qeVe2WWx0S0r1swXDJdzkrJIYFNYyq/wBj7nraSBdq09qDgXl9QfOGZzJTEpQENlssLM7zH2K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511190; c=relaxed/simple;
	bh=axNTdX4yhhIOJ+QIsoHRh/n4DoRTRP01CZzSsF18SEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezRO/ci3u6NNJJ/9blF50sMIy6LpF+B18vQijxUwlk+JwCT7TpP2E7M1X1wGLRHx7baYyjLyXD8ecQwlSXQR1D5QMxbAIrTZeYMaqYRsjGRlaR6KZcsGPGrVRZp5spBjs4/AVT2mIXl26zXr6cw5fnxJRoQfk8kxCIPweR2AtYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pduH/RRB; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=RIygmrpjr/F3XNMpwMpVtcEcYFfz2BQ0PeKPZfeJkm4=;
	b=pduH/RRBlOBTjUyQq6DWQfKd9ZvbiWFMCRGYfMhP1MM9abdhv58uH5cn0PwFQf
	F4MEx+wZBD8T983Qc25ZZcNeayUmDVtwfnUg7YnCoMY6viOiUBgCi3JvvhY3/S3l
	DjZjN9KtutmztC8cVGXv1razjQnmQWMQpQIKZxpWD/xSc=
Received: from [192.168.1.26] (unknown [183.195.6.89])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wD3P0XHI19mOdXWBw--.39291S2;
	Tue, 04 Jun 2024 22:25:12 +0800 (CST)
Message-ID: <29333872-4ff2-4f4e-8166-4c847c7605c1@163.com>
Date: Tue, 4 Jun 2024 22:25:11 +0800
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
Content-Language: en-US
From: Lk Sii <lk_sii@163.com>
In-Reply-To: <7927abbe-3395-4a53-9eed-7b4204d57df5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3P0XHI19mOdXWBw--.39291S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFW3uFy7WrykCr1rAF4fXwb_yoW5CFy7pF
	W5KF1qyrWUtr18Ka17A34xKFy2vwnI9F1rWr1kG3y5J3y5ZF95WFWSgrW5Xa4DCryxuw1j
	van7X34qgrZ0kaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jxHUDUUUUU=
X-CM-SenderInfo: 5onb2xrl6rljoofrz/1tbiyQnzNWV4JejwvQAAsb



On 2024/5/22 00:02, Krzysztof Kozlowski wrote:
> On 16/05/2024 15:31, Zijun Hu wrote:
>> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
>> serdev") will cause below regression issue:
>>
>> BT can't be enabled after below steps:
>> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
>> if property enable-gpios is not configured within DT|ACPI for QCA6390.
>>
>> The commit is to fix a use-after-free issue within qca_serdev_shutdown()
>> by adding condition to avoid the serdev is flushed or wrote after closed
>> but also introduces this regression issue regarding above steps since the
>> VSC is not sent to reset controller during warm reboot.
>>
>> Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
>> once BT was ever enabled, and the use-after-free issue is also fixed by
>> this change since the serdev is still opened before it is flushed or wrote.
>>
>> Verified by the reported machine Dell XPS 13 9310 laptop over below two
>> kernel commits:
> 
> I don't understand how does it solve my question. I asked you: on which
> hardware did you, not the reporter, test?
>It seems Zijun did NOT perform any tests obviously.
All these tests were performed by reporter Wren with her machine
"Dell XPS 13 9310 laptop".

From previous discussion, it seems she have tested this change
several times with positive results over different trees with her
machine. i noticed she given you reply for your questions within
below v1 discussion link as following:

Here are v1 discussion link.
https://lore.kernel.org/linux-bluetooth/d553edef-c1a4-4d52-a892-715549d31ebe@163.com/T/#m7371df555fd58ba215d0da63055134126a43c460

Here are Krzysztof's questions.
"I asked already *two times*:
1. On which kernel did you test it?
2. On which hardware did you test it?"

Here are Wren's reply for Krzysztof's questions
"I thought I had already chimed in with this information. I am using a
Dell XPS 13 9310. It's the only hardware I have access to. I can say
that the fix seems to work as advertised in that it fixes the warm boot
issue I have been experiencing."

>> commit e00fc2700a3f ("Bluetooth: btusb: Fix triggering coredump
>> implementation for QCA") of bluetooth-next tree.
>> commit b23d98d46d28 ("Bluetooth: btusb: Fix triggering coredump
>> implementation for QCA") of linus mainline tree.
> 
> ? Same commit with different hashes? No, it looks like you are working
> on some downstream tree with cherry picks.
> 
From Zijun's commit message, for the same commit, it seems
bluetooth-next tree has different hashes as linus tree.
not sure if this scenario is normal during some time window.
> No, test it on mainline and answer finally, after *five* tries, which
> kernel and which hardware did you use for testing this.
> 
> 
it seems there are two issues mentioned with Zijun's commit message.
regression issue A:  BT enable failure after warm reboot.
issue B:  use-after-free issue, namely, kernel crash.

@Krzysztof
which issue to test based on your concerns with mainline tree?
> 
> Best regards,
> Krzysztof
> 


