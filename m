Return-Path: <stable+bounces-108229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A82A09B87
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 20:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F0F7A3380
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 19:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5552236E0;
	Fri, 10 Jan 2025 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ho6oUBmQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF5C2144BA
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736535634; cv=none; b=GrEAxhc0VT2aXxZfcJrFx6pPzydhSNKq7HSUYt5S9rSe6pR5J59sFAZUuzHFjVsWeqwGCkDqCqs+I8+mEkT8j3mpfg7m8Q1KSiUOn0MUBx4upEjA3bEEeJ2ox0UKQTyo0A3NROxfRIZxHY+Y2wX6MDnHkndxQSmC0o0vc4SymVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736535634; c=relaxed/simple;
	bh=6Au0Ozm6N5d57b/PR5dTyRZOgC8Z6B28G8m6+acGRg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E++4yH6D36kLLmifePa/o78Pmdk9t2hTQZbffxGofi/8wASR1wTvB1AIwHFIMhwDVORakvWiKFF0tGh2cAoDtVehvIA6jAaWeCXz0sKB7JRNl0NQL1cwcRlta5PjNnHx6S1sYg+hCHr52S2zVuWxBkIXq922BxHdklP31JreomY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ho6oUBmQ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d0c939ab78so877a12.0
        for <stable@vger.kernel.org>; Fri, 10 Jan 2025 11:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736535631; x=1737140431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFssL5Eg7HFqhUYjNlx6I1dZGICzmvI+AYnPPZIVuNw=;
        b=Ho6oUBmQjfEOOwb/sEr3S4qdf9sIkt0SbTfMvQcv4gc1rpxK0S9O3so43pI3ZpoSUs
         HGxhrkX2HEs/gA0LF6uq1sWNtR3rQDuzAMXvz/0cau0Mi/l/jF27bvF+Ga0Gp9JyT5ct
         2L6fOYELh8iwF2dSQHBRCzlpB5EwEJWqfg6WSZe5of2LL6u00JT2YOOZeFHrp/afujxa
         OnqOVJaOANVY+ey8p3q/PqPrfBSnwXD+SDgYdPN3NuVDgY9UmBINLDifkA+p5hiTH860
         5xXQsPIo3CXHIJVNBhYDYVVdY2XFYnEYj/s41QIS/GeXcLD0l42ZRkbqsO2yHjxgq/bt
         V/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736535631; x=1737140431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFssL5Eg7HFqhUYjNlx6I1dZGICzmvI+AYnPPZIVuNw=;
        b=C4fOKMX5EKya0pqCSsWtH6azfQZ+ZwlKg9NPw/lcLRX1vhwhstVtT7fKnNRb839fkS
         e7G3QPSi/nGUJdMSmH3tES6dKqiIqMqKhqjhYHBad31LPIQd758GzFGry4KQfu+rgusn
         O7SErI4I2q0dnmvuPMqrSjJOyEQBgfiuZjf9jXJfXeMj7wE/yYjAoajbp8RYN6C08FR9
         asmpIRdhZLxkhNdE3yBAH/6pSnTIn+ie1S9yi7OB8V0IHv+Z/tfycwMo/z+EB0uS0uMN
         eDszYK6kFW3fTpcvxYB3Oc/NF9vLYs2/hBdQNIcCEtIgPZ6OV42TIghF71579v+ivb5L
         U1yg==
X-Forwarded-Encrypted: i=1; AJvYcCW15P/TT28PY9Y1s6o+/W4UU+kT/8fD6gIprZtiiW/JPoMSdxnqlRPMG+ruxjb07mHw+0GVM3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLFROVX+RxeUMKWlEv/42yV1U3pTkZMP2WaWfQNMqWVAW6c+cJ
	0ZdxLj2mMN3ZbVwNIfQe0paDcZ6zrAnx08TQWbHzl8SKPjx6cjasXYkSy9QnbQosUDGhT+u65i/
	nIkw5laKObxIMWZbf9eru/RFeQv4bADGUmJ+8
X-Gm-Gg: ASbGncuMyulvkt2Km0/Mg/0fnw7dTT2uJmzApNOJnUrFUll76Fv0wIDLgwMx4UsPS+R
	02qLnPfqJ+GQ+0NSUCaDnTCK77dWjHsX/Z3XqLWJjoZlfojRDoNXE8RFwA9/aEFIfVRix+QKv
X-Google-Smtp-Source: AGHT+IHSWR/fLldKuhFK4nM6Z9UZ1cOBbz/G2YKf+HVMwPAfqpp8yxek2i0bKSnj9xyXsrAoMv9jT7CozNmY70WUNsg=
X-Received: by 2002:a05:6402:1045:b0:5d9:693e:346 with SMTP id
 4fb4d7f45d1cf-5d99fbd7470mr123173a12.4.1736535630936; Fri, 10 Jan 2025
 11:00:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205074650.200304-1-quic_kriskura@quicinc.com> <ME0P300MB05534EDF5293054B53061567A61C2@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <ME0P300MB05534EDF5293054B53061567A61C2@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Fri, 10 Jan 2025 11:00:19 -0800
X-Gm-Features: AbW1kvY1g459ZajTF-rK_C7M7pE-C-FOcoJ1XnQW3-zhuHIftgHB_3pA-qmjWNY
Message-ID: <CANP3RGc_SBROWVA2GMaN41mzCU28wGtQzT5qmSKcYsYDY03G5g@mail.gmail.com>
Subject: Re: [PATCH v3] usb: gadget: ncm: Avoid dropping datagrams of properly
 parsed NTBs
To: Junzhong Pan <panjunzhong@outlook.com>
Cc: quic_kriskura@quicinc.com, gregkh@linuxfoundation.org, 
	hgajjar@de.adit-jv.com, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, quic_jackp@quicinc.com, quic_ppratap@quicinc.com, 
	quic_wcheng@quicinc.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 11:37=E2=80=AFPM Junzhong Pan <panjunzhong@outlook.c=
om> wrote:
>
> Hi everyone,
>
> I recently switch to f_ncm with Windows 10 since rndis 's safety issue.
> (the Windows 10 driver version is 10.0.19041.1 2009/4/21)
>
> It seems Windows 10 ncm driver won't send ZLP to let udc properly
> separate the skbs.
>
> On Mon, 5 Feb 2024 13:16:50 +0530 Krishna Kurapati wrote:
> > According to Windows driver, no ZLP is needed if wBlockLength is
> non-zero,
> > because the non-zero wBlockLength has already told the function side th=
e
> > size of transfer to be expected. However, there are in-market NCM devic=
es
> > that rely on ZLP as long as the wBlockLength is multiple of
> wMaxPacketSize.
> > To deal with such devices, it pads an extra 0 at end so the transfer
> is no
> > longer multiple of wMaxPacketSize.
>
> I do the iperf3 testing cause gadget constantly report similar error afte=
r
> a litle modification to get more concrete info:
>
> [  174] configfs-gadget.0: to process=3D512, so go to find second NTH
> from: 15872
> [  174] FIND NEXT NTH HEAD:000000006c26a12c: 6e 63 6d 68 10 00 86 16 b0
> 3b 00 00 48 3b 00 00 00 00 52 34 fc 5f 90 fd ca 40 c1 f4 f4 6e 08 00
> [  174] configfs-gadget.0: Wrong NDP SIGN of this ndp index: 15176, skb
> len: 16384, ureq_len: 16384, this wSeq: 5766
> [  174] NDP HEAD:00000000298f3cab: 2b 12 48 8f 12 ce 3c c8 d7 39 c0 0d
> 15 cf 86 14 17 4a 91 85 db df ad 87 f0 35 0d 76 ad 4d 4d 74
> [  174] NTH of this NDP HEAD:00000000af9fbfc9: 6e 63 6d 68 10 00 85 16
> 00 3e 00 00 90 3d 00 00 00 00 52 34 fc 5f 90 fd ca 40 c1 f4 f4 6e 08 00
> [  174] configfs-gadget.0: Wrong NTH SIGN, skblen 14768, last wSequence:
> 5766, last dgram_num: 11, ureqlen: 16384
> [  174] HEAD:00000000b1a72bfc: 3f 98 a6 8e 17 f8 bb 29 07 b8 da 13 7f 20
> 80 8e 77 ca 32 07 ac 71 b8 8d 84 03 d7 1b 96 9b c4 fa
>
>
> Lecroy shows the wSequence=3D5765 have 10 Datagram consisting a 31*512
> bytes=3D15872 bytes OUT Transfer but have no ZLP:
>
> OUT Transfer wSequence=3D5765
>         NTH32 Datagrams: 1514B * 8 + 580B NDP32
>         Transfer length: 512B * 31
>         NO ZLP
> OUT Transfer wSequence=3D5766
>         NTH32 Datagrams: 1514B * 8 NDP32
>         Transfer length: 512B * 29  + 432
>
> This lead to a result that the first givebacked 16K skb correponding to
> a usb_request contains two NTH but not complete:
>
> USB Request 1 SKB 16384B
>         (NTH32) (Datagrams) (NDP32) | (NTH32) (Datagrams piece of wSequen=
ce=3D5766)
> USB Request 2 SKB 14768B
>         (Datagrams piece of wSequence=3D5766) (NDP32)
>
>  From the context, it seems the first report of Wrong NDP SIGN is caused
> by out-of-bound accessing, the second report of Wrong NTH SIGN is caused
> by a wrong beginning of NTB parsing.
>
> Do you have any idea how can this be fixed so that the ncm compatibility
> is better for windows users.
>
> Best Regards,
> Pan

Could you clarify which Linux Kernel you're testing against?
Either X.Y.Z version or some git kernel sha1 (not including your debug
code of course).

Could you provide some pcap of the actual usb frames?
Or perhaps describe better the problem, because I'm not quite
following from your email.
(I'm not sure if the problem is what windows is sending, or how Linux
is parsing it)

I *think* what you're saying is that wSequence=3D5765 & 5766 are being
treated as a single ncm message due to their being a multiple of 512
in the former, not followed by a ZLP?  I thought that was precisely
when microsoft ncm added an extra zero byte...

What's at the end of 5755?  Padding? No padding?
Is there an NTH32 header in 5766?  Should there be?

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

