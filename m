Return-Path: <stable+bounces-250342-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFiyEvsODmrB5wUAu9opvQ
	(envelope-from <stable+bounces-250342-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:43:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D26598A95
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B342C31653BA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BE21CDFCA;
	Wed, 20 May 2026 16:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0kOmpUlC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCE9369D42;
	Wed, 20 May 2026 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295164; cv=none; b=bPtIvWqY9GDXN53CgEQZQBLdn12nRQ81JkxSYmlKLD8fq9WXteWn2mS4/vd9cHngL4zQc69TTSqO9Q11B9+3b8s8DcLbt83Kh2tdXagx0WOY/8P2b9iCKyugZu15FF5p1k4eUN3poE10sIWZztSMWtNrl9K99h07NfPpSKcztno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295164; c=relaxed/simple;
	bh=wiK6NuqSdATvwYIoMwVMdhusdeqxRmy98FTPOJmTM+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrgkzCEjlPIkew7HNDqrx1bmjD6HfLMxFE7NBnHFQ3A4nSNUqdnshabEd2+QyHR2fhdjo8Cn1WEnyKN0rp0Zuh8F945rBjrheClf19CWJOjYYzZF4X8Yc5mYnmVKoVUQjbYwrxtwzjujobK0+pn/NLwKTacud7o9dFIvmJdvQrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0kOmpUlC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8281F000E9;
	Wed, 20 May 2026 16:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295161;
	bh=PPLMLuuNftIE4IfiOaHstuQ7UaGncHOePnJz+CI9c54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=0kOmpUlCX9D/ZzOuSxaQVp1g26UOU6rWlT87BJC2mZMIOUU5Xgm/KH+B3hfOuPqLG
	 tw9oX9Z00DIExCYCd2w6fzZYgZcwxFdwu25mjBqk6OowIc6XhL5X+XluAtE+xglg7U
	 AEnekvs9as0PRnUSiD8MY77Ym8H+uPlHn6wXvSdg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandru Dadu <alexandru.dadu@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0315/1146] drm/imagination: Switch reset_reason fields from enum to u32
Date: Wed, 20 May 2026 18:09:25 +0200
Message-ID: <20260520162155.327610191@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250342-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: A2D26598A95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandru Dadu <alexandru.dadu@imgtec.com>

[ Upstream commit d2f83a6cd598bf413f1acf34153bd1d71023fbab ]

Update the reset_reason fwif structure fields from enum to u32 to remove
any ambiguity from the interface (enum is not a fixed size thus is unfit
for the purpose of the data type).

Fixes: a26f067feac1f ("drm/imagination: Add FWIF headers")
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
Reviewed-by: Matt Coster <matt.coster@imgtec.com>
Link: https://patch.msgid.link/20260323-b4-firmware-context-reset-notification-handling-v3-2-1a66049a9a65@imgtec.com
Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/imagination/pvr_rogue_fwif.h        | 8 ++++++--
 drivers/gpu/drm/imagination/pvr_rogue_fwif_shared.h | 6 +++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_rogue_fwif.h b/drivers/gpu/drm/imagination/pvr_rogue_fwif.h
index 172886be4c820..5d590c4c25663 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_fwif.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_fwif.h
@@ -1347,8 +1347,12 @@ struct rogue_fwif_fwccb_cmd_freelists_reconstruction_data {
 struct rogue_fwif_fwccb_cmd_context_reset_data {
 	/* Context affected by the reset */
 	u32 server_common_context_id;
-	/* Reason for reset */
-	enum rogue_context_reset_reason reset_reason;
+	/*
+	 * Reason for reset
+	 * The valid values for reset_reason are the ones from
+	 * enum rogue_context_reset_reason
+	 */
+	u32 reset_reason;
 	/* Data Master affected by the reset */
 	u32 dm;
 	/* Job ref running at the time of reset */
diff --git a/drivers/gpu/drm/imagination/pvr_rogue_fwif_shared.h b/drivers/gpu/drm/imagination/pvr_rogue_fwif_shared.h
index 6c09c15bf9bd8..f95acd5a1f8e8 100644
--- a/drivers/gpu/drm/imagination/pvr_rogue_fwif_shared.h
+++ b/drivers/gpu/drm/imagination/pvr_rogue_fwif_shared.h
@@ -249,7 +249,11 @@ enum rogue_context_reset_reason {
 };
 
 struct rogue_context_reset_reason_data {
-	enum rogue_context_reset_reason reset_reason;
+	/*
+	 * The valid values for reset_reason are the ones from
+	 * enum rogue_context_reset_reason
+	 */
+	u32 reset_reason;
 	u32 reset_ext_job_ref;
 };
 
-- 
2.53.0




