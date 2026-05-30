Return-Path: <stable+bounces-257469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GObNAekaG2oq/QgAu9opvQ
	(envelope-from <stable+bounces-257469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:14:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FA560F32F
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D03703019A1F
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEAD34389B;
	Sat, 30 May 2026 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h6qkZXgs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93131EEA8;
	Sat, 30 May 2026 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161104; cv=none; b=ftzS7M/ZTC33TBmwnuCQPxvmN4XHPJ0iWH2QvE5cM6j/N3DlUmTnv/76bsUZ9CO5ElqLlLKsAfzVuXKmx2kw2nvt744+0+GdsbWmEH9q/H3iNEMG3jQcCp7rEweNCx+HD4LYJ9vK5/LQS0o5L+5Mz1t2kmo+cyaSga7PBgTIofE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161104; c=relaxed/simple;
	bh=vNbT3GqL2IqA3eNJiSejALhgjTuUolCMZeBClgAUO6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oesVF9asNICrLoBYkld/Qcp9Y0x0W4cEC+Yi43rMPAd5H28WnKIwm3gTur4sZWq80dPrzAstAOh/NisIeWYmjBOdmsXiLSRN1Du655QysUPQCobpnhDYooCO4vpGy7+NjwKPa1Wy/gHH9+uPZ/ueWLgB+87n1G3g1xapr4JtZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h6qkZXgs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BC31F00893;
	Sat, 30 May 2026 17:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161103;
	bh=h9EBqjNPfmjCFlYpUa1Xn4TmjflMJ+NG1yjnaz5CttU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h6qkZXgsk19q8Zqgwa32BgYmn2soJghypJQ4Uu0czTHCUm6KjrxyFzFjpLd/4uU87
	 19xbt77QMSyyo/mg5QA+O2vEVqNAkvRNeG5mK+n/thT1FnWw0E8yMtzUqC6JK0Lwry
	 MmZw8ha3obriC02yGuCo1t7MVHUMpg4R25P9qdfM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Connor Abbott <cwabbott0@gmail.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 526/969] drm/msm/a6xx: Fix HLSQ register dumping
Date: Sat, 30 May 2026 18:00:50 +0200
Message-ID: <20260530160314.883538632@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257469-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,oss.qualcomm.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: F2FA560F32F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 7a30249974cff..de84bd623f16a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -649,7 +649,7 @@ static void a6xx_get_crashdumper_hlsq_registers(struct msm_gpu *gpu,
 	u64 out = dumper->iova + A6XX_CD_DATA_OFFSET;
 	int i, regcount = 0;
 
-	in += CRASHDUMP_WRITE(in, REG_A6XX_HLSQ_DBG_READ_SEL, regs->val1);
+	in += CRASHDUMP_WRITE(in, REG_A6XX_HLSQ_DBG_READ_SEL, (regs->val1 & 0xff) << 8);
 
 	for (i = 0; i < regs->count; i += 2) {
 		u32 count = RANGE(regs->registers, i);
-- 
2.53.0




