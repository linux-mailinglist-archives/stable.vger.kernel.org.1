Return-Path: <stable+bounces-161689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FEFB02754
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 01:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643DE5461BD
	for <lists+stable@lfdr.de>; Fri, 11 Jul 2025 23:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801991F8753;
	Fri, 11 Jul 2025 23:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="s7p0JKBA"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20FCEEBD;
	Fri, 11 Jul 2025 23:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752275063; cv=none; b=IGZP/5dtv1ZF1th/W/0Iq8/mtIjfk7Un8/AiOEuCRJWxmUdQFf0J1rq0bGMyRXoHJWuOnuelEQcV8Gq+DQ44ygr7WAYqkj7S5erfobJSnKgQiH0RebxGwAILtoQmTpKf+HwPU+D/BAq1GVorZwNoRWlq1amF2yg53wprNDoE1go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752275063; c=relaxed/simple;
	bh=wNvfBX4TR767dMxXw25YCG4yyWMISCgR+M2tEP4Rohw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJac9uflb4RO5bdQelzuARRJYvzJ09scfpOVOvqd8ATsVZxH7KI5djJsbGrTpJPffBvs9aqVRTw/eNFsU0mW5pcC1xNQApo+ebab0lBCNIsWH6N9dSRdYL+ltb1ioHVmNYXbrc6T/kjGyaLVpdW2DBJC6r1cqq52QYoxpfdiUlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de; spf=pass smtp.mailfrom=hauke-m.de; dkim=pass (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b=s7p0JKBA; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hauke-m.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bf6j71fvDz9swN;
	Sat, 12 Jul 2025 01:04:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
	t=1752275051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G0dq+6kLOG7lWO2uQdL8frB6adBZ2iahZjar3rc9ltw=;
	b=s7p0JKBAzdzMtlvlqJCA3sH51mnc8Cs9q37D9Un7QudaQeeM8DKJeIlg+KAmPftPQJvyxb
	AcwUkBCxzfMFwezfVpKMy0hoU+C8niY524mAN7QK2lAat9ofBUDKnVvqy1auAucaBt3l/6
	JNYHP4pOr/ePYUgWGU2kB/iIysmJQldUg3vBwZ4cCTnyjz0azvhVBg6Ptgfom4tdtbw/fM
	Uzypuzd3lsVBe+6B4nHFmIVK5lYmfBHT0rv7qFH/coLw7VFg60lt3TnLRem6t5UsMD3KS6
	hkS5LXQ/Q1mWfbJfAbAMd7bk/01Ur+b92BNuo9ZvmySPwJiSGBa/MhO0biXQRA==
From: Hauke Mehrtens <hauke@hauke-m.de>
To: sashal@kernel.org,
	linux-kernel@vger.kernel.org
Cc: frederic@kernel.org,
	david@redhat.com,
	viro@zeniv.linux.org.uk,
	paulmck@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] kernel/fork: Increase minimum number of allowed threads
Date: Sat, 12 Jul 2025 01:03:48 +0200
Message-ID: <20250711230348.213841-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

A modern Linux system creates much more than 20 threads at bootup.
When I booted up OpenWrt in qemu the system sometimes failed to boot up
when it wanted to create the 419th thread. The VM had 128MB RAM and the
calculation in set_max_threads() calculated that max_threads should be
set to 419. When the system booted up it tried to notify the user space
about every device it created because CONFIG_UEVENT_HELPER was set and
used. I counted 1299 calles to call_usermodehelper_setup(), all of
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


