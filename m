Return-Path: <stable+bounces-272886-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JB4rONCJT2qMjAIAu9opvQ
	(envelope-from <stable+bounces-272886-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 13:45:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D93107308BD
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 13:45:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yandex.ru header.s=mail header.b=JJnxkTph;
	dmarc=pass (policy=none) header.from=yandex.ru;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272886-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-272886-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0346D30015B6
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 11:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DE6409631;
	Thu,  9 Jul 2026 11:45:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A143D3B5306;
	Thu,  9 Jul 2026 11:45:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597514; cv=none; b=nHhX/QExKfRurancBgpcgz5TrOlREywLOS3Mrjsq8zpYbfR9LQTZRkNYiao3S2pLY3htnINBVvfvI9lY5+5YYmAn0l+0PbKWzpegjECEBzFm6afVXjB5ZxWtYjdHW2xER7X24OVMICFj5C4TL/qohPds8aHSGhenAz7UUxX0zjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597514; c=relaxed/simple;
	bh=0KDZiaZVZAXpVc7F5zji7D3nRwQNJdLeKoH5O3io19I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZiZt/EyVLgsBE2+iwQgSwxZWmQ5C6GbVTBFMPXUCuyAEhznQW446jFBCcAb78KiOXjSHhxbHxZCB3RsywWGd6DzLCCbd/mTCeSAhX/MLRF9qbV34qt1VcKWjM3UnHRo95IA9c8sKprmfgZfGOUvvx5ZhsEkKRo6Tm8JjrPqUvKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=JJnxkTph; arc=none smtp.client-ip=178.154.239.84
Received: from mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:8912:0:640:42ab:0])
	by forward101a.mail.yandex.net (postfix) with ESMTPS id 636D7813A0;
	Thu, 09 Jul 2026 14:45:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.iva.yp-c.yandex.net (smtp) with ESMTPSA id XiINBd2oAW20-NotBx8gv;
	Thu, 09 Jul 2026 14:45:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1783597500; bh=Sn4PDwvqECVmn5QwC9xACIgixKNG02XVFvorw97wcag=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=JJnxkTphY1wk1F4GdglB+oVxK6nm6kat67MZhXzU92v1HXvTMkB89MzWaByUEMk+b
	 u5aJTsnbq1+5/10mSOWSLrCzHl1x2OVQUEsXzLJbOy2xbccr43Dx/mB3Vtm8skyJrg
	 0phQWfe2l5xRr6kFZvbxXEQyK2yFtdlr+BT3yBIg=
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	sashal@kernel.org,
	michael.chen@amd.com,
	Jack.Xiao@amd.com,
	Hawking.Zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.12] drm/amdgpu: Use scnprintf() in amdgpu_mes_add_ring()
Date: Thu,  9 Jul 2026 14:44:26 +0300
Message-ID: <20260709114427.41013-1-evg28bur@yandex.ru>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[yandex.ru,amd.com,gmail.com,ffwll.ch,kernel.org,lists.freedesktop.org,vger.kernel.org,linuxtesting.org];
	FREEMAIL_FROM(0.00)[yandex.ru];
	TAGGED_FROM(0.00)[bounces-272886-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:evg28bur@yandex.ru,m:alexander.deucher@amd.com,m:christian.koenig@amd.com,m:Xinhui.Pan@amd.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:sashal@kernel.org,m:michael.chen@amd.com,m:Jack.Xiao@amd.com,m:Hawking.Zhang@amd.com,m:amd-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[evg28bur@yandex.ru,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evg28bur@yandex.ru,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yandex.ru:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linuxtesting.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D93107308BD

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
index 41b88e0ea98b..746cb0c71fb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1236,13 +1236,14 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
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


