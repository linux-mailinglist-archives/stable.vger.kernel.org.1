Return-Path: <stable+bounces-233652-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLFuIzsg1Wnr0wcAu9opvQ
	(envelope-from <stable+bounces-233652-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:18:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FA83B0CCF
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2643302350C
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 15:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDC5349AE0;
	Tue,  7 Apr 2026 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iMxxK/ya"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9435933E34B
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574856; cv=none; b=rkaoSuYLT/ZMWoRL7ThV5gzvs04bOCfp3FcKPtEPORCGztoOw/tEYgIgfLBSu9AzbOAhcJA6XNrFK4tFuyyM8dgKRNLfLNm/iBk4Bb2jagqNbcl07GfCCvrONSQ77LJLwlk6GmYMK4e5yM7GaDp/PGTcB0zveNXK4PF+swG+sGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574856; c=relaxed/simple;
	bh=5PCEnb3JST3N3Hz4/M8J4Fb6ZlLhstMzjNuK8o+6bHU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oKuQflODd8xyefhQeVMJIdAVGgmVLebxj32bJPJg27CD2MAq8NBPLAPsHLc7QJ2LA1w7VlmJWlihpnHq7yPTESFN3IinhlaCJUakHD288Ew4JKYRL6FqrpNc48x+3gV2iOahu7omLDw//wdOuSXl9/HQTdlPq7EQVTxeyx+ULko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iMxxK/ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57E5C116C6;
	Tue,  7 Apr 2026 15:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775574856;
	bh=5PCEnb3JST3N3Hz4/M8J4Fb6ZlLhstMzjNuK8o+6bHU=;
	h=Subject:To:Cc:From:Date:From;
	b=iMxxK/yabYUImerc5Ib9Wh1Ff1NA7WAcUzprYQy94bTd0FrGDyutz4I6Tz+rEUBKa
	 04VUIqY07/wcjW3unj7YOe08a1ZjmcgHTUw+wG8zLr7ZEKpOVh3g/COgkKmM8olL6v
	 oTMQ8Cs9dkt16uTPuAgf1vqUagXeZ97BxqGPzEEU=
Subject: FAILED: patch "[PATCH] drm/xe: Disable garbage collector work item on SVM close" failed to apply to 6.19-stable tree
To: matthew.brost@intel.com,rodrigo.vivi@intel.com,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 07 Apr 2026 17:14:13 +0200
Message-ID: <2026040713-buckwheat-spyglass-4710@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233652-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: D9FA83B0CCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.19.y
git checkout FETCH_HEAD
git cherry-pick -x bce7cd6db2386e7a2b49ad3c09df0beabddfa3c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026040713-buckwheat-spyglass-4710@gregkh' --subject-prefix 'PATCH 6.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bce7cd6db2386e7a2b49ad3c09df0beabddfa3c4 Mon Sep 17 00:00:00 2001
From: Matthew Brost <matthew.brost@intel.com>
Date: Thu, 26 Feb 2026 17:52:25 -0800
Subject: [PATCH] drm/xe: Disable garbage collector work item on SVM close
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When an SVM is closed, the garbage collector work item must be stopped
synchronously and any future queuing must be prevented. Replace
flush_work() with disable_work_sync() to ensure both conditions are
met.

Fixes: 63f6e480d115 ("drm/xe: Add SVM garbage collector")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://patch.msgid.link/20260227015225.3081787-1-matthew.brost@intel.com
(cherry picked from commit 2247feb9badca5a4774df9a437bfc44fba4f22de)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index ca67d0bdbfac..c6b92d4ea6f4 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -903,7 +903,7 @@ int xe_svm_init(struct xe_vm *vm)
 void xe_svm_close(struct xe_vm *vm)
 {
 	xe_assert(vm->xe, xe_vm_is_closed(vm));
-	flush_work(&vm->svm.garbage_collector.work);
+	disable_work_sync(&vm->svm.garbage_collector.work);
 	xe_svm_put_pagemaps(vm);
 	drm_pagemap_release_owner(&vm->svm.peer);
 }


