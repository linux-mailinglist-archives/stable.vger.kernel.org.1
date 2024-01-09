Return-Path: <stable+bounces-10356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E42A2827FDB
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 08:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC3DB253EB
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 07:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5264BE4A;
	Tue,  9 Jan 2024 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ntJSrakW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649502D60A
	for <stable@vger.kernel.org>; Tue,  9 Jan 2024 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28c0536806fso2478273a91.0
        for <stable@vger.kernel.org>; Mon, 08 Jan 2024 23:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704787050; x=1705391850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LJaAgkMysyU+rJly+ZLjAMA6XzBdKr1ifp5VcfkkRmI=;
        b=ntJSrakWiG48I6/vXlFku3TzkbRf+vg8wL8lj5CXWzJ0dx5TUjOTH2Lmz3pQ4Cb5Gy
         4tjHC9MhSmdQ7UTxm4WvTtZ91C/n7LaX+J6fpvn7KtyIf2Df+xy3ed/UHLn6P83HDxvh
         yduFZca1LHnicY7AaoYffaW5p5LGekw/13mNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704787050; x=1705391850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJaAgkMysyU+rJly+ZLjAMA6XzBdKr1ifp5VcfkkRmI=;
        b=SuQa4c4sX2DD+c7rbquZKnzT0mLZWTFgvxFEfZZIA/wEMolxtgLIGiLFvPdmrIWHsK
         t1QjmzzKbuD/csrKXEyizrSj5L77iahgDumGgAuq3sYNmN0oDekS7vEBAG9Hga3J5SQe
         pYMQnR1zuVcLUar1gH3dVCu/l8eIzdT9NJWNu6SIOZiDIogPeFoEyK2QQt+14RqxrBRB
         AG+u+yzfrcqob8NajH7xhhrQeFeYCVlQBik59u04euXBOQpxUqpeeY6hoqj3ABeiYh3o
         Cubh+iV8/SKkekAmnu13mnP4ACj0ddEVZlTaJwLZDMfPt0YGiwwcg82IyA9B7/h7nUTM
         ogoA==
X-Gm-Message-State: AOJu0YwgF45PtV4vDtmvl7kMYgd62i6ndUlZ1k7plgbdOxrjo24LFhsa
	WeqaQeM2hcasU5RC+hDQvmSaHky9pxm7
X-Google-Smtp-Source: AGHT+IHkdc5SEqOU4j+ZTAsSmX5JM1gcIkgcDn5+o0E0JsF/jrPN5rTqY5Qu8XkZuoCUCMrUd0zVDA==
X-Received: by 2002:a17:90b:383:b0:28c:e64c:b97f with SMTP id ga3-20020a17090b038300b0028ce64cb97fmr2688891pjb.85.1704787049720;
        Mon, 08 Jan 2024 23:57:29 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:7b29:709a:867f:fec5])
        by smtp.gmail.com with ESMTPSA id 15-20020a17090a000f00b0028bbf4c0264sm8420053pja.10.2024.01.08.23.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 23:57:29 -0800 (PST)
Date: Tue, 9 Jan 2024 16:57:26 +0900
From: Hidenori Kobayashi <hidenorik@chromium.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yong Zhi <yong.zhi@intel.com>, stable@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: staging: ipu3-imgu: Set fields before
 media_entity_pads_init()
Message-ID: <20240109075726.4ht5nqrtevzk7yh7@google.com>
References: <20240109041500.2790754-1-hidenorik@chromium.org>
 <68ff6c83-b8c7-4bcb-9b94-a33ab83aaf58@moroto.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68ff6c83-b8c7-4bcb-9b94-a33ab83aaf58@moroto.mountain>

On Tue, Jan 09, 2024 at 10:51:15AM +0300, Dan Carpenter wrote:
> On Tue, Jan 09, 2024 at 01:14:59PM +0900, Hidenori Kobayashi wrote:
> > The imgu driver fails to probe because it does not set the pad's flags
> > before calling media_entity_pads_init(). Fix the initialization order so
> > that the driver probe succeeds. The ops initialization is also moved
> > together for readability.
> > 
> 
> Wait, I was really hoping you would include these lines in the commit
> message:
> 
> the imgu driver fails to probe with the following message:
> 
> [   14.596315] ipu3-imgu 0000:00:05.0: failed initialize subdev media entity (-22)
> [   14.596322] ipu3-imgu 0000:00:05.0: failed to register subdev0 ret (-22)
> [   14.596327] ipu3-imgu 0000:00:05.0: failed to register pipes (-22)
> [   14.596331] ipu3-imgu 0000:00:05.0: failed to create V4L2 devices (-22)
> 
> That's what people will search for when they run intio the problem.
> Could you please resend a v3?  Normally, editing a commit message is
> pretty easy, right?
> 
> regards,
> dan carpenter
> 
> 

Ah, I misunderstood then, sorry. I will add the error lines to the
commit messages and send a v3.

Hidenori

