Return-Path: <stable+bounces-43041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 328518BB5B1
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 23:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3CA01F23B8D
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 21:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49C958ACC;
	Fri,  3 May 2024 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iza8JZqn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F291E4B2;
	Fri,  3 May 2024 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771553; cv=none; b=iQbsOWqRyifKiCLqUkKXf7Dz6FPmhd22w4213aBL6auS5EJ5nwj2OXi/ev4Vj9iEQU240b/wBKPx7HEykpEOekio5Dy5EegYry4aAWJ/kfaWC50ABFDx3LzLYfQIYGw8BJKRJjerJLvFOgXJC8epEQeR+V74rvfW6rtZ6yFkflI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771553; c=relaxed/simple;
	bh=WXWeP4ev853dPKexyhkyVzoZ012ZID3voS2FDqNJ3N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxJ/8clZLH04y3ov3OY1ZlY0EwTCM+VIBFaxHvgfP+4hzVCPGo4DYwGlzFP5z4wjrEuG3tAzS+KqJ9SVZhUupAap7Nht4G+qU94goipOASMIGbfD+t7mnncKKKexCZiUOwy7CzBy7GGfFheYXf7BUyuOJARI8J7QFXjOGQ7Tz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iza8JZqn; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5f80aa2d4a3so93338a12.0;
        Fri, 03 May 2024 14:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714771551; x=1715376351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGCAEBsx5sU0GBNY/c0fxAm283aZKfn55STI4WKiXnk=;
        b=iza8JZqn0BELaBKd8Qp1fnWt5yB5xwGqCQxKCfa5hLk3jiByL33XcFdoJBr+1dsY2x
         8eYcfYcXUmFiacizwi4cXAcOPkmengx3Nddv5Gj+FZcp1YbCHy8DrNO7BCFR0HdMVYyN
         RvTqjK2uOwycqgYSL8g7Lb3Gps4oX4plgyBiHgI8uHznPZWBscpaSCsOiMiycBBc6/54
         c2tLFMdu7Vw8ehT+91uvPD98TH98cUvm/FB5cvASuDfBlPqwD2DFvQkJ0JBjnLi/41eF
         TZEDbv8Vql85JBQcimQiwuCWeHWFPzL+g1rsi42+I/4z68aWjkvMjL3z4jAjnTTn4cCo
         +1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714771551; x=1715376351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGCAEBsx5sU0GBNY/c0fxAm283aZKfn55STI4WKiXnk=;
        b=Wie1ZIyijDOLlzEMm46uSZvJeudlVJDMQ0cJkeA5ZpYt9KhzLcWLA9xPwLqn3txsYr
         gKfWE3rU2fuU/JsNE0jXfrnso6QHMvb+DsqGj8/DXPMAvg5PTdrosfSaiC+l5GAtZv4l
         Pa2xv2MGr5eTQLGo46dvg7fg8QRbAhyFD/kbmcdHy9NRWduCN9tvmjqBrhdx1oTRe2k3
         dQPjQ1QMGWAWIaCePEZOXYyVlgSviWd7SiMygeZpPgtSe/mDNw86vMXnbURA1F5cixLt
         t2iZ2qjs0KVJt6pbrYUoMU3leVZIIaIScs9hoh7b3Tbd7QIzqLkyWOxf4capaEoWMJmB
         D07A==
X-Forwarded-Encrypted: i=1; AJvYcCWc8gUsD/1HTxFT3U0b556/k4/jsnpcGBDiiqmdyS4DYQMdH1ahZDAwFJl8zINi8F45v2LY8bZHMjiG7Rc+DSST9ITcSw7IHffoicDJF42SB8svO5xqsd0cciHuvmOBTAAeEV6UNeah
X-Gm-Message-State: AOJu0YzaRPih6dnRbFSaAhnq0idp2JFIuIohBt+tumceggeZDtbpSMdR
	53hmRjKgkze8lY9lr0yCJLBGOeeAbj2Ep89KXOqagKYgrgd4dx8ua4AOOvJjQqCzaTXqNQiNqJa
	lY6Ak2bq4nQ/4reVs+IAkGj/BHeaMu05M
X-Google-Smtp-Source: AGHT+IG6GFpeVnbtIbUiMOsU/jaXewm8efNjRxPYXu++O7uoi9t6Qv3dQcR3z5GKeSiZrZ8ukt+lmp0FjRRDUU7QRJg=
X-Received: by 2002:a17:90b:1992:b0:2a0:215f:dc9c with SMTP id
 mv18-20020a17090b199200b002a0215fdc9cmr3948824pjb.35.1714771551417; Fri, 03
 May 2024 14:25:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1714658761-15326-1-git-send-email-quic_zijuhu@quicinc.com>
 <CABBYNZJc=Pzt02f0L3KOSLqkJ+2SwO=OZibA=0S0T3vKPDwPyw@mail.gmail.com> <c5998fbd-bd63-4f7d-8f51-3dd081913449@quicinc.com>
In-Reply-To: <c5998fbd-bd63-4f7d-8f51-3dd081913449@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 3 May 2024 17:25:36 -0400
Message-ID: <CABBYNZJOVnBShpgbWEpFBcu_MnHW+TKLndLKnZkkB9C71EfJNA@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: qca: Fix BT enable failure again for
 QCA6390 after warm reboot
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: luiz.von.dentz@intel.com, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, wt@penguintechs.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 3, 2024 at 4:18=E2=80=AFPM quic_zijuhu <quic_zijuhu@quicinc.com=
> wrote:
>
> On 5/4/2024 3:22 AM, Luiz Augusto von Dentz wrote:
> > Hi Zijun,
> >
> > On Thu, May 2, 2024 at 10:06=E2=80=AFAM Zijun Hu <quic_zijuhu@quicinc.c=
om> wrote:
> >>
> >> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on close=
d
> >> serdev") will cause below regression issue:
> >>
> >> BT can't be enabled after below steps:
> >> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failu=
re
> >> if property enable-gpios is not configured within DT|ACPI for QCA6390.
> >>
> >> The commit is to fix a use-after-free issue within qca_serdev_shutdown=
()
> >> during reboot, but also introduces this regression issue regarding abo=
ve
> >> steps since the VSC is not sent to reset controller during warm reboot=
.
> >>
> >> Fixed by sending the VSC to reset controller within qca_serdev_shutdow=
n()
> >> once BT was ever enabled, and the use-after-free issue is also be fixe=
d
> >> by this change since serdev is still opened when send to serdev.
> >>
> >> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on close=
d serdev")
> >> Cc: stable@vger.kernel.org
> >> Reported-by: Wren Turkal <wt@penguintechs.org>
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218726
> >> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >> Tested-by: Wren Turkal <wt@penguintechs.org>
> >> ---
> >>  drivers/bluetooth/hci_qca.c | 5 ++---
> >>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> >> index 0c9c9ee56592..8e35c9091486 100644
> >> --- a/drivers/bluetooth/hci_qca.c
> >> +++ b/drivers/bluetooth/hci_qca.c
> >> @@ -2450,13 +2450,12 @@ static void qca_serdev_shutdown(struct device =
*dev)
> >>         struct qca_serdev *qcadev =3D serdev_device_get_drvdata(serdev=
);
> >>         struct hci_uart *hu =3D &qcadev->serdev_hu;
> >>         struct hci_dev *hdev =3D hu->hdev;
> >> -       struct qca_data *qca =3D hu->priv;
> >>         const u8 ibs_wake_cmd[] =3D { 0xFD };
> >>         const u8 edl_reset_soc_cmd[] =3D { 0x01, 0x00, 0xFC, 0x01, 0x0=
5 };
> >>
> >>         if (qcadev->btsoc_type =3D=3D QCA_QCA6390) {
> >> -               if (test_bit(QCA_BT_OFF, &qca->flags) ||
> >> -                   !test_bit(HCI_RUNNING, &hdev->flags))
> >
> > This probably deserves a comment on why you end up with
> > HCI_QUIRK_NON_PERSISTENT_SETUP and HCI_SETUP flags here, also why you
> > are removing the flags above since that was introduce to prevent
> > use-after-free this sort of revert it so I do wonder how serdev can
> > still be open if you haven't tested for QCA_BT_OFF for example?
> >
> okay, let me give comments at next version.
> this design logic is shown below. you maybe review it.
>
> if HCI_QUIRK_NON_PERSISTENT_SETUP is set, it means that hdev->setup()
> is able to be invoked by every open() to initializate SoC without any
> help. so we don't need to send the VSC to reset SoC into initial and
> clean state for the next hdev->setup() call success.
>
> otherwise, namely, HCI_QUIRK_NON_PERSISTENT_SETUP is not set.
>
> if HCI_SETUP is set, it means hdev->setup() was never be invoked, so the
> SOC is already in the initial and clean state, so we also don't need to
> send the VSC to reset SOC.
>
> otherwise, we need to send the VSC to reset Soc into a initial and clean
> state for hdev->setup() call success after "warm reboot -> enable BT"
>
> for the case commit message cares about, the only factor which decide to
> send the VSC is that SoC is a initial and clean state or not after warm
> reboot, any other factors are irrelevant to this decision.
>
> why the serdev is still open after go through
> (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)
> || hci_dev_test_flag(hdev, HCI_SETUP) checking is that
> serdev is not closed by hci_uart_close().

Sounds like a logical jump to me, in fact hci_uart_close doesn't
really change any of those flags, beside these flags are not really
meant to tell the driver if serdev_device_close has been called or not
which seems to be the intention with HCI_UART_PROTO_READY so how about
we use that instead?

Another thing that is troubling me is that having traffic on shutdown
is not common, specially if you are going to reboot, etc, and even if
it doesn't get power cycle why don't you reset on probe rather than
shutdown? That way we don't have to depend on what has been done in a
previous boot, which can really become a problem in case of multi-OS
where you have another system that may not be doing what you expect.

> see hci_uart_close() within drivers/bluetooth/hci_serdev.c
> static int hci_uart_close(struct hci_dev *hdev)
> {
> ......
>         /* When QUIRK HCI_QUIRK_NON_PERSISTENT_SETUP is set by driver,
>          * BT SOC is completely powered OFF during BT OFF, holding port
>          * open may drain the battery.
>          */
>         if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
>                 clear_bit(HCI_UART_PROTO_READY, &hu->flags);
>                 serdev_device_close(hu->serdev);
>         }
>
>         return 0;
> }
>
> >> +               if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->qu=
irks) ||
> >> +                   hci_dev_test_flag(hdev, HCI_SETUP))
> >>                         return;
> >>
> >>                 serdev_device_write_flush(serdev);
> >> --
> >> 2.7.4
> >>
> >
> >
>


--=20
Luiz Augusto von Dentz

