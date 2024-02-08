Return-Path: <stable+bounces-19314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7394B84E7AA
	for <lists+stable@lfdr.de>; Thu,  8 Feb 2024 19:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267D31F29ECE
	for <lists+stable@lfdr.de>; Thu,  8 Feb 2024 18:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAADB82D6E;
	Thu,  8 Feb 2024 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR95mYyU"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F67485C64
	for <stable@vger.kernel.org>; Thu,  8 Feb 2024 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707416966; cv=none; b=pH/AEA9eKrrmkcaY7TrrHKzGtci7GjD5JrwNS3f5b/DiraEgxD5h6wytdmCdC2N1o/1AtOmlcemS43sCHAfeCFHjZNi9tZ/QXQ61l2ZS97YSujZc4aRPXmq5EeXq7aghOaAXqzdkhRN/4hMDJjsf6G4MaSmyj8KujhW6d8zTzsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707416966; c=relaxed/simple;
	bh=Fv0F2x1ccnL/h54u9c/hzmdC2sbZec2/MvRlTLuViGI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=b2o4rwHUCA2YVH7Q0hS3Nr+nnHHsR5q+X6kFhnQzyryVz07kYJbemw8PcAeshKMsVvV1ByqsFAC6evgdEnAIsHFcR3ab9e9R9rdQEAkHwUQOGfM7JXNpn9ZSYuac27uO9YMmSNdob3jhFP6fmMSYeln4Lt1lWUxncv7TyPSv4Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KR95mYyU; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-604b4eed8fbso2185637b3.3
        for <stable@vger.kernel.org>; Thu, 08 Feb 2024 10:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707416964; x=1708021764; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RAdz/EouUTEdV0oyJYb+E6rIJqnd9ObxkVIYyDylvzQ=;
        b=KR95mYyU1rMlrflP8ATRV+tgrmIj2t2rgaez50ggpumxl5yov/VY4yHYE5l26wHq21
         PEe3Aroj06k3JxYJY5NzZ+FnQYMAVBPtGyTy1CXnMF2ciMn98t3p6cZOh2ELF6cySV3A
         IsmxJmgTELNjBIXPrQqfhtWzFwgMakih9BXfmZ+czOYjQp6wS4Ysa6jkN8OMxrvPqlG2
         enBkC9g6KSA3RyPOAJtW3bJf8WH8LuJ8FcS/1bGrPers8BjHh+Xh0It9UxAzGhJvf2Bq
         y6pSjAi5IRGLaxOahtckB9B4Db05LjxmivfLciMh/WQSqMhXWUS/fgABgxDZqIF/PY5+
         wQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707416964; x=1708021764;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RAdz/EouUTEdV0oyJYb+E6rIJqnd9ObxkVIYyDylvzQ=;
        b=bNBDHQBj+oEoQZ4sBac9NbNIPJEJtpmTVm3dJ3xpCqJgq1ReoUf3osRpNlYFJriAx7
         hQQ0P7l/gv2KmDp6WaKH4gOrzbbV5byyXk+C12HbOuFFb/bOfFBQHGrtKC2NSij7Qn0I
         gx1L3sRzJ5dgqqyiuKXs4sAxQ9V/b3xvtAdE91VFOPIqDL/fxXlJyS+kL/to4YtsPjYt
         xaT5oSIKmd/pxt3V05qsy6kliAcRDaaqcsaHrY3qNRR4hI+ZeomaBQ6DmcZguuLBz8qM
         eTrhA6oq2TW8bqfVXZO2JtqlIBydIV7vFs3435OdsIqg3+wHB6VMrnWE3hAujO2sBFGf
         7yng==
X-Gm-Message-State: AOJu0Yz6QDgfq/yrTMCi0CpeNfs6zsVzGe+r42f8xsL6rpHU5eI/tFOJ
	ZkZ35g6jyzPPaX2MI+S45D4/v6qePuShgbMxquMzdQK0gekjIRAxbgLMycJkqHRmIKyAfaFGYLg
	Ie2Mfay40SnDas/iaAee0gTjLQA4=
X-Google-Smtp-Source: AGHT+IHQqfJVyMjlPx6B2u1W97ki8XYkXUAgdN4jPc8awQ2ywO+SV5URQSthFBuW48Y4ahdCQ+bkT1lBQkF+husERqc=
X-Received: by 2002:a81:47d5:0:b0:5fb:9715:eaaf with SMTP id
 u204-20020a8147d5000000b005fb9715eaafmr198077ywa.33.1707416964072; Thu, 08
 Feb 2024 10:29:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 8 Feb 2024 19:29:13 +0100
Message-ID: <CANiq72mVfUT6VGcDqKGEEwNZo97pKq1roPMMk4qBvuq2tizwrQ@mail.gmail.com>
Subject: Apply e08ff622c91a to 6.6.y
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg, Sasha,

Please consider applying commit e08ff622c91a to 6.6.y. It requires the
following chain:

    828176d037e2 ("rust: arc: add explicit `drop()` around `Box::from_raw()`")
    ae6df65dabc3 ("rust: upgrade to Rust 1.72.1")
    c61bcc278b19 ("rust: task: remove redundant explicit link")
    a53d8cdd5a0a ("rust: print: use explicit link in documentation")
    e08ff622c91a ("rust: upgrade to Rust 1.73.0")

which applies cleanly to 6.6.y. This upgrades the Rust compiler
version from 1.71.1 to 1.73.0 (2 version upgrades + 3 prerequisites
for the upgrades), fixing a couple issues with the Rust compiler
version currently used in 6.6.y. In particular:

  - A build error with `CONFIG_RUST_DEBUG_ASSERTIONS` enabled
(`.eh_frame` section unexpected generation). This is solved applying
up to ae6df65dabc3.

  - A developer-only Make target error (building `.rsi` single-target
files, i.e. the equivalent to requesting a preprocessed file in C).
This is solved applying all of them.

Thanks!

Cheers,
Miguel

