Return-Path: <stable+bounces-213030-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFA5G7pZgGns6wIAu9opvQ
	(envelope-from <stable+bounces-213030-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 09:00:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB54BC9701
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 09:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DDE83018586
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 07:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4136B2EBDC8;
	Mon,  2 Feb 2026 07:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="1FTqiR+0"
X-Original-To: stable@vger.kernel.org
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136CE2C21C3;
	Mon,  2 Feb 2026 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770019121; cv=none; b=BqZQTy4uKhQpPJKnRSgAfE7qYsvh8R6cmWGqM8NIkYK0VT5/9fwBOJo68dqxAR5E+yoNIm206rPNiO6C7BdMKIYDaLMm8viBjcXDwnk2Wj6MHN8g02AQzKoMqTQqZloqlFPNITNdszCsnKD1g+AneXFMji2Ih4cPKdxTLxFZG4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770019121; c=relaxed/simple;
	bh=GFchh94KY6iI241akTdSE8cFka8LNsvDc6Ly558ZchM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eFW6emOi9phwPsVQRXMQYEcRxFji9IoEOv7LjuCQ1sU2uwanckKRLuoCC6cgm2sQrFRC41ASY+f83oTgPJPmKp7xtviqspppetTowFnjlJVjExL9uZBHKex+9xNQgYqX6EsaaSYzdORUj6PYs+EeSeGwbee9cF+8/uipAaX/Gbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=1FTqiR+0; arc=none smtp.client-ip=120.232.169.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=1FTqiR+0RedpPLCPg3Lc5cDKnHZURz5HHU7sHe6nfm1d+Zav7sx9EFVtRyZ7SL4WXMw5JCry3hhga
	 5d2AygOCXnfsd84lflJbfOE0HwWK7m8+XeG5VhIHeVox3Abo06cr5Z+OyG1AOdaXGqIxFULw7N3Skj
	 WZ/FppFfV/SKLSZ8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-32-12046 (RichMail) with SMTP id 2f0e6980591ab5b-00b69;
	Mon, 02 Feb 2026 15:58:21 +0800 (CST)
X-RM-TRANSID:2f0e6980591ab5b-00b69
From: Li hongliang <1468888505@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	rbmccav@gmail.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 6.6.y] drm/radeon: delete radeon_fence_process in is_signaled, no deadlock
Date: Mon,  2 Feb 2026 15:58:31 +0800
Message-Id: <20260202075831.947537-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213030-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,amd.com,gmail.com,ffwll.ch,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,139.com:mid,139.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB54BC9701
X-Rspamd-Action: no action

From: Robert McClinton <rbmccav@gmail.com>

[ Upstream commit 9eb00b5f5697bd56baa3222c7a1426fa15bacfb5 ]

Delete the attempt to progress the queue when checking if fence is
signaled. This avoids deadlock.

dma-fence_ops::signaled can be called with the fence lock in unknown
state. For radeon, the fence lock is also the wait queue lock. This can
cause a self deadlock when signaled() tries to make forward progress on
the wait queue. But advancing the queue is unneeded because incorrectly
returning false from signaled() is perfectly acceptable.

Link: https://github.com/brave/brave-browser/issues/49182
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4641
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Robert McClinton <rbmccav@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 527ba26e50ec2ca2be9c7c82f3ad42998a75d0db)
Cc: stable@vger.kernel.org
[ Minor conflict resolved. ]
Signed-off-by: Li hongliang <1468888505@139.com>
---
 drivers/gpu/drm/radeon/radeon_fence.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
index 6d5e828fa39e..1462837fda5a 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -362,14 +362,6 @@ static bool radeon_fence_is_signaled(struct dma_fence *f)
 		return true;
 	}
 
-	if (down_read_trylock(&rdev->exclusive_lock)) {
-		radeon_fence_process(rdev, ring);
-		up_read(&rdev->exclusive_lock);
-
-		if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq) {
-			return true;
-		}
-	}
 	return false;
 }
 
-- 
2.34.1



