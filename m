Return-Path: <stable+bounces-215086-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ4XJg3yiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215086-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:41:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1127110AF3
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B1C7305DB8D
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F46259CAF;
	Mon,  9 Feb 2026 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SjlGW1ke"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D021AF0AF;
	Mon,  9 Feb 2026 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647628; cv=none; b=pfy2yKbgNMCsdqCtYFL04H3R8xCH1ykPJZer9Y/YBWb4n4tgv4M2ARDMRVC55F7TUqjFXnhrZDmJLcExT9lizOU7BMnJVSflCdEk+JRUn7RpKIxuQqbNB2jQ0k4GmXiRT0+wDEPePzGqMu90u5dCOUQfgYFJOMUCbv/aYd5ON9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647628; c=relaxed/simple;
	bh=dqQp45SQ0dEoIbkZaOWP90VcxDqnCFsaGwFRKDpuYDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOpnkrPjKFF48Hi2XmYZBpU9wNKmS0pgYmw7lQTn85pC0fOTtNS58t7GscXiKEc5I4xNaaj2JDbD7VNXDCS/Na11xgE6W8saHKcFsyghsAUntvla4AJXIzvxU0mhxYqAm+/y49+qkyE17mq1N4XxAAv3CwE4pRpfcaNvcHZ25p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SjlGW1ke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921D3C116C6;
	Mon,  9 Feb 2026 14:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647628;
	bh=dqQp45SQ0dEoIbkZaOWP90VcxDqnCFsaGwFRKDpuYDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SjlGW1keRkOur+T4f7OvhVP4FTrH7DoPg4ZT5E+vJBJLeShZd2cXPkqWtrAdtC/Ax
	 8Rn4I3VmVO76kRShT8Cg0S3LQsXN9cDsUJEKXbwgld9mbcC9jmZYjpv+N3d+6qByIu
	 ZZTPOWb8ZmdCexDYxqEjbS5c61xBS7gqysTWf8d4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	George D Sworo <george.d.sworo@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 155/175] drm/xe/guc: Fix CFI violation in debugfs access.
Date: Mon,  9 Feb 2026 15:23:48 +0100
Message-ID: <20260209142326.071866988@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215086-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: F1127110AF3
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

[ Upstream commit 4cb1b327135dddf3d0ec2544ea36ed05ba2252bc ]

xe_guc_print_info is void-returning, but the function pointer it is
assigned to expects an int-returning function, leading to the following
CFI error:

[  206.873690] CFI failure at guc_debugfs_show+0xa1/0xf0 [xe]
(target: xe_guc_print_info+0x0/0x370 [xe]; expected type: 0xbe3bc66a)

Fix this by updating xe_guc_print_info to return an integer.

Fixes: e15826bb3c2c ("drm/xe/guc: Refactor GuC debugfs initialization")
Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: George D Sworo <george.d.sworo@intel.com>
Reviewed-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Link: https://patch.msgid.link/20260129182547.32899-2-daniele.ceraolospurio@intel.com
(cherry picked from commit dd8ea2f2ab71b98887fdc426b0651dbb1d1ea760)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_guc.c | 6 ++++--
 drivers/gpu/drm/xe/xe_guc.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index 00789844ea4d0..ae0c88da422b2 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -1632,7 +1632,7 @@ int xe_guc_start(struct xe_guc *guc)
 	return xe_guc_submit_start(guc);
 }
 
-void xe_guc_print_info(struct xe_guc *guc, struct drm_printer *p)
+int xe_guc_print_info(struct xe_guc *guc, struct drm_printer *p)
 {
 	struct xe_gt *gt = guc_to_gt(guc);
 	unsigned int fw_ref;
@@ -1644,7 +1644,7 @@ void xe_guc_print_info(struct xe_guc *guc, struct drm_printer *p)
 	if (!IS_SRIOV_VF(gt_to_xe(gt))) {
 		fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
 		if (!fw_ref)
-			return;
+			return -EIO;
 
 		status = xe_mmio_read32(&gt->mmio, GUC_STATUS);
 
@@ -1672,6 +1672,8 @@ void xe_guc_print_info(struct xe_guc *guc, struct drm_printer *p)
 
 	drm_puts(p, "\n");
 	xe_guc_submit_print(guc, p);
+
+	return 0;
 }
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_guc.h b/drivers/gpu/drm/xe/xe_guc.h
index 1cca05967e621..3b858933749bd 100644
--- a/drivers/gpu/drm/xe/xe_guc.h
+++ b/drivers/gpu/drm/xe/xe_guc.h
@@ -45,7 +45,7 @@ int xe_guc_self_cfg32(struct xe_guc *guc, u16 key, u32 val);
 int xe_guc_self_cfg64(struct xe_guc *guc, u16 key, u64 val);
 void xe_guc_irq_handler(struct xe_guc *guc, const u16 iir);
 void xe_guc_sanitize(struct xe_guc *guc);
-void xe_guc_print_info(struct xe_guc *guc, struct drm_printer *p);
+int xe_guc_print_info(struct xe_guc *guc, struct drm_printer *p);
 int xe_guc_reset_prepare(struct xe_guc *guc);
 void xe_guc_reset_wait(struct xe_guc *guc);
 void xe_guc_stop_prepare(struct xe_guc *guc);
-- 
2.51.0




