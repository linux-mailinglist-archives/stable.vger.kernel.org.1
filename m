Return-Path: <stable+bounces-118535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED75A3E9B2
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 02:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4613B05BD
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 01:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC2A3F9FB;
	Fri, 21 Feb 2025 01:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cwej9MYo"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F57A3594F
	for <stable@vger.kernel.org>; Fri, 21 Feb 2025 01:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100379; cv=none; b=OD66Cx6cHwBPexN8ypfOehmhW4G93ADOipOYMf51xe/C7eye4SPBWgPZah0LBCRwbGQP8gvzUp4HXn2UY91S6+j57ut0yeNKPpegkuQKCPOirFDQvJDOAltkrz5pjtkpd1ekmwy/raGtwD4ySiMeorSzfoYnGsON3Y8Mu0mHDVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100379; c=relaxed/simple;
	bh=Uq7GzPfQ3uC0UiGgLsywtL1UAOYX+nwobFKbFtjrYR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVXYM9JEBCBgkWpTPKiXGR7LypSRKyxikimh5gNzZMZGQ/waD+bHhrxrrBV1s3rCGUie4O/Hi+MlL8So/6zFuAiKECBRd2YFUbpsO210jF1FiXY9FHUKNN8vSIvDxBk7TcZcxyj2cKAZ/Jo07ukmEKC20r4eZfs7PuUkk50oMPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cwej9MYo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740100377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uq7GzPfQ3uC0UiGgLsywtL1UAOYX+nwobFKbFtjrYR8=;
	b=Cwej9MYobLgPbWuEq0/9OlWxMi78UwKh6d66VQYPVtB5EVFs0lgfopPiBZD3CDpSCsAwRr
	kmOq/OhVFG/MP+e6jBg5xVbxEy0FWvSjyetyQ+oaTqKNDYrMR6zKL5cgIu0/CavgIEAfGy
	m/tifV/BbRNtCr4G00z2rnh/hpL+BcM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-ilEALwShNLeuWvgEoB0PAA-1; Thu, 20 Feb 2025 20:12:54 -0500
X-MC-Unique: ilEALwShNLeuWvgEoB0PAA-1
X-Mimecast-MFC-AGG-ID: ilEALwShNLeuWvgEoB0PAA_1740100373
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc1cb0c2cbso5077800a91.1
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 17:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740100373; x=1740705173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uq7GzPfQ3uC0UiGgLsywtL1UAOYX+nwobFKbFtjrYR8=;
        b=Ll3ANMidItKZsTU56RbDUM7gIfSsLbkmnc5DwklVj97jUCjmQj3BjBg7kd3KrifnMw
         M5o2Mv5EBcBYp5pTuR/ECezG01EUurM6oYYsUnxUXaj6jIgaJlFCNDhy+kSqU+2X3fih
         +13ZV8KQC/bMwZqebr/q5y/JP01+dZstIZmOtABmFeA0/uY8X/kTzCHQPb0ugdQzXtCU
         /CzbPGAVhD7MIU8jZVDPzAERnmVahMHnePlNcmcSIqSJJS8GWsy3uBK5l/zPNusLXPLJ
         bC+sBDDEBgUtrjoAveMQ0dk4qIEW/Me5XABfv4pcxz0YkYwHQEK6XXOPbGomkLQy+Mpd
         Gwog==
X-Forwarded-Encrypted: i=1; AJvYcCVpuof43vI+nyoeptSqTclQJWfEWiwcijVeZXEpipDjF7twBeaWDDCxKsJXkSR6ukcR7E9cC44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8MfS0l16JyLLzng3RKUsreh6lCoKTx4UXAuSOtCw/G0yHQjom
	cQMK1yMWAFREcn59+fjmn6A8CzE3JXxgP7cTBGzCMDiH5+V2KopCrA3qtmsx97zl8Vdn2rXVERs
	8x+2wVAnBAroCpIXfcXxVm5xkT795m/eXLl5P0kGOMmePQcUQpZ+JsVq/3CpaA8Dw3KxEkot/UO
	fHpd0yVD3foxwL42+c45h5hl/0shfb
X-Gm-Gg: ASbGncsuJmA3DkYo4s+H9cWyBRDSEbWZA7R3ZpoLZMqC0yJI5gbihx+eVmwi++hJXYa
	Ii4jR8bReOe67XYzQshIOXcYjWjpzJDkEaFctG4mTH7w0YwOCPTlbe607QJJcEoI=
X-Received: by 2002:a17:90b:5310:b0:2ea:696d:732f with SMTP id 98e67ed59e1d1-2fce7b271a4mr2148902a91.29.1740100373609;
        Thu, 20 Feb 2025 17:12:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnQJ9hWU4v+2TwwECUtm6Pf8c9YX7B6ZUHd/Hqnqd2kx0Bc2ftH5qx2hCH5z2BE+GZRURxv4Goas3NlmOaXUg=
X-Received: by 2002:a17:90b:5310:b0:2ea:696d:732f with SMTP id
 98e67ed59e1d1-2fce7b271a4mr2148854a91.29.1740100372927; Thu, 20 Feb 2025
 17:12:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220193732.521462-2-dtatulea@nvidia.com>
In-Reply-To: <20250220193732.521462-2-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Feb 2025 09:12:41 +0800
X-Gm-Features: AWEUYZkw-CTw854l_MFE994dYvtfLs30K1XdrnaRr8wNLayyzmZm48vwiDxgk6A
Message-ID: <CACGkMEuUsh-wH=fWPp66XAFeE_xux-drf1gatSQSiGuS_rO_zQ@mail.gmail.com>
Subject: Re: [PATCH vhost v2] vdpa/mlx5: Fix oversized null mkey longer than 32bit
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, stable@vger.kernel.org, 
	Cong Meng <cong.meng@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 3:40=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> From: Si-Wei Liu <si-wei.liu@oracle.com>
>
> create_user_mr() has correct code to count the number of null keys
> used to fill in a hole for the memory map. However, fill_indir()
> does not follow the same to cap the range up to the 1GB limit
> correspondingly. Fill in more null keys for the gaps in between,
> so that null keys are correctly populated.
>
> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> Cc: stable@vger.kernel.org
> Reported-by: Cong Meng <cong.meng@oracle.com>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


