Return-Path: <stable+bounces-241423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKYdMhir72kCDwEAu9opvQ
	(envelope-from <stable+bounces-241423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 20:29:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC5247897D
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 20:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A71B3059E28
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F83E3E92B9;
	Mon, 27 Apr 2026 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kWlhYQiV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749BB3E6DD8
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777314272; cv=none; b=oPlfDPrP72wCfScprDh0vbEovFMK1ZsxxsIA8dzPJ7ckMzAP6LGhv+/KJsR37j74ncX9xsyUZ68Y1XU6/uKpKqXFhEo8imaaWkNaN1SAIgenG/odSUuOqaMXkmsbx+1Vt2QQ73Hn3suyVcepWEZnwVjktbEVkKUI6RwqmTvUHUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777314272; c=relaxed/simple;
	bh=xvuj3YSEPZyGvcr1TEAUS7dVv2gZaigkbV2JoEaXzA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnXCZY0VuHx1OGTpJ0h4dxhQdJ2KCHBKPb30vt1l5IIa07W4kONDQPyZBMFj6yYlP2pgi7Qr3358osM6unITSjA67yglf3Zx716YGvXRKjaU0p0X4ayTXCPyuKBZM8E5rSDRbhZw+9Nh7+nz4vZVlnRnaGIF1eU0YILbc9wQvgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kWlhYQiV; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ba67b332bbaso1237964266b.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 11:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777314266; x=1777919066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvuj3YSEPZyGvcr1TEAUS7dVv2gZaigkbV2JoEaXzA0=;
        b=kWlhYQiVKIoPEutafH/GCDe7zTIjtItUNEEpTuquyuFHAalfArcXAjDoULLQFAOTar
         ZuG2tvfDgDQtpXFfmGFO18YoiCEia90cXcOiwKXp444qY3+NRDhXPO7JFJXsASkRfb4d
         45FmsGIomeLcTXfugLVrU8MJNTZulZSVthHP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777314266; x=1777919066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xvuj3YSEPZyGvcr1TEAUS7dVv2gZaigkbV2JoEaXzA0=;
        b=Lfxa4iiGqSM33AR56OTwgQU92uzLFfOTHTkfv7er1bN5uz9tV48ksEhAycViXkq5bM
         QID0Qj9bghH/xC4aqHrzR9NuUebDKZDkxK3tAM6kB12RAHaNu6vfv/JakoY/DHuKCtyw
         8/jcsIcifO6NeAaCpGKzeY8jb5j/1FVfqG5BJyy1q9ONI0vz9rwznwjuK4/Q99D/QWIn
         a2Z0EuCKN6CqnN6hIWmVUrNfqDWeNUKPqKtMIMDWLsGDTQ7/uNhyXKBnsGA6B8pOTPbM
         K6HUn3OW5NdN7Dp44zWJfyy8sxMABLYYjDPpEQmuI9Ydvx4gOTTKS3SSTn5AvmadcqCU
         InBQ==
X-Forwarded-Encrypted: i=1; AFNElJ9hhKk2eVGYodwzxWHdpCp0XLVN4B8nPW6YAdHso/axQ9tF2ZKkEIJWltzqeiMcOTqIom3aKhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlcR4YT++CQZ7X3+ZLtOrCcGHaafzrNxFy9WxQq6c2lpj0t2td
	6ClECOPGhOtX3z/Z8F4ngSWv3Dx1Ydk+KAKptCG0cbEqaEImCjyEzLRdwvXNNQVk7bK7/0zUMKy
	DXdFCj8yk
X-Gm-Gg: AeBDieuZV3SmcMXfJ/ewuugn+Gt8eHZxG7tST6BFUW7pSViWA8YFr2jAeYXmkM7i/w4
	FCTStslT0YwwQGs3aARh4PDBLPmG2+8G4Pfe2/DL64PhFBkytUIRmhYPneLshMePT4NRSFIF9Ei
	Xnbo8gO9RIBiGPDN2KZWDjWxnENuhP9M/lDSJlA7zFStSwMZ5D7pZo8KEfREmx1MEl5Z1N/j9EC
	mlWUW4D2LExpThhkCBvOwPAag/1UuBK1hd6R/YmzjujtQDqAfTl5693zGubQIkRSKhaF9eC0WAE
	pwqxL9pbEbmfmx680n0YLIVZLeM3zDk4m16YAP5mYabF/I7bypkpuRgv8lwisjhAHBWxzMAjgRt
	75nDSmWIGE/yiwzjqd2cyOKq/c+knrl7bGgj9MJjio1NyYE4SsKtLBw62PARdo/fG/7RngHsAur
	IAZRppgjZ8uVI7ojYkkTu+uyqLmzL8UUZu0xtbyxvGPxrJlOYe2OgEOoN9lLyMLgymqEeNXJI2
X-Received: by 2002:a17:907:a685:b0:b9d:4301:be37 with SMTP id a640c23a62f3a-bb7fa0a9d50mr3707666b.5.1777314266131;
        Mon, 27 Apr 2026 11:24:26 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45504441bsm1138857066b.45.2026.04.27.11.24.24
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 11:24:24 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso147081585e9.3
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 11:24:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+/t793LCEEXplYDqgVd1o0g6ThNlAhWqwMOMgrIYSutz9ypFt3kPDbiAohfWpb+FBRFKcOqMs=@vger.kernel.org
X-Received: by 2002:a05:600c:1e8b:b0:488:8c89:cfaa with SMTP id
 5b1f17b1804b1-48a76f45b2bmr6693935e9.3.1777314264104; Mon, 27 Apr 2026
 11:24:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
In-Reply-To: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 27 Apr 2026 11:24:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VXD34ZZTH4MJUtZ6xifbbjp1cLRBd_xvz=3T12G4tKYw@mail.gmail.com>
X-Gm-Features: AVHnY4JXQvB4BQntOl3N3TJZoYXk7_aI9YhJcn_qUMOasoRsv3c94qqHiyJrmwQ
Message-ID: <CAD=FV=VXD34ZZTH4MJUtZ6xifbbjp1cLRBd_xvz=3T12G4tKYw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: himax-hx83102: restore MODE_LPM after sending
 disable cmds
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6AC5247897D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241423-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,linux.intel.com,kernel.org,suse.de,huaqin.corp-partner.google.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,iscas.ac.cn:email,chromium.org:dkim]

Hi,

On Sat, Apr 25, 2026 at 9:58=E2=80=AFAM Icenowy Zheng <zhengxingda@iscas.ac=
.cn> wrote:
>
> When preparing the panel, it seems that it always expects commands to be
> transferred in LP mode. However, the disable function removes the
> MIPI_DSI_MODE_LPM flag, and no other function re-adds it.
>
> As the unprepare function contains no DSI commands, re-adding the flag
> just after disabling the panel should be safe. Add the code re-adding
> the flag after the two commands for disabling the panel are sent.
>
> This fixes screen unblanking (after blanking once) on
> mt8188-geralt-ciri-sku1 device.
>
> Cc: stable@vger.kernel.org # 6.11+
> Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out as separate dri=
ver")

This "Fixes" looks wrong. The bug was still there even before the
driver was broken out. ...and it looks like the driver that this was
broken out of (panel-boe-tv101wum-nl6.c) still has the same bug?

-Doug

