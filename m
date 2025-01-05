Return-Path: <stable+bounces-106767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28275A0198D
	for <lists+stable@lfdr.de>; Sun,  5 Jan 2025 14:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78AB3A3206
	for <lists+stable@lfdr.de>; Sun,  5 Jan 2025 13:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4D014AD29;
	Sun,  5 Jan 2025 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNV/4SRL"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390BE45016;
	Sun,  5 Jan 2025 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736082230; cv=none; b=QcImhh8BN1E5CnmRqyif3o8DUSAO3uZI9boyoD5tbGqYSdHoVc5sDz3OaVrVgNUjuCirRJIK7W53pl2jRM2bMEzItWFeeSCfp/BU8YbXKB+lcOnIDfWfhLC/WPc9u+87gwWmTfepSPRsDm6jboxKMcWS06GgYlXZCrCEIL8pRzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736082230; c=relaxed/simple;
	bh=AY+1tKbnrfI6E4poLa8QEeEzrU4F5+8SGRyceE6BCnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkjWERZQraWecW5rvH7jQ3xVVXB0wuJdsVHoB+VunlPu6n8sDHKw7C+JMmva1c2N/lFTK9wXwByNzoKwNO/dOL3KYy8VrLc4E9lKP7YbtUBKWvMHxFYlE0PNeIM0fByM8QGaEe92Ne0pPSy6SrpaB6+6Bw5+lV8tECXmRM1w/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNV/4SRL; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2a3a40c69e3so7070428fac.0;
        Sun, 05 Jan 2025 05:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736082228; x=1736687028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bgS2xiXlPGb/DOmFFIJWprMm8LdeXUrPJ+fJFbUBnw=;
        b=cNV/4SRLdAIWxVJD9clAHTC1zXNFnj7xgOcxn5VK+x+IhPdUAEgkrZSADMmpaILdfF
         inFZxYoIwLdo/xkdmSPOXbfsc1uZ0cDKYaPi2vV+RIwFq68IaP/ecZMBonM6YlcPhWcP
         2glOU86huOYV3MUd6CoctRH/kA19Z7hXf6oX2eUfIYBmbtr5IgJEcJHlaG1snD2DDKmM
         eJBStiu2GZuCtHo/3qxqYqH89yB0pVxlWAIywr0OaoG/xqWGZPut1cTz5lbAAAxpY+Yo
         NGZUmLdUmgLCsCaLwHLplSvNVbKw5/P/9lCjdtqQ1y0VVwGK41lD1kVaw17kDMNaBExj
         w33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736082228; x=1736687028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bgS2xiXlPGb/DOmFFIJWprMm8LdeXUrPJ+fJFbUBnw=;
        b=Ld8MnpeEqKT+ENx8eTXFGhaLDJuQN/UaaM+552VEYBEvWeckniIZYuZDz1N5ouTDFC
         vtuHuuFJlIX7ulDHWHEinIaBMyHACl52zR3hE9f121bvpS87FXbsbtnbwKPrNoEKZgbh
         A/FeKc/xRtBK59875MV4Ssp3IknLvo7GV61niQ4NwKHXchrwAgsK/NzDLIQfHpWt9LJ1
         bDrAr6SfotsPmkKVx6P8Rz2RU4YVW8ijFh4YAbN5Uf4NakWSxC6H4Fa7Pbvh/+EOVVxP
         Hif6EKdgn/lFY+fjJcztVbq6CwqqYKn7VOnmPG+Cp2d/pg9ZGkOZKF9l4zt26RfGAmob
         nQCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUafV2QJjXx+0yiUYKx31KYq6rVEHk+0X0oHjesPDSB6BcE2ASLPMDFLzLpQxkfpb3kteIYPLcN@vger.kernel.org, AJvYcCWMpVccRjYa55TO2CLJrlu8C1Iu5ADDBLlHlOlwOkq/Dy1OnJ89JB4nm//muB+ZefbRat90lDxJN/Vk2GM6@vger.kernel.org, AJvYcCXhAr3APUwrWa827NNHss0KTqd1UDBVRd0MRGfbievFV8GDmd6h0eq43P8dhtGkEqYjLB+P3P54IK3X@vger.kernel.org, AJvYcCXs6P4FkddjP02ZD1TCrUHyjrox8jz4rmd+fEAzXQjGTbFvb/tXsOd3G0r+Bl8EIy7eYw9KZL5QdnDc@vger.kernel.org
X-Gm-Message-State: AOJu0YzkBrD+5m7a7L9eeS3Y4g+Ye1qZ4jvoc+D4PgN6hSpY9KZbxRxm
	G29t1fDoFlttRpgVG4OezQLzMzT0+rlEE5aTy31xo6knHF4jbF/753FoaZg6k4NQTeI4HdB1sOk
	KFhSSrb2v1LNTbVPwStjwEcus2ic=
X-Gm-Gg: ASbGnctyJX94lLteB4m6VmmmY76VM+xIGT2d5egNZ81Q6omDxKqrSOZ40Z1+669f/BE
	50akku3Q7CUDqYObBPv4I4wVX1ET0DTAJzqMtv5Y=
X-Google-Smtp-Source: AGHT+IFWXdfAIip5BChhHhwpWirJ6i4ckF1yZK0KtDpXVEqpUZG1CWu2CJaU3AKDs9Yc60itdV84EDzEnx/0bUoKPLQ=
X-Received: by 2002:a05:6871:a40b:b0:29e:4d0e:a2b6 with SMTP id
 586e51a60fabf-2a7fb056010mr28900394fac.10.1736082228165; Sun, 05 Jan 2025
 05:03:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241222105239.2618-1-joswang1221@gmail.com> <20241222105239.2618-2-joswang1221@gmail.com>
 <exu4kkmysquqfygz4gk26kfzediyqmq3wsxvu5ro454mi4fgyp@gr44ymyyxmng>
 <CAMtoTm2X+aQRpSbNPjw+b+TsYfYT3h6yx2ycXYwfQbcinrwyPQ@mail.gmail.com> <CAA8EJpp06-r9ODvk1dDoH2LwT32BW_uhnkDU9SEeaC35V8Wx1A@mail.gmail.com>
In-Reply-To: <CAA8EJpp06-r9ODvk1dDoH2LwT32BW_uhnkDU9SEeaC35V8Wx1A@mail.gmail.com>
From: Jos Wang <joswang1221@gmail.com>
Date: Sun, 5 Jan 2025 21:03:40 +0800
Message-ID: <CAMtoTm023qnLLErUOUher3-UPr-FoqanDM+4B8XP=9z0rho_Xw@mail.gmail.com>
Subject: Re: [PATCH v2, 2/2] usb: typec: tcpm: fix the sender response time issue
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: heikki.krogerus@linux.intel.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	rdbabiera@google.com, Jos Wang <joswang@lenovo.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 5, 2025 at 2:32=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Sun, 5 Jan 2025 at 04:51, Jos Wang <joswang1221@gmail.com> wrote:
> >
> > On Sun, Dec 22, 2024 at 9:14=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Sun, Dec 22, 2024 at 06:52:39PM +0800, joswang wrote:
> > > > From: Jos Wang <joswang@lenovo.com>
> > > >
> > > > According to the USB PD3 CTS specification
> > > > (https://usb.org/document-library/
> > > > usb-power-delivery-compliance-test-specification-0/
> > > > USB_PD3_CTS_Q4_2024_OR.zip), the requirements for
> > > > tSenderResponse are different in PD2 and PD3 modes, see
> > > > Table 19 Timing Table & Calculations. For PD2 mode, the
> > > > tSenderResponse min 24ms and max 30ms; for PD3 mode, the
> > > > tSenderResponse min 27ms and max 33ms.
> > > >
> > > > For the "TEST.PD.PROT.SRC.2 Get_Source_Cap No Request" test
> > > > item, after receiving the Source_Capabilities Message sent by
> > > > the UUT, the tester deliberately does not send a Request Message
> > > > in order to force the SenderResponse timer on the Source UUT to
> > > > timeout. The Tester checks that a Hard Reset is detected between
> > > > tSenderResponse min and max=EF=BC=8Cthe delay is between the last b=
it of
> > > > the GoodCRC Message EOP has been sent and the first bit of Hard
> > > > Reset SOP has been received. The current code does not distinguish
> > > > between PD2 and PD3 modes, and tSenderResponse defaults to 60ms.
> > > > This will cause this test item and the following tests to fail:
> > > > TEST.PD.PROT.SRC3.2 SenderResponseTimer Timeout
> > > > TEST.PD.PROT.SNK.6 SenderResponseTimer Timeout
> > > >
> > > > Considering factors such as SOC performance, i2c rate, and the spee=
d
> > > > of PD chip sending data, "pd2-sender-response-time-ms" and
> > > > "pd3-sender-response-time-ms" DT time properties are added to allow
> > > > users to define platform timing. For values that have not been
> > > > explicitly defined in DT using this property, a default value of 27=
ms
> > > > for PD2 tSenderResponse and 30ms for PD3 tSenderResponse is set.
> > >
> > > You have several different changes squashed into the same commit:
> > > - Change the timeout from 60 ms to 27-30 ms (I'd recommend using 27 m=
s
> > >   as it fits both 24-30 ms and 27-33 ms ranges,
> > > - Make timeout depend on the PD version,
> > > - Make timeouts configurable via DT.
> > >
> > > Only the first item is a fix per se and only that change should be
> > > considered for backporting. Please unsquash your changes into logical
> > > commits.  Theoretically the second change can be thought about as a p=
art
> > > of the third change (making timeouts configurable) or of the fist cha=
nge
> > > (fix the timeout to follow the standard), but I'd suggest having thre=
e
> > > separate commits.
> > >
> > The patch is divided into patch1 (fix the timeout to follow the
> > standard), patch2 (Make timeout depend on the PD version)
> > and patch3 (Make timeouts configurable via DT). Do you suggest that
> > these three patches should be submitted as
> > V3 version, or patch1 and patch2 should be submitted separately?
> > Please help to confirm, thank you.
>
> Single series should be fine.
>
OK=EF=BC=8COne by one, after the first patch (fix the timeout to follow the
standard) is merged, submit the second patch (Make timeout depend on
the PD version).
The first patch can be found at:
https://patchwork.kernel.org/project/linux-usb/patch/20250105125251.5190-1-=
joswang1221@gmail.com/

> >
> > > >
> > > > Fixes: 2eadc33f40d4 ("typec: tcpm: Add core support for sink side P=
PS")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > > > ---
> > > > v1 -> v2:
> > > > - modify the commit message
> > > > - patch 1/2 and patch 2/2 are placed in the same thread
> > >
> > > --
> > > With best wishes
> > > Dmitry
>
>
>
> --
> With best wishes
> Dmitry

