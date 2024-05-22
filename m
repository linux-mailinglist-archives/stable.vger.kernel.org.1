Return-Path: <stable+bounces-45573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 602E78CC337
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 16:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3E7EB2261C
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 14:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFF71411FD;
	Wed, 22 May 2024 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HB776RxH"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB291411CA;
	Wed, 22 May 2024 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387929; cv=none; b=sP5I7ohp8mL0mEBCUj+//JlLHssbnygMVjx7AI6Htg4hDLZvFLxSuYYqD3wzL6PmA8ttXkoWR0A3Y4810qprt6ODSIgRyyWTV3viQfSauJcH6hdGa6q5zuv3ZGrbhVm0nRkCoiNNH6VFguEKl6uWpA4DE73ATxuWumlOMLpb1yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387929; c=relaxed/simple;
	bh=mnoBKydjtB3TJ5ZZGVOBftXlG87005ka3C0NWrxf4II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1W8FcsGwF03IPUVOygFgseuW95vqWlEODkVK1Oa+agoI9v5MeJ04fx6pY0GEk7LxF//qdAjuwK4gnr1+GrKkZ+wRtSfUOfetGcGj8J/hRhr/r5K4Jw9q7k+WRDCr7oVO5PkwVqDHiSZf9jPiBgcLT3iMH2HFdLyb0rU4a2Tqvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HB776RxH; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e73359b979so28848691fa.1;
        Wed, 22 May 2024 07:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716387924; x=1716992724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FHVMvGgX3K8XARnnPrnec7+iL/PYgA2nDfp5B86P8w=;
        b=HB776RxH/EAx61m2az617+ggQSnaCSMFzajNkdGEqUreWv2g4FDjpLYpftbtNf5gqo
         kk1AJh8pWMm4ckQ5n/tVQK2TJzGPR0eSSgGNJxUKqMTEI+Y6Dtoe4UXK0QoDRr4JCtzf
         kGwNpMWwFVwEyl3i+KKnRrtwqcy0TfD3Xtew8h39bwVDfQucaSMy/vGfmrjOmtt4Gf4F
         B5c36Y7KjYlcdcsT+mlHP9fiFGExj48NSErFYeFMo4rqzdRjBSNRTZ2TPw6+eCZm1NVY
         +D3Wz/vdGYGEf0YzLaGVZCFvMJCMr0PS0Z6FC9LozcoOp5CV5I27N6QmUuALZeKxMO9j
         LTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716387924; x=1716992724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FHVMvGgX3K8XARnnPrnec7+iL/PYgA2nDfp5B86P8w=;
        b=miL4b5t27QaA4EsMYmQ4GkRBwQLRWdrzfimUzfrf1JCb2akAn6WdGflgtdrDNWONku
         Ep+ux5YQwu5Xd/ekD0VXjuz0rnwAR2bkM+qytpenh7y4FWEyZiGv6FFrZXoaU3eOEAY+
         tPDU/2ybTnCJKCRbmuTJfKzjynflnBQL6SVCFsXFbA3RGZQJ4JP2BFK5noZDhnGpcSNd
         3jzii1OgzmtCMDb/VyJp27fezwOlsAL6k0ZD1EXC87EzmGTBpv847UXY2Dk9KElWOmSS
         WhAeVE76MnzILOtZggR86a2uyAq1KsKAwPtq/q1JgUKheawL0JQpeIy56CC/xaeB7TNW
         VEYA==
X-Forwarded-Encrypted: i=1; AJvYcCUMhRVwDd2byfBXMRs/qkhJ/45ZYJ2Q/fo+LMJI/6zBhHXKdpod1yHfI6WsQSe8kA39AEacnNDPi7RpTgWUMgyicqBM6EiROw1AUAwL6cASSq42bF8U2JQ1v3nkdViVJ/Xlnk0Seetx
X-Gm-Message-State: AOJu0YzJYxmax1MjUUdFptYXxnDoAr7jHkcuOPVG98vMRw95mBQ8rpsR
	I0CDAQ0zB+dqu62UMA0v/EA2Hn6aPNYeKBrmuzow1Pi5HJDyStuXXIvkakvxPG4Ks/mK/pEFJRq
	bGKOQChb+rOp0c3k9M2fE3rf56I4=
X-Google-Smtp-Source: AGHT+IGF+ySmmO35v1/CO7cjU39/3xLdZqLfUaFcWhKkQ0j5cpy98+Sno1pEDNH05ExzUNOrteTtWGRpx/S/XXsq0NU=
X-Received: by 2002:a2e:9882:0:b0:2de:48ef:c3ce with SMTP id
 38308e7fff4ca-2e9495ee567mr12281171fa.49.1716387924067; Wed, 22 May 2024
 07:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com>
 <f343ecae-efee-4bdc-ac38-89b614e081b5@163.com> <CABBYNZ+nLgozYxL=znsXrg0qoz-ENgSBwcPzY-KrBnVJJut8Kw@mail.gmail.com>
 <34a8e7c3-8843-4f07-9eef-72fb1f8e9378@163.com> <CABBYNZLzTcnXP3bKdQB3wdBCMgCJrqu=jXQ91ws6+c1mioYt9A@mail.gmail.com>
 <75809a40-d269-4326-8feb-19963526f014@163.com>
In-Reply-To: <75809a40-d269-4326-8feb-19963526f014@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 May 2024 10:25:11 -0400
Message-ID: <CABBYNZKtX54f1QrTrCth-sU83s2_9pLOr+zwRni0UdO7tjFj6A@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: qca: Fix BT enable failure again for
 QCA6390 after warm reboot
To: Lk Sii <lk_sii@163.com>
Cc: Zijun Hu <quic_zijuhu@quicinc.com>, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, wt@penguintechs.org, 
	regressions@lists.linux.dev, pmenzel@molgen.mpg.de, 
	krzysztof.kozlowski@linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 22, 2024 at 9:33=E2=80=AFAM Lk Sii <lk_sii@163.com> wrote:
>
>
>
> On 2024/5/21 23:48, Luiz Augusto von Dentz wrote:
> > Hi,
> >
> > On Tue, May 21, 2024 at 10:52=E2=80=AFAM Lk Sii <lk_sii@163.com> wrote:
> >>
> >>
> >>
> >> On 2024/5/16 23:55, Luiz Augusto von Dentz wrote:
> >>> Hi,
> >>>
> >>> On Thu, May 16, 2024 at 10:57=E2=80=AFAM Lk Sii <lk_sii@163.com> wrot=
e:
> >>>>
> >>>>
> >>>>
> >>>> On 2024/5/16 21:31, Zijun Hu wrote:
> >>>>> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on cl=
osed
> >>>>> serdev") will cause below regression issue:
> >>>>>
> >>>>> BT can't be enabled after below steps:
> >>>>> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable fa=
ilure
> >>>>> if property enable-gpios is not configured within DT|ACPI for QCA63=
90.
> >>>>>
> >>>>> The commit is to fix a use-after-free issue within qca_serdev_shutd=
own()
> >>>>> by adding condition to avoid the serdev is flushed or wrote after c=
losed
> >>>>> but also introduces this regression issue regarding above steps sin=
ce the
> >>>>> VSC is not sent to reset controller during warm reboot.
> >>>>>
> >>>>> Fixed by sending the VSC to reset controller within qca_serdev_shut=
down()
> >>>>> once BT was ever enabled, and the use-after-free issue is also fixe=
d by
> >>>>> this change since the serdev is still opened before it is flushed o=
r wrote.
> >>>>>
> >>>>> Verified by the reported machine Dell XPS 13 9310 laptop over below=
 two
> >>>>> kernel commits:
> >>>>> commit e00fc2700a3f ("Bluetooth: btusb: Fix triggering coredump
> >>>>> implementation for QCA") of bluetooth-next tree.
> >>>>> commit b23d98d46d28 ("Bluetooth: btusb: Fix triggering coredump
> >>>>> implementation for QCA") of linus mainline tree.
> >>>>>
> >>>>> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on cl=
osed serdev")
> >>>>> Cc: stable@vger.kernel.org
> >>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
> >>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218726
> >>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
> >>>>> ---
> >>>>> V1 -> V2: Add comments and more commit messages
> >>>>>
> >>>>> V1 discussion link:
> >>>>> https://lore.kernel.org/linux-bluetooth/d553edef-c1a4-4d52-a892-715=
549d31ebe@163.com/T/#t
> >>>>>
> >>>>>  drivers/bluetooth/hci_qca.c | 18 +++++++++++++++---
> >>>>>  1 file changed, 15 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qc=
a.c
> >>>>> index 0c9c9ee56592..9a0bc86f9aac 100644
> >>>>> --- a/drivers/bluetooth/hci_qca.c
> >>>>> +++ b/drivers/bluetooth/hci_qca.c
> >>>>> @@ -2450,15 +2450,27 @@ static void qca_serdev_shutdown(struct devi=
ce *dev)
> >>>>>       struct qca_serdev *qcadev =3D serdev_device_get_drvdata(serde=
v);
> >>>>>       struct hci_uart *hu =3D &qcadev->serdev_hu;
> >>>>>       struct hci_dev *hdev =3D hu->hdev;
> >>>>> -     struct qca_data *qca =3D hu->priv;
> >>>>>       const u8 ibs_wake_cmd[] =3D { 0xFD };
> >>>>>       const u8 edl_reset_soc_cmd[] =3D { 0x01, 0x00, 0xFC, 0x01, 0x=
05 };
> >>>>>
> >>>>>       if (qcadev->btsoc_type =3D=3D QCA_QCA6390) {
> >>>>> -             if (test_bit(QCA_BT_OFF, &qca->flags) ||
> >>>>> -                 !test_bit(HCI_RUNNING, &hdev->flags))
> >>>>> +             /* The purpose of sending the VSC is to reset SOC int=
o a initial
> >>>>> +              * state and the state will ensure next hdev->setup()=
 success.
> >>>>> +              * if HCI_QUIRK_NON_PERSISTENT_SETUP is set, it means=
 that
> >>>>> +              * hdev->setup() can do its job regardless of SoC sta=
te, so
> >>>>> +              * don't need to send the VSC.
> >>>>> +              * if HCI_SETUP is set, it means that hdev->setup() w=
as never
> >>>>> +              * invoked and the SOC is already in the initial stat=
e, so
> >>>>> +              * don't also need to send the VSC.
> >>>>> +              */
> >>>>> +             if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->q=
uirks) ||
> >>>>> +                 hci_dev_test_flag(hdev, HCI_SETUP))
> >>>>>                       return;
> >> The main purpose of above checking is NOT to make sure the serdev with=
in
> >> open state as its comments explained.
> >>>>>
> >>>>> +             /* The serdev must be in open state when conrol logic=
 arrives
> >>>>> +              * here, so also fix the use-after-free issue caused =
by that
> >>>>> +              * the serdev is flushed or wrote after it is closed.
> >>>>> +              */
> >>>>>               serdev_device_write_flush(serdev);
> >>>>>               ret =3D serdev_device_write_buf(serdev, ibs_wake_cmd,
> >>>>>                                             sizeof(ibs_wake_cmd));
> >>>> i believe Zijun's change is able to fix both below issues and don't
> >>>> introduce new issue.
> >>>>
> >>>> regression issue A:  BT enable failure after warm reboot.
> >>>> issue B:  use-after-free issue, namely, kernel crash.
> >>>>
> >>>>
> >>>> For issue B, i have more findings related to below commits ordered b=
y time.
> >>>>
> >>>> Commit A: 7e7bbddd029b ("Bluetooth: hci_qca: Fix qca6390 enable fail=
ure
> >>>> after warm reboot")
> >>>>
> >>>> Commit B: de8892df72be ("Bluetooth: hci_serdev: Close UART port if
> >>>> NON_PERSISTENT_SETUP is set")
> >>>> this commit introduces issue B, it is also not suitable to associate
> >>>> protocol state with state of lower level transport type such as serd=
ev
> >>>> or uart, in my opinion, protocol state should be independent with
> >>>> transport type state, flag HCI_UART_PROTO_READY is for protocol stat=
e,
> >>>> it means if protocol hu->proto is initialized and if we can invoke i=
ts
> >>>> interfaces.it is common for various kinds of transport types. perhap=
s,
> >>>> this is the reason why Zijun's change doesn't use flag HCI_UART_PROT=
O_READY.
> >>>
> >>> Don't really follow you here, if HCI_UART_PROTO_READY indicates the
> >>> protocol state they is even _more_ important to use before invoking
> >>> serdev APIs, so checking for the quirk sound like a problem because:
> >>>
> >>> [1] hci_uart_close
> >>>      /* When QUIRK HCI_QUIRK_NON_PERSISTENT_SETUP is set by driver,
> >>>      * BT SOC is completely powered OFF during BT OFF, holding port
> >>>      * open may drain the battery.
> >>>      */
> >>>     if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
> >>>         clear_bit(HCI_UART_PROTO_READY, &hu->flags);
> >>>         serdev_device_close(hu->serdev);
> >>>     }
> >>>
> >>> [2] hci_uart_unregister_device
> >>>     if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
> >>>         clear_bit(HCI_UART_PROTO_READY, &hu->flags);
> >>>         serdev_device_close(hu->serdev);
> >>>     }
> >>> both case 1 and case 2 were introduced by Commit B in question which
> >> uses protocol state flag HCI_UART_PROTO_READY to track lower level
> >> transport type state, i don't think it is perfect.
> >>
> >> for common files hci_serdev.c and hci_ldisc.c, as you saw, the purpose
> >> of checking HCI_UART_PROTO_READY is to call protocol relevant
> >> interfaces, moreover, these protocol relevant interfaces do not deal
> >> with lower transport state. you maybe even notice below present functi=
on
> >> within which lower level serdev is flushed before HCI_UART_PROTO_READY
> >> is checked:
> >>
> >> static int hci_uart_flush(struct hci_dev *hdev)
> >> {
> >> ......
> >>         /* Flush any pending characters in the driver and discipline. =
*/
> >>         serdev_device_write_flush(hu->serdev);
> >>
> >>         if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
> >>                 hu->proto->flush(hu);
> >>
> >>         return 0;
> >> }
> >>
> >> in my opinion, that is why qca_serdev_shutdown() does not check
> >> HCI_UART_PROTO_READY for later lower level serdev operations.
> >>> So only in case 1 checking the quirk is equivalent to
> >>> HCI_UART_PROTO_READY on case 2 it does actually check the quirk and
> >>> will proceed to call serdev_device_close, now perhaps the code is
> >>> assuming that shutdown won't be called after that, but it looks it
> >>> does since:
> >>>
> >> qca_serdev_shutdown() will never be called after case 2 as explained
> >> in the end.
> >>> static void serdev_drv_remove(struct device *dev)
> >>> {
> >>>     const struct serdev_device_driver *sdrv =3D
> >>> to_serdev_device_driver(dev->driver);
> >>>     if (sdrv->remove)
> >>>         sdrv->remove(to_serdev_device(dev));
> >>>
> >>>     dev_pm_domain_detach(dev, true);
> >>> }
> >>>
> >>> dev_pm_domain_detach says it will power off so I assume that means
> >>> that shutdown will be called _after_ remove, so not I'm not really
> >>> convinced that we can avoid using HCI_UART_PROTO_READY, in fact the
> >>> following sequence might always be triggering:
> >>>
> >> dev_pm_domain_detach() should be irrelevant with qca_serdev_shutdown()=
,
> >> should not trigger call of qca_serdev_shutdown() as explained in the e=
nd
> >>> serdev_drv_remove -> qca_serdev_remove -> hci_uart_unregister_device
> >>> -> serdev_device_close -> qca_close -> kfree(qca)
> >>> dev_pm_domain_detach -> ??? -> qca_serdev_shutdown
> >>>
> >>> If this sequence is correct then qca_serdev_shutdown accessing
> >>> qca_data will always result in a UAF problem.
> >>>
> >> above sequence should not correct as explained below.
> >>
> >> serdev and its driver should also follow below generic device and driv=
er
> >> design.
> >>
> >> 1)
> >> driver->shutdown() will be called during shut-down time at this time
> >> driver->remove() should not have been called.
> >>
> >> 2)
> >> driver->shutdown() is impossible to be called once driver->remove()
> >> was called.
> >>
> >> 3) for serdev, driver->remove() does not trigger call of
> >> driver->shutdown() since PM relevant poweroff is irrelevant with
> >> driver->shutdown() and i also don't find any PM relevant interfaces wi=
ll
> >> call driver->shutdown().
> >>
> >> i would like to explain issue B based on comments Zijun posted by publ=
ic
> >> as below:
> >>
> >> issue B actually happens during reboot and let me look at these steps
> >> boot -> enable BT -> disable BT -> reboot.
> >>
> >> 1) step boot will call driver->probe() to register hdev and the serdev
> >> is opened after boot.
> >>
> >> 2) step enable will call hdev->open() and the serdev will still in ope=
n
> >> state
> >>
> >> 3) step disable will call hdev->close() and the serdev will be closed
> >> after hdev->close() for machine with config which results in
> >> HCI_QUIRK_NON_PERSISTENT_SETUP is set.
> >>
> >> 4) step reboot will call qca_serdev_shutdown() which will flush and
> >> write the serdev which are closed by above step disable, so cause the
> >> UAF issue, namely, kernel crash issue.
> >>
> >> so this issue is caused by commit B which close the serdev during
> >> hdev->close().
> >>
> >> driver->remove() even is not triggered during above steps.
> >>>> Commit C: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on
> >>>> closed serdev")
> >>>> this commit is to fix issue B which is actually caused by Commit B, =
but
> >>>> it has Fixes tag for Commit A. and it also introduces the regression
> >>>> issue A.
> >>>>
> >>>
> >>>
> >
> > Reading again the commit message for the UAF fix it sounds like a
> > different problem:
> >
> no, the UAF issue commit C fixes should be the same issue descripted by
> me previously as explained below:
>
> the UAF issue happened with machine "qualcomm Technologies, Inc.
> Robotics RB5 (DT)", the machine uses qca6390 and have property
> enable-gpios configured, which will results in that quirk
> HCI_QUIRK_NON_PERSISTENT_SETUP is set, so must meet the UAF issue
> for normal operation sequences "boot -> enable BT -> disable BT -> reboot=
".

Wait, are you telling me that UAF was wrongly described? Or perhaps
they are just different trees and you don't see the problem because
you are not actually running with the mainline code?

> Actually, only machines which uses QCA6390 and have property
> enable-gpios configured will meet the UAF issue as commented by Zijun
> with below link
> https://lore.kernel.org/linux-bluetooth/9ac11453-b7cf-43f3-8e46-f96e41ef1=
90d@quicinc.com/
>
> >     The driver shutdown callback (which sends EDL_SOC_RESET to the devi=
ce
> >     over serdev) should not be invoked when HCI device is not open (e.g=
. if
> >     hci_dev_open_sync() failed), because the serdev and its TTY are not=
 open
> >     either.  Also skip this step if device is powered off
> >     (qca_power_shutdown()).
> >
> > So if hci_dev_open_sync has failed it says serdev and its TTY will not
> > be open either, so I guess that's why HCI_SETUP was added as a
> > condition to bail out? So it seems correct to do that although I'd
> > change the comments.
> >
> i believe hci_dev_open_sync failure should not really happens with the
> machine Robotics RB5, the purpose that it is mentioned with commit
> message is to illustrate that the serdev in closed state is operated and
> causes the UAF issue.

Sorry but Im not really following, there seems to be instances where
qca driver will fail on hci_dev_open_sync, now the shutdown sequence
is only done for a specific model, not a machine like Robotics RB5,
btw you are not really contributing to solving the problem if you are
throwing us back in different directions like this.

> let us assume that hci_dev_open_sync failure -> serdev is not opened ->
> UAF issue happens within qca_serdev_shutdown(), then BT will not be
> working at all and the commit C is actually a workaroud instead of a fix
> since the right approach is to solve the hci_dev_open_sync failure which
> happens firstly.
>
>
> Frankly, only checking quirk HCI_QUIRK_NON_PERSISTENT_SETUP is enough to
> fix the UAF issue caused by either "normal operation sequences" or
> "hci_dev_open_sync failure".

Ok, just stop contributing to this thread, you don't know what you are
talking about, HCI_QUIRK_NON_PERSISTENT_SETUP has nothing to do with
serdev state.

> > @Krzysztof Kozlowski do you still have a test setup for 272970be3dab
> > ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev"), can you
> > try with these changes?
> >
>


--=20
Luiz Augusto von Dentz

