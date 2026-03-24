Return-Path: <stable+bounces-230161-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJcrL9+TwmkXfAQAu9opvQ
	(envelope-from <stable+bounces-230161-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:38:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C233098F4
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32EBD316A857
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 13:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E989372ED6;
	Tue, 24 Mar 2026 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MV0Q8U4U"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D723264EF
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774359125; cv=pass; b=ukcFeCI7VpzXRwwq+cGY5PdHpvC0GxHENyenjmMoraUuOY5rzJI/liuk7S08oEh/xoTTs7Q6EoRKLK5DMkUQtU/tBNMgJ6uzLuL9Opz6sMbs+xl7OZdV6TxSlZnXcGUlohXJpGTJKVaC8h9QyF44iicakowgpTldQlh60o8n3LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774359125; c=relaxed/simple;
	bh=LWeIZ6enY1JbVgBJgC9UO6sV5H5N7YoQorzdHRagQO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6d6jjIIhhWfWRi8ycuMjU6bTqCBYg+Yqh66X9zMgS6/BbQ/nfbgG7Yb7USjWgo8R9r4bYsAfruiBG0kyjBBXHbb8rPmCnbiDxZRTcD2xRleDAVQyPoOe/bEhMVhenHbkeo7gfB+InCc+IqP1e9CGHa5QODP5Rg7YmXYqsiT/cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MV0Q8U4U; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12a70b4de9bso247352c88.3
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 06:32:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774359123; cv=none;
        d=google.com; s=arc-20240605;
        b=gP+1vauTBhqcraoDEU2uZRpWW6m/5ugv3canLpF9agBf6zroUqE5wZoezOKmTpUXnJ
         ol59WfYL7lMXBKXCxzI0XCHt+ryHyZpa0aFNvTdzSPNc1BPem5TmvoMPk9ZA47fKEJhs
         tVxApCqYY8PXtrsfNg6tnjnTeK4tnWDFsYD+vE5hJJVUoeZLeo31Mjt9kt2d44MtUSdF
         +N0iCxqF27tsp7TJ7v7c66FmZ/nCdJ/OIbMH/O2NKJFQedftTTP78i+dNUDVJOOjbpuu
         xQqHkfmRNArTTVHYkxhCGXstmy5LrOz0V2IHA/fC81QNTbOhLDF/Vu3FJ7jIekPimgTu
         pLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j5883fLgA4Kxp5uDjU6jNZrlbfEleppgZMvpZ9qx8xQ=;
        fh=AWYoNYFPpZ1revFnYq0Qg9XN2ruOjZEacxgrUa1dJWQ=;
        b=GI+OLfEg5j+dICQeLXjusAvHatJtwKas13mc1riDoq0xsCJzXnhN1c2/WY1JnEEAsI
         vTTP8v0hXsw5sOfUejUEVBqzRYIzWKykknKcu2rCQDGd8S6C9oqT9t3nkJZOP90jMTCm
         MfMGVkzH7qBhQ8CvalXLk9wKOOhSm8tIUCFgIMOIrWD3j0kgrD4cpzM6AyLM33H9H9hY
         7NO0bXRXOz5qCmp7rlsgvlByv0MR4j0rKrvAxfSiiPD48tgcMyPNQSR6DZ6wGd3fSeLp
         QzJOkqldHLk8V7Tvl/EIx9VQ3j8NsjeISYsRmLoMnmHKwOq3ZMF5bokp0ZIjZyFKnWZ9
         yjwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774359123; x=1774963923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5883fLgA4Kxp5uDjU6jNZrlbfEleppgZMvpZ9qx8xQ=;
        b=MV0Q8U4UdR8LJR7aDHK2nIdwga1jrEJK4wyDVJd6G0QJrd+cmPMKQs/cZBCqcgfAGD
         UNNvyJqE9oPOaCi/airXZKhW4yDJf5hemRtLUXEY1EeD405miPmFRqBq58CsbT30bA4d
         W2fBBJxMAEyt6mZBCKSUPlu+gmxYacEisoKVBs/QyNfETERCrmmx+I1GyFJeuIYTW7/e
         pSgeAMoi4bDv569zjFc4KoAq2+JvjzYEb05niJ8Tq1A19iKhvB2apVRcQkCxpab9L2kX
         YVXaGT010xtiXSN5eSukUTygkrn9mmJUNVKw94xXsZaQUpGHPh78hTSOYNM6LgC8ZYaB
         yZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774359123; x=1774963923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j5883fLgA4Kxp5uDjU6jNZrlbfEleppgZMvpZ9qx8xQ=;
        b=tDrFKNnjbLjclgC//GeeJcvVU0vDT1pGjJObPPC3zQGI6fHqHZ3956tqcEZIxIWHdc
         chami7svIa27z1DJJw3YwPmJ2dmWkKyi7q3OYHzTDZB/MsJf7jkiV42z8StXZ9zT6PDl
         1ruvjjLCCQVSlfsHRQfhlHdBTmMYcOwERQOGgnpJMcU29T14ZCl6/d24o1k/3YXoQknJ
         oaY7Y+5kczD2KyO8rQCugQIMQkKeMGOMUDUIXZ4q+2vmg7sFXr4P+8FqEHFY1Z57YHi1
         /xy9HssCFzUxU9VkGIFCEv3i0YmhpjWEnd5XGPFMBR1u+5FOd2CpY6YuPz8uvlcOyd2b
         q8BA==
X-Forwarded-Encrypted: i=1; AJvYcCWQpvYK9FvDDtHhXFB4WVimCpScQXb568CHXmINdS0l/GdTwyN6FC8VKRExtSL3g0OnPuxQgr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxze1HjY8vfMgNi6GL0kF5O7MtTVc8wq1QRYQFXJ8TwzMu4AiRP
	rxWGJ/vTv1jZJ2YsX5bdeTzM9V7MuV3JGZFZ+apwXHonyYFYz4Qpls4qcm1HeUNMlCmizGZ+06W
	BL9eqS6GRfsGZpNPsdt5VkTZpi5lz1iE=
X-Gm-Gg: ATEYQzzcaZ0PBzQU9E8T+7UwMb1UEtMeKt104FggriyXkz3TtyuEsmSkYDgcTaRlhtw
	W3vsQXxzAzMB6Jex9AD4tGhtpiK5KPgDrvpuc/zwLBFbWE89CAkNtE7XIorrJ6SyYSPDfrUSKyB
	2tV04rIS3vt8zEv6md7CbIBM+WEOv2R4qUo3Luq5XTjZy79ffXSZObw49ZzprBuTzwnrayc+4eE
	n8iXVXE82qX5cYL6CBZJJPLEVQj+UUEYPyHKJy1Npku52EADmiX3aacLfnJYx/abCNK4h8AwAke
	GlGS1pi+jXDDb4ixwpS08qGNidNHns47HUdTi0by9KxzPzLMaKQMrfIRp/+dQITT01x7Ow==
X-Received: by 2002:a05:7022:60c:b0:127:def:dd72 with SMTP id
 a92af1059eb24-12a72646221mr3600922c88.2.1774359123172; Tue, 24 Mar 2026
 06:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SYBPR01MB78816FAF00EC3DADFA588E0CAF48A@SYBPR01MB7881.ausprd01.prod.outlook.com>
In-Reply-To: <SYBPR01MB78816FAF00EC3DADFA588E0CAF48A@SYBPR01MB7881.ausprd01.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2026 09:31:51 -0400
X-Gm-Features: AaiRm5082bmB1vEFeF97G50_iqqBjFx7HoPxAOrnxaX1HwxWGKygBeGTgapRc_0
Message-ID: <CADnq5_N83j3ZjNKXH2K8jEod0s64JB_pdugGsx4AURoPjpveSA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: validate doorbell_offset in user queue creation
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230161-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexdeucher@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 29C233098F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Applied.  Thanks!

On Tue, Mar 24, 2026 at 5:49=E2=80=AFAM Junrui Luo <moonafterrain@outlook.c=
om> wrote:
>
> amdgpu_userq_get_doorbell_index() passes the user-provided
> doorbell_offset to amdgpu_doorbell_index_on_bar() without bounds
> checking. An arbitrarily large doorbell_offset can cause the
> calculated doorbell index to fall outside the allocated doorbell BO,
> potentially corrupting kernel doorbell space.
>
> Validate that doorbell_offset falls within the doorbell BO before
> computing the BAR index, using u64 arithmetic to prevent overflow.
>
> Fixes: f09c1e6077ab ("drm/amdgpu: generate doorbell index for userqueue")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 7c450350847d..0a1b93259887 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -600,6 +600,13 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_=
mgr *uq_mgr,
>                 goto unpin_bo;
>         }
>
> +       /* Validate doorbell_offset is within the doorbell BO */
> +       if ((u64)db_info->doorbell_offset * db_size + db_size >
> +           amdgpu_bo_size(db_obj->obj)) {
> +               r =3D -EINVAL;
> +               goto unpin_bo;
> +       }
> +
>         index =3D amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
>                                              db_info->doorbell_offset, db=
_size);
>         drm_dbg_driver(adev_to_drm(uq_mgr->adev),
>
> ---
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> change-id: 20260324-fixes-9ee6cab7bc47
>
> Best regards,
> --
> Junrui Luo <moonafterrain@outlook.com>
>

