Return-Path: <stable+bounces-207589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA26D09F52
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7CC8E302BF96
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FAA35C188;
	Fri,  9 Jan 2026 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qceN1F1h"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209691DF72C
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962482; cv=none; b=KNxtrhllicgFJ7fKaE97+i8B9frMRo3tXEnQydYWt9dGkVAQ2P8oJF2i6HJpFfkvoO3JSz3al2e0WgiVsvijAkYya9cwCGGlBYGvAIX0/d2TINSD2AeNzKT8I632aWtvkuC0vPLPwXJYFLS+dURLyt8jEtPrajoKevTZGS6CSlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962482; c=relaxed/simple;
	bh=eVOmJOpJ2g+nWNAxnyfdx6FM/mb3Dw1vCRyIVPH1Rag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egr6jnywY8D0zBE3q/vge3y82IRwBZqKlBzKjY8nA8iaPCnrEEUyqemXNZuSTYZklsyc9GW2ydtxCRc6E1CBH93COI4b6UwLakp250TJTvMssjvZ+0opqnCUJST4V3sjoNEfSN0gEFyfBds5ByH5xjHNZkuiZYQC49r5IXvFtiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qceN1F1h; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47d63594f7eso25799065e9.0
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 04:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767962479; x=1768567279; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OS8jAYKJTxd436S6Hg/z7BMXyNGFTQawvHyOajW7Mkc=;
        b=qceN1F1hDJPqJY5F4gHMRVmzOfN1y/WpGRpK6mEmPASh3hwTbM0Rc/HDpEHpuXV8Ce
         Sk4JjfTw9uAavOrlTNDhYr/OI7NG1QjaAUK6o5oC4P1dsAZYidhFXpFEOS8dxTOdxFph
         LSV7m/jXVZLHKSk8Rd9TQXGw1bWcZZ494gBpWIL1CT5Jp9NcDjIQUNKCc9MSD9TzK5ue
         BE+yGaT4mMa/B+kEEyhgmVRWi/weAoghJWqDqIsJaVTCFK8pgBbF0rx+eX0CBgG5Rbyq
         ZPhehTfc7tYvK70bXzP6K0WjVOuqP/8yLrviqIotqX9pKoZ5i+U51i6gwgSgqm75oF/Z
         /S8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767962479; x=1768567279;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OS8jAYKJTxd436S6Hg/z7BMXyNGFTQawvHyOajW7Mkc=;
        b=dAgP7k6PQECBmywwxspe18Hy409xyYoEreC23hYULfUePx7/+sIIGmZxJrIjI/umaI
         mdJvzgVyPSTJTQT+7teFpXX044Pfkq++cUPKj5eTLeMkyqyz5YqCSfASxz0xbpaZMuSu
         4jU5tNYWCPd0C0KTbvURwGcsAbn09I+zJM55fFXHc/EBUATwPxruF+csuu4mObN7OwpW
         8IJIkxdxIMx6e0vX6dc3x6r8Yt3GgHBfyuX7snQZ0M82IefvVvmCwD5N9PiLICIEb8Jx
         Uwc9oE8yeVPJftYJOFukEYcO/JSxUjGcvL5DWYbrYJUm2h/jVM4TsHMD0MihL5F9U9SU
         FCHw==
X-Forwarded-Encrypted: i=1; AJvYcCUqEyYHVkCo9IkdXg+JXihliTS6Z9Z0mDP6wv+QS/XxsOXUsZYx3bLD/S3RPiK0vrPj2unvuCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMieVZe2BIT5Wsb5PVkn3abTdttsx9IIa1CI11sCj0RKuuFP6Y
	N+qZFyil3rWC4QdcsWliIw6RCLdfgiDt8qNtZJWVdHlWAfxwIDJKq666L1/RNtqQIg==
X-Gm-Gg: AY/fxX7N3l8rc9bcArI4xYBm+Y+RDMa8bUlG457lIxQ+uPbwXt2l/1llcGxeAXX3EKE
	b/T2pDjCxg9V3tgefmteHI65HkuhXVSV0FtRKX7HyTOv08V+h9DeVwGwcgYQaBvq+oIvRCZx+eC
	32f6h0xZfyHoSnXg40zRscg/fKAWDROT/PI2wtf0mCZp9FJnW8H4UHaj6yxF4T9pZnfojVfY/4I
	rRceKBFISLvH/b/nfkeShrQOXely5jnIvZdn4STtimhrltMtVzT3v5RJKfbBlPXSbeMlIiW6fXF
	ztBX+PDb57/CWQTs/Z16s8SmvFciZ7tnkJWlVSJEhjkneiT2hUlt6MkGXgAihobn/u0e1P3PAa2
	GaN2LhN2E59oscROzSZZ8R9V0f1IHKNE9dg97HPH/X0HQeyreAqp1nHzvlwMhQfmGADTMdI1rlF
	2o8ZO28iVmo1JSprfxcRv7YBeZ5iqjzDEFyL7UcKEGKw==
X-Google-Smtp-Source: AGHT+IEs1pOpkW+f39F/DRqpNCXzF0cymX5J81DrZywu+onED4ZE4gRGm1Y2kkOMoDNFz55txwy6qg==
X-Received: by 2002:a05:600c:b86:b0:479:3a86:dc1e with SMTP id 5b1f17b1804b1-47d84b41007mr111442295e9.36.1767962479268;
        Fri, 09 Jan 2026 04:41:19 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:b844:1270:724f:f3aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f418538sm205252975e9.5.2026.01.09.04.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 04:41:18 -0800 (PST)
Date: Fri, 9 Jan 2026 13:41:13 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, stable@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: Check maxfield in
 hidpp_get_report_length()
Message-ID: <aWD3aXy9OzH_u73S@google.com>
References: <20260109105912.3141960-2-gnoack@google.com>
 <2026010956-anteater-pungent-d5b6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026010956-anteater-pungent-d5b6@gregkh>

On Fri, Jan 09, 2026 at 12:14:43PM +0100, Greg KH wrote:
> On Fri, Jan 09, 2026 at 11:59:12AM +0100, Günther Noack wrote:
> > Do not crash when a report has no fields.
> > 
> > Fake USB gadgets can send their own HID report descriptors and can define report
> > structures without valid fields.  This can be used to crash the kernel over USB.
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Günther Noack <gnoack@google.com>
> > ---
> >  drivers/hid/hid-logitech-hidpp.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> > index 9ced0e4d46ae..919ba9f50292 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -4316,6 +4316,9 @@ static int hidpp_get_report_length(struct hid_device *hdev, int id)
> >  	if (!report)
> >  		return 0;
> >  
> > +	if (!report->maxfield)
> > +		return 0;
> 
> Combine this with the if() above this?

OK, done. I sent a V2:
https://lore.kernel.org/all/20260109122557.3166556-3-gnoack@google.com/


> And if we are going to be handling "malicious" USB devices, be careful,
> you are just moving the target lower down, you also need to audit ALL
> data coming from the device, not just the descriptors.  I'm all for
> this, just realize that this is a change in how Linux treats devices
> (and all other operating systems as well.)

Thanks.  Yes, I realize that the later communication with the device is also a
potential way to trigger bugs.


> For now, we strongly recommend not allowing "untrusted" devices to bind
> to your system if this is a threat model you care about.
> 
> Not to reject this, or your other patch like this, just letting you
> know.

Acknowledged, thanks.

-Günther

