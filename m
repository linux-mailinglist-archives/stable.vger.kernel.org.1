Return-Path: <stable+bounces-65358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8302947524
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 08:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1B11F21825
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 06:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C531428E3;
	Mon,  5 Aug 2024 06:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEVVe2ew"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA71912B6C
	for <stable@vger.kernel.org>; Mon,  5 Aug 2024 06:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722838671; cv=none; b=s6nCXmhfe9zTTotNToZHtJsq9i3ijaTVty9EPIKadhTsyIR6bSQZgsIfQr4RR0n63fd2BjB/f/omFex+qYYHhSkxfpv6sZtLO2qks68bmCloK5AyVEZQJgIa1j5eLBzZehkE+DwMuRnGg/K/NOpbQdq57QEQBM8d8+hb9JGp2Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722838671; c=relaxed/simple;
	bh=OBA8h6YnctrlscFmyJCXMpOvIXpjcoz5dL6gZTt39+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxN8WELcHexkN9lLOHd3qrdYV+tKp+NWytmFIVLH3oSubI7u+uYWOO7W/tEdgLm2R0BSlxRvh7dObJXD9DwqMy6GaqoCZaXF6lTeeO7O4vkPpFKe00HG0lPdnqJOAn1uMtSysZ7zBXTW8PBRJ6flEKAmwjOGKRRm/CmwlNoV5H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QEVVe2ew; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722838668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OBA8h6YnctrlscFmyJCXMpOvIXpjcoz5dL6gZTt39+I=;
	b=QEVVe2ewn6cd81CfxULmjYXPTVoAgev0Q+hIREOurfdJ4OLvAhQ/Zrs62hRnyweyuO0zmu
	MZ6PpS5IO1ijDqNJhpvy0nXfovx6aWIrNw18w5ssuXugP6zO7oE3IlvIF1nuXqnhBaHyPx
	zEJjiKndiJefdp8EuEAUucO1vAvVFOM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678--Ju0XenBOG2hjjrv3HpnJw-1; Mon, 05 Aug 2024 02:17:47 -0400
X-MC-Unique: -Ju0XenBOG2hjjrv3HpnJw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb5ab2f274so12900395a91.3
        for <stable@vger.kernel.org>; Sun, 04 Aug 2024 23:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722838666; x=1723443466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBA8h6YnctrlscFmyJCXMpOvIXpjcoz5dL6gZTt39+I=;
        b=DGLYufYdgVtyIyWft8GSzjML6cTkjBVeALwSIu7a8XAHv1Va25IPtfFAjRWJCcP3N0
         nZD0mfXEocusPZ4OPDPl9JAw6pMJ0DykiPCCMmOVyCwx6zOGvIPXnMnEu19aw+k9qRWB
         YkIv/kBD2zNWupTqLTBcThBP1axLlESSQRR0oJ9+lbzmpAMoKQyFG+JrU8EDPFb8FJaO
         YljvggwLs0F2k79yUB9s6LWd3uaKYdWm/z8fWOjLDdz7Zx3CULYsENT/Jlzm2FoD27na
         UkI/BdqbeNqesZBlSSoILA//+TfKJ8XLH9/QTqRhutktQ5mbMdqD6T312pnjCuP/Kpd0
         iUXg==
X-Forwarded-Encrypted: i=1; AJvYcCXwPiK4VwcO1OQgDZoqkMmciVw/bwuF85WEgZ7Rr2C2eBzO4KlBzHOPZz2ZjSr3+wL63Vse7U7hZKUehd16fczxd8/s6ITB
X-Gm-Message-State: AOJu0YzSnFzhPLsiwLaZGXuFzqSbXrpRfbfCMeEbO8jxuVJh3M5xkG4n
	wIESyEOb3huLLh7ztU5qcaz6sA2mm+fuK6sH7p/nD34cgg+ElTJTNPWsxhwL7j8QAw3dTcBCPxU
	BXz1MO3+9XmufUY3Q4/iQi5l0h7n3LxLlGDjgimd4ynrV5TCCYqYnJbq06iCd0CJXut5tR6QWOf
	MOofVrzNh1Mv9lviD8/Sn9O/76fq8b
X-Received: by 2002:a17:90b:1e4d:b0:2c8:ac1:d8c3 with SMTP id 98e67ed59e1d1-2cff952d301mr12719466a91.29.1722838666410;
        Sun, 04 Aug 2024 23:17:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7dJm/uMCP9r6q57lSVrYZLF63noAuWOfwLCATXXwoh5VA0D6Hltrsmz9fS/EuEEhz+BVCozQtHiZGOMVa9T4=
X-Received: by 2002:a17:90b:1e4d:b0:2c8:ac1:d8c3 with SMTP id
 98e67ed59e1d1-2cff952d301mr12719452a91.29.1722838665905; Sun, 04 Aug 2024
 23:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGRfhukVR4V9GFmdV71QfM2OLW3G=BQoOM1U1cK0ENFZvLTLyw@mail.gmail.com>
In-Reply-To: <CAGRfhukVR4V9GFmdV71QfM2OLW3G=BQoOM1U1cK0ENFZvLTLyw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 5 Aug 2024 14:17:34 +0800
Message-ID: <CACGkMEvpB0zP+okrst-_mAxKq2eVwpdxQ5WTA07FBzRrs3uGaA@mail.gmail.com>
Subject: Re: [REGRESSION] [PATCH v2] net: missing check virtio
To: Blake Sperling <breakingspell@gmail.com>
Cc: arefev@swemel.ru, edumazet@google.com, eperezma@redhat.com, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, mst@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, stable@vger.kernel.org, 
	regressions@lists.linux.dev, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 2:10=E2=80=AFPM Blake Sperling <breakingspell@gmail.=
com> wrote:
>
> Hello, I noticed a regression from v.6.6.43 to v6.6.44 caused by this com=
mit.
>
> When using virtio NIC with a QEMU/KVM Windows guest, network traffic from=
 the VM stalls in the outbound (upload) direction.This affects remote acces=
s and file shares most noticeably, and the inbound (download) direction doe=
s not have the issue.
>
> iperf3 will show consistent results, 0 bytes/sec when initiating a test w=
ithin the guest to a server on LAN, and reverse will be full speed. Nothing=
 out of the ordinary in host dmesg or guest Event Viewer while the behavior=
 is being displayed.
>
> Crucially, this only seems to affect Windows guests, Ubuntu guest with th=
e same NIC configuration tests fine both directions.
> I wonder if NetKVM guest drivers may be related, the current latest versi=
on of the drivers (v248) did not make a difference, but it is several month=
s old.
>
> Let me know if there are any further tests or info I can provide, thanks!

Does Willem's patch fix the issue?

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3D89add40066f9ed9abe5f7f886fe5789ff7e0c50e

Thanks


