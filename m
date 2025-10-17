Return-Path: <stable+bounces-187278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85845BEAA1C
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1977C1AAE
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F5633509B;
	Fri, 17 Oct 2025 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rrQfxNsu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6149335061;
	Fri, 17 Oct 2025 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715623; cv=none; b=Hi9WBcdax05R7vRusM7rzwx4PzB3nYq9u/BzZB+ZQYXD95C1jyTPCl1pIS/kIwicJ6HiS9VyxgIUfsRBFcJR3btgZO0WhkIO1I4RSyy8bzCkcULAixESwcnfi12mnXhbIZRGHhqfqr6Lt/zxupocBpl/zpRbop4cBcZcA84eT6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715623; c=relaxed/simple;
	bh=Pv+Da9YlvCc71D+4NT5wh/BTxZDxWAucRHfImH0lCfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcR905uOyedDONg66abkbwpKEi5AMjerA9WQggmphVICDb8tHzazevEOC4XaT2OCdlVedMNgns+4yitttgtQ78Tf02oZb9AvoKeMeZke5t+v89MfKQgCltQhndVTS41Z1YnZBVEbhvZpfA802Zx6cWK6SFD6GmdFBelsjRZha1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rrQfxNsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F4DC4CEE7;
	Fri, 17 Oct 2025 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715623;
	bh=Pv+Da9YlvCc71D+4NT5wh/BTxZDxWAucRHfImH0lCfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rrQfxNsuIhEGL7MBRblXVf4U2z+xj51/fzDsP0sCHAAVy1OJdBpZOWPQg5yDEB1i0
	 2wTErF+gIYCurKNNLnl6o+a5+uZA6CEhxHJgZ2tiPfriWQO443Cnc1Zgk9tMRaMDw4
	 Z/aJ4N5I53lAlbatc25KVp7zGN5X7MC8vF0fPx2Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	D Scott Phillips <scott@os.amperecomputing.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 6.17 281/371] PCI: Fix failure detection during resource resize
Date: Fri, 17 Oct 2025 16:54:16 +0200
Message-ID: <20251017145212.241989052@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

commit 31af09b3eaf3603870ce9fd5a7b6c8693129c4cf upstream.

Since 96336ec70264 ("PCI: Perform reset_resource() and build fail list in
sync") the failed list is always built and returned to let the caller
decide what to do with the failures. The caller may want to retry resource
fitting and assignment and before that can happen, the resources should be
restored to their original state (a reset effectively clears the struct
resource), which requires returning them to the failed list so the original
state remains stored in the associated struct pci_dev_resource.

Resource resizing is different from the ordinary resource fitting and
assignment in that it only considers part of the resources. This means
failures for other resource types are not relevant at all and should be
ignored. As resize doesn't unassign such unrelated resources, those
resources ending up in the failed list implies assignment of that
resource must have failed before resize too. The check in
pci_reassign_bridge_resources() to decide if the whole assignment is
successful, however, is based on list emptiness which will cause false
negatives when the failed list has resources with an unrelated type.

If the failed list is not empty, call pci_required_resource_failed() and
extend it to be able to filter on specific resource types too (if
provided).

Calling pci_required_resource_failed() at this point is slightly
problematic because the resource itself is reset when the failed list
is constructed in __assign_resources_sorted(). As a result,
pci_resource_is_optional() does not have access to the original
resource flags. This could be worked around by restoring and
re-resetting the resource around the call to pci_resource_is_optional(),
however, it shouldn't cause issue as resource resizing is meant for
64-bit prefetchable resources according to Christian König (see the
Link which unfortunately doesn't point directly to Christian's reply
because lore didn't store that email at all).

Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list in sync")
Link: https://lore.kernel.org/all/c5d1b5d8-8669-5572-75a7-0b480f581ac1@linux.intel.com/
Reported-by: D Scott Phillips <scott@os.amperecomputing.com>
Closes: https://lore.kernel.org/all/86plf0lgit.fsf@scott-ph-mail.amperecomputing.com/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: D Scott Phillips <scott@os.amperecomputing.com>
Reviewed-by: D Scott Phillips <scott@os.amperecomputing.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: stable@vger.kernel.org	# v6.15+
Link: https://patch.msgid.link/20250822123359.16305-4-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/setup-bus.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -28,6 +28,10 @@
 #include <linux/acpi.h>
 #include "pci.h"
 
+#define PCI_RES_TYPE_MASK \
+	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
+	 IORESOURCE_MEM_64)
+
 unsigned int pci_flags;
 EXPORT_SYMBOL_GPL(pci_flags);
 
@@ -384,13 +388,19 @@ static bool pci_need_to_release(unsigned
 }
 
 /* Return: @true if assignment of a required resource failed. */
-static bool pci_required_resource_failed(struct list_head *fail_head)
+static bool pci_required_resource_failed(struct list_head *fail_head,
+					 unsigned long type)
 {
 	struct pci_dev_resource *fail_res;
 
+	type &= PCI_RES_TYPE_MASK;
+
 	list_for_each_entry(fail_res, fail_head, list) {
 		int idx = pci_resource_num(fail_res->dev, fail_res->res);
 
+		if (type && (fail_res->flags & PCI_RES_TYPE_MASK) != type)
+			continue;
+
 		if (!pci_resource_is_optional(fail_res->dev, idx))
 			return true;
 	}
@@ -504,7 +514,7 @@ assign:
 	}
 
 	/* Without realloc_head and only optional fails, nothing more to do. */
-	if (!pci_required_resource_failed(&local_fail_head) &&
+	if (!pci_required_resource_failed(&local_fail_head, 0) &&
 	    list_empty(realloc_head)) {
 		list_for_each_entry(save_res, &save_head, list) {
 			struct resource *res = save_res->res;
@@ -1707,10 +1717,6 @@ static void __pci_bridge_assign_resource
 	}
 }
 
-#define PCI_RES_TYPE_MASK \
-	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
-	 IORESOURCE_MEM_64)
-
 static void pci_bridge_release_resources(struct pci_bus *bus,
 					 unsigned long type)
 {
@@ -2449,8 +2455,12 @@ int pci_reassign_bridge_resources(struct
 		free_list(&added);
 
 	if (!list_empty(&failed)) {
-		ret = -ENOSPC;
-		goto cleanup;
+		if (pci_required_resource_failed(&failed, type)) {
+			ret = -ENOSPC;
+			goto cleanup;
+		}
+		/* Only resources with unrelated types failed (again) */
+		free_list(&failed);
 	}
 
 	list_for_each_entry(dev_res, &saved, list) {



