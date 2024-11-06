Return-Path: <stable+bounces-90051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0CF9BDD98
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 04:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3A8BB2350D
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC1519007D;
	Wed,  6 Nov 2024 03:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TlxPspo5"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818A2190068
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 03:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730863756; cv=none; b=LFVgI7QFoeeBksupUA/PVUc+8kfrFqBW5M6vdrM4SYvKMT9Ekh3lbUMMKYFavY6J8UUl771EZbTZWVTwFxWLvsaPJQhjQ6zORuni44xi3PWLhCP4WYB27P5eOuPQCAVE1sgpK9TzNbrI4Q3UsAhiubxqt+Pfq7vz2oSIKZDxuh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730863756; c=relaxed/simple;
	bh=4nr36i8ncn5QgwCNYzUTwS3T0ZF0gZikBgpziVS7RTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMzehf8hRlp+dsdYQkgyHPGhacOjd9RKVdG2hrOyK+IwfD/EnvqWR4BsNgpDHywZnouATfErYDd6CmTWD4qxV3VkPzw41b3+MEvSXAhpnXQZ2WN77gEUzNJcI4BK3VZqCvaJsYSCygaZ1/F3k2cMmQBwZEcHP2tPx4BEKhlEajY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TlxPspo5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730863753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nr36i8ncn5QgwCNYzUTwS3T0ZF0gZikBgpziVS7RTA=;
	b=TlxPspo5t4LqbSEECOEVfG5QXE3ImxWyLseUtUqy1uYxho8Coi9hSQjoggCZwTdi9e8wYs
	4JOtCOVXqwjSYqSJpjpdjBEv28ru6oC40rDZUYxr7dm/oDBlV/tEFqe+RFYHkeE6cLBqz+
	3AR24KYu92HHloVtxdzuuZ66KGvdN9k=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-PadIAJubM52i8x5p6s0dLQ-1; Tue, 05 Nov 2024 22:29:12 -0500
X-MC-Unique: PadIAJubM52i8x5p6s0dLQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7202dfaa53fso8849379b3a.0
        for <stable@vger.kernel.org>; Tue, 05 Nov 2024 19:29:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730863751; x=1731468551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nr36i8ncn5QgwCNYzUTwS3T0ZF0gZikBgpziVS7RTA=;
        b=h/TOe+gEwH/JmzAPKnndYTNjcsVr4KvUNjtbbeflZmkxJ95Jr2bd0+lSf9LVan1W3Q
         oK3mBunqVU7n33KJSyHZ8sD2y7IEftyiVwRVrS/ZjSxX6ViHdScSPuB10dpalLNs5ROz
         lqgAB5ujgqmtJQ0bSSx0Ot1x6pM/u5oSCPr2KvAVaFiJvJvcdF+iP11LXr2588OemwRB
         WFuDxqnYc+c+ztbYFwRkeyE7YnhpflHlmP6ZVMRKlM2/6FxcyIKTlq5h2e+xHUEcIbpv
         xVSjYysaBqADpNa8xk8tnadRJIjxPHSumHBiq5ddUXqJtIKYjsaPKtVYTd4ISVeVnI7d
         i7qw==
X-Forwarded-Encrypted: i=1; AJvYcCUZDloAbzLHhDokrvXD9raoX4BtAVw0+o5KS6klz5vhKTZlFUS+GKhy5nQIV7kM4VjSj2sy9O4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmGJWN/z8O8zwaEccGxUUXL0XQc3BX0XRoKn9/eSH42Ej73vSi
	hd4kSWUOnM/teZ0ahNnR+KtvBdMqUCAf4Iszlomb3f6lIHge3iI7krPg9R9vPiVbTEyfV4YtE7I
	mp4lyw2zJr5YqO21mSMJFPe36Jrp8SkrjCcCaGLrolpPcT0M2SZw1qJh76RRJ1nuf1UZ+n0uiRF
	dNvTj5tBtan9X7FTK332Yq+BPLGqFD
X-Received: by 2002:a05:6a21:6d95:b0:1db:e0d7:675c with SMTP id adf61e73a8af0-1dbe0d7d5a5mr11226474637.13.1730863751262;
        Tue, 05 Nov 2024 19:29:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHx61FBBG5j53znRiOsXbThjFE8yVx8cJX3fGJ5TJniNqc/KssM4f1OUImXXv2t+j7CgZ/mWxaKbxS+WYdiaFY=
X-Received: by 2002:a05:6a21:6d95:b0:1db:e0d7:675c with SMTP id
 adf61e73a8af0-1dbe0d7d5a5mr11226463637.13.1730863750851; Tue, 05 Nov 2024
 19:29:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133518.1494-1-lege.wang@jaguarmicro.com>
In-Reply-To: <20241105133518.1494-1-lege.wang@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 6 Nov 2024 11:28:59 +0800
Message-ID: <CACGkMEuYswywBX6P9GQEd4nz179RoCn6TZCseiCprm5iqRW3XQ@mail.gmail.com>
Subject: Re: [PATCH V3] vp_vdpa: fix id_table array not null terminated error
To: Xiaoguang Wang <lege.wang@jaguarmicro.com>
Cc: virtualization@lists.linux.dev, stable@vger.kernel.org, mst@redhat.com, 
	parav@nvidia.com, Angus Chen <angus.chen@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 9:35=E2=80=AFPM Xiaoguang Wang <lege.wang@jaguarmicr=
o.com> wrote:
>
> Allocate one extra virtio_device_id as null terminator, otherwise
> vdpa_mgmtdev_get_classes() may iterate multiple times and visit
> undefined memory.
>
> Fixes: ffbda8e9df10 ("vdpa/vp_vdpa : add vdpa tool support in vp_vdpa")
> Cc: stable@vger.kernel.org
> Suggested-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> Signed-off-by: Xiaoguang Wang <lege.wang@jaguarmicro.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


