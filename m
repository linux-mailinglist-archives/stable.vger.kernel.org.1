Return-Path: <stable+bounces-128382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57057A7C8E6
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 13:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C289E17AC5B
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 11:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39C11DF24E;
	Sat,  5 Apr 2025 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDEs5UW0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345D41B0F30;
	Sat,  5 Apr 2025 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743852635; cv=none; b=pGRkrxCLaFP9EAiH00XbFhybplsnJw8FskROLIwQafBx/bSWxMNOhnPoouUPFEx0WJQlmKqyzS9ivsxc7WRqvpvm9dHvsKWG+wmZsS6h3JmBbaDsZbOK9XlLzCE5LpOeoPEExbXOlBfrfp/YTckxOqq0nmlBwfAQSwPdZbfBmNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743852635; c=relaxed/simple;
	bh=YhMfyn/9sdvW/+B1C9ttSC2di1cyrxHSVS6pEOeqCWA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hukIE2pCXDApb9liHQV6+mxVnnBUlr3i7a1S2jeW07gQOYB3Okh9BN30yyOUHovTHAsjVW8qacPmNGy5lfHOFcoNCEUnYMCtJJq8bBQwOJhZqtc5TEPQ++VyuysJQneQf/cR3damCD1bJ990QLY8uAy8Vg8X9HIE5sE3/fyOQxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDEs5UW0; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-af589091049so1907339a12.1;
        Sat, 05 Apr 2025 04:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743852633; x=1744457433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SoQfJRPHunsbNr6uBql3ChRC57ynqxjZE49jEW526Ik=;
        b=SDEs5UW0EY5rqEm8NLI0XWEe4isyutedwARQsepi/PNOytO4dhDpeIuarxwatmepMi
         jAnp3f7NttHnaUtshgqD0EY+HjSSXnix7JS8kpoFOy9ZFvkpFkpaNvSYan2U2ou6o1Od
         bbvdxyUDXcQ6fP1xspRr6PBIYFrcRMGJpqK8UESsX4YXp3NkVjQsruA/RhLYF8F4e/y3
         6R3qa9OsIredkbUR3WuVVu8mGKrHhn7fkdk4nirhLLEcjEQ9HPm8KmjmQFNSZgnBYanu
         aCf9LHtprmdE7FxKZ7TPO0HyA/i0/4Ahb57khX8hetLRH7buEbc+qFZ6jA2qWcAnLHC+
         vsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743852633; x=1744457433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SoQfJRPHunsbNr6uBql3ChRC57ynqxjZE49jEW526Ik=;
        b=DSKilHi9cAPXAiuHmUjTDwILCMjxjPPXcRCCHwJtCNto63F13cz+UXtgCZYoxZ8JvT
         rRb/60VSF7/DPScAFHpAkV8Ctrdf1ipWtKnd2mxlIIBfQH6gxMK/QGF3JZexbJ9+uxBZ
         KazZ4MJd751mWDKmdMRVybYpThRIDA1QQHJooR2QkIikFhVWyENe4jg+2SXt9Qh+WST0
         X9aIx+/4FJWJphqJRlu+PSbRWz0KMAil6nUdC4k3poR5aFSwBc2KeWQ5THpg4Q135Bbl
         slGXeAmFA37EDoO+iUZiS2gpnsXdAgXaehS+v3MD/B/+d9llxVoTdgNx/Oje63ETQruf
         1qLw==
X-Forwarded-Encrypted: i=1; AJvYcCU+kuAowq7bvUd7eUpIeAS2LyykDyTQwPDGcpO3LJtzn5WrGVjL9RloMi9dkSP/kcL5flUxAacN@vger.kernel.org, AJvYcCWWr3WKFq9hy96VlkHap7aL0PAsdLghYB4lYa0gRGlvgqlWa5/ijCo/dpF7g9YOaC5XacaSVjeFv9KFvhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp0q1rkOjGqwCGa/deSqvEsv4Z0evFb4ExMltyyc8qlmnaXyWZ
	zCSavUfFN11jK5tJ8kL35EcC6VSoZGwV9qsOSIm8tvUu/kJpk8GHjmNf+zMAqhpSOQ==
X-Gm-Gg: ASbGncsxUiq7WEseQGZf+YgO59qbq+zdD80aLZw8paXCP6pbqrEb+dqOGl4WPhQ6YiE
	0D0K+608oh4n6V4pTHJse6Y+og+/nljuT9qmAAYSKXJ6fMbIVLlKtxTLR92l77OSEZdYRMUy7xw
	Ypq4MdcBO4yNalTboFe7x7RFvhshwnWXUAbZqND2lcX2CtL4JlJzG+EXT1u8kvwBSzNZxJUeYJp
	C0XWgxZzYkzvLy0AkQvdZ6rqIuTXZORenfU9dpU5oeY0Pt8KRbRaqb+lRpM6l3LAs7LtjccVOVK
	pSEVawYGuY9X0aFFEfzD8IOHODRCQYDMV/qDzZCdPomdl4K305x+pgClSRTQmfJD36m1
X-Google-Smtp-Source: AGHT+IG3yh2rev0TOr9Xa1tn7dlPnXmv6Sk9wM2sX7rVbQR8YnS+sCVDoP/A+k0aNPhcL4ZnjR4Y1A==
X-Received: by 2002:a17:90a:e18c:b0:2fe:d766:ad95 with SMTP id 98e67ed59e1d1-306a4860a03mr8905930a91.9.1743852633336;
        Sat, 05 Apr 2025 04:30:33 -0700 (PDT)
Received: from henry.localdomain ([223.72.104.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc323839sm4299234a12.30.2025.04.05.04.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 04:30:32 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: gregkh@linuxfoundation.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb/gadget: Add NULL check in ast_vhub_init_dev()
Date: Sat,  5 Apr 2025 19:30:20 +0800
Message-Id: <20250405113020.80387-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kasprintf() returns NULL when memory allocation fails. Currently,
ast_vhub_init_dev() does not check for this case, which results in a
NULL pointer dereference.

Add NULL check after devm_kasprintf() to prevent this issue.

Cc: stable@vger.kernel.org	# v4.18
Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V1 -> V2: Add Cc: stable label and correct commit message.

 drivers/usb/gadget/udc/aspeed-vhub/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
index 573109ca5b79..5b7d41a990d7 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
@@ -548,6 +548,8 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
 	d->vhub = vhub;
 	d->index = idx;
 	d->name = devm_kasprintf(parent, GFP_KERNEL, "port%d", idx+1);
+	if (!d->name)
+		return -ENOMEM;
 	d->regs = vhub->regs + 0x100 + 0x10 * idx;
 
 	ast_vhub_init_ep0(vhub, &d->ep0, d);
-- 
2.34.1


