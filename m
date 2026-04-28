Return-Path: <stable+bounces-241661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC5oC7y08GlwXgEAu9opvQ
	(envelope-from <stable+bounces-241661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:23:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77823485C6D
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A72FF317B3E7
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 13:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73A844CF3E;
	Tue, 28 Apr 2026 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="YoALdveA"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8333F43CEFF
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381875; cv=pass; b=q3Neb1v5zAVp9MC41iEwChqTdrz+3YpS3qSWH77pTX2+vdV+4jVgxTQwIjMdX0Fz7g8Pvptw/oBr1f1ogxZEuN4xlYtdFfXKkslX9PcHPCcULtPwohGij/pwC0QHDEI0fCIjsHvqKXLqj6L40yDq7EzVcYvprD4yv9uY8O29XRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381875; c=relaxed/simple;
	bh=2PXkFh8GWhzh83Kpis/BU/Ka5YuA1wSPtI4Zd+aMZOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTVdIpGkZ8ugNRHZZ1K2zB9xIW/o9e2Fodj+huCywtgLlHsxNiL9Qkarbi+TIt/2ltE1P4QSQSCsGo91o6mDFu9WVjp/d0u/n7JrIcrTR/zEU60PwgEaJqGITvbFaPwoehZEw3kIocDCA/PsJ4F2P9MqN9oSsSzrtWGGZBfWgAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=YoALdveA; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8a154cc6a48so125517396d6.0
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 06:11:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777381872; cv=none;
        d=google.com; s=arc-20240605;
        b=JUAKDz44zq6w4j/EGLX5OawhF9F9xfBHEUK0gdRmGnNQ7724ikUQmXfo/nkp5HZVJ1
         02EL/7Aela/CmIcmocxt1jpx9AYvQ4qAxPfoqID4IMkuUVDDz1b24757p5JcadRahzR8
         VZWV3C3xOfwVJcvVCjV4vSkmjM8FAZrzJupInh6raUR7FXx8XlpfNjpkf5DMu6xzfqFm
         LPiL7h6FFWqaR531ciy7VfWAxQDlk+iWTMjZkRqc4gDPT1EivAs0OVoq5xEOY14R/qv7
         XnjYAAVvalarTYncsew13/aMRoNaIaIJ8M1RZmEx2k1l2KQX7pNDaaNZOTkIBuGdIEqY
         Iavg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sQ0kop8xDcm9PEnIMzOMkspkG4xjsdA7aPahAZouQKg=;
        fh=0zC2Ii6RhK30sua/oTpBB5HgJtFDoMi7a2399YvghGY=;
        b=OWjkmaVRHnPz9pyXlzzvhj1PY0L8ifxQtfaeGkD4ePyAtXUWxJN+fCxlrH8hv3OReK
         kC9Ryb6LWTxz1kowiyzBRqGFOFf+7kX7st5zv/lRq8hVYhGBznxavz1YahVjZQCZQnlW
         tgmE1xt+ZsqyTn5fweWg/xGwCV12Sea9Qf77dOOxPZ4cDq+iDJhyPS1JnXLw+UNh3wQW
         DhYNpVYoxDbEXVB2NCeeBvTf6X7QAZhsXqRr3VzCyffiiRgbM/OXQUI7HdVZz+7Mrvxy
         9o19MTSGeSiWje295E1XKpQje6+BYw2qUP8ICRREHBeTqn/Ye8DNxVSlzHU2rRWUddiX
         IkyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1777381872; x=1777986672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sQ0kop8xDcm9PEnIMzOMkspkG4xjsdA7aPahAZouQKg=;
        b=YoALdveAEOw7BTjYZrpbBMjAFNKNnYsdEVjNilbDIW0/GTzxRm6NXQ4V00jDWNI/o3
         X95OVVUSDi7a9bWx230feiuh1mbrf869wmqIoVvpdVUFz8/jUVSRqYCId4cHN3G/zHWT
         Xvk5iy/ZO1bJ0s+KT4hjEQDMSU5KQ+7aSxwAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777381872; x=1777986672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQ0kop8xDcm9PEnIMzOMkspkG4xjsdA7aPahAZouQKg=;
        b=oCQo+/CGxG7GVgApc01rgRQQsKwEv0xPgsU8zUk2gBSQkg/GhJ5mFZkgcz8K1rn+Ey
         dTPO0jpTKaMTRxgFkrwaWEBvl/aV2pTZweqZOPUfMQXcsSKuVs4K7FhLnqO2W883QdAj
         pu1GFx5k+vBuDwdgutEsg92GFMRFzaXgRWuDO74c+eM+9XqmrqKagXacPQkZoJl58kIx
         vSmWCyox7exmAoCSHsqLfL3CI9vDvZcGxGxW1SvvQjuFExfXAX8h76N0xutIrZsb9cjt
         vxkioWvAIrRKziXYvvTVKgxmrVaw2QfurHy2dmgl6EVTH1KbPteF2M+8WMe+T9AvlyoS
         JG5A==
X-Forwarded-Encrypted: i=1; AFNElJ87xp93WpsGnBuE8LcaIn32/NUlPu0MLPZm4axpzTOGVmNBqC4x18HCZyfgGsgB9KrkqkAk1DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylIDHcGP2Wxq7H8RTPrpgBFjn6hd5e3vQq5sY0LRoE84UX6DEZ
	Tg5jgVcwXIQ7DSRBf6KS7CJCJgr1UzFwQbW7phZHnX9MGGAntY1ZNusWyrGQdzDEzPhS6eCwQEY
	3vL1UVYscBSyGMxmcmTdthUzEe8iQAYOL8LJPwsBECA==
X-Gm-Gg: AeBDiet+1OF3JuKqIiLHbQbovZn3IetrYvAQgB0dmx9mQzbAzFxmU3UujL778qdO9+m
	ffaeEvutLuuWd49VGPK4BhqGYQlZY8IkIRAeJqDnXSrMBw4YdbH78Rqbqdgz8+wwJH3Mwc9b9Aj
	gTAb0e5RUOlUkifwNLF97mgUxPZTPH2SmNUN9NJuFtWXoSs6y+CN5QUBWyCvtuOpLl1uyvK5cZa
	k8Gr7dsJ4G7L0snxpiXUNrgk9zo9UViEA0rrkaougg/2bS93Mjb2jZkbwlNHVtIbPYGb3NIFomu
	yNgOwgARuL+0ZAcacbQ/S0PcswxlbmMN7bTH9HZYSgZl4FJgq4s=
X-Received: by 2002:a05:6214:428b:b0:899:fb4e:47aa with SMTP id
 6a1803df08f44-8b3e31ac152mr50521376d6.39.1777381872299; Tue, 28 Apr 2026
 06:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428021304.2338592-1-mochs@nvidia.com>
In-Reply-To: <20260428021304.2338592-1-mochs@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 28 Apr 2026 15:11:00 +0200
X-Gm-Features: AVHnY4KuqhJBOUqh9rg5qsmJEQclZpBku1Uo2RuOKjIVdiI4OqyYu7n23BussEY
Message-ID: <CAJfpeguzUDE1gegKA3WXCORZZRQrWCRsKe_sdLKtGHqRd_vyyQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: do not treat unlimited readdir count as a buffer size
To: "Matthew R. Ochs" <mochs@nvidia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 77823485C6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241661-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,mail.gmail.com:mid]

On Tue, 28 Apr 2026 at 04:13, Matthew R. Ochs <mochs@nvidia.com> wrote:

> For virtiofs, the output kvec is included in the request bounce buffer
> allocated by copy_args_to_argbuf():
>
>   req->argbuf = kmalloc(len, GFP_ATOMIC);

Ugh.   The real bug here is inappropriate use of the bounce buffer.
fuse_readdir_uncached() should instead supply an array of pages.

It's a little more complicated, but would fix this properly: overlayfs
does want to get as much of the directory as possible in one go to be
most efficient.

I'd go with vmalloc -> alloc_pages_bulk, then vm_map_ram() before
parsing the result.

Thanks,
Miklos

