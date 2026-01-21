Return-Path: <stable+bounces-211175-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNCyCmM9cWnKfQAAu9opvQ
	(envelope-from <stable+bounces-211175-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:56:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C63915DAC5
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F4F0B45CC3
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2D272617;
	Wed, 21 Jan 2026 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCGdV/MT"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212A53F23CB
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769027992; cv=pass; b=U/XiMYevr7xqzfuLt3JLPllhM3GSAieBXxAOV3IEgXYNqa8M3yJ6M1friX6LEzca/aBJDOJyiqcEm7xemkX3IxJSs0e/ULsYfx9Uk7AgxpTiq+YlO3U6zjUgWo7c3BEvOLgDjXJ/8Gn1UnhPl/ebCnZUYPrZBrW+qhmpvEiuC1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769027992; c=relaxed/simple;
	bh=p6ytRu38LgiCM95iKgx0BFSPjzRjOBEZFM4atxBPtWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyQD6zPaHOLVT3wynNu9g8JuCNjIH+a8cO4kE6Uu86KgvT9HavPpDCY9pEvpRHZxanXRwaWxOo5FQ5Yp5PEr81NbI6KkCkkZCAf4sznWXtt4UpvcugK7xaMDMthwppfaNBwzt/uBPsrLdhJyuuArX27ewrWH7e/VJOYoUo03gWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCGdV/MT; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-894774491deso4037886d6.2
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 12:39:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769027985; cv=none;
        d=google.com; s=arc-20240605;
        b=S01rV22nrDgQgW120z3x5vGmSbrNdBGa0eqrP9fPpHfrEpB70VtikkzWF8uj4YpDMb
         Oo1EQnrP0UuOBuZ4lzlcnHH+DhZSQ/OaBiwUrCRu1/jiqi7YUUW57Lm0G527Y85vk+z9
         1PQeQhAzTaPue2e0tLYDB8iCWmdvCXAXn7FC+FyIeFvhZbgbVLO8yKIV/8H5kOFyxXro
         FnJjmPFBmDbuPSxGL1JiXm8Eb925SYOLd48VLLW31ISBu5yhWNl8zqa0WNrM3trTCRpP
         MN8Mk/gLa2sIc1YsV2Tx1qP5JHX0Of5A2MD2QjmX8LqHZ7hRNkGmjUX10vNjGd5ircjs
         +wvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IsKbMXb87YbdFAxJ8k3qkHdu+oabtMAOpKXMPv5pVTM=;
        fh=JJxrfrstJ9+f7fTJxGijt+1ObGJntyX+11Ak2lifWXA=;
        b=HcsngFxGfj7Q+V4R9+Qky+4obZLdoBOE0k9bk9um1I2dXSNPTSEDGTJyKBgErwZhJj
         efCxBeXpXW1op12y3Vk/OgXBL23fqWEVdliT1MF19KVlnNILx+duGnKtk+4iK0Wl3Uhk
         WPPmLpJZJi815fC07m104My7g2OdIxQo7twL/HhGU4fGb+DdNaVvYhfF6wxvdzeOsZtT
         jFhWdKpVbP6ct5oVze8izz1V1Bz0nb4cMqZxQOG/6/2JcN7ra+VAVpFR4JGjmYnN+QSk
         BSEt2SbqUqSft3T+ATmAQCnutZvD6FocX5s49YOYwTYwXRrmtgbskTQQSziIUNDS1sth
         F7fA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769027985; x=1769632785; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IsKbMXb87YbdFAxJ8k3qkHdu+oabtMAOpKXMPv5pVTM=;
        b=aCGdV/MT9/T44FgAYymQwdGpHz+EXxPSvU4NZsd7VCreoCXSOrWFOxxbhpLmb490v+
         V17e0M99XfkUfoqEC9aYvykl8pUaIEXUS3XgWrggg/8nGpAJL640h2WPTR2CZTHjYtZJ
         J3N/n08vO+HKXyf9NB0gzlmxgfq6cGCJCEMjhzJPRJbahNbhFGEhkfn59GeIGTG5Vkg9
         z/Z6YzCaPuo52/IrSvGGivd8mbngMYFkCHk0ZmAilFSBICho3C0kRu/EXoujMHpXIsLP
         7m5cuUCUCHuxd+Pe/PS1yoAxLO6VGkxjd5bvzO7S2XE1M0wqep/v9JSerXxnsuX6/FSE
         Zg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769027985; x=1769632785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsKbMXb87YbdFAxJ8k3qkHdu+oabtMAOpKXMPv5pVTM=;
        b=mzPvrOVD8Vdb9gqnjXYvctLdGzzmdebg8XxayFTtZLTGctkvfHFd7GB99ni+Y4I3PD
         QxQ6R1GW+MicXdVQlMuLT6XizimxZOztO+TIavVlNTfvUBSKyd6RWd4arTPgdsVqFENQ
         GqH/MFHs9VVkG1dDV2dvfBWHHMPQ/d/f/M1qTwjGSskDAc+VkwrgDKAHe6/nS4qMxEQZ
         aWr84pXcGYjgykEzMQChBIanqqF8PVyoL02wV6vxqkEL5I+Bwp65w2n9zrd0dxj9mq5P
         OrtxxNCAQUYSDJLF1x/OCOnwojfqDRKJAo+furyd2oY8MZJkByIbYUda8agvVhcepyZU
         eHnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUrVRwDTkXCT4ToKfQZe1PqOhEVuTWng6oHFaiBL++FL0V2cokso9KhTy6IhmkGGRb8nwV8p0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9I7lKsSiVl/SZvlE6UONe1RqiY6T8/NyZKNaX5A4tT/nzgJJ7
	oE79VR9TUL5fIHmMDDwha7WtXsXv2XtTYgpe7rHZKlZGaQoVZo7gRHoaTW4dTm3lE7bvWHGxjDN
	PDY64nsmKUnGor3LAJ4UNCXtljRQ4KwY=
X-Gm-Gg: AZuq6aLO/NBi2zSvcuQ4q9wtctWwMG5f0EtVc4yCd6yEVOcwPOs2+5no9lx5rp3tAH2
	nCi/xN9qORBdWNXQiAYdIO+YiqDLprIqqFYa//e4keydqkzpu9xm1si9XoQpZxK8tFSlPEIkaEA
	EEm1u9QGL8VsqNpRaeC65iBhuCNjScA/HDHCgsk1xMeoKngbz3PspDL7ac3J49eFgf6zYYCaafV
	oU4FNWaRrkGk78vXKLVTIHuO79OMPZQJYhSJJ/Y9yxY8B5H+R0OEj9hbWXEVjJ/HJuwqrWYa83H
	KkDAT9L6b67IH8hoLNkiq+K8O1RAvEJdCK33uZnNCBUz1PSlGW6haTw=
X-Received: by 2002:a05:6214:2681:b0:88a:529a:a53a with SMTP id
 6a1803df08f44-894638f61camr101162636d6.51.1769027985195; Wed, 21 Jan 2026
 12:39:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121191320.210342-1-lyude@redhat.com>
In-Reply-To: <20260121191320.210342-1-lyude@redhat.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 22 Jan 2026 06:39:33 +1000
X-Gm-Features: AZwV_Qh1FXsbPqa-FcyvA6O5iQiCl9rMUe_JWAej1pc4cnRhG7fKxVLa5VZf6Dc
Message-ID: <CAPM=9tzrCNH3DgRyJ0=KkeQ+=ENtev8UOYLXqHO+X7uK93dJNg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/disp: Set drm_mode_config_funcs.atomic_(check|commit)
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	nouveau@lists.freedesktop.org, stable@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Simona Vetter <simona@ffwll.ch>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_FROM(0.00)[bounces-211175-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[airlied@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C63915DAC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 22 Jan 2026 at 05:13, Lyude Paul <lyude@redhat.com> wrote:
>
> Apparently we never actually filled these in, despite the fact that we do
> in fact technically support atomic modesetting.
>
> Since not having these filled in causes us to potentially forget to disable
> fbdev and friends during suspend/resume, let's fix it.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Dave Airlie <airlied@redhat.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/nouveau/nouveau_display.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
> index 00515623a2cc7..829c2b573971c 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_display.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_display.c
> @@ -352,6 +352,8 @@ nouveau_user_framebuffer_create(struct drm_device *dev,
>
>  static const struct drm_mode_config_funcs nouveau_mode_config_funcs = {
>         .fb_create = nouveau_user_framebuffer_create,
> +       .atomic_commit = drm_atomic_helper_commit,
> +       .atomic_check = drm_atomic_helper_check,
>  };
>
>
>
> base-commit: 68b271a3a94cfd6c7695a96b6398b52feb89e2c2
> --
> 2.52.0
>

