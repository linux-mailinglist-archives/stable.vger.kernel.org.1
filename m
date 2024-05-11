Return-Path: <stable+bounces-43555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3008C2F76
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 06:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4628C1F22726
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 04:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8949E38382;
	Sat, 11 May 2024 04:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GLtfYqpK"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4694621345;
	Sat, 11 May 2024 04:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715400667; cv=none; b=pe48gAE0eInMLqr3zbUG+MceO5IuqNF79JbtVXilWPj9xMe612Bu+KnbOUEoDlR7kHY4aCutIoHM5yR2wnphjj1DkcYASiwQAqFUP/azfg60Zrd3/hgGsv/8p3fBQttMy9D8Y4zdACDXDTcW3lkcG2+UIAZuidpRyRDraU+jOsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715400667; c=relaxed/simple;
	bh=0toZUhGF8FJX7UXdtVZTp+PiWoBQGdQKjqcT/9LHNbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTUvHVyC0QKmvg8hPAQIBqSj9dh+ddlMwHyCUP6TXYZRHZqVEqZJMGXn2N6vZ/OTI+aSySyagg9iYjgZmBjhyN0T/yOMIDeYsQJyy+QMHy94cRudgOGlVCYqb8+bBEzL4lIaWaJuBdIavnSJILQc1qKrfgGFWPZ5dlxNpQoAZeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GLtfYqpK; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=wW/THnZT9ev5Ooy1RcXrjVT3wCbr+5nAAFKRvIdwNLA=;
	b=GLtfYqpKNfk5O2xgA/nflpEVg05YLc/2xgp/p40p7JS7LSYq6xG/w/mnT+1aRd
	AEPZ3LQAaoj6Wd9VRapDkYLJ477tK2q8NbUE7VrTpQiFsX14F8QdauxVc21NuK27
	h0cLML0z0LQK8g4yk7A+6j5KpWjTvNNTPN8QzxN/LP4vw=
Received: from [192.168.1.14] (unknown [183.195.4.13])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wDHdouE7z5m7C1OEA--.49919S2;
	Sat, 11 May 2024 12:09:41 +0800 (CST)
Message-ID: <a80e0da7-be55-4cb0-92c9-51fa258788f0@163.com>
Date: Sat, 11 May 2024 12:09:40 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: qca: Fix BT enable failure again for
 QCA6390 after warm reboot
To: Wren Turkal <wt@penguintechs.org>, quic_zijuhu <quic_zijuhu@quicinc.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: luiz.von.dentz@intel.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <1714658761-15326-1-git-send-email-quic_zijuhu@quicinc.com>
 <CABBYNZJc=Pzt02f0L3KOSLqkJ+2SwO=OZibA=0S0T3vKPDwPyw@mail.gmail.com>
 <c5998fbd-bd63-4f7d-8f51-3dd081913449@quicinc.com>
 <CABBYNZJOVnBShpgbWEpFBcu_MnHW+TKLndLKnZkkB9C71EfJNA@mail.gmail.com>
 <b8cc1486-b627-4186-a53c-8331b84e2318@quicinc.com>
 <d553edef-c1a4-4d52-a892-715549d31ebe@163.com>
 <5b9e0b36-4d6f-49d2-a810-dc59f8312e03@penguintechs.org>
Content-Language: en-US
From: Lk Sii <lk_sii@163.com>
In-Reply-To: <5b9e0b36-4d6f-49d2-a810-dc59f8312e03@penguintechs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHdouE7z5m7C1OEA--.49919S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3Cr4UuF48XrWxtFWkZr1rXrb_yoW8JrW8Wo
	WfXw4xZa18Jr1UCF1UAa4DJFy3J3s8Aw1rJrW7tr4rAr1vq345Xw18Cw15XFW3JF4Fgr4U
	J34UArnxZry3tFs5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU3zBTUUUUU
X-CM-SenderInfo: 5onb2xrl6rljoofrz/1tbisgDbNWVODIWv8AABsg



On 2024/5/11 04:45, Wren Turkal wrote:
> On 5/7/24 6:48 AM, Lk Sii wrote:
>> On 2024/5/4 05:51, quic_zijuhu wrote:
>>> On 5/4/2024 5:25 AM, Luiz Augusto von Dentz wrote:
>>>> Hi,
>>>>
>>>> On Fri, May 3, 2024 at 4:18 PM quic_zijuhu <quic_zijuhu@quicinc.com>
>>>> wrote:
>>>>>
>>>>> On 5/4/2024 3:22 AM, Luiz Augusto von Dentz wrote:
>>>>>> Hi Zijun,
>>>>>>
>>>>>> On Thu, May 2, 2024 at 10:06 AM Zijun Hu <quic_zijuhu@quicinc.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on
>>>>>>> closed
>>>>>>> serdev") will cause below regression issue:
>>>>>>>
>>>>>>> BT can't be enabled after below steps:
>>>>>>> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable
>>>>>>> failure
>>>>>>> if property enable-gpios is not configured within DT|ACPI for
>>>>>>> QCA6390.
>>>>>>>
>>>>>>> The commit is to fix a use-after-free issue within
>>>>>>> qca_serdev_shutdown()
>>>>>>> during reboot, but also introduces this regression issue
>>>>>>> regarding above
>>>>>>> steps since the VSC is not sent to reset controller during warm
>>>>>>> reboot.
>>>>>>>
>>>>>>> Fixed by sending the VSC to reset controller within
>>>>>>> qca_serdev_shutdown()
>>>>>>> once BT was ever enabled, and the use-after-free issue is also be
>>>>>>> fixed
>>>>>>> by this change since serdev is still opened when send to serdev.
>>>>>>>
>>>>>>> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on
>>>>>>> closed serdev")
>>>>>>> Cc: stable@vger.kernel.org
>>>>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
>>>>>>> ---
>>>>>>>   drivers/bluetooth/hci_qca.c | 5 ++---
>>>>>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/bluetooth/hci_qca.c
>>>>>>> b/drivers/bluetooth/hci_qca.c
>>>>>>> index 0c9c9ee56592..8e35c9091486 100644
>>>>>>> --- a/drivers/bluetooth/hci_qca.c
>>>>>>> +++ b/drivers/bluetooth/hci_qca.c
>>>>>>> @@ -2450,13 +2450,12 @@ static void qca_serdev_shutdown(struct
>>>>>>> device *dev)
>>>>>>>          struct qca_serdev *qcadev =
>>>>>>> serdev_device_get_drvdata(serdev);
>>>>>>>          struct hci_uart *hu = &qcadev->serdev_hu;
>>>>>>>          struct hci_dev *hdev = hu->hdev;
>>>>>>> -       struct qca_data *qca = hu->priv;
>>>>>>>          const u8 ibs_wake_cmd[] = { 0xFD };
>>>>>>>          const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01,
>>>>>>> 0x05 };
>>>>>>>
>>>>>>>          if (qcadev->btsoc_type == QCA_QCA6390) {
>>>>>>> -               if (test_bit(QCA_BT_OFF, &qca->flags) ||
>>>>>>> -                   !test_bit(HCI_RUNNING, &hdev->flags))
>>>>>>
>>>>>> This probably deserves a comment on why you end up with
>>>>>> HCI_QUIRK_NON_PERSISTENT_SETUP and HCI_SETUP flags here, also why you
>>>>>> are removing the flags above since that was introduce to prevent
>>>>>> use-after-free this sort of revert it so I do wonder how serdev can
>>>>>> still be open if you haven't tested for QCA_BT_OFF for example?
>>>>>>
>>>>> okay, let me give comments at next version.
>>>>> this design logic is shown below. you maybe review it.
>>>>>
>>>>> if HCI_QUIRK_NON_PERSISTENT_SETUP is set, it means that hdev->setup()
>>>>> is able to be invoked by every open() to initializate SoC without any
>>>>> help. so we don't need to send the VSC to reset SoC into initial and
>>>>> clean state for the next hdev->setup() call success.
>>>>>
>>>>> otherwise, namely, HCI_QUIRK_NON_PERSISTENT_SETUP is not set.
>>>>>
>>>>> if HCI_SETUP is set, it means hdev->setup() was never be invoked,
>>>>> so the
>>>>> SOC is already in the initial and clean state, so we also don't
>>>>> need to
>>>>> send the VSC to reset SOC.
>>>>>
>>>>> otherwise, we need to send the VSC to reset Soc into a initial and
>>>>> clean
>>>>> state for hdev->setup() call success after "warm reboot -> enable BT"
>>>>>
>>>>> for the case commit message cares about, the only factor which
>>>>> decide to
>>>>> send the VSC is that SoC is a initial and clean state or not after
>>>>> warm
>>>>> reboot, any other factors are irrelevant to this decision.
>>>>>
>>>>> why the serdev is still open after go through
>>>>> (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)
>>>>> || hci_dev_test_flag(hdev, HCI_SETUP) checking is that
>>>>> serdev is not closed by hci_uart_close().
>>>>
>>>> Sounds like a logical jump to me, in fact hci_uart_close doesn't
>>>> really change any of those flags, beside these flags are not really
>>>> meant to tell the driver if serdev_device_close has been called or not
>>>> which seems to be the intention with HCI_UART_PROTO_READY so how about
>>>> we use that instead?
>>>>
>>> sorry for that i maybe not give good explanation, let me explain again.
>>> hci_uart_close() is the only point which maybe close serdev before
>>> qca_serdev_shutdown() is called, but for our case that
>>> HCI_QUIRK_NON_PERSISTENT_SETUP is NOT set, hci_uart_close() will not
>>> close serdev for our case, so serdev must be open state before sending
>>> the VSC. so should not need other checking.
>>>
>> hello, i have paid attention to your discussion for a long time, i would
>> like to join this discussion now.
>>
>> The serdev is still open before sending the VSC for this patch.
>>
>> are you agree with above Zijun's point?
> 
> I will say that this part of the discussion seems to be addressing KK's
> concerns.
> 
> @KK, is this accurate?
> 
> @Zijun, this description along with the info about the baud rate issues
> should probably be part of the commit message. In these last two
> messages, you have been much clearer about why this logic is needed and
> correct. I wish you'd provided this description from the beginning when
> KK asked for more information about the logic change.
> 
>>>> Another thing that is troubling me is that having traffic on shutdown
>>>> is not common, specially if you are going to reboot, etc, and even if
>>>> it doesn't get power cycle why don't you reset on probe rather than
>>>> shutdown? That way we don't have to depend on what has been done in a
>>>> previous boot, which can really become a problem in case of multi-OS
>>>> where you have another system that may not be doing what you expect.
>>> as you know, BT UART are working at 3M baudrate for normal usage.
>>> we can't distinguish if SoC expects 3M or default 11.52K baudarate
>>> during probe() after reboot. so we send the VSC within shutdown to make
>>> sure SoC enter a initial state with 11.52 baudrate.
>>>
>>> for cold boot, SOC expects default 11.52K baudrate for probe().
>>> for Enable BT -> warm boot, SOC expects 3M baudrate for probe().
>>> we can't tell these two case within probe(). so need to send the VSC
>>> within shutdown().
>>>
>> it seems the traffic within qca_serdev_shutdown() actually does software
>> reset for BT SOC.
>>
>>  From Zijun's points. the reasons why to do software reset within
>> shutdown() instead of probe() maybe be shown below
>> 1) it is impossible to do software reset within probe().
>> 2) it seems it is easier to do it within shutdown() than probe.
>>
>> Zijun's simple fix only change the condition and does NOT change the
>> location to send the VSC, i think it maybe be other topic about location
>> where(probe() or shutdown()) to do software reset.
>>
>> are you agree with this point?
> 
> From a practical standpoint, this change does seem to fix the warm boot
> issue on my laptop. I do not think that it would fix the issue of
> booting from an OS that puts the hardware into an unknown state.
>
we may not need to focus on below multi-OS issue Luiz assume

Other OS such as Windows -> warm boot -> boot linux OS -> enable BT failure.

firstly, we don't know and can't confirm that other OS don't the similar
jobs as linux kernel do, so can't confirm if the assumed issue is a real
and valid issue.

secondary, if other OS is supported as announced by vendor Qualcomm,
their BT driver for other OS maybe have contained solution for Multi-OS
relevant concerns.

>> For concern about multi-OS, i would like to show my points.
>>
>> the patch is for linux kernel, we maybe only need to care about linux
>> OS. it maybe out-of-scope to make assumptions about other OSs vendor
>> announced supported such as Windows OS we don't known much about.
>>
>> are you agree with this point?
> 
> I would not fully agree with this point. However, I would agree
> completely with your proposal for moving forward (i.e. landing the change).
> 
i agree with above Wren's point about moving forward.

> I would say that it is a problem if the kernel is not doing something to
> setup the hardware correctly in any case where it is technically
> possible. That is clearly a bug in the driver and Qualcomm should take
> responsibility for fixing this poor design. Luiz is totally right here.
>i don't agree with your above point that it is a bug and driver's poor
design, i don't actually understand how|who to conclude that present
design is clearly a bug and is poor design.

it seems this design(software reset within shutdown()) is dedicated
for the scenario that HOST doesn't have H/W resource to reset SOC if you
noticed below link
https://patchwork.kernel.org/project/bluetooth/patch/1713947712-4307-1-git-send-email-quic_zijuhu@quicinc.com/

For the scenario, perhaps, vendor Qualcomm have had more considerations
than you can image and finally selected this doable design.

as i commented previously. this patch doesn't touch software reset
location designed. so it maybe be out-of-scope to discuss why probe()
does not do the job.

> Having said that, I don't see that bug as a blocker for a logic fix that
> creates an obvious (in my mind) UX improvement.
> 
> Here's my view of the situation. Right now, I experience a bug on every
> single warm boot or module reload).
> 
> After Zijun's improvement commit, I might experience this problem iif
> the right set of rare circumstances occurs (i.e. whenever I warm boot
> from an OS that puts the hardware in an unknown state, like the current
> mainline kernel to a kernel with the improvement).
> > In the world where the design problem of the init/shutdown sequences are
> fixed AND this logic change is applied, I might never see this problem
> again.
> 
> These seem like two different problems in my head. They don't seem
> directly logically related, and the blast radii of the problems are very
> different.
> 
> Here's the facts as I see them:
> 1. Logic improvement problem and init/shutdown sequence problem are 2
> orthogonal problems
> 2. Logic improvement greatly users' chances of running into the bad UX
> of the current code.
> 3. Init/shutdown isn't a trivial extension from the logic improvement.
> 4. Logic improvement has a pretty low cost to apply.
> 5. Init/shutdown sequence fix seems to be more fundamental and more
> intrusive.
> 
> All of these together indicate to me that the logic improvement should
> be landed. The init/shutdown issue should also be fixed, but a fix for
> that issue should not block the logic improvement.
> 
> My basic reasoning for this is that a visible UX fix should not e
> blocked for a change like the init/shutdown logic fix when the logic fix
> will help users.
> 
> However, Qualcomm does need to feel some pressure to fix their driver
> code. I would like to think that user's will not be held hostage for
> putting pressure on a vendor in this case as the balance seems very
> intrusive for users. It certainly feels intrusive as a user to have to
> be very careful about how I reboot my laptop.
> 
>>>>> see hci_uart_close() within drivers/bluetooth/hci_serdev.c
>>>>> static int hci_uart_close(struct hci_dev *hdev)
>>>>> {
>>>>> ......
>>>>>          /* When QUIRK HCI_QUIRK_NON_PERSISTENT_SETUP is set by
>>>>> driver,
>>>>>           * BT SOC is completely powered OFF during BT OFF, holding
>>>>> port
>>>>>           * open may drain the battery.
>>>>>           */
>>>>>          if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP,
>>>>> &hdev->quirks)) {
>>>>>                  clear_bit(HCI_UART_PROTO_READY, &hu->flags);
>>>>>                  serdev_device_close(hu->serdev);
>>>>>          }
>>>>>
>>>>>          return 0;
>>>>> }
>>>>>
>>>>>>> +               if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP,
>>>>>>> &hdev->quirks) ||
>>>>>>> +                   hci_dev_test_flag(hdev, HCI_SETUP))
>>>>>>>                          return;
>>>>>>>
>>>>>>>                  serdev_device_write_flush(serdev);
>>>>>>> -- 
>>>>>>> 2.7.4
>>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>
>>>>
>>>
>>>
>>>
>>
> 


