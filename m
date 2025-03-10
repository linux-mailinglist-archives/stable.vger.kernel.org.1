Return-Path: <stable+bounces-121714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C05F2A597F5
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 15:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D99A07A2C69
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 14:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A30119D8A9;
	Mon, 10 Mar 2025 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FvH+TEVk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BA022B5AB
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741617775; cv=none; b=e/VuMxPBed0bW8FgkdBCD1G7BgfoIl7TIVyN3KcIi6g1QJO6bo0UA7anaHCfLbEBqfaxLTj3FXveRj+aPJ3jlPCeJq0BVdqNOIpLok/PXA0YoIcXPlyO9+3dkbR3xSNvtLFZf8tJHmGVVBNv9kOV4PYLxqXum54owK+BUvkGn9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741617775; c=relaxed/simple;
	bh=xWw+nTIIokSCJO2UTzcsdTsMZ9uHXVFeOY0BRJg949Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eOpsKIyQ9zJHMzQfIKH0Go4PVdpoWhXwzfrQTx3GFmPNGMvVx5vGllPVU5ACL4yp37xd8TKvZbV3fI6m7RXTu6aydvlYad6Ii9LFDGXVpDQSonbfvKTMkVNSdhRk6M6MCHUArUIJLbTRYuLEeKJGdEQChlHW935VR20jzpWCRW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FvH+TEVk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ce3f1a2d0so1985925e9.3
        for <stable@vger.kernel.org>; Mon, 10 Mar 2025 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741617772; x=1742222572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhfIc8gYH8+gt6Q5jawnw3uKW1DrnbuKUO8tR0f8B50=;
        b=FvH+TEVkFMeMNPGQVCVv/+eCi7KEMwUzFnhVQKXSDL9FlSnm+bNYwKrnjaBA+GpsaM
         Px5VkBHxx2qbFpZQTz+zNZE3bVt2uKHPL6H2n817lSJHAcad6lYiGW+5bYj9hoGGiOf9
         mJNl4avlwdx2RSAyWOPvO59OJzJxHO4e/sCnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741617772; x=1742222572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZhfIc8gYH8+gt6Q5jawnw3uKW1DrnbuKUO8tR0f8B50=;
        b=SV7rBIWo+eDHZ2BR1lv1NErN/g5jjmynjzDsJYJxYpiiscLFIqyfFGNHLwxcE291P7
         n/cBIlsHxEO3d5yQKo+KpnykqK+V8f4jayi2V/pWil3bcoeLi/cgO6s3JSYU1/aCHuuQ
         FXOqZ5V1xH+IgUn5WYQcwwFL8mJWSR7bBaD9dlVfNGPWoxNA7srzG1nbega9dbC2u/pA
         YiJDud8cH1O1tQsAYwmIGQWF8mip3DMIUEcDZlOWB5l4wZzJhtVUAbN2isSFvqW+3oeG
         L1hAHBSYUHIkB0ftQ0Eip3zwQC3C1sP1aPl4Yq9hjMCscXrjOVbOV/ho4WICsge7vXRM
         bQyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU01zl6gPZeXYH9k/7Scblz+dX4J+uExf+frpk4c0XqaJsifz1FpcTrU7g4X0xCvwZBjbLqB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxQYZhQbuR38W6QdDB34X05w9gyB1K8FsHANC5KIu+KfSGvOYw
	pS3mgGOiY0Kf1FmlIVusfwm9h+NvgMixoX5ElBYtL2xjPf1JCOUFrGjbMWFsjA==
X-Gm-Gg: ASbGnctNNws913LsnyN5zU6xmsYs/pHulZ4dqzukl8WHkye2phK8DbCIgY54nzHZ7y1
	1IV/ejwRuLDLSmBqiNIs7AJqM0yjDzCf8f9TpDGo/ua/H+aJTk8ToWeGNwuidHR71VZ4HxszOwf
	t0pXs9APaWJoSApqXQ5HU5nMsA0+9Mi/E3Bj0Gw+5KUBdeeozbk/5YcJCz8PCHryd5wW0hcbZIa
	3ZnATJ2nv+qLazsYk/95s27iSKr2c3UvOY7bnJAzu2HYE4uZ8AjvhSWXd6O03jQBV7cDlfjAXwe
	vp/uaQUTfiW1k+0P1jdhwNwXOBY0TIJUIDoSAOGALiT+L5c1YzhPxSPVtGx/
X-Google-Smtp-Source: AGHT+IFu+FxExFyGmAlo+3fmikt0qyrGnWILpwyHTBe178npH64SLcKeuxlG7vPfeLmep37e8h4uYw==
X-Received: by 2002:a05:600c:4fc8:b0:439:9909:c785 with SMTP id 5b1f17b1804b1-43ce6e7dc9dmr23994255e9.7.1741617771665;
        Mon, 10 Mar 2025 07:42:51 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:954d:95e6:4e36:b46a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cfbae50aasm24578555e9.8.2025.03.10.07.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:42:51 -0700 (PDT)
From: Florent Revest <revest@chromium.org>
To: bp@alien8.de,
	linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	Florent Revest <revest@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] x86/microcode/AMD: Fix out-of-bounds on systems with CPU-less NUMA nodes
Date: Mon, 10 Mar 2025 15:42:43 +0100
Message-ID: <20250310144243.861978-1-revest@chromium.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, load_microcode_amd() iterates over all NUMA nodes, retrieves
their CPU masks and unconditonally accesses per-CPU data for the first
CPU of each mask.

According to Documentation/admin-guide/mm/numaperf.rst: "Some memory may
share the same node as a CPU, and others are provided as memory only
nodes." Therefore, some node CPU masks may be empty and wouldn't have a
"first CPU".

On a machine with far memory (and therefore CPU-less NUMA nodes):
- cpumask_of_node(nid) is 0
- cpumask_first(0) is CONFIG_NR_CPUS
- cpu_data(CONFIG_NR_CPUS) accesses the cpu_info per-CPU array at an
  index that is 1 out of bounds

This does not have any security implications since flashing microcode is
a privileged operation but I believe this has reliability implications
by potentially corrupting memory while flashing a microcode update.

When booting with CONFIG_UBSAN_BOUNDS=y on an AMD machine that flashes a
microcode update. I get the following splat:

UBSAN: array-index-out-of-bounds in arch/x86/kernel/cpu/microcode/amd.c:X:Y
index 512 is out of range for type 'unsigned long[512]'
[...]
Call Trace:
 dump_stack+0xdb/0x143
 __ubsan_handle_out_of_bounds+0xf5/0x120
 load_microcode_amd+0x58f/0x6b0
 request_microcode_amd+0x17c/0x250
 reload_store+0x174/0x2b0
 kernfs_fop_write_iter+0x227/0x2d0
 vfs_write+0x322/0x510
 ksys_write+0xb5/0x160
 do_syscall_64+0x6b/0xa0
 entry_SYSCALL_64_after_hwframe+0x67/0xd1

This changes the iteration to only loop on NUMA nodes which have CPUs
before attempting to update their microcodes.

Fixes: 7ff6edf4fef3 ("x86/microcode/AMD: Fix mixed steppings support")
Signed-off-by: Florent Revest <revest@chromium.org>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 95ac1c6a84fbe..d1e74bfe130f8 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -1068,7 +1068,7 @@ static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t siz
 	if (ret != UCODE_OK)
 		return ret;
 
-	for_each_node(nid) {
+	for_each_node_with_cpus(nid) {
 		cpu = cpumask_first(cpumask_of_node(nid));
 		c = &cpu_data(cpu);
 
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


