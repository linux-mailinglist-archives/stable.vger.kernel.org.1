Return-Path: <stable+bounces-222491-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOKfJHrcpGk0ugUAu9opvQ
	(envelope-from <stable+bounces-222491-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 01:40:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E08081D2255
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 01:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 463E9301112D
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 00:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A90E1D7E41;
	Mon,  2 Mar 2026 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2JMlHi+h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6egGOTus"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D8F10F1;
	Mon,  2 Mar 2026 00:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772412008; cv=none; b=aHFDQep1xZDfWgwi3P9vSvNX4AeFkgCUtO1bRc9JM7O84y+spvB07Jq/u59vCT0PTTCS4R0WCzWiVroN6sNvgT0jkQbs9rf/7MzJTjlj/74nuKbEIYMiQjdMfQUK1z+ONYymB+xVg8bo5Hwu9Huh+VGlI0UrUHWZ6LDIDAe2dKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772412008; c=relaxed/simple;
	bh=8EKEC6J5g0gtnjCmFEP0Jw99XfDddu2rBIKPE+B7JHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I9i2lrQM7itxA2Qmt7hZiOjdEeczxCWome414qQyz+rlhg+zb9lehMEgXKzR4I117KPd4uKsZlX9C3+WDpumzj8pYFLLCtl+A4W3V0rS/RbL9Mgdb5dpJWaT05rgX583N++mrq4UBxOupCu+PEMc4RLRatvi0yWTT77jlpEW+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2JMlHi+h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6egGOTus; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772411998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7GZ2RRx7O92LjCo7RxqkMuENtOBSVFiWMFDEjbnkLX0=;
	b=2JMlHi+h0t9Dbgdx2J7d8ObJZx1v0a4AWjeAdgTVfxQ4HfIrkiLvRZqk1RXbucQnsemDiR
	4njdlphkHoX9JfhVOiy5rBiJMmQQkb3JNP0g+gRtjq5vvOf5/LzFFe6Vk+sqxWLyRZ6ayt
	jkKOZMZHHPG3u9LYSzILyWVMhomccIBhxQploe/YjHXjG31LrVfL7XBxvr4LuZKqA1HWue
	k/Zgo2Ft9cmWiuq4VFrtZv2dyrqV7DFAK1Ije9IUxpnQQF4nXD+TQROk5JHDagD7s6gp/y
	hFlZzFQy+sQKGpcqSoxi5skEDxF1IPLYHUWf0h9WTYnNGQMi3DlKgh8EG3njpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772411998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7GZ2RRx7O92LjCo7RxqkMuENtOBSVFiWMFDEjbnkLX0=;
	b=6egGOTusrjdSyMRBH6TLMJT1V2sVbaNiavS+t9AT0IEQveMj8bV4q0UHUvU8jKZJkkPS9G
	IyssSQRslYqulTCQ==
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH] powerpc/pseries: Correct MSI allocation tracking
Date: Mon,  2 Mar 2026 01:39:48 +0100
Message-ID: <20260302003948.1452016-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222491-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,lists.ozlabs.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namcao@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E08081D2255
X-Rspamd-Action: no action

The per-device MSI allocation calculation in pseries_irq_domain_alloc()
is clearly wrong. It can still happen to work when nr_irqs is 1.

Correct it.

Fixes: c0215e2d72de ("powerpc/pseries: Fix MSI-X allocation failure when qu=
ota is exceeded")
Cc: stable@vger.kernel.org
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 arch/powerpc/platforms/pseries/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/=
pseries/msi.c
index 64ffc6476ad6..8285b9a29fbf 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -605,7 +605,7 @@ static int pseries_irq_domain_alloc(struct irq_domain *=
domain, unsigned int virq
 					      &pseries_msi_irq_chip, pseries_dev);
 	}
=20
-	pseries_dev->msi_used++;
+	pseries_dev->msi_used +=3D nr_irqs;
 	return 0;
=20
 out:
--=20
2.47.3


