Return-Path: <stable+bounces-252354-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDdPNa0kDmr26QUAu9opvQ
	(envelope-from <stable+bounces-252354-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:16:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEAF59AA46
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30B6231990B6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24F836A02E;
	Wed, 20 May 2026 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="voUHl3U7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B557B331220;
	Wed, 20 May 2026 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300457; cv=none; b=TPQzPWgYLKQie/WRuJp4RKDDjUTYRzZmNaZeG4lGgLvlMEvuzrknxoUeVn+fKtXWP2UwZuUBWAF66Zy0gP1WsFM6JXUwhe+Zu8vlW8fhgPAWZgLkWrF01o6e6JJS0vhV8MClNqNSyuAcb3fjIDVkVj+Smwmu4vrOlYgjFni6x0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300457; c=relaxed/simple;
	bh=9yDaGvHQSIMFJLad9nGUi+f8+0MPhQlWLtwjTdTHgZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MiQ/VtSaTQ5Tj2ZFKAAhxz74gmzrhFBvY6hMjI6iPSb20Ke1FAtY81mkqOl/ajmqFtGG/cwMJ1EoRBiV8qxrYdK+KOMjxl0KmrTpxuvjFI502jV+YoQCT4Wzo2voB7dr+cMzAe9RQRHMrYxW8cVa7K6+7Y/DUbknd3OMtVw/o5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=voUHl3U7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B7E1F000E9;
	Wed, 20 May 2026 18:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300456;
	bh=PqnOO+3fMuUYEi+0pxjrvMvprLcXNeb4X66F8RJ0t/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=voUHl3U7C4nu9xxJTNliHGxltJ0NICnTQPIA4Xtdj1SyVQd1DSwkUF/HxJ2IVX8h5
	 olruzFM8RSXspUEuSAXUfV4uCGYpAMRWc2ebpyhM57cBKdptkCLxwUEqUaaS6imjnj
	 AdtALOhXzrJCyeBSepJn2aDUoMaD1mFPe6Czs5iA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandru Dadu <alexandru.dadu@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 165/666] drm/imagination: Switch reset_reason fields from enum to u32
Date: Wed, 20 May 2026 18:16:16 +0200
Message-ID: <20260520162114.783447103@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252354-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,imgtec.com:email]
X-Rspamd-Queue-Id: 4DEAF59AA46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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




