Return-Path: <stable+bounces-118255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1FAA3BE6B
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 13:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCBB07A6B40
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 12:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D0C1E0DCE;
	Wed, 19 Feb 2025 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oq0a/efE"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410B11B4253
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969149; cv=none; b=MtISG/1pOZ3jTKqpn+Uyb4+5qw2Syu916EZ64gci2ponj19EB1ew0DrWGkTcxUCmjunaHPunq8Uthyp+VgyGGOqrvx7yyRAMgZU4FIN1+n8iPpOSrmrwdZTYW8HmKTdqg1bUwtpywwzuMvkI7qS/he9glzGfc5vLHfPvnVoWbRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969149; c=relaxed/simple;
	bh=fkexAl6M5DyJT1F89Ttgt7gmRIZVsmlf4VohxNakH4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoUpPg9tUJsQiAY3zRMRXBaB2HLymCxKXuQt2JeD9Wsi2jZLkSXFVovVL7Ix7I6qcA5dCZVu9xHch0dzu7Jvp4nHgtF49q7vHKcP7shpTeh3gtuJjf/13j77QiRI1eJF1F5HZ/u29aaRYAScE5lyXa/shFfvRB5kx1JcjqaqKHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oq0a/efE; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3072f8dc069so69943821fa.3
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 04:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739969145; x=1740573945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BPuwrJxY2WcVgAzy4da4UTcGT1UhygelXhUrEvq+Dmg=;
        b=Oq0a/efEAlGVhDJ3mwE8X9hFQrQHgu9MM9R2b+l2CQB9wVtDvzQexNm6uVi9FXQP70
         I64Pkz3Uo/S1Oq3PkP5PB3fCe/ND4XFCL48jCnm2DAqwXst723ntNbiZIrMRF/tyPBuo
         efra33d4VI9zrtsgOMlsSt+VIqYB0eLy5HhR1grhW3yLmCC86Z44VRVp8y5Th6S+6i5l
         tyEZEvfHoZ1XZml/IMJM6zgXzh6/cWEkh9INl3ynivHjoyV971HV3ehgOjUkcdc5Kj4K
         3wI0Ily8fLtFuxboWYLB7IljSHt4LhQpyrMRue5UYl+Xz/D3/L2vuJKBnbUuITkCbYyk
         yy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969145; x=1740573945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPuwrJxY2WcVgAzy4da4UTcGT1UhygelXhUrEvq+Dmg=;
        b=NlipUgFmx64xxYKDTRg6NKaSgFvB0EVZhy1vSYpO6nQQdJIRGuN3zsesPXH9pHhc2P
         7oDqeXcIxzQB0QrJ3W9D/R9BJEc6FjEPMzvA5W2v9DDz5pcVviFQhRHoyDdDi2H9JlFI
         iPUnyWuGLDDfX3NyCSX21+sYH2786n5qleqHKt6T/iTinJfbVaQrnUkE3IsIwUQyssMP
         CRh8xY2Fv2PSO/3f3U5kq8WSnpYZMWyd1/WFUx/R83PjugkbuLQtNoJVxihcMLfT47OK
         QpEDUS1L6NvUUQ0DqumpM5MM+upw73RjogpsgMkLCRto3eF1pKDBc1bsxehuFvkKPfgY
         7C0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrl1ruzHcnZTNZLMkYC3q6MgMRvw8tu/MyorjQglFog1xtnjDJMf6gbsb8lBAKeMc1OeQ62qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbN8YBQ3AE/P3jNynA4amxIravVfMtpHRP7lqR0oKRpsU2ncm7
	DaO/iTiqJZWAMbIru8+0xasxMCrptW9wtTlFwxnk90QlzA/DR0/+UZWMUKwskxw=
X-Gm-Gg: ASbGncsRtE7+ZfkOa9etQhf/xpZ8VAe0aKKNUBP9KBfng+3owo1vUGZCQCbiYIwBDhL
	Qs+VFWBvoZgVw07gZTTmajlkOznTLc5jYTNpBZlNdZyzzHYOrR4Erx9un45K3Cgw4qhmeUhWXT7
	DUWn0NzIiXB8ODhtp0+fCOyWszMpW2EHAB5WSr9F34bnXxVLU650ru9zL3sstJlgletZq5UgyJY
	Www/hmJLfEnRqogfiQ22TLuiOv7PtVPQIqZH8UVtGZsTnWmoVOjNGptUALrrOGjs42iVTF4P5PS
	nY7k5XuJB6tWUZMD2mXHFobBvxvBuaoMpb0Vd2zMxegs2KmNVKGB8MQLnGNhy2SmLcnvPS0=
X-Google-Smtp-Source: AGHT+IHqzXvswBBHdB6BuGTvdIaOpP/9m10nx1rxuNNktCu7rOUQ1riauWad8Yd8fM2T5tKt6/n/Ow==
X-Received: by 2002:a2e:780c:0:b0:302:40ee:4c2e with SMTP id 38308e7fff4ca-30a44dac851mr10131541fa.2.1739969145292;
        Wed, 19 Feb 2025 04:45:45 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3092fb236cbsm14835491fa.69.2025.02.19.04.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:45:44 -0800 (PST)
Date: Wed, 19 Feb 2025 14:45:41 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run, 
	marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, jonathan@marek.ca, 
	quic_jesszhan@quicinc.com, konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dsi: Add check for devm_kstrdup()
Message-ID: <lwtvnlt7rfmsbdgyo32fs4mx2xbcyrnjsjq53nkk5pdzrpqgox@nn27ythhg23k>
References: <20250219040712.2598161-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219040712.2598161-1-haoxiang_li2024@163.com>

On Wed, Feb 19, 2025 at 12:07:12PM +0800, Haoxiang Li wrote:
> Add check for the return value of devm_kstrdup() in
> dsi_host_parse_dt() to catch potential exception.
> 
> Fixes: 958d8d99ccb3 ("drm/msm/dsi: parse vsync source from device tree")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

