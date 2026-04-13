Return-Path: <stable+bounces-235909-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEl5Ga2D3GnnSAkAu9opvQ
	(envelope-from <stable+bounces-235909-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 07:48:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B123E78F6
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 07:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 625DA3003985
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 05:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294E53358A7;
	Mon, 13 Apr 2026 05:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1kbALBW"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F315329365
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 05:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776059303; cv=pass; b=GSolOF7rpvSY0goFFK1PbvFdePxoQfuw12vBP51ySMZKe4rxsTtetNnGk2P1ZE86XzM/VLgWUeTw3AHfHQAcSPiNK40d8Gjt5CozqI8Tc+vGfpqy865q2sl/gKeLf1VWsM9HUK/iiV7HseRezvPyLYvl4v8hXnUDKipvb4hd+CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776059303; c=relaxed/simple;
	bh=igt2Es3IqJum7K3P9h4iERQJBtAxhpKyYYTdHjquAUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBI8IOPV8yZ8OLJI2VPp/B7HYGpXJZjeBsnKJeeiVkzhd96u8Y0SzNCIw+F8h43OK3s8hD/cPo/ZLUO0nigB4xMV1GqQmnFrfNuSkJxeDxadXdbYdW3/4rLj8EL3JGeID6vQ2wri+buR7fWWRMuoDHcxju79t1NIG1KRdzCMAPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1kbALBW; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-651ce2484d5so380104d50.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 22:48:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776059295; cv=none;
        d=google.com; s=arc-20240605;
        b=I91hn4bRaMMrIbWh1xg0DSHgKysXuN84+ywhAuTx2l2vN1XKaG8n8kI2FNyWPuUA4N
         GsgHKTQ03DD0BN1cLhfLCFNo2lhVA6lCZ5VzNcpoa6zU0JMnEJM6ldz1fLiG5HkSxbZx
         OKI3ljZaRCjosIUKQfPKp1usDBHZGxkfVy0YQe6eA8GlquX9tQTSELbMNx9wH1974HL6
         sBR64D+gmgUgKCDL1tLA1/r5Rl7C2Idvussqw037+Ii/ag1GdPxpnks0p/A8MnfgDCrF
         G+BILEfEO6X5y/7ZQNgxhXOvhF3fazUCGnjaV2AVpk7EB4jQH81gA7dSxJPjyA9B5/MU
         U7ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=igt2Es3IqJum7K3P9h4iERQJBtAxhpKyYYTdHjquAUA=;
        fh=K7T0s/lHWBq0ztdyEjtIpBFmRmz2+UA7mZnUuBo3SJ4=;
        b=Mc13rf6KjwnJctyihoREFlvBFwRubFkiHQWxUlZRN8g0pdywTFoaQ4ueK2kxACGI6x
         d/qFvVw9F2nm7ZjBvp7Aw/TT+r3DgD2KCMLlpxTPlLQTh5SDTjqQY7s5yrwmQ0r5mQjS
         kQedDkpPR/2W+CKpnq/CC+jblx6XJTEnfSrYVkamgbSHaaxTN5ANZohI7V8bnhnIALs7
         A2KDsmy1WkSlzKH/nWlMIlySJWTB7vdLveZXkahjEMwIGa2zVSHExtPsW2D3lrAsJMW1
         nQq0Y7yUJu1L2cWPosFiLwZ7QMnz1HPdPfCO/HAPXzgr8k8HT/OUDXwt27dB4Dgjc5pf
         ZzrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776059295; x=1776664095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igt2Es3IqJum7K3P9h4iERQJBtAxhpKyYYTdHjquAUA=;
        b=D1kbALBWISUXixtTGiAn1YtHLaD1vci/HrAEznoIqZRakKRz7y4Wtat9sCmbmCqPpv
         bxsr3Ug/HeANneENKvEzR/3cKGzc5zKoqje0MXlB/92k6MTt9zMF4dPe/WiW6/IejkMF
         1dMyvlZ75NfUMWIt3CcSS6saPCc8PdSyAhpZJtIZQWqyKoQAUTHOgQH5EBsVZMFqJYxW
         0uqLwSA45tYjf2BvBCn/tewW/fTqv7OzFoVaadhNkHRA73bGxMNNfUD0xUlIKXknaNzT
         nDsffdvNzXKptLcWtHPAfK9S+R/eaD6PqyUQd65r4VthuYKR5Ks+yX4ursgY479kjDKJ
         FOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776059295; x=1776664095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=igt2Es3IqJum7K3P9h4iERQJBtAxhpKyYYTdHjquAUA=;
        b=VegOz73L8WgfbEVQhGsRzT+XRL0gecrRLnYrSiAjCggJf7FxuIwwo9Olu3O3Itk/DD
         urO1gPHml9OEksvCm4Kq/tq7jkzCHIDLOQwPExSoSgoem8G8kf7mK/J5jqVEesKv0oYG
         ZHpLPY/DWhst0mOqsmX/XzCLOpoOkhseoLe6gSWKYfkpbcia7R7b/TtP99WwSxlYCCsH
         7EDjoI88gTeKD7d/NZXjjKxWxDfkOgVn6fK+ga4EdlI1BOX8ku1RQPK+GXABtR3G4sBX
         B+B7uOUo/JotIl3dmoOCTGtbNyRK1DyFnM4ClmjdYu8gl3ycuWGXyR1szs+e2+qmjR5N
         Pk5w==
X-Forwarded-Encrypted: i=1; AFNElJ/ddms6vMI0rCG5bN0JgtwDk1gyjBM3uyFs0/tBT/k8SuQ7TH8vUoYo0Vo/N/kqZK6ftLResDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRfvsGjwLZVDzrntPXsz0rkO7WKxtadumjKnzzY57H0kfQUgSN
	a3r8YuYutlvaIXmLYawmN0VwmZBZPZ0Tf1YHWw5M1A95dTlzIXoQykDieuhufmyWWKH5iFKiX57
	F+sSxvS+BBmJDO4tuG7qCeTxOzdK59K4=
X-Gm-Gg: AeBDietroqfHzF7P4lRmHoTNts2MX+t6R77c4t5FHANvrjgqll7vhu4UALUShboc+bl
	KRDaAN1T/qFhOvXi5SGFF0lx8TvsDnW9AXjHTl4FDJqIH/wQX0hjDrFv7eRBH/NhZfPm52RT94J
	Jl2FRfNXwLH5JToWkuRSvoD6bJD8BOqsjHgeuMpTZPFg0nM7ZHFKtZe0ZCvVpy1HUjI2aACJn/D
	AqVRmVnsohPC0IilXFfeQkopz7M2MbW0lQLSdaLkL16pe2X/wyhCmYRodd/BQMgJDc7d+CoPLG+
	/qHSs6xm7eLH64IdNQ==
X-Received: by 2002:a05:690e:e85:b0:651:c732:f13f with SMTP id
 956f58d0204a3-651c732f2d2mr2879385d50.27.1776059295016; Sun, 12 Apr 2026
 22:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412174529.2597250-1-lgs201920130244@gmail.com> <87qzojwi1m.wl-tiwai@suse.de>
In-Reply-To: <87qzojwi1m.wl-tiwai@suse.de>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 13 Apr 2026 13:48:05 +0800
X-Gm-Features: AQROBzBBMm9HXnAJg2gaO5NfrkSceM-v1coDuu3HdhTg1kiFqwZxvg2otGHIv_s
Message-ID: <CANUHTR_1s1aoE7SfYH7NNcaoM2VWcc6wAoN_Xh=7y6D__Pe8tA@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hwdep: fix NULL dereference on error path
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Curtis Malainey <cujomalainey@chromium.org>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-235909-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: F2B123E78F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Takashi,

Thanks for the correction.

I overlooked the NULL check in put_device(), so the reported NULL
dereference on this error path is not valid.

Sorry for the noise. Please disregard this patch.

Thanks,
Guangshuo

Takashi Iwai <tiwai@suse.de> =E4=BA=8E2026=E5=B9=B44=E6=9C=8813=E6=97=A5=E5=
=91=A8=E4=B8=80 13:22=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, 12 Apr 2026 19:45:29 +0200,
> Guangshuo Li wrote:
> >
> > snd_hwdep_new() allocates a hwdep instance first and then allocates
> > hwdep->dev via snd_device_alloc().
> >
> > When snd_device_alloc() fails, hwdep->dev remains NULL, because
> > snd_device_alloc() clears *dev_p before attempting to allocate the
> > device object. The error path then calls snd_hwdep_free(), which
> > unconditionally invokes put_device(hwdep->dev).
> >
> > This may lead to a NULL pointer dereference in put_device().
>
> put_device() has a NULL check by itself, so it's safe to pass NULL
> there.
>
>
> thanks,
>
> Takashi

