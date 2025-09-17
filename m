Return-Path: <stable+bounces-180456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E031B82272
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 00:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A20585FE8
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 22:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF1130E0FD;
	Wed, 17 Sep 2025 22:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIjc/yRY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D22A55
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758148094; cv=none; b=mDhcoBJttjMLFr2fck/srdQmqWZP6ZVmAhvOffzaW8zzMVkYY5VR+9quhdAuS6Hv2J4jfviGlGaVgPPmP5UWMsbd1mxRbyM9CeP0EQKcRWH2Qy+LQKEUvcTPH30zqn8auUi9Kg3JSCosPz2AvQGHubno7MW49wlb1KSk+ak+iGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758148094; c=relaxed/simple;
	bh=JUmpkfXE/ckBh6uUpVA53yMm3XYAiKGXYp30GK8/XQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULbzbx4B4oL8K0+xT92cbJyIiNkzTvmtqklpasarnbQ4CimfyCESEVMFWxIG9TbY8NOVMaoT0mfwvckXOBvzm5vG2P3+MnYfHbspOW1Qa6SoSyXHatb/NaeVMVlQixbOGEW/JUC7rccUyFc7nfAN+2wGpMNl7PEeJK6Vjmx9J08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIjc/yRY; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so162691a91.2
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 15:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758148092; x=1758752892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88Hfxga3d3LxPeYNhn85xtDJ4XWn1qJNDdfdd5STqPw=;
        b=FIjc/yRY4LBXc3dp57UoKBFTi3YfTdgGjVCbIHZ66C0NiU7MWWH4fvmPGxjXRLDE4s
         9mUfomyQ2VGB/TLWSgLst3SBrPBFSLnL5qRKU+g1yyBZMH9A44sBycgToIC7CydLNWtp
         Ha06QN07wFt37CGOzG7kWNFtwXCvleLl+ARUoFfJZC1ol7fztaL+oLC+RFwuDkX19NVH
         cWhRVy/tm+Jfukeh2oBVrhMkSEZz2oC/o0BukbRHxD47prA4gxFrn/68OLLwbeRbail+
         cEHRS+uSXOt2dwifoDcx6OFT73ONf/FYa6e+W8lQVYg8gyaLQ7LShLcmRAu8uK6oB+Zs
         9IBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758148092; x=1758752892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88Hfxga3d3LxPeYNhn85xtDJ4XWn1qJNDdfdd5STqPw=;
        b=sJQHlGo57nd+yEZdc207drjcf8hojHJ0OKS8hgFriUegTNFdIk9aA/XHqEp3F+u/IM
         t0NJgn+D8UHZz27WwYkKVh1q+nSwZ5sWRT4ulwA46zHVC4bYgP19B5id/87GP0CvHfiP
         BVaOj92UEw4sNPPDkDHk2feVtmhiQK0FQs6oNVIZzaNy+a0Q9jsqSMz++EHy9Af06+m4
         PoeNoKoA7yh2azS7TRqIPCYpzhYlnUwwVwao3ULFyfdpoZunerhXFIglurKd2lF53USg
         dmXwIxQLvogDnCaKolsx6GohQWYrA4+NMooCDkOXIYIQg7mXgctegBAGnnOWtUdjlHkj
         e4Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXkV7pSXrYLpXqbatfi/z62tRlUQChNmeleBtn+oUCwoC93yBLxeBvuKD8zxVNY4Vzt1BnojbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6r9zGtuuyhd2jc+PujiWYusEiDCrmmnDaMU6ktYv/8UvdqpEi
	D5H/WR1QZLzvHve2qI3koOlRbeR3tOUde+tVhQTngxNKuDAY3IADQyLHbPaBpGZJuRYyclIXOCv
	J34VmTDmlw6wzRDH5M5dP3cUbkdSGSvNJlmUdCa4=
X-Gm-Gg: ASbGncsbqXlbESePLoDBdHGRZSYHI7USCTT+PGz63UgB+B/aSH+/yZCR+88hvahQuvu
	H3VLjW9PlvkSGo2sn8qXk5qFBhZDmxqadEkTStMi3RbQeA5zJORi+kmIxib9Bt31kPOBx0yGfBG
	/S5gdfWE9JCUcgd4iTQSnmWPyYMoHIsRsL4C8JRCvX8XNHhSQw4IimOFnv89hHjO0Purjeu8wL+
	5Mo48bv8PKYfhNmgrE8efk=
X-Google-Smtp-Source: AGHT+IEDwDc6isJL4dhnCo+gBgaLwDjZMIE8vgVMomCk4Y1HZMZzi470YdQATAEQ9+I5qiFrYGkw3FLRGKOsO2XoBaY=
X-Received: by 2002:a17:90b:5550:b0:330:6c04:755a with SMTP id
 98e67ed59e1d1-3306c04779bmr12761a91.12.1758148092207; Wed, 17 Sep 2025
 15:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917221641.30226-2-julian.lagattuta@gmail.com> <20250917221641.30226-4-julian.lagattuta@gmail.com>
In-Reply-To: <20250917221641.30226-4-julian.lagattuta@gmail.com>
From: Julian LaGattuta <julian.lagattuta@gmail.com>
Date: Wed, 17 Sep 2025 18:28:00 -0400
X-Gm-Features: AS18NWBzcAx5cvt8RiaUg8Ergg45OoVqrlZQHVsmG8ufYPNdLoG8Efsgvkv8okE
Message-ID: <CADuX1q+DRQMbV3Xrbpi3b8kqJX0KeQTO_g5Hh=dHnaFXZuftgw@mail.gmail.com>
Subject: Re: [PATCH 03/39] Bluetooth: L2CAP: Fix L2CAP MTU negotiation
To: julian.lagattuta@gmail.com
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>, 
	stable@vger.kernel.org, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am so sorry I was messing around with git send email and stupidly
sent a random patch that is not mine by accident. Please ignore and
forgive me.

On Wed, Sep 17, 2025 at 6:17=E2=80=AFPM julian-lagattuta
<julian.lagattuta@gmail.com> wrote:
>
> From: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
>
> OBEX download from iPhone is currently slow due to small packet size
> used to transfer data which doesn't follow the MTU negotiated during
> L2CAP connection, i.e. 672 bytes instead of 32767:
>
>   < ACL Data TX: Handle 11 flags 0x00 dlen 12
>       L2CAP: Connection Request (0x02) ident 18 len 4
>         PSM: 4103 (0x1007)
>         Source CID: 72
>   > ACL Data RX: Handle 11 flags 0x02 dlen 16
>       L2CAP: Connection Response (0x03) ident 18 len 8
>         Destination CID: 14608
>         Source CID: 72
>         Result: Connection successful (0x0000)
>         Status: No further information available (0x0000)
>   < ACL Data TX: Handle 11 flags 0x00 dlen 27
>       L2CAP: Configure Request (0x04) ident 20 len 19
>         Destination CID: 14608
>         Flags: 0x0000
>         Option: Maximum Transmission Unit (0x01) [mandatory]
>           MTU: 32767
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Enhanced Retransmission (0x03)
>           TX window size: 63
>           Max transmit: 3
>           Retransmission timeout: 2000
>           Monitor timeout: 12000
>           Maximum PDU size: 1009
>   > ACL Data RX: Handle 11 flags 0x02 dlen 26
>       L2CAP: Configure Request (0x04) ident 72 len 18
>         Destination CID: 72
>         Flags: 0x0000
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Enhanced Retransmission (0x03)
>           TX window size: 32
>           Max transmit: 255
>           Retransmission timeout: 0
>           Monitor timeout: 0
>           Maximum PDU size: 65527
>         Option: Frame Check Sequence (0x05) [mandatory]
>           FCS: 16-bit FCS (0x01)
>   < ACL Data TX: Handle 11 flags 0x00 dlen 29
>       L2CAP: Configure Response (0x05) ident 72 len 21
>         Source CID: 14608
>         Flags: 0x0000
>         Result: Success (0x0000)
>         Option: Maximum Transmission Unit (0x01) [mandatory]
>           MTU: 672
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Enhanced Retransmission (0x03)
>           TX window size: 32
>           Max transmit: 255
>           Retransmission timeout: 2000
>           Monitor timeout: 12000
>           Maximum PDU size: 1009
>   > ACL Data RX: Handle 11 flags 0x02 dlen 32
>       L2CAP: Configure Response (0x05) ident 20 len 24
>         Source CID: 72
>         Flags: 0x0000
>         Result: Success (0x0000)
>         Option: Maximum Transmission Unit (0x01) [mandatory]
>           MTU: 32767
>         Option: Retransmission and Flow Control (0x04) [mandatory]
>           Mode: Enhanced Retransmission (0x03)
>           TX window size: 63
>           Max transmit: 3
>           Retransmission timeout: 2000
>           Monitor timeout: 12000
>           Maximum PDU size: 1009
>         Option: Frame Check Sequence (0x05) [mandatory]
>           FCS: 16-bit FCS (0x01)
>   ...
>   > ACL Data RX: Handle 11 flags 0x02 dlen 680
>       Channel: 72 len 676 ctrl 0x0202 [PSM 4103 mode Enhanced Retransmiss=
ion (0x03)] {chan 8}
>       I-frame: Unsegmented TxSeq 1 ReqSeq 2
>   < ACL Data TX: Handle 11 flags 0x00 dlen 13
>       Channel: 14608 len 9 ctrl 0x0204 [PSM 4103 mode Enhanced Retransmis=
sion (0x03)] {chan 8}
>       I-frame: Unsegmented TxSeq 2 ReqSeq 2
>   > ACL Data RX: Handle 11 flags 0x02 dlen 680
>       Channel: 72 len 676 ctrl 0x0304 [PSM 4103 mode Enhanced Retransmiss=
ion (0x03)] {chan 8}
>       I-frame: Unsegmented TxSeq 2 ReqSeq 3
>
> The MTUs are negotiated for each direction. In this traces 32767 for
> iPhone->localhost and no MTU for localhost->iPhone, which based on
> '4.4 L2CAP_CONFIGURATION_REQ' (Core specification v5.4, Vol. 3, Part
> A):
>
>   The only parameters that should be included in the
>   L2CAP_CONFIGURATION_REQ packet are those that require different
>   values than the default or previously agreed values.
>   ...
>   Any missing configuration parameters are assumed to have their
>   most recently explicitly or implicitly accepted values.
>
> and '5.1 Maximum transmission unit (MTU)':
>
>   If the remote device sends a positive L2CAP_CONFIGURATION_RSP
>   packet it should include the actual MTU to be used on this channel
>   for traffic flowing into the local device.
>   ...
>   The default value is 672 octets.
>
> is set by BlueZ to 672 bytes.
>
> It seems that the iPhone used the lowest negotiated value to transfer
> data to the localhost instead of the negotiated one for the incoming
> direction.
>
> This could be fixed by using the MTU negotiated for the other
> direction, if exists, in the L2CAP_CONFIGURATION_RSP.
> This allows to use segmented packets as in the following traces:
>
>   < ACL Data TX: Handle 11 flags 0x00 dlen 12
>         L2CAP: Connection Request (0x02) ident 22 len 4
>           PSM: 4103 (0x1007)
>           Source CID: 72
>   < ACL Data TX: Handle 11 flags 0x00 dlen 27
>         L2CAP: Configure Request (0x04) ident 24 len 19
>           Destination CID: 2832
>           Flags: 0x0000
>           Option: Maximum Transmission Unit (0x01) [mandatory]
>             MTU: 32767
>           Option: Retransmission and Flow Control (0x04) [mandatory]
>             Mode: Enhanced Retransmission (0x03)
>             TX window size: 63
>             Max transmit: 3
>             Retransmission timeout: 2000
>             Monitor timeout: 12000
>             Maximum PDU size: 1009
>   > ACL Data RX: Handle 11 flags 0x02 dlen 26
>         L2CAP: Configure Request (0x04) ident 15 len 18
>           Destination CID: 72
>           Flags: 0x0000
>           Option: Retransmission and Flow Control (0x04) [mandatory]
>             Mode: Enhanced Retransmission (0x03)
>             TX window size: 32
>             Max transmit: 255
>             Retransmission timeout: 0
>             Monitor timeout: 0
>             Maximum PDU size: 65527
>           Option: Frame Check Sequence (0x05) [mandatory]
>             FCS: 16-bit FCS (0x01)
>   < ACL Data TX: Handle 11 flags 0x00 dlen 29
>         L2CAP: Configure Response (0x05) ident 15 len 21
>           Source CID: 2832
>           Flags: 0x0000
>           Result: Success (0x0000)
>           Option: Maximum Transmission Unit (0x01) [mandatory]
>             MTU: 32767
>           Option: Retransmission and Flow Control (0x04) [mandatory]
>             Mode: Enhanced Retransmission (0x03)
>             TX window size: 32
>             Max transmit: 255
>             Retransmission timeout: 2000
>             Monitor timeout: 12000
>             Maximum PDU size: 1009
>   > ACL Data RX: Handle 11 flags 0x02 dlen 32
>         L2CAP: Configure Response (0x05) ident 24 len 24
>           Source CID: 72
>           Flags: 0x0000
>           Result: Success (0x0000)
>           Option: Maximum Transmission Unit (0x01) [mandatory]
>             MTU: 32767
>           Option: Retransmission and Flow Control (0x04) [mandatory]
>             Mode: Enhanced Retransmission (0x03)
>             TX window size: 63
>             Max transmit: 3
>             Retransmission timeout: 2000
>             Monitor timeout: 12000
>             Maximum PDU size: 1009
>           Option: Frame Check Sequence (0x05) [mandatory]
>             FCS: 16-bit FCS (0x01)
>   ...
>   > ACL Data RX: Handle 11 flags 0x02 dlen 1009
>         Channel: 72 len 1005 ctrl 0x4202 [PSM 4103 mode Enhanced Retransm=
ission (0x03)] {chan 8}
>         I-frame: Start (len 21884) TxSeq 1 ReqSeq 2
>   > ACL Data RX: Handle 11 flags 0x02 dlen 1009
>         Channel: 72 len 1005 ctrl 0xc204 [PSM 4103 mode Enhanced Retransm=
ission (0x03)] {chan 8}
>         I-frame: Continuation TxSeq 2 ReqSeq 2
>
> This has been tested with kernel 5.4 and BlueZ 5.77.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/l2cap_core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index a5bde5db58ef..40daa38276f3 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3415,7 +3415,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *=
chan, void *data, size_t data
>         struct l2cap_conf_rfc rfc =3D { .mode =3D L2CAP_MODE_BASIC };
>         struct l2cap_conf_efs efs;
>         u8 remote_efs =3D 0;
> -       u16 mtu =3D L2CAP_DEFAULT_MTU;
> +       u16 mtu =3D 0;
>         u16 result =3D L2CAP_CONF_SUCCESS;
>         u16 size;
>
> @@ -3520,6 +3520,13 @@ static int l2cap_parse_conf_req(struct l2cap_chan =
*chan, void *data, size_t data
>                 /* Configure output options and let the other side know
>                  * which ones we don't like. */
>
> +               /* If MTU is not provided in configure request, use the m=
ost recently
> +                * explicitly or implicitly accepted value for the other =
direction,
> +                * or the default value.
> +                */
> +               if (mtu =3D=3D 0)
> +                       mtu =3D chan->imtu ? chan->imtu : L2CAP_DEFAULT_M=
TU;
> +
>                 if (mtu < L2CAP_DEFAULT_MIN_MTU)
>                         result =3D L2CAP_CONF_UNACCEPT;
>                 else {
> --
> 2.45.2
>

