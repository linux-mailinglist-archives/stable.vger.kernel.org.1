Return-Path: <stable+bounces-197513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FDDC8F743
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 17:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A3FC35136C
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DE93358D5;
	Thu, 27 Nov 2025 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6oa5MEd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D46330303
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259870; cv=none; b=iq66l9Zw9n5ELekfYgUKTGO4xWCgIY1+9ywnFLBXT5P27G5oVRl9pIw1x57K38qvnR0QAu8mG9IpJfrJ5H6EAKR+8FBO40mNFW/kvgbhLrXRu8PAZeTUWVjCOLY8lj078yGEgLAduVXu1+6TnWShsNz2cBSZSfQuxy7mAGJDwuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259870; c=relaxed/simple;
	bh=9vjHzIMca4DdqffLuqx5DHjylG7Vc5s91WHgJ+iLS+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J44qYYkp/udDxz5cW6GSNtgK2zK7lhNqiWDRN+Th/51Lo+9czKWONzsC/6Ars3xjkJR7BCeaHsbK8ABs8eJzPEBJOTKyPsxVmg8MzwVdkmgyzFpz1T2w6IpsJBvVI21qDPZM29X82PLe2JNOrbELFfNqOqVaZebM6V9tFs6zlv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6oa5MEd; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3436d6bdce8so946432a91.3
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 08:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764259869; x=1764864669; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9vjHzIMca4DdqffLuqx5DHjylG7Vc5s91WHgJ+iLS+s=;
        b=e6oa5MEdZBqPGm0VEVQ+gV5fUlif7dU0Man6RR78vLEiOHaQaZ9F+pbdogeCR6BbtW
         x84PTVnAMy6LLmuxuODrJDc/LchZR83ecLaVMBaoYZN4tgClkJ3JxGkx6RMkW8nikQMm
         vVMLMfkf3pjlhEziSYA0J8bQu7vCYpKplSMe2eJnRYd0yVvJQISPJeotih1YcRqwMbj1
         dpGc7oimyAIUhLd7ARuAV4Aat5KQFXbAyyuVleuMWJKZQAmLfnx63/AummhFwwOIMFev
         V2MOOHiUoyyzFyPwgvezugl0w3mT4GO1RlXmRVzXidRevuZkLUjh9mUDru4uE5yjbjSx
         i9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764259869; x=1764864669;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vjHzIMca4DdqffLuqx5DHjylG7Vc5s91WHgJ+iLS+s=;
        b=S8fB2JLQIw+zzx/pfiJU9MvjDjbJ15xuwCz73wwlhSCXKnyRMT/Zxu7Le+bGSZoZx0
         yOpxGpoMdLaUYYT4vRka+mPNKFpwLqSEQbYFuDJatlMyEsIlMkRsl3oR+igsvwp2GGmP
         BTwYh9HHmz+FyyZW5bv+CMLdAn0FXF1mcxVD68x6iSNcKXzCvOaBkzk4SLzKypxLK3XI
         zuu7RtOxVu+rRSEU07s2SovBPUq6d3V6ytXmKSDeSOKz07rBULT//QRXw6nFeSl5ywgG
         woo3bI//g42/uYRTV3LmcvXM2m2DASHYzD9uUNjL0EZxR7Gze81y5ycFOyaEWkZeuK5E
         SYAw==
X-Gm-Message-State: AOJu0YwCtBEhOszdUvfA/VBbU1hdaBsvd4/ZesReG4Drikza6FCetGX9
	NytHm/Xc96gwTOZPoynfPly6LHs/vuPNjy1/vYFduhrLPTyI0ORqArMvmg1kRsaoegaOUtblTJT
	yS0sB9CEYVUgMU+5OtYF6wkuzLB2VZUM=
X-Gm-Gg: ASbGncvYYrWDI97zxWvPLhuq3ho4xfLreVrDsX1W/7CdCoXndoKx3s+2cgGQE3riM7E
	udJmIYt9RUT04jwMF4kNTsfSsfGKpanaxaF20IZILfBlXs8hW7BK0VeVPEggywYkl7qQYUEPtr7
	w+OggLoNsbitAVZEzJ92PeL2xXOQtaY/KjBo73PVt+1wfI+DaPy2r5pWwnxyATXUi6/uRnmHX7J
	dgs6Kc/YtEg79CuVYAEdkAMRKkELFxg+kjzNvqkZU1VfsJXF9gbLGmQ6zRtAz7RzecfRCh1edKu
X-Google-Smtp-Source: AGHT+IHwqwVIUTjCZAfmmXEk2d+gHSisxrBzmJwH7eCbdTvE6FUSwfBBHmH2R7a/9TOywFWtvE18DTpe+SZYcND1oeA=
X-Received: by 2002:a17:90b:578c:b0:340:ad5e:ca with SMTP id
 98e67ed59e1d1-34733e726ecmr25200360a91.12.1764259868810; Thu, 27 Nov 2025
 08:11:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127150512.106552-1-nkalashnikov@astralinux.ru>
 <2025112735-vertigo-jujitsu-4647@gregkh> <CAKnNz1OYAG-cwPEU6AuKr1mmGWiEzP1-ss9v8K38xspiHFdm+g@mail.gmail.com>
In-Reply-To: <CAKnNz1OYAG-cwPEU6AuKr1mmGWiEzP1-ss9v8K38xspiHFdm+g@mail.gmail.com>
From: SIVARTIWE PROST <sivartiwe@gmail.com>
Date: Thu, 27 Nov 2025 19:11:23 +0300
X-Gm-Features: AWmQ_bmVcnpg-VfaVDMgD_dGwM3deu9dUQTGALIC98ulNFN-1HLpehGIwmv0-Os
Message-ID: <CAKnNz1O96ecFb0F=DZkN4iC_+jS-aFnXWVz-TuX0iYGxGQ5_cQ@mail.gmail.com>
Subject: Re: [PATCH 6.1] ksmbd: fix use-after-free in session logoff
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, Sean Heelan <seanheelan@gmail.com>, 
	Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

Sorry about that! I will send the revised second version shortly

