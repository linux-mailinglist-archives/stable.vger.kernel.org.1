Return-Path: <stable+bounces-204304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAEECEAF97
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 01:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C787030198AE
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 00:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7991C2324;
	Wed, 31 Dec 2025 00:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOrXnYWu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160821A294
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 00:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767142643; cv=none; b=iHExy6I9wneLPVCPnznb4e7n85tMBvyoI1aTvApeHg0XeDQHyk/+mRAnncG/Gd7+N3j2y78hSbK81BvYxGOx2YAYatnI+O+xNuJpopJ+kRcqMPyOdQJbLkxXFpBbOi0HeH1nD5mL4L35BrIw/8mq/JaEqFxmEc1nCb2wSQsu3zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767142643; c=relaxed/simple;
	bh=XZube64hD6IXaptRdl7zcakx49qq6aNUlZ/PPN4/Z20=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tjGiAJTIS83discPG5z6jblnLzjvsev2c3OXncIVRPGpFFJP9031lILztsKJX2X+n2oxeUybemZAoUk7MrN9dtunSp+X2azuzx9HduA1qEelGjffdw+cI9a7T3WZmW3a08Wrh4zhuTriF2srGu5rl9e2wNVMAyhigV0vkYhCTjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOrXnYWu; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bdd38966c74so291673a12.1
        for <stable@vger.kernel.org>; Tue, 30 Dec 2025 16:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767142641; x=1767747441; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y3E1JXxIVHpMJqtMAwCll57AM31/TkT0PGW+VAaoHfw=;
        b=fOrXnYWumJxchBWM/c85Tw/xBP2xvaN9zW/GcU3S3dEDoO9KTb8TZmaEW+62h0uaA/
         DH6EwxaMnQUBYraqHGG9dxucFqSCRmh5xdwTx0xJd0XgpijJ9v7FUjc5DTPPfetCL2kQ
         xQpQvSNV6L9AO4w4+OFcvRXf0eTaWFb1uGDmiDpX562x0XFEOQAdFbl1Qnc7n0WQdTgk
         sEzIXa5GXgpDCRm21WnoR2zmdHbb0JZms5JlFJd88DtpgWoZQrWAMpoc6ft7aq8VOT7s
         aE7FGZcOKJGOJX+9exFCSp87zVAeZOry+ybGzx38dTSaWz4HVI3CK4rWIj9gTecC8J69
         8giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767142641; x=1767747441;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3E1JXxIVHpMJqtMAwCll57AM31/TkT0PGW+VAaoHfw=;
        b=qxRBjPoChCjAO52sRm4iN0endfi8kzCIvTlKhQJYv4W7Vn0q5BJ0D0sheNzQJt7vQB
         SehB7rAns5EfxgZMxip/OscTDSKpk4DLevfuBPhLcX0eOXsnVL/CNs2nG9Cqwba1vesC
         lwkeI2ZwYXUu0YyYxZGVmK3H8/hw7+lRlKVgoiL7CudJu9/Jjtm9Ippmrm6gtGVYeUYr
         g0JfbKO8Bw8dhuWZvNEksHO+6oXj1M3ltWP5ujLTVRUj9D9MgArqoCRdI/5q53to4LEX
         1wEDfKkb6QagLKSxH868eeNMLdvvMfRrXjUbogL4Nn63iw3W3Z2Y0HA4Yl2x7HG+urmv
         2XTA==
X-Forwarded-Encrypted: i=1; AJvYcCXgAPks47nQP3+uo2xUw3oYO5m4kvfihGCH9xCZtAG4anuz/RvVn+rP0+R6Yxx8yqqljVOt/n8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyri/Ztw7v85U/6AM+v9Mz9pxak7J7LpAfbIJiF45meam2TfW4x
	ReBPO5kxnzlJ8Kqi9Y0mfrChugmaz/8IpKj6w8cd6xgEniZJO9C6Ydcj5EyKl8RdfuTM5ZpnM3T
	jBEPOON5UtueyJJ0UoLCuL38Nvsrbl2s=
X-Gm-Gg: AY/fxX7DamcT01GchSuGqfHOnVapi+3Si+PFCdZ5ROfduDAJdSuncmo6Y+rfPLi71BC
	W9d35PtbrbuCJpSAliVPEOpVS6vsdKp31RvKomGReUaJJC0fZbaiiVxXsadSUn6lp27DnqWmXPD
	C3zjmb8fHlhyFWxut1dkNTNlF2otDUgZkaHAULxf8K4mgBgI2hbAllHMaVbufmU+IOhUwushOz4
	JWrno0byBys+sjhU7wlv4/rTutESBpFLq4aoPBBG4ripu46wcc60Opbj91j2KxYKyToZ6PNOQyB
	lF7bNyVDryqSC5KPGJFAndAFCDb8OXaWU5AiHKuElsFK7BK5ZA06gqz7720/CdxtDZ5dZoa0J5o
	u8y7DzzRyWvqK
X-Google-Smtp-Source: AGHT+IE0QZde+Epe2+buYwi8bUzRbiw6UopT760KaBQNT/yzhT5tCfljAa1efVVvg16bHzl1CBMsIOBMC+pNmmJp4w4=
X-Received: by 2002:a05:7300:4f9b:b0:2ac:2b5b:a567 with SMTP id
 5a478bee46e88-2b05ec47be3mr12709409eec.6.1767142641302; Tue, 30 Dec 2025
 16:57:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 31 Dec 2025 01:57:09 +0100
X-Gm-Features: AQt7F2rXDZiOi0tvyImtpIeqTNnWRIevRIzoxoKtqPaxAjroJ-SuGGV60E857XE
Message-ID: <CANiq72=ti75ex_M_ALcLiSMbfv6D=KA9+VejQhMm4hYERC=_dA@mail.gmail.com>
Subject: ba1b40ed0e34bab597fd90d4c4e9f7397f878c8f for 6.18.y
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, stable@vger.kernel.org, 
	Nouveau Dev <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"

Hi Greg, Sasha,

Please consider commit ba1b40ed0e34 ("drm: nova: depend on
CONFIG_64BIT") for 6.18.y. It should cherry-pick cleanly.

Without this commit, one can create a config where `CONFIG_DRM_NOVA`
selects `CONFIG_NOVA_CORE` without satisfying its `CONFIG_64BIT`
dependency.

In turn, this means arm32 builds can fail -- Kconfig warns:

    WARNING: unmet direct dependencies detected for NOVA_CORE
      Depends on [n]: HAS_IOMEM [=y] && 64BIT && PCI [=y] && RUST [=y]
&& RUST_FW_LOADER_ABSTRACTIONS [=y]
      Selected by [y]:
      - DRM_NOVA [=y] && HAS_IOMEM [=y] && DRM [=y]=y [=y] && PCI [=y]
&& RUST [=y]

And then the build fails with (among others, see the related commit
5c5a41a75452 ("gpu: nova-core: depend on CONFIG_64BIT") for more):

     error[E0308]: mismatched types
      --> drivers/gpu/nova-core/fb.rs:50:59
       |
    50 |         hal::fb_hal(chipset).write_sysmem_flush_page(bar,
page.dma_handle())?;
       |                              -----------------------
^^^^^^^^^^^^^^^^^ expected `u64`, found `u32`
       |                              |
       |                              arguments to this method are incorrect
       |

Cc'ing Danilo and Alexandre so that they can confirm they agree.

Thanks!

Cheers,
Miguel

