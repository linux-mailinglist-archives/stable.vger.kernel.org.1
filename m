Return-Path: <stable+bounces-210502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QII4KFYUcWkwdQAAu9opvQ
	(envelope-from <stable+bounces-210502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:00:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 496A55AEBE
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C146667761
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 12:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A831B421EE1;
	Tue, 20 Jan 2026 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgIGSvU8"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE803D7D7B
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768911232; cv=pass; b=Ns7aC3lR03C1+p7zEF//fuk180Pss7KjyALtWUMeCJ5MFowHEBY/nhMSQbJgyU0eaFZS7sytphIQOQs0v1dck492dRMzBjfbkw74oHNtCso+fYPx6wVZ/12aWGC/eqrm6sKNVTeB23N+EYBFMW/ta6VJ5fyumbZ5mppBHZPgIMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768911232; c=relaxed/simple;
	bh=beDlJQKb1YVfbNXGYsZ36u/MhHtIwvqdzNqeKG6RDqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3PhkRfJ5vDl62Qgttn8351d2qMudJdkF14amydBdy+eBko7rvOos3dYTszYKkG4WhY/+yzxxJ4gmVA+IVX0sPHepUufAYQ57h2+v2zOJuuQR0fKnhPq7pKvM08k5S5PtB6tROUDLmvBuTtUleQo297ag4FdMlef5Ud5ixp//tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgIGSvU8; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-404254ffe8aso3850049fac.0
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 04:13:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768911228; cv=none;
        d=google.com; s=arc-20240605;
        b=TrJQxvBwKYVChcR/M0hkXsrWNhumLtc3LWB91ofTsaghzd6cgSIfmmrWK2ZBmvqVq/
         vN3fVEo5aFZHZH9Vsh8d73U6+FBY+g31RWEmPTte2nVJwY1U6+uL3JXmiZkfQCe61iVO
         W7BssMFDeX276VQ5TRvNm5iZrauy/tS01xOvOlcpjJyQhZcqmd7UjXQ/LbFSU0xcV3ln
         +eod9vwpEm6VAg/UHSXyGWTQDDOdmxTHundRMCmiVfuYUtw7OFhng/PwSU/qUdX3yj6s
         xm/oIdhUaPhf950Z1eFGp8+BDzuOVPoCCLyxB1Oa70WQRK0jL2LjimfL0KW+HdiXnp+x
         WHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZaHS89UTJglYV82JPW0gI9vr2H6xZhU9IjhBzukkP1s=;
        fh=0MeDOlTnMShFPE+PmLl07+A97Zc17kRb/Alr+aN2kOc=;
        b=WESKkrHDxZHc/9nTfxJwGzk4FTnoqXoyw1M/4yrL8ngvi85qCZ6aVXeUTq6lmcIkYJ
         3hLfOWW7ipOsPnGSCADGEGrcTHDwVLh8uo9eQNopZvRxLz2gotw8bYDOyUzL4qijXA/j
         7V65isfBQsIWijlwPC3M/x2bqZbHi8K6vYWQhclceimd39f3dqw2U5XKhXzHC5r5sx0s
         L7jxusn50be2nN8pGiBIAVSIZGt/WdxW1TcHYtNMiMMDF7nc2SJgCJPwpNNHlR6mFk1S
         sOGbtWzOf9ODWz/ONmmVErF7MpWt849LuWUGqZJX7BH5b9FpDOQq7RNkIKZAWvIgDm2L
         /IRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768911228; x=1769516028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaHS89UTJglYV82JPW0gI9vr2H6xZhU9IjhBzukkP1s=;
        b=LgIGSvU8cGdH9bYLA2/5/qoM7Wf98NE0tOJ/OvFoztcVNprFmpfuMjznV5MsvT3YJh
         Cfl+N0zSVciCHZUBonzzXzHerJrvB11IVz+HOOLVt0pXLMDUXIfJWAqgiZn4Wy0OgCgO
         wOgMOZX4WrB1h9BdleSLIXjGNeUKyFeyQbI2bR+uK3n6NA9bmou4LQvSW0W/hAeDVQU+
         dU6R0HYO18CDKoRVQ1EKTmfqVaGrVhUM5x6sIBFe4xQ9a3y4fuQilzxRJt4PN8Ur3eCM
         G+Z6fDApst4luBSX8fbVucfEeADiVKBMKMhNmDGa0yjey3T7c6f3rmTsYJ0jfWyyM6BY
         aVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768911228; x=1769516028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZaHS89UTJglYV82JPW0gI9vr2H6xZhU9IjhBzukkP1s=;
        b=LGPmpGvsGzj3hl4LNnFbKgXg9a4EqR4SIZjGAqQJrlw0afwUjzRmuZuQRsvWpLuQRL
         /p0lExL7eTrq31fe4k8EIbTfdgGUdWI96uBv6RqhKkZiSKiFdq2LZU3L7+ONzom4bBbC
         n6lSQX6k32OxVeY9wVo0QZ9BlF7AXUoerppTzx/fyqq0EsU4xMszT48FySAJRfKmF01W
         4v1fMBteUk0WrNxLRCDRmsWiiQ71I/ZXOVY1CQ9SDUeI2PR0/n2yMRcInIGUiEypQWTM
         SVI0WhnxkVU5qqW8z5B5FvPHCnhYF7xQe0pRRHH8ay1W5E8K+orSPwR/WZyOjnLzxHoj
         yWTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwINWNt2vhoHmqoLo/ROofrECFEqwWD0kN4IJif8yKr/p+o79yAQ7Y/ZGGPRFedz0nI0xnjrs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf2psEmbPQ1JUO0LAnawTyvTaRSpaGIu0fYJhABklINIi686aF
	AiQXqXGIyebndFSortutcSnr0aW5vq/ru79zryanZuBST9ucqothHUyVJw0BjS8mWXmhawG5N/4
	uJERlYfpl6wm7X52d4Q2XSVLPkg4BeKI=
X-Gm-Gg: AZuq6aLrLRTKwnyWQ0y+SHLvaKJA6igjTTmNpFHg53VIWI9ifGxbVT0Qpm7oZ6JeGtR
	FarCYBpz19NVfS06hp4G4NTyXiKliIxWm78V4JLm50VeNZ6xBhQrxwTFLuErpL9aGNdF9Zt28l7
	6UdlfE8nDg2irOB1lGnbGA7QPB7ht+CsZOA8BQXaE7azsbyGScSQuD3IJ2JAyi4fsXIUz9+tMN1
	ypjoFlz8QtYCpulmYb9Sbvo77BUvzdbqT83+czuhDkvpOTkM8X+GaJnu7IUd4gHH6KwOeB4Xjee
	a4gHFahVOanuEZ9mbxqqafKG3x+M59YKqf3WAjXAg5ddoEYpFiwu7/NxRj3WjA==
X-Received: by 2002:a05:6870:709b:b0:3ec:4d4a:e6fd with SMTP id
 586e51a60fabf-4044b3da7f9mr7136951fac.0.1768911228575; Tue, 20 Jan 2026
 04:13:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120104129.105079-1-hanguidong02@gmail.com>
In-Reply-To: <20260120104129.105079-1-hanguidong02@gmail.com>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Tue, 20 Jan 2026 20:13:37 +0800
X-Gm-Features: AZwV_QgOsymFEVZni41KtMXKauDtQdvBtP2VYNSTYOczwLqIWpG15UwSTeOZLd8
Message-ID: <CALbr=LaRymJY54fGc-90rCZ9YEbx_oaU4uk9YSe9vSYs1ERCXw@mail.gmail.com>
Subject: Re: [PATCH] media: dvb_demux: fix potential TOCTOU race conditions
To: mchehab@kernel.org
Cc: hverkuil+cisco@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.96 / 15.00];
	DATE_IN_PAST(1.00)[29];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-210502-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hanguidong02@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 496A55AEBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 6:41=E2=80=AFPM Gui-Dong Han <hanguidong02@gmail.co=
m> wrote:
>
> The dvb_demux functions handle frontend connectivity without holding
> dvbdemux->mutex during checks, leading to TOCTOU race conditions. In
> dvbdmx_write(), a concurrent dvbdmx_disconnect_frontend() can set
> demux->frontend to NULL after the check, causing a potential NULL pointer
> dereference. In dvbdmx_connect_frontend(), a concurrent connection could
> set the frontend between the check and the lock. This allows the second
> caller to overwrite the existing frontend, leading to resource leaks.
> The dvb_demux module should use its own mutex to ensure thread safety
> for these internal state checks.
>
> Fix this by extending the lock scope. Move the frontend state checks
> inside the dvbdemux->mutex critical section to ensure the state remains
> stable during the operation.
>
> This possible bug was found by our experimental static analysis tool,
> which analyzes lock usage to detect TOCTOU issues.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> ---
>  drivers/media/dvb-core/dvb_demux.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/media/dvb-core/dvb_demux.c b/drivers/media/dvb-core/=
dvb_demux.c
> index 290fc7961647..e9e833285f0f 100644
> --- a/drivers/media/dvb-core/dvb_demux.c
> +++ b/drivers/media/dvb-core/dvb_demux.c
> @@ -1147,15 +1147,18 @@ static int dvbdmx_write(struct dmx_demux *demux, =
const char __user *buf, size_t
>         struct dvb_demux *dvbdemux =3D (struct dvb_demux *)demux;
>         void *p;
>
> -       if ((!demux->frontend) || (demux->frontend->source !=3D DMX_MEMOR=
Y_FE))
> +       if (mutex_lock_interruptible(&dvbdemux->mutex))
> +               return -ERESTARTSYS;
> +
> +       if ((!demux->frontend) || (demux->frontend->source !=3D DMX_MEMOR=
Y_FE)) {

I have fixed the redundant parentheses issue reported by the Media CI
robot. I missed this earlier because I ran checkpatch without the
--strict option locally.

v2 has been sent.

Thanks.

