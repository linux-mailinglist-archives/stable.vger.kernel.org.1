Return-Path: <stable+bounces-227344-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMMvOzQrvGn4twIAu9opvQ
	(envelope-from <stable+bounces-227344-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 17:58:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 567862CF3CF
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 17:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBF7E31B80D1
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 16:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C413EF0CC;
	Thu, 19 Mar 2026 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cys1qTs3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2349C3ED127
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938923; cv=none; b=i8Vh6YDczjFcVRJebH0u/WqA+qyyQl3/C/rkEWp0G/PDdDeoENSmmB+Ai8oBZpqDfydksjinew3BJ47IXwF1uivW8rqFp+47Mc6I5KI3SAh5MWu6rLEuQJqVeDD+s2v//V0xyDmliNXYVCURAT05EZ4vwUExviznt0nQomKqs+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938923; c=relaxed/simple;
	bh=lG7q/6k0q0qW2KK6r9Mb23Fu+RroCNbNZ7rN3IIIBjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dyn5kIl9OzvgcQzeHDcljncaYYlLhUjijgwMsU34pCqLx4XX8ydGh39SOZTkqrTq/dl7iuPcDcQTEQK3MgVAfXq6Tz76AIJ6oPWezUOD88vBkcSFyhK2F1GybnoJCaKlnksBDASSa7G/g+xQU0fH+jHkVrRzUKq12NV3469EaEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cys1qTs3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486507134e4so14135645e9.0
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 09:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773938917; x=1774543717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bng5/yZC9lrbuKxC9dU3uqE7D/V7iSIEJ7NDOj06TGk=;
        b=Cys1qTs3o5xUjdEgBxYpXHx1X+CLAXAkA3iVPOf3haNJCKVgT4nLzRwLFLSG690SFd
         R2k5PpXNe92Ki02g3IsJHOmCqRmrju0tj02NbTIJMYzIWLuMT64xJ8AOTiCtdUlTXDNH
         NQxEvKJ10OIMUuwFqgyD3pJ5aLFD+WcjXLwUVzaVxXEjz8hoQFUCo7WnYTQq32UpA+Pa
         d75GCmMOBkKlqvIJvFPu1njhUVH304ah0391HeM+BB3n8waC+a/oS6rNeNzJwYczfGWi
         5eMVT4R7bCLC9Jl1VY7jkExOcSPqXUtGC/7WJxYVN8iE1wXJvyHwl33SYc+nTA5B3Bu3
         Raog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773938917; x=1774543717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bng5/yZC9lrbuKxC9dU3uqE7D/V7iSIEJ7NDOj06TGk=;
        b=RdUSkUeEOvHLBgRT29qdr9y/lVPJ0R6eN32QdXEJptbTDhMVIHJHIXAq/gf/CxsSIq
         RBOrDK7WCkHLOfX9v3GnFEzdhePMBZ+R+oSp3I+GGwhUa7/J8VCQGU7q3zzlPnBnuLMU
         Ql+YrNnP+iqaA7Y2U5dE4ykmgUeiCoWgI7ju0VLlyq4FOzwj3ZvI6wS1bLLulTnnv1KJ
         I4EUILZ4b2OL+b7fj2DaDWf/hjU4UpqcnlABkwBLeLcN0nFs1Z/xlLEyAJoZ1s1MsGfn
         mT9SGymcN3UflRRH73zWvgWzAp2N0LijSggKaJ1AXs1k/wpg2MvS2NMjo7Eu5dXrpuH4
         um0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCzmGHsf9ho/3usXy7+23mggKF82dQGgM59ybHMcGhUyat9sEEyqgV5Qma2E4XxPNumcCSY74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKAkozS20T2LwBMH0i4JV59txJ74vBpw++GmhijTWqMZ1IY3Zj
	2PlW93VeohHNX7bu1tJ4kbJC22GH51Hct9ynkW/JFP1cjfA5uDBQnyvx
X-Gm-Gg: ATEYQzyYJHUwokc742nq/CmTEx04Zv6NzNn29na6oOkpFuh3uOhPJaPn38cmX9EECe+
	G51F5mG9Q4jiilPkDHDA3pPL7g4YJJ/Xr9UQAIDwxcW4zhLcNSx6PKiiT9JK6m6QoVjn/wn5jN7
	7KmKyHQLYE5/+NrX6/PYKqQatUME4v4vtbjJcxFCMS7qfbBgbHzs+IgdeRc2CjyRnooxbnJ7UNq
	bRYkw07ZRb25Ri5sqF+MixnqgDIHXJ3HHVWuf1qeLUtM42fubGePmasHkPK7Ii+HCUnlcE5FYwy
	ej0Fj6bToFCHJU8WdskCJ7XaS+h2jyljLITunIOSJrdlkRX6IL2Izc97I2Wdo7M7f9rTQUmP5MF
	m38HH7/hC/3j8mnmjvd+qWg2KgVr4uvalBH3jRx1h9zP08SVqHLKwvNEdpUTMGiEYv99wgNaLHp
	D2To3MO0h3qMe5dOz7ZuKUdWHaViCGTZM=
X-Received: by 2002:a05:600c:c490:b0:485:379b:57bb with SMTP id 5b1f17b1804b1-486f441bc19mr132327915e9.3.1773938916947;
        Thu, 19 Mar 2026 09:48:36 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:8326:7b31:bf82:d2d0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe68ec05sm5238505e9.0.2026.03.19.09.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 09:48:36 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Chris Brandt <chris.brandt@renesas.com>,
	Hugo Villeneuve <hugo@hugovil.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dri-devel@lists.freedesktop.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/4] drm: renesas: rzg2l_mipi_dsi: Fix assert of CMN_RSTB signal
Date: Thu, 19 Mar 2026 16:48:26 +0000
Message-ID: <20260319164833.409126-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319164833.409126-1-biju.das.jz@bp.renesas.com>
References: <20260319164833.409126-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227344-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bp.renesas.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[renesas.com,hugovil.com,ideasonboard.com,ravnborg.org,lists.freedesktop.org,vger.kernel.org,glider.be,bp.renesas.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,renesas];
	NEURAL_HAM(-0.00)[-0.841];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,bp.renesas.com:mid]
X-Rspamd-Queue-Id: 567862CF3CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Biju Das <biju.das.jz@bp.renesas.com>

The CMN_RSTB reset signal is not required for reading PHY registers in the
probe. Move reset_control_assert() from rzg2l_mipi_dsi_dphy_exit() to
rzg2l_mipi_dsi_stop(), placing it before the dphy_exit() call. Since this
reset signal is optional for RZ/V2H, the call is a no-op on that SoC.

Fixes: 2991c3f0ca86 ("drm: renesas: rz-du: mipi_dsi: Add OF data support")
Fixes: 418bb3a69e13 ("drm: rcar-du: rzg2l_mipi_dsi: Enhance device lanes check")
Cc: stable@vger.kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2:
 * New patch
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index ff95cb9a7de5..d2da247abf05 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -541,8 +541,6 @@ static void rzg2l_mipi_dsi_dphy_exit(struct rzg2l_mipi_dsi *dsi)
 
 	dphyctrl0 &= ~(DSIDPHYCTRL0_EN_LDO1200 | DSIDPHYCTRL0_EN_BGR);
 	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYCTRL0, dphyctrl0);
-
-	reset_control_assert(dsi->rstc);
 }
 
 static int rzg2l_dphy_conf_clks(struct rzg2l_mipi_dsi *dsi, unsigned long mode_freq,
@@ -822,6 +820,7 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
 
 static void rzg2l_mipi_dsi_stop(struct rzg2l_mipi_dsi *dsi)
 {
+	reset_control_assert(dsi->rstc);
 	dsi->info->dphy_exit(dsi);
 	pm_runtime_put(dsi->dev);
 }
-- 
2.43.0


