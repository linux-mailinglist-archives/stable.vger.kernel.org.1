Return-Path: <stable+bounces-231311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFO6LrU6y2nmEwYAu9opvQ
	(envelope-from <stable+bounces-231311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 05:08:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B760E3639F5
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 05:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EBD030191B2
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 03:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26D31F30A9;
	Tue, 31 Mar 2026 03:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="bqbNZ25k"
X-Original-To: stable@vger.kernel.org
Received: from smtp134-33.sina.com.cn (smtp134-33.sina.com.cn [180.149.134.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B8188CC9
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 03:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774926446; cv=none; b=sLKhi/YSeH8d7r1flAiWPxPbStO5ANocogIM43tGCuPL0QueEtZmdUK0hfKaW9Eq5RvW41IX1HTNd3aLLVYhEPU676EbANXsVuq5gXTpY5doJ4PRThctnTSaFRwlel5lQxrnWoVZzYfD7PRqYKQQPgxxiHWCv2axf0TUvcNH0mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774926446; c=relaxed/simple;
	bh=zVD1ODOZ5ma95AWRiQkTgNVur1j4xCIgVj+SOxlI7AI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DmOYPx6LGlUdc3A8RaNx87umJ4P//HuYIsrNB5sKf8HS2IJiiK48KBBjzHz01TJmIBRThkJRNTQEtwH0kQTWT+qEmSIWdKbex4XzE4+FoxknsJcb6JMpwpvmGIcu9uQS8UjNArmF8a5jgUL2ccF1X/kvOTc3ROUnV66kjM5q4BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=bqbNZ25k; arc=none smtp.client-ip=180.149.134.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1774926439;
	bh=3sVFcfNlfARuQsbkufs1o7tCcDwibVQbTgHad3/m4bQ=;
	h=From:Subject:Date:Message-Id;
	b=bqbNZ25kD01nC6qYauMut8uesDIBuvsSNBelvfJiTDnQluyCoaZJMa83SLxDo1ntq
	 AkZ1DtYXPDd+vYoWrcn+eLb1uce3MXMStm0XwLLMJCmkOzDduub+k4e5T1wslytzsf
	 XgGpeBaWJUexx52dTYUauBCjLH6kmvlB+JTM2F58=
X-SMAIL-HELO: pek-lpg-core6.wrs.com
Received: from unknown (HELO pek-lpg-core6.wrs.com)([60.247.85.88])
	by sina.com (10.185.250.21) with ESMTP
	id 69CB391D00001F9E; Tue, 31 Mar 2026 11:01:51 +0800 (CST)
X-Sender: johnny_haocn@sina.com
X-Auth-ID: johnny_haocn@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=johnny_haocn@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=johnny_haocn@sina.com
X-SMAIL-MID: 6303583408437
X-SMAIL-UIID: C74F663AB5BB4A0BBAD4ADAF3C3124FE-20260331-110151-1
From: Johnny Hao <johnny_haocn@sina.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 5.15.y] fbcon: Set fb_display[i]->mode to NULL when the mode is released
Date: Tue, 31 Mar 2026 11:01:48 +0800
Message-Id: <20260331030148.2724286-1-johnny_haocn@sina.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231311-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,huawei.com,suse.de,gmx.de,sina.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sina.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnny_haocn@sina.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sina.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sina.com:dkim,sina.com:email,sina.com:mid,syz.xxx:url,suse.de:email,gmx.de:email]
X-Rspamd-Queue-Id: B760E3639F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Quanmin Yan <yanquanmin1@huawei.com>

[ Upstream commit a1f3058930745d2b938b6b4f5bd9630dc74b26b7 ]

Recently, we discovered the following issue through syzkaller:

BUG: KASAN: slab-use-after-free in fb_mode_is_equal+0x285/0x2f0
Read of size 4 at addr ff11000001b3c69c by task syz.xxx
...
Call Trace:
 <TASK>
 dump_stack_lvl+0xab/0xe0
 print_address_description.constprop.0+0x2c/0x390
 print_report+0xb9/0x280
 kasan_report+0xb8/0xf0
 fb_mode_is_equal+0x285/0x2f0
 fbcon_mode_deleted+0x129/0x180
 fb_set_var+0xe7f/0x11d0
 do_fb_ioctl+0x6a0/0x750
 fb_ioctl+0xe0/0x140
 __x64_sys_ioctl+0x193/0x210
 do_syscall_64+0x5f/0x9c0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Based on experimentation and analysis, during framebuffer unregistration,
only the memory of fb_info->modelist is freed, without setting the
corresponding fb_display[i]->mode to NULL for the freed modes. This leads
to UAF issues during subsequent accesses. Here's an example of reproduction
steps:
1. With /dev/fb0 already registered in the system, load a kernel module
   to register a new device /dev/fb1;
2. Set fb1's mode to the global fb_display[] array (via FBIOPUT_CON2FBMAP);
3. Switch console from fb to VGA (to allow normal rmmod of the ko);
4. Unload the kernel module, at this point fb1's modelist is freed, leaving
   a wild pointer in fb_display[];
5. Trigger the bug via system calls through fb0 attempting to delete a mode
   from fb0.

Add a check in do_unregister_framebuffer(): if the mode to be freed exists
in fb_display[], set the corresponding mode pointer to NULL.

Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org
[ The context change is due to the commit 2c0c19b681d5
("fbdev: fbmem: Fix double free of 'fb_info->pixmap.addr'") in v5.16
which is irrelevant to the logic of this patch. ]
Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
---
 drivers/video/fbdev/core/fbcon.c | 20 ++++++++++++++++++++
 drivers/video/fbdev/core/fbmem.c |  2 ++
 include/linux/fbcon.h            |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 8922595cc491..ede993b3fbd4 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2820,6 +2820,26 @@ int fbcon_mode_deleted(struct fb_info *info,
 	return found;
 }
 
+static void fbcon_delete_mode(struct fb_videomode *m)
+{
+	struct fbcon_display *p;
+	int i;
+
+	for (i = first_fb_vc; i <= last_fb_vc; i++) {
+		p = &fb_display[i];
+		if (p->mode == m)
+			p->mode = NULL;
+	}
+}
+
+void fbcon_delete_modelist(struct list_head *head)
+{
+	struct fb_modelist *modelist;
+
+	list_for_each_entry(modelist, head, list)
+		fbcon_delete_mode(&modelist->mode);
+}
+
 #ifdef CONFIG_VT_HW_CONSOLE_BINDING
 static void fbcon_unbind(void)
 {
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 3b52ddfe0350..03a7a7e2a670 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1750,6 +1750,8 @@ static void do_unregister_framebuffer(struct fb_info *fb_info)
 	if (fb_info->pixmap.addr &&
 	    (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
 		kfree(fb_info->pixmap.addr);
+
+	fbcon_delete_modelist(&fb_info->modelist);
 	fb_destroy_modelist(&fb_info->modelist);
 	registered_fb[fb_info->node] = NULL;
 	num_registered_fb--;
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
index 2382dec6d6ab..fb0fc2736b80 100644
--- a/include/linux/fbcon.h
+++ b/include/linux/fbcon.h
@@ -11,6 +11,7 @@ void fbcon_suspended(struct fb_info *info);
 void fbcon_resumed(struct fb_info *info);
 int fbcon_mode_deleted(struct fb_info *info,
 		       struct fb_videomode *mode);
+void fbcon_delete_modelist(struct list_head *head);
 void fbcon_new_modelist(struct fb_info *info);
 void fbcon_get_requirement(struct fb_info *info,
 			   struct fb_blit_caps *caps);
@@ -31,6 +32,7 @@ static inline void fbcon_suspended(struct fb_info *info) {}
 static inline void fbcon_resumed(struct fb_info *info) {}
 static inline int fbcon_mode_deleted(struct fb_info *info,
 				     struct fb_videomode *mode) { return 0; }
+static inline void fbcon_delete_modelist(struct list_head *head) {}
 static inline void fbcon_new_modelist(struct fb_info *info) {}
 static inline void fbcon_get_requirement(struct fb_info *info,
 					 struct fb_blit_caps *caps) {}
-- 
2.34.1


