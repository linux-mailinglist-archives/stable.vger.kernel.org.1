Return-Path: <stable+bounces-142029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CD8AADD24
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 13:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E4B3AFA30
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DD822171D;
	Wed,  7 May 2025 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tlx28veb"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447E021B9DE
	for <stable@vger.kernel.org>; Wed,  7 May 2025 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746616744; cv=none; b=ECQIajmTPWhJOiJXosRiJO2Pray3XRQqzWNg2SMIL2pN0gVOwXnEs1bpNuOH0pdKqPGB7MI8oulmiPrEiRHMpYQ0lfEi0QtJqBq/GUrRS5r5Hu4f+XKKYNybjnxPYSxKepaNq98ZqA8MtbjZcdbXytq53sM5SXXSH5KgjZG0bNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746616744; c=relaxed/simple;
	bh=i90NW5So0knWFQu6mQoTAcHmtACByqARJ43j4thIcIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4CaZnT6k/TdCpE60JittlEDLQWnPpu3mkdVBV5KShMW4lG6polsJR6sOIFyMYoVQrFHIzMG/RSrHtLzMDB/HMx/FgnWl8Vn31jgqnKwylt2LnVWY/3uR7RmQWs3NeYNuF2Yua9N3YqnTmr7l4tUHtVuG+4fNGInrU0zRSxBlYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tlx28veb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746616741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qcMSKxsdL9xzmCiQcoQVPjrNi5EAu+FW+nsZOoK7qsQ=;
	b=Tlx28veb4V9KOk7blAcApFxBdq8mIhS4aoTmwg12cq/vOy36CjgJJLXGhc74/A93jcogNX
	SYYlZDdSBkFOSwfqdpPrnP6aFFldb0M4UI5mOBd85uB+DkNf4RIU+7CYq4a3J84RifXywa
	fDhNmamscj0z1XyGODdoOBtlWcf6+lQ=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-KK6PLs4lNX63IpwzYLg7yA-1; Wed, 07 May 2025 07:19:00 -0400
X-MC-Unique: KK6PLs4lNX63IpwzYLg7yA-1
X-Mimecast-MFC-AGG-ID: KK6PLs4lNX63IpwzYLg7yA_1746616739
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-4c318471cceso752688137.2
        for <stable@vger.kernel.org>; Wed, 07 May 2025 04:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746616739; x=1747221539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcMSKxsdL9xzmCiQcoQVPjrNi5EAu+FW+nsZOoK7qsQ=;
        b=lKr4LRT4M2aJwl8OrkvnRjLD0NsUUyEbwCwOLVamwtESqECmh6xNapPu622WXCnLPo
         RuIRYMqmDQQjhB66MbiKLhu1IXdhUzvRi/dDep8Cb6iPeEiuhWIx5Y/YuX0BTV5s1JXa
         HfPVoUKIpKCUwxbcPERXTaMRnisK3ZlTOiR8WsTnDb2rdCBtfdhSy1j7IRq6zcyqxtWK
         N5Tgdt15/zlkGsNqyihvpyH/N2jBZkwTRX6z70eXYGZfCZXgnOG4kdYscSMggxudsj2S
         Qm6+NfUZL3pzIaltcEfZbAX9VIXWbfH0Bv6c6KBSS0i8D98uVvegANBJPQB9ny/IoN7Q
         0NAQ==
X-Gm-Message-State: AOJu0YzexZ9gEU6I/su1IOvDYRBq/UYCJ9pJ47NoA1Bb0mXbnKq23yFu
	lEhsB3zMTnqQLANfOW+UhHEx7+WJFpnJ881etAPxPHmM2DyFNEMs9oNqyQqsrwVHEOK/E1SV+Vt
	JyekUMCON10Uq5Qm7Y/2SmvSjx/hyjFV2SXe9O7P5DkVZeMLSh9IoXxPBRYHhFRWIs/9At+0cSf
	HgiVKhdblOMqNwG2H9NkbSfjmw2BCk
X-Gm-Gg: ASbGncvqdi2GgVUyYa+CIiXJJ/b8K+L/YJ2W4Iqj0sC8HMDEjz+VvzsUUG5VGjGqt5E
	h1g8h5KOjN/hH6aiIut2XNwXbOFzTirCD7kMNfGEsQEKFfKQiBWJIIkTc+gQC/Z12y6PT/A==
X-Received: by 2002:a05:6102:554a:b0:4bb:d7f0:6e70 with SMTP id ada2fe7eead31-4dc737b3d09mr1844888137.5.1746616739443;
        Wed, 07 May 2025 04:18:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTeAg/9nkJnJ3XP+0A1Pc2Y3HGMojBjwzISF9VXsYErCum1KyGJaiI+vQ9qo9IlGE7kg6efWdxae75lgQ3nlA=
X-Received: by 2002:a05:6102:554a:b0:4bb:d7f0:6e70 with SMTP id
 ada2fe7eead31-4dc737b3d09mr1844882137.5.1746616739125; Wed, 07 May 2025
 04:18:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507094702.73459-1-jholzman@nvidia.com>
In-Reply-To: <20250507094702.73459-1-jholzman@nvidia.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 7 May 2025 19:18:48 +0800
X-Gm-Features: ATxdqUFSivs9HCQcM5X47jQ8BMB2hYaqhmgYks-A562EgAVngUKC4nFcH16fjYA
Message-ID: <CAFj5m9LX68NqDd8Qp2ZVmTwWS1+FqBL8t2q3F-9Gg7GFLYn0bg@mail.gmail.com>
Subject: Re: [PATCH 6.14.y v2 0/7] ublk: fix race between io_uring_cmd_complete_in_task
 and ublk_cancel_cmd
To: Jared Holzman <jholzman@nvidia.com>
Cc: stable@vger.kernel.org, axboe@kernel.dk, ushankar@purestorage.com, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 5:47=E2=80=AFPM Jared Holzman <jholzman@nvidia.com> =
wrote:
>
> This patchset backports a series of ublk fixes from upstream to 6.14-stab=
le.
>
> Patch 7 fixes the race that can cause kernel panic when ublk server daemo=
n is exiting.
>
> It depends on patches 1-6 which simplifies & improves IO canceling when u=
blk server daemon
> is exiting as described here:
>
> https://lore.kernel.org/linux-block/20250416035444.99569-1-ming.lei@redha=
t.com/
>
> Ming Lei (5):
>   ublk: add helper of ublk_need_map_io()
>   ublk: move device reset into ublk_ch_release()
>   ublk: remove __ublk_quiesce_dev()
>   ublk: simplify aborting ublk request
>   ublk: fix race between io_uring_cmd_complete_in_task and
>     ublk_cancel_cmd
>
> Uday Shankar (2):
>   ublk: properly serialize all FETCH_REQs
>   ublk: improve detection and handling of ublk server exit
>
>  drivers/block/ublk_drv.c | 550 +++++++++++++++++++++------------------
>  1 file changed, 291 insertions(+), 259 deletions(-)

Looks fine to me:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


