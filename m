Return-Path: <stable+bounces-115105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F753A338A3
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 08:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5DF188C306
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 07:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320B9207E1D;
	Thu, 13 Feb 2025 07:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKUCldKf"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463252063FC
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431035; cv=none; b=lTPdZ590F5WtaJAGBI8lHJfnbZTh2340jBM8bfOO3v8xG/Zp4dbksTyb04J2OdF6qhwXjpzDU7F8oJ0xMX9YNhpIIbSnaiST0USVD+K6q1qjYnDAS+x6F4ARuElOVHl6CkjA2qLQs+X621mzQ/LBdZPUb4I1piuumvI8AsuqK3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431035; c=relaxed/simple;
	bh=XwVMXNQ761j3J7Ptn4ee+kWiWQc+4AgbYEzScpJOJFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=forVkyUHjMIqc0W/BkK7LCQuRSg3YX2MzhZOFtGqAsm+RxPS7v33zzpSS3b4w8MymIMosSvKNoC+F4SFT5gYYk0diQo+9JEf2k8toOGyGKTm/89Z2AkLXKNn6+pkEr90z4PAR7btWBWZ0RP0LFFnuFmq6qCQlxrBkTC4vATxweY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pKUCldKf; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2a88c7fabdeso361643fac.1
        for <stable@vger.kernel.org>; Wed, 12 Feb 2025 23:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739431032; x=1740035832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAPzHDLMa8F4I+uGf+X/tuBXjfEKEnfqltbhxTQMiCY=;
        b=pKUCldKfzYzCQNftwC8WE7i8y3OusWFZkjrH86JyEJyFMzMnP7mnx5FHb2VSrqdvo4
         lpYAyDOBZgkH+mSnZYvulxenYcJ5noxEmLAzCW9niPIVB9LJRVixTHWauRYTf2krubus
         3ZNmZwOyUNN/tINzIpd7h2Kk8zZUrOh7I8hUy11ArGs0SEF3ABkyDigMHEXknmwL/O1i
         O9S9Ilwsmu8lC69XPZ0AJJk0svk7kakJdV0At5bc1z1JmvHgs+9NfvVvoZ8JlzJs7Mhe
         h/JaKgFzLIsOzibxA2yvYr59MTdEQ0Q+Ylx/KFJzTdD1AlIR2D/N8EYcYhl1ZMUTPDuN
         mAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739431032; x=1740035832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAPzHDLMa8F4I+uGf+X/tuBXjfEKEnfqltbhxTQMiCY=;
        b=VUM24Zl9br0QWOC+WC3lrh1rsCdmOl0Mu4xuciUgVCVjUdFiE4wBhnknFLhrUl6zBa
         FlT5RYdSZgTy43UarioJYl5fBlcw2c5+KofzxH2lzJAEMfA4aCWRkYSRZdV1Sc5jWyD1
         4ck6y/gtMhSOzDGIwe+BLz5ZAwbRFBv076j2GODNYPH6nOBW5bsHqAN5v7H/dmLT3S79
         2eWawj6q23LCb5bU6JTr6o3TCk+5azIulW83kzzyvwNp5Rj1iFbBW4okrMDZ6hsgM2oI
         9ni9W3fIHbuamlx6XfaWn0b3jXQy34gqgAq7AcApJt/+mDLRYPa9vqIAIeGm7RI4UG8Y
         6JXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeaBqtlVyBhPlaoDCygQibOjqkiXftecD4hL1VTxWGEQRStFVZoSY8tTdFlxyfqkywXikw3M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFRnct57JvnkpAPDca/M2dIJTcrLKHikbGKDzz6RAhZXdcSdvD
	Df6A6wMkiJh5lR+DiRcvvgu16bwAlgq5nzn0vwq1JPT9G76BgI4ivA+xkOahHwKELZMIRMVregt
	mJCTksuRfC3a2ElS6Eg465sQApXzynpuL8aCN
X-Gm-Gg: ASbGnctSJNK/3Lz0ofEbYSDzliiZz2COfo41MjZpOjgrFvhSp/Mwkf4+7ETlB8sQw9Y
	43ncQfQbkKi3X/JaTLyz07BrqbH/IvKF5b/m2Ug2xGwve8pvSHvUM87xzlVuEQbfjORuZJtNcCf
	VBKWGP7mWm1BXzg4Q1GXiEoLbWxysNOA==
X-Google-Smtp-Source: AGHT+IEfsRGc6DLQY4CQesdImaEpBlwTV0xIah205sPo/thcjlRBTIl4u2FV25/hHf9zrYLZB0A6O/UXUSdB+3lpew8=
X-Received: by 2002:a05:6870:7ecb:b0:296:fff8:817 with SMTP id
 586e51a60fabf-2b8d682f1e6mr3912622fac.35.1739431032122; Wed, 12 Feb 2025
 23:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209071752.69530-1-joswang1221@gmail.com> <5d504702-270f-4227-afd6-a41814c905e3@google.com>
 <CAPTae5+Z3UcDcdFcn=Ref5aQSUEEyz-yVbRqoPJ1LogP4MzJdg@mail.gmail.com> <CAMtoTm0bchocN6XrQBRdYuye7=4CoFbU-6wMpRAXR4OU77XkwQ@mail.gmail.com>
In-Reply-To: <CAMtoTm0bchocN6XrQBRdYuye7=4CoFbU-6wMpRAXR4OU77XkwQ@mail.gmail.com>
From: Badhri Jagan Sridharan <badhri@google.com>
Date: Wed, 12 Feb 2025 23:16:35 -0800
X-Gm-Features: AWEUYZmRfdK_T6BH_zrmkDkJWGSMnlIR49ILGN6X5bdP8CDQPfCyq0ocxuORgqU
Message-ID: <CAPTae5J5WCD6JmEE2tsgfJDzW9FRusiTXreTdY79MBs4AL6ZHg@mail.gmail.com>
Subject: Re: [PATCH 1/1] usb: typec: tcpm: PSSourceOffTimer timeout in PR_Swap
 enters ERROR_RECOVERY
To: Jos Wang <joswang1221@gmail.com>
Cc: Amit Sunil Dhamne <amitsd@google.com>, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jos Wang <joswang@lenovo.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 5:50=E2=80=AFAM Jos Wang <joswang1221@gmail.com> wr=
ote:
>
> On Tue, Feb 11, 2025 at 7:51=E2=80=AFAM Badhri Jagan Sridharan
> <badhri@google.com> wrote:
> >
> > On Mon, Feb 10, 2025 at 3:02=E2=80=AFPM Amit Sunil Dhamne <amitsd@googl=
e.com> wrote:
> > >
> > >
> > > On 2/8/25 11:17 PM, joswang wrote:
> > > > From: Jos Wang <joswang@lenovo.com>
> > nit: From https://elixir.bootlin.com/linux/v6.13.1/source/Documentation=
/process/submitting-patches.rst#L619
> >
> >   - A ``from`` line specifying the patch author, followed by an empty
> >     line (only needed if the person sending the patch is not the author=
).
> >
> > Given that you are the author, wondering why do you have an explicit "F=
rom:" ?
> >
> Hello, thank you for your help in reviewing the code.
> My company email address is joswang@lenovo.com, and my personal gmail
> email address is joswang1221@gmail.com, which is used to send patches.
> Do you suggest deleting the "From:" line?
> I am considering deleting the "From:" line, whether the author and
> Signed-off-by in the patch need to be changed to
> "joswang1221@gmail.com".

Yes, changing signed-off to joswang1221@gmail.com will remove the need
for "From:".
Go ahead with it if it makes sense on your side.



> > > >
> > > > As PD2.0 spec ("6.5.6.2 PSSourceOffTimer")=EF=BC=8Cthe PSSourceOffT=
imer is
> >
> > nit: https://elixir.bootlin.com/linux/v6.13.1/source/Documentation/proc=
ess/submitting-patches.rst#L619
> >
> >  - The body of the explanation, line wrapped at 75 columns, which will
> >     be copied to the permanent changelog to describe this patch.
> >
> "As PD2.0 spec ("6.5.6.2 PSSourceOffTimer")=EF=BC=8Cthe PSSourceOffTimer =
is"
> This sentence doesn=E2=80=99t exceed 75 chars, right?

Apparently, It actually needs to be wrapped around 75 columns, not too
early either.

Thanks,
Badhri

> >
> > > > used by the Policy Engine in Dual-Role Power device that is current=
ly
> > > > acting as a Sink to timeout on a PS_RDY Message during a Power Role
> > > > Swap sequence. This condition leads to a Hard Reset for USB Type-A =
and
> > > > Type-B Plugs and Error Recovery for Type-C plugs and return to USB
> > > > Default Operation.
> > > >
> > > > Therefore, after PSSourceOffTimer timeout, the tcpm state machine s=
hould
> > > > switch from PR_SWAP_SNK_SRC_SINK_OFF to ERROR_RECOVERY. This can al=
so solve
> > > > the test items in the USB power delivery compliance test:
> > > > TEST.PD.PROT.SNK.12 PR_Swap =E2=80=93 PSSourceOffTimer Timeout
> >
> > Thanks for fixing this !
> >
> > > >
> > > > [1] https://usb.org/document-library/usb-power-delivery-compliance-=
test-specification-0/USB_PD3_CTS_Q4_2025_OR.zip
> > > >
> > > > Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm=
)")
> > > > Cc: stable@vger.kernel.org
> > > >
> > nit: Empty line not needed here.
> >
> Modifications for the next version
>
> > > > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > >
> > > Tested-by: Amit Sunil Dhamne <amitsd@google.com>
> >
> >
> > >
> > >
> > > Regards,
> > >
> > > Amit
> > >
> > > > ---
> > > >   drivers/usb/typec/tcpm/tcpm.c | 3 +--
> > > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm=
/tcpm.c
> > > > index 47be450d2be3..6bf1a22c785a 100644
> > > > --- a/drivers/usb/typec/tcpm/tcpm.c
> > > > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > > > @@ -5591,8 +5591,7 @@ static void run_state_machine(struct tcpm_por=
t *port)
> > > >               tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PW=
R_MODE_USB,
> > > >                                                      port->pps_data=
.active, 0);
> > > >               tcpm_set_charge(port, false);
> > > > -             tcpm_set_state(port, hard_reset_state(port),
> > > > -                            port->timings.ps_src_off_time);
> > > > +             tcpm_set_state(port, ERROR_RECOVERY, port->timings.ps=
_src_off_time);
> > > >               break;
> > > >       case PR_SWAP_SNK_SRC_SOURCE_ON:
> > > >               tcpm_enable_auto_vbus_discharge(port, true);

