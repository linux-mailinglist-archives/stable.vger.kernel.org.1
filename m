Return-Path: <stable+bounces-220348-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEacHV42o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220348-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:39:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B69FE1C612E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91A7531FB435
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124B439C23C;
	Sat, 28 Feb 2026 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPHLM8Gc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62D639C234;
	Sat, 28 Feb 2026 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300246; cv=none; b=pB3f2GnWGHHJYgDflm8MSLt7iCJ7TDcdQhtAh/AZpSX2eZHctoul+1iv2+N9XeFJiHTHdgT76xWIWMWS5gs/+kAJB4aapz84JuUMdE7ilRelAhYzknwbBE8itGcGCHxkEanzuXtGgp8KLCUWlXij5VZvYn3m2osSv8lXnqUNdjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300246; c=relaxed/simple;
	bh=YJsLExZqQcIZWzMl0Y0AJkAaHe6Xs7lXlNrP0xCnjDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhRO1l3f7x0Hen3BNtKriQA03Txrow58d1kjReNmKTJ757HTtV6KN6FzSwzBRBtVtMcAJqfbtrHHO+SrfUAe1w4RSGkyMqW61yKCqRmJ9VDmQqPLykAim9zM4q0nBv5uqFcE/kdc1goiWpO4RRX/Fl+tetQMny+DzdOMcC3THJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPHLM8Gc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068F8C19423;
	Sat, 28 Feb 2026 17:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300246;
	bh=YJsLExZqQcIZWzMl0Y0AJkAaHe6Xs7lXlNrP0xCnjDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rPHLM8GcAfUKHm3ZjTXAh6PI9bYpDzWRGfZNlsnFlJTt27mk32xGWBDV9Pm8SuZZ/
	 ctEme623TcIslSjiNuMqG+jbZD4H4U+rKh0YTGBTA2WJIvxUYqNUr9HpeM6uTCGAta
	 cUf3JRbskBBAGYW1ojW3UXkhLdmpwUTL65aiq+4WEcV7lQ+pP1ymPCMK119H8DyRT5
	 nhoK4WU6sD4iitM2587ZMlaX0oOX/S45v3NAsc1L/2Ogfslu43zPS/xeJrxKoK0f/S
	 V4zf+JjX8s3NaC6bJmSsAjtqGTXn5o2t4l6p/vTjtwH9qEURfuzdtHK1s7giKSRbxJ
	 8p62eYl4833/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ankit Soni <Ankit.Soni@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 270/844] iommu/amd: move wait_on_sem() out of spinlock
Date: Sat, 28 Feb 2026 12:23:03 -0500
Message-ID: <20260228173244.1509663-271-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220348-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B69FE1C612E
X-Rspamd-Action: no action

From: Ankit Soni <Ankit.Soni@amd.com>

[ Upstream commit d2a0cac10597068567d336e85fa3cbdbe8ca62bf ]

With iommu.strict=1, the existing completion wait path can cause soft
lockups under stressed environment, as wait_on_sem() busy-waits under the
spinlock with interrupts disabled.

Move the completion wait in iommu_completion_wait() out of the spinlock.
wait_on_sem() only polls the hardware-updated cmd_sem and does not require
iommu->lock, so holding the lock during the busy wait unnecessarily
increases contention and extends the time with interrupts disabled.

Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd/iommu.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0f9045ce93af1..c5f7e003d01c9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1180,7 +1180,12 @@ static int wait_on_sem(struct amd_iommu *iommu, u64 data)
 {
 	int i = 0;
 
-	while (*iommu->cmd_sem != data && i < LOOP_TIMEOUT) {
+	/*
+	 * cmd_sem holds a monotonically non-decreasing completion sequence
+	 * number.
+	 */
+	while ((__s64)(READ_ONCE(*iommu->cmd_sem) - data) < 0 &&
+	       i < LOOP_TIMEOUT) {
 		udelay(1);
 		i += 1;
 	}
@@ -1432,14 +1437,13 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 	raw_spin_lock_irqsave(&iommu->lock, flags);
 
 	ret = __iommu_queue_command_sync(iommu, &cmd, false);
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	ret = wait_on_sem(iommu, data);
 
-out_unlock:
-	raw_spin_unlock_irqrestore(&iommu->lock, flags);
-
 	return ret;
 }
 
@@ -3115,13 +3119,18 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 	raw_spin_lock_irqsave(&iommu->lock, flags);
 	ret = __iommu_queue_command_sync(iommu, &cmd, true);
 	if (ret)
-		goto out;
+		goto out_err;
 	ret = __iommu_queue_command_sync(iommu, &cmd2, false);
 	if (ret)
-		goto out;
+		goto out_err;
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+
 	wait_on_sem(iommu, data);
-out:
+	return;
+
+out_err:
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+	return;
 }
 
 static inline u8 iommu_get_int_tablen(struct iommu_dev_data *dev_data)
-- 
2.51.0


