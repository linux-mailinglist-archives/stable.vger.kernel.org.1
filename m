Return-Path: <stable+bounces-114227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD900A2BF99
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 10:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4573C3A2905
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 09:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548201DE4F6;
	Fri,  7 Feb 2025 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rWAawmeY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nRJNL+V1"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E541A2381;
	Fri,  7 Feb 2025 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921152; cv=none; b=DgKtEviUfHrraspsHftOXjuJFziOHWocDeV2gRUfooDF/I5GNpDkuYFcah8YXLKUSPG9gatMfE6DElAFxTYAj1XvqYg11rldqRTpi/jQBSqX9jM/28NtR63R5MzII2ERr/9b8BWOWlDhbFC6Gg6EXh2YV2RKETKx+OSemTrp0gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921152; c=relaxed/simple;
	bh=1B5zPKA0Mc/6w7ghytEcBT/SVnSrsKvi3bjfjnQS5dQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sXZPVf4d4euV/CpfbAXm2HQfR0KdSoUWfg5al0vIbl6MN3janyx+azLOhgYsPMtMkDIyQvqCeLbjPcC8g/rPOdzl/2Rw2MRMU5MYz69sjrE6K+mh5tCwtt1TQjY943KYZnRLpSYvLoSfj85y7DNLLRHakpIxsz4wkVoOfQANk+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rWAawmeY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nRJNL+V1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738921148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gupiaH3aeSrW49PewDfwsAeSLNT5/3bH/9opEvPC+nE=;
	b=rWAawmeYpAKH2GrmUVF1eNWG6Dzm0PfBotXhKAMp2wDyD1j4uhfpCVW8eJX5sFds5ic+CS
	3/0Ie2Kru9i++SV1mS9PnjZFH2WbUSsN99CDsGWa7NBal4JtFbKx/oxEyUyC1tusNNz8zr
	OgGx36p7hJpX+azcnonw7ulJLhcMN7cCoRkvtGX0EtdIivuEVHUFBBeJdxH6JlXVKujAKp
	wMA4rlHigPTjtCOtLCbJVrlpsZiOYEB5zdF3DEMtmJyYYEM2tH1099D1SvwtGcmqfhkTpn
	JK/MnkOBwL7vffrX+5WOaYhab3BU8g+a1lutS6LpfR8409XffphwZJI6TVG1vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738921148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gupiaH3aeSrW49PewDfwsAeSLNT5/3bH/9opEvPC+nE=;
	b=nRJNL+V1sL7A9lxTfPDnFb7Cg222V7wjuQaadfMYP4JO2Onxackby70dOFHvKAgzUXs8PI
	SLYLkdA7HShylfDA==
Date: Fri, 07 Feb 2025 10:39:03 +0100
Subject: [PATCH net v2 2/5] ptp: vmclock: Set driver data before its usage
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250207-vmclock-probe-v2-2-bc2fce0bdf07@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738921146; l=1468;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=1B5zPKA0Mc/6w7ghytEcBT/SVnSrsKvi3bjfjnQS5dQ=;
 b=yc+Pliwu5No1r2SGJ9lf6wqlhDPZ0HotxZCwpfeSPNjpANxmq6CwDZdRimKDbNwI690DDS7Wg
 T2iK1l2zdw9DpirBjY1XwENdu86BlncH09V1jkKH9JN3VdQhCo8zIeb
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

If vmclock_ptp_register() fails during probing, vmclock_remove() is
called to clean up the ptp clock and misc device.
It uses dev_get_drvdata() to access the vmclock state.
However the driver data is not yet set at this point.

Assign the driver data earlier.

Fixes: 205032724226 ("ptp: Add support for the AMZNC10C 'vmclock' device")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
---
 drivers/ptp/ptp_vmclock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index dbc73e5382935dcbc799ea608b87f5ff51044ebc..1ba30a2da570fb4d1ec9db72820bf1781dfa9655 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -525,6 +525,8 @@ static int vmclock_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	dev_set_drvdata(dev, st);
+
 	if (le32_to_cpu(st->clk->magic) != VMCLOCK_MAGIC ||
 	    le32_to_cpu(st->clk->size) > resource_size(&st->res) ||
 	    le16_to_cpu(st->clk->version) != 1) {
@@ -588,8 +590,6 @@ static int vmclock_probe(struct platform_device *pdev)
 		 (st->miscdev.minor && st->ptp_clock) ? ", " : "",
 		 st->ptp_clock ? "PTP" : "");
 
-	dev_set_drvdata(dev, st);
-
  out:
 	return ret;
 }

-- 
2.48.1


