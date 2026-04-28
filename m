Return-Path: <stable+bounces-241730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIewKh3h8GmoagEAu9opvQ
	(envelope-from <stable+bounces-241730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:32:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B223488FED
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25BDA316D635
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F5432694E;
	Tue, 28 Apr 2026 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6WlPMDQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6473264FC
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393353; cv=pass; b=hUkVcuEqdK6SqCW12vGaH/B9E7ossjSburmsxibt4MHYVU6ucI/IIRODSEw9PvT13uvw+23mXEWW5JSyrse7Ixj9xhVsQaf6Ez4mm3N3+CiIiPYeIDZesFDHGhNNREnhQJvZum9bTZW9UuGKE2JO5T2/g/g6HD/PQyMAfXI7HgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393353; c=relaxed/simple;
	bh=6RQQwYcPELS1NAz7zt+fqwKi61/aTOp4k08nEMZJn34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koOOAcjs/kirkA+5f6lORsri5SZYORlDJ62NDCjbZwqEuATkC/LbFoxsx+Tmk96djajAyEZIRh54YR0PskKjAj1XtM/4O8PSfeyo6szKaLr9uT7sLyW4HslRe2PlmsQeBHwhlIpwqENXyGZFqjDuaM6hSNoatk1lGq5y922D1CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6WlPMDQ; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65318dafbcbso11893098d50.2
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 09:22:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777393352; cv=none;
        d=google.com; s=arc-20240605;
        b=adiNt5l13Kql/vihDkwh9e+im0RDZxqFkKbHAyVwUw720kLDCXQMAFdxsYLn0RYUUJ
         iLB7BsfTpQ5/b18V31QOxQHusWHuHuXM6LxjfOkLtutK3ZxJSMTkjWPC8qnrKcpimAfx
         nB+ehzgWQm1z2OpXYb1MC/LMdz3q0fdwk/IiAzLt23JI+NCv1SLqquVsrilsf9WasxQ7
         idzEMs39C9GEPI+7sNUBhIA3FCFI3URV/CnDPqnrW0Sb1wPboqIHan5jp2g8BlvL5+p8
         mqMeRACs/hDb4wI4dSmT7aDGr7M8RS9Fxll98o2cZeRLJFU/IbXMBuW8pgEcYGktE7fM
         Gzng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6RQQwYcPELS1NAz7zt+fqwKi61/aTOp4k08nEMZJn34=;
        fh=972QPGvOheV8hI4IDbyKH7fifgadSyt8J/zLlyMkGM8=;
        b=NUEImfSRBU6YSNh0j/OzHH6M4mA6fPA5gya310x3EXPiU7MV/lXNXHjyI9mDSzZduw
         cZ7D3XPvg0TI6TeDCEjQPvYR+KzSnhKvjTGM7tmXUbCUjklAYVafBTp6vcME1pbZEP/H
         /JMb0MjjUvlcJEeMtuiSaZSv5KnCDKq478FzI+EVSJQ9hbK1ysE4I3zCrwvbW8SyKBkC
         9Bkx9MaynAO9PXrbEazCtzDo8LNH2L8CYgPh3tqhdLlaRRoGPY2sGoaLMQtROmSXVCAV
         ONkGWs59CvHzNmI8ubIY+2lw0jC/hiF4m/yZMQRMXdLS+XRQ7eXgipgOru1Wy26oeDzX
         szMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777393352; x=1777998152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6RQQwYcPELS1NAz7zt+fqwKi61/aTOp4k08nEMZJn34=;
        b=U6WlPMDQwO6xEx5N+GIgp7SqpDyNh/1uqIc2sSFuJSLuG7t4W9P3urNdBY2PzGfdIO
         68OdqpJ9DGqVpKUx/owDXRP6AZyfvjXj+Uj79j2VigN9OOt/wGCIZ364rjHkfWQ1Rx9y
         MkFx9ERRooO26nq/0FHfNgDIYUT3djhgMOdJ3sgCTy3Xe9rYuJ6A3pi2UT/Fjpr11UHf
         Mi6NfrTT9xponI8ZMSCyekRuc1FHhreZi12dgRpbAglR7tK22OJ9FkqDbuMOwmfDAzkY
         /4/Bi/MIlUc/ziXBo+J/VYrNGHIZjeysSocFm3RJluPKrolgfYmkWm43ZtL3R1RYSenY
         Ejxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777393352; x=1777998152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RQQwYcPELS1NAz7zt+fqwKi61/aTOp4k08nEMZJn34=;
        b=SioLglhDRLtinMPjipuF0jGnlYo63xO6f/rIs45W55W0M6c0ZT3OJvW9odCGjSYnY7
         rGNweFRB7ZQYz2wvDfculSgMcAxTQG+lVhrpIZsfEcz+krWrzNOD1rqJEpkD1M8fhOVs
         SGbdPUEO7VOOztal+M2lpMTWm7fbrM5g+hVsFCvN35UOhkjJw2H0xQS8yfW+FkjZrdGL
         7W1emFZWWe+iIXvHmzQXgLAhQv5S4psydsZd+Z+QWfOOIn5pwyup6htLTzcoI4yHn10V
         Jr20Kx6GSXhfgRw9bghQHLbmcDIrkEVkUAKYnFFl5mHCFW05IDoc5NGG/9USzXKrSk+5
         j9bA==
X-Forwarded-Encrypted: i=1; AFNElJ/eOdbd7uRgNiaRC9tfNgwZ1IEMv9GHfX6In2CL2pqzo2SHNdo2q26JB/dyLJV3lOH3ktZyoCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhz0Vlkr64vSvq4kHV1UTea3koLAisQ1AgxrEE8+eZ/J5rpVM4
	6JAbw2nMCEj/7LP7DP0xSvH8mrTwRF2JhqwefS2yd0MuHn23qtp8RhB74jRFTRmfdNnfMsh0EGZ
	DbBJIjD5EMI0ZB1+gwkAnHn9oAv7jOS8=
X-Gm-Gg: AeBDieuBCc4hxaK9flCaJuY8XTgyA0HAWwwMwJFWaVbvLFKYSLxzMlzpwTziF7JDAts
	xH3IOpqpgWf0Uc2nyx35UDua+eESrIYue3mUQRRbph+ZpmnBW/lz3O4WbnbSrr+rwWyEUYDxRYg
	RUTuDz0P3pDTOcO10RnDpJkz0srfYnskITwYULZV1dXpsSS216B6c4K6sFc9WyNlLZC8OeVJMgE
	4hm3QYYMvspRqUnJ0tHfxHQWc7QoLqMc6GajZcOwp0aZ53RmbHvZBApJGyQuCEAFaVoXxm5E07M
	+1P8yYblLRqn7M9gfzjg
X-Received: by 2002:a05:690e:d58:b0:657:4633:b67e with SMTP id
 956f58d0204a3-65bfb71052bmr324700d50.46.1777393351810; Tue, 28 Apr 2026
 09:22:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428154716.375069-1-lgs201920130244@gmail.com> <20260428160619.GJ849557@ziepe.ca>
In-Reply-To: <20260428160619.GJ849557@ziepe.ca>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 29 Apr 2026 00:22:24 +0800
X-Gm-Features: AVHnY4IRwmpnVMv_0gH3lQ-4VAT_2-IrNwFWgWQ8swPc_vkx92CB_0QETmTNdcA
Message-ID: <CANUHTR8TKCN-Bq0b1C_7gmK8hj133EJ5BLOrsD0SZhiCtUUa1w@mail.gmail.com>
Subject: Re: [PATCH v3] IB/mlx4: Fix refcount leak in add_port() error path
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yishai Hadas <yishaih@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Jack Morgenstein <jackm@dev.mellanox.co.il>, Roland Dreier <roland@purestorage.com>, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1B223488FED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-241730-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi Jason,

Thanks for reviewing.

On Wed, 29 Apr 2026 at 00:06, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> Do not put double returns in goto-unwinds..
>
> This should be fixed to open code the kobject_init() immediately after
> the memory allocation so we never switch between kfree and put, and fix
> all the release functions to tolerate half initialized objects.
>
> Then you can remove the mess of kfrees which are all duplicated in the
> release function.
>
> Jason

I will respin this so that all failures after kobject_init_and_add()
use a single kobject_put() based unwind path. The duplicated kfree()
handling in add_port() will be removed, and mlx4_port_release() will
tolerate partially initialized mlx4_port objects.

