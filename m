Return-Path: <stable+bounces-244438-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GOeFo+D+2mEbwMAu9opvQ
	(envelope-from <stable+bounces-244438-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 20:08:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C974DF27A
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 20:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18D473006B76
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 18:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978233B8D75;
	Wed,  6 May 2026 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNnsP5I9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD7C31A81C
	for <stable@vger.kernel.org>; Wed,  6 May 2026 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778090890; cv=none; b=X8gpwZjfy4ECHSICu+1gRzVMabFoNS0SIB7ZttSOzLaT9inVBQ7MdWSCBW+Uuvclk3lB2x99u+PQkkIndAOBJyP45mteJesTCXhd2IEMYikjABVPMqJFqu+1CNFkR7aTN3isYoMF6zuwN3vkW/1lzjcwOXotWZwJprWVu7t/oW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778090890; c=relaxed/simple;
	bh=eHY44Mcb3dKOfvzPQO8xQxCj0g5xvveBA8tTtPN1A7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fbpOmg979Nds7zKsitKgNnJOxVMdyOhEVT4meunqbYCHWp5yJzRtcIqF9yZFEpNRnTKQLqiBLJS8lWj+E0M1dYCDwAQCv5eVGxZ1gKhoZXB08eHWXtzIA1CSi16pnTk8tF7cmgbekmOKhEoC7uGvHs9K0dtLGh8DHq0miIbxs2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNnsP5I9; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ab46931cf1so8673405ad.0
        for <stable@vger.kernel.org>; Wed, 06 May 2026 11:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778090889; x=1778695689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SOFKzq9vyU4IaDOJ+S3dhxhZPfZZAQMLAQILYvOzB5s=;
        b=iNnsP5I9sVtPI0FwvoPXu+qekXGpf3iCmtwM24ghFdWPTQS/0qsRVN5vnQ7qF9dJwq
         lHl7iKErDfJCswNzQPRMiiwIDqrpKD1Q3VMAFf1d6OMSkXEgWlqbTAF54DkZPTXOMtN8
         /IcnukhzyqqpXn0A/tPqYpK7Y7RVoGWDmpnQa/LZg3MzmPv18m7D+eIq7l2UuygLQs/w
         acWQbwVX8a8hgKZRVmD+ynR1lKm8AUVPWml1OQa/r/u+nBQKm2X/T7xgVknqAfIyRdNO
         UBm8PJp/TSCnxN9N8fxBdjpLOQd2OYkYnVBNeQQWXiRtN70CMpELrbtzZSAPYFs6uZT4
         D6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778090889; x=1778695689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOFKzq9vyU4IaDOJ+S3dhxhZPfZZAQMLAQILYvOzB5s=;
        b=RqAol2EmdiQ5oJ0YdWZdy6Nsft5m9W7XrFB4NYNDffb+jvIb82LpjvR9YKxdZd2LQQ
         9FeMeObNhY9kPeU5G37vAtJMAxhdpcyMWLekPMM8PhGCl7rdTZ2A0siWe6/RwbFQeWy2
         Ml5LImlI8CoxV1+APHH/xV12jnvzRuxLv+8u5nOzjmynThn2kbk2eH3tcuMv/pU/6Lvp
         EYqsQ1ne4lpZJHFKZlh5yG/qaDd6c2Guu4W+1wywlROfyt9kN8rcxGh6BMAwXVli1pYi
         LaB4CEZfW6sYPogS7NdLqQztd0ChGIkGtoupw/gzURpRi6BCLMoxRGdiazQsOsXRffZo
         cgOA==
X-Forwarded-Encrypted: i=1; AFNElJ/eleGk/rug+dPv/Cnqna6wSD5aiUtcWvJs0CLPxBlSxIss8Ydyh1BcDi9bR9aKdRJgIy/f9xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGJ5K2pCyx6LXV1qvHjoiWViZCuYG1ldUz/wvLjj4eYLMz7voj
	foeu99sr2jpv+gtRQuPbchGp/7gPNKmgmvD/W+mgKRxJEHr+Gp9ffzDkWHKo5pA=
X-Gm-Gg: AeBDiesnsDapBcbzk29LEVNmrMMHp+fq1VShBhXNB05GzfzF9QYLMI6nLBRDfs9fsUC
	7/Exozu/6zppp69e4MXMXnS2e+rJ2vwzMgD9PGntIz2zFE7lGST46TG7sY5txkQOxRQk+7xkMqI
	L4Ck/z24rQvjzxzQjbaSEJl0lvq857wZy10DwNCtkAYb1AX4bxd9uJRzBLzoDE8Ss9qsPrrj5Zs
	YX3BMlLq6V1AfEeVL7j2oFCLPxe2gSf2rBPfJRcwNATRcwSkPxaErVAhtz1cDWVRaXQpqqtICCV
	c6LMUGvWOFwD8U10CUcYmqZqGAo5FnpKvaKs5qHIiVsE82oPBN+j36N8SZuj2eaji1bMzIHWYkR
	0s9DPmQaSAJm5Y2a3asas6kSLsK7WvJ5SyZCSzA+XJq50tjsDZL0Ie3DPtSxEMkBeypOfUHH3Z6
	X5RN+yI27GORa4gUUEcLyCDvjAtG4lebuD5vq+7aX4RCQVBlhoVwGqhr093SvcfTMJBJ1WCLoHi
	YukPwzLVbVzbRY=
X-Received: by 2002:a17:902:d501:b0:2b0:be79:e521 with SMTP id d9443c01a7336-2ba4e5f89e0mr70303685ad.26.1778090888453;
        Wed, 06 May 2026 11:08:08 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([202.177.225.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7c038b40sm33581675ad.34.2026.05.06.11.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 11:08:08 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	stable@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH] drm/xe: Add bounds check for num_binds to prevent memory exhaustion
Date: Wed,  6 May 2026 23:36:36 +0530
Message-ID: <20260506180636.23771-1-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B5C974DF27A
X-Rspamd-Action: no action
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
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244438-lists,stable=lfdr.de];
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

The xe_vm_bind_ioctl function accepts user-controlled num_binds without

bounds checking, allowing arbitrarily large memory allocations. This

follows the same vulnerability pattern that was fixed for num_syncs in

commit 8e461304009d ("drm/xe: Limit num_syncs to prevent huge allocations").

Add DRM_XE_MAX_BINDS (1024) limit and validate num_binds before allocation,

matching the num_syncs fix pattern.

Similar unbounded allocations exist for num_mem_ranges and OA n_regs,

which should be addressed in follow-up patches.

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
index ae2fda23ce7..804ccb23b11 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -1606,6 +1606,7 @@ struct drm_xe_exec {
 	__u32 exec_queue_id;
 
 #define DRM_XE_MAX_SYNCS 1024
+#define DRM_XE_MAX_BINDS 1024
 	/** @num_syncs: Amount of struct drm_xe_sync in array. */
 	__u32 num_syncs;
 
-- 
2.43.0


