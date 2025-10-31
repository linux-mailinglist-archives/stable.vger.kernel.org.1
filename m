Return-Path: <stable+bounces-191938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22571C25D01
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 16:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E7D74F79ED
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 15:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA9129B77E;
	Fri, 31 Oct 2025 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUQI39Pu"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B237192B84
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923899; cv=none; b=WRP2nrSMJp6CDFk6OUtfE15/BqceN/WM/0elD083gIUlYXWQ9DpBNlVZwkwmGWUEIdG3R/WaGHTRHZDT+gFI3/fcP1IkHJq8Fq+zqjwh2UQC2hIdWbFrnvumSlmnAxLLtEXEMgzOnUG7czD5GvrTwRAVw+b1SMBoA4Vqz+5RytQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923899; c=relaxed/simple;
	bh=On3cALU8nBb0+4ieggXOsWPvMWQU83j2ni/F0KAU+8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AC80f9BUk4vg8N1U/YCmBiqvYpb6PpX1xjMiYAWLGkYTRajatkX7gdDQzYkdMjZ6GEafExlyM11LWluQmbffQr+1CW5tPnV4+oDJxe9sz+ZVn5BW6Z25jDj/4XTRhbD7r4PCjL8F4vo/doiVfDmsUoODRVzcYEqTbITPn4jMLwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUQI39Pu; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-378e0f355b9so22900431fa.0
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 08:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761923895; x=1762528695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWTZKkOkYcn9N/iXeT7lTpb6wx5Kgm29lLrZZWz6S0Y=;
        b=NUQI39PutpnQtcrVBQp3FC3sNqrkkV7ZC8PAzdjeWSW8gfiVVE3+EiLjGsssBFCjws
         LXnO8PNgfkuqWzFGVKbeRJNYFT11TqWxdk0M8UG6MKeV7Og+6X2JYcSp8Bhx7WnCBBx7
         wV2gkxe7ZfAwsopmHY4JP34khkX8W38eFFIh1L/fBb95oV/WA6Lq7aNPZ7/RszRfh6Hb
         47pxXkqCistkPkkcAgZg+QVeL51px149xmU9DWYCm41+ZdAtUkfRtY047mv/hPgftfTd
         5qtZ1eUXuGPG1wQExkKtFega/oWWB9SDKmZlIdqY18RoNyRbufXpOnxfL+Srb0LjUEKF
         +lJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761923895; x=1762528695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWTZKkOkYcn9N/iXeT7lTpb6wx5Kgm29lLrZZWz6S0Y=;
        b=PVKivRKg5PCfKScYULNwzXe0SbhF1vu/Lv7UaPEnCS5KqmF5RRJxHbanHe+L+uoKzY
         bVWqowk5AHG+m46OSz68f1RYmFiVP7Na+wg4kwvb/A1NOBvjVB2FJnQ7HtfdU3V3++Be
         3/BCkaNJLKaEkAtH3IwunTmBa/cazhXRBZxK+N/b17pbeqc63BY79omUdyN7K5ast6Eh
         Pv7mT/c0qLyNqAFCp+aysI8XH6F7dQRF5OXztaTig0iBroFaafFwHkhLGmVLlUrg0NCT
         cKGEYPbUjhBGll8V6GYErv4dCirsBCJxziroEbylEOhBiu8wsUdP2eXpW6LRpccUQxvn
         2aTA==
X-Forwarded-Encrypted: i=1; AJvYcCX+eLg7yoIHKuJzU/pdVotcnS0BBuXRwl2GG5Vbw/ZXog8CwWF0XTtaCy7eJZ4Ysdi7ehj3HE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ypXVLVEQcJbb/U/aoRTJrMuD7ZuPD5T/2WOj4NwuSm5jQ9JI
	2G6Vun9GAtTY6HplxE1Lyk780iv/FVFjCDby3+JDQddwsADhAXWRqKcD2099o8rdm9WlvhOXvyR
	p5iBjT3cRxGscjrlZnZsB+UUcaEjT9U+8dSno
X-Gm-Gg: ASbGncvQLCnmU0UF8TStDz8C+gQ7zGwRVts9Asa/b19PZlP4Qa+gsmddOE6OoyvVc/x
	5sanDJCjZGpTv06rzNyHCohl6C+EkWg7Ia0paiD+utpe1Z2rFIT2P7U8JfqTZ32NBta1EEXMqS/
	G73EUtXqrJaq2d0js9u4HfPUf5iqDZ4j7Xc734FeZvZeEnlN5LTstSdNjRfLwRIEoo7o8hX3i6A
	mpoG2eaYNNn36veAWyxLcBGBfo3sBlxqGrDu9L7fao4EBRJrM0jwrMOiM+uB1nRwBt/aQ==
X-Google-Smtp-Source: AGHT+IHhCyX5WgD/BnEfxs9+rDfxqdatiMXwvRpqYTj0+QM5LEWR/Zg4MlR9SQpm0sfZglZhrIAAIz4nl5FkspVBkEw=
X-Received: by 2002:a05:651c:2209:b0:336:9232:fb91 with SMTP id
 38308e7fff4ca-37a18d84e13mr14682981fa.4.1761923894307; Fri, 31 Oct 2025
 08:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029022955.827475-1-quic_shuaz@quicinc.com> <20251029022955.827475-2-quic_shuaz@quicinc.com>
In-Reply-To: <20251029022955.827475-2-quic_shuaz@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 31 Oct 2025 11:18:02 -0400
X-Gm-Features: AWmQ_bnmEoXSHQbwofIVHDVHm8UazbPDGWMN_lWJ04lJ7qFjiRa0BctPyX2rqPk
Message-ID: <CABBYNZKh5_Ed0Jm-rjpPZKEf26zo3Lz-ZZrEKAJJWkZWQy3o7Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Bluetooth: btusb: add default nvm file
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: dmitry.baryshkov@oss.qualcomm.com, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, stable@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_chejiang@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 28, 2025 at 10:30=E2=80=AFPM Shuai Zhang <quic_shuaz@quicinc.co=
m> wrote:
>
> If no NVM file matches the board_id, load the default NVM file.
>
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/bluetooth/btusb.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index dcbff7641..6903606d3 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3482,15 +3482,14 @@ static int btusb_setup_qca_load_rampatch(struct h=
ci_dev *hdev,
>  }
>
>  static void btusb_generate_qca_nvm_name(char *fwname, size_t max_size,
> -                                       const struct qca_version *ver)
> +                                       const struct qca_version *ver,
> +                                       u16 board_id)
>  {
>         u32 rom_version =3D le32_to_cpu(ver->rom_version);
>         const char *variant, *fw_subdir;
>         int len;
> -       u16 board_id;
>
>         fw_subdir =3D qca_get_fw_subdirectory(ver);
> -       board_id =3D qca_extract_board_id(ver);
>
>         switch (le32_to_cpu(ver->ram_version)) {
>         case WCN6855_2_0_RAM_VERSION_GF:
> @@ -3522,14 +3521,28 @@ static int btusb_setup_qca_load_nvm(struct hci_de=
v *hdev,
>         const struct firmware *fw;
>         char fwname[80];
>         int err;
> +       u16 board_id =3D 0;
>
> -       btusb_generate_qca_nvm_name(fwname, sizeof(fwname), ver);
> +       board_id =3D qca_extract_board_id(ver);
>
> +retry:
> +       btusb_generate_qca_nvm_name(fwname, sizeof(fwname), ver, board_id=
);
>         err =3D request_firmware(&fw, fwname, &hdev->dev);
>         if (err) {
> +               if (err =3D=3D -EINVAL) {
> +                       bt_dev_err(hdev, "QCOM BT firmware file request f=
ailed (%d)", err);
> +                       return err;
> +               }
> +
>                 bt_dev_err(hdev, "failed to request NVM file: %s (%d)",
>                            fwname, err);
> -               return err;
> +               if (err =3D=3D -ENOENT && board_id !=3D 0) {
> +                       board_id =3D 0;
> +                       goto retry;

goto backwards is asking for trouble, just split the required code
into its own function and then call it again with board set to 0.

> +               } else {
> +                       bt_dev_err(hdev, "QCOM BT firmware file request f=
ailed (%d)", err);
> +                       return err;
> +               }
>         }
>
>         bt_dev_info(hdev, "using NVM file: %s", fwname);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz

