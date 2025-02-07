Return-Path: <stable+bounces-114226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8247A2BF93
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 10:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73FC416992D
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 09:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AAF1DE3AE;
	Fri,  7 Feb 2025 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pUPLgXFa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rZNrnwW+"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E6D13C9A3;
	Fri,  7 Feb 2025 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921151; cv=none; b=if1Pvc3DoWge9/QZvvAXGin6+vdkeWrhIbjAnVVFUfSyscm/w9nEN+UBefO7FiX0mDFo5wZA1SAk6WRH7lJhdTk88xGjBCHbqgDxJIiZcOZGXE8Am+9KGgr6ucMW767djdbapDK4DIhwPrl/HutKOK5crSbMeJtqU8+zubtc8hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921151; c=relaxed/simple;
	bh=kTfv69N70jRYPW4PfE2gGidB3Lx+7n93IMhTANRVrYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ravht3/O4MK8W3rYS7o3TPWa54uOyKxDGocO6HCBaeXeMoPwBehrqF8dpskalqgkvWg9PcHsyIF/zkn3bj+W8gOJWAN1rteRdjzYFWktreAI3rCv9/gHiS2AbaHZAtyxi4XBtah9oTC78f4mu/kV55qlu+Qo77wFJiovdSysDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pUPLgXFa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rZNrnwW+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738921148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGKJRgcHeTsvHCCIhahevFs9ZoQcn4ms3fb+kPTrYUw=;
	b=pUPLgXFaDGWrQ5TSaSsCKK7CMqDdW27b68OIDaQM1CHubYZldfxMSWOp4pGzduuyh36qs1
	T8yQSDklKXkuFklPN2EEBmEB7plqmpXoe8urrj+TmQzz7Mx6mTOjNX+in+ohHpStH/tmcC
	c6JR0q7KMY6RBe/01+TDHty2typlgcm6mPV9yFVP1bN3lObWNKbA8acLgcrWP/2n4RH9Ub
	ZLswa/zgY2yBTJEJIBiLj9ezhNwEwfUAaCzM2iLx+hAO25XNCIwX1A9B7h8rkRrWiQWocL
	2g7jL5e5vX6uFSk1eZ/t0kCEZgabGqVZ+il9/+/tSyggg21RTHJ5exBhseGBaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738921148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGKJRgcHeTsvHCCIhahevFs9ZoQcn4ms3fb+kPTrYUw=;
	b=rZNrnwW+9h7sQmNnvHKyUxWAMHxultlcKQzohTuYuJDqnHkbz+FuwsxPdgmIUGDPS5bviL
	CakQJH32PygzfCCg==
Date: Fri, 07 Feb 2025 10:39:02 +0100
Subject: [PATCH net v2 1/5] ptp: vmclock: Add .owner to
 vmclock_miscdev_fops
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250207-vmclock-probe-v2-1-bc2fce0bdf07@linutronix.de>
References: <20250207-vmclock-probe-v2-0-bc2fce0bdf07@linutronix.de>
In-Reply-To: <20250207-vmclock-probe-v2-0-bc2fce0bdf07@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>, 
 David Woodhouse <dwmw@amazon.co.uk>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738921146; l=908;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=MFy8Kvx9GfNv7kEwQZwKavMJ1HFnaFSDW05FWmtv9l0=;
 b=FhK5DAQshdTsQDR3kmHqezcN25DxsO+GNEzCCmLMZaUkHHdxVobJAN70DHC3pWCzlbjKqnIYm
 rkbpqgaaKLsCgdQPRhJlJs6BUtoxDxWr/RogxLH4J+VVVUUhRmwVAOn
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

From: David Woodhouse <dwmw@amazon.co.uk>

Without the .owner field, the module can be unloaded while /dev/vmclock0
is open, leading to an oops.

Fixes: 205032724226 ("ptp: Add support for the AMZNC10C 'vmclock' device")
Cc: stable@vger.kernel.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/ptp/ptp_vmclock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index 0a2cfc8ad3c5408a87fd8fedeff274ab895de3dd..dbc73e5382935dcbc799ea608b87f5ff51044ebc 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -414,6 +414,7 @@ static ssize_t vmclock_miscdev_read(struct file *fp, char __user *buf,
 }
 
 static const struct file_operations vmclock_miscdev_fops = {
+	.owner = THIS_MODULE,
 	.mmap = vmclock_miscdev_mmap,
 	.read = vmclock_miscdev_read,
 };

-- 
2.48.1


