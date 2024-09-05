Return-Path: <stable+bounces-73620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 134EA96DDA8
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 17:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE7D7B279DA
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 15:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B298B1A2842;
	Thu,  5 Sep 2024 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u18XTSGx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B489D433A7
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549118; cv=none; b=HTkTOviPnHbvUuKQ+0bD0AgnJ3C+0kHW4/xhJ/h/qAzEDUVD86cKDWz5nrM4nVFqChDrhcToIgfbstnUmx3QPiMf2ptEzGExiU8A5KhDzFyNLrEVXWKCVBXge+SuZP4FY0MYH3ifOTuabI0Gpy7+oQYAob0ydOTb7lfL4+YLxVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549118; c=relaxed/simple;
	bh=0HVxap2WfUaoSbJ6P5wXUA6AtuQouKc0QdxQVKFfCSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAsDMl597T/KZzIISDZXjYvC+gVRqYB3oWZn6Sq8Mr9LUkVpZzImD5zJO2OkJOouBavwmJP3iZLWZfNmxFlm+rs/+YIku5r4YLs5G8KBrn8OgRMejJ0IXKKH24W84Nkkxx5XyMa2I5KO97svXzpIQXULuNmOqN/T/owRtIhtcFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u18XTSGx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42c7b5b2d01so9572025e9.3
        for <stable@vger.kernel.org>; Thu, 05 Sep 2024 08:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725549115; x=1726153915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c5ydbHAcLR6S2kZ2UiSe4taaN+JWRdShTwsXukZfYrE=;
        b=u18XTSGxV5WU0BIezQYLudJIcblmUCm58m3EDhW18mLbLQ569wOl0qAtqRId2v7yM0
         OmEdMSTFQPTgyUeovfwC3/8woXc/NF+hfInt+t+WCXmFW0ym/XGOqcIImVmTBXSkjyHU
         xJUR7bpptshFed2S0YK01hjdWwrCAuhoRljD3ugezT0GPUnfvqpeoEIV0+JYFJvtZKEz
         M51x8/3tBPA/jfxpt019PlbkySMYXudildBwI/MmU0sbmHRryYQqivGdJ6sv+CABKXIq
         9yHHFcvY3z5dUje3VY69oz+6mq4JAT4Lu7hdcEAClPs24sVJbO6B+WDSm1kMfqIhi/Qu
         Xkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725549115; x=1726153915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5ydbHAcLR6S2kZ2UiSe4taaN+JWRdShTwsXukZfYrE=;
        b=p2a2A/O+wNS1Qj7k7PY/SLlV8wTYav4sC6EXwqAijm5kzFJaxq4uXlfBeywcaluilm
         +gI8mZPyksuwTszK6fi65a7rwhjK7ggBa3pARvuCaaEjJYhv5E7MXJMsh8ESR9tQ1oka
         1FvCuT7ekJ1DX3Fn7Tx479/iabGmwTbZ/miDb1cq1E4LvO2my5S+4+AKdlDs7g1iYl/8
         pvbwLOuUNesQyJKyhYxJzbO2tVyvVUZL4rVCGPl5YZCEZB/fuv41rP/dtFjeiQBlysVk
         hZ4CoPkRer9R/Ondkp1vjAqh2z6aIOjZlTBAKUGYaBnvmFS73KJJyjAAymnkpNQOnsAW
         wJew==
X-Forwarded-Encrypted: i=1; AJvYcCVilcHzSD+bL6U+nQe8AOmorMhH+NFIN9UgP5fkUS6sWM2nhZbT3ttMav/AVj7a4Y44qqlwyic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn7mfSWfCXLtA73wGrAzENmEArye/PgcEFydBWBgyWoKkjCQaE
	RY+6u9WZYrP+4NEo6bXkDEzyEnxH7v+lcEqUw2VseHpuo82XIHDTW6upMJcpZMU=
X-Google-Smtp-Source: AGHT+IEb2Gx1tTCmdOI5YjqColZWn/7Fy+QvmuvrxLoHycJJrpvuJNWc5dunZZ9mWjFu1Gzsuu06PQ==
X-Received: by 2002:a05:600c:154f:b0:428:e820:37b6 with SMTP id 5b1f17b1804b1-42c9a3938b4mr26782045e9.31.1725549114779;
        Thu, 05 Sep 2024 08:11:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df84b9sm235437335e9.24.2024.09.05.08.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:11:54 -0700 (PDT)
Date: Thu, 5 Sep 2024 18:11:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Hillf Danton <hdanton@sina.com>, alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2 4.19.y] ALSA: usb-audio: Sanity checks for each pipe
 and EP types
Message-ID: <747a6089-b63d-4d14-b524-55a76f58d724@stanley.mountain>
References: <76c0ef6b-f4bf-41f7-ad36-55f5b4b3180a@stanley.mountain>
 <599b79d0-0c0f-425e-b2a2-1af9f81539b8@stanley.mountain>
 <2adfa671-cb11-4463-8840-a175caf0d210@stanley.mountain>
 <2024090557-hurry-armful-dbe0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024090557-hurry-armful-dbe0@gregkh>

On Thu, Sep 05, 2024 at 03:49:14PM +0200, Greg KH wrote:
> On Thu, Sep 05, 2024 at 04:34:45PM +0300, Dan Carpenter wrote:
> > Sorry,
> > 
> > I completely messed these emails up.  It has Takashi Iwai and Hillf Danton's
> > names instead of mine in the From header.  It still has my email address, but
> > just the names are wrong.
> > 
> > Also I should have used a From header in the body of the email.
> > 
> > Also the threading is messed up.
> > 
> > Will try again tomorrow.
> 
> It looks good to me, now queued up.
> 

The code is okay but the Author header is messed up.  It has my email address.

From: Hillf Danton <dan.carpenter@linaro.org>

From: Takashi Iwai <dan.carpenter@linaro.org>

regards,
dan carpenter


