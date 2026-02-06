Return-Path: <stable+bounces-214669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJgrM/0OhmkbJgQAu9opvQ
	(envelope-from <stable+bounces-214669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 16:55:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC37FFEEF
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 16:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 148C430398A0
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 15:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F4F2DE717;
	Fri,  6 Feb 2026 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kha5r/Zw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E092DC772
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393269; cv=none; b=IHcZdhrhYAZiVZM6uVFC8f6BlspMIYvaS/A02tu36o2Fx5zlGilakH4mdQispzqKdHBIE+IF/wqmJpV6cxG5lzb7Z0r8mXDXHmrH9ZWn6c5OpYwoa9QWLlQNS3ra1ecfOQ0l00wQimQEFuc8YnOsaEzykXdZTqV4Gcf++s6U9I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393269; c=relaxed/simple;
	bh=4wDpwikNwz5IQP5Nd+9I5r1hpnWC+g14izf4MF/exts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Udp6NTeRSi/ODSFVeOI1GhFfU4MsvVHn18zt67jadhmV14TsSOfR02Cw7HGuSiHepYagYLkt/28da5pqEs64XgqUd5cP4yUmTQLjdrt5HQmhX5f8VSpBBVhVv/gWChn9PmjEkmVRbNCerTV+mSmKEScvCtjliC2UK9KOHI1PRFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kha5r/Zw; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b8860d6251bso298219166b.3
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 07:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770393267; x=1770998067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etMVOc7KD+4rAqRuGUMOzPeLpua4ifj9Amz+IzMXTTE=;
        b=kha5r/ZwIIm4HCDGcbS/fYDS/djVlYYSUrzi9N8JE31X5luAZSrG4Mp8yqP9q74AWw
         PtoefZ8VAs48wrLtHEZY++G/E5SBfVGPhmsYZhTIC17lA8qVZUiXx9a8WmQg1P9RPGJh
         J0iKha+vG8al3TFqhdlywjB+EO5Q0/OCbM8QA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770393267; x=1770998067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=etMVOc7KD+4rAqRuGUMOzPeLpua4ifj9Amz+IzMXTTE=;
        b=WwwUo8BVbz38sRWesmY/X40vVLZ+OT5tjw1kCjqFFzkc5QRvmH0btdHAEg9h+T56GT
         V8zSUuuq/hHGThVJlef7G1A1LLe6W3jygLkPWbQe7gZ8T+9G3PPzxQYmreEaeu4QLcnw
         K1sFqkkkm6dnNtEo/yKFpKx4O9sbWAw+jLNiu0yJDUd8l9MqZmgmqSwqN4Kx4qWQKCYl
         p+2ba/Cfy9K58xIIagEQo1RkUzK7XNEoQuPttzT1NmOCwrybIb14LEQAB4zPBq5EfRFi
         +zLbHwKzb1fGcn/SPQMk3hyEcdCyJYpt1pbhXu+QTNAeNBebx8XybYpenkW/RmxXxJOp
         KHhA==
X-Forwarded-Encrypted: i=1; AJvYcCViIq8O2+fqVCfyqygLwBbJFX1/H+s2OhjtXZYCE8WD0v4IscxWRNJE3y7emRducAZ2Jn7g8Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlXc2jXfRJRUQV1Knj/PHDzq3HhZCSHCrxQOUk/Iuubmh1UBZR
	QMtFIgUIgotBXCUMxYIo7h1cLcGbN5poc5KAUAa/GSNjN8AqjNkHqPV92AK6VBwgmYOhYcx1NTj
	nXrWLlyPDoeg=
X-Gm-Gg: AZuq6aKvS3yFq4j7eCw22w0vLa0lyJ0Yk+dWP0HA83JUzUJohJYfTKW7PhTSf4Cq2Vj
	7bSRayyVYaqlsehEtgTBQFEvdWxZduyVpd4A511Gadaxf8IuFfPKwHy8OMNhcOq0OPEvrKeLKTI
	a/oJsewrCzZyAdstbEiyuKwerYyoSmLqtrqr04hD29iEuVLm+fX7VU4m8ww41X2YTJRfiRFjusP
	ybZl8DdDSrBsAEQ/sRu3+KBTYFeT8Hsyqh4oxyuE+wp9GAtwwlsl0gidopsa4oLWp6IDzo/jNz1
	AWpy6mFlhl5hQW1P1k2bHFd0MOEfFfYNFef9NfR9fnOwS2PcL+qeKXJcgYAS41fEUB3jCl7Mjab
	+tunykA9BPI0I3V4Z6g6mc4mQQSPOOBHuX/k83ziyygIqBIuw95+isaQH7jT2I+xZ5B3kkmz9mO
	5aZ1j00K+XeQyAkNB2UMMhHafYvTzdvFEoe6I1aRHApbkzYr4Phw==
X-Received: by 2002:a17:907:a4c:b0:b87:c92:25bf with SMTP id a640c23a62f3a-b8edf34d44dmr182244866b.33.1770393266643;
        Fri, 06 Feb 2026 07:54:26 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda7a3624sm91969766b.23.2026.02.06.07.54.26
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 07:54:26 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43622089851so1753189f8f.3
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 07:54:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV28XcsQtn50J4Am3tznO2Qvv1x3ZegajnX5lHec+K7/T5ntop+MQ6Qk8h2zDUHxXCbyyXYqCU=@vger.kernel.org
X-Received: by 2002:a05:6000:200d:b0:430:fa58:a03d with SMTP id
 ffacd0b85a97d-436293ae118mr4862176f8f.63.1770392781791; Fri, 06 Feb 2026
 07:46:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206123758.374555-1-fra.schnyder@gmail.com>
In-Reply-To: <20260206123758.374555-1-fra.schnyder@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 6 Feb 2026 07:46:10 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UO3wHqGKep67pY04PgBJKgvOgDf8u1qxeXmWkgVMLXiQ@mail.gmail.com>
X-Gm-Features: AZwV_Qhcv-IxPe6r_qqtTYtGlVNepLgatAVvPPQTa8PlDibDivxEWQ2rEGCs3tI
Message-ID: <CAD=FV=UO3wHqGKep67pY04PgBJKgvOgDf8u1qxeXmWkgVMLXiQ@mail.gmail.com>
Subject: Re: [PATCH v1] drm/bridge: ti-sn65dsi86: Enable HPD polling if IRQ is
 not used
To: Franz Schnyder <fra.schnyder@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Franz Schnyder <franz.schnyder@toradex.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Francesco Dolcini <francesco@dolcini.it>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214669-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,toradex.com,lists.freedesktop.org,vger.kernel.org,dolcini.it];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[chromium.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,toradex.com:email,chromium.org:email,chromium.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CC37FFEEF
X-Rspamd-Action: no action

Hi,

On Fri, Feb 6, 2026 at 4:38=E2=80=AFAM Franz Schnyder <fra.schnyder@gmail.c=
om> wrote:
>
> From: Franz Schnyder <franz.schnyder@toradex.com>
>
> Fallback to polling to detect hotplug events on systems without
> interrupts.
>
> On systems where the interrupt line of the bridge is not connected,
> the bridge cannot notify hotplug events. Only add the
> DRM_BRIDGE_OP_HPD flag if an interrupt has been registered
> otherwise remain in polling mode.
>
> Fixes: 9133bc3f0564 ("drm/bridge: ti-sn65dsi86: Add support for DisplayPo=
rt mode with HPD")
> Fixes: 55e8ff842051 ("drm/bridge: ti-sn65dsi86: Add HPD for DisplayPort c=
onnector type")
> Cc: stable@vger.kernel.org
> Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

It's weird that you have two fixes, but upon closer inspection, I see
why you tagged it as you did.

The first commit that landed, commit 55e8ff842051 ("drm/bridge:
ti-sn65dsi86: Add HPD for DisplayPort connector type"), was still
using polling mode and just using the HPD line for polling. That
commit incorrectly set the flag "DRM_BRIDGE_OP_HPD". So the proper
backport to kernels with just that commit would be to take away that
flag. Unfortunately, I didn't notice this problem during the review
and I don't personally have any hardware using this bridge for DP,
only eDP.

The second commit that landed, commit 9133bc3f0564 ("drm/bridge:
ti-sn65dsi86: Add support for DisplayPort mode with HPD"), actually
added support for the HPD interrupt. After this commit, your fix
(which makes the flag "DRM_BRIDGE_OP_HPD" depend on the IRQ) is the
correct one.

Unfortunately, I think the above will confuse the stable scripts.
Since your patch applied cleanly atop the first commit then it will
picked to any kernels with it, even if they don't have the second
commit.

I think the first commit landed in v6.16 and the second commit isn't
yet in any stable release.

Maybe the right way to look at this is to just call the 2nd patch a
prereq? So this:

Fixes: 55e8ff842051 ("drm/bridge: ti-sn65dsi86: Add HPD for
DisplayPort connector type")
Cc: <stable@vger.kernel.org> # 6.16: 9133bc3f0564: drm/bridge: ti-sn65dsi86=
: Add

That will cause the 2nd patch to get picked up for stable too, but
that would be preferable to having just your fix without the 2nd
patch. Alternatively, you could try to add some other note to the
stable team to help them arrive at the right backport.

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'm going to let this sit on the lists for a little while in case
folks want to comment on the above.

-Doug

