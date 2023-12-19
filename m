Return-Path: <stable+bounces-7883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8818183DE
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 09:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559EF1C21663
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 08:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFEB11C96;
	Tue, 19 Dec 2023 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PM7xUU50"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6EC14017
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-466a2e4fd18so301806137.3
        for <stable@vger.kernel.org>; Tue, 19 Dec 2023 00:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702975841; x=1703580641; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ma2EOna3hcuYWIIJvo0TWV0UQ4um3lMO53Jk29bdo+k=;
        b=PM7xUU50kqSklQ+9GdOA1GjRi0jrIqNw52wGv6zTIArqVXdhRcY2N5tWGM79QYIzlf
         xpj32fv4fsdvGWbP21Z12L5jtP2FHgv9KPMZiZvo2MY+OoeZUnEEJgbwpgEAih/hjCUA
         NhAyldTgP9qGyASlMRvpV4WcDXQPm/3YnRLlh+4EDfnI8JHP3P6tW+g9E0pcff1oA9kz
         1F+XRbLJzwfk84w9CCIiZB7EU3kdRGK/eYsFLolr4muS2DDHq5De9CAaUaRXKk3Y39zQ
         QBLFbfLMa/ISBDNibl5eF1B8L+JDb8sha7ynvnrIWAFjo1tgOgE2Tx0rfUzWQaPDuntQ
         owCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702975841; x=1703580641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ma2EOna3hcuYWIIJvo0TWV0UQ4um3lMO53Jk29bdo+k=;
        b=rk73uuYSQd3718weupR//ecHqOd96cmE7spcxYpL39X7t4yWCnhEEVf8ocx4bjuG4h
         rBPgLXSBkd6V36i4QeohqEb6p28PZaT8kApJ8XwniFIzltscemFpbbk+VduMgt8aPcQz
         OEhdFlcip0CgeEppUmFPnarIGB/l6xaOZnvFkYHgPkIoaI/0gzeMwMVvM/ng5MqbW3WY
         3N6uEDE26UO3xEnZNhDZbx9eeiHYtIeuH8D/rZ58q4qVVFt6VVIJ3qiiTHIKbm7tzSlW
         IeQ59lFkhoYNld5XW5PPWmPKGAtMPcH5fMX8A8vnf3M8naNYatrD+MlL0vaISNG27YIc
         IuTg==
X-Gm-Message-State: AOJu0YytYkTsDaPh0bbEcgYng8Xuz0qDMdwBqrc7REgJYhIzmyMgeMo4
	CspoSluVw8QfBfKzeHs0kViTZsLefSDUNAxAevtfL0TWdsB9lDtc
X-Google-Smtp-Source: AGHT+IGkRUHeQtaLCNwM0LGcPF2U/wrzLd63UBP51lRyYpgyk7d0GNIRFxEmn+tEK9IXzOIahTdmaBuhLfcDRzHXFME=
X-Received: by 2002:a05:6102:3586:b0:464:7e51:6f57 with SMTP id
 h6-20020a056102358600b004647e516f57mr14504034vsu.2.1702975841668; Tue, 19 Dec
 2023 00:50:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMi1Hd2jWZpZn8O1eP5qCZ2HfLbvBAEJsM5FwZxp-rC3q-V7KQ@mail.gmail.com>
 <2023121931-spool-outlying-4ef9@gregkh>
In-Reply-To: <2023121931-spool-outlying-4ef9@gregkh>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Tue, 19 Dec 2023 14:20:05 +0530
Message-ID: <CAMi1Hd1nkbiMjiMFAH4WOUD3nVEYbkmO_+b3PgO7-fkiZTQaaw@mail.gmail.com>
Subject: Re: Request to revert lt9611uxc fixes from v5.15.y
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, Maxime Ripard <maxime@cerno.tech>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Dec 2023 at 14:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Dec 19, 2023 at 01:54:59PM +0530, Amit Pundir wrote:
> > Hi Greg,
> >
> > The following lt9611uxc fixes in v5.15.139 broke display on RB5 devboard.
> >
> > drm/bridge: lt9611uxc: fix the race in the error path
> > drm/bridge: lt9611uxc: Register and attach our DSI device at probe
> > drm/bridge: lt9611uxc: Switch to devm MIPI-DSI helpers
> >
> > Reverting them (git revert -s d0d01bb4a560 29aba28ea195 f53a04579328
> > #5.15 SHA Ids) fix the following errors on RB5 and get the display
> > working again on v5.15.143.
> >
> > lt9611uxc 5-002b: LT9611 revision: 0x17.04.93
> > lt9611uxc 5-002b: LT9611 version: 0x43
> > lt9611uxc 5-002b: failed to find dsi host
> > msm ae00000.mdss: bound ae01000.mdp (ops dpu_ops [msm])
> > msm_dsi_manager_register: failed to register mipi dsi host for DSI 0: -517
>
> Great, can you send patches that do the reverts along with the reasoning
> why the reverts are needed so that we can queue them up?

On it.

>
> thanks,
>
> greg k-h

