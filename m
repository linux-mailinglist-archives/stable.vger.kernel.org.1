Return-Path: <stable+bounces-106744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0A2A01283
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 06:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 773167A1DBD
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 05:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77545148FF6;
	Sat,  4 Jan 2025 05:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al7PgydM"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93410168DA;
	Sat,  4 Jan 2025 05:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735968245; cv=none; b=TF9Zuk1KsIPA5PODKU+/ewRxF7RJdtqitPnlmEbupdfTKg1ka5RlEWrbq9z1NOtpQuVZSTC6ULusNNmgyMAV+VgWc+e2NKtZbXCTtXg9qtq5Ruita61iYMDMwfhhiIIN91FgwTd77mjq+LvCwlooKfS4dW2vRbJU84gKtYvORfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735968245; c=relaxed/simple;
	bh=y3bxbAnBlKC1hENCikUB+10x7gYzgjtwbzOlqpoIyss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pM+f+Ot6GuKysKxE/PhGxhpckY1ZGjMEwXGuaNxKz91sYZAVaFCksItPjug5Js8IJShwQFVy1V392FuEqCP9A+ppnzQmp9W693Bwltq7vYwwrwzY4p2qcigilnDIixHUbxkPuUqNn34K0H3Nyw6nFbSuH8fS+uh9KFexLFw2yIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al7PgydM; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71ded02b779so6942988a34.2;
        Fri, 03 Jan 2025 21:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735968242; x=1736573042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acA1TDb0UrJFKrVaZCv/YccfOjk9TfQSmkM3PcsZWBI=;
        b=al7PgydMqI41IrYcUuoJrKFhta+nOJ6O8zs6qX907UuISCXB7ch6p7sqswQMq8Lyrw
         PL06ddfHh6xS2M7b6FYkRxnw5ml09eamBYjaNzG672ni89DDAirtKjlL9dPNlxNSIQYE
         w3XpxPaMosW62dWZinIbx5SU0wj9qd+TjyGQFsQdN1OVKmet3FeQ07+ISL4WYnY7Xd+E
         3QnhOHEpJbWoSXyIm3IYu+D43+b2Oz4rXm99o1C5ceVpp7jCR/f6+31Q0ZRBww90t97K
         AybEfmvfFCBpexhAURAPGj7oa+sE53vJ4WtV9UxGXSvawSuS8lu4tPMzmyhO34qS5Iag
         0kiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735968242; x=1736573042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acA1TDb0UrJFKrVaZCv/YccfOjk9TfQSmkM3PcsZWBI=;
        b=Cpvq0cJyj6LYk3aDpbRm8//2NShLuumOHYxQqt/gXKoWxjac6cMeHFfKP1CGMhHMun
         mc6ydnLYkNKiF9c3xibCedO0uE41M2FY69gTKYsqAVlTqtmfxnzSGrgFkCK/oPQ0lZ4j
         lVMgvfR9JOIrfIyR/UcWCWLc7c4mmEYhQY/ANHLDMeJE3QvYGIyb5lf52gtPy0pmjgb7
         HBD+mVDe+hXqKHDc68p6AoU4Po/QQ94glIx9sW2axAJlC+dV1cn49CBlXoohhp1WLz+J
         dnR0wzcpBGje9lHE8n1Kcx6bda1oyCG37o/jLICTNCnX5QvOG+gueUyI2N2P/NG96rXK
         vS5w==
X-Forwarded-Encrypted: i=1; AJvYcCUG+vayWjQGSARCbTfasNs1oLeHkUFl5EBx2v8KzvMsFqU/jpxqb3dDGXC+R+lcdkvJ8WNcfrFrxF45@vger.kernel.org, AJvYcCUa6i9fvkoy0nf5SqxsPkfWs6OqpuGvvqp7RJ7KMFkT/dqNpCULbHVH9QHeZplRPaBScPnbdfd7MPr1fkib@vger.kernel.org, AJvYcCVGCUrpoe1eJx5CMux5VBh6ou6wNHg9Gjj/CV0Hx0JDDXipP+D76tvdjf98yLgxCrNybHAUik71Rw/v@vger.kernel.org, AJvYcCWFfZnmFmu2cBemM5gRrsi3A0lrQuv1Df+VHZbOZ8IwaodZ9qWqvf6gH5pUKSAHGwIHXDJzpq5+@vger.kernel.org
X-Gm-Message-State: AOJu0YyaaziAuj7ma77E2YY5kqJIuEYGR7ZutGYlKcM0GPDd0BZV/cXm
	KFpnPO3lNzF6o/fkMNF4c2UduhHnZoYbT6GCwvK/AM3t3AthTO/Nb8D0vHWpuxZl8mn3NFJJRCC
	6hLkVj2p/6nanUQPJNRSJieBnXdSJyQ==
X-Gm-Gg: ASbGnctieEqEMNM1IE9mi3d5LtiFswaldfUN/e/gytZcs/fwm3GcidnDGfmYvaph6cU
	5BnDUjn4SZzL3VfmVT9DVW+rUaoxdx698cXKKEe0=
X-Google-Smtp-Source: AGHT+IGDHHiShh2/RbztpLYfVEGR6eidVfvZztjSDJRPjbFLFEwSFq5vmkUnRgElcfTZadwZIwy8KqWQGeAYki9omSA=
X-Received: by 2002:a05:6830:d86:b0:71d:5bfd:8537 with SMTP id
 46e09a7af769-720ff867237mr32877210a34.14.1735968242581; Fri, 03 Jan 2025
 21:24:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241222105239.2618-1-joswang1221@gmail.com> <20241222105239.2618-2-joswang1221@gmail.com>
 <exu4kkmysquqfygz4gk26kfzediyqmq3wsxvu5ro454mi4fgyp@gr44ymyyxmng>
 <CAMtoTm0nCL7jL=Wno7Cv5upyPnF0wTOXbY+WNG+y1P94513Pgg@mail.gmail.com> <j2icjry36lnmhhe2jskh4jpdxmogv4xy3mnbjasechbg5gf76u@wlakfperuk7q>
In-Reply-To: <j2icjry36lnmhhe2jskh4jpdxmogv4xy3mnbjasechbg5gf76u@wlakfperuk7q>
From: Jos Wang <joswang1221@gmail.com>
Date: Sat, 4 Jan 2025 13:23:53 +0800
Message-ID: <CAMtoTm2ScJGwhMtr=KryxFaG16WeM22jqGY1PBvSC+92pLX5iw@mail.gmail.com>
Subject: Re: [PATCH v2, 2/2] usb: typec: tcpm: fix the sender response time issue
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: heikki.krogerus@linux.intel.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	rdbabiera@google.com, Jos Wang <joswang@lenovo.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 1:39=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, Jan 01, 2025 at 09:00:01PM +0800, Jos Wang wrote:
> > Hi, thanks for your help in reviewing the code, and happy new year to
> > you and your family!
> >
> > For the first commit you mentioned (modification time is 27ms), I
> > understand that just modify the include/linux/usb/pd.h file:
>
> In future please respond under the comment, not at the top of the
> message. Thank you.
>
OK

> > diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> > index d50098fb16b5..cd2cc535d21d 100644
> > --- a/include/linux/usb/pd.h
> > +++ b/include/linux/usb/pd.h
> > @@ -457,7 +457,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
> >  #define PD_T_NO_RESPONSE       5000    /* 4.5 - 5.5 seconds */
> >  #define PD_T_DB_DETECT         10000   /* 10 - 15 seconds */
> >  #define PD_T_SEND_SOURCE_CAP   150     /* 100 - 200 ms */
> > -#define PD_T_SENDER_RESPONSE   60      /* 24 - 30 ms, relaxed */
> > +#define PD_T_SENDER_RESPONSE   27      /* 24 - 30 ms, relaxed */
> >  #define PD_T_RECEIVER_RESPONSE 15      /* 15ms max */
> >  #define PD_T_SOURCE_ACTIVITY   45
> >  #define PD_T_SINK_ACTIVITY     135
> >
> > Is my understanding correct?
>
> Yes.
>
Thanks you

> >
> >
> > Thanks
> > Jos Wang
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
> --
> With best wishes
> Dmitry

