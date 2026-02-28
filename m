Return-Path: <stable+bounces-220203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHSnA8sro2mF+AQAu9opvQ
	(envelope-from <stable+bounces-220203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:54:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4D51C52FD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E76C930B8494
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240814D8DA1;
	Sat, 28 Feb 2026 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIZRwC0u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6854D8D9C;
	Sat, 28 Feb 2026 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300108; cv=none; b=oEbJwf0cqdzV7TiFYvoxC6MsoK+NHRZ/CyZNcrXmPxRVJ2MXpClUBonUQqjAmT0HgGB5/SmuF42pxrdaB92equILwgVy6txVoiEWNHxVbWVk7XyOhzPR6ri633oWZgAcYQLTK6XHsFfUP05FZLyg3mImX++184cPM9p7IDwacf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300108; c=relaxed/simple;
	bh=tBg3vpDSFHpRBvcSIvLKnAjE33wX6Eu8WWVlpec+G9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/keo7DtNX84j9OjIk3DHzYXGmPqCJugeIr9A1+qOTsyYJw9jeEFMyrpyJ7ZCsem5TDTa5ievOPH83SjZKE1yojnNTrnQj/kHGMjCIHI09UYnpv9X5M3KdqO9zGzFzAiuei0CN6f2IH+fTPbojtmZ6rKVM72ptAhfgTGsqfDQTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIZRwC0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F03C116D0;
	Sat, 28 Feb 2026 17:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300108;
	bh=tBg3vpDSFHpRBvcSIvLKnAjE33wX6Eu8WWVlpec+G9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UIZRwC0uJALE5lv3tH1CQOt6imtsAZlh2JJ862vk+jin4cjNYeLlibfev+cswkG3f
	 dlPPQ9/c4CDuMcXmJop+qkMVK4jKDhXwaBZqHpaROHlPTR64yTLPl6Ledsd9zlWkR6
	 3yZxz98Vo7bZP9izC035uVJkmR8XuXCuVGclkugkSOPSJ2h1nik80FOxBmi4352pdT
	 yfbH3Pln7oWk8ilZ2/+CFAicPse5VZ57WkNeJduFfRmp+ZCeEt+4ud9qsvDRBkR98e
	 yii6XVMJlxdDKT0WJJ7Lr+mWBut8T806LuXV/1TCluoFytfdCFWwyzRGBkPUi7rY7R
	 BDA7cjGWUUdvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 125/844] drm/panthor: Always wait after sending a command to an AS
Date: Sat, 28 Feb 2026 12:20:38 -0500
Message-ID: <20260228173244.1509663-126-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220203-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email,arm.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 7E4D51C52FD
X-Rspamd-Action: no action

From: Boris Brezillon <boris.brezillon@collabora.com>

[ Upstream commit d2c6fde56d451ca48a5e03428535ce3dbc8fc910 ]

There's currently no situation where we want to issue a command to an
AS and not wait for this command to complete. The wait is either
explicitly done (LOCK, UNLOCK) or it's missing (UPDATE). So let's
turn write_cmd() into as_send_cmd_and_wait() that has the wait after
a command is sent.

v2:
- New patch

v3:
- Collect R-b

v4:
- No changes

Reviewed-by: Steven Price <steven.price@arm.com>
Link: https://patch.msgid.link/20251128084841.3804658-2-boris.brezillon@collabora.com
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 9194bad4b6196..c15d2a3906db9 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -510,27 +510,29 @@ static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
 	return ret;
 }
 
-static int write_cmd(struct panthor_device *ptdev, u32 as_nr, u32 cmd)
+static int as_send_cmd_and_wait(struct panthor_device *ptdev, u32 as_nr, u32 cmd)
 {
 	int status;
 
 	/* write AS_COMMAND when MMU is ready to accept another command */
 	status = wait_ready(ptdev, as_nr);
-	if (!status)
+	if (!status) {
 		gpu_write(ptdev, AS_COMMAND(as_nr), cmd);
+		status = wait_ready(ptdev, as_nr);
+	}
 
 	return status;
 }
 
-static void lock_region(struct panthor_device *ptdev, u32 as_nr,
-			u64 region_start, u64 size)
+static int lock_region(struct panthor_device *ptdev, u32 as_nr,
+		       u64 region_start, u64 size)
 {
 	u8 region_width;
 	u64 region;
 	u64 region_end = region_start + size;
 
 	if (!size)
-		return;
+		return 0;
 
 	/*
 	 * The locked region is a naturally aligned power of 2 block encoded as
@@ -553,7 +555,7 @@ static void lock_region(struct panthor_device *ptdev, u32 as_nr,
 
 	/* Lock the region that needs to be updated */
 	gpu_write64(ptdev, AS_LOCKADDR(as_nr), region);
-	write_cmd(ptdev, as_nr, AS_COMMAND_LOCK);
+	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_LOCK);
 }
 
 static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
@@ -586,9 +588,7 @@ static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
 	 * power it up
 	 */
 
-	lock_region(ptdev, as_nr, iova, size);
-
-	ret = wait_ready(ptdev, as_nr);
+	ret = lock_region(ptdev, as_nr, iova, size);
 	if (ret)
 		return ret;
 
@@ -601,10 +601,7 @@ static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
 	 * at the end of the GPU_CONTROL cache flush command, unlike
 	 * AS_COMMAND_FLUSH_MEM or AS_COMMAND_FLUSH_PT.
 	 */
-	write_cmd(ptdev, as_nr, AS_COMMAND_UNLOCK);
-
-	/* Wait for the unlock command to complete */
-	return wait_ready(ptdev, as_nr);
+	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UNLOCK);
 }
 
 static int mmu_hw_do_operation(struct panthor_vm *vm,
@@ -633,7 +630,7 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 	gpu_write64(ptdev, AS_MEMATTR(as_nr), memattr);
 	gpu_write64(ptdev, AS_TRANSCFG(as_nr), transcfg);
 
-	return write_cmd(ptdev, as_nr, AS_COMMAND_UPDATE);
+	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 }
 
 static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr)
@@ -648,7 +645,7 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr)
 	gpu_write64(ptdev, AS_MEMATTR(as_nr), 0);
 	gpu_write64(ptdev, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
 
-	return write_cmd(ptdev, as_nr, AS_COMMAND_UPDATE);
+	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 }
 
 static u32 panthor_mmu_fault_mask(struct panthor_device *ptdev, u32 value)
-- 
2.51.0


