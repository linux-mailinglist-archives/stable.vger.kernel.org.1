Return-Path: <stable+bounces-114914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3C4A30D4B
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 14:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837A81887058
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 13:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1702441A1;
	Tue, 11 Feb 2025 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbNBjw8C"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9590F26BD9A;
	Tue, 11 Feb 2025 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739281823; cv=none; b=kQcO4HqsPoH+XX2FhDgG2a4aGxu8QDJlJQfKpHH392lLmnAhBAJ2TsH61B0xykkonISXmAf0EkM60mixbA28CnBJfwTdQbMAD5S3gjgqr91iU+Laz2YKoln0kozdbVZKaKMjsM/DO/8GrPqG3OdnAPnf6QneH/D2bogd53GSuA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739281823; c=relaxed/simple;
	bh=pKkt4VSoLZl2sGaYzr79kkI7zvh+CB5ECNtiwL9okKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNfi6sphP8vWcHgY1eCiVdB3S3L7xZco/aDOhgsYImaDGa1I5xZ2B/e1TvTNth3BVpD/+h+CBek13NhCHS1ow9aiB1FbW3AAc4peUJgVnnMiZYYJSNEI8qCfsgk0Svpu1/0Ks1rsQ/i17wi/WVCOsWlyDQpkL0FcoCPxzU9t9QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbNBjw8C; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2addd5053c0so3191624fac.1;
        Tue, 11 Feb 2025 05:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739281820; x=1739886620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3JAPeXHn1qsDNW866P/qiGLMSZ4lYzkFddERH0fa2A=;
        b=hbNBjw8CPSV3yF+e8R+ru0cB3XGOy40MX9TvdwAGel+WnMewuY+5o0r/hiGbRhFdjL
         k67hB+laA1D/HQK7NZas4JfLj8wR7D6U9wgWxRVXCIxISDo5WXJbi0+mledm61UxYxq2
         KoUcpueS0Z2DjikxaehUtIEsj6oF/gxpAQlJvpsMbOtCS+zVc8agK6987uhB2GgDiMhq
         EvIDmZQEzPmmJxUwBWwmaV12nvq/N1iYaVfrDwBs3Fc54VgWSrBL8I//4ZoVO+GJ1CnR
         NUFW/0HPevXF/uq6ljKSYyUb5krA21FD2Ddf4DofpKV0uFbtgL1tHGYiN0M3ZuV1uGEr
         o9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739281820; x=1739886620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3JAPeXHn1qsDNW866P/qiGLMSZ4lYzkFddERH0fa2A=;
        b=AM8JhAwAFjOldh4ArADteFJzxmfpsn0WsUSr74+MMZ3o5vxjRVONMMSN4HEmFeKSX6
         urHhWSgTkiOGpV7mihYWNdkBTH2nUsZezTs1exxlBnvS6jgfUCuykeeU2xaIEyYf58/P
         JkiODLA+mHNu3Pnh7sVLrAuaX4tWY1eQV45zgY5wWgxiegwrPZ9jlykh9dJVtmJxjFs+
         /Rau+mcJo8zx3BY09bb38XPS2OmGae4W74W6k++NZ6FwD3q30zFcXkm/ux8npAYSECZf
         8jKgKCDCcH9efsX1tKBKqx5myvrKmAsVW+p7R04u6gs3BCACvKfyRsoYGwtk0yasicnK
         R9ug==
X-Forwarded-Encrypted: i=1; AJvYcCU1dcn0jFlfdrznBYOGSrkb4eIBy7p1zXpw/y+Qda1N/VtXkp/4LZ2CnIkrv5NxNRsI6o5JaX4/ZpqS@vger.kernel.org, AJvYcCV925+/YuOdJzupTyHECzdy5KphYzytghlqVVFjMOSKrQEKkRKztR+RIco3966YpiMvtEVmXc3T@vger.kernel.org, AJvYcCVlEpHUZRSfUEKWaFIMo5Ah/A1VY7dOsJOLD/YSa3Whsi5u9yrkUT+Xtt6/WlX5h6u3xefcla5TOaq7jG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynl2PWFzEbEUmup8BawIbRf+xiNMx0f2opIs6dfo3bLJBl71wf
	72bSTIVdxLbjkSAnkBNKNa6y4eyYWoVXRaEmq6Fwa8Q1u9gES9NdD65x33r7cW4EEDSfEg97KEf
	CyZuGHBMmqmdzus82lHiNaStPk3c=
X-Gm-Gg: ASbGncv6DLkAoswLPZKQkwM6J2l3QjAOVK/1TBitbzO2IGVsszLJkaZmjrlXvpMKrRW
	k2HtFfSf6yxg22WtY9cIQ1oAXbpbM7uCmKhC+yExf+UQeX6/YbPIG/VxObYH2zD3epE42vUf9
X-Google-Smtp-Source: AGHT+IFbEj4xWuZDz0dziKnxzJesY6Ax7CfGY3vRgXsgo08AmUlxMqbQTwRk7p9bqtEs1i5O9AuAKm4mN/H/W957aNk=
X-Received: by 2002:a05:6870:9106:b0:29e:3eff:dea with SMTP id
 586e51a60fabf-2b8b570c2dbmr2200377fac.8.1739281820000; Tue, 11 Feb 2025
 05:50:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209071752.69530-1-joswang1221@gmail.com> <5d504702-270f-4227-afd6-a41814c905e3@google.com>
 <CAPTae5+Z3UcDcdFcn=Ref5aQSUEEyz-yVbRqoPJ1LogP4MzJdg@mail.gmail.com>
In-Reply-To: <CAPTae5+Z3UcDcdFcn=Ref5aQSUEEyz-yVbRqoPJ1LogP4MzJdg@mail.gmail.com>
From: Jos Wang <joswang1221@gmail.com>
Date: Tue, 11 Feb 2025 21:50:09 +0800
X-Gm-Features: AWEUYZkZT10sA2YI3GJlef0qf7-Q5jW60r6XuARrBv_ir_XPwSKMTdiVWOOQGQc
Message-ID: <CAMtoTm0bchocN6XrQBRdYuye7=4CoFbU-6wMpRAXR4OU77XkwQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] usb: typec: tcpm: PSSourceOffTimer timeout in PR_Swap
 enters ERROR_RECOVERY
To: Badhri Jagan Sridharan <badhri@google.com>
Cc: Amit Sunil Dhamne <amitsd@google.com>, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jos Wang <joswang@lenovo.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 7:51=E2=80=AFAM Badhri Jagan Sridharan
<badhri@google.com> wrote:
>
> On Mon, Feb 10, 2025 at 3:02=E2=80=AFPM Amit Sunil Dhamne <amitsd@google.=
com> wrote:
> >
> >
> > On 2/8/25 11:17 PM, joswang wrote:
> > > From: Jos Wang <joswang@lenovo.com>
> nit: From https://elixir.bootlin.com/linux/v6.13.1/source/Documentation/p=
rocess/submitting-patches.rst#L619
>
>   - A ``from`` line specifying the patch author, followed by an empty
>     line (only needed if the person sending the patch is not the author).
>
> Given that you are the author, wondering why do you have an explicit "Fro=
m:" ?
>
Hello, thank you for your help in reviewing the code.
My company email address is joswang@lenovo.com, and my personal gmail
email address is joswang1221@gmail.com, which is used to send patches.
Do you suggest deleting the "From:" line?
I am considering deleting the "From:" line, whether the author and
Signed-off-by in the patch need to be changed to
"joswang1221@gmail.com".
> > >
> > > As PD2.0 spec ("6.5.6.2 PSSourceOffTimer")=EF=BC=8Cthe PSSourceOffTim=
er is
>
> nit: https://elixir.bootlin.com/linux/v6.13.1/source/Documentation/proces=
s/submitting-patches.rst#L619
>
>  - The body of the explanation, line wrapped at 75 columns, which will
>     be copied to the permanent changelog to describe this patch.
>
"As PD2.0 spec ("6.5.6.2 PSSourceOffTimer")=EF=BC=8Cthe PSSourceOffTimer is=
"
This sentence doesn=E2=80=99t exceed 75 chars, right?
>
> > > used by the Policy Engine in Dual-Role Power device that is currently
> > > acting as a Sink to timeout on a PS_RDY Message during a Power Role
> > > Swap sequence. This condition leads to a Hard Reset for USB Type-A an=
d
> > > Type-B Plugs and Error Recovery for Type-C plugs and return to USB
> > > Default Operation.
> > >
> > > Therefore, after PSSourceOffTimer timeout, the tcpm state machine sho=
uld
> > > switch from PR_SWAP_SNK_SRC_SINK_OFF to ERROR_RECOVERY. This can also=
 solve
> > > the test items in the USB power delivery compliance test:
> > > TEST.PD.PROT.SNK.12 PR_Swap =E2=80=93 PSSourceOffTimer Timeout
>
> Thanks for fixing this !
>
> > >
> > > [1] https://usb.org/document-library/usb-power-delivery-compliance-te=
st-specification-0/USB_PD3_CTS_Q4_2025_OR.zip
> > >
> > > Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)"=
)
> > > Cc: stable@vger.kernel.org
> > >
> nit: Empty line not needed here.
>
Modifications for the next version

> > > Signed-off-by: Jos Wang <joswang@lenovo.com>
> >
> > Tested-by: Amit Sunil Dhamne <amitsd@google.com>
>
>
> >
> >
> > Regards,
> >
> > Amit
> >
> > > ---
> > >   drivers/usb/typec/tcpm/tcpm.c | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/t=
cpm.c
> > > index 47be450d2be3..6bf1a22c785a 100644
> > > --- a/drivers/usb/typec/tcpm/tcpm.c
> > > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > > @@ -5591,8 +5591,7 @@ static void run_state_machine(struct tcpm_port =
*port)
> > >               tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_=
MODE_USB,
> > >                                                      port->pps_data.a=
ctive, 0);
> > >               tcpm_set_charge(port, false);
> > > -             tcpm_set_state(port, hard_reset_state(port),
> > > -                            port->timings.ps_src_off_time);
> > > +             tcpm_set_state(port, ERROR_RECOVERY, port->timings.ps_s=
rc_off_time);
> > >               break;
> > >       case PR_SWAP_SNK_SRC_SOURCE_ON:
> > >               tcpm_enable_auto_vbus_discharge(port, true);

