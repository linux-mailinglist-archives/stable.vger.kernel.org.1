Return-Path: <stable+bounces-244593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PBqOgqq/GlESgAAu9opvQ
	(envelope-from <stable+bounces-244593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 17:04:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 988714EAC3B
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 17:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09ADB303C9B6
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4B73EF0C6;
	Thu,  7 May 2026 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHqhm76i"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C5015ECCC
	for <stable@vger.kernel.org>; Thu,  7 May 2026 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165927; cv=none; b=n4YLuakaaQ66IFE8BLaQnKN6pitjqRLaeIf5f4114cW1Xpjk5Jci/ZNTTT+i8x4BNkhHA7dwFXlzVSDjQ+XmGTIzYy/7owr0EgihWlF15MV6TEujB4h2t79Xu/L4SfeQhzr72Oz91zuy8EMnj7osswQIbady8LsqSToywSR0jt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165927; c=relaxed/simple;
	bh=HwVeK7wdjqVBnN2DX0iTXWkMreQW3YRImQr8URxX4bA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dR867Dtgesg2p7CXiejQe+S/zmahnloPoI7mVWJtnpuBnlEjnMBS8nbaY+iyn1V68Y6Tyj4ID6uRQzweGIsJ3dkT9fy+DrnIVyepGCBYfQvOwPaPpBaIxSxq2kmY2XAymf9CrGsKK3C0jYhVMIgnlnKjAlDIT2HqPIkfEK4n0n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHqhm76i; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b941cd869cso5754765ad.1
        for <stable@vger.kernel.org>; Thu, 07 May 2026 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778165925; x=1778770725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2A39dF+p7aFgXp967/D764wgb7uWfzZBjZMIRm9YyxU=;
        b=KHqhm76iyDO2xzfNQ9B0wuhP+tRsaZ95ExE97FLvcgds7jSSKBGt8YMAe6iB0a+XyF
         fhlezY8RToa4jDgGE45oKZpmxhQCfQY8CDNNKL0Nk6wRDdHjIQDQm6ZQEDNMHk1gnoE1
         +5sbvHwnx83BzVJnMe1rMXFYUor2NkB3AhDM/ZetbQqv0WJnwDifzlhfGgpsw3ArrqXK
         T+8fLyRXpY/FDIU3sO06mHDTSTECEGmVNDRKNpjEqsBGWP3IA8340kGfdi6VQCztzKP1
         7Yux3NFCaOfb9yRuf/sviq3hoqYzVLjdRrIstKgX+bADPZy7jI0WzUJPDnlGwkED6c8+
         8Tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778165925; x=1778770725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2A39dF+p7aFgXp967/D764wgb7uWfzZBjZMIRm9YyxU=;
        b=d9gNk2fVuat+p9/4/O9usiCLT1VkUXVqsQpthfHjvkUYc3o0MuOUf+FDasjJ9hjS3W
         oANyh8MA2JpaN8lqhv7x9nInRdz1vbfkJXCOQateCay1JfazsEFbJkQulaeziTn4zFR9
         1AWissU2CwkrF6OcKYlP4xwoZjsKDeKQwXhGDp3NfMkmWpv8D3edldXRliBun8RxsOaP
         A4lYYBtl7v+QsBL1GzvWfOViNkdeKo0wUKAmwMJwEPle154pIG6QQ977pJSelHot0afI
         F/n9GumYA7/SRN4AKM/VU0Z22S5qxE9ORtjMSxBM6VXx3Z9c/Efy3Oh9buq13bNPvQ8l
         Vtqg==
X-Forwarded-Encrypted: i=1; AFNElJ+0B4N+g7TPdntWYTr95b4rkvdumjnz2OJ1iJAxfHo3tzfTl+esrvEfzZY6BZ9hehLpkxK2Dy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzrTOQq2u7g3lhLXlWCutoMwR1ZTIcC92434FEtVA8SOgFDEK5
	sv1k43YxG4Q5t0dgfTgzfXt/Zx2WPgly/9xPXy9LcwwbUVMairykFN0=
X-Gm-Gg: AeBDieuOCzWTT7rTI1DRpMWqkJq8bzCdqB042eXsfA6KsG6yWIn+FqKECAs3vXxo0p8
	1NmTPFqPH0GsOhQ6kghgSBvRfMkdPCn1uLfZWIl9lZpeM77XATqqEDi5G9ORdBe2UdfdXyuTJhU
	9zhV79VyDiaDW/MO3iMfs7KiHR7eqsWfykWr0+NSwl5uQ0J5kJHnxlH1SZfNETrVNz9m5B0RamD
	4f0QIK1IC0B7lko+aEbpHQrRokoRHX9fTXTYxg/1YRvV7u0rzz2t0WXj1AhFf2AdFFRDoh2V93M
	UPUYwUwCDJFP7zp0KQ/9eMk8YxFRIWqt0F7NP3nEKVadvbOe5RCrOeNeca9ToDY8iKfoDnzevGg
	sHuFn3NG1KnHaBCCvcPQTrIrnH1Eo9+yswUzAQ+/9cBanWOZ/OwUYdVPVD25tgjYRHjN3R0Dzfj
	8T1lPLW2RZs4oUlNYyqvij3Q+dLd+OnyjTNDw8NIx52XE6AoZskou9AcjsARUw9yvemGBTsNkzV
	btDMTFELP/B
X-Received: by 2002:a17:903:38cd:b0:2ba:be5f:cab3 with SMTP id d9443c01a7336-2babe5fccc8mr31855355ad.3.1778165925281;
        Thu, 07 May 2026 07:58:45 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([137.59.92.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bae752d027sm3775ad.4.2026.05.07.07.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 07:58:44 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	stable@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH v3] drm/xe: Add bounds check for num_binds to prevent memory exhaustion
Date: Thu,  7 May 2026 20:28:07 +0530
Message-ID: <20260507145807.140317-1-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 988714EAC3B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244593-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adhikariresume@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The xe_vm_bind_ioctl function accepts user-controlled num_binds without
any bounds checking. I noticed this follows the same pattern that was
fixed for num_syncs in commit 8e461304009d.

While the main allocations (bind_ops, bos, ops arrays) use __GFP_ACCOUNT,
I found that vm_bind_ioctl_ops_create makes additional allocations in a
loop that don't:

  - drm_gpuva_ops (16 bytes) at drm_gpuvm.c:2949
  - xe_vma_op (144 bytes) at xe_vm.c:1318

Both use kzalloc_obj() which defaults to GFP_KERNEL without __GFP_ACCOUNT.

I traced through what happens with a large num_binds value. For 268M binds,
the loop at line 3971 runs 268M times, allocating 160 bytes per iteration.
That's about 43 GB allocated without cgroup accounting before the code even
hits the main allocation at line 4009 (which will fail because it exceeds
the 4MB kmalloc limit). So even though the big allocation fails, the damage
from the loop allocations already happened.

I'm adding a limit of 2048 binds, checked before any allocations happen.
I found that Mesa uses at most 960 binds in conformance tests (from commit
ba6bbdc291), so 2048 gives about 2x headroom. At 2048 binds, we're only
allocating 320KB in the loop, which seems reasonable.

I'm using -ENOBUFS instead of -EINVAL so Mesa can retry with smaller
batches if needed, as Thomas suggested.

A note on my methodology: I don't have Xe hardware, so this is based on
reading through the code and tracing the allocation paths. I verified the
struct sizes and followed the call chains manually. If I got something
wrong or missed something, please let me know - this is my first kernel
patch and I'm still learning.

v3: Changed to -ENOBUFS, moved the check earlier, added more details
    about the allocations I found

v2: Bumped limit from 1024 to 2048 after looking at Mesa usage

Cc: stable@vger.kernel.org
Signed-off-by: Ramesh Adhikari <adhikari.resume@gmail.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 1ff66874f43..1ab020cbdc1 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3840,12 +3840,14 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	if (XE_IOCTL_DBG(xe, !vm))
 		return -EINVAL;
 
-	err = vm_bind_ioctl_check_args(xe, vm, args, &bind_ops);
-
+	/* Prevent unbounded allocations in vm_bind_ioctl_ops_create loop */
 	if (XE_IOCTL_DBG(xe, args->num_binds > DRM_XE_MAX_BINDS)) {
-		err = -EINVAL;
+		err = -ENOBUFS;
 		goto put_vm;
 	}
+
+	err = vm_bind_ioctl_check_args(xe, vm, args, &bind_ops);
+
 	if (err)
 		goto put_vm;
 
-- 
2.43.0


