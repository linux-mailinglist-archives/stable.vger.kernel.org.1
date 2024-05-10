Return-Path: <stable+bounces-43550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F758C2B43
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 22:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C5C285588
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 20:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4051346444;
	Fri, 10 May 2024 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="DsXMa0o6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F99219FF
	for <stable@vger.kernel.org>; Fri, 10 May 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715373937; cv=none; b=cIBf6gicgzL242gZT8sIyZaRt6UoTGxe4SEqt25+Z/qwUSCC4sQjzQPebi1Ycw9S36ZaiyKW1S0PLEebfPyyp9ABOzgEQc+jOf2bNEI9sjjYlhftupt7Lbs0RwFhkuUnkqC3c+2sH5pm+gx+yvrMa113easIaCmhKlMShf+VBYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715373937; c=relaxed/simple;
	bh=hHHlhEnUxgkufgYFDcK2EDRm95P5/juK/4q+v41mE/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+bwS9luCjLt+AbEPrnvHXi7NPo0BDoQVco1OUnNRw+u4OxHljBXLU3X/gPeErW8TCpKOkORgwB4tfWYawsJ4HDE8P44IZFolscrwdMQG8TNOkgsNXeOSYW+dgvG4Ah4WtAiG9rqPCj3+kI1Bp7SJYek3uTjCaUKVIRdfwgVOhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=DsXMa0o6; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2b27c660174so1816679a91.1
        for <stable@vger.kernel.org>; Fri, 10 May 2024 13:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1715373934; x=1715978734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0g4tkuPF3Ed6Xi1Raycy2lYbRqK16cTamVI92NbDtUU=;
        b=DsXMa0o6XyBuEYUS6TuonSPrDvCzNqEhAUAubDP/ywlA6GEcBWqBpd4bIUDlmqEcap
         u1cMbz3RcX5VP3PP9zYfAUVui8DRDEovjFHgxTOyACpg+rYKKOSKp/24uDFDC5fVHEJq
         2vTySWZq5MuduyZK+ziPalXVvkga87MaMXaEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715373934; x=1715978734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0g4tkuPF3Ed6Xi1Raycy2lYbRqK16cTamVI92NbDtUU=;
        b=XiGYEBpoax9fHzwYSgLV29UeCxdoDMzv53wkA0+SlM/t/uLiUdXZhKkGdz3A0t1EVy
         ejFrPaHb7TXqmZmKG/tyaNKSMUK6I/7AoBMsWs4Oy0tnxwGbpHj8wKRNWkX/X8yOI639
         o076g5WGf5CTQxpt4mMsrP7F6boPGW5xDEDUJkEAH2OvMul/pUnGZ8Xs89CSrNkW2KYe
         ZF/bE/vhPa3ysFg8694bLjvr7KTYtsijD0PUuyGI9Dohn9NfojCEmD7XiQOiTJvWJ3PR
         iLwWl0HvTlUtjqj+A2CvO8VAOUslt6rur41TBK8/xfiYlnM7VDUZAv80ItXhol89xevV
         otOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyxdIpZUhtUJ35sEl0moImH6m++GQr4iTV8kbsZGv0OM9KSUvndqo0PFlDDcMv0nbPOcr/DE8fukIXNI+N4qfLredV/sn6
X-Gm-Message-State: AOJu0YzOePlaOObVwCMgzpQALdSycF6LUGLnM9wQd85GcsG62EN0PHWS
	SqVQsQjilQ9cUO69liKbAnUmzSVVCrBVafO55Wam9MatIbahNCXN4r/x8skxnQ==
X-Google-Smtp-Source: AGHT+IHTnw0bup9QN7jcfwSKVbfTLjSAxPnKUMraFJvk8L0utTPtHL9hwKXN3P9mQsYAwHVoixz03w==
X-Received: by 2002:a17:90b:1c08:b0:2b2:cdf9:1641 with SMTP id 98e67ed59e1d1-2b6cc1437camr3909761a91.8.1715373934218;
        Fri, 10 May 2024 13:45:34 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62886b608sm5523725a91.27.2024.05.10.13.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 13:45:33 -0700 (PDT)
Message-ID: <5b9e0b36-4d6f-49d2-a810-dc59f8312e03@penguintechs.org>
Date: Fri, 10 May 2024 13:45:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: qca: Fix BT enable failure again for
 QCA6390 after warm reboot
Content-Language: en-US
To: Lk Sii <lk_sii@163.com>, quic_zijuhu <quic_zijuhu@quicinc.com>,
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
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <d553edef-c1a4-4d52-a892-715549d31ebe@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/7/24 6:48 AM, Lk Sii wrote:
> On 2024/5/4 05:51, quic_zijuhu wrote:
>> On 5/4/2024 5:25 AM, Luiz Augusto von Dentz wrote:
>>> Hi,
>>>
>>> On Fri, May 3, 2024 at 4:18 PM quic_zijuhu <quic_zijuhu@quicinc.com> wrote:
>>>>
>>>> On 5/4/2024 3:22 AM, Luiz Augusto von Dentz wrote:
>>>>> Hi Zijun,
>>>>>
>>>>> On Thu, May 2, 2024 at 10:06 AM Zijun Hu <quic_zijuhu@quicinc.com> wrote:
>>>>>>
>>>>>> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
>>>>>> serdev") will cause below regression issue:
>>>>>>
>>>>>> BT can't be enabled after below steps:
>>>>>> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
>>>>>> if property enable-gpios is not configured within DT|ACPI for QCA6390.
>>>>>>
>>>>>> The commit is to fix a use-after-free issue within qca_serdev_shutdown()
>>>>>> during reboot, but also introduces this regression issue regarding above
>>>>>> steps since the VSC is not sent to reset controller during warm reboot.
>>>>>>
>>>>>> Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
>>>>>> once BT was ever enabled, and the use-after-free issue is also be fixed
>>>>>> by this change since serdev is still opened when send to serdev.
>>>>>>
>>>>>> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
>>>>>> ---
>>>>>>   drivers/bluetooth/hci_qca.c | 5 ++---
>>>>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>>>>> index 0c9c9ee56592..8e35c9091486 100644
>>>>>> --- a/drivers/bluetooth/hci_qca.c
>>>>>> +++ b/drivers/bluetooth/hci_qca.c
>>>>>> @@ -2450,13 +2450,12 @@ static void qca_serdev_shutdown(struct device *dev)
>>>>>>          struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
>>>>>>          struct hci_uart *hu = &qcadev->serdev_hu;
>>>>>>          struct hci_dev *hdev = hu->hdev;
>>>>>> -       struct qca_data *qca = hu->priv;
>>>>>>          const u8 ibs_wake_cmd[] = { 0xFD };
>>>>>>          const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
>>>>>>
>>>>>>          if (qcadev->btsoc_type == QCA_QCA6390) {
>>>>>> -               if (test_bit(QCA_BT_OFF, &qca->flags) ||
>>>>>> -                   !test_bit(HCI_RUNNING, &hdev->flags))
>>>>>
>>>>> This probably deserves a comment on why you end up with
>>>>> HCI_QUIRK_NON_PERSISTENT_SETUP and HCI_SETUP flags here, also why you
>>>>> are removing the flags above since that was introduce to prevent
>>>>> use-after-free this sort of revert it so I do wonder how serdev can
>>>>> still be open if you haven't tested for QCA_BT_OFF for example?
>>>>>
>>>> okay, let me give comments at next version.
>>>> this design logic is shown below. you maybe review it.
>>>>
>>>> if HCI_QUIRK_NON_PERSISTENT_SETUP is set, it means that hdev->setup()
>>>> is able to be invoked by every open() to initializate SoC without any
>>>> help. so we don't need to send the VSC to reset SoC into initial and
>>>> clean state for the next hdev->setup() call success.
>>>>
>>>> otherwise, namely, HCI_QUIRK_NON_PERSISTENT_SETUP is not set.
>>>>
>>>> if HCI_SETUP is set, it means hdev->setup() was never be invoked, so the
>>>> SOC is already in the initial and clean state, so we also don't need to
>>>> send the VSC to reset SOC.
>>>>
>>>> otherwise, we need to send the VSC to reset Soc into a initial and clean
>>>> state for hdev->setup() call success after "warm reboot -> enable BT"
>>>>
>>>> for the case commit message cares about, the only factor which decide to
>>>> send the VSC is that SoC is a initial and clean state or not after warm
>>>> reboot, any other factors are irrelevant to this decision.
>>>>
>>>> why the serdev is still open after go through
>>>> (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)
>>>> || hci_dev_test_flag(hdev, HCI_SETUP) checking is that
>>>> serdev is not closed by hci_uart_close().
>>>
>>> Sounds like a logical jump to me, in fact hci_uart_close doesn't
>>> really change any of those flags, beside these flags are not really
>>> meant to tell the driver if serdev_device_close has been called or not
>>> which seems to be the intention with HCI_UART_PROTO_READY so how about
>>> we use that instead?
>>>
>> sorry for that i maybe not give good explanation, let me explain again.
>> hci_uart_close() is the only point which maybe close serdev before
>> qca_serdev_shutdown() is called, but for our case that
>> HCI_QUIRK_NON_PERSISTENT_SETUP is NOT set, hci_uart_close() will not
>> close serdev for our case, so serdev must be open state before sending
>> the VSC. so should not need other checking.
>>
> hello, i have paid attention to your discussion for a long time, i would
> like to join this discussion now.
> 
> The serdev is still open before sending the VSC for this patch.
> 
> are you agree with above Zijun's point?

I will say that this part of the discussion seems to be addressing KK's 
concerns.

@KK, is this accurate?

@Zijun, this description along with the info about the baud rate issues 
should probably be part of the commit message. In these last two 
messages, you have been much clearer about why this logic is needed and 
correct. I wish you'd provided this description from the beginning when 
KK asked for more information about the logic change.

>>> Another thing that is troubling me is that having traffic on shutdown
>>> is not common, specially if you are going to reboot, etc, and even if
>>> it doesn't get power cycle why don't you reset on probe rather than
>>> shutdown? That way we don't have to depend on what has been done in a
>>> previous boot, which can really become a problem in case of multi-OS
>>> where you have another system that may not be doing what you expect.
>> as you know, BT UART are working at 3M baudrate for normal usage.
>> we can't distinguish if SoC expects 3M or default 11.52K baudarate
>> during probe() after reboot. so we send the VSC within shutdown to make
>> sure SoC enter a initial state with 11.52 baudrate.
>>
>> for cold boot, SOC expects default 11.52K baudrate for probe().
>> for Enable BT -> warm boot, SOC expects 3M baudrate for probe().
>> we can't tell these two case within probe(). so need to send the VSC
>> within shutdown().
>>
> it seems the traffic within qca_serdev_shutdown() actually does software
> reset for BT SOC.
> 
>  From Zijun's points. the reasons why to do software reset within
> shutdown() instead of probe() maybe be shown below
> 1) it is impossible to do software reset within probe().
> 2) it seems it is easier to do it within shutdown() than probe.
> 
> Zijun's simple fix only change the condition and does NOT change the
> location to send the VSC, i think it maybe be other topic about location
> where(probe() or shutdown()) to do software reset.
> 
> are you agree with this point?

 From a practical standpoint, this change does seem to fix the warm boot 
issue on my laptop. I do not think that it would fix the issue of 
booting from an OS that puts the hardware into an unknown state.

> For concern about multi-OS, i would like to show my points.
> 
> the patch is for linux kernel, we maybe only need to care about linux
> OS. it maybe out-of-scope to make assumptions about other OSs vendor
> announced supported such as Windows OS we don't known much about.
> 
> are you agree with this point?

I would not fully agree with this point. However, I would agree 
completely with your proposal for moving forward (i.e. landing the change).

I would say that it is a problem if the kernel is not doing something to 
setup the hardware correctly in any case where it is technically 
possible. That is clearly a bug in the driver and Qualcomm should take 
responsibility for fixing this poor design. Luiz is totally right here.

Having said that, I don't see that bug as a blocker for a logic fix that 
creates an obvious (in my mind) UX improvement.

Here's my view of the situation. Right now, I experience a bug on every 
single warm boot or module reload).

After Zijun's improvement commit, I might experience this problem iif 
the right set of rare circumstances occurs (i.e. whenever I warm boot 
from an OS that puts the hardware in an unknown state, like the current 
mainline kernel to a kernel with the improvement).

In the world where the design problem of the init/shutdown sequences are 
fixed AND this logic change is applied, I might never see this problem 
again.

These seem like two different problems in my head. They don't seem 
directly logically related, and the blast radii of the problems are very 
different.

Here's the facts as I see them:
1. Logic improvement problem and init/shutdown sequence problem are 2 
orthogonal problems
2. Logic improvement greatly users' chances of running into the bad UX 
of the current code.
3. Init/shutdown isn't a trivial extension from the logic improvement.
4. Logic improvement has a pretty low cost to apply.
5. Init/shutdown sequence fix seems to be more fundamental and more 
intrusive.

All of these together indicate to me that the logic improvement should 
be landed. The init/shutdown issue should also be fixed, but a fix for 
that issue should not block the logic improvement.

My basic reasoning for this is that a visible UX fix should not e 
blocked for a change like the init/shutdown logic fix when the logic fix 
will help users.

However, Qualcomm does need to feel some pressure to fix their driver 
code. I would like to think that user's will not be held hostage for 
putting pressure on a vendor in this case as the balance seems very 
intrusive for users. It certainly feels intrusive as a user to have to 
be very careful about how I reboot my laptop.

>>>> see hci_uart_close() within drivers/bluetooth/hci_serdev.c
>>>> static int hci_uart_close(struct hci_dev *hdev)
>>>> {
>>>> ......
>>>>          /* When QUIRK HCI_QUIRK_NON_PERSISTENT_SETUP is set by driver,
>>>>           * BT SOC is completely powered OFF during BT OFF, holding port
>>>>           * open may drain the battery.
>>>>           */
>>>>          if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
>>>>                  clear_bit(HCI_UART_PROTO_READY, &hu->flags);
>>>>                  serdev_device_close(hu->serdev);
>>>>          }
>>>>
>>>>          return 0;
>>>> }
>>>>
>>>>>> +               if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks) ||
>>>>>> +                   hci_dev_test_flag(hdev, HCI_SETUP))
>>>>>>                          return;
>>>>>>
>>>>>>                  serdev_device_write_flush(serdev);
>>>>>> --
>>>>>> 2.7.4
>>>>>>
>>>>>
>>>>>
>>>>
>>>
>>>
>>
>>
>>
> 

-- 
You're more amazing than you think!

