Return-Path: <stable+bounces-114676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB9FA2F15E
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889D91631BA
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D4E2397B9;
	Mon, 10 Feb 2025 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eljee4QS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54467239096
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200918; cv=none; b=e9MRixgY32wlWs7NCBRSK7YskYAofx/ed+dRM2f0k4/Y1n6aeMZnh/qzG56XsnHC72CTtm9PBTevllBOlW/Gx5twj9zPHHgnSEalI5i+FP9D+4seDh1yYsp7Lj4V3zhTAajnhAjIxtapPAFd0Rd0xo5+lnkHwBhdpL/XnOvBqSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200918; c=relaxed/simple;
	bh=OFIFyl9UNziHYfHCfMLm3ovfF9LUndc8t8+PJfCjQfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u8tD7qSh43nllYJRqyd4AYUkhJks6uyRt5orWr4VFEOsBEXI1YH7FF8aJ0W/sEwVNkHwMsB+GwPhnKd2HyvXacYbwg/M/b1Goy7xrbBBiqQIWZOKycsHcy+fZnesAPS7P1pggNCSDOhJRM97InqnXSR88aP+wqQxjGzXB9d4eyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eljee4QS; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so840679166b.3
        for <stable@vger.kernel.org>; Mon, 10 Feb 2025 07:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739200914; x=1739805714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qzYqa/g+GOzKxJJWedO3KzSRX87c6zCxPSEaoJJs1Jw=;
        b=Eljee4QSE+OWbyPHY8VeDnk6KgOjjnPQfrgdthWjpAs9OqHa+9M27YH5JXcfM0PAaj
         +ZkWnLDKGpsfX2zTxEE9NgxasfHT1KNWoGgYmRJBAHYN+ZQ3H0j6ydt5c4pLdQZf4koa
         720LrFLQXsuJLLvPoECuRejGbBkczpzgF3FAiiFX0svYLrZEsseBPEJj9q5lWcv9Moge
         sxvXaaCzXd7dMx32I4oaEG/7X1XNHr80zbQwPXEo6EFV9pxzScNui6HKEUDRZke9fWef
         pKgB3+qXo1a6P5kwKwUus/zU1TUqBJrwmfOVHtUWhTd7ceMXp5ZnSXnlI1UkPsSb0a5V
         GuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739200914; x=1739805714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzYqa/g+GOzKxJJWedO3KzSRX87c6zCxPSEaoJJs1Jw=;
        b=JRnqH0UlWGlY6ZgTV+FQ7QlpQfL+IKIFwB+oXoxvA/Q1bzw1UVZ+d/CAWIlbBDIkKp
         n95MeWrPzju8jLyjPvBtMAnVsiwMNziHGa+n/rPIsmVznT2hOOcJ/kc8n2V1GSeXYgUy
         ZLvqYKQharB3Msn5X186VgediF7s5ccJiciJaxiTdTwMPteawlzLb6e6booAHeC6arya
         VCIOPoKIHR+vTGAaFijlRw/gjFBGp9ObuWc7W9dX/F2P9TaR4/D/QDl8u1/l04m/JVJo
         tZT5E/CQyC8ikqTpJ+kF6YT8HxWOLrTMphOZ7UDYcyDYl8o1zTdT7evQBrFiXl99Kc1d
         VTHQ==
X-Gm-Message-State: AOJu0YyxPUvuVjVDdIEuk0JnWPbggW2AvsvbuRVjbOYkPWaLVpig1Hxz
	K+L7xEBpSfibogUrPgP2GUGlICaKJK89roTMQfEkGmqh2L6uXEX1qJQe0A==
X-Gm-Gg: ASbGncsVeY/L0ANVC3jnCeMoNlh5wWYhKVkRV3zdzknhbOlXbTBChYv5zkMWgnicx2M
	Q2tVqO1lHSFyzAsht4KPItY6hfPwdxjXOhVEPOtOIPULL+v73v4nyay8iZrBmV7z3F3qtpHZoZj
	ZKbUnRXtfOcjoUFR3nByek3ykl4DwMa5QT2GtJXLKUprFG5V7jXRjzciyaPU1wjoN+W8p6Ipto8
	LDTNQdURwht/Mn4LH8GY0aPLDCHZtfaexuroVNEJAu3XFM+PvDSZm174bgPN5gI/b6OiE+D6Ew=
X-Google-Smtp-Source: AGHT+IFK0Gry2OGmk2KKwh/m1b73f6oLYESlKpUjohX8OLBQZlKzJa47quzT3jKEGXfkT/k+caJFYw==
X-Received: by 2002:a17:907:d01:b0:ab6:d59b:614d with SMTP id a640c23a62f3a-ab789b395a1mr1624684066b.23.1739200912439;
        Mon, 10 Feb 2025 07:21:52 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:e0cd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7d2c1797asm69587166b.22.2025.02.10.07.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 07:21:51 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: stable@vger.kernel.org
Cc: Muhammad Ramdhan <ramdhan@starlabs.sg>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	Jacob Soo <jacob.soo@starlabs.sg>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH stable-6.6 0/3] provided buffer recycling fixes
Date: Mon, 10 Feb 2025 15:21:35 +0000
Message-ID: <cover.1738772087.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes for the provided buffers for not allowing kbufs to cross a single
execution section. Upstream had most of it already fixed by chance,
which is why all 3 patches refer to a single upstream commit.

Pavel Begunkov (3):
  io_uring: fix multishots with selected buffers
  io_uring: fix io_req_prep_async with provided buffers
  io_uring/rw: commit provided buffer state on async

 io_uring/io_uring.c |  5 ++++-
 io_uring/poll.c     |  2 ++
 io_uring/rw.c       | 10 ++++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.47.1


