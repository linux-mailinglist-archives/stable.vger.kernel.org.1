Return-Path: <stable+bounces-228072-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI66FulHwWlGSAQAu9opvQ
	(envelope-from <stable+bounces-228072-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:02:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E60B62F3AD7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 419F0309FC1A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE433AE18C;
	Mon, 23 Mar 2026 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PAOiHiBj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C093AC0C9;
	Mon, 23 Mar 2026 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274044; cv=none; b=B6C+1Gsq5UZaD8ozLL83QqbPQcWvMNJX9pHR3nDawnzoaOCMN3MagoCtZXj3f0KSITd3lmWI4zXQcY6qmqs5xUdpE3A4+G8+9efwKGZTIHgUJlV6R/TgYC/AmteBU/xcXbTOB8m5W42OeB7o8xB1rVbjniBhbjlqRUWoQ6kpGmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274044; c=relaxed/simple;
	bh=zravM1OCV2U4VbRsW6194yuaeQLOhhfptGHuaxi+nYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZAUxBUMZg1fvrNNEgF2S2DaAs1WlH/uUwOawuK2rrNME5+lKDzJ3e2LPn3w3gelawXubzwdJnA4+pnA/6h5Im/UwDTE8kQ4eAF9ArpSe6vdHUdqH/WBCFV+3toAimKxpGRvHgtqAkXT0JsRwIviHbmT0caOalR4inHJgo+Ykhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PAOiHiBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2739EC2BCB3;
	Mon, 23 Mar 2026 13:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274044;
	bh=zravM1OCV2U4VbRsW6194yuaeQLOhhfptGHuaxi+nYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PAOiHiBjLSG6yArQprT8Wo+GqoINUDJURP8/jNuGL/8O/rHZba3Jnz9jl8ZAZT+CO
	 EF38SQWyjofbKHMnJof0WyDG07zmuMCJWID1u5sqb6Le+OKnqlsLdcksYbqpwVKEA7
	 R983Fmv/xFTs7HtwqeJpo+D1pQcU4rCJFxKwQXO8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Sanjay Yadav <sanjay.kumar.yadav@intel.com>
Subject: [PATCH 6.19 092/220] drm/xe: Fix missing runtime PM reference in ccs_mode_store
Date: Mon, 23 Mar 2026 14:44:29 +0100
Message-ID: <20260323134507.500304374@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-228072-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.freedesktop.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: E60B62F3AD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanjay Yadav <sanjay.kumar.yadav@intel.com>

commit 65d046b2d8e0d6d855379a981869005fd6b6a41b upstream.

ccs_mode_store() calls xe_gt_reset() which internally invokes
xe_pm_runtime_get_noresume(). That function requires the caller
to already hold an outer runtime PM reference and warns if none
is held:

  [46.891177] xe 0000:03:00.0: [drm] Missing outer runtime PM protection
  [46.891178] WARNING: drivers/gpu/drm/xe/xe_pm.c:885 at
  xe_pm_runtime_get_noresume+0x8b/0xc0

Fix this by protecting xe_gt_reset() with the scope-based
guard(xe_pm_runtime)(xe), which is the preferred form when
the reference lifetime matches a single scope.

v2:
- Use scope-based guard(xe_pm_runtime)(xe) (Shuicheng)
- Update commit message accordingly

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7593
Fixes: 480b358e7d8e ("drm/xe: Do not wake device during a GT reset")
Cc: <stable@vger.kernel.org> # v6.19+
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Suggested-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
Reviewed-by: Shuicheng Lin <shuicheng.lin@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260313071608.3459480-2-sanjay.kumar.yadav@intel.com
(cherry picked from commit 7937ea733f79b3f25e802a0c8360bf7423856f36)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_gt_ccs_mode.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/xe/xe_gt_ccs_mode.c
+++ b/drivers/gpu/drm/xe/xe_gt_ccs_mode.c
@@ -12,6 +12,7 @@
 #include "xe_gt_printk.h"
 #include "xe_gt_sysfs.h"
 #include "xe_mmio.h"
+#include "xe_pm.h"
 #include "xe_sriov.h"
 
 static void __xe_gt_apply_ccs_mode(struct xe_gt *gt, u32 num_engines)
@@ -150,6 +151,7 @@ ccs_mode_store(struct device *kdev, stru
 		xe_gt_info(gt, "Setting compute mode to %d\n", num_engines);
 		gt->ccs_mode = num_engines;
 		xe_gt_record_user_engines(gt);
+		guard(xe_pm_runtime)(xe);
 		xe_gt_reset(gt);
 	}
 



