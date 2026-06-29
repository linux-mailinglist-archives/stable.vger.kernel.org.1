Return-Path: <stable+bounces-269692-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u6siBWk3Qmr81wkAu9opvQ
	(envelope-from <stable+bounces-269692-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 11:14:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F736D7F26
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 11:14:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yandex.ru header.s=mail header.b=ks5im5QQ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269692-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269692-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=yandex.ru;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 868B7303D2C7
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 09:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9993F7A9E;
	Mon, 29 Jun 2026 09:11:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711F93AE6FC;
	Mon, 29 Jun 2026 09:11:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724264; cv=none; b=NiOvpPWaL5THQzhj94anvjFCne0zV2p8+9UMISRxfl/xNAuBN/sGp63md/yYzCOsPT915SdAntxhguqsymv0N522fRP4k7QtyFIOztujxmWzISsYPlGB0iu/vvHjmPJBkNjwgeJegPcA7aYOCWZVR5OBvAtyJd+zJnzoYtgwRuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724264; c=relaxed/simple;
	bh=JQWfRBaTHIfEGArwPLkR5YHf5htkDdrB2wFUiDUyO0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p70mCnOUrgGTskJ6Piq1TwjEctb4tQ1uhN3R2UYAw6UbLdPrV0OpNUsUDlgW4+q4e1JYOPMocOMPozOSdF5r8tRWe5FIXQkSn8OR6ymmmXJnrHi0GZnlyuwCBva5/UQvmbDAwlNbbndqxpQb9Z7EHGexzPC6SIE6R8ypha0/rfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ks5im5QQ; arc=none smtp.client-ip=178.154.239.214
Received: from mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:bb8b:0:640:6ac7:0])
	by forward103d.mail.yandex.net (postfix) with ESMTPS id D8A06C4701;
	Mon, 29 Jun 2026 12:11:00 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (smtp) with ESMTPSA id ZAZXGGsiDOs0-e82wDVD8;
	Mon, 29 Jun 2026 12:10:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1782724259; bh=ozXm2Xvy6K1ZkZFvOIsIPVVdHjDSCB8gUTLLJ0/7c0k=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=ks5im5QQyUQzg9JH+aa30cTczRyFk3Ww3tnmluw6+PVrv+1Qf1qBsm6DesF7wkzoP
	 YfRrVxvvohrCvZ/QT+MdaeD6MJ6BgiPGX+ZWVcbiE3fLR4QiT8AVf8w8RI4C4/4MNw
	 Hr8SpgnsjrBNK1TPYsZoZ9hv0P3YFoZR7OOqqDXk=
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	mario.limonciello@amd.com,
	alex.hung@amd.com,
	superm1@kernel.org,
	timur.kristof@gmail.com,
	ivan.lipski@amd.com,
	ray.wu@amd.com,
	aurabindo.pillai@amd.com,
	chen-yu.chen@amd.com,
	mripard@kernel.org,
	Dillon.Varone@amd.com,
	mwen@igalia.com,
	chiahsuan.chung@amd.com,
	kenneth.feng@amd.com,
	srinivasan.shanmugam@amd.com,
	tzimmermann@suse.de,
	Alvin.Lee2@amd.com,
	dmitry.baryshkov@oss.qualcomm.com,
	chaitanya.kumar.borah@intel.com,
	ekurzinger@gmail.com,
	pierre-eric.pelloux-prayer@amd.com,
	HaoPing.Liu@amd.com,
	Tony.Cheng@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	mdaenzer@redhat.com
Subject: [PATCH v4 2/3] drm/amd/display: Fix dangling pointer in CRTC reset function
Date: Mon, 29 Jun 2026 12:04:30 +0300
Message-ID: <20260629090435.9729-4-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629090435.9729-2-evg28bur@yandex.ru>
References: <20260629090435.9729-2-evg28bur@yandex.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[yandex.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269692-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[evg28bur@yandex.ru,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[yandex.ru,amd.com,igalia.com,gmail.com,ffwll.ch,kernel.org,suse.de,oss.qualcomm.com,intel.com,lists.freedesktop.org,vger.kernel.org,linuxtesting.org,redhat.com];
	FREEMAIL_FROM(0.00)[yandex.ru];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:evg28bur@yandex.ru,m:harry.wentland@amd.com,m:sunpeng.li@amd.com,m:siqueira@igalia.com,m:alexander.deucher@amd.com,m:christian.koenig@amd.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:mario.limonciello@amd.com,m:alex.hung@amd.com,m:superm1@kernel.org,m:timur.kristof@gmail.com,m:ivan.lipski@amd.com,m:ray.wu@amd.com,m:aurabindo.pillai@amd.com,m:chen-yu.chen@amd.com,m:mripard@kernel.org,m:Dillon.Varone@amd.com,m:mwen@igalia.com,m:chiahsuan.chung@amd.com,m:kenneth.feng@amd.com,m:srinivasan.shanmugam@amd.com,m:tzimmermann@suse.de,m:Alvin.Lee2@amd.com,m:dmitry.baryshkov@oss.qualcomm.com,m:chaitanya.kumar.borah@intel.com,m:ekurzinger@gmail.com,m:pierre-eric.pelloux-prayer@amd.com,m:HaoPing.Liu@amd.com,m:Tony.Cheng@amd.com,m:amd-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:mdaenzer@redhat.com,m:timurkristof@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evg28bur@yandex.ru,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yandex.ru:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57F736D7F26

amdgpu_dm_crtc_reset_state() frees the old state before allocating
a new one. If kzalloc_obj() fails, the function returns without updating
the state pointer, leaving a dangling pointer to already freed memory.

Fix this by allocating the new state first. On allocation failure, the
old state remains untouched and the function safely returns.

Fixes: 473683a03495 ("drm/amd/display: Create a file dedicated for CRTC")
Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 3dcedaa67ed8..5b5c4023a514 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -437,13 +437,13 @@ static void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc)
 {
 	struct dm_crtc_state *state;
 
-	if (crtc->state)
-		amdgpu_dm_crtc_destroy_state(crtc, crtc->state);
-
 	state = kzalloc_obj(*state);
-	if (WARN_ON(!state))
+	if (!state)
 		return;
 
+	if (crtc->state)
+		amdgpu_dm_crtc_destroy_state(crtc, crtc->state);
+
 	__drm_atomic_helper_crtc_reset(crtc, &state->base);
 }
 
-- 
2.43.0


