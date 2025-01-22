Return-Path: <stable+bounces-110088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B9CA188F7
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 01:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2D63A553C
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 00:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423253FD4;
	Wed, 22 Jan 2025 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="Nr92q1XR"
X-Original-To: stable@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA93C1F
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 00:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737505824; cv=none; b=XGuRAHzm4urqLvQSLwAsc5dML9ZOTTbf2jzv+106Tx/sqcWp6T1hUuCZwhWypmVfyylcEtiz4EYKfPHEpY8Gvd0+iPCmKRS5mt2BLQHOgs06BDxo3Bv5Th+oCJbSFvMV1GYcz050XPkBOZA3ENIRbwKUPM8FVF4bKq9j2gAq8Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737505824; c=relaxed/simple;
	bh=DPkLAf7+HErf4szdsvzc51ZrGaUYw7BrIYp1rs8ZBOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLR2KfJc9XhXev59GmHBKfsKEP7rGA8QFpBUQOMoPyIaOrztgyl/PJRY7mnJz6JmKhYH+uV8fljL2+gm60MUOY7FpqBznulDpR6qsD/qlE7+oH7rcX35emn1R0f8ZOUkEwjrEwcq6By95MtRlzhx8zac/EaI5Vzd1nlO9FZgeBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=Nr92q1XR; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=Nr92q1XR;
	dkim-atps=neutral
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id A0CB5587
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 09:21:24 +0900 (JST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2166464e236so185089105ad.1
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 16:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1737505283; x=1738110083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a1TLfeOz9Q4gtSY6IBD+sYaU477uQa7FYhohbKlqeeU=;
        b=Nr92q1XRhtX5hGBQxzFoizUSR940op7swiFCtzPSHC793f0RsvZ0Xung9tPykdT7xG
         q4+aDxoCEst1myUype7G2/v86dqD3W6OZXmq2UK1ru7XXncOQxKnqXKjNK53C9oV2yx7
         JR6zs5QRu2RCjr23elD7X12YlHGMJxwFI2BKeYFVGG/2c82AA7uQ6RTu8oMpwzIsGLJW
         GaEDw/jkn+qy9+w+4OlNBBjl4GKDN5PwkIfgkdF62rfbfNbCkfvEL9PSN5LuzdERUifj
         ucyy76rJspyduzquMsiCNUuox4XtPHh3oYUuCehisBVjXAPSw4xRiBwx/HipvCQhA+OG
         bNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737505283; x=1738110083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1TLfeOz9Q4gtSY6IBD+sYaU477uQa7FYhohbKlqeeU=;
        b=iLDiancbknCraai1xzgE9XGsFbj094ILsQwefQs71KzF79aGzEWw/jGxcBtpNgQjOu
         tRioR2m97biQFBJVVCcf9xNqXXQLuPWB3NNmEUlRN/Yz6SMIpGKYtnVD7LsolSPn1vKm
         pQA9T70A5HUThfIuXkj+C0SM8N4uqFgwyXOE9VcKFPe7+SLaC443ukiAyo7ntIeudedM
         lMOiVdJyzvmhgdYzmMmS9s9BXTzJ0kkCJR7oQEW65jKdoS0vd9MafcthxX/g0B4Uk76L
         PquIGbA/ubLXqR7hYQmMgGbhDZFF457lO80OcwEBunmuozaGGuKY95EBBbB2Nq/CjebH
         r0EQ==
X-Gm-Message-State: AOJu0YznuRdk9DV3nSjnN6qz1AOF6i8aQUq7SQh18ceOUGtP8hEtaJMs
	axNIGut2DUFKu94nvLpYO8lhI8csFCr7CT2iGu6j14WgY84ZxULrBVB1VXi/B69qbJ87PtQnEAC
	jDTyGLnZObPhYF/QpZw+CXtJ/PCE5KAaJ6CybsVjRtls9vFsszRTp5VDBSGcZ5Tg=
X-Gm-Gg: ASbGnctEtddj0qSrFmz41NDYAGM6CcBMnqXzt924RE281j3vVfMb91lAQ8FJPjIlDSn
	DTMheWGvhEwgsnNJ6A2vRiOJqJJWIccUCOtaXVFTkxcw7xNf2DOUT+aj9wmx6hFWuwOoo8clXyg
	WjeQB9DQbNTDF0Cjc2tHy2d79UQFaBMeThQVNn6Nawbm7itMatM0LT6zOG6x85XXfOeDvYki+8b
	oipfVAT5rEXrejuqurLUzHsQXGYJYxZ0z8yXM+gEg/OhB9yIf1DvP1TkiNuelccFsnxHSWTmgP2
	ks7evi2FwXDLg+UQr0VEGUjzxYkKPf8k+HwuWMWnh3gdVG3fMCefEw==
X-Received: by 2002:a05:6a20:7f89:b0:1e0:dc34:2e7d with SMTP id adf61e73a8af0-1eb214650camr28305978637.5.1737505283641;
        Tue, 21 Jan 2025 16:21:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMk4BHzoOUBtE5QE8ZHEBytolUrs3TXUxb7D2pbR8ua6hwu/NV+x2bdDU+hUiQJm1/xA/0BQ==
X-Received: by 2002:a05:6a20:7f89:b0:1e0:dc34:2e7d with SMTP id adf61e73a8af0-1eb214650camr28305951637.5.1737505283357;
        Tue, 21 Jan 2025 16:21:23 -0800 (PST)
Received: from localhost (103.131.189.35.bc.googleusercontent.com. [35.189.131.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba5340asm9637484b3a.150.2025.01.21.16.21.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jan 2025 16:21:22 -0800 (PST)
Date: Wed, 22 Jan 2025 09:21:10 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 034/127] drivers/block/zram/zram_drv.c: do not keep
 dangling zcomp pointer after zram reset
Message-ID: <Z5A59tcFS22YMZAt@atmark-techno.com>
References: <20250121174529.674452028@linuxfoundation.org>
 <20250121174530.999716773@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250121174530.999716773@linuxfoundation.org>

Greg Kroah-Hartman wrote on Tue, Jan 21, 2025 at 06:51:46PM +0100:
> 5.15-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> commit 6d2453c3dbc5f70eafc1c866289a90a1fc57ce18 upstream.
>
> We do all reset operations under write lock, so we don't need to save

This branch does not have said write lock, please either also pick
6f1637795f28 ("zram: fix race between zram_reset_device() and
disksize_store()") or drop the 3 zram patches from 5.15
(see https://lore.kernel.org/all/Z4YUmMI5e2yPmzHl@atmark-techno.com/T/#u ;
sorry I didn't follow up more thoroughly. As said there, I believe that
with the extra patch this backport is now sound, but given this isn't a
security fix my opinion is that this was too complex of a backport for
an uninvolved party like me to do)

Thank you either way,
-- 
Dominique

