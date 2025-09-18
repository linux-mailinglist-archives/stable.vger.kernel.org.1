Return-Path: <stable+bounces-178367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84765B47E61
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80350189FB80
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB12277C94;
	Sun,  7 Sep 2025 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IRUFzcBG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC90264A9C;
	Sun,  7 Sep 2025 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276610; cv=none; b=HiRJ9ACA8HT5Bfhq9pmVPrQ8i0pBlABX98Dj2QUfBBm1z8P2l6eptQOoIyWqx+SFNvEaMqFP7x0Dq1LfssjsP7Ip+XautU9SZGd4bMswswjK3fwAvtvtBd32LrG9fNnF+iV93y+Gd1kB3fwg1o/AT3exrDsaT1q77rXHv7uMW+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276610; c=relaxed/simple;
	bh=G7p5M6Lyg0ewZb5b5f5g7D1X/kNF4qsLqebQVuW+GP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekEuv4dRCpUfYXKl/khVDzUN/f3L4S6MdmZD5VO88VwhqloDFA6B5P1wk2agggoomt4mIBDjyYWx4+BQxMmuM+K+/AA40DI3zupDObQumM7WFYbO4We0xIf1SO2wjc12lVzzoDwKTqWmmtj8u9bTHD0ikoxZ3uMxtn66jci4cXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IRUFzcBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D6CC4CEF8;
	Sun,  7 Sep 2025 20:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757276610;
	bh=G7p5M6Lyg0ewZb5b5f5g7D1X/kNF4qsLqebQVuW+GP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IRUFzcBGbbZvffYRjlrhX+WsnVmcji3T4LlrLObc/+/nJaJ/+oougJ/pS1u2rdajs
	 8tLmZBjuLUQD8NS5PBVtA7nuXvTFLwqScZNwZswqmO4fqqLfKf9MSP+Ly3Qbr5ZJVT
	 apl3UuHvoDI06eJD/gdwgsymSVOL5176DZvvJw08=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wang Liang <wangliang74@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 047/121] net: atm: fix memory leak in atm_register_sysfs when device_register fail
Date: Sun,  7 Sep 2025 21:58:03 +0200
Message-ID: <20250907195611.031853957@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195609.817339617@linuxfoundation.org>
References: <20250907195609.817339617@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Liang <wangliang74@huawei.com>

[ Upstream commit 0a228624bcc00af41f281a2a84c928595a74c17d ]

When device_register() return error in atm_register_sysfs(), which can be
triggered by kzalloc fail in device_private_init() or other reasons,
kmemleak reports the following memory leaks:

unreferenced object 0xffff88810182fb80 (size 8):
  comm "insmod", pid 504, jiffies 4294852464
  hex dump (first 8 bytes):
    61 64 75 6d 6d 79 30 00                          adummy0.
  backtrace (crc 14dfadaf):
    __kmalloc_node_track_caller_noprof+0x335/0x450
    kvasprintf+0xb3/0x130
    kobject_set_name_vargs+0x45/0x120
    dev_set_name+0xa9/0xe0
    atm_register_sysfs+0xf3/0x220
    atm_dev_register+0x40b/0x780
    0xffffffffa000b089
    do_one_initcall+0x89/0x300
    do_init_module+0x27b/0x7d0
    load_module+0x54cd/0x5ff0
    init_module_from_file+0xe4/0x150
    idempotent_init_module+0x32c/0x610
    __x64_sys_finit_module+0xbd/0x120
    do_syscall_64+0xa8/0x270
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

When device_create_file() return error in atm_register_sysfs(), the same
issue also can be triggered.

Function put_device() should be called to release kobj->name memory and
other device resource, instead of kfree().

Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250901063537.1472221-1-wangliang74@huawei.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/atm/resources.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/atm/resources.c b/net/atm/resources.c
index b19d851e1f443..7c6fdedbcf4e5 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -112,7 +112,9 @@ struct atm_dev *atm_dev_register(const char *type, struct device *parent,
 
 	if (atm_proc_dev_register(dev) < 0) {
 		pr_err("atm_proc_dev_register failed for dev %s\n", type);
-		goto out_fail;
+		mutex_unlock(&atm_dev_mutex);
+		kfree(dev);
+		return NULL;
 	}
 
 	if (atm_register_sysfs(dev, parent) < 0) {
@@ -128,7 +130,7 @@ struct atm_dev *atm_dev_register(const char *type, struct device *parent,
 	return dev;
 
 out_fail:
-	kfree(dev);
+	put_device(&dev->class_dev);
 	dev = NULL;
 	goto out;
 }
-- 
2.50.1




