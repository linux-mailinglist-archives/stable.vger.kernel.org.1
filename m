Return-Path: <stable+bounces-159106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17474AEEC63
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 04:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7170A1BC2B72
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 02:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059511B3939;
	Tue,  1 Jul 2025 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxRwnIJV"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B911917F1
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751336411; cv=none; b=ayVCz4vJIIpWpkeprJlQK/EaetFtq2VInjAhe9W7AUb2TdJb8i/qC03YqeXDOxM57jPOvWl7juPxLI+aHrFJV/qfDUiC+HXOX39abzGuZC6SWS5/YadSsbdgQae0PjKbMOrNn/Z5XYVegKgz1LWnbWi1B6K80fpHV5N8ilYb1Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751336411; c=relaxed/simple;
	bh=Bz/86j3mpJf6RZwOMLVBi8P/cdclQpstyJilpZn/LWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixLf0RWleMvf4xhRfEyheaF+qj/dFJZ0EzR2Vqx51G6qydV1mCh9uuZCZL4gglRK4jxs+cZb+m8BH7PYMgTvwsFCugZyjuT1VuWStRc279o2de2fYUIgHpXHeRMfDMO5bNfoiiXVMIQiUCso9um6lF0OOkfQ0QkMT1OW7/Ya+nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LxRwnIJV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751336409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bz/86j3mpJf6RZwOMLVBi8P/cdclQpstyJilpZn/LWw=;
	b=LxRwnIJV1PK3FTkiBBCPHK6eFm4srrqxAXKtXpSGEczEzRlOAgChDJUddzRjk0B/X0hXc/
	JIrR8VHCaTvZ8/A7ZKK5gG263o4niyvwokfoYxQpUhVKT3fIu4Pa2bQJo+AZ6+LKglgvMW
	0jqsiFX5tTtWyIw9MQl5FlL58qott3c=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-6AfdKk_LMCO7mc2HB_TZiw-1; Mon, 30 Jun 2025 22:20:07 -0400
X-MC-Unique: 6AfdKk_LMCO7mc2HB_TZiw-1
X-Mimecast-MFC-AGG-ID: 6AfdKk_LMCO7mc2HB_TZiw_1751336406
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-4e81805effeso406576137.1
        for <stable@vger.kernel.org>; Mon, 30 Jun 2025 19:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751336406; x=1751941206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bz/86j3mpJf6RZwOMLVBi8P/cdclQpstyJilpZn/LWw=;
        b=t0YGEOEo4mBPkyPHjmQ5QZ5t49B5Zu/scmz5mcO+pq4u55hUbZpiTPjSCzeJ4zXQR4
         S3roGlguKu4gZ+zKEmvwJLiJmzz/0B0lzEC+8Mlx86Zf9qw1vyK/omUdZMte+17iPcpH
         0xGsVL5d82a0PdbqxBXcNa1ppPONMI5MR+WAZEQ9Y7fxgN9vpCXt1NOJDlX3QGby6DCy
         WvlwFYCB76x+K3yx059s1yOU+rPFw7qaUYTlZcafcT3lSYVJY/4V4p124Pv3lk1sGgN5
         q+zpKbH4X+c8se6jfH1NBH7YHq32PQioNc7WjWjUs90YM43cpeCUZSVEQ/0H4xhP5/L7
         PhpA==
X-Forwarded-Encrypted: i=1; AJvYcCVML33bxL+//YUUcibj7HaqgwTrLm8B88f77Y88CXs9iVhh+kpqfkymC9mPAQIQ71SZ59R7M3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwooTXoAqy4DuoYWUCt1lxA+RN3wwnggGJ2GbAvrE+BtJ3/Pzru
	pXkTHo/60qo5dQSXAFzNxGGB8NjRdyHJjOPhtoucCu0/eRUEnj/2mOdCa8tIOpJEONhxa/8JZQB
	ZXUopRIurEqeqG/3GezytsbNvk8ctb2LCYQTuCeasHeGDVv8/EYaZDyvo2SgpZYd51ljP3aAMyT
	2y1AKktx3nTXRW9+JwXtl3eH/kQk4xJ2d2
X-Gm-Gg: ASbGncv7gkcfcEJmLrp1JdjoxAsh1y7kOtsj169hWxra2TWf01XxSpTspBCdmkQgMq9
	7R5c55uoO82Q6BvJTG1ZS+O2k2dB2VNqatlJzrZ7AYSi+t8iQhLGDE4BP6QthDFTyWWdIAy8hlz
	AU
X-Received: by 2002:a05:6102:b0f:b0:4e7:db51:ea5d with SMTP id ada2fe7eead31-4ee4f57b220mr9035433137.6.1751336405878;
        Mon, 30 Jun 2025 19:20:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfwt0IUN9XzbcPTMYkve3OC1WK/0fpTeOcXovTvrlwz1DP2O24mIjCZg0vVcRzjUe2M01DvNuq273bCwcQw/Y=
X-Received: by 2002:a05:6102:b0f:b0:4e7:db51:ea5d with SMTP id
 ada2fe7eead31-4ee4f57b220mr9035421137.6.1751336405513; Mon, 30 Jun 2025
 19:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630144212.48471-1-minhquangbui99@gmail.com> <20250630144212.48471-2-minhquangbui99@gmail.com>
In-Reply-To: <20250630144212.48471-2-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 1 Jul 2025 10:19:53 +0800
X-Gm-Features: Ac12FXwg9udMXpdfqk8skCNczA1b4cFLqKAJ_PlRVtyvo3Mi9xA6wAsp9nIVFQs
Message-ID: <CACGkMEuJk=PF2aGQj4FNhSv=VvOTzruK6PMpEykB9MVHwU4nDw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/3] virtio-net: ensure the received length does
 not exceed allocated size
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 10:42=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> In xdp_linearize_page, when reading the following buffers from the ring,
> we forget to check the received length with the true allocate size. This
> can lead to an out-of-bound read. This commit adds that missing check.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


