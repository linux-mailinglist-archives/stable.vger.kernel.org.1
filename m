Return-Path: <stable+bounces-119458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42094A43643
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 08:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135B13ACDBE
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 07:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B692225A33E;
	Tue, 25 Feb 2025 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="mohV7Dk/"
X-Original-To: stable@vger.kernel.org
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D30257423;
	Tue, 25 Feb 2025 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.182.119.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469194; cv=none; b=b5sGTqXCeTzBG05UHkfpT7DG+yr8jDHJSPkW8t7QvGuT3/J7ROlr1OuTfXQfIutf14h3XGtzaenVwsWpzYFc0G/rneu7vZNkjXbQ834aSTTnaxmlWkfP8V8bF1heU9NwdBDN9gYkFhb8Tc0I3knn8lUvy7Vbtu1TI9coEfgDaqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469194; c=relaxed/simple;
	bh=jJv616jfTn0ZGbYwwYOpX5lWgGqrU9i3HLdGP4o/yI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hNt1ZwZA1pAL4K7Wrs00wExZ0fed0KUpIFUPIYmh/FLcVekN619hK8G7OrMlpJxqggizP/wWnjivk5NmBJVsU+3yiQ19VGVXqNNGUbpgJ772S3gSSh6zETIPvqO5sP+0IhWiDG/7CeymVM033Q/US3UbeP6KZvE/vg8p1HclsXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=mohV7Dk/; arc=none smtp.client-ip=217.182.119.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id 1B67B3E917;
	Tue, 25 Feb 2025 07:39:51 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 897A84023E;
	Tue, 25 Feb 2025 07:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1740469190; bh=jJv616jfTn0ZGbYwwYOpX5lWgGqrU9i3HLdGP4o/yI8=;
	h=From:To:Cc:Subject:Date:From;
	b=mohV7Dk/6gbHatB+pznBJbKYR3zzmfXMIYKZUlHQhSxTRi+mgvypiWZ9bXfoiwWX6
	 k7UblRqmPpaPLQFUa6sR3J705ccGOtPrwf6IuUreTEd2CsQEFHGlmDOXOq8KqiqcHP
	 7D52fpiNBtJ5v7IjRGlPXxrI7uLsabDwJAQGowkA=
Received: from JellyNote.localdomain (unknown [203.175.14.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 55F72413A7;
	Tue, 25 Feb 2025 07:39:44 +0000 (UTC)
From: Mingcong Bai <jeffbai@aosc.io>
To: linux-kernel@vger.kernel.org
Cc: Kexy Biscuit <kexybiscuit@aosc.io>,
	stable@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matt Roper <matthew.d.roper@intel.com>,
	Ashutosh Dixit <ashutosh.dixit@intel.com>,
	Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
	Pallavi Mishra <pallavi.mishra@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	Ilia Levi <ilia.levi@intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/xe/regs: remove a duplicate definition for RING_CTL_SIZE(size)
Date: Tue, 25 Feb 2025 15:31:01 +0800
Message-ID: <20250225073104.865230-1-jeffbai@aosc.io>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: 897A84023E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.40 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	RCVD_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[stable.vger.kernel.org:server fail,jeffbai.aosc.io:server fail];
	FREEMAIL_CC(0.00)[aosc.io,vger.kernel.org,intel.com,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[]

Commit b79e8fd954c4 ("drm/xe: Remove dependency on intel_engine_regs.h")
introduced an internal set of engine registers, however, as part of this
change, it has also introduced two duplicate `define' lines for
`RING_CTL_SIZE(size)'. This commit was introduced to the tree in v6.8-rc1.

While this is harmless as the definitions did not change, so no compiler
warning was observed.

Drop this line anyway for the sake of correctness.

Cc: <stable@vger.kernel.org> # v6.8-rc1+
Fixes: b79e8fd954c4 ("drm/xe: Remove dependency on intel_engine_regs.h")
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
---
 drivers/gpu/drm/xe/regs/xe_engine_regs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/regs/xe_engine_regs.h b/drivers/gpu/drm/xe/regs/xe_engine_regs.h
index d86219dedde2a..b732c89816dff 100644
--- a/drivers/gpu/drm/xe/regs/xe_engine_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_engine_regs.h
@@ -53,7 +53,6 @@
 
 #define RING_CTL(base)				XE_REG((base) + 0x3c)
 #define   RING_CTL_SIZE(size)			((size) - PAGE_SIZE) /* in bytes -> pages */
-#define   RING_CTL_SIZE(size)			((size) - PAGE_SIZE) /* in bytes -> pages */
 
 #define RING_START_UDW(base)			XE_REG((base) + 0x48)
 
-- 
2.48.1


