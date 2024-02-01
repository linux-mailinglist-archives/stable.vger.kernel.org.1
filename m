Return-Path: <stable+bounces-17632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C728462B9
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 22:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7440128DC03
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 21:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C648A3D542;
	Thu,  1 Feb 2024 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkOU7gIt"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA413CF65
	for <stable@vger.kernel.org>; Thu,  1 Feb 2024 21:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706823686; cv=none; b=SyZvv0LsX2OgvRqucv602EJXIeh1RJkzmN2DgyvyoImObSJiRFbE4irVOjlTSNPsvtcvLwLVzh1ewQTBucg3CD2XNWekVVQ3t8JwRE4kS6CnNzbzQI4cpUIrTLhX3kM74ApdQcM2Ox42+hX1pD87+WRpH7clSwtu8S+k83cOedY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706823686; c=relaxed/simple;
	bh=SQ1m3yXC+NDL7FmEgP6h8b5WnnPlyP3D3morzRfeeEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHaL418df33zf/J0c265KNsF0ZHO0cWsmLYCLGPLzN/FJd608kLakuG2IfLxskrwd2HIn+DEAao877M5+23DHINcE/1S515kJYHlPMIkzCE6d1YBUzsoSBqB3fJxWpOLlApW/SinemLdSCTsEi46DHTfwl6OnhNa3/r78R3XBts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gkOU7gIt; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60406dba03cso16404567b3.0
        for <stable@vger.kernel.org>; Thu, 01 Feb 2024 13:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706823684; x=1707428484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZcmtzoccqPD34xcaZ6HlkxufzsXXa25ILumhyj0ar4=;
        b=gkOU7gItKWn6EBHaoNc3qShbpmgY/NCxqpEPh9Sia7xLMu4uLQipV+iUe0lr7ndPbL
         hWY40Gfu6tIjTeRvpUQg1YvxawFb7yfP/w6nX7Ka6IluKcmOMnfvK4tBrD+Ti+NL1T7m
         bMe4dylXwN2aBnAGMmGMQmjD+H9FQVlKxdRYLRsKdPU0VOGs9pSkLASvrXwzJ5R+qy0f
         witYvfLIlzmboq8SdapNksRQkDKseXekgY+EfuS+HihYblu0/zWs8/CPkFy8801XHi1G
         9E9J+CY17RHUpiIkwshSeUgyt7/basl8sct/NoLmBVqwciW/K2+71RZyui30+Yr14AHl
         h5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706823684; x=1707428484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZcmtzoccqPD34xcaZ6HlkxufzsXXa25ILumhyj0ar4=;
        b=JK9RUFexZ6DXou3P/JkmAURceVDOIv71GE+z+ET41HSmD4J3xoxQXErtIoJEcjM/cy
         3AAV0+9jI9VGXbjpzIDpS9bizSeZ0FIcTvLNjlLAff5tT36O0voQtL/4YwT6F1eztM4H
         1JqrMAdk1uF62QTeRAQJb2JmaIMdP7FeKblmOVkxZkICynUuut6SAc/7TyzpgYbMgGRh
         fN8bNcdPsyLi1H7xJ9tee6TirFdfWYujzhWOvRF4p7ly88tGpC/AIS7Y4wJ+y4eWdoEq
         1K/jvTwKUI3U4u3xhB9K/0XSdzuI80M7GVWayZemfNSEno2G8ULNhVXBoNEkhN3lNi5U
         fA/w==
X-Gm-Message-State: AOJu0YzguMVf5PQeMvPbytBJ31bHMTnUkeLd/t6aT8AMYOP/porPN7Tq
	7MI56X6i7xKF3Z9ieLgfFA1wPikhBSLxA0r2aNIcmdmm4gdWU/f5Oo5Yq/6yypsutDgLoA4nJOo
	DO2cXT3gYHlthkLKQhtuYCSKXxP4C+oTXMAxr+qi+dYUSBqv5
X-Google-Smtp-Source: AGHT+IHo96L2vjESmgUuMuE3SPTp/NytUB4ttLNfTpeJIl7OJlcuSBtOgvt20vErXaWpTrk4s8trQ6b4JGNXdZ4jmFw=
X-Received: by 2002:a0d:d647:0:b0:5ff:9676:3658 with SMTP id
 y68-20020a0dd647000000b005ff96763658mr3878685ywd.48.1706823683955; Thu, 01
 Feb 2024 13:41:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201172135.88466-1-sashal@kernel.org>
In-Reply-To: <20240201172135.88466-1-sashal@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Feb 2024 22:41:12 +0100
Message-ID: <CACRpkdbKVcYeC+oGMk-+wfs78GNes3fMMPR8hRQ3A_jX4-vhqQ@mail.gmail.com>
Subject: Re: Patch "Hexagon: Make pfn accessors statics inlines" has been
 added to the 6.1-stable tree
To: Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>
Cc: stable-commits@vger.kernel.org, Brian Cain <bcain@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 6:21=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:

> This is a note to let you know that I've just added the patch titled
>
>     Hexagon: Make pfn accessors statics inlines
>
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      hexagon-make-pfn-accessors-statics-inlines.patch
> and it can be found in the queue-6.1 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please drop this patch from the stable trees, it is not a regression
and there are bugs in the patch.

Yours,
Linus Walleij

