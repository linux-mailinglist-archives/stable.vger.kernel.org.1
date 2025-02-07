Return-Path: <stable+bounces-114228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA27EA2BF9D
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 10:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63FA77A5E7A
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 09:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910F42343B3;
	Fri,  7 Feb 2025 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h8YLWiD2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2WQ6m6nk"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F7E1DDA2F;
	Fri,  7 Feb 2025 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921152; cv=none; b=T7eS36m8rPg0XaQtNVpt6hEUeQJUgTZw+DN5BBmMu4YlBr2IHJWvvL1XvpTenrVKv7rACVI4XEn9U06D+h9EhMzc31kvKezqQzqBjwqIJxzIISKPT5f6wpLCXdwvl1bG3ivojbl382UOFdlu5hVc3EU/OpcmxeK+h/497vHzszg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921152; c=relaxed/simple;
	bh=67Qj7Rsb7HIT+rC3c3Khs/YT3YZlzU7gpEnE+MBUEP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gQlJlnwnnW6EhyINgN/GY1keKDWErF2ujs6tRAFxN3/zKezsguj1nJ+OMHx/SEvGmPSMw62Hh9hCzfvc79LZ+gvrLTZXS5Vza1/0mklKnte1j+QYayzT7fSIIrLbGWbiG7sMzrJrBVn91gLKUe+V9hkXuvV7Q05ksIsOmgzIrN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h8YLWiD2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2WQ6m6nk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738921149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9Y7amg6joot0ql0Loij+UqAMaqkQi9rCV9IvPg7dSo=;
	b=h8YLWiD2nzQMDRS60SYGfl8bWoZIHD8bFoJP266cu9y78xJxLYaRkFTmSycOD5rwhl3+Ub
	lZNfK0mbBDGI1kzEnEzM7tRqzTJ5h65UEZLxHHpgrH7JJ9qkO0zWNt8N6s+qIA0rNdTJZW
	xBr8uo/fGm+/vfMRxxa11WehcRqiGrljNanC4XcndqqSWgC8/I9s8UINpdRsqvm0TtY/L4
	eCII8BZ+R/ZbPEOeMam28QssEJiC6t4M+H42QKt9WOnmrnWNO9mSR3u8Y/Ak2CNin3zIGm
	NKaCrNvK5fo6v4afyX1i6h5ic9l3gDzF88BOyuwsSFbEALOtO/ACb6r6rd1yJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738921149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S9Y7amg6joot0ql0Loij+UqAMaqkQi9rCV9IvPg7dSo=;
	b=2WQ6m6nkrF368bMFQ18vNImSHuDcqKV1eqeJTACQTJwaGSqhlto6EveHe07Ecxvvi3/6/u
	34ASIWgdR37gpbBg==
Date: Fri, 07 Feb 2025 10:39:04 +0100
Subject: [PATCH net v2 3/5] ptp: vmclock: Don't unregister misc device if
 it was not registered
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250207-vmclock-probe-v2-3-bc2fce0bdf07@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738921146; l=1501;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=67Qj7Rsb7HIT+rC3c3Khs/YT3YZlzU7gpEnE+MBUEP4=;
 b=3xaMTeiqFBY8oD2NO24lNtTWbQDHgoSqqQPBGwKQWQ4M5MDOnn3H5ODx+lOMPSoNoAjN29mEp
 lp7g5molxWiC/jd1g89uFg2kuyf0tkgLU8RV1gWbOwo70zphHTeAScA
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

vmclock_remove() tries to detect the successful registration of the misc
device based on the value of its minor value.
However that check is incorrect if the misc device registration was not
attempted in the first place.

Always initialize the minor number, so the check works properly.

Fixes: 205032724226 ("ptp: Add support for the AMZNC10C 'vmclock' device")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
 drivers/ptp/ptp_vmclock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index 1ba30a2da570fb4d1ec9db72820bf1781dfa9655..9b8bd626a397313433908fcc838edf8ffc3ecc98 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -550,6 +550,8 @@ static int vmclock_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	st->miscdev.minor = MISC_DYNAMIC_MINOR;
+
 	/*
 	 * If the structure is big enough, it can be mapped to userspace.
 	 * Theoretically a guest OS even using larger pages could still
@@ -557,7 +559,6 @@ static int vmclock_probe(struct platform_device *pdev)
 	 * cross that bridge if/when we come to it.
 	 */
 	if (le32_to_cpu(st->clk->size) >= PAGE_SIZE) {
-		st->miscdev.minor = MISC_DYNAMIC_MINOR;
 		st->miscdev.fops = &vmclock_miscdev_fops;
 		st->miscdev.name = st->name;
 

-- 
2.48.1


