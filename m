Return-Path: <stable+bounces-7897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B20818525
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 11:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2266C1C23A12
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 10:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C47E14281;
	Tue, 19 Dec 2023 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VGV+tTUz"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A090A14A81
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1ef36a04931so2827119fac.2
        for <stable@vger.kernel.org>; Tue, 19 Dec 2023 02:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702980890; x=1703585690; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8yrPXmCzj3IK29PcmUElaCFsOsyUAhOpZihuRJ+N2u8=;
        b=VGV+tTUzNsxh3bz9O7XguXN8AmkviwErLfNTeN0xm85aC5qGqD/taQYSSFcD+7heFJ
         zoL7k7cG7iWRMUtIucJnVRju321XzsKY3ipREO1trRqZf/Kws8Rq9VA3GCqO9j8JKyca
         ekb5ymkvLJcydSVVoqxxTp2r7DDm6uWKVXrtiX45m8jJovUCH6bZcq8wS3ka/iM11jff
         FeMsrD7Ia/g3Yqjv6LTbNWUq2RiotQ0V0e5NYIcvUsFl+tSKwp78Pd0oGXpbXw9g3vtw
         aM8vGYulnd1+f5mOijwUmBQ6Un810QoOYTgNvfXcjV5PW6+hxbbo9cH/6XQKTxhDDZsD
         kgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702980890; x=1703585690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yrPXmCzj3IK29PcmUElaCFsOsyUAhOpZihuRJ+N2u8=;
        b=i12n/c1Fb+AQ010C9biLyN5A7kqvfMNDLISY4VNJ7mF8CxNaEbrPMYDb1bV1TnJooW
         TBBjI4Ov6Q3Ek/4Z3Hnt0sANFczPRbSCfbTtquDbMKLtUxTb/QUIs5gsgOQMeYuPoHp6
         4D+BI7BMuQWRi67kCHfRNHFXi64xrHky4cZvHOjKpWx+cWC3cxupe78hD+tlaUg8n7cs
         6dD0VbfwP4s9Lz6dC5qgt/nHG3WXWrunoqHmPQfmo/bh5kYYTm9+e22LlZ0/a/gqfq5n
         5ys8GOwYgfsVG55w9eDTXKPu0PoE0k1FwK0Pjll5z89YbzxXRnnJLWyYwEMWqPDbulV5
         282g==
X-Gm-Message-State: AOJu0YxVfSWUiZUany070/0FT1bTsYo0yhrhiWYDrmX1BbcAYaxFrS3b
	c9c/PmCwv03BF1XqxprUXcFjtVKS6v2AzNVKTpbIPA==
X-Google-Smtp-Source: AGHT+IF227arYzhltAYmPaxaoo7UcGrw4GIP/dK50ngrQPEImbc/thS+6U06OrNZpvsWM230OFryhrfTPCW6wYSklfA=
X-Received: by 2002:a05:6870:7e0b:b0:203:b60d:8536 with SMTP id
 wx11-20020a0568707e0b00b00203b60d8536mr2784582oab.88.1702980890680; Tue, 19
 Dec 2023 02:14:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219101118.965996-1-amit.pundir@linaro.org>
In-Reply-To: <20231219101118.965996-1-amit.pundir@linaro.org>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Tue, 19 Dec 2023 15:44:14 +0530
Message-ID: <CAMi1Hd3-kYAfSOS7SBR2=ZLZ0sbvDWgyPm=t0KALzGpdomQGSw@mail.gmail.com>
Subject: Re: [PATCH for-5.15.y 0/3] Revert lt9611uxc fixes which broke
To: Greg KH <gregkh@linuxfoundation.org>, Stable <stable@vger.kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: Maxime Ripard <maxime@cerno.tech>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Apologies for the half-baked subject line. I don't know what went
wrong there. I meant "Revert lt9611uxc fixes which broke display on
RB5".

Regards,
Amit Pundir

On Tue, 19 Dec 2023 at 15:41, Amit Pundir <amit.pundir@linaro.org> wrote:
>
> Recent lt9611uxc fixes in v5.15.139 broke display on RB5
> devboard with following errors:
>
>   lt9611uxc 5-002b: LT9611 revision: 0x17.04.93
>   lt9611uxc 5-002b: LT9611 version: 0x43
>   lt9611uxc 5-002b: failed to find dsi host
>   msm ae00000.mdss: bound ae01000.mdp (ops dpu_ops [msm])
>   msm_dsi_manager_register: failed to register mipi dsi host for DSI 0: -517
>
> Reverting these fixes get the display working again.
>
> Amit Pundir (3):
>   Revert "drm/bridge: lt9611uxc: fix the race in the error path"
>   Revert "drm/bridge: lt9611uxc: Register and attach our DSI device at
>     probe"
>   Revert "drm/bridge: lt9611uxc: Switch to devm MIPI-DSI helpers"
>
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 75 +++++++++++++---------
>  1 file changed, 44 insertions(+), 31 deletions(-)
>
> --
> 2.25.1
>

