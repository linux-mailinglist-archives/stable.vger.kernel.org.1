Return-Path: <stable+bounces-132358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C96A872F3
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 19:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B635B18957EE
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 17:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748461F1519;
	Sun, 13 Apr 2025 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vo9Fzgl5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E391F152F
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744564994; cv=none; b=oB6JTPZdmBtC4XEI+Oi8zHvZoYE4VvYdYFkC1EjgkdbwSkfjIUGhv56U3XFZm8cqyK19RkLm5TK64NozQy5brRGIUMxT4sKXptjTQRL4BHttpurpXMNgxU+24AjFwEhIcPO2VextXrM9ZRH9Ai2/HuOxNS/BRpvfGGw/xtrsvzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744564994; c=relaxed/simple;
	bh=CBkf/SsIk1He736WuWLvwNyLT9Ph1WZ5dUuCMW0yBQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKEZ9x/fj/q+jzaSkdZt5a0OgtiwyNsitiVgk/uba3joI8Sxy8mk/jXhTEm6zjplnk6BAXdfKHK5b1673640do26UBDsQjqpMG2gRCfeeTsCNqQsjYzA+rTRXTCaLAMXKi8LTSv9lRJotU7jizl/h0tMtHnRfz0zoyPkAmrLQ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vo9Fzgl5; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff6ce72844so702272a91.2
        for <stable@vger.kernel.org>; Sun, 13 Apr 2025 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744564992; x=1745169792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LImAsG8GVnWf5TjKw58qDfeNbmj9PrwsXH7yjfjGzgs=;
        b=Vo9Fzgl5qNyNSLWk6hvMpe7tU0Pr9UqRiXjt+Q1lN3FiPH0Lv+zobBR6KlgqcUkYSM
         Z8PDwtJziDED2UxCJ0ScedjlmKmwEPwlaEtl2ckqsb0/FibNIOTMKOCdvetIIFT7ozG7
         G6ds8p+4YW+1GDwt7lNeNj0V4Zcth1zaKUDsnCl5KM5qkkZeNFmfChs2nNratCWzO0uq
         ZVTNO7mi8eicQApSNhU0NfaNgVeRdq/VDMgSOb0sl8CLkcHdmnqYLrMH07jVbuCf8R4Z
         51kNn8gIZ/XKg1/hrQBCWfwnPvD5AMQqelje6aUyIrTTFLIUevcfWDuE+Z5+QoDhCC0E
         CEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744564992; x=1745169792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LImAsG8GVnWf5TjKw58qDfeNbmj9PrwsXH7yjfjGzgs=;
        b=jteNy9kQ3BAKHQIIxZwg0aZSblLzRMrSSaBk6YAYZ2ynZQzC5AEe0l04c8ydMJmUJw
         uGPtaiIE6yrvDKVh+9uPlOH762hfzBbHe7mAcLbkHRgjfRk00i1IBVOZEJUHVTnpjS3k
         d4K7r4fjf0f96tKszuSV8zMSk2WE/mCvYWLwKy5+CzSLh84UuxwLZgaPr2fnuCyu2GBj
         8FcsErmGwhtRON99SxFsoTgxV+74l263CslMUBJmQaOHhgapx9fVsPRNDOdilQ8p/pna
         /T0cR0EnxIr4gys9MbAC8aA31gaDyLtA3RLPIScrtM9u6X5xDLwtELkEXFu8tK3B0p0j
         SSqg==
X-Gm-Message-State: AOJu0Ywxou4jgwF7+JcWmtUCo2N2m1eQ1RFNYRSvWwnQK3WYvu4IHCgY
	ZnSXGxySKyC7gpWYz9Dz1cFcgzCZyI9U8fruPnADUTjAYzSD8Z56Ijv947kAPH8HXilrLbp3LHo
	07HstZee7rgrVWVGr+vTD6d0J8YD1tlB+
X-Gm-Gg: ASbGncsaAWkjMeMxAwmK+u9kzHVAi8o/lEvapRRoge67lRz9ZqTgC6uGsRoMk0Q7OAx
	MP+JPB6rgQ6rSa74A2SYhyePu7zW6GRP2INKuBFvcS3kwYWftOzaKf1umIdBoAMXNmzLZVHEwt8
	O79JQ9y49Oy9zgRBz+AVm2og==
X-Google-Smtp-Source: AGHT+IHNt+9Q363HAH+dHg0NIJrNGIDVQYU71Ois0EZCcV2gAubXpxsIGDdhHOjeS+i/31ZL05uACcv69fwf8+q6I5s=
X-Received: by 2002:a17:90b:390e:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-308273f3592mr4767554a91.5.1744564992071; Sun, 13 Apr 2025
 10:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250413002338.1741593-1-ojeda@kernel.org> <20250413131421-3e7c4d5c868c4f09@stable.kernel.org>
In-Reply-To: <20250413131421-3e7c4d5c868c4f09@stable.kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 13 Apr 2025 19:22:59 +0200
X-Gm-Features: ATxdqUFAREv5COnTxtMeXZ9MagvSqautK0adz_M6rPkTTvqFPUwM1KaHaYvqZeU
Message-ID: <CANiq72kZ+d07g+3soOKsq9ipqDxBxvnHOWjhiKqmzp7xP=E=mw@mail.gmail.com>
Subject: Re: [PATCH] objtool/rust: add one more `noreturn` Rust function
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 13, 2025 at 7:18=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> 1:  cee6f9a9c87b6 < -:  ------------- objtool/rust: add one more `noretur=
n` Rust function
> -:  ------------- > 1:  a6ee72c789bbc objtool/rust: add one more `noretur=
n` Rust function

I guess this is due to the same title -- the patch is a new one.
Sorry, I guess I should have changed the title a bit. When I apply it
I can do so.

Cheers,
Miguel

