Return-Path: <stable+bounces-249237-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFoJE+zaCmog8wQAu9opvQ
	(envelope-from <stable+bounces-249237-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:25:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9870569A73
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8B37302C353
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6AE3E5577;
	Mon, 18 May 2026 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/6jzKYX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TiRYNxPz"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCAB3E5EE8
	for <stable@vger.kernel.org>; Mon, 18 May 2026 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096141; cv=none; b=jprXueiErJDZnW6xSKRjVjio2RzoQT67Ldei/2HAi1qbUInb/GagqT0OoLcThNfgpacLPBVj7+ZjrHVq5QHBWYfGfEkc/l9XQuAGZlHhYOsLsZfYCpMkzv25dO2N1p4Vnt0cFvdRWXDEc1C+i+nTMYggKnEGdyxIRyrNRPU5P74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096141; c=relaxed/simple;
	bh=XwTgVrx2bklMiIMrHUg4G15T2KsYsT7zewWu455r+RE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UOx23QH+dSngiAJgnPh9udL+5dA1fJ6YbuFOTEMR/mBpxD8QKjBaxLOibgfQNxkei8Qx5V+7zicqPNjat0FSa0uHajWTM5B9Dsz9GQ3FnI1bhYw3+8DU9eOz9k/V68mffZhcn9kjfBU91t3YqtXGN/0T9I1mUOp7SYERmK7oq/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V/6jzKYX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TiRYNxPz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779096139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lQO1/7FO9sTnoT11sCio/KFSKpDAF4QkGjd6FaweRXM=;
	b=V/6jzKYXXtlxTs6piplNVLsGc8T5iRdD6eWd9Ar5pXs9MZKo0dfEsSfyA5uknuIjNBb1+X
	HNBrfYXHi+Jo5OwcEwiwz+iyy8/URB8prm7bzTL84/IUxgBY54nFXj19mMGnmmN00WFM9Z
	srYegJEgndC7Xz/bhfi6zaVY8F6ZnJ8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-1nLqO5Q2Nq-0S3NkfVIFpw-1; Mon, 18 May 2026 05:22:17 -0400
X-MC-Unique: 1nLqO5Q2Nq-0S3NkfVIFpw-1
X-Mimecast-MFC-AGG-ID: 1nLqO5Q2Nq-0S3NkfVIFpw_1779096136
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fd3449e6dso13197215e9.3
        for <stable@vger.kernel.org>; Mon, 18 May 2026 02:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779096136; x=1779700936; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lQO1/7FO9sTnoT11sCio/KFSKpDAF4QkGjd6FaweRXM=;
        b=TiRYNxPz8EkieyUz2CAp9At1vWDnV5yJlaNiBMRNvESaIWg/Qe3ceZJ3k2k9kVEWMT
         sG1u1OphvxQ87uTQMIg1oXR06DKqxLj/dCuuShTWy6wgX0CkplEZdGf/vdIWYrMVLpaw
         1tumgUFYUiZUe9Ow9Hi7jkM6EtV3DvBzGeDVNVB8GyxsPSczyTE2/YiZvHV3Zsi6B+eR
         GKZi2ZcLNKdg7RZqT+EEGhAvT0ZIP9cXTkMpvcFcppiDlIjRpZpZnI5A5IItGUdfXuDV
         Ha7wFvT7p+LtAyvU2jq37/4iNzmruv+AEpmGR7Et0jMi7A/QXfw9H3/e/4iifxZ0dJS4
         FNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779096136; x=1779700936;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQO1/7FO9sTnoT11sCio/KFSKpDAF4QkGjd6FaweRXM=;
        b=TLZTDQnDfCereRH0XdcT+/HdiyLKe0chusM49BB9h+rnneM0ACy2VNCoeB3ujJvom7
         twiiG6qY1xB/0/1FttauVeF7G/qEZm1fkKxHNsVSDtqWQx7cpZK4771AxVLm+IsYnbve
         bwpI6ja9HyJYHeXHUaUjeFJI7ZEY7ZolZW7roDhxeVI2B1g4xZ717TitEW0LY+m+9Zmf
         V48W0qoHyLdfsyXgakjdn7YrRK7UggBtB+8g6JMuOm58YRS2m0JdcOytu2cpAZgvp31U
         5lSG3R8HGWpBiwkII2kOhmc+D+j/zOQdzQku/g2sf4rHAoDD4JzIqWFjOq1bGPKapQgo
         WU2A==
X-Forwarded-Encrypted: i=1; AFNElJ+pc5mCqs3+6JY76fD+7q8neJoJaq96l8xTVIYjodMWMdKW05GNCto1xxNAd+AMbrASzmiuNE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHNspmARUUZBG2MKAzoHUwxPRWV2SCAOsW/s2tEndPGAqAFrVW
	jMBQMS/8dnq2D8JZijhhptKBD5gAikhiWy48pAzZQAbpS55QSzMuDUIWNmPnN/NhARqzPwq8p09
	gZkbCnnpNE0a15Hr2yS5B2PMgXomo/50k1I8PRc+19HJG/PPpt1LPLdYJ1g==
X-Gm-Gg: Acq92OHKkfOSdZH4T6HVwqXSxjCkq2j3e6FV/yK63sBztfG0igdT35yLiH6/9ryPVUZ
	Nma9pXEFzpa8FZTnge/joox9wflELONi5Xkest0e7DKXzKoSYIs+lxqP2sSHH0JFjUQYzGTN8k+
	JsjMTKvB6RkDrGXxEHuYMTv0+qA3EZlZNpKR7ioo0R+6LhPa/CX040oJuaE3YukPbbmwX0OWir/
	BSec9RGj4urs/SrJ9wwAL1zj54MM37Fnn82EHIYEE2YBf/ATEoeAjirA7shnSd+YtwdAvPa400i
	O7OP1GvyzExCYzC0p3maRjhLCAlPuJHcmAiXIYWqWbdQP0b7BrEsIddmRBiFu8FHw3Ip0PKEF12
	xOFlOio4iDNsTiZdJEVhumnxKpmC0BFLAOuTQjk0z9oqXknU4X1o9SxYQLzWQ2WnjXuJKNX6WG8
	tjLxwI546UmNbrQTc=
X-Received: by 2002:a05:600c:858d:b0:488:f453:b976 with SMTP id 5b1f17b1804b1-48fe651c8b1mr148072265e9.27.1779096136181;
        Mon, 18 May 2026 02:22:16 -0700 (PDT)
X-Received: by 2002:a05:600c:858d:b0:488:f453:b976 with SMTP id 5b1f17b1804b1-48fe651c8b1mr148071815e9.27.1779096135715;
        Mon, 18 May 2026 02:22:15 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fea52a0bfsm114035395e9.0.2026.05.18.02.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:22:14 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Julien Chauveau <chauveau.julien@gmail.com>, Phong LE
 <ple@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Julien Chauveau
 <chauveau.julien@gmail.com>
Subject: Re: [PATCH] drm/bridge: it66121: acquire reset GPIO in probe
In-Reply-To: <20260324193011.16583-1-chauveau.julien@gmail.com>
References: <20260324193011.16583-1-chauveau.julien@gmail.com>
Date: Mon, 18 May 2026 11:22:13 +0200
Message-ID: <87lddhxebe.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: B9870569A73
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249237-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,baylibre.com,linaro.org,lists.freedesktop.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[javierm@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ocarina.mail-host-address-is-not-set:mid]
X-Rspamd-Action: no action

Julien Chauveau <chauveau.julien@gmail.com> writes:

Hello Julien,

> The it66121_ctx structure has a gpio_reset field, and it66121_hw_reset()
> calls gpiod_set_value() on it. However, the GPIO descriptor is never
> acquired via devm_gpiod_get(), leaving gpio_reset as NULL throughout
> the driver lifetime.
>
> gpiod_set_value() silently returns when passed a NULL descriptor, so
> the hardware reset sequence in it66121_hw_reset() is a no-op. This
> leaves the chip in an undefined state at probe time, which can prevent
> it from responding on the I2C bus.
>
> The DT binding marks reset-gpios as a required property, so all
> compliant device trees provide this GPIO. Add the missing
> devm_gpiod_get() call after enabling power supplies and before the
> hardware reset, so the chip is properly reset with power applied.
>
> Fixes: 988156dc2fc9 ("drm: bridge: add it66121 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Julien Chauveau <chauveau.julien@gmail.com>
> ---

The patch looks good to me. I've also tested it on my BeaglePlay board.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


