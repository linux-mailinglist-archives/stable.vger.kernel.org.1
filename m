Return-Path: <stable+bounces-258368-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK8nAcUoG2ra/ggAu9opvQ
	(envelope-from <stable+bounces-258368-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:13:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 692FA611425
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AE8130C475F
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1076D23392B;
	Sat, 30 May 2026 18:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A7IrqWqh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF812FDC5E;
	Sat, 30 May 2026 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164117; cv=none; b=AZD941hVWyOe64W1E2Y1LtS6QleZpic2tA5ZPXh9bjVx97+QR1EoLZ6T9k/OIBMeUvBhkATT/F/ghbgdCOHrOzE8BBv/W3vivk3ZfF8g6Ea+RNI8qqnWijVQBfNRYJ/Mblry44Uhxde5xQtR0y5OipxOdQX0hK/zXBvkS85obrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164117; c=relaxed/simple;
	bh=ZKg8rZ/qxUD1h4E2w9sdygxGjQpROeiRqK6L0Wkzb4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwYsEUnkwd7B8Y5xxPxoHi2CzbC6dD3sj4UPAfOWoAFsT2nyMf/phaCJADFNaBfLJ8zzpex+naZA+Y7h3YTtwSmQVHLk+2G8rjVWMzofdFs7gwa61zEpMEuycGj4zTcgYmP0iX8yjv1xBXXQ6vSk/whHWNSHH1ft7leDcTTYxLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A7IrqWqh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC461F00893;
	Sat, 30 May 2026 18:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164116;
	bh=H9cAvW/jKARapq2NyZtrWaSNP57LAauZx4pNNcrBERs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A7IrqWqhVW3WKs8eErRydU8IkMeOL5s85p8ZmAQu/5ARE8u0Dk/Rm0UMr6IMH7SkE
	 FbYd6jC3nyzWpYp73w3/sewMLvYhjFm8r9Y6VSN4PoC3ARt2xbHkbBilCbT4B1oxz4
	 t77OIyGBX0wr/YLOml0V5vdf0D5+N7apTlAX8izg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Connor Abbott <cwabbott0@gmail.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 458/776] drm/msm/a6xx: Fix HLSQ register dumping
Date: Sat, 30 May 2026 18:02:52 +0200
Message-ID: <20260530160252.206239392@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258368-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,oss.qualcomm.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[patchwork.freedesktop.org:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: 692FA611425
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Clark <robin.clark@oss.qualcomm.com>

[ Upstream commit c289a6db9ba6cb974f0317da142e4f665d589566 ]

Fix the bitfield offset of HLSQ_READ_SEL state-type bitfield.  Otherwise
we are always reading TP state when we wanted SP or HLSQ state.

Reported-by: Connor Abbott <cwabbott0@gmail.com>
Suggested-by: Connor Abbott <cwabbott0@gmail.com>
Fixes: 1707add81551 ("drm/msm/a6xx: Add a6xx gpu state")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/714236/
Message-ID: <20260325184043.1259312-1-robin.clark@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 61d0bb8c2fe0b..b25395af39b29 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -642,7 +642,7 @@ static void a6xx_get_crashdumper_hlsq_registers(struct msm_gpu *gpu,
 	u64 out = dumper->iova + A6XX_CD_DATA_OFFSET;
 	int i, regcount = 0;
 
-	in += CRASHDUMP_WRITE(in, REG_A6XX_HLSQ_DBG_READ_SEL, regs->val1);
+	in += CRASHDUMP_WRITE(in, REG_A6XX_HLSQ_DBG_READ_SEL, (regs->val1 & 0xff) << 8);
 
 	for (i = 0; i < regs->count; i += 2) {
 		u32 count = RANGE(regs->registers, i);
-- 
2.53.0




