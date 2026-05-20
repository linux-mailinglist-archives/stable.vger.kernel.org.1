Return-Path: <stable+bounces-251063-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKfsCOH2DWry4wUAu9opvQ
	(envelope-from <stable+bounces-251063-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:01:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD665951CC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87B013116C0A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01053D8138;
	Wed, 20 May 2026 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L+Qt1EPo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67DB3403F4;
	Wed, 20 May 2026 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297005; cv=none; b=d2YasJ9Am3r3TxEKrlFWZRGEIyX1RwXzb5c+KCLyT3OqJJkC9Zf61d4kLYfHBtNR1G2WuW/GaPaUFur1Yr9TvmdV5wauY0Kb774jNdYCeBeoOGiXZ9eyNv7Iu5hQG64B7Jrosa/VtJQ3DfTxv0jCTGqhZ7wE8X0IrYo/u6nVqAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297005; c=relaxed/simple;
	bh=uLWvVQnTpv/cr78+dQCjvHHPBPRYhO13CmKmT+YH5pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OsN6ltPKnWm/bxMgMGf/ck/+691JG5YdBj/q6DWQuIVgZ7v0VUGtLYvfobbleJFeoQ2Xi2KUOCCPXYuddlbpaLwZ6JW8AOPR4lH2Mj8g1SsYYCln0d9oX0X9OdJz5jzc6uCOLr9KFM8iAl+9b+/cUrXYDVU7dE3xf0kmw/nhv40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L+Qt1EPo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D586F1F000E9;
	Wed, 20 May 2026 17:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297004;
	bh=dH/a8uJ88pA5fERqCUjAXVKMr1Dald4VXSQ349felOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L+Qt1EPoMYoz3ZG5D7mzLbBeWX3Xi6Cw/qKtF+/+UtrZCJVSaiPG5hM9UgW5Cg7aV
	 cp6SB0JS/Ml31JXgalBVuGYERnLOOfVNXw+DQ1YzfmKN469um7ZFqojAYVqczKyTOQ
	 TGuAbONtaPbrBPS0tEdjPsxNi2cRYzQpEUhQTdgw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 1015/1146] drm/xe/xelp: Fix Wa_18022495364
Date: Wed, 20 May 2026 18:21:05 +0200
Message-ID: <20260520162211.202309782@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251063-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 3BD665951CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

[ Upstream commit 7fe6cae2f7fad2b5166b0fc096618629f9e2ebcb ]

It looks I mistyped CS_DEBUG_MODE2 as CS_DEBUG_MODE1 when adding the
workaround. Fix it.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: ca33cd271ef9 ("drm/xe/xelp: Add Wa_18022495364")
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: <stable@vger.kernel.org> # v6.18+
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://patch.msgid.link/20260116095040.49335-1-tvrtko.ursulin@igalia.com
Stable-dep-of: 0df99689eb79 ("drm/xe/xelp: Fix Wa_18022495364")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_lrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
index 7b70cc01fdb38..fc38cdcc37714 100644
--- a/drivers/gpu/drm/xe/xe_lrc.c
+++ b/drivers/gpu/drm/xe/xe_lrc.c
@@ -1202,7 +1202,7 @@ static ssize_t setup_invalidate_state_cache_wa(struct xe_lrc *lrc,
 	if (xe_gt_WARN_ON(lrc->gt, max_len < 3))
 		return -ENOSPC;
 
-	*cmd++ = MI_LOAD_REGISTER_IMM | MI_LRI_NUM_REGS(1);
+	*cmd++ = MI_LOAD_REGISTER_IMM | MI_LRI_LRM_CS_MMIO | MI_LRI_NUM_REGS(1);
 	*cmd++ = CS_DEBUG_MODE2(0).addr;
 	*cmd++ = _MASKED_BIT_ENABLE(INSTRUCTION_STATE_CACHE_INVALIDATE);
 
-- 
2.53.0




