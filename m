Return-Path: <stable+bounces-41660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 258328B5683
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B932D1F21CA3
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E85944C60;
	Mon, 29 Apr 2024 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5Yt5+o3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA623FE28
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390016; cv=none; b=hphxnxb8soaTfR7hyxB5OIZNS6ZYA2F9lxbohFxgDiO/PkGZU8Nh/h3QkZ7ZhO51qiyYbwOcipnP5m0dXyIF+bvrZU8YcW91fqDV/tiq4tF910xSHjwg+I97c0D05CFmXfm+wXwNXI6gAk04MMBT7bSrBqZtWUlXODeQ/q0Ysdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390016; c=relaxed/simple;
	bh=+Uwz0MxQZNzbokQ2el4xPehPAStf8Z19ctV2eYB6qjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0yN6mLGWV1wPsFsJy8lpyX95EhVEMQ4yNjSKeP0/HUcF9PvAAqSz/P4PmmIj0OStf01A9tIAwg66yyaXWIjfNpEBHVx0qFzcWCeLY98Ms/YuHCBkTp8aeOOAaCqgI7LmgXN/4fEWITrbD5phxHnyblacWtiWOz+NPrARaSazL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5Yt5+o3; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so3033219a12.0
        for <stable@vger.kernel.org>; Mon, 29 Apr 2024 04:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714390014; x=1714994814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Uwz0MxQZNzbokQ2el4xPehPAStf8Z19ctV2eYB6qjM=;
        b=C5Yt5+o3Rl2iOxhBqkn3wX54mYlLw7z1B8NdotKJ56p7fZ6eESlCoVVQt7W2P7BGaT
         C4MuG2ymvhA76NIUYhwi02jMFliSte4N1a8OeLj6lhq2BxD/mtTjCt2RekBYjpE6FjV0
         HTh/O+4u5Nikp664R6qaFrMbKeYFOu5INudva/uP7tu8cYDiylwvw4AgBfHdyf1W/jxC
         4z7yMVupU2EGX4QXw5bui4ZrKhrbXNvCZIFKUTNWVL50JsqeehFLsRH/oiTDCJmSV/V4
         6HiB4ABhf9qMhyv9oCehSW8pxQssWcgDwsMBNeJwn6kHZiLsr235tWlfzFir9wSR9tDE
         7DtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714390014; x=1714994814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Uwz0MxQZNzbokQ2el4xPehPAStf8Z19ctV2eYB6qjM=;
        b=lC+zGho9TO5zsQZM4WvXesgBR+DABnHoVHBdY4G360kU546LOuUHuCkaVJ+z5XmWpx
         ruanRPSXdxm2pF5HIRRo1ZkcpQHhiacODSpAuGCy8YdkXaL2iBEuuBEbvJxgEADV/aSZ
         r0Mj0qmLPuOH3OLaEnwN73EtNhwSXiR7foT0fPLTaPuhWY8eS6/UZAjAnCvybwU9dWY1
         GivUsQXkBUNnR/O1kS57b5PsZrLpMMIwAzh/mMSFQAS0xEB92xhO/W0r6w6uTkULh2E4
         Gl+ie/zXV6D72q4NbLpN4hNTMnLbZG/lwIX5LRQZ6JVb2vpr31C+LE1x8xZYxcSh2Qbo
         w4ng==
X-Forwarded-Encrypted: i=1; AJvYcCXboNEsrOZaSfhamH9sCBolY8N0r5mJUeAzOeq3uk8OvemN8pbqIeUrDa+axj3SLB5XeKtvg53Ty02frQXD7ObhT/XWuG/I
X-Gm-Message-State: AOJu0YyU4QA5vCyQbWUu1CXOkbR2RyQlhP45M8AKZ+lEUinlfsRMOrtE
	Ybsg5SHb3ra/M5Pxqp2XLJls+Qbt74VW8lCq4v+pWaKkIOk/GKhqG3R7d3aYomXx2/P4frAn/Wq
	NOswESyzAjaBJrQvYvxoK3YfMZMs=
X-Google-Smtp-Source: AGHT+IGxGXtmfm3MRau/hjBx978SefbIg85hTvuVXadodIrv1ApeRimeXRwrW62RkiJFdDOc9AJnfeRoP8vS60hzC6U=
X-Received: by 2002:a17:90a:134c:b0:2ad:9382:35be with SMTP id
 y12-20020a17090a134c00b002ad938235bemr13391989pjf.16.1714390014152; Mon, 29
 Apr 2024 04:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024042909-whimsical-drapery-40d1@gregkh>
In-Reply-To: <2024042909-whimsical-drapery-40d1@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 29 Apr 2024 13:25:37 +0200
Message-ID: <CANiq72ndLzts-KzUv_22vHF0tYkPvROv=oG+KP2KhbCvHkn60g@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] kbuild: rust: force `alloc` extern to
 allow "empty" Rust" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org
Cc: ojeda@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com, 
	gary@garyguo.net, julian.stecklina@cyberus-technology.de, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 1:21=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
> The patch below does not apply to the 6.1-stable tree.

Yeah, this one was only intended for 6.6+:

> Cc: stable@vger.kernel.org # v6.6+

Was the annotation above incorrect?

Thanks!

Cheers,
Miguel

