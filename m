Return-Path: <stable+bounces-244673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEESMZmG/WmefQAAu9opvQ
	(envelope-from <stable+bounces-244673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 08:45:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 461AD4F297B
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 08:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEB3A3006B0A
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 06:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C373635E549;
	Fri,  8 May 2026 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+oItg0g"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD6B3612CF
	for <stable@vger.kernel.org>; Fri,  8 May 2026 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778222737; cv=none; b=NVx6pe5b9VzY6x3dzesnMAya/5ecjWsHsA0DZW0bPH2X6zYhKeuyD9rQG42sdCZtQmzoT6kclXT1M0SsdZusQVz4+itPYbnnnIW4+OFDEWs9VC7ZDBmxkduPRoszQZGXA2Gh+OSVeHPtq9cr5nyYuqUizHxswSYiwfYu5mYX0mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778222737; c=relaxed/simple;
	bh=HwVeK7wdjqVBnN2DX0iTXWkMreQW3YRImQr8URxX4bA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qVPi7PEnb6n8yK3wNZf+obU350XR3EpXmjKl7yVMZxtqthSxChwR2lmT1uR/IMiTBTmQFW56HqtPHRrmjwib1ua+4K4CR3DiXWBG/OFpA0R0Q9e5I4tuEFDhDjFDY22D1W3VHzxfaWLeUYEDBf3RURIxedNeZh2c08iVolfwOaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p+oItg0g; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36523acb0c1so1142637a91.0
        for <stable@vger.kernel.org>; Thu, 07 May 2026 23:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778222730; x=1778827530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2A39dF+p7aFgXp967/D764wgb7uWfzZBjZMIRm9YyxU=;
        b=p+oItg0g6eVKDfMwWP4a47eCbpc2LQhduxWcrlorcOyR0xTo2ngTWCzQgTHmaeiA22
         DKoTyxOP6u3o71dAeTZuRaox/TgTqL9iQ0fj58oMjq9Fvrq9nBEvLwR2T7EwTQqw/AIi
         pB7aBUr9wyTW/7gk92vP+BtaVvV+B0cIHIp+2TRZBE8Xe9GrOQLTcRteRo0cypW0t84C
         fCzwgtoh5S6kHQaLR0jXaDpHpc8vTyIQzdcC+r2Zuuz/Muqvv6DW51lqpj7P9Ffmw/Jz
         aZUIRcZo89S5ze8xUfrs5vXRbUiMVDQy6K7o9+prfgdF2Bkg0L1aFxnMcv63+IhQUrFp
         EnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778222730; x=1778827530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2A39dF+p7aFgXp967/D764wgb7uWfzZBjZMIRm9YyxU=;
        b=lb+mCT471slS2uRhV0lGTW2kDMKbNgKRaU3OJHPYaDEMjpSImyuYMLHUiAtlWGNZiY
         rB1lifcCvjVmJBrRMuKiBACbDK4BkrYWx6kjqN8R0RmKt7YZaBBiYCixGWbJoxwsX3TX
         TKgnwVO7Ba3wgaAcVQOQgpIH1dRRJCp0IOoy6CUzX3julC9pfabIp0K9bORv6zlkCIHe
         oHTszJflIX8ii0pjcPoSTO2Le1FHLIVr03kw29r5lEqamo16Y0T9cCDaHAQtgnZG0X7i
         jQ9zgpUCxYtNxjrIoCivHmkELbYoWmOcVcsVJyJpw1g3l1RzuzaD3JYYswADT+b+uibQ
         OJUQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Sgb1y1uw7A0jsaWCBWDUhWmNz5edEK5pjdVJ7nfYEBZoy/W3r++CNyBcVzKzGNkJdBk02DOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9VzSuJ45Lcpugrwkfrzp4/ZzbJKh8tn++GGwwSpAIWx05VKbt
	rUSE4hDFrCqXP9/+V2LGUuPY7PAsyyGXC2q8409ck9gvJgsgqvitH8o=
X-Gm-Gg: Acq92OHdxoyux/0H/yYA7vh+tJaj4idLW+2YAa8FG4MfzheLmjO7PBNHm6dM1wv7onc
	gpDWhbJoUZVj+QUPpnMZ8NsVnBgC70EfLMraFyFRPUsnV153rm0qs7u1BQ4+9sxuFvVbrIMn0wU
	/OXPDE4hd04s1o8dWssBNtnIXRk8Riv6J60sOZrok14qtmOY3Um1CXrgwfONLfHu16/iUefQpun
	Yhwag9rbIWUjqkQxPNdiHxO0tAsVapN2xg0bKR9OCnl7WjeKb6kjTKqHzFtGJtAy4+ppVVWAzYc
	U3FKQjHrzsIuP9+Wza+edoG10A4ctsHEPlBWTp+coIiJPqxIuRFanxPsEthQ778pZn5CMpo9Fq/
	dX3/izXyfUJT12mxZSpNnHlRlkeYutpnDaBg+9ZjTyNnP1HvpzfT/pJbU+cyRzH9WE7I48U+Jh1
	BJ2gOOjQ08CnYADR9Kw9AQaOc6VFq8dOwAvujuNgc0b5M3XPdSLYeaxrhvF6vZlR1PFN+AvIVEq
	7KA/s3w1sJQzOQ=
X-Received: by 2002:a17:902:7798:b0:2b2:5503:1b8c with SMTP id d9443c01a7336-2ba794b7f8fmr79747875ad.11.1778222730082;
        Thu, 07 May 2026 23:45:30 -0700 (PDT)
Received: from coe.tail83f5bd.ts.net ([202.177.225.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e6199csm13223695ad.55.2026.05.07.23.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:45:29 -0700 (PDT)
From: Ramesh Adhikari <adhikari.resume@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	stable@vger.kernel.org,
	Ramesh Adhikari <adhikari.resume@gmail.com>
Subject: [PATCH v3] drm/xe: Add bounds check for num_binds to prevent memory exhaustion
Date: Fri,  8 May 2026 12:15:10 +0530
Message-ID: <20260508064510.158728-1-adhikari.resume@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 461AD4F297B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244673-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
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


