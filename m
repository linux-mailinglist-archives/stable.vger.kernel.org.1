Return-Path: <stable+bounces-174626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C93B3641C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996BA1B6792C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9572B30AAD2;
	Tue, 26 Aug 2025 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iIbN5iTI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514A627EFE7;
	Tue, 26 Aug 2025 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214888; cv=none; b=CVVX9dXB847t8Y+J4YpzTDO4gfEwmLD5b6ovaEef6eRdJyj1AfFprOisrRJ0oJoguQy9x4v1VfKv7aCL7WXiqLR0vvDXNQj36A4zsfj2zHuzR6/zzUgmf1bJAb1/tHJbinhjaMYSxzLKSV33TNN+QHaD1sTodV7F5YrXmUFIA7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214888; c=relaxed/simple;
	bh=ovQA87G3Xf2DZWl5Bc4QNSyom5C/fbUDnr0a45TH0wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utUladFIEsjoCGuN5UeLcwgU5OzNIx6mICQuJjRQ1aga/JTFNB7ttCVKy6AEjG2f7FixtIwqn78U1YtcJVz54nyrABNy1Zyiz80B/OE3lmaVnEVdJlp6q4izUXc8e6lbpWSho7tnkhU/EDJ/ozfFic/550wuXGH3XOJrFJ/5H2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iIbN5iTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AC9C4CEF1;
	Tue, 26 Aug 2025 13:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214888;
	bh=ovQA87G3Xf2DZWl5Bc4QNSyom5C/fbUDnr0a45TH0wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iIbN5iTInNrDAGsjyMW/ju4I40kWPBpEoywgOaRpUwT2OSXOKvzyFVvHx/YIa9xht
	 f9RuU8pJqcZQ6GxVOV1YA4j7qGcDO2hFxhgdcan2ff1SCEvHGBxtNxHKRxC1mOq7qB
	 GpSgoids0I6SnFOHjw7Wnrsukk9I380iREtgdwPY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 6.1 307/482] PCI: endpoint: Fix configfs group list head handling
Date: Tue, 26 Aug 2025 13:09:20 +0200
Message-ID: <20250826110938.384528353@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

commit d79123d79a8154b4318529b7b2ff7e15806f480b upstream.

Doing a list_del() on the epf_group field of struct pci_epf_driver in
pci_epf_remove_cfs() is not correct as this field is a list head, not
a list entry. This list_del() call triggers a KASAN warning when an
endpoint function driver which has a configfs attribute group is torn
down:

==================================================================
BUG: KASAN: slab-use-after-free in pci_epf_remove_cfs+0x17c/0x198
Write of size 8 at addr ffff00010f4a0d80 by task rmmod/319

CPU: 3 UID: 0 PID: 319 Comm: rmmod Not tainted 6.16.0-rc2 #1 NONE
Hardware name: Radxa ROCK 5B (DT)
Call trace:
show_stack+0x2c/0x84 (C)
dump_stack_lvl+0x70/0x98
print_report+0x17c/0x538
kasan_report+0xb8/0x190
__asan_report_store8_noabort+0x20/0x2c
pci_epf_remove_cfs+0x17c/0x198
pci_epf_unregister_driver+0x18/0x30
nvmet_pci_epf_cleanup_module+0x24/0x30 [nvmet_pci_epf]
__arm64_sys_delete_module+0x264/0x424
invoke_syscall+0x70/0x260
el0_svc_common.constprop.0+0xac/0x230
do_el0_svc+0x40/0x58
el0_svc+0x48/0xdc
el0t_64_sync_handler+0x10c/0x138
el0t_64_sync+0x198/0x19c
...

Remove this incorrect list_del() call from pci_epf_remove_cfs().

Fixes: ef1433f717a2 ("PCI: endpoint: Create configfs entry for each pci_epf_device_id table entry")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250624114544.342159-2-dlemoal@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/endpoint/pci-epf-core.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -343,7 +343,6 @@ static void pci_epf_remove_cfs(struct pc
 	mutex_lock(&pci_epf_mutex);
 	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry)
 		pci_ep_cfs_remove_epf_group(group);
-	list_del(&driver->epf_group);
 	mutex_unlock(&pci_epf_mutex);
 }
 



