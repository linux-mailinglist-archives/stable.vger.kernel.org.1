Return-Path: <stable+bounces-183223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40067BB6FD9
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 15:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824FD4A0451
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 13:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0B812DDA1;
	Fri,  3 Oct 2025 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vyp0xYmf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E301862
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759497398; cv=none; b=SKMUZcob1LJFlwoZQZcySmgg3ziy8/YPx0sKcAWtuMDneJqRWIDWTuxiugXRlS0s4IQESV0gS/RYC/yfz02rLVRhBzcfBE/BXlzgfO0ZrhOtDw5iejCPC+TsjGvEOZxlstb6gf1EgZStMnGkmP86DBDiQh6NAZ95hTD/JKLScmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759497398; c=relaxed/simple;
	bh=dtkh2nuGHBGMBEh/y9yZyhceruWbLoSaV9ir/ZueGZM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bkauk8W0y6DzyzNo8VI0FxbVs59wgR39ifjSloWciBkWfPm5ewntnetkSbl9MQkTkAxs0lxBmu4r6+KeF8M7uofBSeYvrobuGz364vwLZCxJpEjblzQLgpU0/hMLs2idoSRvJHA857ji36vIPqVl7RbuQup/bBL0vyRw8JABmNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vyp0xYmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FBBC4CEF5;
	Fri,  3 Oct 2025 13:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759497398;
	bh=dtkh2nuGHBGMBEh/y9yZyhceruWbLoSaV9ir/ZueGZM=;
	h=Subject:To:Cc:From:Date:From;
	b=Vyp0xYmfYl6dPCiLqpI2u3VdTX2t3wE8VLcKZb5q4HOnqUHUuy8ix0S4mLPbLs8sE
	 cP3rvvfS3kB0427e0nkipNq+QcYMoN1IBwSMqKwYgXQ+nO+HupBgEFB6aayRAvTKOM
	 D28J3CknF9JViCwKH+Jm5onBAI92DUycFb1alDw4=
Subject: FAILED: patch "[PATCH] drm/xe/vm: Clear the scratch_pt pointer on error" failed to apply to 6.16-stable tree
To: thomas.hellstrom@linux.intel.com,brian.welty@intel.com,lucas.demarchi@intel.com,matthew.brost@intel.com,rodrigo.vivi@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 03 Oct 2025 15:16:27 +0200
Message-ID: <2025100327-kindly-attic-f695@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x 358ee50ab565f3c8ea32480e9d03127a81ba32f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025100327-kindly-attic-f695@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

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


