Return-Path: <stable+bounces-161691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E13FB0276B
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 01:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6CCA41C5D
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 23:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA061220F20;
	Fri, 11 Jul 2025 23:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="02nz6Iiu"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4DEEBD;
	Fri, 11 Jul 2025 23:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752275325; cv=none; b=r79iOrhip+PzKCvsMveRSUwqUPo9wLy/6gHml8d+vQ2zizfbo8SG1sqlQ7LAkc7oJF3WJI+9Oah0kjW9/ScT9VkohbGM5YltIc3lqFXRgVHkZN+LMoOGczs/9GzE9jJhub9Pr1K+ykVWcen7WoStoJnEQdlDKRDin+0CuHkxc30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752275325; c=relaxed/simple;
	bh=+ICMoXA52mh6wjhVQL+jgW1x7ZFK7RA91iVCPBQIxzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUDlRAaxYGLC4q5fPnkwgHaWn+azuByp7pqSSwl+Byt+n8yV4n99RAfV6GHZfR164XnSS5uwP+n/D1niIjFZ0Zqk1ur9KAp2CUgqKsQRFt5uQ1qR+bjYsWqI35bFSYv9tayIdllFGC6EIs8/p4z1Nednx+4jYVEGCEV24kqJSd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=02nz6Iiu; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bf6pH64wRz9svH;
	Sat, 12 Jul 2025 01:08:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1752275319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YsokS1HHDcW/fuPwGIRSA3H7pQfCAdn3V93lXZuDPJM=;
	b=02nz6Iiu1jAE4EARO9A82YMoVMVbJkr88PQbCSrxZBMcm0QzXxJWrra4LPYrIMeGKERQMH
	taILE2jrh28YMQkpINDNtHNJNZBfENegygdpJeIP7WqUckZbv8s/tTZZlcVV95tVrhwGGC
	+MUUcm1sxNuQNuf4dyHdQeT8O67SV8FEyYRN3ivxw4KaUGpQMAQx3/7cgyFi+eyD8kcmRv
	t3d19sRccMiIiagq9JuTIXLEGD1xGdMrhgXJUGuBGuEODAOvWQdpQ6s1YqZhW9us6Cpn4y
	boPnd6hPDxGUQ0FLq8oXEYbAzM+l6Y+zPvtM262akNzIlpl3WNMkv4USjQQm5Q==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: sashal@kernel.org,
	linux-kernel@vger.kernel.org
Cc: frederic@kernel.org,
	david@redhat.com,
	viro@zeniv.linux.org.uk,
	paulmck@kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>,
	stable@vger.kernel.org
Subject: [PATCH v2] kernel/fork: Increase minimum number of allowed threads
Date: Sat, 12 Jul 2025 01:08:29 +0200
Message-ID: <20250711230829.214773-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A modern Linux system creates much more than 20 threads at bootup.
When I booted up OpenWrt in qemu the system sometimes failed to boot up
when it wanted to create the 419th thread. The VM had 128MB RAM and the
calculation in set_max_threads() calculated that max_threads should be
set to 419. When the system booted up it tried to notify the user space
about every device it created because CONFIG_UEVENT_HELPER was set and
used. I counted 1299 calls to call_usermodehelper_setup(), all of
them try to create a new thread and call the userspace hotplug script in
it.

This fixes bootup of Linux on systems with low memory.

I saw the problem with qemu 10.0.2 using these commands:
qemu-system-aarch64 -machine virt -cpu cortex-a57 -nographic

Cc: stable@vger.kernel.org
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 7966c9a1c163..388299525f3c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -115,7 +115,7 @@
 /*
  * Minimum number of threads to boot the kernel
  */
-#define MIN_THREADS 20
+#define MIN_THREADS 600
 
 /*
  * Maximum number of threads
-- 
2.50.1


