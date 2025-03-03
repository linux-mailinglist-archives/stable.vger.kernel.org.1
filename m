Return-Path: <stable+bounces-120034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69297A4B713
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 05:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8412216CB38
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 04:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B941C860E;
	Mon,  3 Mar 2025 04:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hc6u9pgw"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0194F14D29B
	for <stable@vger.kernel.org>; Mon,  3 Mar 2025 04:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740974814; cv=none; b=fBI+MOQ6l7zxOGzeoWN2cUQQl/RkUXi+b5cnt9SiTR3uLnktH6V4ep4331Qjpt7GgU7HDZVqnfv8uxrJPW6vwG2gd71Ki8FqYhEDT/nvlpdhiOXButkWk71U+9ai6cZi8ReqEXa4CI6/ooHR8DHOOepwjCqJcCPQps7iszgiHF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740974814; c=relaxed/simple;
	bh=1wzdOirKyTsZVCC1Ram2ZbDslf5ecQQUi0CW6qdxLA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxmVMz9s4eEsFywVrE25DI0YeAXqTCTP1Q2YmXi8aJY8UzOtGaPhB/RrmplGGb8PU2k6am1wP2ptfRYzywDcEAfH3m+otKpxXKK9JfJ5vRTaZeNkfEnrshcK6766ma+0uKDPOOpcoUYUffamLCeYqyzmH0z+dsMcJPOdGfw4H4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hc6u9pgw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740974811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1wzdOirKyTsZVCC1Ram2ZbDslf5ecQQUi0CW6qdxLA4=;
	b=hc6u9pgwVV5NjNAHCrQzOlQyxCqeYVoR4Nsu4tHN5xGf1NVr+gQiFQwtTT6y18fwXFmZLw
	2zJNt+w+bCan+SDspVLgI8/p+5+26d6mJoz4XIrJoRGqPFfwUn+87h+zulJzzp3FyPc2c1
	fSiqT56bk3ByFFE0YdCFzCJQvX2NZ/U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-VgiqZSoXPIuLbAMpuuesgQ-1; Sun, 02 Mar 2025 23:06:50 -0500
X-MC-Unique: VgiqZSoXPIuLbAMpuuesgQ-1
X-Mimecast-MFC-AGG-ID: VgiqZSoXPIuLbAMpuuesgQ_1740974809
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e4a0d66c69so4920338a12.0
        for <stable@vger.kernel.org>; Sun, 02 Mar 2025 20:06:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740974809; x=1741579609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wzdOirKyTsZVCC1Ram2ZbDslf5ecQQUi0CW6qdxLA4=;
        b=wM1qoZ2tI3xyo2ZskBBnQl29fG8m7foNPfI63Cj3r9uKCVjvmSDGNKMLAUEoIF3yng
         f9tf2/+T/n4WhPTdgtWgufKaHlgcwJqvVVeRADdLNT7acbYUBPDScpaIr7dxq2V5lsz3
         m4YM5SY6GN0A9Z+jGbE8brUmgmGcYfYcbb0UqxPJSoasktZDTLzpKA8f8RKYZmV92zlk
         tb1vgZeAZuJMPG/5e3W2q3/CN+KqcE1WV9366YM1LBFmqiYjfjJRBFnDpKTMsjHkrHbT
         /k6qZ8awTckZvwlWeX5hj0lMdfrMDx41B8Q5sL0iH14WDtfxwVlrwnmorFmtG+CaoS1r
         VdIg==
X-Forwarded-Encrypted: i=1; AJvYcCUpwmGrGImKKvUNAKruGbum3U/EXa2CeMY9KGhiaINYupYihg512uCNvUlogh90jkeGOhkyJaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFZmPdUKL6gT6wvK4gwYkxO9VbkdBM3/bXKVgGTzEvE/Fiz51B
	jyxkJrgcSpljPyc7Jtoix1V1ckqGgxDl12QOjsotXJ/qO2vSCDn/mJCUZGuDQS9+7rqlpE8TyJZ
	xlxRJPNTmkjC4NqFIhaS56/2W91io8Rxnaul5mkdo71Bdf6kM0TIIfUJ4PlrK/kXqsL/F5z+rCO
	ZiUAtBcc8z0GQVjMl18M50UllmmDlR
X-Gm-Gg: ASbGncuPCHVEI+OXaALv+6RP6ArUWF5nfvDGabzOAUAP8G97SeqYpgj5TIi9OHDH7zW
	vpkF05rqOeW5m35b5/g2NeGqTwqzWQ6rMDJB8zOzo/ngSiWF0Ma3u4j13sKoLDFdQ8q2m0WxPpQ
	==
X-Received: by 2002:a17:907:6d27:b0:abf:7a26:c485 with SMTP id a640c23a62f3a-abf7a26c67fmr190821366b.50.1740974809384;
        Sun, 02 Mar 2025 20:06:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmtrdRGgr7U86+kr7f7l+xUDJuXUAyByaCCPcM629oXjBKkXRBVGvEXjN66jpswo1w8JgxuIRD6C81df5Lbfo=
X-Received: by 2002:a17:907:6d27:b0:abf:7a26:c485 with SMTP id
 a640c23a62f3a-abf7a26c67fmr190819866b.50.1740974809047; Sun, 02 Mar 2025
 20:06:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220193732.521462-2-dtatulea@nvidia.com> <CACGkMEuUsh-wH=fWPp66XAFeE_xux-drf1gatSQSiGuS_rO_zQ@mail.gmail.com>
In-Reply-To: <CACGkMEuUsh-wH=fWPp66XAFeE_xux-drf1gatSQSiGuS_rO_zQ@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 3 Mar 2025 12:06:11 +0800
X-Gm-Features: AQ5f1JqUG0YYBVOhwWGb6YuP75KRc_vcIL7Lh2pD9dN004pjvXLXIThnUsVJvbs
Message-ID: <CAPpAL=zfKkWD8BVio__qHezhs-UDht6rq7mp6Rn5Z-tQG8RW6w@mail.gmail.com>
Subject: Re: [PATCH vhost v2] vdpa/mlx5: Fix oversized null mkey longer than 32bit
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	Eugenio Perez Martin <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, stable@vger.kernel.org, 
	Jason Wang <jasowang@redhat.com>, Cong Meng <cong.meng@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this patch with virtio-net and mlx5 vdpa regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Fri, Feb 21, 2025 at 9:13=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Feb 21, 2025 at 3:40=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.c=
om> wrote:
> >
> > From: Si-Wei Liu <si-wei.liu@oracle.com>
> >
> > create_user_mr() has correct code to count the number of null keys
> > used to fill in a hole for the memory map. However, fill_indir()
> > does not follow the same to cap the range up to the 1GB limit
> > correspondingly. Fill in more null keys for the gaps in between,
> > so that null keys are correctly populated.
> >
> > Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> > Cc: stable@vger.kernel.org
> > Reported-by: Cong Meng <cong.meng@oracle.com>
> > Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
>


