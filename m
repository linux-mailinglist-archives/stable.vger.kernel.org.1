Return-Path: <stable+bounces-91693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C2C9BF3DB
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 18:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A4E285867
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 17:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A8E2064FF;
	Wed,  6 Nov 2024 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E2wpFy1V"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17664205E33
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912666; cv=none; b=iG/byZvKt2U62OLeq8ioLCF4NLPLp1yJNxa4TsAuSFAorDTSXiqyCHUNrVTiH38btW4sc5gpBvEdcbNoAXmlyeU38itkLaI4rfxvK4iaLwG4b5zWSiTvEZVRqPGx+VkJ72AsGa90yG5zrZQvCpoBZ3Rhzfm8s1lcyS2ubwQqhaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912666; c=relaxed/simple;
	bh=IqW57oiCoBaCk36CniFqvizF47SHTBcgPQmGYek9qt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ak52WhCk5s1LHvYkRbXc0+dYFy87QCg0zJ37z40edu3sdeXYnpPbDuSpTOOeZYri90e3St9lc4pp/TELGJPD/IKokiRRN4NPvYNlk+z/fwgjL2yB5PIf66UnFCUP/3NlQQZLubRQBTGqVRl+lfMHMMTw2l8dqtLdwuys2xIArkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E2wpFy1V; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so6097245b3a.1
        for <stable@vger.kernel.org>; Wed, 06 Nov 2024 09:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730912664; x=1731517464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rDaQLdznzK7seqYSBe/wCoaA0MUN6ZM7xHd32DKGHh8=;
        b=E2wpFy1V4LcM8Sjf+T9lJHkgp2HZjgkTNCNRFwG9qGmsNMUBBtUNhBb80D0twCHrzx
         bMFYUFq+sO8wZlQpMd0bKECkSAhALJ8iTIJgzTkooIQsSkZvOLNs1hUOFAt220fGk9tS
         yfWCygVv7RshrRCSmfy3KKk8EAzEyRbhuZBMzGPSmVh6Djt5GgUMS7IVSvPDRvxN18yv
         gOsFRCkEV06ZGoJkNYZjArFQyAqJXhgs7SQ8XpfIS0nopGY0cE868Ar7Lo1qZldUsxmq
         OHoQS87UBu56IM/w1wYKDuwWCfv8vD73LQ++DmK6vccFlKZNGiqybV1K2A9X/nk00Am6
         iRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730912664; x=1731517464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDaQLdznzK7seqYSBe/wCoaA0MUN6ZM7xHd32DKGHh8=;
        b=nThPenzN1IMS+3Nmzz1h+LaLrW0iiQwQ+QuLq1sdioyetRYf/5ZPFHw8hsROclBh6R
         tQzzDmD/P5W+Zx8w2fTK7F024YpwnO0ThZT0fVio8HfhwQwMKfilRdcTHQl918SqZu5x
         oYjngomgjnAULNwOu/thXnP5TYhZqdAt7WX3hR0APk2yHDzj/z+TY40eLpbVjDOI4sNy
         F9QQTZ+ELlH4w6Uxq+goRponyXctvA+9b7T055EYo/58vDF5oKx+3LgiI3HV4lmnaAXy
         VxRgPRufeF3/Hf+GApN3K6ZTJWu/Z1WF32nYYqUeMIQjN4XM4XPO6CejwRjtRkoFg5tY
         si3g==
X-Forwarded-Encrypted: i=1; AJvYcCWXqpyNyuunAe+ssYF8dCHgNlCPSy76BhisgAhjLb+zFZ5+Pa+sCJJchUy2WmwL7at379jYOLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+o/2n28RhXfbTOnPNzrWGv2Y6AgPGIlvVPXD0KwGieXy13m0P
	C2fBcpBwwrR/lMJjzC9A+olahOHlIRzz3PwLUZVmxTEwoHYpkK4uI2OEpirSuw==
X-Google-Smtp-Source: AGHT+IFTRmyv3jddEWzwMk7l4ToMoo9qEgn6PMk6nfoP7kxnLFshmvLNCipLw+gSEmO7+UOuZw7W7g==
X-Received: by 2002:a05:6a21:3292:b0:1db:f68a:d943 with SMTP id adf61e73a8af0-1dbf68ada69mr7915594637.17.1730912664141;
        Wed, 06 Nov 2024 09:04:24 -0800 (PST)
Received: from google.com (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452a7ffesm11355388a12.23.2024.11.06.09.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 09:04:23 -0800 (PST)
Date: Wed, 6 Nov 2024 09:04:18 -0800
From: William McVicker <willmcvicker@google.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
	yunkec@chromium.org, hverkuil@xs4all.nl,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, andre.draszik@linaro.org,
	kernel-team@android.com, stable@vger.kernel.org
Subject: Re: [PATCH] media: videobuf2-core: copy vb planes unconditionally
Message-ID: <ZyuhknpDgVLl39zL@google.com>
References: <20241106121802.2939237-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106121802.2939237-1-tudor.ambarus@linaro.org>

Hi Tudor,

On 11/06/2024, Tudor Ambarus wrote:
> Copy the relevant data from userspace to the vb->planes unconditionally
> as it's possible some of the fields may have changed after the buffer
> has been validated.
> 
> Keep the dma_buf_put(planes[plane].dbuf) calls in the first
> `if (!reacquired)` case, in order to be close to the plane validation code
> where the buffers were got in the first place.
> 
> Cc: stable@vger.kernel.org
> Fixes: 95af7c00f35b ("media: videobuf2-core: release all planes first in __prepare_dmabuf()")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Thanks for sending this fix! I have tested that this fixes the video playback
issues I was seeing on my Pixel 6 device. Feel free to include my

Tested-by: Will McVicker <willmcvicker@google.com>

Thanks!
--Will


