Return-Path: <stable+bounces-192458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FE3C3375E
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 01:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02AEC189F6CD
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 00:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E207231C91;
	Wed,  5 Nov 2025 00:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqNZSDw5"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBCE224AF3
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 00:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762301992; cv=none; b=N8L+dw0YJ+S2Bw/1IEkoCWRooRzmmWhTOeRtPyoVerqKF2Kn28U7ea2HmyFCtl3zjDvB/fcMStoiSAJxRvptl2xjiO78ti/Zd94lKrq/8fM0yPYIQkZxER/mG8RvstO862O9thjFBd4AS6IOH4Kz2dZMebsvY0XbEJgilmTO/EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762301992; c=relaxed/simple;
	bh=tPNyrSglXgzbTSxAtrtNr66B4b82eAkptaHPW68Y0SY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJOZkjp2If0z12edJJmn7V1DBHjkqP0rzBzMIiv50qFmcrOYEv2jXWta5bg8x+jBnYx58q6d6BC5i4JKhwT1b49xi5d4uRiyRv3B0xmzzhk5JmFTmdgeJFxbvbzGciQ7EcqkYr3sg/zk6QkLCt1z0h45Credmu4SYSZQ9vPgcZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqNZSDw5; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-43326c748d5so1901505ab.0
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 16:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762301990; x=1762906790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPNyrSglXgzbTSxAtrtNr66B4b82eAkptaHPW68Y0SY=;
        b=gqNZSDw5FkB1z/vsgXvvAlmbYiI4DAoGsT1ZhX+eVrPJYEIyi0jvIvtBLywc352qj0
         ZLlrO25aQ+QzYdegFTlh3akPMhyM8/Fz1lULTj87R2PHqgKtnu6HcytvVAN343QyimQj
         HEmKG0W5JEeFp1FMBKy9xCyNwyphsCeE9d0oAejVx1nQLw3h/6qFj3NcemYNPgGVuu4f
         kQZKFp1QjvRQvsca7rPJxFpoT+zV5Y+C5DbBeRVdgR189krev2t2YDoLqLE+CuGfLZQd
         Vyi3w1LdzLqGVz/zcb74b7qjw57YmSoIqAf4ilT0Tbxm3MLR3IijQ2OS9+zzJRd58kgf
         4tVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762301990; x=1762906790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPNyrSglXgzbTSxAtrtNr66B4b82eAkptaHPW68Y0SY=;
        b=p7YUBgSJKeVQwtxwRlRVI7ZL519zWkM5K/LqZSjORAjCtOppOJzGColelTmeVO1vSE
         4IsB3yX8CGTWyIk2/KlUv96ksD+kIP60cXJ/NFtgpipvQFTY0X6DZji6i4oLm8I3t97T
         iV7hnhEDZxmIrXYBE7Ka7gSk/M1gCdEkxqgq+pwp3FhHkM6RfQu6D9SyLqhB9+XQdXob
         6/zgS/q4ZPIMFWZGruXm0nBtU2V0VRKYNTQu6hpKVv566nJFnukSAW9lcLPTF5jiKuMc
         CcZw+erJUCbiDdRu9zIPkQlTh8ABhXGq3JiqxZHTseQ/xpkIUGGMbKjLMRCgVC1yxLqk
         k0eg==
X-Forwarded-Encrypted: i=1; AJvYcCVTwqXJ4I7nxqRM/ih5HKZIpEk8lMhGjgIO8c/Gq9aXFuUc0PNrDa9VfRT78E3LIDKHCpGdc0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrX0kKv4HYRGQdRtjZPDVa6Jm8Q1s494b6LeYWiWMBcpuy7WJg
	ZtuyQm5uZx2J5n4mHzXhsAS68LqxZqAHT1tudXg9b/MLJRVXMGiatbz8pV5BHivJGihHos390mJ
	rLf7CSMLrZjdpzys0GN8yGuAs8gvG3Yk=
X-Gm-Gg: ASbGncsx2V+aidaQKQ/y3njg3VzQ1S2mGZXb7AnL6I9RfITaYVTU7e/iRFuxxWS5m+R
	iGrUH+BxYuxtpxlwxRNY79rSXVO/IbXZcQLbcyzq/YPqbOnmkMJ5skqVDfApbLYYq/PR0+30Nb8
	29JwIcjlSzQAq4dpBzgCK6vHyfcp3foVDwtmiHaImH4P8mqqgHUNQ+34UdmhcNy7cjk7/RYlsaw
	qK9oPS7OUS/lsoU8zUcdZ1vIz4ZhLqcqD2TLgNWo87Dwe2+l9MCpQEIpBj8FGs=
X-Google-Smtp-Source: AGHT+IHlKDGDIG6BMqjPpmMiXRElX7CmlqHBVKFE5hB2vstBzsdvMVaGUbKSbC7UrpLHQfFggPSndMWaqnea6GXPLXI=
X-Received: by 2002:a05:6e02:1fc6:b0:433:37e9:c1ff with SMTP id
 e9e14a558f8ab-433401a21c1mr24512685ab.9.1762301990514; Tue, 04 Nov 2025
 16:19:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030144438.7582-1-minhquangbui99@gmail.com>
 <1762149401.6256416-7-xuanzhuo@linux.alibaba.com> <CAPpAL=x-fVOkm=D_OeVLjWwUKThM=1FQFQBZyyBOrH30TEyZdA@mail.gmail.com>
In-Reply-To: <CAPpAL=x-fVOkm=D_OeVLjWwUKThM=1FQFQBZyyBOrH30TEyZdA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 5 Nov 2025 08:19:14 +0800
X-Gm-Features: AWmQ_bliMV8nE85ERHZI-EI4lokvoDwiY8yl4dOnlkgckxmIlBlgt3FBCpHKufM
Message-ID: <CAL+tcoAnhhDn=2qDCKXf3Xnz8VTDG0HOXW8x=GSdtHUe+qipvQ@mail.gmail.com>
Subject: Re: [PATCH net v7] virtio-net: fix received length check in big packets
To: Lei Yang <leiyang@redhat.com>
Cc: Bui Quang Minh <minhquangbui99@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lei,

On Wed, Nov 5, 2025 at 12:56=E2=80=AFAM Lei Yang <leiyang@redhat.com> wrote=
:
>
> Tested this patch with virtio-net regression tests, everything works fine=
.

I saw you mentioned various tests on virtio_net multiple times. Could
you share your tools with me, I wonder? AFAIK, the stability of such
benchmarks is not usually static, so I'm interested.

Thanks,
Jason

