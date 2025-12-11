Return-Path: <stable+bounces-200774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B99DCB4EC4
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 07:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79B7430012D6
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 06:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C492BDC23;
	Thu, 11 Dec 2025 06:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4lCIV7K"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F90A24E4B4
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 06:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765435790; cv=none; b=NFoj979IWfl/WwW2lVDW1lXvllT0X/UD/qnQGfapHrSvK8VUS5uBFuYcrFr8V1/lsawuyj/v6JrbejeBILWLxc47iskHLG0GsovsBYGxfymfSZw6Ht6da/NJtpKKD+cdO33+S6I7Ht3QRAfjw7Q3/pP9yliS2JjRqNsaNlA7AtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765435790; c=relaxed/simple;
	bh=jLIEbOil8JUvwvgoHLS0xgagSdpZFVnP6mw3L4Fg5os=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lSTGUXgJEkR2pWRmH2FCj09CWhZRqkBiMCIpeFZWDodnBzt/T6y3it680GFKhqBOc8iOha3+1kv2/fz0JBP1JU+9yCHPYf0pEL0DTUaTUMHAUou5jLWC22vKOS8mmFzO721iC6fpoU/wTBJDpd/CST0qJmhAJOnBiqSrb/iK5Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4lCIV7K; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29808a9a96aso8630975ad.1
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 22:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765435788; x=1766040588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A930R/Xs4QOYTiiYr4F9dDu2dd52LTZ9/1wSdEBmY94=;
        b=X4lCIV7KIkrdHL97r40ojr5tWwjy1SLV27XpVWFgLUDTyXT0E1BTgsPRsyGsKUq0BH
         3L3uq4xyMRakOPLe+PMUXAmZF0A8lveTiJ/I0Lev8Q2ml3q4oGMVOE4/fbTV3Um9Gqfs
         3okM/7vXTGxWUMxipkIUW91euh3Lnk/XKSOhzQu+4Cznb4cIA5fTvY21KkyhjGNjLpMp
         P0YKwasupl6R0WSvydYwkL1pvU58uFLb0hmcV8P0+NMjIBj9kAgYc0E/ekqwoyjen84c
         0LeacveXue4iNh0ZiburhIOhda6+QI7K4+TCbHpeteXjMTVmqVIXxLb5MVbzrGbcarv/
         KucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765435788; x=1766040588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A930R/Xs4QOYTiiYr4F9dDu2dd52LTZ9/1wSdEBmY94=;
        b=TGboma++sZReZBfGRuctrA0mpZ2BSOMi2uF30lu6zidMee7Ks0rIX4qHTvHXmtKIgk
         hZ2VR4neHoa0FDXiIeJHc/kvQfxzRU6Gl2GhNjyMLVcO83HkJo8cB1BfKu/hVf5rq97R
         Wc6ppAFX8I98XqobOYkk0v0+6Ba11dy+cwZWN+0CH4IIx/Bvc16RPhytWOoRriKLU2Ug
         dhu2fYpVpbhMEXC0MDuyj91qI2DhzkBw2X1V5Cr+oRk26eP591WedLcJFKkGxcW6XyCR
         grPdB7wY7NwWMorq/JNmHeWxx3dozhHUtnRwQv20QS/mYz6yBJ30VC/V0lHdEkXwgSXv
         bm5A==
X-Forwarded-Encrypted: i=1; AJvYcCXa1Uu1E2IVzUAlP3+f0BCmIRMEpgfaw7MQWhv9Upcl6OEHXesVfZViN6jt+BgSN5iJiG5kR6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC98Ams7nhVN3fNZbjrXz+0pkfAXv0jVqz9Gp4nAph7+9OzKzu
	Sd4C3WwsnwdjBPUckXTbkVEU4nNP+4w1+t5ZKHs2dcBEwEc0Kn8Vu2iTmu2rELXrGLU=
X-Gm-Gg: AY/fxX5kEG2oDNToAABCSYFVnGJUf0eqyExg9lpJp0oOy0V9ypN7GHy3wtdGujRuiKm
	hWJmkCWQYN4Jt0pVtE6HaNqq+JYVUE5QQnLMNT7uKdQX0vcqihHNqMzJpXf0c4jwPk4YQioX7Uv
	rc32/CKNQB120U7fosR4HeOqHVpav+kAR3kJw7LyWCpWjoXTqwWIb1rsrH6FEByaTlBk4LIbD+V
	e2LobhcU+4Ye9+6VbqYha1rCrhx8jaG6JZtdHNVY/GZ/kb981i+5Yu4DPS7lt6fw2ZyYIa5lInX
	FuMbnzvKUx094WPkp6srAFleXYWX7v/6bOK9Afq8mmXdUT+NBie4oe9rXO3C+nlUJcsIlfie7C0
	fG//zhAdyptzFTQdmkU824iKciCdFXe+RxtCU1AdYP0yilKN7kW51LVAM6nUK9rYiCQO9YA9yF2
	7/QJfpt4frgycN8GNg9uachhZ0hyRt6Lyhkw==
X-Google-Smtp-Source: AGHT+IHpmykci4B0OIJtBdbWIngC1cFWd1IKB2ZOgzuk8178NaUix/BQGoMHNT6ECQIxjsjZDCl8TQ==
X-Received: by 2002:a17:903:1904:b0:295:73f:90d0 with SMTP id d9443c01a7336-29ec27b8670mr40699845ad.50.1765435788379;
        Wed, 10 Dec 2025 22:49:48 -0800 (PST)
Received: from c45b92c47440.. ([202.120.234.58])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29eea016ef4sm13694335ad.56.2025.12.10.22.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 22:49:47 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] usb: dwc3: of-simple: fix clock resource leak in dwc3_of_simple_probe
Date: Thu, 11 Dec 2025 10:49:36 +0400
Message-Id: <20251211064937.2360510-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When clk_bulk_prepare_enable() fails, the error path jumps to
err_resetc_assert, skipping clk_bulk_put_all() and leaking the
clock references acquired by clk_bulk_get_all().

Add err_clk_put_all label to properly release clock resources
in all error paths.

Found via static analysis and code review.

Fixes: c0c61471ef86 ("usb: dwc3: of-simple: Convert to bulk clk API")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index a4954a21be93..c116143335d9 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -70,11 +70,11 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 	simple->num_clocks = ret;
 	ret = clk_bulk_prepare_enable(simple->num_clocks, simple->clks);
 	if (ret)
-		goto err_resetc_assert;
+		goto err_clk_put_all;
 
 	ret = of_platform_populate(np, NULL, NULL, dev);
 	if (ret)
-		goto err_clk_put;
+		goto err_clk_disable;
 
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
@@ -82,8 +82,9 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_clk_put:
+err_clk_disable:
 	clk_bulk_disable_unprepare(simple->num_clocks, simple->clks);
+err_clk_put_all:
 	clk_bulk_put_all(simple->num_clocks, simple->clks);
 
 err_resetc_assert:
-- 
2.25.1


