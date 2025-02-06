Return-Path: <stable+bounces-114154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A88C6A2AF40
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 18:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F1097A158B
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247CA198E6F;
	Thu,  6 Feb 2025 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VNaXBJCt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EFilHyGV"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEB818A95A;
	Thu,  6 Feb 2025 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863970; cv=none; b=aeVhH//XsZ1YCzdbgC+6GUSYDh97i3FiPl4Pg6/1Th/KAoaxoptWYrxmrs+pJvno8yUYOG5WG1/oWnQf2eoIxnhc+SLwvkbVTZAB8J48tQvnxL5nMNFOtoM7HqjapT8cvSouODdzGbjHliCrgWWzC94XSoPyJEkUoFrn2VLFHcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863970; c=relaxed/simple;
	bh=oUP3uARQb8ElTZZgfn00uglkGDh3XLe4pUDHXD8wncc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ulrxNCFg3qy5iBbDeoZPSnNM4yn13SFjzzZZdCLmw8MUxjfne9r6WYhpjUmmxmwAeyR+vIxDpPXYUmQ9wskLnc8sWrWL9JbwLUeSsgce4VsOB6Q8MTIRepMMMBo4cfzoPLyOLscfMMGsf66jEpgq+9X5KZ1fFC/h37uddi6PUTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VNaXBJCt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EFilHyGV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738863967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzFzW2m/x4Wy5ubrf65StcWZ+T0d8i2QbPnyKM6LHPE=;
	b=VNaXBJCtTSZlI4xwTpWVxGpPJmclYni8Y2nLk76DSZwPUiAWqFvrw+nf7rbAGF7FBoVhmR
	kaKE9FFEQn0vFZvaoO7+I0bsesXg0uW2gWh86HAm928YDIGczo80frP5eFLOoPDItEGlYX
	+6m6Sl/OkdW3zixY/47kb/9EpLh21KoUzX2oA32m04HG7J8vQH0YZeX+y3mn0NVJA8xRau
	eCg0J/vK7Lx3KEdFCUdKM2criMTdYVLaM2r93Rx4sFdLqEed4lVoXj6OAhJFaREsOT6QRj
	FAdNepTZN+r1GnkstylhFYpF4XzBX9vpl8a/xQBt9mDDWamtj19CjXdgaErKaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738863967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzFzW2m/x4Wy5ubrf65StcWZ+T0d8i2QbPnyKM6LHPE=;
	b=EFilHyGVrzltxjpKSMKvoZy5/tSQo9HDNi572VFGNb3ZtiCvg23uRfDVgcpMQTcdSZ7aCO
	H1oR+btb/FbtO9Cg==
Date: Thu, 06 Feb 2025 18:45:02 +0100
Subject: [PATCH net-next 2/4] ptp: vmclock: Don't unregister misc device if
 it was not registered
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250206-vmclock-probe-v1-2-17a3ea07be34@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738863961; l=1397;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=oUP3uARQb8ElTZZgfn00uglkGDh3XLe4pUDHXD8wncc=;
 b=DmSYiVmqrG8PzDKMP/ONn2O1YrFJxXOlv9Hi6FxA4ynn+1sO47IEjrhTbGxj8qwD2Ypsj1Lek
 m+ZlLIOFoYgBRS38AkO740Ekb476ZkDIGnqzb6/OVY2mSlsWX/RgcTv
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
---
 drivers/ptp/ptp_vmclock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index 1920698ae6eba6abfff5b61afae1b047910026fd..82e6bef72b1b6edef7d891964c3f9c4546f6ddba 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -549,6 +549,8 @@ static int vmclock_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	st->miscdev.minor = MISC_DYNAMIC_MINOR;
+
 	/*
 	 * If the structure is big enough, it can be mapped to userspace.
 	 * Theoretically a guest OS even using larger pages could still
@@ -556,7 +558,6 @@ static int vmclock_probe(struct platform_device *pdev)
 	 * cross that bridge if/when we come to it.
 	 */
 	if (le32_to_cpu(st->clk->size) >= PAGE_SIZE) {
-		st->miscdev.minor = MISC_DYNAMIC_MINOR;
 		st->miscdev.fops = &vmclock_miscdev_fops;
 		st->miscdev.name = st->name;
 

-- 
2.48.1


