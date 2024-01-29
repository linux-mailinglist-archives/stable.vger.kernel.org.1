Return-Path: <stable+bounces-17301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4198410BF
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE991C2329A
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DB276C7A;
	Mon, 29 Jan 2024 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+mdqM68"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2CF76C69
	for <stable@vger.kernel.org>; Mon, 29 Jan 2024 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706549434; cv=none; b=DMJEWsP8QBdbZAswjd+fZ5KPgC7AmisARsgMuyQl14XSw6d8wmdntgptUc1um4rJD05dZpmIKhSBzwMlprBmzUfA0BZiQEnC63tvyzK66OTjnr3ehLFkYGq6faCINFYxIdrNCrgNZo1mNsBTTtQcKajZMJvFUYTw/D6D2OT/cOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706549434; c=relaxed/simple;
	bh=2OZ14mI0u8xh5I/pvTyltSxYTCQUCxzOrkvKQ3NU4Cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSIQenNJbw4byAniWN2Jz7kiMCVLMIpgFhptGzFMcnBX+6Xo+2KeFHrVp4LAcYdI8ZM40zt5Vyetg0oXfW//1/9mWpSDZv1OwwNPSyBj1o7sxaSLcIc/KP3iJezU+FAVLSP833+n+XsHeiyLXxkU8AtgndznCscMqxa/udTBvwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D+mdqM68; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4bd2b1dc7d3so609141e0c.3
        for <stable@vger.kernel.org>; Mon, 29 Jan 2024 09:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706549430; x=1707154230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2OZ14mI0u8xh5I/pvTyltSxYTCQUCxzOrkvKQ3NU4Cs=;
        b=D+mdqM689ZFc5itlTqkMjOfTOSpejl9RKHVgmeSMyLL6kvS8QA+RUoBFNcuEd9TYDD
         UfTB8EhfX2XNt05mNmgKV6lWAut4MgOWouD33rHFqzswqN9AeVO+1Klchr9XakFQm7Wt
         h8RLsQRoUuqMsfIMbbgwv1jIr+K48yzxGhPrFau4alsAhxc7ru/oNuB6gOIsTBL/b2uu
         ca9v19z3WilPUTcU7vbumMgiSg5B+S/Bnx1Hsz6TEOL6K1PZfFnUIrcI2YL+xsq7nSTm
         lIesUyxHD1a2STkRfG1rB9xwrfIFgk/vNaXug1ez6UStfQMLs5ptJGdRiJCOLxwARLic
         t++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706549430; x=1707154230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2OZ14mI0u8xh5I/pvTyltSxYTCQUCxzOrkvKQ3NU4Cs=;
        b=ML2OmfkS/tJSG7hP1IPzNaagRdcgF/jQtOY5kOYUWYqdrkJ+kve7J301qb93TImrZJ
         C9K6TedeNt8E0LicT23Fuq9my8PRHViDQJu2KcZ8y29A/jtEMRead4xHtl75xUPc22p7
         L48v93Re+PB/N4gh6ZMjWEdbLXbC8u91LnixGxIyfQ6//EYdRZzantmww6g3Bz/Zk5YO
         HRoD3b/zlPZJ4pOMvvI0vtES5hfyXdjeD0jO25PDwbAZAMv9SYq5WpRqbXgF58Qx5Pi1
         pUnhFBgSFFwsKjt5D4ysRjipYg/O0U5PqO5F1L6QdK5gm3QR7+wdL29Ls/a5Qs7HCmoL
         /chQ==
X-Gm-Message-State: AOJu0Yyq91y2LNC+wbe//meC8pWyhH7UZUUEmVdZfPH2R43uvOomhW44
	gaPMc5t4m+8vqR3ui7CewFgPrmPibpzoxqD9a+EHkAyVxOHohdNNQc9EHe8YZZHtRoT/SENp1Wb
	ZfnpyLCD0Qooil5hixjLwtC924zKUELGUAxNkbw==
X-Google-Smtp-Source: AGHT+IFY6DGvgFjtevNtx+nE3QrKWuRdhoRzW9QtmTRL3qBwhiVw1NRnmt8CaeODH7Z9VoZ+3aZ9t4tz7H27bTY3tTU=
X-Received: by 2002:a05:6122:4c0f:b0:4b6:e383:5f with SMTP id
 ff15-20020a0561224c0f00b004b6e383005fmr2483989vkb.25.1706549429991; Mon, 29
 Jan 2024 09:30:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129103902.3239531-1-amit.pundir@linaro.org> <2024012936-disabled-yesterday-91bb@gregkh>
In-Reply-To: <2024012936-disabled-yesterday-91bb@gregkh>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Mon, 29 Jan 2024 22:59:53 +0530
Message-ID: <CAMi1Hd19ox3b__mUk=VTxj_eRuzGYhzECTQ3sCrAzcpiQDJe5Q@mail.gmail.com>
Subject: Re: [PATCH for-5.4.y 0/3] db845c(sdm845) PM runtime fixes
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 21:51, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 29, 2024 at 04:08:59PM +0530, Amit Pundir wrote:
> > Hi,
> >
> > v5.4.y commit 31b169a8bed7 ("drm/msm/dsi: Use pm_runtime_resume_and_get
> > to prevent refcnt leaks"), which is commit 3d07a411b4fa upstream, broke
> > display on Dragonboard 845c(sdm845). Cherry-picking commit 6ab502bc1cf3
> > ("drm/msm/dsi: Enable runtime PM") from the original patch series
> > https://patchwork.freedesktop.org/series/119583/
> > and it's dependent runtime PM helper routines as suggested by Dmitry
> > https://lore.kernel.org/stable/CAA8EJpo7q9qZbgXHWe7SuQFh0EWW0ZxGL5xYX4nckoFGoGAtPw@mail.gmail.com
> > fixes that display regression on DB845c.
>
> We need fixes for all of the newer stable trees too, you can't fix an
> issue in an old tree and then if you upgraded, you would run into that
> issue again.
>
> So please, resend this series as a set of series for all active lts
> kernels, and we will be glad to queue them up.

Ack. I'll send the patch series for all the active LTS kernels
tomorrow after build/boot testing them locally. Meanwhile please
consider this patch series for v5.4.y anyway.

Regards,
Amit Pundir

>
> thanks,
>
> greg k-h

