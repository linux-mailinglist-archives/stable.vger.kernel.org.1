Return-Path: <stable+bounces-100292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A9E9EA703
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 05:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504102834ED
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 04:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09757226182;
	Tue, 10 Dec 2024 04:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qn4Nsp75"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4321D22616A
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 04:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803702; cv=none; b=fTaaFFRmDMvmM7MMf2Brp7NU57Q2mVpGjdUJd8sSFM2+CF5EVIPQ1ROS2VTF62UJgAP3S1LgnhT4r0PwstiD6RVmoinRHyp13BScZcA5i0QaKqS0zjY4it4/qlQxfwL6DxwjTiGAuB8Hk2dOnJC04QZ8bLpxniZxQfU326ZtpWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803702; c=relaxed/simple;
	bh=77oJMx+eeBDF7qy2o8yfW9PnFYhmY2+FGY13HB2vUi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ib8+yABsPNEWGMq5w7+khcOSe2Hiw0y2PP0xvA6vTSS/ZAt8Azko9T6bzT1jN5wV9KS4fjWtAF9Vbp4AKXIcz+PccYfg/VsqeA6/SQnnDCD8z5N3acvyesgSzExgbncf5vckEv1JI5vzNZ9SM7aKgw1rJLTmTUwwGR/WJRelYuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qn4Nsp75; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21654fdd5daso14734255ad.1
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 20:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733803700; x=1734408500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=axXRqmXD5+CjBVBSDGxUL0twbCo/E0+HfkDdNUNs4Po=;
        b=Qn4Nsp75Xzo9Wkc1bl5OevJipATe5BmQk6WevRLZonnnyME2W5nKaOoXe0nu5WqWDC
         L9ggB3ihp4NtKmKKN2wr39FqAt1kQHUy3ctu2TKhXPaMvVRasB4+1LjmoTKBfhJ+jWh9
         rp+qfWGFIfbvrgOH2rBe0qhy2c+/0aj6LmUuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733803700; x=1734408500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axXRqmXD5+CjBVBSDGxUL0twbCo/E0+HfkDdNUNs4Po=;
        b=WUYLJxqcmruwDtOEQaUz5pol0Y7Ep5dkPxgR+aOkQw4lQNtn0JocDoFBBbGkpOlFr/
         7izKJC/oiXaoSbQz/DDg8O9bEZxOyOMjNlmqnaeq3moKaU7phdsdQe8ekODZv3/C8FrX
         P8rzB9PPzta1hG8cKOlr+4qqCiGBhsZTjwQc3Xvpl1SkgNHfcUp3thBS7uOIQFBGx5i9
         FoYazkTlNQ0cQqJJ7FT1LpvKA8pTQZ1QWnJjcaRYyNnkM8GMbKop3Il5dlSidLz0XXHi
         jk2HHlMZ+pTG+jFLGLZWeiYdw0BFSXDXibdSy4s2RjK3xBs9ewJ2LrF0ebMUH4p5ko7Z
         Lhuw==
X-Forwarded-Encrypted: i=1; AJvYcCXZYvaLwFvF3ZKGK/zGDqHIW2GeLp2YAXKwvd2sz72bN5Zqg/w974cEayoiWuYapuyCzRz5ipc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTsZNPjGpN0Ym0Sm1Sn3JsgZ/O7oFUPwAf9RvqZNGcufDil7yj
	XfAmjO7/Dlez6/GQBp18KcRLITvuJ9Ms8AsrzWAkL6E43T1u926sKo93A+/sWw==
X-Gm-Gg: ASbGncuQooOKqfj6bzgkADFVLO+T2uI/ZSIQj0g0ErcOSfkBjfxhbhChuZpKKReUJUx
	Dia40tBVrWCWZjtbl1T5B1hueF0yqOD0Uyrd4Onlx4os5jyzap1193dchnA1RMeJUw2rvD7+wqI
	Nqh+hUHJMW7hUDo88Ejmx2zEjkQuC+If3R9HbmKxy7z5NAXxReVj39nLmgq7BCcmsoQgGdL58an
	lJTM+PzJng8HU3e5+0fLibikff2cX5xmlJHcmZGeSKZIRV0aexlAvm12Q==
X-Google-Smtp-Source: AGHT+IFjmpvieV+pfsMfThew3ztD0oXD6IkJjb8h1A0Q75dlOI+AVRkqso5KxQ+5N/XewF/VP4QJxw==
X-Received: by 2002:a17:902:e80b:b0:215:97c5:52b0 with SMTP id d9443c01a7336-21614dac17dmr236776125ad.38.1733803700680;
        Mon, 09 Dec 2024 20:08:20 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:ecc2:3f01:a798:5d0f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2166fc21dd6sm5586975ad.123.2024.12.09.20.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 20:08:20 -0800 (PST)
Date: Tue, 10 Dec 2024 13:08:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, stable@vger.kernel.org,
	senozhatsky@chromium.org, deshengwu@tencent.com, kasong@tencent.com
Subject: Re: + zram-fix-uninitialized-zram-not-releasing-backing-device.patch
 added to mm-hotfixes-unstable branch
Message-ID: <20241210040815.GJ16709@google.com>
References: <20241210015750.7D4C6C4CED1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210015750.7D4C6C4CED1@smtp.kernel.org>

On (24/12/09 17:57), Andrew Morton wrote:
> Setting backing device is done before ZRAM initialization.  If we set the
> backing device, then remove the ZRAM module without initializing the
> device, the backing device reference will be leaked and the device will be
> hold forever.
> 
> Fix this by always reset the ZRAM fully on rmmod or reset store.
> 
> Link: https://lkml.kernel.org/r/20241209165717.94215-3-ryncsn@gmail.com
> Fixes: 013bf95a83ec ("zram: add interface to specif backing device")
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reported-by: Desheng Wu <deshengwu@tencent.com>
> Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>


Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>


A side note:
I'm not sure if this and zram-refuse-to-use-zero-sized-block-device-as-backing-device.patch
are worth the stable tag, they don't really fix problems that people run
into en masse.

