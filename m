Return-Path: <stable+bounces-269691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NfOPIDU3Qmrm1wkAu9opvQ
	(envelope-from <stable+bounces-269691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 11:13:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CA26D7EE3
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 11:13:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yandex.ru header.s=mail header.b=p3Ba5InO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269691-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269691-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=yandex.ru;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 357EE301224C
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 09:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D0A3F7AB4;
	Mon, 29 Jun 2026 09:10:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069E13B42F2;
	Mon, 29 Jun 2026 09:10:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724255; cv=none; b=VftSqHKaSs8ML3SYwatLlThH59azBZ1WhDBl9nb5KjXzg7/056vRGs0hyKZia2Wp4SR/ge0ghc2su0ryhw9HnramC5K3hOYKpUY39SdduWq5C3a4Q9M1VbSmzcFdTFdknnavYhaAcu24PfzrvAwzCDtwqaKlASF2d/ElYqS8yDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724255; c=relaxed/simple;
	bh=g1nzx26XmJNXOfGsyOI6Z35gxmHuCw+gbaTM6Zu/ngE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eICbYJt1aRJ+SHzHX8Yw786QivBwDyY7DiTElBrmSUaKM8tf5YfOh9mtFJ0rlC1mVuhmtAkdHEr5jQYNPv8hcTi1Wge+RzQjZvTAFmq04MlPxQcCoeFIJsif29j66sqHJpnw5baTSLtlkm+njqKR5KFAdq69TKOLMw/fjSiOvtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=p3Ba5InO; arc=none smtp.client-ip=178.154.239.214
Received: from mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:bb8b:0:640:6ac7:0])
	by forward103d.mail.yandex.net (postfix) with ESMTPS id A3FBEC4705;
	Mon, 29 Jun 2026 12:10:43 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (smtp) with ESMTPSA id ZAZXGGsiDOs0-5jVX16YM;
	Mon, 29 Jun 2026 12:10:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1782724242; bh=xa8mxpQF1gWUMUNTX/3Xc9iwg6Tf8Ib7YDOWmAM4pJ8=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=p3Ba5InO56HaMPWNkPtOvS6h7ow6ARn/OigJksxiJ//wfH8jvghIcYwuazG94uG24
	 mJYeqQI62mOA4zhdU6FnPrHwpqIJoPZHcOx2eCJSNCs3YA9URjckaL+smgd4lTi7KC
	 3Y0yVV+Ffs4PD7Ay5HG/2kyUt7x+D6lApen6mmw4=
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
	lvc-project@linuxtesting.org
Subject: [PATCH v4 0/3] drm/amd/display: Fix dangling pointers in state reset functions
Date: Mon, 29 Jun 2026 12:04:28 +0300
Message-ID: <20260629090435.9729-2-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
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
	TAGGED_FROM(0.00)[bounces-269691-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[evg28bur@yandex.ru,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[yandex.ru,amd.com,igalia.com,gmail.com,ffwll.ch,kernel.org,suse.de,oss.qualcomm.com,intel.com,lists.freedesktop.org,vger.kernel.org,linuxtesting.org];
	FREEMAIL_FROM(0.00)[yandex.ru];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:evg28bur@yandex.ru,m:harry.wentland@amd.com,m:sunpeng.li@amd.com,m:siqueira@igalia.com,m:alexander.deucher@amd.com,m:christian.koenig@amd.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:mario.limonciello@amd.com,m:alex.hung@amd.com,m:superm1@kernel.org,m:timur.kristof@gmail.com,m:ivan.lipski@amd.com,m:ray.wu@amd.com,m:aurabindo.pillai@amd.com,m:chen-yu.chen@amd.com,m:mripard@kernel.org,m:Dillon.Varone@amd.com,m:mwen@igalia.com,m:chiahsuan.chung@amd.com,m:kenneth.feng@amd.com,m:srinivasan.shanmugam@amd.com,m:tzimmermann@suse.de,m:Alvin.Lee2@amd.com,m:dmitry.baryshkov@oss.qualcomm.com,m:chaitanya.kumar.borah@intel.com,m:ekurzinger@gmail.com,m:pierre-eric.pelloux-prayer@amd.com,m:HaoPing.Liu@amd.com,m:Tony.Cheng@amd.com,m:amd-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:timurkristof@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxtesting.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5CA26D7EE3

This series fixes a dangling pointer issue in three reset functions:
- amdgpu_dm_plane_drm_plane_reset()
- amdgpu_dm_crtc_reset_state()
- amdgpu_dm_connector_funcs_reset()

Each function frees the old state before allocating a new one. If
kzalloc_obj() fails, the function returns without updating the state
pointer, leaving a dangling pointer to already freed memory.

The fix is to allocate the new state first. On allocation failure,
the old state remains untouched and the function safely returns.

For the connector function, additionally restore the explicit
kfree(old_state) which was lost during refactoring.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
Evgenii Burenchev (3):
  drm/amd/display: Fix dangling pointer in plane reset function
  drm/amd/display: Fix dangling pointer in CRTC reset function
  drm/amd/display: Fix dangling pointer in connector reset function

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 39 ++++++++++---------
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  8 ++--
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 10 ++---
 3 files changed, 28 insertions(+), 29 deletions(-)
---
Changes in v4:
- Split into three separate patches as requested (reviewer Fedor Pchelkin)
- Remove WARN_ON on memory allocation failure (reviewer Fedor Pchelkin)
- Remove redundant comments (reviewer Fedor Pchelkin)
- Fix empty line in local variable declaration block (reviewer Fedor Pchelkin)

Changes in v3:
- Restore explicit kfree(old_state) in amdgpu_dm_connector_funcs_reset()
  to prevent memory leak (reviewer Mario Limonciello)

Changes in v2:
- Also fix amdgpu_dm_crtc_reset_state() and amdgpu_dm_connector_funcs_reset()
-- 
2.43.0


