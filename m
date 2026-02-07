Return-Path: <stable+bounces-214819-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFtJHg2Ph2kzZwQAu9opvQ
	(envelope-from <stable+bounces-214819-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 20:14:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FBF106EF4
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 20:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0B96301372B
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 19:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D71533B6FB;
	Sat,  7 Feb 2026 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="TxpfUjwL"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A233B6F0;
	Sat,  7 Feb 2026 19:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770491656; cv=none; b=uzlaVOjuL4+JNqasMZSM3ZNpyEDfM2x1ssCt8nZnEAGZlAp7OOJkOU21/RhuNZtzpQnaZe/csCG4soVeYYFlZCDhnaWXB89LqN9O9JYmneg/OOp5A5Ahv9iJ2/+3YJjdmQBM3rGVRekRDohlF59YROWcfdn2RRfzaigXTaYaJvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770491656; c=relaxed/simple;
	bh=Rhhg2VREEvIkK1nSeGi18mzV3AWkkFohy/JeEFpVuoc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I4FlO7Do5kl6xB7yynD6H+5U7g/ST3dTFWK+Iq0z55spjUrWKcg36EqhX9y1h8OU+doDChN4UqCzkW0TmTWF4LRn/npwTOhFGFFIlMEIFpjSY0NCJu8vp/xxYnZzUoHe9ex0nFADbFBPVyfIHkOJDBaIlqHUieQGXA79NRZU/78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=TxpfUjwL; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D1569262C2;
	Sat,  7 Feb 2026 20:14:12 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sGAiZcTIynir; Sat,  7 Feb 2026 20:14:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1770491652; bh=Rhhg2VREEvIkK1nSeGi18mzV3AWkkFohy/JeEFpVuoc=;
	h=From:Subject:Date:To:Cc;
	b=TxpfUjwLQckCYQOO74OAQ00dSzgMBCgEb2K0BB2zgZx0FdiRxyzFVwrRq5CiSLiaU
	 CuLY1E9kr0Ou1Y7BxDRzXq7rGVXNR3UTv/PS5Qpx/6sWwMAqzg18B/fUHX4JClwym9
	 /qudYSOCFQiruyPN6zFy2M/woAcWGY7w37GOMYFNMjnK5CraUl06n6+fJ8K/1gNvDz
	 dLdHCLIfclC6Rmrsnwu8bnXAHS2TjpUWjGIdTZVXMYYMM0sXxKRhxwW6gUHuCT19xD
	 meUADWB88F2MP2EXtLDIKXSnmYuLUSCuTwBhUhaQWGfcw1JYrp6aBIS5L//4AYmM6V
	 fjB9REgmhNpGw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH v2 0/2] Fixes and enhancements for Exynos (7870) DSIM
 bridge driver
Date: Sun, 08 Feb 2026 00:43:57 +0530
Message-Id: <20260208-exynos-dsim-fixes-v2-0-a857e8130a2a@disroot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPWOh2kC/32NQQ6DMAwEv4J8rqvEoaHqiX9UHFBjwIeSKkYIh
 PL3pjygx9nV7B6gnIQVHtUBiVdRiXMBulTwmvp5ZJRQGMiQN5Zq5G2fo2JQeeMgGyve3N0F3/v
 BNA6K90l8FkV7doUn0SWm/bxY7S/9t7ZaNGiJgqmbnlywbRBNMS7XmEbocs5f9sz6HLQAAAA=
X-Change-ID: 20260124-exynos-dsim-fixes-5383d6a6f073
To: Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, stable@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214819-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[samsung.com,amarulasolutions.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[disroot.org:+];
	NEURAL_HAM(-0.00)[-0.976];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,disroot.org:email,disroot.org:dkim,disroot.org:mid]
X-Rspamd-Queue-Id: E8FBF106EF4
X-Rspamd-Action: no action

Since v6.17, there is a regression for the Exynos 7870 DSIM driver. The
display occasionally had random aberration when the panel was turned on.
The first patch addresses that.

The second patch replaces an implicit loop for waiting for PLL
stabilization with an interrupt-based solution, which should be more
reliable. This solution was suggested by Inki Dae in a discussion of an
earlier patch series sent by me. For further details, refer to its
commit description.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Changes in v2:
- drop now-not-required [v1 1/3] (Marek Szyprowski)
- Link to v1: https://lore.kernel.org/r/20260124-exynos-dsim-fixes-v1-0-122d047a23d1@disroot.org

---
Kaustabh Chakraborty (2):
      drm/bridge: samsung-dsim: enable MFLUSH_VS for Exynos 7870 DSIM
      drm/bridge: samsung-dsim: use DSIM interrupt to wait for PLL stability

 drivers/gpu/drm/bridge/samsung-dsim.c | 48 +++++++++++++++++++++++++----------
 include/drm/bridge/samsung-dsim.h     |  1 +
 2 files changed, 35 insertions(+), 14 deletions(-)
---
base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
change-id: 20260124-exynos-dsim-fixes-5383d6a6f073

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>


