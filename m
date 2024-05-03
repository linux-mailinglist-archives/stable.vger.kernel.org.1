Return-Path: <stable+bounces-43033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1FD8BB3DB
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 21:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10558281401
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 19:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D8D1586C2;
	Fri,  3 May 2024 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODHATBk8"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DAC12EBC9;
	Fri,  3 May 2024 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764142; cv=none; b=NtAx0t60tecDxW4VombPMcBJQ7rcLBCEPCEv2uMhmVke+fc4io/Htfr75ZqHWjsSkShX/usGxa9ZesEbjsoWwsVpKnuhxmUUu8dDW4Ug865pTaqe0LOKGRt8d5c183I1bNw7YYmKc8XRGWvd8muw0ZscWY9DjXW8sasOZTQNAJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764142; c=relaxed/simple;
	bh=1RqUL/IAtVDsbNvDGXYbqVXX9t1cfymUmQpyF2IDRBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8hOw+44UmOqIhBI+hmY0j5YZcx8BgPsCmwNZ5r0x5CgIUR4xP7oONMwGaP9rS5ivE4SDqhCVqnr0U6aUScJ3nW6E+liu8eGOHZNq0/PGNdG04S8y+9GfavfmzbZKU2bJk72DK1nfKAmoTqQ/5DSXON2V5Ijs3AUOG7MmB49tiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODHATBk8; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e22a1bed91so477101fa.0;
        Fri, 03 May 2024 12:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714764139; x=1715368939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGx2n5yoiLSRIt71Nt2FP9+93qkzoiQNbPT3yt8Y8TQ=;
        b=ODHATBk8dwzDChzzB9AUF1JVO4YsouOYUuj6aA7cxLrPto1VOacjqb2TMgknihGz6Q
         mkyvON9vYHaYCX0rvvRaFiV27mxoVJpTV9lIT7MmT2afmYz0rm2vnBUy3jmwcTEblWDl
         GnWAwX7rGWwgBjPJ2QGxGKVtYGoxphCGhINeCuGeLgi7F+lBR8/PMs1wefNHLLJRIuYt
         gvk0omZPvaCbFMExN5XC0EmfMKmZtoowtSzkAxXkoPvZpFLE1TALUCGakscd0D+XsnWG
         gv2oaSbz3k0V0Zn1NsQpU9ykHnYXG5SVP3ClEJcFAp9gBPIZqZ41zBhdKIv3I3tTrxkz
         g5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764139; x=1715368939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGx2n5yoiLSRIt71Nt2FP9+93qkzoiQNbPT3yt8Y8TQ=;
        b=UaGWswTLEijp8N6fU2l5yDv5vAzl/ln4nlsc/jqt10/n3XzYA2xCocxOQRXwrJEzHR
         XTyP8YJ5hz1WUQhZF56RszvFtB/6rmFsC5YTMD9OA0ltd/pLgz0oUaLAcirYRgjeooQs
         ezSAEFHy7CgqBxHtl33qfrDso1CZAgzYWALIh3CSpy3gw/jdArufgiqhh1C4QH4RfYV5
         Akpv7c45swhBfN2q6uFHZV9JSD1nTZ5rqBs9VDIO85vvJO6gUXPuhSk4zHkWaSznrnn5
         lHAHMIcbeIPuh/7nWoGQaAY5irkIVmAK1XCvQFrDE9q3K69c16M4ZaY9vlzeQtftzVK3
         waKA==
X-Forwarded-Encrypted: i=1; AJvYcCXZB4MUD2TcRPTu7NkM0i13WBlXyxfja0mOOLZmCNHQ85HAj+Kp14Nz3t+a6ZE68u9A06ODC3C/i3lmG2R6CyCSJz1UX72ZvyX1Y+A/K483u1CdcHYYBvBxYhLkEJKd28q6sYv0zne4
X-Gm-Message-State: AOJu0Yw2NqYF7st9hvKQxG5x1tUgAKazwgSPizD//aidrPbxvaD3ETrm
	B174APbhNh9ecSdPtJU31fiN7iTUuOD7Xp0nRa7hRggZr3kqhzBboCR4mCstovb0VGym+U8Fb5Q
	ZBfcNf8zyUq9PiBLB6IcGPmM0hSY=
X-Google-Smtp-Source: AGHT+IG0mJicwsO+tXDvlFh1LOx/Y/2dM/UTZxiEc7Av7UUdup4AyeP7l92N/Fp1tkLm1CwXmjSoYjx0j3kkaZZgV/o=
X-Received: by 2002:a2e:a406:0:b0:2df:eee9:c71f with SMTP id
 p6-20020a2ea406000000b002dfeee9c71fmr2451126ljn.7.1714764138823; Fri, 03 May
 2024 12:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1714658761-15326-1-git-send-email-quic_zijuhu@quicinc.com>
In-Reply-To: <1714658761-15326-1-git-send-email-quic_zijuhu@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 3 May 2024 15:22:06 -0400
Message-ID: <CABBYNZJc=Pzt02f0L3KOSLqkJ+2SwO=OZibA=0S0T3vKPDwPyw@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: qca: Fix BT enable failure again for
 QCA6390 after warm reboot
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: luiz.von.dentz@intel.com, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, wt@penguintechs.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Thu, May 2, 2024 at 10:06=E2=80=AFAM Zijun Hu <quic_zijuhu@quicinc.com> =
wrote:
>
> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
> serdev") will cause below regression issue:
>
> BT can't be enabled after below steps:
> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
> if property enable-gpios is not configured within DT|ACPI for QCA6390.
>
> The commit is to fix a use-after-free issue within qca_serdev_shutdown()
> during reboot, but also introduces this regression issue regarding above
> steps since the VSC is not sent to reset controller during warm reboot.
>
> Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
> once BT was ever enabled, and the use-after-free issue is also be fixed
> by this change since serdev is still opened when send to serdev.
>
> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed s=
erdev")
> Cc: stable@vger.kernel.org
> Reported-by: Wren Turkal <wt@penguintechs.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218726
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> Tested-by: Wren Turkal <wt@penguintechs.org>
> ---
>  drivers/bluetooth/hci_qca.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 0c9c9ee56592..8e35c9091486 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2450,13 +2450,12 @@ static void qca_serdev_shutdown(struct device *de=
v)
>         struct qca_serdev *qcadev =3D serdev_device_get_drvdata(serdev);
>         struct hci_uart *hu =3D &qcadev->serdev_hu;
>         struct hci_dev *hdev =3D hu->hdev;
> -       struct qca_data *qca =3D hu->priv;
>         const u8 ibs_wake_cmd[] =3D { 0xFD };
>         const u8 edl_reset_soc_cmd[] =3D { 0x01, 0x00, 0xFC, 0x01, 0x05 }=
;
>
>         if (qcadev->btsoc_type =3D=3D QCA_QCA6390) {
> -               if (test_bit(QCA_BT_OFF, &qca->flags) ||
> -                   !test_bit(HCI_RUNNING, &hdev->flags))

This probably deserves a comment on why you end up with
HCI_QUIRK_NON_PERSISTENT_SETUP and HCI_SETUP flags here, also why you
are removing the flags above since that was introduce to prevent
use-after-free this sort of revert it so I do wonder how serdev can
still be open if you haven't tested for QCA_BT_OFF for example?

> +               if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirk=
s) ||
> +                   hci_dev_test_flag(hdev, HCI_SETUP))
>                         return;
>
>                 serdev_device_write_flush(serdev);
> --
> 2.7.4
>


--=20
Luiz Augusto von Dentz

