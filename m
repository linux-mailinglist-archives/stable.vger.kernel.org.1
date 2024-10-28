Return-Path: <stable+bounces-89132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7675D9B3DEA
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 23:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D726CB21618
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 22:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE05918E05D;
	Mon, 28 Oct 2024 22:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NsIQYmj/"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700C41D88D7
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 22:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730155203; cv=none; b=LZU6BxENWbHi2/iJ+wJ3F6OKk/pBJyN55cuSqBAweYzzPz5IR6niXs2mAyTvlDLiwA9BikL9uJzZqAdUctZNEXj7Porvp7g9932GalLyIYmA7Y/NtIBflaP0MT45si74eibeJdcC899TbqrZGg09bRKateIac9wJhw//PbKnP70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730155203; c=relaxed/simple;
	bh=g2kBDlv/Ae+cxd/EcWrksl+RYNV6wyTAfhIwWRiTdoc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jwRtzanU4Cqn5U6uSSV3UN8/mXBn+//y6ou6xsiJOwil0+U7UkonxegzBklSnF4HlBCsCU7g9Ce7R6XbXH1y6rinmWkzZKemZdv81hT8lMCLAZaYrjEmgEfYrL3UAh9P7gJ8ZTOVFik0ykvaHzQoqaDjeU/RmCZcAZkGjSc289I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NsIQYmj/; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb4ec17f5cso43211031fa.3
        for <stable@vger.kernel.org>; Mon, 28 Oct 2024 15:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730155199; x=1730759999; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9wXo63O32Tj8mL4S2l9hFvzU6LzT7SmxiJkM8pmk0Yk=;
        b=NsIQYmj/9VHmEq/9b4l+PdQG6wYjmx9s5iaI/pCtYGDLtvP2c+WZ8TIQpDsLn43fIB
         2bQz1ZZfZrKfzM0TkFbiE0lTBsNYm/9LK56HuOBu1fT691vUY4aNwSMTCVL97/l/tAHS
         Gc0GZ1/q0Vf1yX4Xr0E8Mffm05AeGOI8ULp4o1RKPLtPGcyvgYAT2fbGL2Jyd6riAj9Y
         UPHWB72qGHDa98aTvX0GYQhm9HbXZ+PrvGbnuOGrVzMVpw5K9zLYNmnCbvEjgukJQcll
         gA1WZCr1F4ZMpfTuI7UPCP2xRQAEytS9qf4d+mEtAdrkxlaxtJFEOKVTjdDWjlq+jh1t
         1d7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730155199; x=1730759999;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wXo63O32Tj8mL4S2l9hFvzU6LzT7SmxiJkM8pmk0Yk=;
        b=mRKMm/HyW7s74g81cp2DqL3qgTQoxVHHoYUF34cut21gkh08jBnL6+/vO9NObB4sNy
         P5FVMqhbYe8HYQSW0RFD4bJGqvZ1GdFRuW9N7qxk852n/REH1u7fL9fapw2g/Kg5iReZ
         SblaIRKhG24nILe5yvLKid1siSvf44WWGIb3oblueGhW2Kp9k2iEvIpjY4AXW2CWLaef
         m4jiyjSKWLChqaRAwV0tUq7qIuClI5H8SOeCKyV72scp01qwOce70CIb1pQlC1fe1CWk
         rm9uLYg5ohuhIO9KvxKXaWtlKhqzCgmEZ7zqDDmW06ZfNq9FjOjqCLIc/lL6P9ISJS80
         U4cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUutGikFjpV9FCHLJp19W924y3MmDvryBzBs6nIzUokfI6T/v+HePxbFu6VeH5g0jHOMjkyKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYA9x/nEYs0XGmYWfRGt/Pz9Ndusocg+6cvHM5/NKEsc/lMDcr
	gliGXZIQQZvMeY52TuD/lEdctnm731mCQarVx7z3wKraY6HgeR3StN9IhWXcscc=
X-Google-Smtp-Source: AGHT+IFw8S9GXzhKxxjCAvfQuZXm713onz2offOHHcQy90zHeXKFAxWbIRDYgwZ/jZYdTjDeJs6JGw==
X-Received: by 2002:a2e:a9a0:0:b0:2fb:6465:3183 with SMTP id 38308e7fff4ca-2fcbdf5eab0mr42659151fa.3.1730155199410;
        Mon, 28 Oct 2024 15:39:59 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb451caa2sm12648561fa.36.2024.10.28.15.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 15:39:59 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/2] Expand comment
Date: Mon, 28 Oct 2024 23:39:57 +0100
Message-Id: <20241028-comments-in-switch-to-v1-0-7280d09671a8@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL0SIGcC/x3MQQqAIBBA0avErBtQMbCuEi3CppqFGo5UEN09a
 fkW/z8glJkEhuaBTCcLp1ih2wb8PseNkJdqMMpYrYxDn0KgWAQ5olxc/I4loSJjrVPkbN9BbY9
 MK9//d5ze9wNfxHZaZwAAAA==
To: Russell King <linux@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 Linus Walleij <linus.walleij@linaro.org>, stable@vger.kernel.org, 
 Clement LE GOFFIC <clement.legoffic@foss.st.com>, 
 Mark Rutland <mark.rutland@arm.com>
X-Mailer: b4 0.14.0

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (2):
      ARM: entry: Do a dummy read from VMAP shadow
      ARM: entry: expand comment in __switch_to

 arch/arm/kernel/entry-armv.S | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241028-comments-in-switch-to-0e24480e8495

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


