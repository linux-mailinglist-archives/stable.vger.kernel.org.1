Return-Path: <stable+bounces-98737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F499E4E7F
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 08:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A73916671C
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 07:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365511B652C;
	Thu,  5 Dec 2024 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwgHppmK"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F331AF4F6
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 07:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383993; cv=none; b=i5iWzHW8XZGG/6wHoNnPDGleb4o23fZDxdPolF0uXMke5YBsFLEIVWrZAsO2ulWFQVNdjYE1rGC5rFrgtasuVghsyK8zAAAzavF4jm4YeFulF7F0OThdirM74yVjKfQenw7tSXdfnK+Ms7/US38Dy5AEmrkg+/IqDpApO61f78I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383993; c=relaxed/simple;
	bh=3vovcjPsrqh8Ljoz6njJUjJy7BIdDFIT/rdglPI+fT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkZKpYwjQHiL6u1q1rZ0PULK31YANKoO2A0kC3zLjZIGb9mJde8gewyIhcWInSiF1aWadviHWUEKrwL5SRafQx6JbY/SU8Xd2+j94rZCUyes8yRJQ/ZuU0TWg5qlADlz6zLukqw6BupVMTqmIjc8VOytKXhCNL6kwj1wezk7qBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gwgHppmK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733383990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vovcjPsrqh8Ljoz6njJUjJy7BIdDFIT/rdglPI+fT4=;
	b=gwgHppmKf39BYb+LIRVdoHBlwqmqIf1HVLqJymXDk8RJTZxWczE0oOBR8Tt+3FiRu9DTcD
	/Go5uFD8khIO1vff0894Eeyev0A6Lnhp3cHzLVKDXXQ6zlF+sCIuTGpTkSGkh1j/ZSF8sL
	GRNi5UkavOEMNoBsPRuvhexwLBl/1F4=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-K5xjNrI-PW-VrfI5kaQXAw-1; Thu, 05 Dec 2024 02:33:08 -0500
X-MC-Unique: K5xjNrI-PW-VrfI5kaQXAw-1
X-Mimecast-MFC-AGG-ID: K5xjNrI-PW-VrfI5kaQXAw
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-71d557437e0so379402a34.3
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 23:33:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383986; x=1733988786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vovcjPsrqh8Ljoz6njJUjJy7BIdDFIT/rdglPI+fT4=;
        b=gn9OmNVmPFFt8NoJ/18OT3mZpd6+T0CpyzfSwQ7thXVwgh+7XoifBrR4UztG9N2QLS
         /BYtGD1tBnpYntcNmMM8lF40JrWAy8DIYLjVI2NybgRASZPEYTH4XQBy5zKa87q4edMy
         Y2D1f2TyU040LlUJw5IUodZSL73bSM3gOOeQpy/ZJy4MBS3RG1e3+USJcM4NXH5GRSQ1
         V/PfY7ZWnFKN1fXZMfOixsBhuPkqHC9oizruIT/C58JfGZXStzoxVzUtWlftHww3NvNr
         7W87ph5xDTbdItLHPfVscTXrzs0WGc5vgmnM8rxDJOc93ki2Ek2zR8KlaHC/kLWmPknI
         VNAg==
X-Forwarded-Encrypted: i=1; AJvYcCUZiVRbRckjoFeavB3b2/UnzvH+2qK2i5vRAA+0KFnJuho4qiSrmTdbM5PNscDZPX0wC/p+Agk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCcjjpfwNtOzEBHa5pHbH+Qa1H2Sm61vLgRtFao0mP5sqhflcx
	OhOmjHWej2F4SfckUVmEvnkv+0+iGbnMGkxu/X30dvPcHG9lyfbco3KGQ6F32KlR720e/tKMc3V
	dKUH8lhZOpGzwGM5csIftsIdZqOrRqP4jPKEtV2W3d8CAbEH2EKD7f+PhlZBHUyy2//Ao6ehhnF
	GabCche+jWg53KwHw7ZHS3j0kS3e1n8qli8IQ2QVU=
X-Gm-Gg: ASbGncuKr8gtjMkzFER8KKc9GWmKAvVoNmZeJuN/2IlaUpYIpPMS+SxVyMm/rPUrG62
	WR53mVDufEpHpOIdH8qm6Z2Yybv3FAXS5
X-Received: by 2002:a05:6830:d8a:b0:718:9a71:be2f with SMTP id 46e09a7af769-71dad6da96cmr6780458a34.21.1733383986740;
        Wed, 04 Dec 2024 23:33:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDtQDoQaqM+3b+ntK9dqohRIca4r56a555HOpzjVOkBG5XoAIkxz5R1IAjDQ0aajFWY1uYgAI/ZNkMsaHUSWY=
X-Received: by 2002:a17:90b:1b4e:b0:2ee:8abd:7254 with SMTP id
 98e67ed59e1d1-2ef012748damr12711858a91.36.1733383974938; Wed, 04 Dec 2024
 23:32:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-7-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-7-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:32:43 +0800
Message-ID: <CACGkMEtkabmYmepsx-dyTbTJKq4RUh7fPVT6YubS6RFQD35XMg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/7] virtio_ring: add a func argument
 'recycle_done' to virtqueue_reset()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:08=E2=80=AFPM Koichiro Den <koichiro.den@canonical=
.com> wrote:
>
> When virtqueue_reset() has actually recycled all unused buffers,
> additional work may be required in some cases. Relying solely on its
> return status is fragile, so introduce a new function argument
> 'recycle_done', which is invoked when it really occurs.
>
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


