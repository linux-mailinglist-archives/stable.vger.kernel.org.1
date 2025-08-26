Return-Path: <stable+bounces-176271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AEEB36BF2
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909C2582FD8
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9D835E4DA;
	Tue, 26 Aug 2025 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YLa6oWDD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56185356905;
	Tue, 26 Aug 2025 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219222; cv=none; b=NvTFKniN3Y4p65wJ3ley3f+6LM2Qlpgzs4pZCixMa0ogWHcuUOchwfEsyf4o/+S5m4qeUNbxjoOCf+JQw2Bb1TQmlJbFCqJdF7HH9Q/B+1Pmlw0Ix3KZrC6alfqNZs6MrYxx1g/S+L1pxr3zzs+cXGkjwmz63FmQCrmunCaxLoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219222; c=relaxed/simple;
	bh=ljBbVJZejX0OpxfpdbnWpOCf/rB8S9q0me8CUMNAxns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBPELKUTUIHOIscXuugAPtl9+Cew/Jawjlbx4ErJ3e62cVvZ+zAI4ipENQRVMKFvTxEZhyWqCTP1Q6s2MQYDy47UruTUiDbCSG080hGxEnLukU+aIbF3GveXaRf2/ZGC85IhF+Ktoooxtdy6dOovIercfhG8HlAD1XPYKPIglK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YLa6oWDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3705C4CEF1;
	Tue, 26 Aug 2025 14:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756219222;
	bh=ljBbVJZejX0OpxfpdbnWpOCf/rB8S9q0me8CUMNAxns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YLa6oWDDi4KL3KRxBVrSBxIwpio9HClbHx2kbG512+9e+GjqxA23sLiVHejilkYJE
	 R27YqxVqguGB0PbprF+1QGYKeQzqo2wJWu1CB2tS56uDodbY7LdbFQP/TfISZ07MhG
	 B9/ZH2cgFYMTNLURyl6oVOD9ofvgdt8QJjGv+LQ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 5.4 300/403] PCI: endpoint: Fix configfs group removal on driver teardown
Date: Tue, 26 Aug 2025 13:10:26 +0200
Message-ID: <20250826110915.100630924@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

commit 910bdb8197f9322790c738bb32feaa11dba26909 upstream.

An endpoint driver configfs attributes group is added to the
epf_group list of struct pci_epf_driver by pci_epf_add_cfs() but an
added group is not removed from this list when the attribute group is
unregistered with pci_ep_cfs_remove_epf_group().

Add the missing list_del() call in pci_ep_cfs_remove_epf_group()
to correctly remove the attribute group from the driver list.

With this change, once the loop over all attribute groups in
pci_epf_remove_cfs() completes, the driver epf_group list should be
empty. Add a WARN_ON() to make sure of that.

Fixes: ef1433f717a2 ("PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250624114544.342159-3-dlemoal@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/endpoint/pci-ep-cfs.c   |    1 +
 drivers/pci/endpoint/pci-epf-core.c |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -480,6 +480,7 @@ void pci_ep_cfs_remove_epf_group(struct
 	if (IS_ERR_OR_NULL(group))
 		return;
 
+	list_del(&group->group_entry);
 	configfs_unregister_default_group(group);
 }
 EXPORT_SYMBOL(pci_ep_cfs_remove_epf_group);
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -155,6 +155,7 @@ static void pci_epf_remove_cfs(struct pc
 	mutex_lock(&pci_epf_mutex);
 	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry)
 		pci_ep_cfs_remove_epf_group(group);
+	WARN_ON(!list_empty(&driver->epf_group));
 	mutex_unlock(&pci_epf_mutex);
 }
 



