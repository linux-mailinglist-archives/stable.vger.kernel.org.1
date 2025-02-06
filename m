Return-Path: <stable+bounces-114153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1291A2AF3A
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 18:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1093188BA0E
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFC318FDD2;
	Thu,  6 Feb 2025 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rD2HdXOs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mifhz9+U"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3079818A92D;
	Thu,  6 Feb 2025 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738863969; cv=none; b=X4HdRJ4PScpAZwe8tg6u6MXsii0d4rTVRPAn6R79fX6kYd7Gyo0pissF6B55D5YNypCf+TTlhV8670BGHRZiMw8efe8t7BOw+RIDqWXQuXtD+1BQq29/48eDQDp9TRysNXuilb0Td41Vh3K3BFlyecGhyR9YT/Fb4DNv1/fout0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738863969; c=relaxed/simple;
	bh=VbCFflXesGSImL6bNQsizjjO6E8k6pkdVh7W5M/aRAY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j2KvNWsY3dZspzkNLbT37Pk25a9ZMcpZGex1+TuOhGXoFSaPseNXhKvGFBIQaJiYYFF2dfdvY4VHS9D+tEYB/ftZDAfn9DGOAG6fbV3zEJjWg24YbgeRUG0ouaQpwo3gsqKycs0jZFtU1LZ5V99QbxK19pVzibpuajD/Vg4pKTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rD2HdXOs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mifhz9+U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738863965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kdX3fHEALuqcZwNeLv5W3dViVtMAUAdzbiwDYebj3uQ=;
	b=rD2HdXOsIWRCRMluGt6ZXHDjjsoO1cJAaSf9Nr6fsAR/KPIsq6sp9zIY21Kg3w61bGPAvY
	gULkBoG83Eo2U8FXwGQVH4Y0mO9RE0/9lyOy7jEU+YgYjcFrgSEfdL5lCqGptLo3YFHE9+
	cF+AP6C/fTlZzZjuuOS54aFTPtBYJvgunhyWVhKGBvtioeWa5XIEjTh8Fvq5qsPPVZXlU4
	mtg2vLOUnHbsWUJNoyZt+eY6QV8qcyU30TMYUnkl1IJVosY1GBLCyTSLmcYQP+EgPhJQ+h
	x39PVE+Fdc0+raGP8ZVNtlcd2g65ab/YequP+5YRiSkNLTWr7WTuxf5wT73ipA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738863965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kdX3fHEALuqcZwNeLv5W3dViVtMAUAdzbiwDYebj3uQ=;
	b=Mifhz9+USAPdgAJIwLLQDNiN64f/lo/v0gQ6FCXm6HZeHVBbEpbUzhjtmRttyK+EiMHJuA
	UxUIudukSHJVIACA==
Subject: [PATCH net-next 0/4] ptp: vmclock: bugfixes and cleanups for error
 handling
Date: Thu, 06 Feb 2025 18:45:00 +0100
Message-Id: <20250206-vmclock-probe-v1-0-17a3ea07be34@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABz1pGcC/x3MQQqAIBBA0avErBswwaSuEi1ymmqoNDQiiO6et
 HyL/x9IHIUTtMUDkS9JEnxGVRZAy+BnRhmzQSttlFY1XjttgVY8YnCMxpIjZ61qtIHcHJEnuf9
 fB55P9Hyf0L/vBzWnlzxpAAAA
X-Change-ID: 20250206-vmclock-probe-57cbcb770925
To: David Woodhouse <dwmw2@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738863961; l=754;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=VbCFflXesGSImL6bNQsizjjO6E8k6pkdVh7W5M/aRAY=;
 b=+DBjjLLbYLFrYEW0vieMhxBlIsJy7TvvcRujD/f4gQWcNhgr2hMlGUiRsiNj/uyyaG5Ic3j1L
 cqrnDIb1TDhB4cSUYP+PFR0sIg+SieOEPD7REm/oMm3IFFqPxcZjODQ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some error handling issues I noticed while looking at the code.

Only compile-tested.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (4):
      ptp: vmclock: Set driver data before its usage
      ptp: vmclock: Don't unregister misc device if it was not registered
      ptp: vmclock: Clean up miscdev and ptp clock through devres
      ptp: vmclock: Remove goto-based cleanup logic

 drivers/ptp/ptp_vmclock.c | 46 ++++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250206-vmclock-probe-57cbcb770925

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


