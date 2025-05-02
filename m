Return-Path: <stable+bounces-139451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F216EAA6B58
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 09:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45CC1BA6891
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 07:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206822673A9;
	Fri,  2 May 2025 07:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnK0Emoo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E90D267387;
	Fri,  2 May 2025 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746169788; cv=none; b=tibj9nWG1q8rltFgCYQxqekBqFfyfNlXlHh8QQoj6Ne+UPKrrvbaJ1drK5NQMacMPMnHSW+0FxGYx4sb7R/vwsBmPMpPT3JlaGORymqf5ppByVqQctuyMb9q+KNcTpIcks7gGIeFz/cHX6UlgbAX782XtNt9ddM0aODQJlQ4ML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746169788; c=relaxed/simple;
	bh=Zv9UkLIihex6h6uTzkv6W5mgHkrreKRyi05a5WoLInI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RxLLO+s+bGG0h1mz43r4Lid1KGSADVLm1l5IHwmxvM1PB2G/ybS9ItMSWvkSjxgeN4AwsA2v5ZXxmbqjD8nbb/ALce/K+P/L0X7ZSaF6G7l/9tnYpdWUMMvKnI2RYh6TqtQgEYU8RYch8ho4wKfZ+nJqIQNdBGMpftorknMK3KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnK0Emoo; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5edc07c777eso2464608a12.3;
        Fri, 02 May 2025 00:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746169785; x=1746774585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ep7HI99e/tGud544tNPRZD7MzU2VMMJjX/Q3bJALYng=;
        b=EnK0EmooRPWQ3NaR0eN9HvXpp3mBourerkAvjwMF7vTdLoDqRAKOZBHVQ0l2Pn+YZw
         t40EvwBYQBTfZ9fXDnye7bQFy0IVHt4IEesryX9aZf+0Ksl7vdsaV16mwoH2OMQjVjQn
         SVOOLBOI+/C++PvoklDYnh53/87sVTVl7nZx18l1u98u8CsQ/oflw6oXeBS6xRHS5Og+
         bDwrUjr6xAxoLac8svRX7braBWoX8LQ8duocy2fkPsluynSEXvA/H7sQd+C3/8bR0ltx
         55B7xTpCgbCoEFNrSbPy5Olq3Ha+xuyfBtTHWoc4nALc2gpNufUfXK9n/q6sLb6naKAX
         ll6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746169785; x=1746774585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ep7HI99e/tGud544tNPRZD7MzU2VMMJjX/Q3bJALYng=;
        b=K/18VDmma8OuLDDO2c9PYSWBrvU/9iEsvA3cIjCyuDssl0Xix7qWAlviW244PjpPef
         I/ubTaNCJfdRUUWZAYwOa0QIcMtGkpazvcHGh1YaRoaHYYIh/O5CWdxuXs7+pBeV/m7p
         AFosbhBVwjW7rPSxhBAbCwOptUX1q16PfxrAmXodE8ckVhaAsTDk0jrBdrsV7vWdpJb7
         fjEa/o4tTgaTT38U9Cy6iXTPLRDHzoMzlIRnJ3PGf4OWsFwC61Z1RJA/xEF9eeV5He/S
         R1/3l+OARDRlqNdldypsX1Yj/WCCHb0KQ8VFheN9j9XdYVp55IkJ3RDQ7olw1DbjhXoq
         X2hg==
X-Forwarded-Encrypted: i=1; AJvYcCV+JjvvfI1uVBsUxmcv+WN9KRAmwJOBsSVq7SCV9xFXt3qh9SlN0HZjVmC5rAHFQLV5SR1vTZcj@vger.kernel.org, AJvYcCW39I78UTL2NSmDroIhgCR4R9FyufNJ0dDcW1KiMC8gi4g53NautMaCaWF4EF3NCo/5oqWXT5znGCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl7gzgxfqQO8PaD3E44d+wdmXxJlQS9S+cNj2BOESUsKAoRDG5
	iZk1Ug3KLgP7vH/9ITEHG8YE/wkTLKnDt/s8pg+GN+gkJxrVB+0Y
X-Gm-Gg: ASbGncsO809IdmfOg03VrFvamZxpSWUqQsVZF4+ufTPTRW4HDPKITm2Y0ZNuTLTKlbk
	nDjkKFaXwwOZUcQT8PDdTYtxa3Al2mx2cjkxfKcQRMwrG0DlNR14qhl+BqgH35neLXDwxB/f3vB
	8Kah6vtdwJ+wxe8gyiJ0s8Ujiw76+NJP/5SS5cpYe6bU6JtosfAP/bPyTUVEoXEIjcH23ZSnY7h
	G/ddh5K2f+m+NugI581Or+dmwEIiMJH3+l+8mKoV2HlfVd/KdEXe/qj2VCHluBt125RdUqhBEHk
	Q15j96tMttBlLrvmboiO9FG3+X+SBrtkMyIYL4GD0ZDdVqvBf8M=
X-Google-Smtp-Source: AGHT+IEUOx/kHS3urIXTNQqKt63To14kA7EtxIUZfpJbg7fKJN0Zh8twc07BDyOu8Gnp9W4o9waVUA==
X-Received: by 2002:a05:6402:50c8:b0:5f8:b48a:a2d with SMTP id 4fb4d7f45d1cf-5fa78018af5mr1413360a12.10.1746169785042;
        Fri, 02 May 2025 00:09:45 -0700 (PDT)
Received: from localhost.localdomain ([178.25.124.12])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77bf3ec0sm753513a12.79.2025.05.02.00.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 00:09:44 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: guido.kiener@rohde-schwarz.com,
	stable@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 0/3 V3] usb: usbtmc: Fix erroneous ioctl returns
Date: Fri,  2 May 2025 09:09:38 +0200
Message-ID: <20250502070941.31819-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent tests with timeouts > INT_MAX produced random error returns
with usbtmc_get_stb. This was caused by assigning the return value
of wait_event_interruptible_timeout to an int which overflowed to
negative values. Also return value on success was the remaining
number of jiffies instead of 0.

These patches fix all the cases where the return of
wait_event_interruptible_timeout was assigned to an int and
the case of the remaining jiffies return in usbtmc_get_stb.

Patch 1: Fixes usbtmc_get_stb 
Patch 2: Fixes usbtmc488_ioctl_wait_srq
Patch 3: Fixes usbtmc_generic_read

Dave Penkler (3):
  usb: usbtmc: Fix erroneous get_stb ioctl error returns
  usb: usbtmc: Fix erroneous wait_srq ioctl return
  usb: usbtmc: Fix erroneous generic_read ioctl return

 drivers/usb/class/usbtmc.c | 53 ++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 22 deletions(-)

--
Changes V1 => V2 Add cc to stable line
        V2 => V3 Add susbsystem to cover letter
2.49.0


