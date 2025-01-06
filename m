Return-Path: <stable+bounces-106844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25255A02680
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 14:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0820D164A72
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 13:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A5D482EB;
	Mon,  6 Jan 2025 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHmUlm+e"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29581D90C5;
	Mon,  6 Jan 2025 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169926; cv=none; b=Uw4L1szVo9umkUplV2/W4zU9n8oXQzsmFwhCPrIdFyOaJWt9U1oPNNOrYYRDc/2ra5xDP/5syrYE9a0TWNb58jimWlh6MHxDNfmin/+CCNORDleqDEshX7dBq2xelf1SWIoL/Kytlhld9b2st6qBlUHHL927ukcQceOxWM8zJYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169926; c=relaxed/simple;
	bh=uBl5512cVeNFZuefqmHVTx+H9akHlDhOzIPkLzw5fdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDAy4ZDTf2+AQrXDSmfoRuvDWjD0irUoVyOmDC+Zwn6awURNsQ/p5VW0yxlggfL/bEfFyKw3zYk33Boe7Wa1klLIn/V3Nnaptx8juM1/yy2zVnONoCglt9dXB+0kcdvw9Ez2NqoDdzw77H21mYcu7gkkG6WVwlQgWo4W/hqL4S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHmUlm+e; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-71e19fee3b3so7524196a34.0;
        Mon, 06 Jan 2025 05:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736169924; x=1736774724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCtxy8VnWn6v00HOQGhDAdAFl5aL18QqotBUE88uI+0=;
        b=LHmUlm+eXCmnWi0aAFnHhVBE6A/xcnNb+R9kH5GMwvL6kMtZoMdzVr6Kd3sB8JK/rH
         i+ltRqp9iLKxbIepNB8IMFINPouy+GBw2jGYNIbtvK8bFaiqzw531d02AM6M6VYX55pA
         2AZXCKslhvepp8m03FF1x3OLYaGRwj/U0biEFojRrRQElP5P2oZM+JIUeqfEhswMUgtR
         iTf2ctJMvH9ra2EDMa1a6EuorKufrfzlsqoklnv82xt/OppCQIIW6k/lDL/EMykPzWpF
         +vJidmZUA22k00OONb07D+NlVaNDLowTqZuaFYID1C+4qQaqcIxEDLUcsDc8gKZcOlNz
         d4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736169924; x=1736774724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCtxy8VnWn6v00HOQGhDAdAFl5aL18QqotBUE88uI+0=;
        b=kPOYCNeg9l6hdXwBNxiwhEuO6SoiVFUH4vPQKHc8n8nwXvOkjfC5Mu9Zckw6ZCMqkY
         O2/Qsy39qsYe2UdKGv7WcVDrt1MrK1qjhtBm/P0jV2EwOIiuANylljfUVkOe5mge0CLW
         Y3UBrwjJUHDRG1QilNQ+jTWqPIkv8e4dOzOJloRSk5Y+mK3TaRRkI5KQ7QnqWPwH3E3W
         dLADMwsXcNazgosxV40fPFQ9zb0eSavOU7JVwvNiUtrxX/GEe/ooxf4bnHxWP6uhbQH/
         c6jAyYKoUPEJkxYIE29BYkiX4o5zBXT+/DKBbCHk1hBaT/9VIpFiEAl0NoHJttlbu8FN
         E12Q==
X-Forwarded-Encrypted: i=1; AJvYcCUetiuJzYjnboyvfPomWBEAPt8R3+5cEOyJ7/iTKKYqYJ3OWYwaXscd12/dyBQn4QbTdRmNAJxc@vger.kernel.org, AJvYcCWrAF+n+UsuZirwPKWHSY3s2NykDGVeyYonPKZ96CIvZbSzU6dPBQEPGELbWO8mOv0683rSuVRJDJtFoYU=@vger.kernel.org, AJvYcCXdewFbQNUmPJoibMAj/TvZ1prrS5q//XZ3ZbPvnq5fxfr4yofpOkB6uXICalwkfTfIyL6uZMRcZgVM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx56SvF5erpmMveqiS3H/fjfad0LzXscKsRapbTAB53CG/99ab1
	+Cby0HETcx8R+7ojaOtEbgubNZPX847aXcizZUtF52g1Kt6739rUYcrLxXwzPd2GIh8m4tBFZxt
	CbtIFtf/LiUPQFW6MfCL9kzs+vW5WqF/VBE4=
X-Gm-Gg: ASbGncuo+msWT48Iy1HcM9Ii8ZA/Nda5188EbF4IN2Mrj3HmAgCltOJZhbvx5+khjot
	8VpX397utuFDaW4uxuOXvVr8QHKgXCLe12HDnS00=
X-Google-Smtp-Source: AGHT+IHOBhu54wxIGAl4fimYKtLxwEtXtnkoANezwFKobTUkMnwxwy29o8BMhrGuwekMa5FoxE+i1RuqAGcTToJTUuA=
X-Received: by 2002:a05:6870:55c6:b0:2a7:8c73:be33 with SMTP id
 586e51a60fabf-2a7fccc2847mr28932067fac.16.1736169923750; Mon, 06 Jan 2025
 05:25:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250105125251.5190-1-joswang1221@gmail.com> <2025010520-pod-material-75c4@gregkh>
In-Reply-To: <2025010520-pod-material-75c4@gregkh>
From: Jos Wang <joswang1221@gmail.com>
Date: Mon, 6 Jan 2025 21:25:17 +0800
Message-ID: <CAMtoTm2jEWQHKp2hOO7ngG1KosqH4sxgG=fg7qoHqe7Ei5DuHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] usb: pd: fix the SenderResponseTimer conform to specification
To: Greg KH <gregkh@linuxfoundation.org>
Cc: heikki.krogerus@linux.intel.com, dmitry.baryshkov@linaro.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jos Wang <joswang@lenovo.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 5, 2025 at 9:00=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Sun, Jan 05, 2025 at 08:52:51PM +0800, joswang wrote:
> > From: Jos Wang <joswang@lenovo.com>
> >
> > According to the USB PD3 CTS specification
> > (https://usb.org/document-library/
> > usb-power-delivery-compliance-test-specification-0/
> > USB_PD3_CTS_Q4_2024_OR.zip), the requirements for
>
> Please put urls on one line so that they can be linked to correctly.
>

OK=EF=BC=8CThanks

> > tSenderResponse are different in PD2 and PD3 modes, see
> > Table 19 Timing Table & Calculations. For PD2 mode, the
> > tSenderResponse min 24ms and max 30ms; for PD3 mode, the
> > tSenderResponse min 27ms and max 33ms.
> >
> > For the "TEST.PD.PROT.SRC.2 Get_Source_Cap No Request" test
> > item, after receiving the Source_Capabilities Message sent by
> > the UUT, the tester deliberately does not send a Request Message
> > in order to force the SenderResponse timer on the Source UUT to
> > timeout. The Tester checks that a Hard Reset is detected between
> > tSenderResponse min and max=EF=BC=8Cthe delay is between the last bit o=
f
> > the GoodCRC Message EOP has been sent and the first bit of Hard
> > Reset SOP has been received. The current code does not distinguish
> > between PD2 and PD3 modes, and tSenderResponse defaults to 60ms.
> > This will cause this test item and the following tests to fail:
> > TEST.PD.PROT.SRC3.2 SenderResponseTimer Timeout
> > TEST.PD.PROT.SNK.6 SenderResponseTimer Timeout
> >
> > Set the SenderResponseTimer timeout to 27ms to meet the PD2
> > and PD3 mode requirements.
> >
> > Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > ---
> >  include/linux/usb/pd.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> > index 3068c3084eb6..99ca49bbf376 100644
> > --- a/include/linux/usb/pd.h
> > +++ b/include/linux/usb/pd.h
> > @@ -475,7 +475,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
> >  #define PD_T_NO_RESPONSE     5000    /* 4.5 - 5.5 seconds */
> >  #define PD_T_DB_DETECT               10000   /* 10 - 15 seconds */
> >  #define PD_T_SEND_SOURCE_CAP 150     /* 100 - 200 ms */
> > -#define PD_T_SENDER_RESPONSE 60      /* 24 - 30 ms, relaxed */
> > +#define PD_T_SENDER_RESPONSE 27      /* 24 - 30 ms */
>
> Why 27 and not 30?  The comment seems odd here, right?
>

1=E3=80=81As mentioned in the commit message, "TEST.PD.PROT.SRC.2
Get_Source_Cap No Request" test item, after receiving the
Source_Capabilities Message sent by the UUT, the tester deliberately
does not send a Request Message in order to force the SenderResponse
timer on the Source UUT to timeout. The Tester checks that a Hard
Reset is detected between tSenderResponse min and max. Since it takes
time for the tcpm framework layer to initiate a Hard Reset (writing
the PD PHY register through I2C operation), setting tSenderResponse to
30ms (PD2.0 spec max) will cause this test item to fail in PD2.0 mode.

2=E3=80=81The comments here are indeed unreasonable, how about modifying it=
 like this?
+#define PD_T_SENDER_RESPONSE 27 /* PD2.0 spec 24ms -30ms, PD3.1 spec
27ms - 33ms, setting 27ms meets the requirements of PD2.0 and PD3.1.
*/

3=E3=80=81This patch was originally discussed here
(https://patchwork.kernel.org/project/linux-usb/patch/20241222105239.2618-2=
-joswang1221@gmail.com/)
Dmitry Baryshkov suggested splitting the "[v2,2/2] usb: typec: tcpm:
fix the sender response time issue" patch and submitting it
separately.
(1) Set SenderResponse timer timeout to 27ms
(2) Make timeout depend on the PD version
(3) Make timeouts configurable via DT
Actually, I would prefer to merge (1) and (2) and submit them. Do you
have any better suggestions?

> thanks,
>
> greg k-h

