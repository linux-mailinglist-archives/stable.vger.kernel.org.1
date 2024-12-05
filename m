Return-Path: <stable+bounces-98734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 725079E4E6E
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 08:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325522867B9
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 07:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C001B4146;
	Thu,  5 Dec 2024 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NcnCTEMh"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5781C1B218F
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383915; cv=none; b=BdvogPnwH5reERqPC4qtkvEYoosNdCB7dyO08mW9t2MKSN4dyeyuru9cx+1oplj33NPGhZF3eQjpldakSxnaaaQuR+CZC7oTfceM1gf8OxsJmZxPoJRwOr4sGijNojbor+962F59ie9K09sJb8zkOBAYevGUACoTq1u3gA30cXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383915; c=relaxed/simple;
	bh=toFosSafYBFrQ7Vmksn/Bd7aqXnd1s0VzoOQWShwL04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dE6FenNrSoM+vhisNHiiaevSLCmx4EBS9WGOCIqkrVcUZAgjksXLQcCezIRFDuay4JJSOfjd/loCkE3QXj/xo8uGTseaDw3Qq+d7oqnIS/P40vWXFJp8rmQgsVW+XS59DLLTZcMmV7VGYLcs4KTZ6/BaHaLrhY0GFgmcO9ZgJE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NcnCTEMh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733383913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toFosSafYBFrQ7Vmksn/Bd7aqXnd1s0VzoOQWShwL04=;
	b=NcnCTEMh5+2T/mfAM2+tdQFUfFPRWcG0hxr9y7q2bC8j5bV1KWUyjXx0A5tAQy4ZJgDPme
	P7vS1ZRt2XeWgZmgz22hNuaUCnjcHw46JL5zWsGR9wgWMZU6i5x0eJhtEkVw5aeDsPpwWo
	bV9aIuEb3YBCz7o/2Kr0rOv8/RybtU4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-kZgQwt33MHSDT_AOo9Sepg-1; Thu, 05 Dec 2024 02:31:50 -0500
X-MC-Unique: kZgQwt33MHSDT_AOo9Sepg-1
X-Mimecast-MFC-AGG-ID: kZgQwt33MHSDT_AOo9Sepg
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7259e5127ecso606536b3a.1
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 23:31:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383909; x=1733988709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toFosSafYBFrQ7Vmksn/Bd7aqXnd1s0VzoOQWShwL04=;
        b=jiv6IoCALdSvJkwabYABybFjVYmk17YgPtx8BsdXFJtmuTB0i/2Mkj925vyUz/eo73
         5pOubTzoyQcZC5hGOJBHZqHkNraZKOOOLZBuIfVm+YDIx8NwS7msfBIe1DOItPsnGh5O
         fa1lbLJTCYYStU0w9w6j/1hCn0PCeDEcKThcJ1vFTdt8zhufR4zOdokzag7Wu72YCLl4
         qs+qpXh6MQI52JkDLBgJ6qrVy16pIWXCPRpWvi4iwh2/FH8u18NcPa3/FE00v5Npmk8i
         Ds/AaFZ1zPmzj4+PEB5Ya9PVp/+BnCNx86D1sS187oiYLdIW9Xs31CUGteY6vn6FGWSa
         DYkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO25ulFRV/g7fd/lVRjjeH1D7TaX08qQPA5FtPJ7ISfzEBgO02mrzwUvOwHMnUsXw3qcyA1qE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9bh5px5VEiwM4cwQntOTFFmoYiZcS5UrCszWj12aNeFNJ7Aht
	9OXPbdiYgGi65uU4CdG8X3QQv1HdOTLoS8gJF1MnXBxH814SCoeetxnVGD4ZpP5nKlgjcm1S3nA
	BmmbmFrjxQc9Z2pWecV7GlO5WTnv20zsBNjz21XQ1VgKoHH5NiJ9+P2m0HFYK6rZCcuW7OHdIym
	qNDySXPFxeShi9wHZ6NbDL9m6ewCWk
X-Gm-Gg: ASbGnct5w8TfCegFKjTtUbHlNyZpHCrxJWgAEesIPh+o6f0Xz6KFw7V2LER2Whk+VNO
	vvPeI1tHNWbkRl55lFW4XETFTEQRsPMi/
X-Received: by 2002:a17:90b:3903:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-2ef2f498ccamr5022364a91.18.1733383909081;
        Wed, 04 Dec 2024 23:31:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGixH+V19QXJVTaRQQMS7yMn8u7saE4FALdvwG/htpjGLWE45l6MvTr9cB/l1hOZceUtfHA1KOmc6KCU2mMM4A=
X-Received: by 2002:a17:90b:3903:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-2ef2f498ccamr5022336a91.18.1733383908747; Wed, 04 Dec 2024
 23:31:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204050724.307544-1-koichiro.den@canonical.com> <20241204050724.307544-5-koichiro.den@canonical.com>
In-Reply-To: <20241204050724.307544-5-koichiro.den@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Dec 2024 15:31:37 +0800
Message-ID: <CACGkMEsBKLkY5vRjWkP49LOOYmhY=Dw7U97xy0+xpL3-9Jnmiw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/7] virtio_ring: add a func argument
 'recycle_done' to virtqueue_resize()
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
> When virtqueue_resize() has actually recycled all unused buffers,
> additional work may be required in some cases. Relying solely on its
> return status is fragile, so introduce a new function argument
> 'recycle_done', which is invoked when the recycle really occurs.
>
> Cc: <stable@vger.kernel.org> # v6.11+
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


