Return-Path: <stable+bounces-248928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMkIOOCTB2pU9AIAu9opvQ
	(envelope-from <stable+bounces-248928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 23:45:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F9E558663
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 23:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C70330142BF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 21:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A773EDE5B;
	Fri, 15 May 2026 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="AIwWVeeG"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3167E3ED5C7;
	Fri, 15 May 2026 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778881496; cv=none; b=s57T3iDRvvAQQlMC61DkMUlqLU9p/n22eI456EWqlTOnodMt/ZztHUjk703v9Hhgmj9Rw5sF6mGeGW1oglUcYZB3p5edKdQlo0ItIYGjZIZQtVH+TNsiGq7LcZx1B78AGECsTqEmcaBbcakAjl8mTEN2X2w3zP4dz16TogemTzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778881496; c=relaxed/simple;
	bh=Rhhg2VREEvIkK1nSeGi18mzV3AWkkFohy/JeEFpVuoc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CNyuiRkmslU52nWRW03pEbeiO7E2l6tzbMjEN/dIR3KwCxKDOo5w1M0cyrfiCZ/d1OehQ1N91Dn8/AUK2gtLhJUsseKDfX+FV/pe5othADIlbaLnesa49HWbAAUIYSTqys994zjjzjcPj0WjPyvEBDiQVPp+G+TGzfL+F+0N6Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=AIwWVeeG; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9979F27247;
	Fri, 15 May 2026 23:44:53 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5xyq5njVtx1n; Fri, 15 May 2026 23:44:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1778881492; bh=Rhhg2VREEvIkK1nSeGi18mzV3AWkkFohy/JeEFpVuoc=;
	h=From:Subject:Date:To:Cc;
	b=AIwWVeeGEiZ1bvnKDoVLlCWcTol8A7r9mVSh6L69qV/hZgTkqIEASfdjkDVa+ZKsH
	 jSCvI4g6Vguqvx+sS/jf/OkeOOIBgBvF66M7l/aXQmrpXJ4vD42eWTYp69KzwuWUrL
	 Pid0O3NT4Vbjfeic/a/UXbALoL+BzFUMdl7yDap7p16qf3LYbhiaxefSGzM92Ha7dA
	 d7yXFfD+xtCeevmFQJj8LnS4nZX04g2+jEGRPhNYjHBnqjkBnvX+5GsgmqwIxXWbDc
	 QSfWEuTHwx7wk00HeYzZXmU8fv6zE8Wqn82IKNLyBM0itp3x6O4kiRpkRLajhLCfBz
	 VKz9oYSX3WDVw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH RESEND v2 0/2] Fixes and enhancements for Exynos (7870)
 DSIM bridge driver
Date: Sat, 16 May 2026 03:14:29 +0530
Message-Id: <20260516-exynos-dsim-fixes-v2-0-db9bf96ae641@disroot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
X-Rspamd-Queue-Id: 46F9E558663
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248928-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[samsung.com,amarulasolutions.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[disroot.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kauschluss@disroot.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,disroot.org:email,disroot.org:mid,disroot.org:dkim]
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


