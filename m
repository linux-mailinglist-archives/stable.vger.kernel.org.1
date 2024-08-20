Return-Path: <stable+bounces-69746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97418958DD8
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 20:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B585B21C5D
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 18:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15A81C0DFE;
	Tue, 20 Aug 2024 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bt4vZ6XA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CEA1B9B32
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724177692; cv=none; b=bspKNwgfftHY3StyVplOtD4rGw3EYfL6ePx5zGFhRG75D8E/uD3up6W73RgRLqOSFOF23ej0neafsF37+80MePvPM2fl4VFb7fjP3yf1uOdBYKrWMrpM8fSJtAYkCCae3BADeHdz1UpxjDrneGh9CgsxjJhnCusPEDontXleJfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724177692; c=relaxed/simple;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P5TI6QIt3/Ueos/Y7QTLDq7sJA5gDrUwkK6MS+hTFabsqG/zQGpUL/uM1AZWj3p5fcaCWpcdA5ZCXdSgdhuLO3pRf+4MSZG199tr8OJXFxs5CilznlcnpeT6iZ9HTJHPAGU4iCusMJxPBeZHYETCo8+Vv25wMNfJOVV1RTlzmrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bt4vZ6XA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42812945633so51276015e9.0
        for <stable@vger.kernel.org>; Tue, 20 Aug 2024 11:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724177689; x=1724782489; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=bt4vZ6XA+jJhcFXCrOrCXm5r52wPMFyclEtqj3BG5+HlCmVixzrK/YJWFlSKGIX9X+
         /8zMFvNEnoCbrQfV7pgUKc1Fa0SfbMLaklOGFfzu+D55LxoP93D9Uc5jPFkiAUd7r3rQ
         dCtoVGiNh3WP1hGdgrp8kFRrJLNgJYEJL2ZYNnli8t2xI1Ww0aYHW7IppFRt/C22TAq8
         XQbIX7meTJm5Yb7kY9QDXq4bmpOL4m2qSLVZ03l/N4Yx+AwV6M9TqWBKu258yQg8Ji1i
         4tuJn5E4/sGgtlgaBnwUy6utL+z5illC67YoFbM7E3k1rJdmRfsxd9Q4GOnjDc7p3Kd0
         +FPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724177689; x=1724782489;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=gjfVzQBTQphD5tJ11jZBm2aYtUiEWj4sJ1LAMvnB3GfIT4fNkDEbbB3KS7V+Nq8crX
         UBvlcpQrALdVMJlaLQiXaUlbNK6oMFWqdyX1r8IAnPku1AmdYjxlZBRwlwi6sD6CcuVw
         6pmAPohvRvdFVeuyucgPK0wz8VNFcVT7brikECYjF75/jguam6OQB4XgdO3AlZYt+D10
         aPDmlXALPLWaHr8+IayseAcFVljgrJGK/20IwjH98oLYci85hXAJlqTdeQX+e9F5TR6i
         SkA8S/dFs1KNw4VGoa+EBcniwPKwfUyTmpAtE9PGUojgejqehGMqYFZsXOafhWC0CzH6
         RJEA==
X-Forwarded-Encrypted: i=1; AJvYcCXB5dK3HOYI3WWN0k9H/sXVtCqBb+SChZxGgfKxKDp3aByC1jvabl99p97LgRphIxdwJWjFLir7TS2S52167PgugIxlT7t9
X-Gm-Message-State: AOJu0Yy9TxC/96YSz7B3+cdX3ylL8HrDJlGwg6qYEZAYy1F5bWZODySv
	uMbo1SVdSVlbrf/5Og62rJ99JLNKz0lWtEne4UwzbgmVbQi7Ds3V6dS8JCxCEUZnPRgTj4cz6kV
	Meovj7NfIV6OhHIVBGTH2At9IjSzylTEoM6+U
X-Google-Smtp-Source: AGHT+IHmbKSFe4B1/1TnoT1W3TvVcJzc2fL1GZV//LexmxlmcbOZiG/FdzVIHlK0+AXA6ItiI5sA+LO8mRK53OYMBOE=
X-Received: by 2002:adf:a2da:0:b0:371:8e8b:39d4 with SMTP id
 ffacd0b85a97d-3719464cd9dmr10782209f8f.28.1724177688981; Tue, 20 Aug 2024
 11:14:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f7b96e062018c6e3@google.com> <20240820085619.1375963-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240820085619.1375963-1-hsiangkao@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Tue, 20 Aug 2024 11:14:37 -0700
Message-ID: <CAB=BE-RDih_Ng0cCCHgmQ8+29yj+kKHZheyoLKEDEnPC=tJjhg@mail.gmail.com>
Subject: Re: [PATCH RESEND] erofs: fix out-of-bound access when
 z_erofs_gbuf_growsize() partially fails
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, 
	syzbot+242ee56aaa9585553766@syzkaller.appspotmail.com, 
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
	Chunhai Guo <guochunhai@vivo.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.

