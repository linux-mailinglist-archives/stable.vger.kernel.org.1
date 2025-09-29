Return-Path: <stable+bounces-181858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862FFBA7F03
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 06:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25051175049
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 04:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB97B217F56;
	Mon, 29 Sep 2025 04:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqsbDU7J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C77207A20
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 04:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759120187; cv=none; b=UkkSCjPx1yxfCDtzlDtJlMWpAog8yP1LF7ZEkNyjdDegrYXJOygtWosVuyBzTsXIA1ZFhY0HOAExvdx0ARKyrImi6KL7yi8AuwQOZW9CGGZ2xfEHAQKr5kZ5POoFeu2qUHt0IlFtQi38JhTMAxZ/XViXQFk7BcOkX8cdIU89q6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759120187; c=relaxed/simple;
	bh=kFFSC5GoahdKu3K5krXPBvbtnivbS0rpNq4dNHOhin0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hl0IzwkNLixHVSSzZF+IoRAQ/XR8XS9/UcsRe0Ev1X0rTCijf3P831EEDX3F3Mny/Uk/6a7z89t422+bAWIHCZddu87Hgcmd1ycX4NEcQ2uA7BXIf0ZTJmNc2FvCmdeItAyqSKEZS4lo4qhXtZHLW+Od/MVRDcUO8nNbOGHdygs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqsbDU7J; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-27a6c3f482dso32884055ad.1
        for <stable@vger.kernel.org>; Sun, 28 Sep 2025 21:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759120185; x=1759724985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vkxef2+AVsU71z+fKIaM1uDBUG0P/Nu5z5dA8sCM2tI=;
        b=DqsbDU7JR37QrAVxJA1dcv6dKaR8ldqfsx8tljSejWwZUQR447SFuzTJd4zsEK3wDt
         CNn8umjd9i8qXq6hzfl6Ztis5Sfm+rInnbLDWk67iPEXxYV4RULvWfEnQjq/eYjjgNZ2
         jX0AuLvILkawOhxZNl+ZDdhBeNMMrmKUQkk7tAonBBbbkTEhFkpXCdpUSi1yVZxl3nm2
         KXJ23THbvcgqukn2Yqq1apNcYElwiewfu+JZ3bwtfLXcF5QXSu/fz24gH/GdTbqRJvph
         mYtRX3SOBkU+GKiRZOvVRoxXeEuuigHuEbZWmnj/EFmbTIvJvuu04MO8Nt0cGzBg9JW5
         vfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759120185; x=1759724985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vkxef2+AVsU71z+fKIaM1uDBUG0P/Nu5z5dA8sCM2tI=;
        b=YM+idl5kG+KU1aJpp7SgoLD0UXsJPimxb7zUhaTqvb6pyhi3eWU9cOiKxAI87LkLDy
         3Cw2iULwKZ46iCdddmyXqOB/sy0qElH8jpFRjdi3qdwAVac2S+maS973hbWbVUrDfF3+
         Cdok4luLYWLkQjpQFHJDPOoyh60ruSyFZx7UfPZNtZXWSnL3gSIBs+Jfz0JUsvHpDUHa
         mg/98DTjxnVvU5xopPDSH8fWq6EjuGOQaStBY/t88uFEwzXIybU6aNt2vmYk3sOFxKO4
         dvqx5j36tn1b93D/yuKoMbGzTF6JXcjlraIj3OE0k3jfppGuytyPOg1MJca2ePmjbCJJ
         FHaw==
X-Forwarded-Encrypted: i=1; AJvYcCWexeSw5n+5TL9dnT+RbIm5qUrvgeNF6CIL4gYjCuoEZVWSEUnzq8W8VpDVjO1UE6ic4ZyWKI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7SWEQd4gf412fj2jOrnkCuqjMiVFP6Gszg/6YQyySx6LlOB7f
	WiuRer+5ZlYA5cw9JKAeOSgPdJEyZ/OIZW0klZlIFXn8Py6zWVwBIbUk
X-Gm-Gg: ASbGnctbibbt6RSPT2xyP5JOwp/7YVVnd3WPz1eHxlBymYisFgB9BHE1XmpjcHtxSHr
	Nhx08fdHdghi7QTnMMJbPAu2plJtnSoAMHUW59Mvq/K8j9azXWYW8py15JuxwccTo+t3r6z8WQ9
	Sl5j0rbB+suH6HmH4Vok2PPlg01VxvdxlrLu5elps06m+cvSNCkPY0gMbp3dx3lDtKDHsZELiL9
	E7AIpE8wR5Fbj6Phf2xI1fRag6aepluY/C3++VNo9uPMWDw4a14JAowxRmtRnkXaXNBdmGsadDZ
	yzNCZ8sZqK0AR5yjboXgvl+/bwVXnM7x+ZJBowYy+93mF8UWFzTP3IaItZpm8A2iCTMOnXQZcMr
	fbnpaIr1z3Zn9cyxuraKejlhln419PIxDr2Q3LQGQDtcleGwY2bBSE/09sINpvvDnUvNTNQXw/g
	==
X-Google-Smtp-Source: AGHT+IEydysVp4VmZ+QQonnsPxkjXJAGZ9EcfAUe93S/3LB6hQ9TXXcHbMyclV7XrLOtsJIv++TsVA==
X-Received: by 2002:a17:903:13c8:b0:283:c950:a76f with SMTP id d9443c01a7336-283c96f311cmr54378465ad.43.1759120185331;
        Sun, 28 Sep 2025 21:29:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:78a6:bdf8:e03d:d9ea])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d3acfsm118376105ad.20.2025.09.28.21.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 21:29:44 -0700 (PDT)
Date: Sun, 28 Sep 2025 21:29:42 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Input: uinput - zero-initialize uinput_ff_upload_compat
 to avoid info leak
Message-ID: <2s7j3pivdcouh3ug7yzzai53egxiakscuhgalcoodsw3xnvcre@vfhdvo7xnnng>
References: <20250928063737.74590-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928063737.74590-1-zhen.ni@easystack.cn>

On Sun, Sep 28, 2025 at 02:37:37PM +0800, Zhen Ni wrote:
> Struct ff_effect_compat is embedded twice inside
> uinput_ff_upload_compat, contains internal padding. In particular, there
> is a hole after struct ff_replay to satisfy alignment requirements for
> the following union member. Without clearing the structure,
> copy_to_user() may leak stack data to userspace.
> 
> Initialize ff_up_compat to zero before filling valid fields.

Nicely spotted, thank you, applied.

-- 
Dmitry

