Return-Path: <stable+bounces-118657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6B0A40963
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 16:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5AE47A943B
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 15:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E21C15DBBA;
	Sat, 22 Feb 2025 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEIZtKsD"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6D42CCDB
	for <stable@vger.kernel.org>; Sat, 22 Feb 2025 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740237195; cv=none; b=FgIj6Xgrto/r+dUe68CS4x/0Wbu0sgRi7UwVZD+fkCXny5JsZY2VWStGdndSRC5WPwEYw9m+n4tKuUyNl+rWwMbGgND4C0yTTXgswkKMhtnHaoXs5+RUPnMd800kJb3eg+g4utZHvjl+DL7LwQzvhkFxJXTDznlGgNBMTvLxlJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740237195; c=relaxed/simple;
	bh=q0vxeV5l6blS+8eyd6OawzU48tHTPe+kcG+4KZuOjJo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=or7pMYg3RSBLqocYxlVAT9dFXZzEqM5/KnshV3G09tH88IEYMDHUsuCy9Id/luY6wNeSeplifQ3zrElhfjYTCD34V9KMKUrY2SQi/Y1s1DWUesogAuPy8KesAvzhvfEZmQZJGNpVHetP4sBldX5njmr4mPH2EPuy3pWHjqujn/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEIZtKsD; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-545306588easo445642e87.1
        for <stable@vger.kernel.org>; Sat, 22 Feb 2025 07:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740237192; x=1740841992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KJZVNsSbuslb0JtD8p7VvgpM/kT0Terhvfag+ESqtVI=;
        b=cEIZtKsDX9K3fo78Ejm8q8GetrdxiMcXjYHSwrYNF6pCMJkWFdS5/mC2ihsh6bCIXD
         Z0PEmJ7mdYba0wjyEAq6qAwoUt7h/hUgJpIqz+pttcbG3fLdap5f5kj8+Pcg6WtWP+kG
         WZ/2CC8QFkHiUXj8aiV++9eU47KaC3iQd4TOKO/3Zr9E4c05rtBmYWwGdadWeh7pacKh
         Fm7v1ijb9AJ/NJJz/WSK/P6G5pTwqGgiUjfS//lxzXwreHHapZwrHbqNCHzR8VKGNR3l
         OZBWrRJWk5U5oZgRjUbhvZeCdrBE2O3pmBhu/RDsxYaicTsRCDCyk8OxzX74U8j7VVFZ
         XETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740237192; x=1740841992;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KJZVNsSbuslb0JtD8p7VvgpM/kT0Terhvfag+ESqtVI=;
        b=oQv+LD8MoUnMtfmp5ufda5at2htTroqATL72wr88TZUg8YRnF9LM3W4YOtE7DyYV1Q
         LvyXhHlHQLx2KltQTWbeD8pif5aPbawC6+K+C69fBil9Xr8AQDR526EUF6ibph6n8Pgc
         rgRrnhlM1YPQQbxk/wT78/TO8yNzR0hs36V6qLx3yn13DgJdGnFReO09/aMl13Z4rfeg
         vfT4/j5FTLOsQle+t/1T+Tz1wE7WC/Cw9058LOiYtrHr+Q9/7DYuE3xK5Zf9yA3X1q8J
         mle2IaP36Zas4xZgp/5JfaL9OB4FDNddBt535s4jDON/B/Ny5bpgL5YCSmHan+DdSJwj
         9mAw==
X-Gm-Message-State: AOJu0YwXmEnVRpVI4uGTnICzMWXcw4f4PfVcrsBtvgD1A7WmWeqXSs2z
	jU5xUpITt7TMnv7unYHL9TrjQwj+N7CJVWQZP3yPBOIERiQRq+8MVA8TOHYcfG1irZ5i3VWjUgd
	Xgh2P7x0xbG0TN0teaLYEqZi6ZpU=
X-Gm-Gg: ASbGncsDZNV4DcFU+xz8OMkQivOjes+vx/zWeI5q+hpcgmQgwb4hnlSw/PZtxHBVbIC
	o7MQbmwvXu9twV6aj8BrvVnVRHgZaTnWPs6Y6lF3eUPsswM2lGXb+Swih12GM0iLJzIlZYUmxYr
	vQpWlcCm8=
X-Google-Smtp-Source: AGHT+IGTK3LWLwz46AkEZbnScY4XxyPp4DP/fr0pq84nYvltb24LHomThP785+SLwSZ3tSnwUsHmehs1PFfTyKTZ5+8=
X-Received: by 2002:a05:6512:3f19:b0:545:40f:5757 with SMTP id
 2adb3069b0e04-54838d2379fmr1197726e87.0.1740237191669; Sat, 22 Feb 2025
 07:13:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 22 Feb 2025 16:12:56 +0100
X-Gm-Features: AWEUYZm40vq9lPteq2G6mxuOv9RIL9sOl5X1jwgT5Rk3M_WbFgHFrzO-jPWqFY8
Message-ID: <CANiq72kaO+YcvaHJLRrRw1=KteApRnRM0iPuSwgFkaCf2BR01w@mail.gmail.com>
Subject: Apply 3 commits for 6.13.y
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	NoisyCoil <noisycoil@disroot.org>
Content-Type: text/plain; charset="UTF-8"

Hi Greg, Sasha,

Please consider applying the following commits for 6.13.y:

    27c7518e7f1c ("rust: finish using custom FFI integer types")
    1bae8729e50a ("rust: map `long` to `isize` and `char` to `u8`")
    9b98be76855f ("rust: cleanup unnecessary casts")

They should apply cleanly.

This backports the custom FFI integer types, which in turn solves a
build failure under `CONFIG_RUST_FW_LOADER_ABSTRACTIONS=y`.

I will have to send something similar to 6.12.y, but it requires more
commits -- I may do the `alloc` backport first we discussed the other
day.

Thanks!

Cheers,
Miguel

