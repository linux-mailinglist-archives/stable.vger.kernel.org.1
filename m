Return-Path: <stable+bounces-167024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3172FB205BE
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 12:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A18A3BEF4C
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 10:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E3F26AA88;
	Mon, 11 Aug 2025 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FU/h3gbZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505BD25FA0F
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908618; cv=none; b=XaWMaXuRezZUVGjFH31Fl0B5VEz6f76BoMqFUTEfu/0uq7neU27UD1imh/ILHCSVLLcT5RUte09OAGxYM+rJbnKFYdmaHxXtDqz4NYcNEGqh9RonFLvlSwYx81noWv+fHmYNlUwovHcrN0roCRxVLjd4x6w5din4KfEiPE0XgUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908618; c=relaxed/simple;
	bh=xR3ED7P5d6g5pj44vG6qM16AEcp3rM710QWeT+iy0p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYDEZMz3H/T4rxuIonPxX/eUUYKlbZkyEHVzP4S+KnvbJqBKOglMC1B4yR1a/OaFaZ7Qwl9pxYMPmGweT1MskN9CZHnluyghabbYWrZAOpzkFZ3luxUI/M/IsFX0pHVPLjYVe+th48chKXm6pQifASaTgnHgp9IpC3v+3nVt7MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FU/h3gbZ; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-70744e8ed6eso35671606d6.2
        for <stable@vger.kernel.org>; Mon, 11 Aug 2025 03:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908615; x=1755513415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YF6WOmwfHFHIQd/1Z730F2pm4AXsjtuGip5qrJTB4TI=;
        b=jiT4J+lwaD45KAFWpO4OFM3igwM04vy9167opmbKM65exvAn7CskiSMnn6+dHEe7Vp
         OK0a0q9DbrDcZBLkAkS/EeLxMqhYR5v/uI21lo5xQS9Ymn1101jEZN89bLqVXkiwzhFC
         UYtl7QgFSn6wR3jjmnhboDOmd+07QhbF5qwGc2PsphzMTiuQczpJZo9S5+/sNLMSzWrI
         2BGF6Wf8ziLir3mwS8GwhLV/yHghem2yXKp0rviS2R4xzM/9hJBaxlFQ+dHsBv5MQ+jo
         ky6EaEdLN6T3VfcLyq2+lRS/mSSe9zE0nioFR/nukjxv0a5SZ1j6X6gbWSF5VCqDpVmt
         PXPw==
X-Forwarded-Encrypted: i=1; AJvYcCXMEnN6CXMFZ1col1dAHuYhCZh6m8d2irQY8GCF38dMfEz/9NiGsN2t/mgZpqsRb4sComArxKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPzXvAWI/eCkSyGVYJ2gmD8v0IpBgNX8f3ZYLcXELlQ4v1y6z3
	XlIR2+JwfkjhhHpJ5BhjXjztFqmmls21VCdwnJi0mdYNDbABQcOcfqWDWv1YKYNl9Hna/M/52N8
	U+ZAVEc6EECc7YrWnd52ttWJwn23LBrCn0ba2GMStZwjvdpDkRQjgaZUkMlcpH9tODayCj3gL05
	oinnN3/RDjX80xcQ4r9Xty72+KC6cCnIq+WYX5ms2KpuR1PN8hojY5vtvc/df+9oyAqPx1ncrAP
	eAqCdYu3XG3O2hJKA==
X-Gm-Gg: ASbGnct0Fz815HSYGtMn2ZU2gI2WmoCwFUl1saYF1HbqtJyQxyg4uI66KjG9buDEHNt
	2VIl1TbnjNHzeuUwS79IBwTe9bewdBBslV6/axJzMn5txS/8eb7JiRBYtRli+sVk8Y0yfruaTAv
	kGyZ032kBRRQVNbDc6+mDUagEZiPPA1T0Kr85oaFR+ueLp+pOdzpN22QPCaPntCOe4wS6WP8Gje
	FfmtOxuH3IVX5NrfEtvRHdZ7iAWpjiJkwJzPAWewwZKIj9ul1DLkaEtTkC5PnQpGCRjGkQvTVVY
	XpxeuNmCVHs21n89eCLG5Vmb2AMXOTb/TdO+Googs6GSYm5yGanVOrWboftJdHmWYLr7B3sTP7h
	sEKRBXFHoOwLClSrsW/Sh2QCTf2mFFbrEGPUWTUmwhurd9TW/XlExTi5PIh3Et251TZ7hBzRBuO
	D7
X-Google-Smtp-Source: AGHT+IHfnEcvzOrOxTEoyXttjOIOPux1+fzsIpNOzmWmMIfG8r5v78DU36HgHpREoUwBwqEnfpzwNFs40L7a
X-Received: by 2002:a05:6214:8007:b0:709:b6a7:6226 with SMTP id 6a1803df08f44-709b6a7636fmr73892836d6.34.1754908615004;
        Mon, 11 Aug 2025 03:36:55 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-7077c98938bsm16078266d6.38.2025.08.11.03.36.54
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Aug 2025 03:36:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-33272ab5ed4so18879671fa.3
        for <stable@vger.kernel.org>; Mon, 11 Aug 2025 03:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754908613; x=1755513413; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YF6WOmwfHFHIQd/1Z730F2pm4AXsjtuGip5qrJTB4TI=;
        b=FU/h3gbZ8hIEBYTBq2HXt6HHfaDEahhJyTHVRO3p5QbRt9E9b5QL4Det5MFim8KAkg
         3x95QHz+4WdBhCUR3SxbvpxOd90w8alJ9eHggIZCs1IfxcDfIYNp2m2/AFsr4kdeJNDW
         t40o4cmOk/yc968LfthXsplL/FZ0KxvS/h9xQ=
X-Forwarded-Encrypted: i=1; AJvYcCUx656WUYstPR6PFMGNjpywPEB2dWb7dMed1JbSZGscRJn6019Blj5OF9RAz4oICnQPZlCyUX4=@vger.kernel.org
X-Received: by 2002:a2e:b8d6:0:b0:330:d981:1755 with SMTP id 38308e7fff4ca-333a210d629mr31287121fa.6.1754908612706;
        Mon, 11 Aug 2025 03:36:52 -0700 (PDT)
X-Received: by 2002:a2e:b8d6:0:b0:330:d981:1755 with SMTP id
 38308e7fff4ca-333a210d629mr31287081fa.6.1754908612199; Mon, 11 Aug 2025
 03:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811052035.145021-1-shivani.agarwal@broadcom.com> <7c7aedbf-389d-4e5a-83d0-33c51cda1d8a@web.de>
In-Reply-To: <7c7aedbf-389d-4e5a-83d0-33c51cda1d8a@web.de>
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
Date: Mon, 11 Aug 2025 16:06:40 +0530
X-Gm-Features: Ac12FXwNglXMtrgIIpAb8_5Z4UtmkHGLxNPDlnxZm1tW0Yi4PWiSy2OxteVobxs
Message-ID: <CANTE3ihiPx2GZDcUWcO-YR8h-tNrsCtJ=jH7Kzd08Y8qDxZk9A@mail.gmail.com>
Subject: Re: [PATCH v5.10] scsi: pm80xx: Fix memory leak during rmmod
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Sasha Levin <sashal@kernel.org>, Viswas G <Viswas.G@microchip.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Ajish Koshy <Ajish.Koshy@microchip.com>, 
	Jack Wang <jinpu.wang@ionos.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-scsi@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, 
	stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jack Wang <jinpu.wang@cloud.ionos.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Tapas Kundu <tapas.kundu@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000806afb063c148093"

--000000000000806afb063c148093
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 1:30=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> =E2=80=A6
> > +++ b/drivers/scsi/pm8001/pm8001_init.c
> =E2=80=A6
> > @@ -1226,6 +1227,16 @@ static void pm8001_pci_remove(struct pci_dev *pd=
ev)
> >                       tasklet_kill(&pm8001_ha->tasklet[j]);
> >  #endif
> >       scsi_host_put(pm8001_ha->shost);
> > +
> > +     for (i =3D 0; i < pm8001_ha->ccb_count; i++) {
> > +             dma_free_coherent(&pm8001_ha->pdev->dev,
> > +                     sizeof(struct pm8001_prd) * PM8001_MAX_DMA_SG,
> > +                     pm8001_ha->ccb_info[i].buf_prd,
> > +                     pm8001_ha->ccb_info[i].ccb_dma_handle);
> > +     }
>
> May curly brackets be omitted here?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/coding-style.rst?h=3Dv6.16#n197

Thanks, Markus. I agree with you and have no objection. However, for
the stable branches, we usually keep the patches unchanged.
I think it would be good to remove these curly braces in the Linux
master branch as well. Should I go ahead and submit a patch for the
master branch too?

Regards,
Shivani

--000000000000806afb063c148093
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
iRPJW7xMdyXlghl13B29WFHBvkcVJoRG7X1q9hGiJ6cP+UffhEHqOIAfa+w9JdtfPmRdIei9rDMG
13qTNm0LSI5pyK2hrV1mJ69tfsMsfB7sejsTuTOfw/7DV6KBse6HCG6+EopHpBKz+ZrTMOJo5UxE
en1o7UfNuVpRJRpTSkEXMRntyMcIEyWmGBpUN644f3dX8Wrd6HHYhLRqATO+uwIDAQABo4IB3TCC
AdkwDgYDVR0PAQH/BAQDAgWgMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5Bggr
BgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUG
A1UdIAReMFwwCQYHZ4EMAQUDATALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEEG
A1UdHwQ6MDgwNqA0oDKGMGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2Ey
MDIzLmNybDAnBgNVHREEIDAegRxzaGl2YW5pLmFnYXJ3YWxAYnJvYWRjb20uY29tMBMGA1UdJQQM
MAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBSm
eEP07C50BiHJ6M3vZhTU/COMnzANBgkqhkiG9w0BAQsFAAOCAgEAGDK7XvmoOTcNaefKnzjIfKKD
wCbRX7fLxL0keAQAmiQNgNd7eDc/Cnlnf29QH0YYVWllIGMIiHpdfJP+W/lbdMxvCDQ/NWmnuBJ1
HgH/cJpD69x6sybVo2zvbeavlHsFLCWpfDfgY9p8j/flVo1SWPcQG+udOqyXwh+nGwHhiuKAiEBy
jBEEs+ngv59U/j1cvJ9pXlaGTC9NOkP1XliIs3nlytpQXJG1weyZzkY4DZf4klN3cHOSQTvF7vjy
aY7hNcp1YrHDxsqoKdQvazng3Y96w/GEAgcaZhITyrH6mCC8+/oJC3HpM0k4K7Z2Vi1m1v3Jq/Kn
lQkI8Dv80Uhgt6bvS+KOVU1vLDk5B7tcy4kSASakBiXbjOIQTjGUFAFM45yN+Tv2vS8o4QbX2nRl
8yzOosbR0aM7SFOnifxUub/2hhQl5W1ZNeoOL1bZUskIQ+VsgxQxNtqMXf7uupJq2sVzutbf3lEh
Z+E/GB50TcPGfgSBH3kP9JH9Wd8oXJ3PN02vpjq/h3ffJEPGIPtqYkaFjI7dzhC/XpW5+A+J232c
qsnzyHW2U8vSWC5M3Mo4f8tGkjBS4qQS/eFgGz6KLcwD1SjhPzgp5NZN2W2jYEVoPmBNAeNnm/tW
lDghRb6zt3dVU5NEcysBUTIydLMkLuoWGzgRJx8fFpe/qziOJKsxggJXMIICUwIBATBiMFIxCzAJ
BgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWdu
IEdDQyBSNiBTTUlNRSBDQSAyMDIzAgxdbqmjX1toyzmQTGMwDQYJYIZIAWUDBAIBBQCggccwLwYJ
KoZIhvcNAQkEMSIEIOyZsF/EZr9UY9sn0SgzJ7df5XeBlNevmWV5WucHmHNjMBgGCSqGSIb3DQEJ
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDgxMTEwMzY1M1owXAYJKoZIhvcNAQkP
MU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAL
BgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAAswuCQnRa9zy1/Pu9Pn
L+IfU9Er4FLnLn6+mciixXSbtUNU5zjeU5Ld5uieSbMsEvE8oURRKL/uW01o+Lox2cWEL73iJQt2
UhymzWluj6x0JP3Juw5AqeeNiqatAOTnsDzvPWctguCei0HTKRK9wocmmzA9vPviwKWKSialj4Ws
tIu2zQj+gTqW1y+hVbKWxv7necl5KcKDv4RJIbnuxPPBaDQyEZUDAj7dPVD7ta1b4GSEcg5OXW2v
5pSR8lOq/vZyNKNS4QoO7JjqUNYXQFXXeSoAVM1tewRfinRDcKNsO1r5+OFxfs1aoJnwieqQ1q0o
cGGxlY1tiybWqHZXXoc=
--000000000000806afb063c148093--

