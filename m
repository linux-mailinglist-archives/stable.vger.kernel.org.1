Return-Path: <stable+bounces-247429-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEDsM7DLBmrynwIAu9opvQ
	(envelope-from <stable+bounces-247429-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:30:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5255F54A9AC
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FFB030A8488
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D722F37AA81;
	Fri, 15 May 2026 07:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HP0WTrMq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A803E3C78
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778829826; cv=none; b=iZpmHnkQE5FhiOYJeDPwhifGwHLvEjfwwNOXecxJ3aUNmE2tl0R8v3sGzXq1DTbEzpAMqMl0fh1SzXl6r/6p77z4uDevZklpmMH8N/cqhD0naQ+4z2vc6QWchTp60sb4TQekbnfjtSgEOVqS7Wgi/2dRM18SvUBQbs6Y3yZL7SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778829826; c=relaxed/simple;
	bh=J6R4VG/rt1h/tSJ6pKvDbgUG8Ohc9yLQHI0P9YAqA9M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PgXziCUm3IUyg1dz3ac0zbJ/Q4qotNY8HmwVYLsixG9F0C8UTt6/NE7s+FXCnOU6UqOvvhdR1cUEJPYJS2QbHJUy/bZNW50XN+L8e7o5p77Hpt3tHp0PxpfnKnA+9j4iECRVSGWwzgtGxcmjQ4mP9sy21IwSvRBh8a3xAghR/zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HP0WTrMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4D8C2BCB0;
	Fri, 15 May 2026 07:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778829826;
	bh=J6R4VG/rt1h/tSJ6pKvDbgUG8Ohc9yLQHI0P9YAqA9M=;
	h=Subject:To:Cc:From:Date:From;
	b=HP0WTrMq09/OF1PrA4TXRyow9HlriAnueGPeb5OjUeZbCMo6XdrEG65uf74wUWik7
	 0ZQMQTBIcbMSLohZcv/rJEMwYzlFRpqqsGFxW1Fxl9Nc1pIwQ7iqpwoBeyRzYHU270
	 QYSpG40W/2XFWJ1aEDLccPSl90gsIidyFAl6Tm/8=
Subject: FAILED: patch "[PATCH] drm/xe/hdcp: Add NULL check for media_gt in" failed to apply to 6.12-stable tree
To: gustavo.sousa@intel.com,matthew.brost@intel.com,matthew.d.roper@intel.com,shuicheng.lin@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 09:23:42 +0200
Message-ID: <2026051542-splatter-narrow-b00a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5255F54A9AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247429-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,intel.com:email,msgid.link:url]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 60a1e131a811b68703da58fd805ab359b704ab03
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051542-splatter-narrow-b00a@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 60a1e131a811b68703da58fd805ab359b704ab03 Mon Sep 17 00:00:00 2001
From: Gustavo Sousa <gustavo.sousa@intel.com>
Date: Thu, 16 Apr 2026 15:17:19 -0300
Subject: [PATCH] drm/xe/hdcp: Add NULL check for media_gt in
 intel_hdcp_gsc_check_status()

When media GT is disabled via configfs, there is no allocation for
media_gt, which is kept as NULL.  In such scenario,
intel_hdcp_gsc_check_status() results in a kernel pagefault error due to
&gt->uc.gsc being evaluated as an invalid memory address.

Fix that by introducing a NULL check on media_gt and bailing out early
if so.

While at it, also drop the NULL check for gsc, since it can't be NULL if
media_gt is not NULL.

v2:
  - Get address for gsc only after checking that gt is not NULL.
    (Shuicheng)
  - Drop the NULL check for gsc. (Shuicheng)
v3:
  - Add "Fixes" and "Cc: <stable...>" tags. (Matt)

Fixes: 4af50beb4e0f ("drm/xe: Use gsc_proxy_init_done to check proxy status")
Cc: <stable@vger.kernel.org> # v6.10+
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Reviewed-by: Shuicheng Lin <shuicheng.lin@intel.com>
Link: https://patch.msgid.link/20260416-check-for-null-media_gt-in-intel_hdcp_gsc_check_status-v2-1-9adb9fd3b621@intel.com
Signed-off-by: Gustavo Sousa <gustavo.sousa@intel.com>
(cherry picked from commit bfaf87e84ca3ca3f6e275f9ae56da47a8b55ffd1)
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

diff --git a/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c b/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
index 29c72aa4b0d2..33494b86205d 100644
--- a/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
+++ b/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
@@ -37,9 +37,17 @@ static bool intel_hdcp_gsc_check_status(struct drm_device *drm)
 	struct xe_device *xe = to_xe_device(drm);
 	struct xe_tile *tile = xe_device_get_root_tile(xe);
 	struct xe_gt *gt = tile->media_gt;
-	struct xe_gsc *gsc = &gt->uc.gsc;
+	struct xe_gsc *gsc;
 
-	if (!gsc || !xe_uc_fw_is_available(&gsc->fw)) {
+	if (!gt) {
+		drm_dbg_kms(&xe->drm,
+			    "not checking GSC status for HDCP2.x: media GT not present or disabled\n");
+		return false;
+	}
+
+	gsc = &gt->uc.gsc;
+
+	if (!xe_uc_fw_is_available(&gsc->fw)) {
 		drm_dbg_kms(&xe->drm,
 			    "GSC Components not ready for HDCP2.x\n");
 		return false;


