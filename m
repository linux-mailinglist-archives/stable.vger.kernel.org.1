Return-Path: <stable+bounces-45522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3C28CB1A8
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 17:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D551C2195C
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 15:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4E81474DA;
	Tue, 21 May 2024 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBOWaP5W"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D91114291B;
	Tue, 21 May 2024 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306542; cv=none; b=hJHpNoYj8RkVfrptFV6pkFS4pOvfwu6CTUTU6Q6OE3byDsNuAB5mlylpIwxPK8MXdz2pshwqk7inlZM4YwmP1z9ii7yVSmaefk2NGzTfIeeRb+iyukj6CDnqvM8rLWnXj9BIht7QRH0KeC36nfgz38XpjnCM9q8PC0zpfGx1RT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306542; c=relaxed/simple;
	bh=ywjvfDtNNmWcxM2SgnrIWU53H3dwpGEQR5LFNZxFMKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvg8yg7yVQaRbJLVNcSli55H4tld7p+YcdsmgEmiNP1ASl0fXlbr2dqboK2ZL4Bbd1YSiZ048B2d5BYmsaaU2d99V7UXzqigOyqicRPKmlbcg3kZr86kIoj7lgUTcq7EChMBXJHVrdhUebSX6fV0rE9nlp8NfZiMGF6zU04wxp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBOWaP5W; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e428242a38so77426891fa.2;
        Tue, 21 May 2024 08:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716306537; x=1716911337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ck3ktJkAwKndtnUF4Yf1ES/s8fb2Iwk2z1iMsniLOM=;
        b=QBOWaP5WRJykcOrDqryEFPvcQRWgTc0oaSXyWOoIcjKzeQMtyTfg1/SBmPd7puXLdU
         h02g2PnIz326KcWYZ3r6XTgfsqfuCJbs5mxvc09vwyD4OWYc1E6ohwuWOw8nLOdVtKb2
         PWzHc6TiA/dhNGKmBXdpHQO4SKSScc+LpDoPXKxxMre6k+WEpiZEIufw2WBPEMNvQ1H/
         w95/iDO1/ef7ceUIp9dClnbjDEnEE3DnQx473bOUyJMxq/7+ShoSRATHYe7NqToudTiA
         Nslykp8KaTjj9LWeLFLg5dd0h1C5Lk8LSsAbSOBvWSr9p3WXcIhX/LBjPw9uIKBky/1g
         ll8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716306537; x=1716911337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ck3ktJkAwKndtnUF4Yf1ES/s8fb2Iwk2z1iMsniLOM=;
        b=gC91/8XgkPFujzSsuer/YcGJip+iSd+MVhIV9nu/2WOBHO0pGBYifCDGPDAi1QV3TP
         n3yNUA8iOfrrQew8LY7EgzaFqwZ4YCId5ziE7W3368V62/t9qVotE2doIH78id4tmvEJ
         R9oTN/FIZ+s19a/nGeEUvM9vTHw3EHrazqJL95rRWz10eHj3I5qg5v/u7VtKQnGkc4Gu
         ObJB9ADhI+xr/Xyu8Zau5OPOli55ov2Q/YUlTv8UMayOc/CcQJQCvNC2mereYgy5pGM/
         vM3FPXAjwOSVc/0i0usvB+GgDsCRQ+smByUR6k/AfdC4HfAvjlSN7GuF+yMqt6q7lRQz
         0dvg==
X-Forwarded-Encrypted: i=1; AJvYcCXsco+iHbaDgkAU/8zMsycWZovJHmkY6WG1MgB7nC0aRZASYJ4abQMBH5ccNq5OhXoO/hHMwiXJ7jcqEB+FBWkcuzAgBg1i6Xw0bz2qly2w7PENJl/0Y9qr/uhGyAJ3hecEW8GPpbjN
X-Gm-Message-State: AOJu0Yx4jEXKSwhAEfY3rmuriCHMjHl/UY3VhZU1GUBBW4H5LZY222Qu
	tzYc9Jqd0vdFgbbtjGNAZuhuDxvz7cRRVghSsanx9atAHdpByshkn3ExT6vnqBn+smJxoFU15iU
	fUKI4DKZvGgc+JOZ+D2mjsgAfLOo=
X-Google-Smtp-Source: AGHT+IGIY/VILANL2Kk4YZnz1o+5Ov3gkGlL5cSUD803Ucb9KPO+v3nzqmQSPYheDtklX8kKAgb2ATHhuT5nbV0mv/8=
X-Received: by 2002:a2e:750:0:b0:2e5:4e76:42df with SMTP id
 38308e7fff4ca-2e54e7644cemr214940181fa.33.1716306536718; Tue, 21 May 2024
 08:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com>
 <f343ecae-efee-4bdc-ac38-89b614e081b5@163.com> <CABBYNZ+nLgozYxL=znsXrg0qoz-ENgSBwcPzY-KrBnVJJut8Kw@mail.gmail.com>
 <34a8e7c3-8843-4f07-9eef-72fb1f8e9378@163.com>
In-Reply-To: <34a8e7c3-8843-4f07-9eef-72fb1f8e9378@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 21 May 2024 11:48:43 -0400
Message-ID: <CABBYNZLzTcnXP3bKdQB3wdBCMgCJrqu=jXQ91ws6+c1mioYt9A@mail.gmail.com>
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

On Tue, May 21, 2024 at 10:52=E2=80=AFAM Lk Sii <lk_sii@163.com> wrote:
>
>
>
> On 2024/5/16 23:55, Luiz Augusto von Dentz wrote:
> > Hi,
> >
> > On Thu, May 16, 2024 at 10:57=E2=80=AFAM Lk Sii <lk_sii@163.com> wrote:
> >>
> >>
> >>
> >> On 2024/5/16 21:31, Zijun Hu wrote:
> >>> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on clos=
ed
> >>> serdev") will cause below regression issue:
> >>>
> >>> BT can't be enabled after below steps:
> >>> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable fail=
ure
> >>> if property enable-gpios is not configured within DT|ACPI for QCA6390=
.
> >>>
> >>> The commit is to fix a use-after-free issue within qca_serdev_shutdow=
n()
> >>> by adding condition to avoid the serdev is flushed or wrote after clo=
sed
> >>> but also introduces this regression issue regarding above steps since=
 the
> >>> VSC is not sent to reset controller during warm reboot.
> >>>
> >>> Fixed by sending the VSC to reset controller within qca_serdev_shutdo=
wn()
> >>> once BT was ever enabled, and the use-after-free issue is also fixed =
by
> >>> this change since the serdev is still opened before it is flushed or =
wrote.
> >>>
> >>> Verified by the reported machine Dell XPS 13 9310 laptop over below t=
wo
> >>> kernel commits:
> >>> commit e00fc2700a3f ("Bluetooth: btusb: Fix triggering coredump
> >>> implementation for QCA") of bluetooth-next tree.
> >>> commit b23d98d46d28 ("Bluetooth: btusb: Fix triggering coredump
> >>> implementation for QCA") of linus mainline tree.
> >>>
> >>> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on clos=
ed serdev")
> >>> Cc: stable@vger.kernel.org
> >>> Reported-by: Wren Turkal <wt@penguintechs.org>
> >>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218726
> >>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >>> Tested-by: Wren Turkal <wt@penguintechs.org>
> >>> ---
> >>> V1 -> V2: Add comments and more commit messages
> >>>
> >>> V1 discussion link:
> >>> https://lore.kernel.org/linux-bluetooth/d553edef-c1a4-4d52-a892-71554=
9d31ebe@163.com/T/#t
> >>>
> >>>  drivers/bluetooth/hci_qca.c | 18 +++++++++++++++---
> >>>  1 file changed, 15 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.=
c
> >>> index 0c9c9ee56592..9a0bc86f9aac 100644
> >>> --- a/drivers/bluetooth/hci_qca.c
> >>> +++ b/drivers/bluetooth/hci_qca.c
> >>> @@ -2450,15 +2450,27 @@ static void qca_serdev_shutdown(struct device=
 *dev)
> >>>       struct qca_serdev *qcadev =3D serdev_device_get_drvdata(serdev)=
;
> >>>       struct hci_uart *hu =3D &qcadev->serdev_hu;
> >>>       struct hci_dev *hdev =3D hu->hdev;
> >>> -     struct qca_data *qca =3D hu->priv;
> >>>       const u8 ibs_wake_cmd[] =3D { 0xFD };
> >>>       const u8 edl_reset_soc_cmd[] =3D { 0x01, 0x00, 0xFC, 0x01, 0x05=
 };
> >>>
> >>>       if (qcadev->btsoc_type =3D=3D QCA_QCA6390) {
> >>> -             if (test_bit(QCA_BT_OFF, &qca->flags) ||
> >>> -                 !test_bit(HCI_RUNNING, &hdev->flags))
> >>> +             /* The purpose of sending the VSC is to reset SOC into =
a initial
> >>> +              * state and the state will ensure next hdev->setup() s=
uccess.
> >>> +              * if HCI_QUIRK_NON_PERSISTENT_SETUP is set, it means t=
hat
> >>> +              * hdev->setup() can do its job regardless of SoC state=
, so
> >>> +              * don't need to send the VSC.
> >>> +              * if HCI_SETUP is set, it means that hdev->setup() was=
 never
> >>> +              * invoked and the SOC is already in the initial state,=
 so
> >>> +              * don't also need to send the VSC.
> >>> +              */
> >>> +             if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->qui=
rks) ||
> >>> +                 hci_dev_test_flag(hdev, HCI_SETUP))
> >>>                       return;
> The main purpose of above checking is NOT to make sure the serdev within
> open state as its comments explained.
> >>>
> >>> +             /* The serdev must be in open state when conrol logic a=
rrives
> >>> +              * here, so also fix the use-after-free issue caused by=
 that
> >>> +              * the serdev is flushed or wrote after it is closed.
> >>> +              */
> >>>               serdev_device_write_flush(serdev);
> >>>               ret =3D serdev_device_write_buf(serdev, ibs_wake_cmd,
> >>>                                             sizeof(ibs_wake_cmd));
> >> i believe Zijun's change is able to fix both below issues and don't
> >> introduce new issue.
> >>
> >> regression issue A:  BT enable failure after warm reboot.
> >> issue B:  use-after-free issue, namely, kernel crash.
> >>
> >>
> >> For issue B, i have more findings related to below commits ordered by =
time.
> >>
> >> Commit A: 7e7bbddd029b ("Bluetooth: hci_qca: Fix qca6390 enable failur=
e
> >> after warm reboot")
> >>
> >> Commit B: de8892df72be ("Bluetooth: hci_serdev: Close UART port if
> >> NON_PERSISTENT_SETUP is set")
> >> this commit introduces issue B, it is also not suitable to associate
> >> protocol state with state of lower level transport type such as serdev
> >> or uart, in my opinion, protocol state should be independent with
> >> transport type state, flag HCI_UART_PROTO_READY is for protocol state,
> >> it means if protocol hu->proto is initialized and if we can invoke its
> >> interfaces.it is common for various kinds of transport types. perhaps,
> >> this is the reason why Zijun's change doesn't use flag HCI_UART_PROTO_=
READY.
> >
> > Don't really follow you here, if HCI_UART_PROTO_READY indicates the
> > protocol state they is even _more_ important to use before invoking
> > serdev APIs, so checking for the quirk sound like a problem because:
> >
> > [1] hci_uart_close
> >      /* When QUIRK HCI_QUIRK_NON_PERSISTENT_SETUP is set by driver,
> >      * BT SOC is completely powered OFF during BT OFF, holding port
> >      * open may drain the battery.
> >      */
> >     if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
> >         clear_bit(HCI_UART_PROTO_READY, &hu->flags);
> >         serdev_device_close(hu->serdev);
> >     }
> >
> > [2] hci_uart_unregister_device
> >     if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
> >         clear_bit(HCI_UART_PROTO_READY, &hu->flags);
> >         serdev_device_close(hu->serdev);
> >     }
> >both case 1 and case 2 were introduced by Commit B in question which
> uses protocol state flag HCI_UART_PROTO_READY to track lower level
> transport type state, i don't think it is perfect.
>
> for common files hci_serdev.c and hci_ldisc.c, as you saw, the purpose
> of checking HCI_UART_PROTO_READY is to call protocol relevant
> interfaces, moreover, these protocol relevant interfaces do not deal
> with lower transport state. you maybe even notice below present function
> within which lower level serdev is flushed before HCI_UART_PROTO_READY
> is checked:
>
> static int hci_uart_flush(struct hci_dev *hdev)
> {
> ......
>         /* Flush any pending characters in the driver and discipline. */
>         serdev_device_write_flush(hu->serdev);
>
>         if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
>                 hu->proto->flush(hu);
>
>         return 0;
> }
>
> in my opinion, that is why qca_serdev_shutdown() does not check
> HCI_UART_PROTO_READY for later lower level serdev operations.
> > So only in case 1 checking the quirk is equivalent to
> > HCI_UART_PROTO_READY on case 2 it does actually check the quirk and
> > will proceed to call serdev_device_close, now perhaps the code is
> > assuming that shutdown won't be called after that, but it looks it
> > does since:
> >
> qca_serdev_shutdown() will never be called after case 2 as explained
> in the end.
> > static void serdev_drv_remove(struct device *dev)
> > {
> >     const struct serdev_device_driver *sdrv =3D
> > to_serdev_device_driver(dev->driver);
> >     if (sdrv->remove)
> >         sdrv->remove(to_serdev_device(dev));
> >
> >     dev_pm_domain_detach(dev, true);
> > }
> >
> > dev_pm_domain_detach says it will power off so I assume that means
> > that shutdown will be called _after_ remove, so not I'm not really
> > convinced that we can avoid using HCI_UART_PROTO_READY, in fact the
> > following sequence might always be triggering:
> >
> dev_pm_domain_detach() should be irrelevant with qca_serdev_shutdown(),
> should not trigger call of qca_serdev_shutdown() as explained in the end
> > serdev_drv_remove -> qca_serdev_remove -> hci_uart_unregister_device
> > -> serdev_device_close -> qca_close -> kfree(qca)
> > dev_pm_domain_detach -> ??? -> qca_serdev_shutdown
> >
> > If this sequence is correct then qca_serdev_shutdown accessing
> > qca_data will always result in a UAF problem.
> >
> above sequence should not correct as explained below.
>
> serdev and its driver should also follow below generic device and driver
> design.
>
> 1)
> driver->shutdown() will be called during shut-down time at this time
> driver->remove() should not have been called.
>
> 2)
> driver->shutdown() is impossible to be called once driver->remove()
> was called.
>
> 3) for serdev, driver->remove() does not trigger call of
> driver->shutdown() since PM relevant poweroff is irrelevant with
> driver->shutdown() and i also don't find any PM relevant interfaces will
> call driver->shutdown().
>
> i would like to explain issue B based on comments Zijun posted by public
> as below:
>
> issue B actually happens during reboot and let me look at these steps
> boot -> enable BT -> disable BT -> reboot.
>
> 1) step boot will call driver->probe() to register hdev and the serdev
> is opened after boot.
>
> 2) step enable will call hdev->open() and the serdev will still in open
> state
>
> 3) step disable will call hdev->close() and the serdev will be closed
> after hdev->close() for machine with config which results in
> HCI_QUIRK_NON_PERSISTENT_SETUP is set.
>
> 4) step reboot will call qca_serdev_shutdown() which will flush and
> write the serdev which are closed by above step disable, so cause the
> UAF issue, namely, kernel crash issue.
>
> so this issue is caused by commit B which close the serdev during
> hdev->close().
>
> driver->remove() even is not triggered during above steps.
> >> Commit C: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on
> >> closed serdev")
> >> this commit is to fix issue B which is actually caused by Commit B, bu=
t
> >> it has Fixes tag for Commit A. and it also introduces the regression
> >> issue A.
> >>
> >
> >

Reading again the commit message for the UAF fix it sounds like a
different problem:

    The driver shutdown callback (which sends EDL_SOC_RESET to the device
    over serdev) should not be invoked when HCI device is not open (e.g. if
    hci_dev_open_sync() failed), because the serdev and its TTY are not ope=
n
    either.  Also skip this step if device is powered off
    (qca_power_shutdown()).

So if hci_dev_open_sync has failed it says serdev and its TTY will not
be open either, so I guess that's why HCI_SETUP was added as a
condition to bail out? So it seems correct to do that although I'd
change the comments.

@Krzysztof Kozlowski do you still have a test setup for 272970be3dab
("Bluetooth: hci_qca: Fix driver shutdown on closed serdev"), can you
try with these changes?

--=20
Luiz Augusto von Dentz

