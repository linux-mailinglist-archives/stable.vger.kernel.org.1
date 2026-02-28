Return-Path: <stable+bounces-221019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PicAwhIo2l//AQAu9opvQ
	(envelope-from <stable+bounces-221019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:54:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 842A11C786C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E95F32DC15B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532324BCAB3;
	Sat, 28 Feb 2026 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvyx6iRl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AA44BCAB0;
	Sat, 28 Feb 2026 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301362; cv=none; b=T1rhlaXy3XgpEm7mr3pDgqfhjnyjwlstQMPQBPm+7N8od8ZKF+yexMb+0ISciNFC+y1KGgN+KWmWPOEgkkxR3TGaspjvIjDQUuODUz0Ik5z0W393Ij+exJLMd5jU0FfuUrEv6JDLwXnL7w4oV4R5jXFdsKzggJcfA+l97rJxt04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301362; c=relaxed/simple;
	bh=dTle06lUXDk7SlT5K/JGW0wMzFUKzTs8xoOQno5za78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7MumSOh8jG6dvz7m+baUAAKTWLnZ7aRRz3sWkJGxTiL7OLYmSjDQdX+pWJfrws2jFkkuJHVGT1wpona8kiVUQAiz1wx3TIGxl74w2mmIZKDOi7gmn997hQdOeimy7KWC0i52blwMpTGgULxWxX9ZmZZkwb/Ssucz2RprE5qrB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvyx6iRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B806C2BC87;
	Sat, 28 Feb 2026 17:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301362;
	bh=dTle06lUXDk7SlT5K/JGW0wMzFUKzTs8xoOQno5za78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kvyx6iRl5AENPh10NpAYwn29JGiXg4HY9FN17i077hl6GqngZdo8Sncm2+SNz1+1u
	 35pUfT8A5AiIv76P75kTWSYA8mkjK5CzfdwiLRavG1MvEeTmJNamRadAuOerTERGVM
	 FdsmdwLDaJ1MjYYva1nfKLFrIZ7D+8+e67LHnWiEyxd07f+WpyzwxP/QUGZ067O5Vk
	 BZJwuIeeIUiLGNpfwBJjV8hU/kyrsisT5B+8wQaRYR2Y+xHK2yY2o/rcmF3oTz0u3O
	 bA6KoEWcLI7zfuB/7pcp55iUquCBC3iYMRkZj0amTkSqvsUDuMgRRAn5edCQLuGsZO
	 pULrCtnNKBzmA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	stable@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 550/752] media: stm32: dcmipp: bytecap: clear all interrupts upon stream stop
Date: Sat, 28 Feb 2026 12:44:21 -0500
Message-ID: <20260228174750.1542406-550-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-221019-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 842A11C786C
X-Rspamd-Action: no action

From: Alain Volmat <alain.volmat@foss.st.com>

[ Upstream commit 222f1279edd9008ee35b62de156ddac84e31443c ]

Ensure that there are no pending interrupts after we have stopped the
pipeline. Indeed, it could happen that new interrupt has been generated
during the stop_streaming processing hence clear them in order to avoid
getting a new interrupt right from the start of a next start_streaming.

Fixes: 28e0f3772296 ("media: stm32-dcmipp: STM32 DCMIPP camera interface driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c
index 1c1b6b48918ee..b18e273ef4a3e 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c
@@ -512,6 +512,9 @@ static void dcmipp_bytecap_stop_streaming(struct vb2_queue *vq)
 	/* Disable pipe */
 	reg_clear(vcap, DCMIPP_P0FSCR, DCMIPP_P0FSCR_PIPEN);
 
+	/* Clear any pending interrupts */
+	reg_write(vcap, DCMIPP_CMFCR, DCMIPP_CMIER_P0ALL);
+
 	spin_lock_irq(&vcap->irqlock);
 
 	/* Return all queued buffers to vb2 in ERROR state */
-- 
2.51.0


