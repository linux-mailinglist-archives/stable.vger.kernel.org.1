Return-Path: <stable+bounces-185884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8A0BE1DA3
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887271A606D7
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 07:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25852ECD26;
	Thu, 16 Oct 2025 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JigxG606"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B94283FD8
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 07:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760598328; cv=none; b=oavh8SqONdHweeRWDM34JHPpz0+YcGFyayTps2aD9edsWVLENTpnVRSlZHGmqNDcoxjy235IkMh1fiZb9SRWyi8hnskSptGVTg6WLBhqTB55aiA+Pf56iieOF4tyS22l8e+ceOVKh3J10obT/4aIZTzS5xHOtN+ohqWDpK2tM9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760598328; c=relaxed/simple;
	bh=p0myo92MmjxlvZuAoHPLrlj0DNjkKh00FfJsrOtYC58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ddg0e47LMzE9YffDEotryKy3iie2Uo0hGogQ2Q0UaWckXnEK6tNYrYGN+h5bpd9oxkFypdIHa11oyJ/Xx+R2m8Dbm80yFIcASrWxa/NNfHu7ysZEPXgH689ThiaLU7kaheigrvhQxzHZmT5ZakiHgHg9ILsh2ipslssqyhE9vuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JigxG606; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-782023ca359so452267b3a.2
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 00:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760598326; x=1761203126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VnADZNtvG2oDzd49JEbUEGirF2sr15sK/4g0V6zan7s=;
        b=JigxG606i3zg0l9ISOhmVN+m4SBteP6CsnkqooJYr+3V+AJaSXYBgWlJLNO9K8c3mx
         fLUCkI7a432HKcP9t35SeWN0LL90d5mdffO0eVL+gazccg8OD4BHOTA9F59Udm7kEXXl
         rvA8HRkMlXZg9QfGjy83uQqXDn/TCzJHmgI3hyQjJD/jCPEnvlf9oLhDpkQVGCoC0fqF
         zyTFwOCpLwgDLXPDOdM/rOTmOj9Z6EYujXxcaDEqLxQGv+uKdqJD+iPqLiEINzZWZyJJ
         KDlaXSy+L+AJgsgvB6LzVEAR5S2gCYuxyjSzelDVJuaiOeVIO13a+wLudDbErAbRuNN7
         vtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760598326; x=1761203126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VnADZNtvG2oDzd49JEbUEGirF2sr15sK/4g0V6zan7s=;
        b=j6/KVaJAO4X28MAPmdeSLttM8lRrRx7CITCTMUfjr8/xTumazYPidVQrk0j9ZZeO7j
         W3fZAWDXo8iAjqxbzBgqIbv5yrtlZWHbn4XBeBiYZWUKL/5JnbNQWWmmavNEazoNySzu
         5Qe2s5JJPTo/Nvzz3O7KLesnDUn/xmQPiaQgXfu99WLOLsje+8n0j1+VGW0euFFU8ywt
         AdaxrTH/tqbGbHNEMW9I0OhszCo37n+C63tuMWxQ/lSddPWEbwReav9aQWvJGe5tYRsE
         eeUySOmJmeGnza0keQjZYnCEsFS9dY8Tu/V5G+9uD3H/8DN5s9O2xt8u0jdlV/kaftSK
         0GFg==
X-Forwarded-Encrypted: i=1; AJvYcCUXDBy78mWyZgl6wizH/rQt7orfsE4Pt4oIEGjXcGonqgxWibQzC+dC3KYGtlIoqr1iMzbBqBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYEYQ+yFDhaABWIbJ2Er0mhb2E1qhNArYB+gSIsxvb7Cl42b4R
	4mVDzBOjUKMDhx8iykXEn2rcDNpiPfULXBDdxBj2e9d5y1MSM3OouAwNLlA2HagVB80=
X-Gm-Gg: ASbGncuAOi4hhAw7O5MeLiZeqTMqON09aEvoPa+xTNvURXfA+YoUhJb0EfAiDeLfy1/
	IM2bfXhUJt2ezIjPWV/a0v9eT+I+Y2Vwq/2GwWKZDEhxMQScoN/0JmcMwWrY0qlDajffotagppC
	Z9lhQVH/zWPkP52kr3PCJn8ZHjqjw8kZ8otLmgZFtIrX/2pQvfLpofTlTrIVikZORjtJ2WBsKjj
	Jod30Ach5TqXmn2NDIDNyI+K4qIlLYIDn9SfH/bnotcCZqnuoqPLLBYV4b/ZK9gcCcfS2GkYiTJ
	s8yZIkLd8awV6DQJ3dUSJgI0e7Rw51pcdDPeJWpMdms+GRsVICp0Q8fenfif8Wl5HJqfT9e9hea
	5Il9j7toKEzFokJ19IZuRfst3lgomLh0ehYyy+Qi6zS0prst4t8Fbpt78+vppR4EUopISjxUKeY
	1CNUoJ68OczrmzI2mK4EjJlYL/P5OkFRVs9+0m0XlYy9J2bV1YUeM1
X-Google-Smtp-Source: AGHT+IF1MUyIStDGYZTHEyg8E2ywDZduM7sqAh10ehYvS4mTZJXKLG3YccUhx6i6ZwBsPOUw0Zd0Wg==
X-Received: by 2002:a05:6a00:b85:b0:781:2069:1eea with SMTP id d2e1a72fcca58-79387828612mr39359235b3a.24.1760598325971;
        Thu, 16 Oct 2025 00:05:25 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2774sm21105126b3a.63.2025.10.16.00.05.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Oct 2025 00:05:25 -0700 (PDT)
From: Peng Zhang <zhangpeng.00@bytedance.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	songmuchun@bytedance.com,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] serial: 8250: always disable IRQ during THRE test
Date: Thu, 16 Oct 2025 15:05:16 +0800
Message-Id: <20251016070516.37549-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 039d4926379b ("serial: 8250: Toggle IER bits on only after irq
has been set up") moved IRQ setup before the THRE test, so the interrupt
handler can run during the test and race with its IIR reads. This can
produce wrong THRE test results and cause spurious registration of the
serial8250_backup_timeout timer. Unconditionally disable the IRQ for the
short duration of the test and re-enable it afterwards to avoid the race.

Cc: stable@vger.kernel.org
Fixes: 039d4926379b ("serial: 8250: Toggle IER bits on only after irq has been set up")
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 drivers/tty/serial/8250/8250_port.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 719faf92aa8a..f1740cc91143 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2147,8 +2147,7 @@ static void serial8250_THRE_test(struct uart_port *port)
 	if (up->port.flags & UPF_NO_THRE_TEST)
 		return;
 
-	if (port->irqflags & IRQF_SHARED)
-		disable_irq_nosync(port->irq);
+	disable_irq(port->irq);
 
 	/*
 	 * Test for UARTs that do not reassert THRE when the transmitter is idle and the interrupt
@@ -2170,8 +2169,7 @@ static void serial8250_THRE_test(struct uart_port *port)
 		serial_port_out(port, UART_IER, 0);
 	}
 
-	if (port->irqflags & IRQF_SHARED)
-		enable_irq(port->irq);
+	enable_irq(port->irq);
 
 	/*
 	 * If the interrupt is not reasserted, or we otherwise don't trust the iir, setup a timer to
-- 
2.20.1


