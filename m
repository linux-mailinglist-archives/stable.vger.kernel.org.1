Return-Path: <stable+bounces-114152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF93DA2AF38
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 18:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D173A456A
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0027C18E368;
	Thu,  6 Feb 2025 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="31sDh86z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TQcE3EIg"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E59518A6AD;
	Thu,  6 Feb 2025 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863969; cv=none; b=cbMv7UuNYy6QO5RENQmuNnFwux0QfX57fZFiAjNo6xCI1U173lK2SFcLxptEKIBpFRnOKdR1TsrG1izy8mbHB80lQ1EPs29YUccV3YUj9Slh4WOpCl8Mv/77YGgvV87Pzc5bl+T9tS0TtRUiM6+6LnascExpVsH5SUALDYBz5Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863969; c=relaxed/simple;
	bh=o8hw8b06FQjYLKmUpeXn7PVmDXgAzF3nOanhCnadJMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YRs5NHQizxA1FEouvyTxVoSI+uAk4tdSwCsv+HKSycu0jd079Xd2suGwBSSb5iEGwqgc7gjtSjqSpkgdDduMgzaHgcHn3GHge7Xb4gEqHjs7l3bUBFBwHywNEEPj0er+j5xvywOvK/OUrYaN/AuuElLMYfiQJLpakvgyej+Perg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=31sDh86z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TQcE3EIg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738863966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CC4gUgCnxt0BPV+hTHbd+rpIn+XhiTgaTWIDW6YhHwQ=;
	b=31sDh86za1XRzhLoqf8DJ944rJhnU5PFJP8AqqmdZ/7Ip1ZC+56rKWKufMKl/6R5/CSsyd
	X+TsuHRmqM+Rff6Z4lF1Z9wQo37JLIsuGW808nOLdCFSqaC0fYJGz2KblqnvAztRjjJiFc
	se5WVpgyooTq3v9RhKSYIKDZBxNEiFkfiWwM6ySLLCjk0M+mUHPt4N5e5F3OFzWAIO1ior
	xAA7aM4a4jFxSad0Smbk1x8ZgbvPahU13n+NZKYO3M/WkfDhQRhyeN9+3itKYLNqrZdZbE
	XHiATvWoh4qe3JtF4CCEw2k7J1oVq5JNdGimaxVlf8RAmcMvHu93k5f+DtAewg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738863966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CC4gUgCnxt0BPV+hTHbd+rpIn+XhiTgaTWIDW6YhHwQ=;
	b=TQcE3EIgyB3zc567VE5TKCsWwZdRx0N9VnOE+GafORIhGgnuFcwdZPD3xp7Nv8p9eTNuoI
	BwZiqNcG8pKnBpCA==
Date: Thu, 06 Feb 2025 18:45:01 +0100
Subject: [PATCH net-next 1/4] ptp: vmclock: Set driver data before its
 usage
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250206-vmclock-probe-v1-1-17a3ea07be34@linutronix.de>
References: <20250206-vmclock-probe-v1-0-17a3ea07be34@linutronix.de>
In-Reply-To: <20250206-vmclock-probe-v1-0-17a3ea07be34@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738863961; l=1299;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=o8hw8b06FQjYLKmUpeXn7PVmDXgAzF3nOanhCnadJMY=;
 b=fr8uQDAtVbN35sf9Hp8cnEXQnxPzZ6dBSXcvwXwyy82ViNHqakf/dvvGqhGR5my5QKbJYtfHJ
 dqYk0t1EIuyDl0NsWFuLDx1Mo0M8YWeju7V/H8Xw9z67VbLzyW7jlbr
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

If vmlock_ptp_register() fails during probing, vmclock_remove() is
called to clean up the ptp clock and misc device.
It uses dev_get_drvdata() to access the vmclock state.
However the driver data is not yet set at this point.

Assign the driver data earlier.

Fixes: 205032724226 ("ptp: Add support for the AMZNC10C 'vmclock' device")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/ptp/ptp_vmclock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index 0a2cfc8ad3c5408a87fd8fedeff274ab895de3dd..1920698ae6eba6abfff5b61afae1b047910026fd 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -524,6 +524,8 @@ static int vmclock_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	dev_set_drvdata(dev, st);
+
 	if (le32_to_cpu(st->clk->magic) != VMCLOCK_MAGIC ||
 	    le32_to_cpu(st->clk->size) > resource_size(&st->res) ||
 	    le16_to_cpu(st->clk->version) != 1) {
@@ -587,8 +589,6 @@ static int vmclock_probe(struct platform_device *pdev)
 		 (st->miscdev.minor && st->ptp_clock) ? ", " : "",
 		 st->ptp_clock ? "PTP" : "");
 
-	dev_set_drvdata(dev, st);
-
  out:
 	return ret;
 }

-- 
2.48.1


