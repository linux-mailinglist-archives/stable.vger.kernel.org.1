Return-Path: <stable+bounces-147882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F7DAC5AEE
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 21:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73AA28A2134
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383932DCBF0;
	Tue, 27 May 2025 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="Ox9w5Kfx"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC35354F81
	for <stable@vger.kernel.org>; Tue, 27 May 2025 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748375115; cv=none; b=Rspjr0VGhoUh/VjUkC8xGXDTBrNfjFyNvfNXv5+p2HjtIGDtoi4Rxp+/bGfHW6MgPcWMseTwTD7y6QAme4WC/3AqacRw5cMZYupXfY1KEI56e/W9IPgriOqgD8uXb0lYYx0P4AhBh4FA5zVDAW891ut4nf8kVY2GVOdzwc0//eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748375115; c=relaxed/simple;
	bh=7uFjyvxlMG9Jro52mtHPkeSk3WljRlHZIKEUy4WdKzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BU9pbJCBaMX3Zlp1r5YipWacvL+/her6kyabmPBZrt+GK5B2aqjFuc9/kjQ7UsDaDA1hNdyjcwUSZ5yO/JuxRW1aXnJqGawfchXUzQ3NOT6Xja3dLl1iXD7qOQKrTC5g95lx6dOpWuamqU2ed4LqcKvd3C62CYQLyyPQXNbvS7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=Ox9w5Kfx; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1748375099; x=1748979899; i=natalie.vock@gmx.de;
	bh=yy55+GQV07DU1PlzulpC7ZxEesUJ7cu0Lq4pW8qpSO8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ox9w5KfxuQqHQbX5WA7aHw/zkE1JIBgYtSfmKgMVW7QESlzq+TGKOo0LaIMINhQR
	 io00drwGalWBHCg0EmJuGrC0pDKiCPJLZAZXqrHNSfrnxeTPgv/7QE+0AnFFRVm4O
	 Vr1T/V0PCUh1Yalw/SUMxFxvcYGVuCjdE/TRlhTUpSqwaVEeQpyePC+FrOKGicYQE
	 MVWJhmyAZVieNSEi+fddmpmTVdPZo7QvtKwmjV1SmL5ugEr9L4yRtr/l75j+/lyWO
	 ho5ST6gD63xjwh0zzbA3G3cUGHf6V/S+yHpCLwUpruS8ea/0+VSauIZHejiGEq22S
	 agGFPx4ow1mMaUKhSw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([109.91.201.165]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MMGRA-1ua0wn2Pva-00LF1d; Tue, 27 May 2025 21:44:59 +0200
From: Natalie Vock <natalie.vock@gmx.de>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	Natalie Vock <natalie.vock@gmx.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/buddy: Add public helper to dirty blocks
Date: Tue, 27 May 2025 21:43:52 +0200
Message-ID: <20250527194353.8023-2-natalie.vock@gmx.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527194353.8023-1-natalie.vock@gmx.de>
References: <20250527194353.8023-1-natalie.vock@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:euWBSkH/f7kf5t01BmVT6vYLv/uqhWZUx+ZzS3mguzTWxtVN4Y8
 GT6j+7qC2TDS2a+S7udASu0bTcRn//gdrL/ailn3KPDRtP2Vpsqk8RmPqf667NtjCMraBPg
 c9hrBvdBEUaMkoSsEaR+MAPdfkN63yjkna0iPiAXCoQEkH/G2KDHln/5u9rILPH5d56Is/r
 Ch8Kn64dT8ZIbLj/zsC0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+tnUOAMDi18=;teqbMi9YqtVcxHYenirkFNud8Pe
 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

Cleared blocks that are handed out to users after allocation cannot be
presumed to remain cleared. Thus, allocators using drm_buddy need to
dirty all blocks on the allocation success path. Provide a helper for
them to use.

Fixes: 96950929eb232 ("drm/buddy: Implement tracking clear page feature")
Cc: stable@vger.kernel.org

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 include/drm/drm_buddy.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/drm/drm_buddy.h b/include/drm/drm_buddy.h
index 9689a7c5dd36..48628ff1c24f 100644
=2D-- a/include/drm/drm_buddy.h
+++ b/include/drm/drm_buddy.h
@@ -142,6 +142,12 @@ drm_buddy_block_size(struct drm_buddy *mm,
 	return mm->chunk_size << drm_buddy_block_order(block);
 }
=20
+static inline void
+drm_buddy_block_set_dirty(struct drm_buddy_block *block)
+{
+	block->header &=3D ~DRM_BUDDY_HEADER_CLEAR;
+}
+
 int drm_buddy_init(struct drm_buddy *mm, u64 size, u64 chunk_size);
=20
 void drm_buddy_fini(struct drm_buddy *mm);
=2D-=20
2.49.0


