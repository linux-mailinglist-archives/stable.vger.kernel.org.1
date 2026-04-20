Return-Path: <stable+bounces-238679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJUzHkqN5WnXlQEAu9opvQ
	(envelope-from <stable+bounces-238679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 04:19:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F1E4262E1
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 04:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BAB0300FC7A
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 02:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D9626F288;
	Mon, 20 Apr 2026 02:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVUiST44"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF6527281D
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 02:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776651588; cv=pass; b=Odxqr/LSRMdrIHNdMjJoXVHhUgKgvPinJfBUfVShx4vRWlfZ/KTfN8ucVQyW3DPoFvrbjh1jV9ulK8t2pfXuUxJulFCHThMuVkOdlWdtc2IHQTMX4bDee7BgmpZPjlWcttk8u2dRVKhYp6nQdyp5BRQj2CEOSyi7RsS5YaDVU00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776651588; c=relaxed/simple;
	bh=Mn2XEI38VK14s4TDNjxRsEErkOLyfZwZt+XdGzTxUC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f47xwJacNOOP3KfKl69G/hvhq7d7v6gYXLUqTmix/GK+X5FHo+nBDKgmExcOxTR2beNeylcfQPQpspH1D+Ub6w9AWqVFM2YxsCU28OCBHhCwUP9zM8cPHH0Eo4nuu16R74jW07cpL7ND8xr3rqbI7ok9YNng3y4WFx8Xn1UzrL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVUiST44; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-650789b22e3so2703016d50.1
        for <stable@vger.kernel.org>; Sun, 19 Apr 2026 19:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776651587; cv=none;
        d=google.com; s=arc-20240605;
        b=ViFXlXj2vTcNXykUqyqo5AFanDpGnAZOb0Q5zim9c2wOJNYKL94I36N03Lo7oMVRww
         NMIFKHtMMYE0y6V2nFWTyULxM9keFaLAV4xAPE2etOjtOztMIZW5EttZBqiUBOW8zHO/
         l/+dHcin95MBmq6RZih32GcyPNBsvYgsop0sJCmrtYkuJFyj2+lDoazNCeVkJRPZipLu
         AUuTxeLW/ImgWNKukw+z+RAONLSPmxtuGvmSQ1viBcF3RNaX1DZ6DcrOHd4QbE+pE+3d
         q7+yuQmAma+Wgs+G3G41CyyGfbMKvS97ZxpDmQjQmeZkRt5sYuum1sW/KsMXiVxFs8WC
         CB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Mn2XEI38VK14s4TDNjxRsEErkOLyfZwZt+XdGzTxUC8=;
        fh=7B0s22PSNFTwo1JOINdUCPxYqP+dgUWXDQb4qufbcqE=;
        b=HV1TIOGQTS4NbYm7tFCkZTYR7Ps+pJAI9HFczzQF2jnYm2kcBHXqaoDE+bm5D5a3UH
         vqb3A0QmbR5+FNxm2PigLwN9GHHqZ6bHPIxaZcTEdIqeQwpiOwI7v/Mj4anB1qxV9087
         Uw/1N9OqH5WjWBHbRGw2OrlDdPFrYZuMfWThA2Mj8j2VzSBj5CpuIfUI4wZ18a1nI4+f
         SayjqZQ7aVR8hoG6wVGEJ3lD44JTfMps+dBI2/VeyCEoQ6oecbPPtGY06L8mWOBM0TFs
         oarb1bQhahj+fTKplcXLYDSJYB5Hm4nfk20MCwajJlPGD6dzuuH0XDVhq3DN57QZkh8O
         P7hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776651587; x=1777256387; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mn2XEI38VK14s4TDNjxRsEErkOLyfZwZt+XdGzTxUC8=;
        b=gVUiST44Dc+6frxbkgjgjAikr5M4DRKAs6UD7pitR4M6Kv2TjpxchTxn0WrFgEtgL1
         q3R3pAmBGY168MqzEbhP1moUq7nSeEjBeGr8CwPsMYoeUc8S5vGAvDRNG53UjlK+HCsb
         b7CGBPuy4waCY5KUAQsmQRTxb/k2mjj2X8WNRxsIX8W779La0x4w0xebGjsI2i6tnFp9
         fuWNMc8OdNoyHhVhlChmSvzlIEybyOSXN2WgQfnKg+DgTrIWMAoL6gpszKPW8ge73JJW
         BGuwwmO98W/xFMYWoHz2E9zTx529AtRGTJJE8W6oWiTcc2rdbTBlLOJy0NkRzg1FtYLl
         OWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776651587; x=1777256387;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mn2XEI38VK14s4TDNjxRsEErkOLyfZwZt+XdGzTxUC8=;
        b=jACP09NQm9JPSz2UxploR6n3cFRWqEa3fM20WOdKL9n8QLIScjm2ZNhHrOdxrjf0af
         L4YWt+99oXdBjYLHXSrsBSArTS0Do2jDDxDHFQDEowB9QPt5JcZtujcTmCBeRraS18GD
         BvoXPdWso84MZ5mX4szk4JuAdYf4afW+2Oy6fFHGEKxN+ebi9tCJljZMWPjz1OHpHO9e
         Rdcz2PGcLLXr5WWWqja5jrQCnBj2UvqNa5Jj6riqpLFg9N6r5tUzpX5+fj9oO3Wb776g
         g/j00ewwLY/oq8HLtFcXOFhLqXb0lHMmJU7kfmcBjguO45Xqg+5+xSJ6oTVnNMDYG2vS
         O57g==
X-Forwarded-Encrypted: i=1; AFNElJ/5B/f6+pg7OpxcYfQmIQlncRTnj/HxpDIHwMXcYGIU9yt0UP1DA90XkbQaan9wrVpyZ8aKGQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOQJmVyPvbCmXxNg6HHp2o+U5OJbcDAuoUEEBjuNauLR+Liktx
	KVYvYUWeUbH6crhxx0Vp/WWvrdo88fdXlipXYkr4eimJZ6O7VCIDmGz6hc77KVYsiGZ5bSCTzQ5
	33HQYHZ/C2EWAa0S1h0ai4bIOSf6FvFc=
X-Gm-Gg: AeBDievm7DjysmotVjHL9f5sqcQnAHpiUfsRXt/a44YpOP7ODsqwqMm5H4V9jWn9RBL
	KxuImbMG95mHt1ATQsV47BCOGm2DzOXmRd/duyajCbpgPYXtbIC8ZOImt7L6IVYD6FHnNO3AXjz
	pGC1TO0SqKtTr1YqC6GXgVnhCxARWxTW4gj3ybFkrayBoNh3vSxhM0b6dxtJ8UQO4qkJuJxWX6R
	D2Q3xEUmbYIsrrAcERYJGKHCjc2+CfU1A4AOYhTzPNKCouKc2s0T+ppunnlZuasmxd2ZJXgy8sT
	+fVGQK0EygUscRSNvopt
X-Received: by 2002:a05:690e:484d:b0:649:ef06:161d with SMTP id
 956f58d0204a3-653107f8e3bmr7151345d50.12.1776651586801; Sun, 19 Apr 2026
 19:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419122134.97529-1-lgs201920130244@gmail.com> <aeWHyhp43ZbgXwFe@lizhi-Precision-Tower-5810>
In-Reply-To: <aeWHyhp43ZbgXwFe@lizhi-Precision-Tower-5810>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 20 Apr 2026 10:19:35 +0800
X-Gm-Features: AQROBzCNElVyi3SqTu0MlhOiyhEx1DKejewgDVxgHgM7RX0rIbL7rJ3aJmlWlyE
Message-ID: <CANUHTR8FaXLX+Nbeb7+sWRF9jQ5SoBgWc2y_LVD38KE7TqsxeQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: imx8qxp-pxl2dpi: avoid of_node_put() on ERR_PTR()
To: Frank Li <Frank.li@nxp.com>
Cc: Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238679-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[nxp.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,pengutronix.de,bootlin.com,lists.freedesktop.org,lists.linux.dev,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3F1E4262E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Frank,

Thanks for the review.

On Mon, 20 Apr 2026 at 09:56, Frank Li <Frank.li@nxp.com> wrote:
>
>
> Please fix
> DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))
>
> If (!IS_ERR(_T))
>

You're right, fixing DEFINE_FREE(device_node, ...) is the proper way
to handle this:
if (_T && !IS_ERR(_T)) of_node_put(_T)

This is a better fix than handling it only in this driver.

I'll rework the patch based on your suggestion and send v2 later.

Thanks,
Guangshuo

