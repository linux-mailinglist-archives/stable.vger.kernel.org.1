Return-Path: <stable+bounces-269362-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gt6YKwZwP2p+TQkAu9opvQ
	(envelope-from <stable+bounces-269362-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 08:39:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F272F6D1540
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 08:39:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cYUNIGts;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269362-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269362-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D6B1303264A
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 06:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169B5388E7A;
	Sat, 27 Jun 2026 06:38:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6AA355F53
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 06:38:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782542334; cv=none; b=LPrAELtaQWPpLt27/xWllmtjXmmQA59Xmvpx8mVURMsU3j6j6bUxNm0GzQfxLi6Zl1WwFKfDfjjETUE+aZjYsL4YgbgLFzDMWgr9rLyNynmBKBr2eNQgDF3gDHEUYMbpTyg3UOO10BGjmVB+sIsr8Uivq+snpOybFxQZIU7jSyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782542334; c=relaxed/simple;
	bh=ParnwBExfgSuCvGNbbNh3YhRq5Zw4wfCqZvmdKMow3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2s2cQDyewT3i6MpsFZCwGIrwa+u7T871yk1wlDJCru/gPV/i5xVrd193ISNJeJsRUNk8vbdrDH69fK5UGh0Uek3JDogv6fZ6ZIDHKslHuT+v6Z1sm1J0PgSUM9qhXRVsizB9Igsq4btaqElHhpLJdU+QU1aTLUtCjD0IsRVdcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYUNIGts; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49241dbf9c1so14534265e9.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 23:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782542332; x=1783147132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ParnwBExfgSuCvGNbbNh3YhRq5Zw4wfCqZvmdKMow3E=;
        b=cYUNIGtsu5USkdNL1kWDKED6UGY3amvoVIWndLefcSqLPshsB81MT0e0ZrsIDrz/dU
         KJ05e5/u9VhQpC2Qmoa3vNlt93sAFHTncf0HL3i7pDuYZra+1tPyJuxG5uleoyxaMGO6
         zEjC2gKZTzShWeNkdXpfzk0l3NpEJr4vPXkYmJK9ext0Te707EAzAuUFPXLblYvChTMb
         s1gWsDa56z9cxveMF3ue2cWC37z56xzQyqNQ/F8Epo6i2PsEqwos0/f80Ka9z2KN5fNE
         ZFsBJ4UaBZZMCQMo8kvcCVub0+MdwpuZMljji14J67jIA1LtRSDOQzdANCzvB/s/lw1b
         9X1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782542332; x=1783147132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ParnwBExfgSuCvGNbbNh3YhRq5Zw4wfCqZvmdKMow3E=;
        b=itn0TvkTjX3B4hQIY/YZqmlQVej+XteKgKCcFcUAPTrRuoVK39Ry/ARLUel3myXo04
         YBIvfOjGHh+ArAFGR9ABqeKF2G2MgwYOvnr18F6bINzBUjG6Fs0/ETBR4dWYwe6Qrtrj
         /rgfqNtjsuhTgU+b5jTScNcvf+sckzwO2KfHODTlkOqg1N7dFZdALl0LTUz+lQFHXT2B
         +0TwTaVEwwscOatCjFAKS7mm1rU8glNIspskTbaIHUp+3G5KpOhdW80djUziNtsd1+Vc
         ugskOAx1txd2EAc2Sn0395vgIqFcIALfZ/OJ49mYS8VLLEWkby+d6g+y6vf9RDvmFUi8
         CL9w==
X-Forwarded-Encrypted: i=1; AFNElJ+bssqmsVyGdNUk536i2WKgofsC5YajljuphzZkJRdeGFuwDJ47mLCLbtIFZSRhlPI4I7HeldE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/a2Y7AHiB4ed0EaEO0lwlIoCHuzq7P/g0VagQ3gU4FkL/uv3L
	xTYYudyjqe/dHfnIY27E7JHBHh1RZm0b3mlrGqWYA7cXzdCwPCpHT5bG
X-Gm-Gg: AfdE7cmC8lG5OOJVa1DZe5D/CYujGjFvtUtlnC7dthDHUJ4DobdYXeVm7mkGx5b6iB9
	PU/+ZWrwac3/awT+cycZXJFI4VtDuSSIli5knkwFi7yrtOlIAms3pqVkr83sVd4ugFm2JzclgrZ
	q3I+ZCh/cnagwnRgXfbaZn+smSYzu/wfJ22uGyueBP/ExoTXT49w7YPNY3lXFb8BL5OswGeo9/6
	w6x74Z9fBsI9nty5FQGR+NuNWUVdx8ecvuK2N9wWkqylXgwhE5p4f0G2PfaTGsGYZBvhA1QbkAB
	WFZ5x+KTV05y0Rw9Wyut3MR1OxkTbyDsVhDTPPRwImCv+TBbXhQ2YigbmeCDNTz2VIRQw8kxmwv
	AG2XmWGlqWyQx5GThSgddBsNikQmq4enkCTQ7X6wV9OZbCKdNrL4mt9IgqfqynghFIG43qpTfiv
	NjhbB3JQ5FrV3zVUkZi3AKSkqva4UtZGV19EpC1FF+kWsyeKIG5C9t3NBOK48IgsNc0Q==
X-Received: by 2002:a05:600d:8499:10b0:490:e196:6574 with SMTP id 5b1f17b1804b1-49266864b4cmr108469495e9.13.1782542331948;
        Fri, 26 Jun 2026 23:38:51 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4927038578bsm67964385e9.4.2026.06.26.23.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 23:38:50 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: mripard@kernel.org, Dawei Feng <dawei.feng@seu.edu.cn>
Cc: paulk@sys-base.io, mchehab@kernel.org, gregkh@linuxfoundation.org,
 wens@kernel.org, samuel@sholland.org, hverkuil@kernel.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, zilin@seu.edu.cn,
 Dawei Feng <dawei.feng@seu.edu.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] media: cedrus: fix memory leak in cedrus_init_ctrls()
Date: Sat, 27 Jun 2026 08:38:49 +0200
Message-ID: <3HodGaD_QKy_OLZfdyJ49A@gmail.com>
In-Reply-To: <20260624085920.578446-1-dawei.feng@seu.edu.cn>
References: <20260624085920.578446-1-dawei.feng@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269362-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mripard@kernel.org,m:dawei.feng@seu.edu.cn,m:paulk@sys-base.io,m:mchehab@kernel.org,m:gregkh@linuxfoundation.org,m:wens@kernel.org,m:samuel@sholland.org,m:hverkuil@kernel.org,m:linux-media@vger.kernel.org,m:linux-staging@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:zilin@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jernejskrabec@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jernejskrabec@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F272F6D1540

Dne sreda, 24. junij 2026 ob 10:59:20 Srednjeevropski poletni =C4=8Das je D=
awei Feng napisal(a):
> In cedrus_init_ctrls(), the V4L2 control handler is initialized before
> allocating memory for ctx->ctrls. If this allocation fails, the function
> returns -ENOMEM without freeing the previously allocated handler
> resources, leading to a memory leak.
>=20
> Fix this by calling v4l2_ctrl_handler_free() on the ctx->ctrls allocation
> failure path.
>=20
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still
> present in v7.1.1.
>=20
> An x86_64 allyesconfig build showed no new warnings. As we do not have an
> Allwinner SoC or board with a Cedrus VPU available to test with, no
> runtime testing was able to be performed.
>=20
> Fixes: 50e761516f2b ("media: platform: Add Cedrus VPU decoder driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



