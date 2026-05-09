Return-Path: <stable+bounces-244981-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD60DJBt/2mh6QAAu9opvQ
	(envelope-from <stable+bounces-244981-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 19:23:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E15D500C61
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 19:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7AA3430028C3
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 17:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AB4346A0A;
	Sat,  9 May 2026 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKIi2bUA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E208A2F8EB0
	for <stable@vger.kernel.org>; Sat,  9 May 2026 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778347402; cv=none; b=Hectj1ee9wQXy0THhNbIjnEd7w48raHFPd7Yj23lXuVQrQdX7B2Z29cAwQt8bVR2c3eTjVxRKDd3Ff5DAI+7pg6IxwWkJMsqSkugyrStDRwIJtJkhFhFziO/wx2m8RLwD1/I1TTc0QyHqUGEaAJijEXtTK/i7HSnKdmRdNDIAgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778347402; c=relaxed/simple;
	bh=PSPcdqZ+OinNTUFxt0SJo8DGrxrsHpsIJ4s3uCO1zPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bnwpVznPH+viZ9NU9vVrIWbX6ZDGRnCaaKbfmheWXfvCAGvfdA/h/tgeY6DM/FOqctPNhBedB3jyWAD8s7kvcsCrJ5D/0BnZ3JQxKh4h1FZ6izYbhtvA4MidEqhyu5YZEn53UrGpG4lpNQRYLSrcTgV9LQN0yoNLBULmqxQ7B0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKIi2bUA; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3653cb9c6f8so2682787a91.0
        for <stable@vger.kernel.org>; Sat, 09 May 2026 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778347400; x=1778952200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=79yteFN44OLmqQd7A/WzQJLcbKTG20XFMFZdijxLhxE=;
        b=IKIi2bUAA+kUPUbOL3K1GOQdR5jK6MjhzwZ+V2TUvFOMmz2NZYLb/4dEREV+WtnPBp
         2dDVKsUAs+JvMSBiUnZGUlFCMDF6Rbon9br2gCS94NqGFVYAJf0ENRS4ox197A2HdNVt
         DwO69uKTf0QUN6UWJHEfG7pYVb6ZAywDmrd2ldF92Nz6CErBSHoYEcdSUmiMVT61EeRc
         gBwwkmnzAOBFPSJGeWDzKBJGh7Uvzym+rp/gjvGkhlhnlvgM++ZucEe1lGqy6zog3TtR
         HTbl3PD6vkPP4/6SLFdTc2lLb4ra3FnjRiq3sr5Z4U+22xHntayoMadSas9QN34N0Tt5
         7nRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778347400; x=1778952200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79yteFN44OLmqQd7A/WzQJLcbKTG20XFMFZdijxLhxE=;
        b=ZEWB6p/0rRzsgPSUm5vUkGzIND/Q/nqxs8BD+nT/SoHHldtrU8MpXTUMiLmuExpfu3
         KJZB/P/lw+71JGpXmKzdquu8OusKGIL6BjfoEVOydBRsNhS/273p68MJZdI/x7NAWGUW
         KUlP9aVQ1gzu2R2kXgN3hTRq+d/B80pC8kjw5qRQORDVsh4/Jx2BonRmUaGV5b6vcDDL
         7oERcQoMmv4400qobtxPyNdYcTtGsgN/64QJV30t6HEfLivV4nVFckAqbTWxfRK472TY
         miuWK7skjtlnuVeBNOyKWfBAQhtKv6jX9K/VxbvlAyKwtXF/nKHI8VXAct7zV8Qu15N+
         roDw==
X-Forwarded-Encrypted: i=1; AFNElJ8fd7U+VOptKKZ6t+Bie0S2eMd6JH2v3VlJwuIgsGZPnFHPDtWBHFBe1pfbgh8Tqi9uExMyecI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgJHFAPSP86Cg8Gc9P8Vw0xywmkoKcoNkzX8JkhobGek7DUsyJ
	noV1AbVjaHcqx1hiMFeYsO6CI86OW0bLwnfzX4ueSLBv34SJTyeBhT4=
X-Gm-Gg: Acq92OHVuo9+q2db+wDf0Rmid0zkfAOWPIPli2tUar2N/DySjiWzX78k3iBcHEefSFq
	toLz8PvF7lm4EoZKCpwYxHJdH71P3nw+LRLEDqupqVjcjq5JKfG9D7Q27L2cjMO6PcX0HZrhftn
	c4t11Y+LWDC0jbVDgNBSE5rwUYGOGoU6z+H1L0Rllg3X9BN1hVhK8deR/WAr4hEwAyf4nwGAEI0
	mfFfgCQeY5NMS9EoA2u5Xk6OGKT9IezX02jEfRr2c9iMAz+4XL9zD/SxfHnqR5q9jCUXkQGB1xR
	WtjigPtmn78BmSsoU/jtVJ5dHaEB6Zw7g5yxSIFb8+yG+b7yxqxLptvMMbzuT9PgFc5DriKl/g/
	TKkqnGKmY46MX4EHSLWuPpxJkEMsmZ/whiE2BtDSC9EBWp/3iH1XNk+8SB25clhhWaeFDAEVWy2
	pdsNyb9Koc2+ultvmBUCP2CGxgJLVQGNeZN/4JCsernXFH2F8tGip+la2KrGUdZ+7LVFgDu3uWZ
	eA=
X-Received: by 2002:a17:902:e544:b0:2bc:7c62:187 with SMTP id d9443c01a7336-2bc7c62085bmr35723455ad.29.1778347400276;
        Sat, 09 May 2026 10:23:20 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([125.19.217.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d271d1sm56826955ad.11.2026.05.09.10.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 10:23:19 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	stable@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH v4] drm/xe: Add bounds check for num_binds to prevent memory exhaustion
Date: Sat,  9 May 2026 22:53:09 +0530
Message-ID: <20260509172309.58377-1-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2E15D500C61
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244981-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adhikariresume@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The xe_vm_bind_ioctl function accepts user-controlled num_binds without
any bounds checking. This follows the same pattern that was fixed for
num_syncs in commit 8e461304009d ("drm/xe: Limit num_syncs to prevent
huge allocations").

While the main allocations (bind_ops, bos, ops arrays) use __GFP_ACCOUNT,
vm_bind_ioctl_ops_create makes additional allocations in a loop that don't:
  - drm_gpuva_ops (16 bytes) at drm_gpuvm.c:2949
  - xe_vma_op (144 bytes) at xe_vm.c:1318

Both use kzalloc_obj() which defaults to GFP_KERNEL without __GFP_ACCOUNT.

For 268M binds, the loop runs 268M times, allocating 160 bytes per iteration.
That's about 43 GB allocated without cgroup accounting before the code even
hits the main allocation (which will fail due to the 4MB kmalloc limit).

Add DRM_XE_MAX_BINDS (65536) limit, checked before any allocations happen.
At 65536 binds, we're allocating ~10MB in the loop, which is reasonable and
won't force unnecessary fallbacks in userspace.

Return -ENOBUFS instead of -EINVAL so Mesa can retry with smaller batches
if needed.

v4: Increased limit to 65536 (64k) per maintainer feedback, changed error
    to -ENOBUFS for graceful retry
v3: Changed to -ENOBUFS, moved check earlier, added allocation analysis
v2: Increased limit from 1024 to 2048 after Mesa source analysis

Cc: stable@vger.kernel.org
Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 7 +++++++
 include/uapi/drm/xe_drm.h  | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index a717a2b8dea..1ab020cbdc1 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3840,7 +3840,14 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	if (XE_IOCTL_DBG(xe, !vm))
 		return -EINVAL;
 
+	/* Prevent unbounded allocations in vm_bind_ioctl_ops_create loop */
+	if (XE_IOCTL_DBG(xe, args->num_binds > DRM_XE_MAX_BINDS)) {
+		err = -ENOBUFS;
+		goto put_vm;
+	}
+
 	err = vm_bind_ioctl_check_args(xe, vm, args, &bind_ops);
+
 	if (err)
 		goto put_vm;
 
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index ae2fda23ce7..33f23f6638e 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -1606,6 +1606,7 @@ struct drm_xe_exec {
 	__u32 exec_queue_id;
 
 #define DRM_XE_MAX_SYNCS 1024
+#define DRM_XE_MAX_BINDS 65536
 	/** @num_syncs: Amount of struct drm_xe_sync in array. */
 	__u32 num_syncs;
 
-- 
2.43.0


