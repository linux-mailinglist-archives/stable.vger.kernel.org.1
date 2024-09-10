Return-Path: <stable+bounces-75373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EAA973436
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7331F25D3D
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3DB194081;
	Tue, 10 Sep 2024 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oYzEwkak"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE2B17C220;
	Tue, 10 Sep 2024 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964543; cv=none; b=s3gVKZQj1cGfRqopAPL6hwn42el1KyBwNN8CwoPyiuWOXQ0BTo6UcrT2NncK29heh8y0LSNwNtlfmw7JMwZ80znVahtYygpU6k3fLQmnrk+9YOUAnrW+qHvFrAwnYPR2gWCKTRnHcgxpZLz8iff7iTPfmuVGjdnWuX0H4uoQ02E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964543; c=relaxed/simple;
	bh=iNU2p4Rtp5up/10tJzC5r+uV3Cxm8I8QaELkh58UmR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fm7h7pBBbG7gtyvHQVVlZuU2F3XaaPGoICq4zmer5oi+tlokUsxHAGEcDHerYcRaRRqt5VES21rW3elMUy+THwmI41fphg2BQ+AUx0lbIVC06ydt8ONHT3MQ6PoTiIBgT1nFmH5kopI9JNO0sMIke6clCtCccb58Iip652vYkL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oYzEwkak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0548FC4CEC3;
	Tue, 10 Sep 2024 10:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964543;
	bh=iNU2p4Rtp5up/10tJzC5r+uV3Cxm8I8QaELkh58UmR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYzEwkakd8kH0vYI82MOXYLJhtIvTuZakhDF33UzFSJzX+pGhjzGTWq4zp9RuaOni
	 rxaPRd/6T6sCpJhRs2RkcIICoh/sHnWmWTMDlXkorDlVFVlJCSPU373YTwmybqFMC9
	 3u3tjFK52jXA4HZ9wm6Xowt6ACkUE6BWc06CBEjY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	George Kennedy <george.kennedy@oracle.com>,
	David Fernandez Gonzalez <david.fernandez.gonzalez@oracle.com>
Subject: [PATCH 6.6 219/269] VMCI: Fix use-after-free when removing resource in vmci_resource_remove()
Date: Tue, 10 Sep 2024 11:33:26 +0200
Message-ID: <20240910092615.778982823@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Fernandez Gonzalez <david.fernandez.gonzalez@oracle.com>

commit 48b9a8dabcc3cf5f961b2ebcd8933bf9204babb7 upstream.

When removing a resource from vmci_resource_table in
vmci_resource_remove(), the search is performed using the resource
handle by comparing context and resource fields.

It is possible though to create two resources with different types
but same handle (same context and resource fields).

When trying to remove one of the resources, vmci_resource_remove()
may not remove the intended one, but the object will still be freed
as in the case of the datagram type in vmci_datagram_destroy_handle().
vmci_resource_table will still hold a pointer to this freed resource
leading to a use-after-free vulnerability.

BUG: KASAN: use-after-free in vmci_handle_is_equal include/linux/vmw_vmci_defs.h:142 [inline]
BUG: KASAN: use-after-free in vmci_resource_remove+0x3a1/0x410 drivers/misc/vmw_vmci/vmci_resource.c:147
Read of size 4 at addr ffff88801c16d800 by task syz-executor197/1592
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x82/0xa9 lib/dump_stack.c:106
 print_address_description.constprop.0+0x21/0x366 mm/kasan/report.c:239
 __kasan_report.cold+0x7f/0x132 mm/kasan/report.c:425
 kasan_report+0x38/0x51 mm/kasan/report.c:442
 vmci_handle_is_equal include/linux/vmw_vmci_defs.h:142 [inline]
 vmci_resource_remove+0x3a1/0x410 drivers/misc/vmw_vmci/vmci_resource.c:147
 vmci_qp_broker_detach+0x89a/0x11b9 drivers/misc/vmw_vmci/vmci_queue_pair.c:2182
 ctx_free_ctx+0x473/0xbe1 drivers/misc/vmw_vmci/vmci_context.c:444
 kref_put include/linux/kref.h:65 [inline]
 vmci_ctx_put drivers/misc/vmw_vmci/vmci_context.c:497 [inline]
 vmci_ctx_destroy+0x170/0x1d6 drivers/misc/vmw_vmci/vmci_context.c:195
 vmci_host_close+0x125/0x1ac drivers/misc/vmw_vmci/vmci_host.c:143
 __fput+0x261/0xa34 fs/file_table.c:282
 task_work_run+0xf0/0x194 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x184/0x189 kernel/entry/common.c:187
 exit_to_user_mode_prepare+0x11b/0x123 kernel/entry/common.c:220
 __syscall_exit_to_user_mode_work kernel/entry/common.c:302 [inline]
 syscall_exit_to_user_mode+0x18/0x42 kernel/entry/common.c:313
 do_syscall_64+0x41/0x85 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x6e/0x0

This change ensures the type is also checked when removing
the resource from vmci_resource_table in vmci_resource_remove().

Fixes: bc63dedb7d46 ("VMCI: resource object implementation.")
Cc: stable@vger.kernel.org
Reported-by: George Kennedy <george.kennedy@oracle.com>
Signed-off-by: David Fernandez Gonzalez <david.fernandez.gonzalez@oracle.com>
Link: https://lore.kernel.org/r/20240828154338.754746-1-david.fernandez.gonzalez@oracle.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/vmw_vmci/vmci_resource.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/misc/vmw_vmci/vmci_resource.c
+++ b/drivers/misc/vmw_vmci/vmci_resource.c
@@ -144,7 +144,8 @@ void vmci_resource_remove(struct vmci_re
 	spin_lock(&vmci_resource_table.lock);
 
 	hlist_for_each_entry(r, &vmci_resource_table.entries[idx], node) {
-		if (vmci_handle_is_equal(r->handle, resource->handle)) {
+		if (vmci_handle_is_equal(r->handle, resource->handle) &&
+		    resource->type == r->type) {
 			hlist_del_init_rcu(&r->node);
 			break;
 		}



