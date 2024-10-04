Return-Path: <stable+bounces-81122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA0A990FC8
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 22:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE34282C77
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDFD1DE3D1;
	Fri,  4 Oct 2024 19:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjH6sYw5"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE37A1DE3CD;
	Fri,  4 Oct 2024 19:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070253; cv=none; b=esR75WCdtykjtcOs8+RCR2D0Xzaz1WSR0bm8krdZzEOL/4X4PTM1bxnSI8v9jgx2F0HovHfIwP2hAwSesvZva6GeoM8oVMvsytqwYd0QKIyJ+ghF2uSo3U/5mQMNV3HVobgj+2v78f05jJwTQaFdYNCnlP4GvcsTFqMy1bZBiyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070253; c=relaxed/simple;
	bh=Xs6myaYJRTX41E9hzKSusMcX++FCX9dr2GqqaK7tPuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjy5YAh47bWczxe2H/u4HyeuWrkZe4wEuwY2Nmc8vSPEGDWgE+z3PjEwTp5++lGOhRB5MEvy85njotbEecxyt7IvGnf9GNHaV/oHuyNi25Nfu7gkXKXoj6d/cdAmo20R9UYwgSuYDrwgUzi4WJgVL3T4tUoqQMH1Z8YpSvuLV1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjH6sYw5; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2facaa16826so23741371fa.0;
        Fri, 04 Oct 2024 12:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728070250; x=1728675050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDiKk/gkNOho7a3SMHPhX41erbMC+PbTgZ41vTz/A78=;
        b=ZjH6sYw5J79IaF6L/tQJkw2P2H6szxIo0G0+2sKOrpAjDSurJVOwyupONe/5Yh+fjo
         R/WguWUrnLzExpCTwrgk6Ib0rosfX6AdadDEFplafCeClp0RDLBW8BL1ExrCQLAPi8/A
         D/7Iz3k4O0dc5jz9LhW1i36oHR2YKjcPLTUCkprXRseqJM2EbzagWyQlkeU4bpxbPlzN
         jCD01esnpkfItMN6cl2Y4fZt1/RGMGCWokKpQ5ptIQqnJxtMTYInZruRjvAnuGyD12cD
         SvdHhfrfl95mYajlY1a8MRQeY3P/iG1O6eXvv1+vxmLwwyO5qX/numKvZKM9ae/YuCMy
         Sthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728070250; x=1728675050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDiKk/gkNOho7a3SMHPhX41erbMC+PbTgZ41vTz/A78=;
        b=gKO8OXz7AnONzPXVLsdA0V/vAqvjQ0dU8eiSC++oIT26xzTl9TzRPdBiUykIPe3uk7
         QZxSdF316R+BEGnd3x1mkuNYki87s4hHBScfoBcyP4989T0Q1ig1/m+V8eWDUfPRz+gQ
         an4xf01okWtpulxjZGDkLz2OpIwaSt7xMJggKkrzrkjqhVL0EvgBfayMb/2meEFljO9N
         vM5HbBpiYzrrX7tYPhFQT1JIKN9HSMfMvxxIFWqBHDLDlfveNooeyUXDboiEILzFO0Zf
         r4235Ehv+/KZcRil1bOO3ZVOmHWU5IKo0gFgwGBNdPMtCx5fdy12YVTlqmxzmuLPs+gV
         MROw==
X-Forwarded-Encrypted: i=1; AJvYcCVibJLISNtuD8OSGLppxfNrvH3SnrwOntl9BAMG0bHW2YZ1vkzQV5UCVvQP9lO6tIxwYxNLGeerP98W59owYSM=@vger.kernel.org, AJvYcCWTy3HZ9x0ELF3Pviwa4JjII7KgSUxLAwAnDeE9o9YckJHhkHWm7vJ9GFrUvqfMKmEN5znsvavG@vger.kernel.org, AJvYcCX1Xfa4SFlSZoOgOT9Z0xzi7V3tSOe8cHitVaX1hHqjkqM83nruHCpDDNPvhMrHC9fAYpqbHmTR2wlXN/J/@vger.kernel.org
X-Gm-Message-State: AOJu0YyKa554IMmuWQLMT2vJHyFi/w6rcm0+0k8qmhsx8lQ9GCtbiySV
	fF9GdE7gBnLVk/0MgPy+83ykAskbe/E3Tng7uAbc6/+rVZeKjk1Jevt67MtJRwNvwBSKZc+hm0U
	nCLOVWwB8dV+M/LY7E8YYZUpkpF0=
X-Google-Smtp-Source: AGHT+IEK4J8RH1M7kHAo0ZIttY6GbiyFoqPXMSiNpGQSfNVTLSrfmAUw2yTiwZw0tRf8+uzaC3DuhqVUNgoO5+zLRZE=
X-Received: by 2002:a2e:be20:0:b0:2fa:e4ae:3362 with SMTP id
 38308e7fff4ca-2faf3c1403fmr20806571fa.6.1728070249701; Fri, 04 Oct 2024
 12:30:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004003030.160721-1-dev@aaront.org> <20241004003030.160721-3-dev@aaront.org>
In-Reply-To: <20241004003030.160721-3-dev@aaront.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 4 Oct 2024 15:30:37 -0400
Message-ID: <CABBYNZ+gOZ36CJpq5Z7zXSNnruRpGrau9gXWo-cXKwU814ybvg@mail.gmail.com>
Subject: Re: [PATCH 2/3] Bluetooth: Call iso_exit() on module unload
To: Aaron Thompson <dev@aaront.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aaron,

On Thu, Oct 3, 2024 at 8:31=E2=80=AFPM Aaron Thompson <dev@aaront.org> wrot=
e:
>
> From: Aaron Thompson <dev@aaront.org>
>
> If iso_init() has been called, iso_exit() must be called on module
> unload. Without that, the struct proto that iso_init() registered with
> proto_register() becomes invalid, which could cause unpredictable
> problems later. In my case, with CONFIG_LIST_HARDENED and
> CONFIG_BUG_ON_DATA_CORRUPTION enabled, loading the module again usually
> triggers this BUG():
>
>   list_add corruption. next->prev should be prev (ffffffffb5355fd0),
>     but was 0000000000000068. (next=3Dffffffffc0a010d0).
>   ------------[ cut here ]------------
>   kernel BUG at lib/list_debug.c:29!
>   Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
>   CPU: 1 PID: 4159 Comm: modprobe Not tainted 6.10.11-4+bt2-ao-desktop #1
>   RIP: 0010:__list_add_valid_or_report+0x61/0xa0
>   ...
>     __list_add_valid_or_report+0x61/0xa0
>     proto_register+0x299/0x320
>     hci_sock_init+0x16/0xc0 [bluetooth]
>     bt_init+0x68/0xd0 [bluetooth]
>     __pfx_bt_init+0x10/0x10 [bluetooth]
>     do_one_initcall+0x80/0x2f0
>     do_init_module+0x8b/0x230
>     __do_sys_init_module+0x15f/0x190
>     do_syscall_64+0x68/0x110
>   ...
>
> Cc: stable@vger.kernel.org
> Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
> Signed-off-by: Aaron Thompson <dev@aaront.org>
> ---
>  net/bluetooth/mgmt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index e4f564d6f6fb..78a164fab3e1 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -10487,6 +10487,7 @@ int mgmt_init(void)
>
>  void mgmt_exit(void)
>  {
> +       iso_exit();
>         hci_mgmt_chan_unregister(&chan);
>  }
>
> --
> 2.39.5

I had it under bt_exit with the rest of the exit functions so that we
don't have to move it once ISO sockets become stable.


--=20
Luiz Augusto von Dentz

