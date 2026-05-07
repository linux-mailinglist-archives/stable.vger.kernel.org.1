Return-Path: <stable+bounces-244509-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDZQHS0p/GmXMAAAu9opvQ
	(envelope-from <stable+bounces-244509-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 07:54:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C98B94E343D
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 07:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 858EA302D940
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 05:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5936933032B;
	Thu,  7 May 2026 05:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGBd3wGr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F58330B3B
	for <stable@vger.kernel.org>; Thu,  7 May 2026 05:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778133253; cv=none; b=NADB8o4OqEkHOSPGSxsbJVULmupU8AJxcWLOGqmMU8dmwYCXN9OLEcrW0tJXft22ut8+/Z4EUZOUoBoCYdk8R9PDqcaOhsErK2DsbiiKUI7R/64CvSSFL9PU7i95BM9lmvBkL9T4GpBD/E8LAuWbx98dQRKSWDovDdRfYLA2X0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778133253; c=relaxed/simple;
	bh=QIt16dLFJWrTMrck4Yfo8+89cEeYAYgdvo7mbGDGtTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rSA5VrFHTIPc8SYdOZ81bN30hu1+AwiPT1lnkBO60ruABWnZjNiPFRNV8+MqrlqKYfvHsHG8QkuCWPFkVTf64z4JJ9+anqxPx6lx2VU19A7rq7iGBX8ytz2/nEdqjxRdJ1qyZjf9eFoLGf6gTyYsMqz+pbwtDrl79DjiFpCXGVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGBd3wGr; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-837dfccd950so188076b3a.0
        for <stable@vger.kernel.org>; Wed, 06 May 2026 22:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778133251; x=1778738051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uh9bbazrPITkf0mpglMFr/dzIoLu0nt2Rlj2ZEQ+nU0=;
        b=YGBd3wGrhklAy1wRXywWqT2yyTrvmbGwnsHm9H6tZlAuLXRzXTf/fO8dF1pbEX2Fxt
         M0NDxOFxJq3OnAmwmUrXCZWZI/DSb5/A8emehK9lifPOIV6Yir8TOz/7XwSRHTGf0LMQ
         ueZcAAWBl1hxXVzUfM31CEbWjLC7Nu0rObJVRjsOVwedrFzI9fQctWvK8EsbqD6Cc7+C
         MQGNPzdpuwpI1vkyAwUKdfQjhyh37mYjWUo8GVbBk3NHDLSxLzaV0tc+eZbgX5HQgc46
         pqlJ71C1NmrRictw/EH3yZLStIC5rMvvibNzWFywQ81pj+7auHrmK0XS+fui3asdMulA
         eluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778133251; x=1778738051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uh9bbazrPITkf0mpglMFr/dzIoLu0nt2Rlj2ZEQ+nU0=;
        b=JNlGYe0/Z0Na2Btb4URYTJHXX5MnuXANciegFZECJeqBdKTUy+q07iJ6pciy7Gc86K
         DREcW4RlJ0MxRh5d6AZxuiI/Z94dfgumfia61UsBU6Qubcm0k3+srvPLt6wrWLFSl8tE
         hUEr/0eYgN4Ehtu72iG7l+HnyF/qFCULf7C/Af3jhDbR8xCYCFsT1vdJ63YKiNiTIc34
         EYHZxB0zqq5ub7JAgu24w5ibtAt7VIZRrVUqZcMEAkpRUfOW0eNCver+cJPnEkwWpdlF
         kGN8nAF3DGXWD0BFPHLFTzAm8couwwn5J061ReinJXqVaxE7ZSOhzZigaGdnd0EP/sIS
         IJlA==
X-Gm-Message-State: AOJu0YxnKtj7/4DsmLSuY84PvHUne5/oNjyYrrzNpUkJyuF4JmfDbnG2
	C6z0hrO20OEwIyn5Q5N8TUcUMrpAIeRmvSrIepbDZhRXOX+JjJxpvu93h85ETgY=
X-Gm-Gg: AeBDiev1X8HF5WNurn/jPQfietfpADivAlnR72hEMd3Izd9qtt4QTvhXPsrid6/UcVn
	kI2uidUyGQnZtJ1pVp0qUz7aAU7lM8mrItSTsrv3NSGUxkaYlU4TVTtu3Wri8dj+LKwv1pwxzjl
	7irDnNxymeQ5hKf91ilI2vxoGS4m2IRshhbecn5egkh8oYhr+YXhofQP+CupyR8UvhACef/24TY
	KOw5UBKJDaNDF5CTL7NMUc/y59xRP1GWNxHqYSPBWlZ+E+Rv48Z4mZ60ISUEIo9ZBLwo5clWFLH
	b66CpIjJTubFXM8UmrkAtDfKez7yHNM5D/H9FQpRZ8qQIZzfl80W6KFqy8D5GMXi2stRBQxlXYe
	xVlSreMtrR+Y4L6fnPTHId9snpM4zv4nwArIUU/KBoTdjqhEjaTyXOJP3Q96wuhz2tmG/rfqudn
	5dXyicMxSVWz0F0vlzZXsldjgQsLEmcBAwu8IQccvK4Hud8dDewscRW77/n4xA1pM7LHynPOMvH
	IMAjDhOG4w91T0=
X-Received: by 2002:a05:6a00:b483:b0:837:6bb9:acd5 with SMTP id d2e1a72fcca58-83a5825898bmr6322050b3a.0.1778133251101;
        Wed, 06 May 2026 22:54:11 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([202.177.225.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbf67fsm7577641b3a.47.2026.05.06.22.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 22:54:10 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: intel-xe@lists.freedesktop.org,
	matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com
Cc: stable@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH v2] drm/xe: Add bounds check for num_binds to prevent memory exhaustion
Date: Thu,  7 May 2026 11:23:51 +0530
Message-ID: <20260507055352.61017-1-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C98B94E343D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244509-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adhikariresume@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The xe_vm_bind_ioctl function accepts user-controlled num_binds without
bounds checking, allowing arbitrarily large memory allocations. This
follows the same vulnerability pattern that was fixed for num_syncs in
commit 8e461304009d ("drm/xe: Limit num_syncs to prevent huge allocations").

Add DRM_XE_MAX_BINDS (2048) limit and validate num_binds before allocation.

v2: Increased limit from 1024 to 2048 based on Mesa source analysis:
    - Mesa's maximum usage: 960 binds (conformance test dEQP-VK)
    - Confirmed by Intel Mesa developer in commit ba6bbdc
    - 2048 provides 2.13x safety margin while limiting allocation to 64KB
    - Prevents unbounded allocation (attacker could send 268M binds = 18.8GB)

Cc: stable@vger.kernel.org

Signed-off-by: Ramesh <adhikari.resume@gmail.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 5 +++++
 include/uapi/drm/xe_drm.h  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index a717a2b8dea..1ff66874f43 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3841,6 +3841,11 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 		return -EINVAL;
 
 	err = vm_bind_ioctl_check_args(xe, vm, args, &bind_ops);
+
+	if (XE_IOCTL_DBG(xe, args->num_binds > DRM_XE_MAX_BINDS)) {
+		err = -EINVAL;
+		goto put_vm;
+	}
 	if (err)
 		goto put_vm;
 
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index ae2fda23ce7..e666b73c81d 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -1606,6 +1606,7 @@ struct drm_xe_exec {
 	__u32 exec_queue_id;
 
 #define DRM_XE_MAX_SYNCS 1024
+#define DRM_XE_MAX_BINDS 2048
 	/** @num_syncs: Amount of struct drm_xe_sync in array. */
 	__u32 num_syncs;
 
-- 
2.43.0


