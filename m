Return-Path: <stable+bounces-220494-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIiiCjA3o2lh+gQAu9opvQ
	(envelope-from <stable+bounces-220494-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:42:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A0B1C62C5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A21A31B2EA4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE353C7D93;
	Sat, 28 Feb 2026 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1gRhOlJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EA33C7D8C;
	Sat, 28 Feb 2026 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300379; cv=none; b=Npg1NANOUOBRHUf4rGthI2eZcRO3mPuCg30rpGwm8xTrbeQ71pzeAs+MJhSEphro4b6JwPqjvqmH7cdaLVMQco93vBu1EdRmMDRXMxxInRLKa3fFlzmOoHzHJGR1olCGZUrNWy6FGfPd7niThV6D1MH13VGUOMz8m42kiCRUDXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300379; c=relaxed/simple;
	bh=dn1iFD73VMHB/YqmWH1neyVbOGQ8Ue4J3Ro2YMlNY1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WACfRwfsVPtzMCRD3aD/69r/jhZaE72vDXIzMRpJNK0PbpiTeLOdcy2EnNOgS59ztS4KQ8Dg9hsjlT/4cEku+NI2n5F7bjmif71SHCPVx+F4UgRxly0g68W/AW+5SqBts7hX6JDS0PtaCnTk4ay0SWdnN+NIlDgpca5+6LfPwCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1gRhOlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE51AC19424;
	Sat, 28 Feb 2026 17:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300379;
	bh=dn1iFD73VMHB/YqmWH1neyVbOGQ8Ue4J3Ro2YMlNY1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j1gRhOlJQbQ16BTwwCGnO0Rsl/qTu0b6NaVLgNMut0YKbszvxcPo1fTZu4C7the0n
	 PCyMQIJLFFrflGcj8IbxMZ0oU9Av3gXgqvSyAgNpJfpOYzolE6w+BeiRBhbezyap4g
	 ORsFSK+90uuwIq3GPKuh7rYaYCWmYI5F9CtgkuUmuYFjsK2f7rYCHvyWTpf+oKfpKW
	 B4a5poArAXFykFLuVZUMfwtCOQmH/WLZ9JsMUOlyVHthsyXDITT/kAqnY5ua6lL8as
	 rI6DWaI07RMzKXjBWmRxvzXc9KFOASq0pu8op0DzYNYepNsCowVjjO61ouf5GeTpk0
	 rEjxFmnd6LnMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 415/844] ARM: 9467/1: mm: Don't use %pK through printk
Date: Sat, 28 Feb 2026 12:25:28 -0500
Message-ID: <20260228173244.1509663-416-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-220494-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: D0A0B1C62C5
X-Rspamd-Action: no action

From: Thomas Weissschuh <thomas.weissschuh@linutronix.de>

[ Upstream commit 012ea376a5948b025f260aa45d2a6ec5d96674ea ]

Restricted pointers ("%pK") were never meant to be used
through printk(). They can acquire sleeping locks in atomic contexts.

Switch to %px over the more secure %p as this usage is a debugging aid,
gated behind CONFIG_DEBUG_VIRTUAL and used by WARN().

Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mm/physaddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/physaddr.c b/arch/arm/mm/physaddr.c
index 3f263c840ebc4..1a37ebfacbba9 100644
--- a/arch/arm/mm/physaddr.c
+++ b/arch/arm/mm/physaddr.c
@@ -38,7 +38,7 @@ static inline bool __virt_addr_valid(unsigned long x)
 phys_addr_t __virt_to_phys(unsigned long x)
 {
 	WARN(!__virt_addr_valid(x),
-	     "virt_to_phys used for non-linear address: %pK (%pS)\n",
+	     "virt_to_phys used for non-linear address: %px (%pS)\n",
 	     (void *)x, (void *)x);
 
 	return __virt_to_phys_nodebug(x);
-- 
2.51.0


