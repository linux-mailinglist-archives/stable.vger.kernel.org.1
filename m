Return-Path: <stable+bounces-272892-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dkn0D1uPT2q9jgIAu9opvQ
	(envelope-from <stable+bounces-272892-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 14:08:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD1A730D42
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 14:08:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yandex.ru header.s=mail header.b=L0VCLLRO;
	dmarc=pass (policy=none) header.from=yandex.ru;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272892-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272892-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA4C53040954
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 12:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9163B42D1;
	Thu,  9 Jul 2026 12:08:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from forward200b.mail.yandex.net (forward200b.mail.yandex.net [178.154.239.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1456A318EC4;
	Thu,  9 Jul 2026 12:08:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598890; cv=none; b=PxdCMEvVAs1FdS7WtBJGwF8QHDT6oUNiJRT1J7j3Vrz7pMQGlfqSs44zq/h+wm6WTs8z6ARAR4Uxm96XaB57nnXwCI8TaO/feJCg65Ku7v2fNyRh8GVfc+4l7XaAZWbwczeAljZ1fv2nmfw3rmNnM7LuMDs6tnJlw+OrhkrX8UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598890; c=relaxed/simple;
	bh=5vU4BuFEmhYgmqBpPIlL0IFB6p1lp0aJ2lPZMH+4lGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d44DnkwdHEm2uRKPfp7guXUw1UduzzBGLtbP00mG/3ptaeACUbUYzeZS5W/QMFtOQ6YhXr1zpTbpJBqrRGGgLm+dOwb9ehd/sgfAFfg9n9ksEB441ye3YIYh4/AmjmBcg/3HMKfgr6O/lz8i0375u9e5KjqvY2/mXsk8SxWXQ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=L0VCLLRO; arc=none smtp.client-ip=178.154.239.157
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward200b.mail.yandex.net (postfix) with ESMTPS id E3E6881F56;
	Thu, 09 Jul 2026 15:01:39 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:2281:0:640:870e:0])
	by forward101b.mail.yandex.net (postfix) with ESMTPS id 586B3C1CA3;
	Thu, 09 Jul 2026 15:01:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (smtp) with ESMTPSA id Q1JKHN8fGeA0-E1hKzfgN;
	Thu, 09 Jul 2026 15:01:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1783598490; bh=Q2IgRKlmontnVqFHpJDdJWiJuotI3IXzRQ02ZlLmDjI=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=L0VCLLROIzZFaC5zfeth9mIK/TI1XS7pKiEvUY64D2lmaM5am/z++wB14/L0Uh9Gb
	 MJtYbRXUndoJ2Hmoz4f8QoV3nSSOsOqdjuuPHnvt6TB+eMx2oSZuIzxqlhLXzYQLAH
	 iv/N+BfIvBkTBO4cpIt7FSZZQbyLwy+KzBKF1Xpc=
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Jack.Xiao@amd.com,
	Hawking.Zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.6] drm/amdgpu: Use scnprintf() in amdgpu_mes_add_ring()
Date: Thu,  9 Jul 2026 15:00:48 +0300
Message-ID: <20260709120049.42048-1-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yandex.ru,none];
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[yandex.ru,amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,linuxtesting.org];
	FREEMAIL_FROM(0.00)[yandex.ru];
	TAGGED_FROM(0.00)[bounces-272892-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:evg28bur@yandex.ru,m:alexander.deucher@amd.com,m:christian.koenig@amd.com,m:Xinhui.Pan@amd.com,m:airlied@gmail.com,m:daniel@ffwll.ch,m:Jack.Xiao@amd.com,m:Hawking.Zhang@amd.com,m:amd-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[evg28bur@yandex.ru,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evg28bur@yandex.ru,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yandex.ru:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxtesting.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BCD1A730D42

Replace sprintf() with scnprintf() to prevent a potential buffer overflow
when writing to ring->name. The buffer size is 16 bytes. For compute rings,
the string format "compute_%d.%d.%d" can exceed this limit when the total
number of digits in the three numbers is greater than 5 (e.g., pasid=1234,
gang_id=0, queue_id=0). This can lead to memory corruption.

Using scnprintf() guarantees that the buffer is not overflowed, even if the
string is truncated. This is a minimal fix for the issue; the BUG() for
unknown queue types is left unchanged to avoid additional risk.

This code is only present in LTS kernels v6.12, v6.6, and v6.1, as it was
completely refactored in upstream. Therefore, this patch is specifically
intended for stable trees.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d0c423b64765 ("drm/amdgpu/mes: use ring for kernel queue submission")
Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 5e3abdd0805b..076d9069aa30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1072,13 +1072,14 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
 	ring->doorbell_index = qprops.doorbell_off;
 
 	if (queue_type == AMDGPU_RING_TYPE_GFX)
-		sprintf(ring->name, "gfx_%d.%d.%d", pasid, gang_id, queue_id);
+		scnprintf(ring->name, sizeof(ring->name), "gfx_%d.%d.%d",
+			pasid, gang_id, queue_id);
 	else if (queue_type == AMDGPU_RING_TYPE_COMPUTE)
-		sprintf(ring->name, "compute_%d.%d.%d", pasid, gang_id,
-			queue_id);
+		scnprintf(ring->name, sizeof(ring->name), "compute_%d.%d.%d",
+			pasid, gang_id, queue_id);
 	else if (queue_type == AMDGPU_RING_TYPE_SDMA)
-		sprintf(ring->name, "sdma_%d.%d.%d", pasid, gang_id,
-			queue_id);
+		scnprintf(ring->name, sizeof(ring->name), "sdma_%d.%d.%d",
+			pasid, gang_id, queue_id);
 	else
 		BUG();
 
-- 
2.43.0


