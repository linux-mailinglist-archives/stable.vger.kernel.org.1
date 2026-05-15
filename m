Return-Path: <stable+bounces-247586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cATiCKLdBmp4ogIAu9opvQ
	(envelope-from <stable+bounces-247586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:47:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDFA54BABE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9012302726D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B8B40DFD4;
	Fri, 15 May 2026 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mZaWlDjA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FFB40DFC5
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834359; cv=none; b=bMhv+hUYLKmD8n9kdu75AYXxn2kvx+GtKlemsu95lY3JnTf7kILSWYqVDop043m92ilUwmD5n3uxCIux7kt9MlB/3smGeuUUW9qL/Gb9SFoJQR5J4XalPFKknI+B9fr3SPCWFy6FcueWVorYOT/eB8oxCOTl042z+rutvQCA8Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834359; c=relaxed/simple;
	bh=V6cOIPlqq1YjJsCYyuHjob6ZHpLsuXWGmu+vvgfvWps=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i/Nxjq659wczIvMsP0smGkSe2xiQzscQs5YDCfNDVrUdXKK1PieYhAP+KPxP/F5lnMuxizdmVrmBURoZwhTMLZ2bGgoRaErqm+QaDcxLgnWL7vhWi/WlvUabHiKvlnZ83HkD8cqWt98x2D0c55dGM2Xss9vaIuCHdCByBmToRAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mZaWlDjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA523C2BCB0;
	Fri, 15 May 2026 08:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778834359;
	bh=V6cOIPlqq1YjJsCYyuHjob6ZHpLsuXWGmu+vvgfvWps=;
	h=Subject:To:Cc:From:Date:From;
	b=mZaWlDjA2idS9Xee/mnlkhY3yKZIseVFCM8nmpD1sixy7++qwFe4C4amkwRRInpdz
	 OnfKCOew9GsokgKuFsVmAXrfNZJ72cGjUXnmwnq42eIbwwcRqzH/TaWWap+tqd6xn6
	 vkpaDRl/5/H5ZhVz811HasVK9FMYzGUMY4O68LY0=
Subject: FAILED: patch "[PATCH] drm/xe/uapi: Reject coh_none PAT index for CPU_ADDR_MIRROR" failed to apply to 6.18-stable tree
To: jia.yao@intel.com,alwin.mathew@intel.com,matthew.auld@intel.com,matthew.brost@intel.com,michal.mrozek@intel.com,rodrigo.vivi@intel.com,shuicheng.lin@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:39:15 +0200
Message-ID: <2026051515-treble-unwieldy-f489@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1BDFA54BABE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247586-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim,msgid.link:url,intel.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 662f9ddc8077792129440d05cbef2f944a07777a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051515-treble-unwieldy-f489@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 662f9ddc8077792129440d05cbef2f944a07777a Mon Sep 17 00:00:00 2001
From: Jia Yao <jia.yao@intel.com>
Date: Fri, 17 Apr 2026 05:59:17 +0000
Subject: [PATCH] drm/xe/uapi: Reject coh_none PAT index for CPU_ADDR_MIRROR

Add validation in xe_vm_bind_ioctl() to reject PAT indices
with XE_COH_NONE coherency mode when used with
DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR.

CPU address mirror mappings use system memory that is CPU
cached, which makes them incompatible with COH_NONE PAT
indices. Allowing COH_NONE with CPU cached buffers is a
security risk, as the GPU may bypass CPU caches and read
stale sensitive data from DRAM.

Although CPU_ADDR_MIRROR does not create an immediate
mapping, the backing system memory is still CPU cached.
Apply the same PAT coherency restrictions as
DRM_XE_VM_BIND_OP_MAP_USERPTR.

v2:
- Correct fix tag

v6:
- No change

v7:
- Correct fix tag

v8:
- Rebase

v9:
- Limit the restrictions to iGPU

v10:
- Just add the iGPU logic but keep dGPU logic

Fixes: b43e864af0d4 ("drm/xe/uapi: Add DRM_XE_VM_BIND_FLAG_CPU_ADDR_MIRROR")
Cc: <stable@vger.kernel.org> # v6.15+
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Mathew Alwin <alwin.mathew@intel.com>
Cc: Michal Mrozek <michal.mrozek@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Jia Yao <jia.yao@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Acked-by: Michal Mrozek <michal.mrozek@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260417055917.2027459-3-jia.yao@intel.com
(cherry picked from commit 4d58d7535e826a3175527b6174502f0db319d7f6)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 1720205c09ca..a717a2b8dea3 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3658,6 +3658,8 @@ static int vm_bind_ioctl_check_args(struct xe_device *xe, struct xe_vm *vm,
 				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
 		    XE_IOCTL_DBG(xe, coh_mode == XE_COH_NONE &&
 				 op == DRM_XE_VM_BIND_OP_MAP_USERPTR) ||
+		    XE_IOCTL_DBG(xe, !IS_DGFX(xe) && coh_mode == XE_COH_NONE &&
+				 is_cpu_addr_mirror) ||
 		    XE_IOCTL_DBG(xe, xe_device_is_l2_flush_optimized(xe) &&
 				 (op == DRM_XE_VM_BIND_OP_MAP_USERPTR ||
 				  is_cpu_addr_mirror) &&


