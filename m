Return-Path: <stable+bounces-240464-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KuAMAgE6mk/rQIAu9opvQ
	(envelope-from <stable+bounces-240464-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:35:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0AB45155D
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F0BD301C895
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD8C3E959F;
	Thu, 23 Apr 2026 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFN/luxW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1828938422A
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776944087; cv=none; b=VSU+51tCU0CaUdT78NpnLc2tY1JnLqWGrDBKxhCszxDlH3vcmFUUa3m1BEF4t8XeiPzJuENDIjswLYY30jDBIVE/WbASYcbY5LTufEFEDbsW2knj4kHZ/bwGcJSGTWEIx3+nwfkbBJwy+Eyi/yCDtOWH7eS223hw+HosH1dRt3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776944087; c=relaxed/simple;
	bh=0WfnOZbXeCCnN3w3UE+Jw0ce/6J+iDbqFJsV/ehYRCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YftDWhnMZYWsPI6PJvTUDvK0RUwCFms5Htzk8xvUO1LJZ0NdWAE9kDMoRjE6hasLyoc0yqSeNJc5MieEV9rn7TRZ9+byu3Lf8vswXI37GGszCOBXraHMFPo6kYR+IguPuW0avEboU/XpWQtN8yU2SDJ8gBaflHBj9qfcfRUw0as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFN/luxW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso90063085e9.3
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 04:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776944084; x=1777548884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WfnOZbXeCCnN3w3UE+Jw0ce/6J+iDbqFJsV/ehYRCw=;
        b=eFN/luxW+aGDZZH66Ri2eaFyiP+8c8eaR4DjtZnGdI6OYF6Wj/Y8iDh3ObzaA/8sV9
         wVy656szM5Q4qx0qjp0zjqde7b+FZY7gimuh4FopS09ng8IKrxi9AZA3oHJP4xwwHEKd
         oZH5UHlpc2h7LxRlqOnHnniGyto+3TtGp+dBVMKXaCxHmrXT5D927vsjMPjsUuH6o6Tl
         eolDVpQwCPJVHSERsZsZKAHko70h0rJlFPfDymc44t2rEAEN4MG7dC+GWGjmrSCmB1jc
         6+G0SBwQIjMY6LPLeIhlLIImTDTuK7MSu5epJX8KJNTu5KbbgIzWluX2l7EnWwrl15NX
         h2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776944084; x=1777548884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0WfnOZbXeCCnN3w3UE+Jw0ce/6J+iDbqFJsV/ehYRCw=;
        b=a3V0oJwBGblqcJS8oUEJoDdGlXkPFWxIp49anUy8FfVCmBF4R33I526WkZLWhJ+hFI
         tCMXljTL4rWBtSKLKPKTVUCKdgfcHP1GY7fLZqnA8qOo5Pi1Z5qfflTTpFVUEE4fgV11
         5J5nuFThAmG2VrTEnC9WyXC5OvXY31Cg97HCSLCTnecek3X3Wu1JvjvChPrRoF2yEed3
         wVMyRqQfAQ7qLFof3Usu5HF2JlcPjsnE0t0Ok03rSysGfNdYGI6qkfh+awJnv9N313tD
         u1Of8n8XvldhCZfu7GJMi6J269K7XDvc+9zsFDJ5QQ6V28zTJccNh59bJYPO/jWGlTCq
         a7vg==
X-Gm-Message-State: AOJu0YzAunolXYR6muTD74Js1jjR3d24Qb3eAFWoxw6zN2Wpv4Ficfff
	RxdkEmvCrJrppA2OZNKFn28hA30GPRaL7F9ex/rd8/NtkgV6829VJ4N9
X-Gm-Gg: AeBDieutq0iRoNSs/QPJBm4eGplpOfY60vIlm8bnXE4a5CTCuvXrq2TMNpXiTe7U3ub
	WkdvX8XRHoaMSYCTMdruAKW5BHgtLj9EnUFOuz95FHDciHpZS27PnK2Hav0uD3rdNYChL/tg66L
	Cnp596bIiIyyT7X9q2Y4/iYB9YfEoNLkqgLwvqXJXjarHjsdg9cyi/iguRs10ZEwK++lGPT2cUC
	/Ho9kQfXkmAccM1CJWk1euDY7eQG0UqEO3DZHSD++JjBlEg81GeRwOwGrNycGd1Zb7cY/TOWvSB
	f/I32DwKGdfJ8Esg+6LGsUJfnYuWbEzv/e2y2ZWMsJKc157+SpSMOhOkIwVVJ7D02eeeOKQWQvt
	75bzrgqEMRaxAJeE0wzxbR0l6P9AZrpt/qbrANtGV6/vabVDsSFey5+d0QBW9seGHZy28wuGYvZ
	dLL+vnoWZiP+Yu2HQLw7FOHZ1WB8srR9u1i1kUJJbRczy5Pc6B/2lcig+bIlOHmhLobSHrNof4T
	vbOMIjq1Uw=
X-Received: by 2002:a05:600c:620d:b0:489:1d23:4524 with SMTP id 5b1f17b1804b1-4891d23468bmr239536185e9.5.1776944084219;
        Thu, 23 Apr 2026 04:34:44 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1B98A2.dsl.pool.telekom.hu. [94.27.152.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c08faffsm552416145e9.1.2026.04.23.04.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 04:34:43 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Robert Garcia <rob_garcia@163.com>,
 Alex Deucher <alexander.deucher@amd.com>, Pan Xinhui <Xinhui.Pan@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Yifan Zha <Yifan.Zha@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y] drm/amdgpu: remove two invalid BUG_ON()s
Date: Thu, 23 Apr 2026 13:34:42 +0200
Message-ID: <4885687.vXUDI8C0e8@timur-hyperion>
In-Reply-To: <2026042335-probation-heftiness-7399@gregkh>
References:
 <20260417074010.1607496-1-rob_garcia@163.com>
 <6064b45a-b8de-4848-856f-383d2d06680d@amd.com>
 <2026042335-probation-heftiness-7399@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240464-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com,amd.com,gmail.com,ffwll.ch,lists.freedesktop.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[timurkristof@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D0AB45155D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thursday, April 23, 2026 1:22:22=E2=80=AFPM Central European Summer Time=
 Greg=20
Kroah-Hartman wrote:
> On Wed, Apr 22, 2026 at 04:11:15PM +0200, Christian K=C3=B6nig wrote:
> > Those points are certainly valid.
> >=20
> > I've also up-streamed a patch which completely rejects userspace
> > submissions who try to use the CE.
> >=20
> > The problem is that those BUG_ON() can lead to a deny of service because
> > they crash the whole kernel.
> >=20
> > A BUG_ON() is only justified if it prevents even worse things to happen,
> > e.g. data corruption or it would crash later on anyway just not so
> > obvious on what is wrong.
> >=20
> > Otherwise we should use WARN_ON().
>=20
> WARN_ON() crashes the kernel as well when panic-on-warn is enabled, as
> it is in a few billion Linux systems :(
>=20
> As this commit is upstream, and in other stable trees, I'll apply this
> as it's not nice to have a simple way for userspace to crash the system.
>=20
> thanks,
>=20
> greg k-h

Sounds reasonable, if you feel this improves stability.

That being said, there are many other ways besides this one for userspace t=
o=20
crash the system equally easily.

Timur



