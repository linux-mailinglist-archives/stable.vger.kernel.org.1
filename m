Return-Path: <stable+bounces-146141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09046AC183B
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 01:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD98E506BE7
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 23:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71A6186295;
	Thu, 22 May 2025 23:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7LcJiQy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC0E2609D4
	for <stable@vger.kernel.org>; Thu, 22 May 2025 23:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747957887; cv=none; b=VW479OxOBFEilTrfmN1/CKVUb0giYB6pC/DYdUPjocifrCBkvMjpqAwdoUUMEB1OS7AS4686J687dT5mUop0xp/T/zKnVw3DuUs2VWHffGjQSk/TDUsKvJ0A0jHLBXkohiCV8gw+Tc9E2/rfdR6sqBv/W1vJyfeJDf9M1BfV/jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747957887; c=relaxed/simple;
	bh=sgyFFJAnCJUBGKmWU1InDGZENXuXQ+nwvmLUPLlqVOY=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=DUFXEbq0Q1gCZjzRYLznfVkbsc/2SGbalFPHM7S5KBFZESyu4nkdtJ01yw5q1ldp/eB8z0qeWwDP/MbzmhMakvqIvEJpagulSNsWyD3q4ph/ZFK2j+lEdyQtneQpA0Rus85mnOROJMrONOH08oszYKC3SmNQ0l5ufzT9IkFwwlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7LcJiQy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43edb40f357so72152995e9.0
        for <stable@vger.kernel.org>; Thu, 22 May 2025 16:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747957884; x=1748562684; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:subject:cc:to:from:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JdSGGP4i8x9bilkIzdRnc9XdO8ilTm4tAPeTA/a9Egs=;
        b=g7LcJiQyz4p/13oaZI0cC9nsknGESOLlppatpqfABabnYHVNmwfN9Nu+1E7ea/3NLM
         /WtitQvhAIGfJtjyj+NrNZY/8nm2rNuCJZ9z58HOVO6Fzv1+uovkNlMs1XDn2BLj3t/y
         vvhGE+XqNdW3HEDeA0Lhx6SfjcB1A/daYEeMtz/VH0EqREbB18US13M/6c3fq7HLTgY8
         q/COulW7yH+mPDNEiM7J9nKxaEmUHnXTCVyYj9TrTLpWwcxFkz+0HID9ZQdsR+fE97wf
         qGq8bX4PCGeKyIwFyfckgMb4ZeKBUxv35zFiyCLYq4QaRnEyUgkSAMaEAaB3jBOdEgC0
         UjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747957884; x=1748562684;
        h=content-disposition:mime-version:reply-to:subject:cc:to:from:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JdSGGP4i8x9bilkIzdRnc9XdO8ilTm4tAPeTA/a9Egs=;
        b=U1GdKJhaN+K0AHYET5a9DSAY25KTPAwrW2nZJi71ZcBwb3NVIO1Jc95CP6Vc6xgjs7
         jOa28Oirt/2NjF73fsq43let0Kv3pSYEm++M+KW3p3+ehySgXVXDI2Y1Lv88A9SB5ol7
         1X7nlO+jcL0603LeM3AEIilY7ot9eAc0gI7D/XBXo28uLXTkhlbJ/Uxc3qDxcAE5KU0A
         qlpDx3uovNunRLu14qOUxFDpMcsd9iDW6ADqPMX9i/4U3NUDbA5jk4YwzRklw9YOfpiz
         Sv45oUhAZSkzIqb6oj/6GmU55QiTOfy3Bd3cAXMtBQ7JZS5u9Kj0M2xab24/v6eaz5Mf
         XwBQ==
X-Gm-Message-State: AOJu0YzyJYiISVeTW75wj2fo6hbDkXHKsA4igW2XIP38VSwc2vxLmCU7
	c6BYUHRN2b/yivRbTvdaitMaW70SbcckWdLKrCtcxOrq/u0Z9dm8qFPcEN0bIeoA
X-Gm-Gg: ASbGnctRqQ3VfpWXCvbeCWgb44s1vC/wN7Pvh6eHE9VeBwl+3JIPBblAaoUlwH5DVEu
	FeaUfneiVajZohx6CXQG2oIYR0/RkIyROzARxtk6Tl4kzbHh6YNpf+2mi6on4I/HkY/1+AFV4ZP
	vPHBGQdpm3+sJRmHoc+2FMKgbYmDIay7jl0XwrUj3CYZCFfhT6fpXxb9MRr+QNAESI3mZ93oKCB
	SuyXlZy8mZxG5V8X+6q3BYaHrQKEh6ommCVe3kRzVAfX2QQqjgM0Rz1iLs7nAe4jCH33bSfYbax
	nSdZc0GLGReOmZFcd3q2MRRXtchuvmVppwsvrpAsyPU6eW7roY47WHE=
X-Google-Smtp-Source: AGHT+IEfgibsCry+xPlNkoNT5afdLC9QRPTzl5aygSpWu90xdX49V0evjNDGo+MZuY+kRtIR6a99wg==
X-Received: by 2002:a05:600c:4f42:b0:442:dc75:5625 with SMTP id 5b1f17b1804b1-442fd60cb7bmr245173185e9.5.1747957883857;
        Thu, 22 May 2025 16:51:23 -0700 (PDT)
Received: from akanner-r14. ([5.151.48.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ebdc362fsm243071505e9.1.2025.05.22.16.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 16:51:23 -0700 (PDT)
Message-ID: <682fb87b.050a0220.33d4e6.76e3@mx.google.com>
X-Google-Original-Message-ID: <aC+4ePTiiGBxzuJq@akanner-r14.>
Date: Fri, 23 May 2025 00:51:20 +0100
From: Andrew Kanner <andrew.kanner@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev, Li Nan <linan122@huawei.com>,
	Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 005/568] md: fix deadlock between mddev_suspend and
 flush bio
Reply-To: 20240730151640.019989388@linuxfoundation.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> [...]
>
> Additionally, the only difference between fixing the issue and before is
> that there is no return error handling of make_request(). But after
> previous patch cleaned md_write_start(), make_requst() only return error
> in raid5_make_request() by dm-raid, see commit 41425f96d7aa ("dm-raid456,
> md/raid456: fix a deadlock for dm-raid456 while io concurrent with
> reshape)". Since dm always splits data and flush operation into two
> separate io, io size of flush submitted by dm always is 0, make_request()
> will not be called in md_submit_flush_data(). To prevent future
> modifications from introducing issues, add WARN_ON to ensure
> make_request() no error is returned in this context.
>
> [...]
> @@ -560,8 +552,20 @@ static void md_submit_flush_data(struct work_struct *ws)
>  		bio_endio(bio);
>  	} else {
>  		bio->bi_opf &= ~REQ_PREFLUSH;
> -		md_handle_request(mddev, bio);
> +
> +		/*
> +		 * make_requst() will never return error here, it only
> +		 * returns error in raid5_make_request() by dm-raid.
> +		 * Since dm always splits data and flush operation into
> +		 * two separate io, io size of flush submitted by dm
> +		 * always is 0, make_request() will not be called here.
> +		 */
> +		if (WARN_ON_ONCE(!mddev->pers->make_request(mddev, bio)))
> +			bio_io_error(bio);;
>  	}

Hello,

It looks we can hit this WARN_ON_ONCE() after which rootfs is
switching to read-only:

May 20 15:13:35 hostname kernel: WARNING: CPU: 35 PID: 1517323 at drivers/md/md.c:621 md_submit_flush_data+0x9b/0xe0
...
May 20 15:13:35 hostname kernel: XFS (md125): log I/O error -5
May 20 15:13:35 hostname kernel: XFS (md125): Filesystem has been shut down due to log error (0x2).
May 20 15:13:35 hostname kernel: XFS (md125): Please unmount the filesystem and rectify the problem(s).

Can you double check if the following regression is actual?

Since both stable/linux-6.1.y and stable/linux-6.6.y branches don't
have b75197e86e6d ("md: Remove flush handling") there is a minor issue
with this backport.

Statement "previous patch cleaned md_write_start(), make_requst() only
return error in raid5_make_request() by dm-raid" will not work for
both branches since 03e792eaf18e ("md: change the return value type of
md_write_start to void") was not backported.

So we should either backport it, or do error handling, not the
WARN_ON_ONCE().

-- 
Andrew Kanner

