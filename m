Return-Path: <stable+bounces-210012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A3BD2F0C9
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 10:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30DF43061FDB
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 09:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CF231355E;
	Fri, 16 Jan 2026 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hMjlIOih"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D62D357A47
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557063; cv=none; b=ZqG8nv8lBUTSlhHC7h+Mmfu5OG49QbU72yDqaADPW4VbhYAMQdGU2SXXPeJ7pKkSiFeIXwyAFdJkOAr+QBBemSSD+PMD4qrRkmU1iMfvgCXzzsCZmhQVF95uHPDAb32fBiWLvK7uxDt+7GUvLeV47ioI/qdfNQtexGhJmm41c48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557063; c=relaxed/simple;
	bh=YNHk9qHbZFtCFVFm1vI3Q98fMi1vsn1JwRyY0iYpFzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j3tiim+t0wGv2uHxD1vG3g5QwRSXYhXZuix0+w67UIYxkDKZ9Dsflt8yattXRDmCoRZwYDNvmMknybSDsJaC8jFSA3rZQ03RurtVX7Qlh6s8f2a+7/zHo16ZQwpIBTtb5iCXYFPPHXND9ygYMZnPEMvYOy3OkCIBTRBvGIyNbh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hMjlIOih; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OZJDXMXOLAM4VqZIrkEKxzvUE4UsA75pYg53aJGeFwA=; b=hMjlIOih5HtmSjeX82SwqBcpdT
	9fJ6TPaRCrABIVIZZbUmcNoelUobjs6KUvEHZN8pg05klVrF12hsVfRqML6qsh5SAtqRvhrbTEONX
	wWGj4YJH8lxR0qylN4Pf8VLF0CA3U19ZvIai7V2kyj2/AOwNvjS1A8Zek01DrktgQ4ey4Iow6mxfG
	oQH4XG4+lIX778RQ6/2TxCn6RgZ/6ef5f0n+MBYSSQrDUP+j26X8ly3sjVN/sKyCQbZGr1+01mO+C
	irxPFL/OqJkG+67/ZgFbO3qtBQx0GUTgHg12qKtHtHZLJ61xALl50b6mHXE0Aiz6Yaqk5gtOj7PCH
	cXDzn1Sg==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vggTf-0066AN-It; Fri, 16 Jan 2026 10:50:47 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: intel-xe@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/xelp: Fix Wa_18022495364
Date: Fri, 16 Jan 2026 09:50:40 +0000
Message-ID: <20260116095040.49335-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It looks I mistyped CS_DEBUG_MODE2 as CS_DEBUG_MODE1 when adding the
workaround. Fix it.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: ca33cd271ef9 ("drm/xe/xelp: Add Wa_18022495364")
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: <stable@vger.kernel.org> # v6.18+
---
 drivers/gpu/drm/xe/xe_lrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
index 70eae7d03a27..44f112df4eb2 100644
--- a/drivers/gpu/drm/xe/xe_lrc.c
+++ b/drivers/gpu/drm/xe/xe_lrc.c
@@ -1200,7 +1200,7 @@ static ssize_t setup_invalidate_state_cache_wa(struct xe_lrc *lrc,
 		return -ENOSPC;
 
 	*cmd++ = MI_LOAD_REGISTER_IMM | MI_LRI_NUM_REGS(1);
-	*cmd++ = CS_DEBUG_MODE1(0).addr;
+	*cmd++ = CS_DEBUG_MODE2(0).addr;
 	*cmd++ = _MASKED_BIT_ENABLE(INSTRUCTION_STATE_CACHE_INVALIDATE);
 
 	return cmd - batch;
-- 
2.52.0


