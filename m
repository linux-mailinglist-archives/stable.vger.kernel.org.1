Return-Path: <stable+bounces-45604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841258CC98E
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 01:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1B21F22100
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 23:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF1214A627;
	Wed, 22 May 2024 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="L3V4nHSK"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353FA146A76;
	Wed, 22 May 2024 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716420385; cv=none; b=IdCE8lFndvwyIYZ+QTftHtOzgk++PuxOuoUAWcGYJfW4PqibGZz3DtzY2u4LACqbkU4kd2HFWfZaLMvXwUVYhGCbn7I+OPvPkgUkQAOi/Qyp333f/X5RhWmeYU+IDYnJuQOVDRTo59eQFO9VS5Vy77jooflsIPUB1krMCO90YRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716420385; c=relaxed/simple;
	bh=SmMdZV+48vA3uRMvpKMa0WfNcBGvF4iPP3xBH9mpF9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itiAzIgps8VebbZf5pMMRhQFDDSUFaz3yp3i2T/uypudc9NTisRiKjSxRkpesA5HBjreuH0aqhyaSGJdDE5GeZBLMObMEz79HP5bu+PRHdEsGpNALYRUcpZHdT+8HDL1v0aEv/MoPIrFpGJiZgXRH+w3U2V9MKPo9n+hEjsNeEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=L3V4nHSK; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=z23Ki4e2NABlBf02MgjBQ9MDAsB2Ew9POLwHallhTSM=;
	b=L3V4nHSKTkutpumWCz6M3FnBNnvr95YfxH0AahdGV0VBx/IUXcQf1EpqGqFYww
	/FZOKLq6DDtWBNFvMxe3hSukODasAzHuFHCkNf2UPt0NfinVtv1ScPYmdLe7AYn5
	RcgSPyHS/fdIcUGqnQuCL22TRcuhX1ZDHiLKzSnOB5IlY=
Received: from [192.168.1.25] (unknown [183.195.6.89])
	by gzga-smtp-mta-g2-5 (Coremail) with SMTP id _____wD3X9Dnfk5m0xtVBw--.52033S2;
	Thu, 23 May 2024 07:25:28 +0800 (CST)
Message-ID: <aa04210f-ffef-4fdf-9413-e4d6fde5de11@163.com>
Date: Thu, 23 May 2024 07:25:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: Fix BT enable failure again for
 QCA6390 after warm reboot
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <quic_zijuhu@quicinc.com>, luiz.von.dentz@intel.com,
 marcel@holtmann.org, linux-bluetooth@vger.kernel.org, wt@penguintechs.org,
 regressions@lists.linux.dev, pmenzel@molgen.mpg.de,
 krzysztof.kozlowski@linaro.org, stable@vger.kernel.org
References: <1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com>
 <f343ecae-efee-4bdc-ac38-89b614e081b5@163.com>
 <CABBYNZ+nLgozYxL=znsXrg0qoz-ENgSBwcPzY-KrBnVJJut8Kw@mail.gmail.com>
 <34a8e7c3-8843-4f07-9eef-72fb1f8e9378@163.com>
 <CABBYNZLzTcnXP3bKdQB3wdBCMgCJrqu=jXQ91ws6+c1mioYt9A@mail.gmail.com>
 <75809a40-d269-4326-8feb-19963526f014@163.com>
 <CABBYNZKtX54f1QrTrCth-sU83s2_9pLOr+zwRni0UdO7tjFj6A@mail.gmail.com>
Content-Language: en-US
From: Lk Sii <lk_sii@163.com>
In-Reply-To: <CABBYNZKtX54f1QrTrCth-sU83s2_9pLOr+zwRni0UdO7tjFj6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X9Dnfk5m0xtVBw--.52033S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3tw4rCw18Gry3CF18KFy7trb_yoW8GFWDKo
	Wftr47Xa18tr1UCr45Aa4UArW3J34DZw18ArWUXrs8Jrs2qa45ur4UCw15XFsxJr4rGr48
	J34UAr98ZrZ8Xa1fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIYiiUUUUU
X-CM-SenderInfo: 5onb2xrl6rljoofrz/1tbiEw7mNWXAlRL9nQAAsM



On 2024/5/22 22:25, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Wed, May 22, 2024 at 9:33 AM Lk Sii <lk_sii@163.com> wrote:
>>
>>
>>
>> On 2024/5/21 23:48, Luiz Augusto von Dentz wrote:
>>> Hi,
>>>
>>> On Tue, May 21, 2024 at 10:52 AM Lk Sii <lk_sii@163.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2024/5/16 23:55, Luiz Augusto von Dentz wrote:
>>>>> Hi,
>>>>>
>>>>> On Thu, May 16, 2024 at 10:57 AM Lk Sii <lk_sii@163.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2024/5/16 21:31, Zijun Hu wrote:
>>>>>>> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
>>>>>>> serdev") will cause below regression issue:
>>>>>>>
>>>>>>> BT can't be enabled after below steps:
>>>>>>> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
>>>>>>> if property enable-gpios is not configured within DT|ACPI for QCA6390.
>>>>>>>
>>>>>>> The commit is to fix a use-after-free issue within qca_serdev_shutdown()
>>>>>>> by adding condition to avoid the serdev is flushed or wrote after closed
>>>>>>> but also introduces this regression issue regarding above steps since the
>>>>>>> VSC is not sent to reset controller during warm reboot.
>>>>>>>
>>>>>>> Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
>>>>>>> once BT was ever enabled, and the use-after-free issue is also fixed by
>>>>>>> this change since the serdev is still opened before it is flushed or wrote.
>>>>>>>
>>>>>>> Verified by the reported machine Dell XPS 13 9310 laptop over below two
>>>>>>> kernel commits:
>>>>>>> commit e00fc2700a3f ("Bluetooth: btusb: Fix triggering coredump
>>>>>>> implementation for QCA") of bluetooth-next tree.
>>>>>>> commit b23d98d46d28 ("Bluetooth: btusb: Fix triggering coredump
>>>>>>> implementation for QCA") of linus mainline tree.
>>>>>>>
>>>>>>> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
>>>>>>> Cc: stable@vger.kernel.org
>>>>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
>>>>>>> ---
>>>>>>> V1 -> V2: Add comments and more commit messages
>>>>>>>
>>>>>>> V1 discussion link:
>>>>>>> https://lore.kernel.org/linux-bluetooth/d553edef-c1a4-4d52-a892-715549d31ebe@163.com/T/#t
>>>>>>>
>>>>>>>  drivers/bluetooth/hci_qca.c | 18 +++++++++++++++---
>>>>>>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>>>>>> index 0c9c9ee56592..9a0bc86f9aac 100644
>>>>>>> --- a/drivers/bluetooth/hci_qca.c
>>>>>>> +++ b/drivers/bluetooth/hci_qca.c
>>>>>>> @@ -2450,15 +2450,27 @@ static void qca_serdev_shutdown(struct device *dev)
>>>>>>>       struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
>>>>>>>       struct hci_uart *hu = &qcadev->serdev_hu;
>>>>>>>       struct hci_dev *hdev = hu->hdev;
>>>>>>> -     struct qca_data *qca = hu->priv;
>>>>>>>       const u8 ibs_wake_cmd[] = { 0xFD };
>>>>>>>       const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
>>>>>>>
>>>>>>>       if (qcadev->btsoc_type == QCA_QCA6390) {
>>>>>>> -             if (test_bit(QCA_BT_OFF, &qca->flags) ||
>>>>>>> -                 !test_bit(HCI_RUNNING, &hdev->flags))
>>>>>>> +             /* The purpose of sending the VSC is to reset SOC into a initial
>>>>>>> +              * state and the state will ensure next hdev->setup() success.
>>>>>>> +              * if HCI_QUIRK_NON_PERSISTENT_SETUP is set, it means that
>>>>>>> +              * hdev->setup() can do its job regardless of SoC state, so
>>>>>>> +              * don't need to send the VSC.
>>>>>>> +              * if HCI_SETUP is set, it means that hdev->setup() was never
>>>>>>> +              * invoked and the SOC is already in the initial state, so
>>>>>>> +              * don't also need to send the VSC.
>>>>>>> +              */
>>>>>>> +             if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks) ||
>>>>>>> +                 hci_dev_test_flag(hdev, HCI_SETUP))
>>>>>>>                       return;
>>>> The main purpose of above checking is NOT to make sure the serdev within
>>>> open state as its comments explained.
>>>>>>>
>>>>>>> +             /* The serdev must be in open state when conrol logic arrives
>>>>>>> +              * here, so also fix the use-after-free issue caused by that
>>>>>>> +              * the serdev is flushed or wrote after it is closed.
>>>>>>> +              */
>>>>>>>               serdev_device_write_flush(serdev);
>>>>>>>               ret = serdev_device_write_buf(serdev, ibs_wake_cmd,
>>>>>>>                                             sizeof(ibs_wake_cmd));
>>>>>> i believe Zijun's change is able to fix both below issues and don't
>>>>>> introduce new issue.
>>>>>>
>>>>>> regression issue A:  BT enable failure after warm reboot.
>>>>>> issue B:  use-after-free issue, namely, kernel crash.
>>>>>>
>>>>>>
>>>>>> For issue B, i have more findings related to below commits ordered by time.
>>>>>>
>>>>>> Commit A: 7e7bbddd029b ("Bluetooth: hci_qca: Fix qca6390 enable failure
>>>>>> after warm reboot")
>>>>>>
>>>>>> Commit B: de8892df72be ("Bluetooth: hci_serdev: Close UART port if
>>>>>> NON_PERSISTENT_SETUP is set")
>>>>>> this commit introduces issue B, it is also not suitable to associate
>>>>>> protocol state with state of lower level transport type such as serdev
>>>>>> or uart, in my opinion, protocol state should be independent with
>>>>>> transport type state, flag HCI_UART_PROTO_READY is for protocol state,
>>>>>> it means if protocol hu->proto is initialized and if we can invoke its
>>>>>> interfaces.it is common for various kinds of transport types. perhaps,
>>>>>> this is the reason why Zijun's change doesn't use flag HCI_UART_PROTO_READY.
>>>>>
>>>>> Don't really follow you here, if HCI_UART_PROTO_READY indicates the
>>>>> protocol state they is even _more_ important to use before invoking
>>>>> serdev APIs, so checking for the quirk sound like a problem because:
>>>>>
>>>>> [1] hci_uart_close
>>>>>      /* When QUIRK HCI_QUIRK_NON_PERSISTENT_SETUP is set by driver,
>>>>>      * BT SOC is completely powered OFF during BT OFF, holding port
>>>>>      * open may drain the battery.
>>>>>      */
>>>>>     if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
>>>>>         clear_bit(HCI_UART_PROTO_READY, &hu->flags);
>>>>>         serdev_device_close(hu->serdev);
>>>>>     }
>>>>>
>>>>> [2] hci_uart_unregister_device
>>>>>     if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
>>>>>         clear_bit(HCI_UART_PROTO_READY, &hu->flags);
>>>>>         serdev_device_close(hu->serdev);
>>>>>     }
>>>>> both case 1 and case 2 were introduced by Commit B in question which
>>>> uses protocol state flag HCI_UART_PROTO_READY to track lower level
>>>> transport type state, i don't think it is perfect.
>>>>
>>>> for common files hci_serdev.c and hci_ldisc.c, as you saw, the purpose
>>>> of checking HCI_UART_PROTO_READY is to call protocol relevant
>>>> interfaces, moreover, these protocol relevant interfaces do not deal
>>>> with lower transport state. you maybe even notice below present function
>>>> within which lower level serdev is flushed before HCI_UART_PROTO_READY
>>>> is checked:
>>>>
>>>> static int hci_uart_flush(struct hci_dev *hdev)
>>>> {
>>>> ......
>>>>         /* Flush any pending characters in the driver and discipline. */
>>>>         serdev_device_write_flush(hu->serdev);
>>>>
>>>>         if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
>>>>                 hu->proto->flush(hu);
>>>>
>>>>         return 0;
>>>> }
>>>>
>>>> in my opinion, that is why qca_serdev_shutdown() does not check
>>>> HCI_UART_PROTO_READY for later lower level serdev operations.
>>>>> So only in case 1 checking the quirk is equivalent to
>>>>> HCI_UART_PROTO_READY on case 2 it does actually check the quirk and
>>>>> will proceed to call serdev_device_close, now perhaps the code is
>>>>> assuming that shutdown won't be called after that, but it looks it
>>>>> does since:
>>>>>
>>>> qca_serdev_shutdown() will never be called after case 2 as explained
>>>> in the end.
>>>>> static void serdev_drv_remove(struct device *dev)
>>>>> {
>>>>>     const struct serdev_device_driver *sdrv =
>>>>> to_serdev_device_driver(dev->driver);
>>>>>     if (sdrv->remove)
>>>>>         sdrv->remove(to_serdev_device(dev));
>>>>>
>>>>>     dev_pm_domain_detach(dev, true);
>>>>> }
>>>>>
>>>>> dev_pm_domain_detach says it will power off so I assume that means
>>>>> that shutdown will be called _after_ remove, so not I'm not really
>>>>> convinced that we can avoid using HCI_UART_PROTO_READY, in fact the
>>>>> following sequence might always be triggering:
>>>>>
>>>> dev_pm_domain_detach() should be irrelevant with qca_serdev_shutdown(),
>>>> should not trigger call of qca_serdev_shutdown() as explained in the end
>>>>> serdev_drv_remove -> qca_serdev_remove -> hci_uart_unregister_device
>>>>> -> serdev_device_close -> qca_close -> kfree(qca)
>>>>> dev_pm_domain_detach -> ??? -> qca_serdev_shutdown
>>>>>
>>>>> If this sequence is correct then qca_serdev_shutdown accessing
>>>>> qca_data will always result in a UAF problem.
>>>>>
>>>> above sequence should not correct as explained below.
>>>>
>>>> serdev and its driver should also follow below generic device and driver
>>>> design.
>>>>
>>>> 1)
>>>> driver->shutdown() will be called during shut-down time at this time
>>>> driver->remove() should not have been called.
>>>>
>>>> 2)
>>>> driver->shutdown() is impossible to be called once driver->remove()
>>>> was called.
>>>>
>>>> 3) for serdev, driver->remove() does not trigger call of
>>>> driver->shutdown() since PM relevant poweroff is irrelevant with
>>>> driver->shutdown() and i also don't find any PM relevant interfaces will
>>>> call driver->shutdown().
>>>>
>>>> i would like to explain issue B based on comments Zijun posted by public
>>>> as below:
>>>>
>>>> issue B actually happens during reboot and let me look at these steps
>>>> boot -> enable BT -> disable BT -> reboot.
>>>>
>>>> 1) step boot will call driver->probe() to register hdev and the serdev
>>>> is opened after boot.
>>>>
>>>> 2) step enable will call hdev->open() and the serdev will still in open
>>>> state
>>>>
>>>> 3) step disable will call hdev->close() and the serdev will be closed
>>>> after hdev->close() for machine with config which results in
>>>> HCI_QUIRK_NON_PERSISTENT_SETUP is set.
>>>>
>>>> 4) step reboot will call qca_serdev_shutdown() which will flush and
>>>> write the serdev which are closed by above step disable, so cause the
>>>> UAF issue, namely, kernel crash issue.
>>>>
>>>> so this issue is caused by commit B which close the serdev during
>>>> hdev->close().
>>>>
>>>> driver->remove() even is not triggered during above steps.
>>>>>> Commit C: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on
>>>>>> closed serdev")
>>>>>> this commit is to fix issue B which is actually caused by Commit B, but
>>>>>> it has Fixes tag for Commit A. and it also introduces the regression
>>>>>> issue A.
>>>>>>
>>>>>
>>>>>
>>>
>>> Reading again the commit message for the UAF fix it sounds like a
>>> different problem:
>>>
>> no, the UAF issue commit C fixes should be the same issue descripted by
>> me previously as explained below:
>>
>> the UAF issue happened with machine "qualcomm Technologies, Inc.
>> Robotics RB5 (DT)", the machine uses qca6390 and have property
>> enable-gpios configured, which will results in that quirk
>> HCI_QUIRK_NON_PERSISTENT_SETUP is set, so must meet the UAF issue
>> for normal operation sequences "boot -> enable BT -> disable BT -> reboot".
> 
> Wait, are you telling me that UAF was wrongly described? Or perhaps
> they are just different trees and you don't see the problem because
> you are not actually running with the mainline code?
> 
sorry, please ignore my last comment to simply discussion
>> Actually, only machines which uses QCA6390 and have property
>> enable-gpios configured will meet the UAF issue as commented by Zijun
>> with below link
>> https://lore.kernel.org/linux-bluetooth/9ac11453-b7cf-43f3-8e46-f96e41ef190d@quicinc.com/
>>
>>>     The driver shutdown callback (which sends EDL_SOC_RESET to the device
>>>     over serdev) should not be invoked when HCI device is not open (e.g. if
>>>     hci_dev_open_sync() failed), because the serdev and its TTY are not open
>>>     either.  Also skip this step if device is powered off
>>>     (qca_power_shutdown()).
>>>
>>> So if hci_dev_open_sync has failed it says serdev and its TTY will not
>>> be open either, so I guess that's why HCI_SETUP was added as a
>>> condition to bail out? So it seems correct to do that although I'd
>>> change the comments.
>>>
>> i believe hci_dev_open_sync failure should not really happens with the
>> machine Robotics RB5, the purpose that it is mentioned with commit
>> message is to illustrate that the serdev in closed state is operated and
>> causes the UAF issue.
> 
> Sorry but Im not really following, there seems to be instances where
> qca driver will fail on hci_dev_open_sync, now the shutdown sequence
> is only done for a specific model, not a machine like Robotics RB5,
> btw you are not really contributing to solving the problem if you are
> throwing us back in different directions like this.
> 
sorry, please ignore my last comment to simply discussion
>> let us assume that hci_dev_open_sync failure -> serdev is not opened ->
>> UAF issue happens within qca_serdev_shutdown(), then BT will not be
>> working at all and the commit C is actually a workaroud instead of a fix
>> since the right approach is to solve the hci_dev_open_sync failure which
>> happens firstly.
>>
>>
>> Frankly, only checking quirk HCI_QUIRK_NON_PERSISTENT_SETUP is enough to
>> fix the UAF issue caused by either "normal operation sequences" or
>> "hci_dev_open_sync failure".
> 
> Ok, just stop contributing to this thread, you don't know what you are
> talking about, HCI_QUIRK_NON_PERSISTENT_SETUP has nothing to do with
> serdev state.
> 
okay, please ignore my last comment to simply discussion about Zijun's
change.
>>> @Krzysztof Kozlowski do you still have a test setup for 272970be3dab
>>> ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev"), can you
>>> try with these changes?
>>>
>>
> 
> 


