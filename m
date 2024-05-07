Return-Path: <stable+bounces-43180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FDF8BE4A1
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 15:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9AB289D0B
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 13:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C0A15B128;
	Tue,  7 May 2024 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BctFR3G1"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C26D13CF9C;
	Tue,  7 May 2024 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089771; cv=none; b=iJiglrEcyyFWqfg1mSmXRJUJICLjvMh7PLBnXwqC1F0PgGVfWz2HoyLvYfJQuPgqPniv3paA6T85uvNkfPOAFACUkutjPcUOgpWJEr193lGsV6R6DAsSdThymEu0w9+vLHSic1n74wg83B+znkOJh4buvO2fSezth0IozYewEf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089771; c=relaxed/simple;
	bh=4/wITxIkMokFjGEwmrXcgMdiigbqU2NKbPB7zg3pOsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvioJiukw8GQUYkNhUp/BY7L9cyht7EK9+6G+U8Zlti6aenLvHztgwwdYUmd5xdlqIcf2b0MYoDx1v+21bETBT4E7Ov1GmGnShpHbXbWE6QOF56WzWkTAQkn3RzsOd9TWXsfsiUoFiyoZ/JU05LuVVupvaE+RXRzI6wcj4OB0XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BctFR3G1; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=y6lPLvzpQ4EVpjvLFGhHJpKRyBRIswtWXAZn3lu7Qgc=;
	b=BctFR3G1rSS6YU69VTT9xokbfcn4oj/Dk8rTwgiX9lyP4fqd4cV4dYiFABKYBB
	jigzvG9aENIEUiXFOrp90hcVev8Zr2VGINI7sJ8hEx/FoVGN0NwNlZNWuCTB+eM8
	+Pmi2UNPaUKjvpc4vseqss2Kaa5IR0A9K0Klr1BL8x5o0=
Received: from [192.168.1.20] (unknown [183.195.4.43])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDnr90vMTpmjMtKCg--.30278S2;
	Tue, 07 May 2024 21:48:33 +0800 (CST)
Message-ID: <d553edef-c1a4-4d52-a892-715549d31ebe@163.com>
Date: Tue, 7 May 2024 21:48:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: qca: Fix BT enable failure again for
 QCA6390 after warm reboot
To: quic_zijuhu <quic_zijuhu@quicinc.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: luiz.von.dentz@intel.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, wt@penguintechs.org,
 regressions@lists.linux.dev, stable@vger.kernel.org
References: <1714658761-15326-1-git-send-email-quic_zijuhu@quicinc.com>
 <CABBYNZJc=Pzt02f0L3KOSLqkJ+2SwO=OZibA=0S0T3vKPDwPyw@mail.gmail.com>
 <c5998fbd-bd63-4f7d-8f51-3dd081913449@quicinc.com>
 <CABBYNZJOVnBShpgbWEpFBcu_MnHW+TKLndLKnZkkB9C71EfJNA@mail.gmail.com>
 <b8cc1486-b627-4186-a53c-8331b84e2318@quicinc.com>
Content-Language: en-US
From: Lk Sii <lk_sii@163.com>
In-Reply-To: <b8cc1486-b627-4186-a53c-8331b84e2318@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnr90vMTpmjMtKCg--.30278S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr43JFy3Ar1kJFyxtrW5KFg_yoW3Xr1rpF
	WDKF1Ykr4jqry8Gry2vw18ZFyjq3sIvrWUWFyUG3y7Jan0qry5KF4xtrWY9ry5G395Kr40
	vw17Ja43ua4DGF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jq0PfUUUUU=
X-CM-SenderInfo: 5onb2xrl6rljoofrz/1tbishbXNWVODEqkFAAAsb

On 2024/5/4 05:51, quic_zijuhu wrote:
> On 5/4/2024 5:25 AM, Luiz Augusto von Dentz wrote:
>> Hi,
>>
>> On Fri, May 3, 2024 at 4:18 PM quic_zijuhu <quic_zijuhu@quicinc.com> wrote:
>>>
>>> On 5/4/2024 3:22 AM, Luiz Augusto von Dentz wrote:
>>>> Hi Zijun,
>>>>
>>>> On Thu, May 2, 2024 at 10:06 AM Zijun Hu <quic_zijuhu@quicinc.com> wrote:
>>>>>
>>>>> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
>>>>> serdev") will cause below regression issue:
>>>>>
>>>>> BT can't be enabled after below steps:
>>>>> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
>>>>> if property enable-gpios is not configured within DT|ACPI for QCA6390.
>>>>>
>>>>> The commit is to fix a use-after-free issue within qca_serdev_shutdown()
>>>>> during reboot, but also introduces this regression issue regarding above
>>>>> steps since the VSC is not sent to reset controller during warm reboot.
>>>>>
>>>>> Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
>>>>> once BT was ever enabled, and the use-after-free issue is also be fixed
>>>>> by this change since serdev is still opened when send to serdev.
>>>>>
>>>>> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
>>>>> Cc: stable@vger.kernel.org
>>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
>>>>> ---
>>>>>  drivers/bluetooth/hci_qca.c | 5 ++---
>>>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>>>> index 0c9c9ee56592..8e35c9091486 100644
>>>>> --- a/drivers/bluetooth/hci_qca.c
>>>>> +++ b/drivers/bluetooth/hci_qca.c
>>>>> @@ -2450,13 +2450,12 @@ static void qca_serdev_shutdown(struct device *dev)
>>>>>         struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
>>>>>         struct hci_uart *hu = &qcadev->serdev_hu;
>>>>>         struct hci_dev *hdev = hu->hdev;
>>>>> -       struct qca_data *qca = hu->priv;
>>>>>         const u8 ibs_wake_cmd[] = { 0xFD };
>>>>>         const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
>>>>>
>>>>>         if (qcadev->btsoc_type == QCA_QCA6390) {
>>>>> -               if (test_bit(QCA_BT_OFF, &qca->flags) ||
>>>>> -                   !test_bit(HCI_RUNNING, &hdev->flags))
>>>>
>>>> This probably deserves a comment on why you end up with
>>>> HCI_QUIRK_NON_PERSISTENT_SETUP and HCI_SETUP flags here, also why you
>>>> are removing the flags above since that was introduce to prevent
>>>> use-after-free this sort of revert it so I do wonder how serdev can
>>>> still be open if you haven't tested for QCA_BT_OFF for example?
>>>>
>>> okay, let me give comments at next version.
>>> this design logic is shown below. you maybe review it.
>>>
>>> if HCI_QUIRK_NON_PERSISTENT_SETUP is set, it means that hdev->setup()
>>> is able to be invoked by every open() to initializate SoC without any
>>> help. so we don't need to send the VSC to reset SoC into initial and
>>> clean state for the next hdev->setup() call success.
>>>
>>> otherwise, namely, HCI_QUIRK_NON_PERSISTENT_SETUP is not set.
>>>
>>> if HCI_SETUP is set, it means hdev->setup() was never be invoked, so the
>>> SOC is already in the initial and clean state, so we also don't need to
>>> send the VSC to reset SOC.
>>>
>>> otherwise, we need to send the VSC to reset Soc into a initial and clean
>>> state for hdev->setup() call success after "warm reboot -> enable BT"
>>>
>>> for the case commit message cares about, the only factor which decide to
>>> send the VSC is that SoC is a initial and clean state or not after warm
>>> reboot, any other factors are irrelevant to this decision.
>>>
>>> why the serdev is still open after go through
>>> (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)
>>> || hci_dev_test_flag(hdev, HCI_SETUP) checking is that
>>> serdev is not closed by hci_uart_close().
>>
>> Sounds like a logical jump to me, in fact hci_uart_close doesn't
>> really change any of those flags, beside these flags are not really
>> meant to tell the driver if serdev_device_close has been called or not
>> which seems to be the intention with HCI_UART_PROTO_READY so how about
>> we use that instead?
>>
> sorry for that i maybe not give good explanation, let me explain again.
> hci_uart_close() is the only point which maybe close serdev before
> qca_serdev_shutdown() is called, but for our case that
> HCI_QUIRK_NON_PERSISTENT_SETUP is NOT set, hci_uart_close() will not
> close serdev for our case, so serdev must be open state before sending
> the VSC. so should not need other checking.
>
hello, i have paid attention to your discussion for a long time, i would
like to join this discussion now.

The serdev is still open before sending the VSC for this patch.

are you agree with above Zijun's point?

>> Another thing that is troubling me is that having traffic on shutdown
>> is not common, specially if you are going to reboot, etc, and even if
>> it doesn't get power cycle why don't you reset on probe rather than
>> shutdown? That way we don't have to depend on what has been done in a
>> previous boot, which can really become a problem in case of multi-OS
>> where you have another system that may not be doing what you expect.
> as you know, BT UART are working at 3M baudrate for normal usage.
> we can't distinguish if SoC expects 3M or default 11.52K baudarate
> during probe() after reboot. so we send the VSC within shutdown to make
> sure SoC enter a initial state with 11.52 baudrate.
> 
> for cold boot, SOC expects default 11.52K baudrate for probe().
> for Enable BT -> warm boot, SOC expects 3M baudrate for probe().
> we can't tell these two case within probe(). so need to send the VSC
> within shutdown().
>
it seems the traffic within qca_serdev_shutdown() actually does software
reset for BT SOC.

From Zijun's points. the reasons why to do software reset within
shutdown() instead of probe() maybe be shown below
1) it is impossible to do software reset within probe().
2) it seems it is easier to do it within shutdown() than probe.

Zijun's simple fix only change the condition and does NOT change the
location to send the VSC, i think it maybe be other topic about location
where(probe() or shutdown()) to do software reset.

are you agree with this point?


For concern about multi-OS, i would like to show my points.

the patch is for linux kernel, we maybe only need to care about linux
OS. it maybe out-of-scope to make assumptions about other OSs vendor
announced supported such as Windows OS we don't known much about.

are you agree with this point?

>>> see hci_uart_close() within drivers/bluetooth/hci_serdev.c
>>> static int hci_uart_close(struct hci_dev *hdev)
>>> {
>>> ......
>>>         /* When QUIRK HCI_QUIRK_NON_PERSISTENT_SETUP is set by driver,
>>>          * BT SOC is completely powered OFF during BT OFF, holding port
>>>          * open may drain the battery.
>>>          */
>>>         if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
>>>                 clear_bit(HCI_UART_PROTO_READY, &hu->flags);
>>>                 serdev_device_close(hu->serdev);
>>>         }
>>>
>>>         return 0;
>>> }
>>>
>>>>> +               if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks) ||
>>>>> +                   hci_dev_test_flag(hdev, HCI_SETUP))
>>>>>                         return;
>>>>>
>>>>>                 serdev_device_write_flush(serdev);
>>>>> --
>>>>> 2.7.4
>>>>>
>>>>
>>>>
>>>
>>
>>
> 
> 
> 


