Return-Path: <stable+bounces-238714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGPGHhzY5WnWoQEAu9opvQ
	(envelope-from <stable+bounces-238714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 09:39:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2B1427CFC
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 09:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 775FF3015A64
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 07:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAF1383C95;
	Mon, 20 Apr 2026 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L4vrZps9"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00F821A92F
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670745; cv=pass; b=rl8eIG1nyjfZZHO/1e0lpKsmTeBQzEfiF87ENdgsVQ6pEqgGOWvP55dGHuMIj1/qKpcUBvmUiRpo9c9elKMcqYwEtwlEwjDLWrMq9HNRArIrHLP+45RvblM1vF2GYQOLT5uvfT8mzV7lvFEXpoQvEMlmOSZjzDcl6lZtMfwtT4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670745; c=relaxed/simple;
	bh=Y6SaI5/j4+Ufg5rzhBx6PvjnNi5tIO6L4mbRl8+/keE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNg6gD/mWwQJbrGwfkCNWsBNYOaX1bAY6D2QKRKAKZ2zyR5zN46jYLK1+oKcqeTeWpxxVg8fxEcPiQZnyewnjbMo6YTVaac2bfXXdQRHFSBoXn3GY/m5Zq74KfHNxVg8rfuph1Vw6BUQg3eXTecXx/dIHgjUbl38bITX2fZ9COg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L4vrZps9; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38e7b0903cdso24816231fa.3
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 00:39:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776670742; cv=none;
        d=google.com; s=arc-20240605;
        b=AE92Ss8mnd/Og7O6G5FRXkS5qi/Sm5GwYpJhD+9cIg8xyk4EGz2dx+4r0cpaUZg3f5
         iJkCcPRlWhMy9NC0e09Mn7Q96kcPgWytpu0P/7ZageL9bKOD5xD3xwcSttRAUO72sejk
         JA1KqwXub9LtrC2Vcq/VkEV9mNSi41J+Kt/K1YLBNvUYHZr+p/a+DRztlnFD902un5IH
         LgKLT0i81GbiB7TgoduUhIfaDwW5kCfrkf5NChlPy9rP7m4wCbC/RUodfoI14nzm8amF
         +NDdqyP1gZo4aZvz0TGmmxsvSzPue3nQDUk+KnZ9tC+3fMIixCdfqog8Xm/ndrcanXJY
         t14A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zKEgJOPy9NW9AOWN8wHVDlaVtMzqG521cwuziW4vs0A=;
        fh=YllXARdiMQsH8Nyy3aLpOP3SXdvfRTL+23KH2qihcdQ=;
        b=io6me/AAbczEYck7PnxWPtOz+Ce8j7t7RHqKkaX6yVIAOAot4Vg2sWfrQZRsjHt0y/
         3yhBd0jTo4gjvCOBvew22dPC1IwZ6d2kjk4YNf1BBGwWYQRvxwInakB29xhMYqdBbGTX
         jwvuGitlu6eSgOBbUhyYVqbmyElnI6keMbjxRcPbBBFrfGAYHfyCW+vs2VpG41upO9EP
         jxwUr8Rk1AzE+EAExiHAmeIggnrCfWqBM19NkAgTMFI7fStMyvFzo0tQdBP3vWIxMA7d
         zRYjYs/Kdv0ewvMpOZLSnHbxjvmchIFkNWmos017hBVtwCmxEzBvgDt0BldnsZGM7eTx
         HsyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776670742; x=1777275542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKEgJOPy9NW9AOWN8wHVDlaVtMzqG521cwuziW4vs0A=;
        b=L4vrZps9l9ipyeIGq8JLCpA/uPakwLFCf5V3dCuserf09J1uJfv49SXaI5QoR7HHeY
         QFULWznQGqWva/m+w8cXvBzzgherdh3zmoTQGucWpVhkgWVQtZkRf57h/Zw+gN3AObUv
         DnjWm3zKAtDwBjD9n3PcItJfFIEjnFfHWCHh6ooMnJ2MRfkOxi03xzQ1Pw60nOIsra3B
         ZHZehfpXUaQnLU+R35qltrYZAxmAy4Hm8dwRZQKnMoQ0LdK08fy14LC8/tjqu1rSOLPN
         o1jf9K2q9afkY68yx/Qj36M+JmcqFboqNTNsvo0e4F2Zci/NswCVpSoibmNMk6BeJVPn
         uXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776670742; x=1777275542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zKEgJOPy9NW9AOWN8wHVDlaVtMzqG521cwuziW4vs0A=;
        b=JAbwpKdEOaQQUsUz8HdEdntNS7415IuzMVu7AXuIWH1lnU7xnxL323+egpIjZSotLy
         tcplUHsoQckx2D1WorICuzQL7eaDgKzjbh0u1njukV2z7SGSuiVmoN8siBAucW4nRBps
         olvUAmvUOsG/f6HefH4fnNdRlkuxr+pAxO4b9IOXZfNriUAVA0XQWTBHFjpZkz8dQJjx
         3Yty109cYVF+L57+kxntY8BQek/VBar4P3ITIYfcb+TWXRjDXsQ3ln/2c1wqvz+b/oXP
         UVeEr9fGhYrJN7ES4RJcgtTmpwByFieA+EE74YuSbwJV/nf4hH44tfq2DhAJXWAqQBN1
         ItTg==
X-Forwarded-Encrypted: i=1; AFNElJ+hq3dBGMif/sw8Q//6h4HYq2TPaXcKflpHx0vkpSGKSLuni8LKO+DJ6z9/FK1A1WMz+bBtdhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDmniyG8RMRLbiNKYsS4tZjY12ANmc8JsQdF+ThNqErecG7MiS
	BaqGbi40Ws23IaLnSVNOe4zLPC6Be9ItLZcfPkO1LirsroCacsxNsfU0FMNHtbDvRBVBmRreOLa
	l4ghR95LoVORd9biYNBpu1+DddRIpf9/znLlXbOMs
X-Gm-Gg: AeBDiet0S4/eRR3xiRYC7R9RYahw1w/uhDqeAo+dFWWza41p3+k8E+3CS/8d/WBAB/N
	HeBGih5gjeudqgnLSkb5uOCD5HSCvd3W/MHPlGF1NvDqJRc2JC5nPi5VUTiXluQMHo4bE+NhVl+
	W61GI5uiWZoD/sDUscOSFcTcmke3RUDNgxIcP5ZG+Rud86vHjpOulfMEnTs9jkOVAU7ItAunWGS
	UatHPbaYURR/uBaLUOLBlzoybayqwY/U2aXEZ6U9IMbK0fSS2oa94uVGsNVCkmOkgTYxCKlJmnn
	yBA3Uuu93H/nuFn7BREJXSKDj98n0zEIakQNcld/yWtMUu+iixIpfLpz5WxkqFb0hP2Phw==
X-Received: by 2002:a2e:ae08:0:b0:389:fbe6:3321 with SMTP id
 38308e7fff4ca-38ec7b99984mr29889291fa.33.1776670741419; Mon, 20 Apr 2026
 00:39:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323-uvc-hwtimestamp-v1-0-aa42e3865204@chromium.org>
In-Reply-To: <20260323-uvc-hwtimestamp-v1-0-aa42e3865204@chromium.org>
From: Yunke Cao <yunkec@google.com>
Date: Mon, 20 Apr 2026 15:38:49 +0800
X-Gm-Features: AQROBzAlapTXffBH_3Vrs0aqJdVPiVmm2hr8avyAcZulKyL5RhYlAQonTJX8rRE
Message-ID: <CANqU6FckNvLSDj9S9Oc_NGmP80YCe5P46f5oQ9mahWvxqikxNw@mail.gmail.com>
Subject: Re: [PATCH 0/4] media: uvcvideo: Fixes for hw timestamping
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Tomasz Figa <tfiga@chromium.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238714-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yunkec@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chromium.org:email]
X-Rspamd-Queue-Id: EE2B1427CFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ricardo,

I tested the series on a SunplusIT Inc 1080p FHD Camera (2b7e:c877).
Without this series, hardware timestamping was broken (due to the
issue fixed by [PATCH 2/4] of this series).
With this series, hardware timestamping works as intended.

Tested-by: Yunke Cao <yunkec@google.com>

Best,
Yunke


On Mon, Mar 23, 2026 at 9:10=E2=80=AFPM Ricardo Ribalda <ribalda@chromium.o=
rg> wrote:
>
> This series introduces fixes for the hardware timestamp calculations.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> Ricardo Ribalda (4):
>       media: uvcvideo: Fix dev_sof filtering in hw timestamp
>       media: uvcvideo: Use hw timestaming if the clock buffer is full
>       media: uvcvideo: Relax the constrains for interpolating the hw cloc=
k
>       media: uvcvideo: Do not add clock samples with small sof delta
>
>  drivers/media/usb/uvc/uvc_video.c | 51 +++++++++++++++++++++++++++------=
------
>  1 file changed, 35 insertions(+), 16 deletions(-)
> ---
> base-commit: a7da7fb57f2a787412da1a62292a17fa00fbfbdf
> change-id: 20260309-uvc-hwtimestamp-f25dc27f5711
>
> Best regards,
> --
> Ricardo Ribalda <ribalda@chromium.org>
>

