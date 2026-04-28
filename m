Return-Path: <stable+bounces-241502-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC9bM+l38GlgTwEAu9opvQ
	(envelope-from <stable+bounces-241502-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:03:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BCB480D83
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74EC931BD633
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27AB3D47BD;
	Tue, 28 Apr 2026 08:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aquinas.su header.i=@aquinas.su header.b="C9GOKohh"
X-Original-To: stable@vger.kernel.org
Received: from hope.aquinas.su (hope.aquinas.su [82.148.24.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE3A3D47A7;
	Tue, 28 Apr 2026 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.148.24.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366009; cv=none; b=TxIVUSe3CgOGSlx9fgCs3CTBtLZdgCGfpYvCgkpiKi1lvkhikAsukgJ0GcaqlVRaMylxwXIbsmf+jg+CUZmZ5x0JeUKS4Mb9kk949rgf4aGFBUOAH//SJGtwr66O+wA4Z+WU8P9ix/ty7FbQ7+F3K9WUls57nmpf0E5OXwwgHys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366009; c=relaxed/simple;
	bh=xkqsIT3puJjVXufM4Rs//DVtzl914AuKJYlwfXxWa0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GnyOH1uKVOC1HYdX6e5jWYOo72qVF4o3RSa8ZipiO6vabWyYS24ZH+5zi9h8GNdlhrdnjZ9f69S15ZF+SxDN+coputYwKwQsP3TeBdG12igv+r6o0wCv3PxnlunRN0AjN4r4vPzhtD3Wao5Z0SyZ3xNE9FXxRu37jxTNtTyiSdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aquinas.su; spf=pass smtp.mailfrom=aquinas.su; dkim=pass (2048-bit key) header.d=aquinas.su header.i=@aquinas.su header.b=C9GOKohh; arc=none smtp.client-ip=82.148.24.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aquinas.su
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aquinas.su
Received: from woolf.localdomain (unknown [87.228.30.162])
	(Authenticated sender: admin@aquinas.su)
	by hope.aquinas.su (Postfix) with ESMTPSA id 9F3B470ED7;
	Tue, 28 Apr 2026 11:38:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aquinas.su; s=default;
	t=1777365507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JR5D7svhufHLHr7OlrUflbzz8ZcWnKvD1eCr/jJoanM=;
	b=C9GOKohhlbocQBpvwo8oT4GyXyniwMog5isSMowAOrdnlj87nqHHkmen5MFWRVr3hz5N+n
	XVTtyYhdQaZ8XDWRF83wq9ehun2LrIfGZ1/KWzuVLmtBwztMwComFgxseqKoEO0OXXb+qm
	oQtwcbWY8d2HGbwbmXmAgDjbxADxMwWdVK+CfNtFSS0Mb0RgqutAhZDhbU7v0SGuMNIM3Y
	igTgBT+gl6e0qIQNQPZvFwfatRxf2fmEBaODtb8QtA1PGgfCR0JEslkUJKOIwVIE0kc1+c
	SKV1Mw/QgFAWVtcJxpmr+5OST/o7XM41/y3onYNAyVchG2Y6rP5FkPCcI9bXTg==
Authentication-Results: hope.aquinas.su;
	auth=pass smtp.auth=admin@aquinas.su smtp.mailfrom=admin@aquinas.su
From:
 =?UTF-8?B?0JrQvtC90LXQvdC60L4g0JDQvdC00YDQtdC5INCS0LjQutGC0L7RgNC+0LLQuNGH?=
 <admin@aquinas.su>
To: ilpo.jarvinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
 platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject:
 [PATCH] fix support for thermal profile Omen =?UTF-8?B?MTYt0YEweHh4?=
 laptpops
Date: Tue, 28 Apr 2026 15:38:25 +0700
Message-ID: <T3DTKbKwQzOgk_0eUG-kMg@aquinas.su>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 23BCB480D83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[aquinas.su,none];
	R_DKIM_ALLOW(-0.20)[aquinas.su:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241502-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[aquinas.su:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[admin@aquinas.su,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The HP Omen 16-c0xxx (board ID: 8902) has the same WMI interface as
other Victus S boards, but requires additional quirks for correctly
switching thermal profile.

Add the DMI board name to victus_s_thermal_profile_boards[] table and map it 
to the omen_v1_legacy_thermal_params quirk.

Testing on board 8902 confirmed that platform profile is registered
successfully and fan RPMs are readable and controllable.

Signed-off-by: Konenko Andrey Viktorovich <admin@aquinas.su>
---
 drivers/platform/x86/hp/hp-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-
wmi.c
index d1cc6e7d176c..4ab47a43e4d4 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -197,6 +197,10 @@ static const struct dmi_system_id 
victus_s_thermal_profile_boards[] __initconst
                .matches = { DMI_MATCH(DMI_BOARD_NAME, "8A4D") },
                .driver_data = (void *)&omen_v1_legacy_thermal_params,
        },
+       {
+               .matches = { DMI_MATCH(DMI_BOARD_NAME, "8902") },
+               .driver_data = (void *)&omen_v1_legacy_thermal_params,
+       },
        { 
                .matches = { DMI_MATCH(DMI_BOARD_NAME, "8BAB") },
                .driver_data = (void *)&omen_v1_thermal_params,
--
2.54.0




