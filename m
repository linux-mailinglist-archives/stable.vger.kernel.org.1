Return-Path: <stable+bounces-183224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B873BB6FF8
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 15:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC94C4A0958
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 13:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC2E1862;
	Fri,  3 Oct 2025 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PgdYE2f6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8A1175BF
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759497402; cv=none; b=sCBVVhsG1b+oGJHKPBZUa1bIbN0W+Iue79n01ORNbq789uC0wLWdfOphgH26jOnumKTqR+unDph5bcWx0FSKVwUZDJTODWKGHFN6hmcHFzb6CNtkdk4XXS706xEUW1KfJl/U+GpAOcn57FDuZJOXoalx3hfVFP4udrP69HZ7QWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759497402; c=relaxed/simple;
	bh=aDxvkn4ec0Mx/651XvZ8TWT4yrxNlOVZ8mZqzrX6JnI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=abCH2rZWmIygwMf6sMB8a+Rn/cWJyW15Z9QUW6FEDsu1hYOuA5QrfoRHr1VFV/kAEAHmJLwTGdfxoJSBeKbIbvqHbITth1XN0/AqZrklIv9i4CwhLtNie/saDDVRSxOZ67QVmRAi7/+x6aV7f1HsKGi9kRLHZnOcqDFJh96mKSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PgdYE2f6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE9CC4CEF5;
	Fri,  3 Oct 2025 13:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759497401;
	bh=aDxvkn4ec0Mx/651XvZ8TWT4yrxNlOVZ8mZqzrX6JnI=;
	h=Subject:To:Cc:From:Date:From;
	b=PgdYE2f6rIIbMAmxe0Kxpss+LmWFqOLAdkdH4QFrkRMOoIRSJHpMZ3XLPFqq0pPnJ
	 e2F7t3qirqKMFhoQz5hGMxH4to2DWKu3gM9U6yKT7kRylwlOW5yycnqaY2CMXe7Wr8
	 3AbnZP6hmEhUs49ngNU1nl/Ee2AvCrWnK8yLEcgY=
Subject: FAILED: patch "[PATCH] drm/xe/vm: Clear the scratch_pt pointer on error" failed to apply to 6.12-stable tree
To: thomas.hellstrom@linux.intel.com,brian.welty@intel.com,lucas.demarchi@intel.com,matthew.brost@intel.com,rodrigo.vivi@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 03 Oct 2025 15:16:28 +0200
Message-ID: <2025100328-armchair-going-304b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 358ee50ab565f3c8ea32480e9d03127a81ba32f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025100328-armchair-going-304b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 358ee50ab565f3c8ea32480e9d03127a81ba32f8 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Date: Thu, 21 Aug 2025 16:30:45 +0200
Subject: [PATCH] drm/xe/vm: Clear the scratch_pt pointer on error
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Avoid triggering a dereference of an error pointer on cleanup in
xe_vm_free_scratch() by clearing any scratch_pt error pointer.

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Fixes: 06951c2ee72d ("drm/xe: Use NULL PTEs as scratch PTEs")
Cc: Brian Welty <brian.welty@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://lore.kernel.org/r/20250821143045.106005-4-thomas.hellstrom@linux.intel.com

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index c86337e08a55..d3f6dc6b1779 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1635,8 +1635,12 @@ static int xe_vm_create_scratch(struct xe_device *xe, struct xe_tile *tile,
 
 	for (i = MAX_HUGEPTE_LEVEL; i < vm->pt_root[id]->level; i++) {
 		vm->scratch_pt[id][i] = xe_pt_create(vm, tile, i);
-		if (IS_ERR(vm->scratch_pt[id][i]))
-			return PTR_ERR(vm->scratch_pt[id][i]);
+		if (IS_ERR(vm->scratch_pt[id][i])) {
+			int err = PTR_ERR(vm->scratch_pt[id][i]);
+
+			vm->scratch_pt[id][i] = NULL;
+			return err;
+		}
 
 		xe_pt_populate_empty(tile, vm, vm->scratch_pt[id][i]);
 	}


