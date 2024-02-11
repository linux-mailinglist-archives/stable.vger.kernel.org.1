Return-Path: <stable+bounces-19444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8CD850B7E
	for <lists+stable@lfdr.de>; Sun, 11 Feb 2024 21:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1FE282FA3
	for <lists+stable@lfdr.de>; Sun, 11 Feb 2024 20:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6177D59B79;
	Sun, 11 Feb 2024 20:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bmU90aDV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478B55F466
	for <stable@vger.kernel.org>; Sun, 11 Feb 2024 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707684413; cv=none; b=A46/Xa1afcTygkVTn5ph51edNlfkn4m+IZ3DUtOBRejrdhkgQZkBvZO0Ow/VX1R3i/FSpI+tlYVT6EQw8m26O7p9HvVK0RSP/UqouVe3eIMHzNczdxQoB1T30U4O9+uUJioOlHOvJE9+FwqjiIAdg0hVLG7KYNQ8IIGcn/WeLqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707684413; c=relaxed/simple;
	bh=bEy3fwndTKbLWkFzl4W3XVSdL3IHmugTfiQM9pJOSr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=EKoEqjwWria8vQWoUduDQ0b+ACKb8IFKonss1LsTf0QAV5dhx+FWOFNiI+dA7VQOmjg8wvQsHYJxMiu+ApkUapYiDXot2wf2+8BUyiHzXHXdM9hlAn4YhEW934Hz4dd+EigBxHYzEgkenFXfyWPtVAOXr5LOUTyT0gjza9gzZdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bmU90aDV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3be9edf370so280658766b.2
        for <stable@vger.kernel.org>; Sun, 11 Feb 2024 12:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707684409; x=1708289209; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBIrAr5FZ5+RYVT0DmsIdOiOkCMGQQkT7bJlGkB6jNU=;
        b=bmU90aDV5zFXH/VfEV5QQpQGAO2kOeZV0b+8r5zSCH7YzZZoqDWabcA/3dRWD0zQtB
         Ve/AVLBiegNMeeWjv79Z6pCEsJU18NiEl1H88aK5owQEMEcJ1pLc5+NSk8yXtePRP44w
         RmIdi654E3SrRlFNG2kYqI/ODWQ0n3E+MzbAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707684409; x=1708289209;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBIrAr5FZ5+RYVT0DmsIdOiOkCMGQQkT7bJlGkB6jNU=;
        b=nbMsNgq/h4C9hRHNX5Gxl2UseQOS1sFtDgwQGMlmTtwgIbKGVUOAefFQVMYTTzyLV8
         TvQJjXfvE4Rjr+mKXHIqskz6zQWwRtvQOmfuPCdYrjzMAMn+T1KoCBWC0NZnFy0tjRkx
         En7X75zMXVsp6qrTLy/rVX5peQx0/TVL0dx1nYUs0+L1OHJ+EDEsJz2dOgm9/H9UbQa6
         Gr0B8QDUU0hFokMg3EMf61jtaKs1LANbueZTsgB0JT3GN6FTy3MS66p8CWSlpJjAypGz
         FmFboab6nAZGtCXZd5pSJe3kPEbvH6MhIc6hc+WjvqRKC/4Bsl5clY6EpC6PSo98GesV
         RvMA==
X-Gm-Message-State: AOJu0Yy28Nk+WyOnTHFb4PL4Aw04CwCc57nIPIsylExmR7NEJAPHdw/h
	gqoYqUj4XWamsRMPKepwOuaMBXDkp0aVGcQzn03xXkL9dsSFFw5fsOWnYoXYB6oMchEXfW66LCl
	PEnNX0jveyIG5EWd9XLxa2m6PGBIh56wN9ryvTqOiZAp5z0w=
X-Google-Smtp-Source: AGHT+IENbjN4Nkv+xSZqobtORX8IXHoL4HyiaaQ/HQoMPRst0icSaWD66Ksoz3b/0Y/49zTPm92Dg6UsyDm4MF5sOA8=
X-Received: by 2002:a17:906:3596:b0:a38:35c5:76f0 with SMTP id
 o22-20020a170906359600b00a3835c576f0mr2882905ejb.11.1707684409186; Sun, 11
 Feb 2024 12:46:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210201237.3089385-1-guruswamy.basavaiah@broadcom.com>
 <20240210201237.3089385-4-guruswamy.basavaiah@broadcom.com> <CAOgUPBsTgdqko3MwpWsjLfSDZp_4CRiRwALcsWSJQKTuML6aQw@mail.gmail.com>
In-Reply-To: <CAOgUPBsTgdqko3MwpWsjLfSDZp_4CRiRwALcsWSJQKTuML6aQw@mail.gmail.com>
From: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
Date: Mon, 12 Feb 2024 02:16:37 +0530
Message-ID: <CAOgUPBtJPGgb-6COBboJBsVkQ-Q0tu44eKFUwmXmcjXrWKbLbA@mail.gmail.com>
Subject: Re: [PATCH 5.15.y 0/3] Backport Fixes to 5.15.y
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, 
	Tapas Kundu <tapas.kundu@broadcom.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Steve French <stfrench@microsoft.com>, Paulo Alcantara <pc@manguebit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am withdrawing the current series of patches submitted with subject
"Backport Fixes to 5.15.y" to branch 5.15.y, as they had the wrong branch
information in the subject line.
The correct branch information will be included in the subject line and I w=
ill
resend the patches shortly. I apologize for any confusion caused.

Guru

On Sun, Feb 11, 2024 at 2:25=E2=80=AFAM Guruswamy Basavaiah
<guruswamy.basavaiah@broadcom.com> wrote:
>
> The subject lines for patch 2/3 and patch 3/3 incorrectly mentioned
> "5.10.y" instead of the intended "5.15.y."
> These patches are intended for the 5.15.y branch, not the 5.10.y branch.
>
> On Sun, Feb 11, 2024 at 1:43=E2=80=AFAM Guruswamy Basavaiah
> <guruswamy.basavaiah@broadcom.com> wrote:
> >
> > Here are the three backported patches aimed at addressing a potential
> > crash and an actual crash.
> >
> > Patch 1 Fix potential OOB access in receive_encrypted_standard() if
> > server returned a large shdr->NextCommand in cifs.
> >
> > Patch 2 fix validate offsets and lengths before dereferencing create
> > contexts in smb2_parse_contexts().
> >
> > Patch 3 fix issue in patch 2.
> >
> > The original patches were authored by Paulo Alcantara <pc@manguebit.com=
>.
> > Original Patches:
> > 1. eec04ea11969 ("smb: client: fix OOB in receive_encrypted_standard()"=
)
> > 2. af1689a9b770 ("smb: client: fix potential OOBs in smb2_parse_context=
s()")
> > 3. 76025cc2285d ("smb: client: fix parsing of SMB3.1.1 POSIX create con=
text")
> >
> > Please review and consider applying these patches.
> >
> > https://lore.kernel.org/all/2023121834-semisoft-snarl-49ad@gregkh/
> >
> > fs/cifs/smb2ops.c   |  4 +++-
> > fs/cifs/smb2pdu.c   | 93 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++-------------------------------------
> > fs/cifs/smb2proto.h | 12 +++++++-----
> > 3 files changed, 66 insertions(+), 43 deletions(-)
> >

