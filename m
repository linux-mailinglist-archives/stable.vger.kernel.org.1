Return-Path: <stable+bounces-211467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pWWEMAECdWmi/wAAu9opvQ
	(envelope-from <stable+bounces-211467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 18:31:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6B47E4E7
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 18:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5948D3006B57
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 17:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0335421CC5C;
	Sat, 24 Jan 2026 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="NLNgiRAU"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EE52BD0B;
	Sat, 24 Jan 2026 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769275897; cv=none; b=JEHKqviwWHvbnOQge24IlRrrYumDrp4QG3cENOWdRNUPE7ywd1/n9DBST3bQlyroH3tc0r6kWjuEPiE6YHN47u77z9YRevKBMI4O6ASA2vqVD/yq0cDTEPTEVRS4b84lqfTRRHJP0wiRQFKgMmWOX0/joEmPPzbzDYEQdJ4W3k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769275897; c=relaxed/simple;
	bh=wakJy6/WI3zTSTIk8b8zvkA5paropCtJ2eepRXWqQyM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lVZCBdqb0W1dSQdXjmDejqNjKbTQSsaO6sbs27FW0rGV8zWKsU/V6dL8Sur5eNS+g9eiEwCK3WoMFoy1i9m+cBWQ7sxkKONwoNT97KoYz1tVod/P5CU3D27DgblRUbgTf1it5nzauMVkH8cWzKxj9M6wGMyor+tB2ojQqHL05TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=NLNgiRAU; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7AC5527D6A;
	Sat, 24 Jan 2026 18:21:24 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MgCn9sH1KmQz; Sat, 24 Jan 2026 18:21:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1769275283; bh=wakJy6/WI3zTSTIk8b8zvkA5paropCtJ2eepRXWqQyM=;
	h=From:Subject:Date:To:Cc;
	b=NLNgiRAUSNu+C7VqTTpq24xo+YEhzfQ1UUc+5tmAkiOpp5B6o7AF2ZpHkiHyHwyMC
	 Mf+pj9Y3OiG4W/Fi+j5AqhGthXxmm8694mcFJEQ8wUTur/qoZ0cGvI+uRRUcSugq1Z
	 vxsamL56bngG+MViXlKfhR49S8RQp3JuytmO8a3Iea7a+S8kmXq5mlSfCXX6HFh+0C
	 CeWHJBZX3oXPwWGRcVHatPXk/M8r4+DKv9xABakHaLwk1roxLMC8x484ayN8l1ybCM
	 PO7Nkd34Ho4q+U/XtGXht2dup7pdvg8w4fT7/bRY74dl2Qt4wpveA6SQIKZN8lqxCD
	 znAFPKgNEmTGA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: [PATCH 0/3] Fixes and enhancements for Exynos (7870) DSIM bridge
 driver
Date: Sat, 24 Jan 2026 22:50:45 +0530
Message-Id: <20260124-exynos-dsim-fixes-v1-0-122d047a23d1@disroot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG3/dGkC/x3LQQqAIBBA0avErBswLYuuEi0ip5pFGg6EId09a
 fn4/AxCkUlgrDJEulk4+IKmrmA9Fr8TsisGrbRVjW6R0uODoBM+ceNEgp0ZjLOL3VRvoHxXpD+
 UbZrf9wPyZ+ovYwAAAA==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211467-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[disroot.org:email,disroot.org:dkim,disroot.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C6B47E4E7
X-Rspamd-Action: no action

Since v6.17, there were a few regressive changes for the Exynos 7870
DSIM driver. These changes resulted in weird artifacts on the display,
such as random RGB channel swaps and random aberration (the occurrences
of both were mutually exclusive).

The first two commits of this patch series address the aforementioned
changes.

The third patch replaces an implicit loop for waiting for PLL
stabilization with an interrupt-based solution, which should be more
reliable. This solution was suggested by Inki Dae in a discussion of an
earlier patch series sent by me. For further details, refer to its
commit description.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
Kaustabh Chakraborty (3):
      drm/bridge: samsung-dsim: move bridge init sequence to atomic_enable
      drm/bridge: samsung-dsim: enable MFLUSH_VS for Exynos 7870 DSIM
      drm/bridge: samsung-dsim: use DSIM interrupt to wait for PLL stability

 drivers/gpu/drm/bridge/samsung-dsim.c | 61 +++++++++++++++++++++++------------
 include/drm/bridge/samsung-dsim.h     |  1 +
 2 files changed, 42 insertions(+), 20 deletions(-)
---
base-commit: ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea
change-id: 20260124-exynos-dsim-fixes-5383d6a6f073

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>


