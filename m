Return-Path: <stable+bounces-179649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3886B58519
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 21:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94102203AEC
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 19:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6E927FB06;
	Mon, 15 Sep 2025 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NYNN3Ts/"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A68F23814D
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757963174; cv=none; b=IgcYzB8JR25/cMh5tqJ8vyGMHl6xFiu/WZRWcvbZNt3ZqLDC3UuavNveZH9z06QjjZyvBL7ctYMmYHkfP1tJYejijoXFtAwtdhre2QSnqtYroXotnZYnuomKCUa1+1X+zQNSzUFLyJ43sCtP2a+nehuviZrfuCbyihgN5S218h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757963174; c=relaxed/simple;
	bh=uG8nC9oDH61dYzrtPeYvBQoL9gSQjgCoib4sR0f3whs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YFBgKYLiSKWnYFVXAaJhZWGO00pAQRd3mGBPUYYe52oHLM/rx46k2BUG/Ed55Ov98BJDfxVJ6G60gLVQs/wx00EvzTWstHTJzzY/Ed+R04vtSl1ff8EglyWesXMCSS2KLxGwxkyJnTBwwNj91agIO+msnDIJPBlVtRVc26FoRaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NYNN3Ts/; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3fe48646d40so30597885ab.0
        for <stable@vger.kernel.org>; Mon, 15 Sep 2025 12:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757963171; x=1758567971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVh6sd5jyxq/syVYCa2EI7xp2H1Pq0+2Ah4mfKjgzlg=;
        b=NYNN3Ts/Vzg+H1ZsgdHr2dvbyL7CgJpkHNaLVB2rR70gLED2MApyLiZkQ1Ltbw6jHS
         EoqUOdyTST7bRRN75NOm4jxdcMzCAo3ZcQj0kbRLt75YPEB1EBOalaiBOrVtXYUQHMRJ
         DgFIj5uFqQtzHhY0id1xkJTsfkSATYbDFm3la/KdFrZAjJ7HpmtmSJHXbwZAjfgAxE/z
         RvepyobH9dgnxNPjFvUkfR8OijaV7esVqfUHS1HvmJsg+vLh0KuI1f6/+Ypg5T1+lZGc
         NFoJct8gdCUXkNkfjduALHsqIxQMbQrf5IRWlRgz0pw94x3xQWJD31lPZcVMeJooIAsi
         oXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757963171; x=1758567971;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVh6sd5jyxq/syVYCa2EI7xp2H1Pq0+2Ah4mfKjgzlg=;
        b=aay2/DyWfkyqgGQgoECY2f6YMv+L7WxaVml+MG+YhCfvvIR0x7q8iQmHupPZt3Cze3
         9YECmo/1iuvvSw6RsBc1urTmO02GVMIgyqS3N4QshFz5jIq2Jy4wP5xoiSEqr3wfbfYm
         wesqsZRAm+7si1UYZIPL7Zeoevvihits3xr8g2Ljz3RbaPgP2V9hl5XmQx/xKFQo1bmR
         s+TFiNHBxta3X/b3NzqZW895/c4aPRd4cLae0NIqVASvQA4twT7qbr1z30n6OuY9LObV
         dM9c9iarq2cq6JEdud8JTji5IF/RdZiafQmC5Nsc4p7eVKe+WLmIe487KTxy4V87EUWf
         F1lQ==
X-Gm-Message-State: AOJu0YxqLHqUSjYA4k3svSoWVAciOLN9eaONVOETrrnc7ep2nAHiajr7
	3wsMoCOltmk+4SA35ibbhrW8KmU5cy1D3Rzul7adaybLlUP6ZKNCwOO/E8+pwuS7j2Q=
X-Gm-Gg: ASbGnct+ug8eixnP7DWwKtVBJbZ6eRHgHwZ9o3jAxuKWgy5DV05/Af+B5Wmj6+J6wU9
	w7kkA3pDITg664gWjGRJJM9vwn95quvOcD3n0njFvQN+G3h6P/03iWb9/5FgWaC1n4q6imzmknv
	AhYNK6K1r3jAKTkuZQHwVM9MPZMOdnHL2pFZlHWVjB0UQwTBRCMcJmSfrUzePapMthrXvdboeaM
	W03SCkrXketzhoxoBgx6o4jj1CFnQv0JUOW1K6E4KzSZDMpVMs4E7vpqdttsw/G5ZTcKDt7NnFb
	ieJ+/9fqb5nAzQSDpgdYTzCwIpqJvllLM7dNmrwDshZ/mMhrbDovAL7M2ihkYNfQcS9OmoRsHQG
	IyXllSbh2E/ANhg==
X-Google-Smtp-Source: AGHT+IGcYD4IuB/wNW8MI8+e27nl+qICtx3uV3uHHdDP6AqZ/REWrrxVvvAsFfR/EjZbUXKsqyNkjA==
X-Received: by 2002:a05:6e02:4815:b0:424:657:7782 with SMTP id e9e14a558f8ab-42406577ad6mr46791835ab.7.1757963170660;
        Mon, 15 Sep 2025 12:06:10 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-41dfb240f4fsm60222675ab.43.2025.09.15.12.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 12:06:10 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Fengnan Chang <changfengnan@bytedance.com>, 
 Sasha Levin <sashal@kernel.org>, Diangang Li <lidiangang@bytedance.com>, 
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Max Kellermann <max.kellermann@ionos.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20250912000609.1429966-1-max.kellermann@ionos.com>
References: <20250912000609.1429966-1-max.kellermann@ionos.com>
Subject: Re: [PATCH] io_uring/io-wq: fix `max_workers` breakage and
 `nr_workers` underflow
Message-Id: <175796316976.265356.16431775523856266594.b4-ty@kernel.dk>
Date: Mon, 15 Sep 2025 13:06:09 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 12 Sep 2025 02:06:09 +0200, Max Kellermann wrote:
> Commit 88e6c42e40de ("io_uring/io-wq: add check free worker before
> create new worker") reused the variable `do_create` for something
> else, abusing it for the free worker check.
> 
> This caused the value to effectively always be `true` at the time
> `nr_workers < max_workers` was checked, but it should really be
> `false`.  This means the `max_workers` setting was ignored, and worse:
> if the limit had already been reached, incrementing `nr_workers` was
> skipped even though another worker would be created.
> 
> [...]

Applied, thanks!

[1/1] io_uring/io-wq: fix `max_workers` breakage and `nr_workers` underflow
      (no commit info)

Best regards,
-- 
Jens Axboe




