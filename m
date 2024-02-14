Return-Path: <stable+bounces-20221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63502855714
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 00:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BAA729031C
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 23:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F90E1420B2;
	Wed, 14 Feb 2024 23:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CcWywS/p"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19081474B1
	for <stable@vger.kernel.org>; Wed, 14 Feb 2024 23:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952464; cv=none; b=rAHhogoFfa/iEVLEeICUjALBsBVkYc7K1myIWXzmmPaJMAX1MEtmzo5JgowVAt7rHrtseclTbHgS1iZhrct/LCjPcJ/cVuCuc6GuxH8hoaRNUSVEK6EoVACMP8imT7P0ae3CjSLBS9BAi+6hCN5xV39o110dEqvJQ7IL+e8oSuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952464; c=relaxed/simple;
	bh=9+dCxs0xsYhTXZ07xpquz6ytsf91ewkmJTIEICMPV/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkeM2rBPqu0El/BqyIwH8oJyXEWJpKCO9kktmhM/cgCPAMLCH9tY2dBPqxCcAIV158kZHMUZBIKWDROSH2MtYQ6O7nx4mkwcB/jycQfUkfISizXsaWVYJM1lXPrmaL0Shnw8fbpeNvdzZHqURnYGiX3C+fg5EdbKFt0kJd93Fw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CcWywS/p; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3d52d40569so28796866b.0
        for <stable@vger.kernel.org>; Wed, 14 Feb 2024 15:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707952460; x=1708557260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k00c+eMas0sQrVf5Mkf37AkgKjaEP45uEEFu+ncFEjE=;
        b=CcWywS/pQ2ED1pvf7mky0jdOGGeuJmEeaLNMJzJh6VMpp/p4Xo7qWAj6jD5iw/HPP9
         QwkVOtk98I2Cb+7ZJtYSxUqUHSrNPCCsgNBs9mDPvlx4M8f+UcqyJ6zcYBLeMV8ca85Q
         W2Uh12b+AhxjPH3X8DlC6/8Nc/zO0w2iWnb6NaPRlGQe/QWYdDu6Nh9j+cT4S1+BXDfK
         rLF82ZPcfhgBP4DNC3CCX2PeyDdDULdvM0HXISLkZA3wo/NHVShDrtFeIpBDdCzR5kQ1
         fJAIno+UMSLahQd26WQ75qbpZUvvHx+pn7JM5WlQyooDUvulH1sGq2BxdhYUgC/fTNyS
         FiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707952460; x=1708557260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k00c+eMas0sQrVf5Mkf37AkgKjaEP45uEEFu+ncFEjE=;
        b=ZzKWivlQdvZPczoMbNRN1z0DDZFygzG4A2hJNI6Ohfi57tqeePDBfDf3SGxV0BWnB/
         A51tCCr5KEfsnmItGipsr3kxWlODvK4h7YlV3uFkyVFwouA0QnWgAZDwS4FZssMZ/bKo
         VaW/02N8CmQutCggsKrcyLmvenmx4RL53JpUJOQdq4xEAQM74E15GHmeOCjNHChUuMUp
         t6/wOZF4Vk5Civq1UzG+Pq98jH5znyH9fN6UoCMzx7OOMFWCwLCxtCDRrdsffThVSAnd
         zm6JTZ8+s37f9o7Am6i2LHcDgoXWM/bfNhyyUPzRn4VOMbvKRW6w1KI8teNLG1tEuiXK
         Ki2A==
X-Forwarded-Encrypted: i=1; AJvYcCUJKiYlQUZ5FLNKreXMBxw6sKBhN8UyD6H4sx0G+0knyqJ7MH5Y08j6urIsOKQe0FQWUuHV7Y1nvvjRnJD7+gGudvE/4M0m
X-Gm-Message-State: AOJu0YzHw4ND05rpCLFY9HuL58u/LtweGLQtcFgcX/6Ko42eX/WWVeNX
	cnmkiviy91GpK0MwpGwabC3F+6QQE6LmJ7Nu25vg5X+9oUvQ6HbQtbe1uqwyCVw3kwjzuDzOxOq
	X4ftu9UOhrVqartV9OC4dPjM53K4N3TF0Uklb5g==
X-Google-Smtp-Source: AGHT+IEmSOh2SgQ6iNK8etMSaX5/e78N71ehh9lNYrzUHKOujHsQMSgwOywTv73GH10jE/Uu3g98mZAN+6w1KzwOFJY=
X-Received: by 2002:a17:906:bc5a:b0:a3c:875b:f378 with SMTP id
 s26-20020a170906bc5a00b00a3c875bf378mr5885ejv.36.1707952459921; Wed, 14 Feb
 2024 15:14:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214221411.2888112-1-martin.petersen@oracle.com>
In-Reply-To: <20240214221411.2888112-1-martin.petersen@oracle.com>
From: Lee Duncan <lduncan@suse.com>
Date: Wed, 14 Feb 2024 15:14:08 -0800
Message-ID: <CAPj3X_WBdsoYJKbkpx8Bmkjd1ud=eKC6z-qwO3OW5Z+894-kbA@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: core: Consult supported VPD page list prior to
 fetching page
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, belegdol@gmail.com, 
	stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 2:14=E2=80=AFPM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
> Commit c92a6b5d6335 ("scsi: core: Query VPD size before getting full
> page") removed the logic which checks whether a VPD page is present on
> the supported pages list before asking for the page itself. That was
> done because SPC helpfully states "The Supported VPD Pages VPD page
> list may or may not include all the VPD pages that are able to be
> returned by the device server". Testing had revealed a few devices
> that supported some of the 0xBn pages but didn't actually list them in
> page 0.
>
> Julian Sikorski bisected a problem with his drive resetting during
> discovery to the commit above. As it turns out, this particular drive
> firmware will crash if we attempt to fetch page 0xB9.
>
> Various approaches were attempted to work around this. In the end,
> reinstating the logic that consults VPD page 0 before fetching any
> other page was the path of least resistance. A firmware update for the
> devices which originally compelled us to remove the check has since
> been released.
>
> Cc: stable@vger.kernel.org
> Cc: Bart Van Assche <bvanassche@acm.org>
> Fixes: c92a6b5d6335 ("scsi: core: Query VPD size before getting full page=
")
> Reported-by: Julian Sikorski <belegdol@gmail.com>
> Tested-by: Julian Sikorski <belegdol@gmail.com>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
>
> ---
>
> v2: Address Bart's comments.
> ---
>  drivers/scsi/scsi.c        | 22 ++++++++++++++++++++--
>  include/scsi/scsi_device.h |  4 ----
>  2 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 76d369343c7a..8cad9792a562 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -328,21 +328,39 @@ static int scsi_vpd_inquiry(struct scsi_device *sde=
v, unsigned char *buffer,
>         return result + 4;
>  }
>
> +enum scsi_vpd_parameters {
> +       SCSI_VPD_HEADER_SIZE =3D 4,
> +       SCSI_VPD_LIST_SIZE =3D 36,
> +};
> +
>  static int scsi_get_vpd_size(struct scsi_device *sdev, u8 page)
>  {
> -       unsigned char vpd_header[SCSI_VPD_HEADER_SIZE] __aligned(4);
> +       unsigned char vpd[SCSI_VPD_LIST_SIZE] __aligned(4);
>         int result;
>
>         if (sdev->no_vpd_size)
>                 return SCSI_DEFAULT_VPD_LEN;
>
> +       /*
> +        * Fetch the supported pages VPD and validate that the requested =
page
> +        * number is present.
> +        */
> +       if (page !=3D 0) {
> +               result =3D scsi_vpd_inquiry(sdev, vpd, 0, sizeof(vpd));
> +               if (result < SCSI_VPD_HEADER_SIZE)
> +                       return 0;
> +
> +               result -=3D SCSI_VPD_HEADER_SIZE;
> +               if (!memchr(&vpd[SCSI_VPD_HEADER_SIZE], page, result))
> +                       return 0;
> +       }
>         /*
>          * Fetch the VPD page header to find out how big the page
>          * is. This is done to prevent problems on legacy devices
>          * which can not handle allocation lengths as large as
>          * potentially requested by the caller.
>          */
> -       result =3D scsi_vpd_inquiry(sdev, vpd_header, page, sizeof(vpd_he=
ader));
> +       result =3D scsi_vpd_inquiry(sdev, vpd, page, SCSI_VPD_HEADER_SIZE=
);
>         if (result < 0)
>                 return 0;
>
> diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
> index cb019c80763b..72a6b3923fc7 100644
> --- a/include/scsi/scsi_device.h
> +++ b/include/scsi/scsi_device.h
> @@ -100,10 +100,6 @@ struct scsi_vpd {
>         unsigned char   data[];
>  };
>
> -enum scsi_vpd_parameters {
> -       SCSI_VPD_HEADER_SIZE =3D 4,
> -};
> -
>  struct scsi_device {
>         struct Scsi_Host *host;
>         struct request_queue *request_queue;
> --
> 2.42.1
>
>

Reviewed-by: Lee Duncan <lee.duncan@suse.com>

