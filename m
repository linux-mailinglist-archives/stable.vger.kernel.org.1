Return-Path: <stable+bounces-255919-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNYaOI2nGGpolwgAu9opvQ
	(envelope-from <stable+bounces-255919-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:37:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F9E5F9236
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA1C2311CF47
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6680E313550;
	Thu, 28 May 2026 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XzGMdJxc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3065025F7B9;
	Thu, 28 May 2026 20:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000247; cv=none; b=tt69/vW4RO6oBITNuFOZ4h6zAIKt9lCH+0VbsjCnSir86uZPz2Agg72xlHFz+YaoWRbDE10vQ9E/TdjMrhSlhtTKUKX7cnntpQSJBZRDxOV/fjAtsDMTY8HhPXtu1VfFW+Y2aYH5scQ1Y2srv/NoElR2nOw3awNLQyemngfqIYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000247; c=relaxed/simple;
	bh=aa9acddHkhClbM85ADV08mExrMyTYG7MSTpYcsz/6YU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U78oOtz6mhFMfsRmUmEXPOkQQ5t/5PZ8iZ/ySj9834o7h9kHXN9daz7j7a9NuXW4BGpQk7q/P/afZsvvGoVAM98kMPYaJpQzPu8/GJvDvIbQM8AtGs6W30YANEG82OEBcuXZBl3gbHiaPW9VCnW8llzUqLtL7texrQqG3pZZ5bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XzGMdJxc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDCA1F000E9;
	Thu, 28 May 2026 20:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000246;
	bh=MdeNwd+6dxdZg3Il04M8/PJ47vytFdqMujdadJNWmb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XzGMdJxc37Fm94L7DD6KuwMbJwo1q2wsdtXu1pCKqqrjsafCafk/Mp3zJgzhvV077
	 5ixQDPlhdDJYNCtucof5IF3jk6Gism9XRu9d+pq7R4+mxZa7gBcCqZbVO24qOziCaY
	 PkuClrhbqeYZUHVrBdHtdxK2nAnBPGCxDhdHxnE8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mohanram Meenakshisundaram <mohanram.meenakshisundaram@intel.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 317/377] drm/xe/pf: Fix CFI failure in debugfs access
Date: Thu, 28 May 2026 21:49:15 +0200
Message-ID: <20260528194647.571929925@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255919-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 89F9E5F9236
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mohanram Meenakshisundaram <mohanram.meenakshisundaram@intel.com>

[ Upstream commit 96bf49b526e2d03a2b7f6e861925a08f46ed0d28 ]

Reading debugfs file (/sys/kernel/debug/dri/0/gt*/pf/adverse_events)
with CFI (Control Flow Integrity) enabled, the kernel panics at
xe_gt_debugfs_simple_show+0x82/0xc0.

xe_gt_debugfs_simple_show() declare a function pointer expecting int
return type, but xe_gt_sriov_pf_monitor_print_events() is void return
type, leading to CFI failure and kernel panic.

[507620.973657] CFI failure at xe_gt_debugfs_simple_show+0x82/0xc0 [xe]
(target: xe_gt_sriov_pf_monitor_print_events+0x0/0x130 [xe]; expected
type: 0xd72c7139)

Fix xe_gt_sriov_pf_monitor_print_events() function by updating to return
an int type.

Fixes: 1c99d3d3edab ("drm/xe/pf: Expose PF monitor details via debugfs")
Signed-off-by: Mohanram Meenakshisundaram <mohanram.meenakshisundaram@intel.com>
Reviewed-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Link: https://patch.msgid.link/20260514174918.1556357-2-mohanram.meenakshisundaram@intel.com
(cherry picked from commit ff1d386a8359746d9699ac30336e3b0684c68958)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt_sriov_pf_monitor.c | 6 +++++-
 drivers/gpu/drm/xe/xe_gt_sriov_pf_monitor.h | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_monitor.c b/drivers/gpu/drm/xe/xe_gt_sriov_pf_monitor.c
index 7d532bded02a8..a85ba44353789 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_monitor.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_monitor.c
@@ -114,8 +114,10 @@ int xe_gt_sriov_pf_monitor_process_guc2pf(struct xe_gt *gt, const u32 *msg, u32
  * VFs with no events are not printed.
  *
  * This function can only be called on PF.
+ *
+ * Return: always 0
  */
-void xe_gt_sriov_pf_monitor_print_events(struct xe_gt *gt, struct drm_printer *p)
+int xe_gt_sriov_pf_monitor_print_events(struct xe_gt *gt, struct drm_printer *p)
 {
 	unsigned int n, total_vfs = xe_gt_sriov_pf_get_totalvfs(gt);
 	const struct xe_gt_sriov_monitor *data;
@@ -144,4 +146,6 @@ void xe_gt_sriov_pf_monitor_print_events(struct xe_gt *gt, struct drm_printer *p
 #undef __format
 #undef __value
 	}
+
+	return 0;
 }
diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_monitor.h b/drivers/gpu/drm/xe/xe_gt_sriov_pf_monitor.h
index 7ca9351a271b7..0b8f088d3a16a 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_monitor.h
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_monitor.h
@@ -13,7 +13,7 @@ struct drm_printer;
 struct xe_gt;
 
 void xe_gt_sriov_pf_monitor_flr(struct xe_gt *gt, u32 vfid);
-void xe_gt_sriov_pf_monitor_print_events(struct xe_gt *gt, struct drm_printer *p);
+int xe_gt_sriov_pf_monitor_print_events(struct xe_gt *gt, struct drm_printer *p);
 
 #ifdef CONFIG_PCI_IOV
 int xe_gt_sriov_pf_monitor_process_guc2pf(struct xe_gt *gt, const u32 *msg, u32 len);
-- 
2.53.0




