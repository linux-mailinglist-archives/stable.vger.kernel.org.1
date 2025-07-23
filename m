Return-Path: <stable+bounces-164320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692B4B0E76D
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 02:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E7D3AB6AC
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 00:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DA92E3705;
	Wed, 23 Jul 2025 00:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rA3QxaUB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691D61862
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 00:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753228915; cv=none; b=GnUL2qI9nHGzGbzhclgofdX9rXNzzYMExSsCnRNUTlyRoRgKQ3N2y24l5VsTUlBHy2woM9TCeo9xuDdn1XASeF78dvFO9K+BQU1ayVoKFHhdTJxRs7QfGWjlFJggsViio1wtdyfSqDPkK7+NdapwFbMKqZ9HLGKvhu4X/Z/zTXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753228915; c=relaxed/simple;
	bh=gPi51dK3oE0zdSbMxyoTJ2j+Kp9ZEpvTgPvxtE9gInE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqU965OVgbLEU39zf8S5x0Y35KuXLV2e8cOb3VBaZpcV1W2CdrW66+AYW46raPYFwxTPuMkrBQXBAJe/ScqYHZ5kOFS9GdVxKahNWrry5gmoQRHw4WX1neZOdHzEidD9wiwRV8/Data3JqCiAf+g+06xZlw/k+2Hde9rDi80iy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rA3QxaUB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23694cec0feso58503665ad.2
        for <stable@vger.kernel.org>; Tue, 22 Jul 2025 17:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753228913; x=1753833713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmW+kJOfooutx6wMAE2aHCnhV2kwpGozAvb4QhsmOeU=;
        b=rA3QxaUBvtcdG+wsrKD7uW0ONPYlrinlYCepMW+ftu1pXvhZMNqOVJoGdkhi6R5X+i
         f8bTrod5tiQrnhstd/R0765F4Oo9qda09NmHMOUmWj3qF3mqokRI8A2D9O4EUDoNU6TZ
         5gSvKUQdOS/ntIkvtQ+3ESKgHQ+XTFX3Hqllf+KgAZRZHlpDOa8lFNxtEfOPkDIzoxwC
         RahPwB9VkCMRGyW/KQ1RYs0rWzUz+9w+fED4KLhh9WsFv+aY21qOkM2n8lXjV8hQ6o0D
         COU1SF/YsIc5eF+nh5YP5xQ9MZoUubyDCQdQV0sgRWcIrERoWCoTcEB5Sd503LQ+jPEU
         0VUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753228913; x=1753833713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmW+kJOfooutx6wMAE2aHCnhV2kwpGozAvb4QhsmOeU=;
        b=w9iQaoi+xmHnFtzAkcMZjkClLKapEt6Yb3evekNRwno9NGlINeKuPiX3GlOIvvcSJW
         iekFeqz23mt/yT8MLH+Y0+YtqNlrL6B2PG43NwFCcFs19IbmmVxILkei/PPOq/dsgiEY
         fJpEALEjqVs6hydNWW1fRqDJEjeqw5LhP4vKl38EfB/GverLOsgy2qkLlwv5hbO4W3/H
         GUQZVGWJrv4+axD3rb0chlnem7NcpFryYHod/TgdYt91Yizs9NM3S6AhpumH6eaSql9f
         yowTKwFaVNvAuXiZCpwzmxZ1snqzsJdi9Hb3xj9IT7wc9+af2AGA5fBE08Dmilnhuozy
         Zg2A==
X-Forwarded-Encrypted: i=1; AJvYcCW5dkR20c6xxXYqJEE3gY+OLblUCZrmCCrOnAwhmNmua9G1NXBUtkbmJ/9ywMXVsHWs/Ff8eoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8dwvDmWzNOsW0OLYHOMGs+FnldHQFeYHPO08mnk6glhEutleo
	Q1rSyb2L+9M3eOJAUZu/wmEiKYBKySViCw0qWG7c+O9T/VFQTZoiL7OtNV+Kyn/nTkugEnUWnR4
	bR8TVMCi4aEN4Nw+THSZ9VCjdYzAJW7JlKBgC5Pp+
X-Gm-Gg: ASbGncsK5BFpAkE6wJA4qs3tuNyTzBLM/DpIKxXWcQAmjyHamjnOvpwI+khUHkrB9h+
	IolOZhQ/lu+tLnmN6jWSf6t2SvjRi/zjIeCNr5neIsFty1GBBXZ9mVHI6OFUPKpVNi5ak3K2nPc
	/Rsr8Z1OauQXKuW189I2OErTQomzyDZpg+DhHxTN8pYoaid/pOFjnpF2xGA80sJkE1kwoCIgF/Q
	6wB4BuzFPXzfo61oP/Q0jZMcMYKNQPMk7u0rQ==
X-Google-Smtp-Source: AGHT+IEqqHZkTue9jUT8aBgzW9HXFM4b9QYOnzU5SiGbcOMqJT4zItAuhvKX5pr1J1z8bXy8wQZzWEwQMYnEb1hq4s4=
X-Received: by 2002:a17:902:c946:b0:235:779:ede5 with SMTP id
 d9443c01a7336-23f981df84emr10431745ad.40.1753228913257; Tue, 22 Jul 2025
 17:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1753228248-20865-1-git-send-email-haiyangz@linux.microsoft.com> <1753228248-20865-2-git-send-email-haiyangz@linux.microsoft.com>
In-Reply-To: <1753228248-20865-2-git-send-email-haiyangz@linux.microsoft.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 22 Jul 2025 17:01:41 -0700
X-Gm-Features: Ac12FXwOFltqpWqcJyOPdTDnWUTF9s30pio1HgtXH8zT888WCdTjkN8V30YF4KI
Message-ID: <CAAVpQUBuyfnv4BBxnOvheEb7JVnokTEiea5Yp4UZdX=5CuWVHg@mail.gmail.com>
Subject: Re: [PATCH net, 1/2] net: core: Fix missing init of llist_node in setup_net()
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, andrew+netdev@lunn.ch, sd@queasysnail.net, 
	viro@zeniv.linux.org.uk, chuck.lever@oracle.com, neil@brown.name, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	davem@davemloft.net, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 4:51=E2=80=AFPM Haiyang Zhang
<haiyangz@linux.microsoft.com> wrote:
>
> From: Haiyang Zhang <haiyangz@microsoft.com>
>
> Add init_llist_node for lock-less list nodes in struct net in
> setup_net(), so we can test if a node is on a list or not.
>
> Cc: stable@vger.kernel.org
> Fixes: d6b3358a2813 ("llist: add interface to check if a node is on a lis=
t.")

No Fixes tag is needed because we didn't have a need to
test if net is queued for destruction.


> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  net/core/net_namespace.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index ae54f26709ca..2a821849558f 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -434,6 +434,9 @@ static __net_init int setup_net(struct net *net)
>         LIST_HEAD(net_exit_list);
>         int error =3D 0;
>
> +       init_llist_node(&net->defer_free_list);
> +       init_llist_node(&net->cleanup_list);
> +
>         preempt_disable();
>         net->net_cookie =3D gen_cookie_next(&net_cookie);
>         preempt_enable();
> --
> 2.34.1
>

