Return-Path: <stable+bounces-45306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7438C79E6
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 17:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143BA1C212E3
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 15:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CC414D431;
	Thu, 16 May 2024 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH0rw4ZE"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171E314D433;
	Thu, 16 May 2024 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874958; cv=none; b=PtchZHNivoBAKSGHPeQaWfYnHx9YKObjaUm1ArdEk7ODj4RgPQtc9Mg03wYrcjathyQhn2zgVq709NCRbza0SHf5u9d6AhaxfJNNXg5zMv5aJ4wFAHi244zbkhzRSA8NWrJNFNdJYsnlzzv9xAUdLBxQAL4l2+2RdOw5jqqBCCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874958; c=relaxed/simple;
	bh=GotmUVvg3yCA1K/0AUhNy3lVYojERI0YjVqh8CZv7+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9VqC2sUTegxi3EWTRPPKkYhB+QziU5b8UEsFdH7Dvd3VqsJixoTfyhPFYQWBGXoiN1lt5UgjPud47O2g+melUaYAvzrAL3sCtSolOsBHuVxYT9Udg7J8meOnzXC8m9g3qatCMZ/gjxDvzZywKegsihkZH/+ui7LpISq7AKnGGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH0rw4ZE; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e538a264e0so12590191fa.1;
        Thu, 16 May 2024 08:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715874955; x=1716479755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X51fSppkpogm5g68VevzSjdTrmvDiJaepwBpjEkIupc=;
        b=mH0rw4ZE8DYaBErseHsfNcfGV7lsSzzcWmM95sDTocg9bUa/KC0tcvFkuNU7GpFQdO
         9abnf8YUuVcYRDKLK+hPg9PsFcgf7Bt1EzRRDtEODzgO1JlBLPB7L31MJ0DGVP/nymh+
         e5R3n/kDBbTJ5z80f0v5KCXHiYT7euwb57I6ClHMtkjTCT/NrvrcLtVZ4smlOfqVqePJ
         T76ON7MJDMQDmFuvl8HWfJGsz9PCvxrYfM9l3RgmFo0ZxMLOl9XRPk+1BWhGOC8Iov7L
         ucQoRBsjiPpQVZc7ZMWLZG6OJ72DAq88362Dbhxkog3aWs02WMZLuJq514ah7BMBTNKB
         ufSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874955; x=1716479755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X51fSppkpogm5g68VevzSjdTrmvDiJaepwBpjEkIupc=;
        b=JMzXzset/mxUJ+ZbGJ0PJ9+bPEmt3pD17oySEXMc+QuG80VyKW79HJYZETtOdBJiBt
         q87SM2FUJRZg9l+2wcDx4Rz4/xgR2QQ0fevC7nMWT86EuRiXhvkY0S+2CJSPJbszgDd6
         Ev8vNs8SMcpOX0rAS4FXBrQNZnKqXQhUEDPkyAFJhXgNXU67IkwzBI4dNaueByPb8xAl
         bODekKky0g/GPZb88GUB3S3zNlK89RHsK0mPtf187OwkpGNFxnevibULdstI6u7PYFzy
         Y032lc+P/xUQzGYArqY95LauFyE5vOmKjtJNGo9zTE6HIg66Oyc8voFQa5hzazbGArBH
         vCsg==
X-Forwarded-Encrypted: i=1; AJvYcCXZYoixWEIyaOW3Plg98DE7QqGPrAPlACGa5Lk9EJE8JVXCuH6pqza9TPXyXB71IwwsWIzk42BQ6ZxMDhrHq+9mxXoayc6VeFIxuy8JK/IiGZMCqbg9GSwmGUgg0VHpKqUYsagtskaK
X-Gm-Message-State: AOJu0Yyb87uTg/50dTzpDOrNfw7MD/Fqe2+PbFMgFe1fPIAL2qRAVueA
	tuzh5IBVfeencB1pVueGckGhwFV5V0HvybT9I8v16irqWnf8gSmDAQ7iLKLWn2BbKp/vbJWg8/U
	oJVoaLw2e7fJXtW/EWcwV8JaYiT0+RJEq
X-Google-Smtp-Source: AGHT+IEFeaCtLRNo5VoiulyvOQ9u5fQIcZftbw9jZKZ2+uGwIk1yQQuY5A0kQEIrPVM/0MW0dIOTQUmRUckvz++9TIM=
X-Received: by 2002:a2e:9657:0:b0:2e6:f57a:9854 with SMTP id
 38308e7fff4ca-2e6f57aa0afmr56199111fa.38.1715874954817; Thu, 16 May 2024
 08:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com> <f343ecae-efee-4bdc-ac38-89b614e081b5@163.com>
In-Reply-To: <f343ecae-efee-4bdc-ac38-89b614e081b5@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 16 May 2024 11:55:42 -0400
Message-ID: <CABBYNZ+nLgozYxL=znsXrg0qoz-ENgSBwcPzY-KrBnVJJut8Kw@mail.gmail.com>
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

On Thu, May 16, 2024 at 10:57=E2=80=AFAM Lk Sii <lk_sii@163.com> wrote:
>
>
>
> On 2024/5/16 21:31, Zijun Hu wrote:
> > Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
> > serdev") will cause below regression issue:
> >
> > BT can't be enabled after below steps:
> > cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failur=
e
> > if property enable-gpios is not configured within DT|ACPI for QCA6390.
> >
> > The commit is to fix a use-after-free issue within qca_serdev_shutdown(=
)
> > by adding condition to avoid the serdev is flushed or wrote after close=
d
> > but also introduces this regression issue regarding above steps since t=
he
> > VSC is not sent to reset controller during warm reboot.
> >
> > Fixed by sending the VSC to reset controller within qca_serdev_shutdown=
()
> > once BT was ever enabled, and the use-after-free issue is also fixed by
> > this change since the serdev is still opened before it is flushed or wr=
ote.
> >
> > Verified by the reported machine Dell XPS 13 9310 laptop over below two
> > kernel commits:
> > commit e00fc2700a3f ("Bluetooth: btusb: Fix triggering coredump
> > implementation for QCA") of bluetooth-next tree.
> > commit b23d98d46d28 ("Bluetooth: btusb: Fix triggering coredump
> > implementation for QCA") of linus mainline tree.
> >
> > Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed=
 serdev")
> > Cc: stable@vger.kernel.org
> > Reported-by: Wren Turkal <wt@penguintechs.org>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218726
> > Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> > Tested-by: Wren Turkal <wt@penguintechs.org>
> > ---
> > V1 -> V2: Add comments and more commit messages
> >
> > V1 discussion link:
> > https://lore.kernel.org/linux-bluetooth/d553edef-c1a4-4d52-a892-715549d=
31ebe@163.com/T/#t
> >
> >  drivers/bluetooth/hci_qca.c | 18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index 0c9c9ee56592..9a0bc86f9aac 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -2450,15 +2450,27 @@ static void qca_serdev_shutdown(struct device *=
dev)
> >       struct qca_serdev *qcadev =3D serdev_device_get_drvdata(serdev);
> >       struct hci_uart *hu =3D &qcadev->serdev_hu;
> >       struct hci_dev *hdev =3D hu->hdev;
> > -     struct qca_data *qca =3D hu->priv;
> >       const u8 ibs_wake_cmd[] =3D { 0xFD };
> >       const u8 edl_reset_soc_cmd[] =3D { 0x01, 0x00, 0xFC, 0x01, 0x05 }=
;
> >
> >       if (qcadev->btsoc_type =3D=3D QCA_QCA6390) {
> > -             if (test_bit(QCA_BT_OFF, &qca->flags) ||
> > -                 !test_bit(HCI_RUNNING, &hdev->flags))
> > +             /* The purpose of sending the VSC is to reset SOC into a =
initial
> > +              * state and the state will ensure next hdev->setup() suc=
cess.
> > +              * if HCI_QUIRK_NON_PERSISTENT_SETUP is set, it means tha=
t
> > +              * hdev->setup() can do its job regardless of SoC state, =
so
> > +              * don't need to send the VSC.
> > +              * if HCI_SETUP is set, it means that hdev->setup() was n=
ever
> > +              * invoked and the SOC is already in the initial state, s=
o
> > +              * don't also need to send the VSC.
> > +              */
> > +             if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirk=
s) ||
> > +                 hci_dev_test_flag(hdev, HCI_SETUP))
> >                       return;
> >
> > +             /* The serdev must be in open state when conrol logic arr=
ives
> > +              * here, so also fix the use-after-free issue caused by t=
hat
> > +              * the serdev is flushed or wrote after it is closed.
> > +              */
> >               serdev_device_write_flush(serdev);
> >               ret =3D serdev_device_write_buf(serdev, ibs_wake_cmd,
> >                                             sizeof(ibs_wake_cmd));
> i believe Zijun's change is able to fix both below issues and don't
> introduce new issue.
>
> regression issue A:  BT enable failure after warm reboot.
> issue B:  use-after-free issue, namely, kernel crash.
>
>
> For issue B, i have more findings related to below commits ordered by tim=
e.
>
> Commit A: 7e7bbddd029b ("Bluetooth: hci_qca: Fix qca6390 enable failure
> after warm reboot")
>
> Commit B: de8892df72be ("Bluetooth: hci_serdev: Close UART port if
> NON_PERSISTENT_SETUP is set")
> this commit introduces issue B, it is also not suitable to associate
> protocol state with state of lower level transport type such as serdev
> or uart, in my opinion, protocol state should be independent with
> transport type state, flag HCI_UART_PROTO_READY is for protocol state,
> it means if protocol hu->proto is initialized and if we can invoke its
> interfaces.it is common for various kinds of transport types. perhaps,
> this is the reason why Zijun's change doesn't use flag HCI_UART_PROTO_REA=
DY.

Don't really follow you here, if HCI_UART_PROTO_READY indicates the
protocol state they is even _more_ important to use before invoking
serdev APIs, so checking for the quirk sound like a problem because:

[1] hci_uart_close
     /* When QUIRK HCI_QUIRK_NON_PERSISTENT_SETUP is set by driver,
     * BT SOC is completely powered OFF during BT OFF, holding port
     * open may drain the battery.
     */
    if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
        clear_bit(HCI_UART_PROTO_READY, &hu->flags);
        serdev_device_close(hu->serdev);
    }

[2] hci_uart_unregister_device
    if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
        clear_bit(HCI_UART_PROTO_READY, &hu->flags);
        serdev_device_close(hu->serdev);
    }

So only in case 1 checking the quirk is equivalent to
HCI_UART_PROTO_READY on case 2 it does actually check the quirk and
will proceed to call serdev_device_close, now perhaps the code is
assuming that shutdown won't be called after that, but it looks it
does since:

static void serdev_drv_remove(struct device *dev)
{
    const struct serdev_device_driver *sdrv =3D
to_serdev_device_driver(dev->driver);
    if (sdrv->remove)
        sdrv->remove(to_serdev_device(dev));

    dev_pm_domain_detach(dev, true);
}

dev_pm_domain_detach says it will power off so I assume that means
that shutdown will be called _after_ remove, so not I'm not really
convinced that we can avoid using HCI_UART_PROTO_READY, in fact the
following sequence might always be triggering:

serdev_drv_remove -> qca_serdev_remove -> hci_uart_unregister_device
-> serdev_device_close -> qca_close -> kfree(qca)
dev_pm_domain_detach -> ??? -> qca_serdev_shutdown

If this sequence is correct then qca_serdev_shutdown accessing
qca_data will always result in a UAF problem.

> Commit C: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on
> closed serdev")
> this commit is to fix issue B which is actually caused by Commit B, but
> it has Fixes tag for Commit A. and it also introduces the regression
> issue A.
>


--=20
Luiz Augusto von Dentz

