Return-Path: <stable+bounces-167953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFB8B232B3
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1631A6E357F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B342FDC4F;
	Tue, 12 Aug 2025 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yCACxOeb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17C521ABD0;
	Tue, 12 Aug 2025 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022548; cv=none; b=m+tuMo0Yq0AjJdDw6UAYYWLjiNnfRxurVUeQAaJgc5zS6yDgvhLRayBP9WNqNRJR3XjW1JzY/4JP2Q17T6+BGCKuvAXavtXVM7n7NiwOOuxD6mrc4UHrYPTyJUOzvWUtpeZcgahQVC/rxXPM7twNpNOBjkB0sIhsqQ4WmziM6Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022548; c=relaxed/simple;
	bh=k7+22cJT1d+heWGkFG8uxVh/I4jtztRzGu0Aw67A1E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpP6AEaLP7dt/0n462WSLorggwFRXNRyXjN83qjeHgyTuOqg4f4dXFdBHLdlnLAI+1aP15aQMAKuY52P0Tx2fgCtN0Au7cv/J77veIBw0L7iI4uhAERwJ1qX506dqsJ1Yc+kTaObJJ6E8jeJlSWoNuKSOt7D9k+eBM/76U6bj8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yCACxOeb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8E8C4CEF0;
	Tue, 12 Aug 2025 18:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755022548;
	bh=k7+22cJT1d+heWGkFG8uxVh/I4jtztRzGu0Aw67A1E0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yCACxOeb3tiC3nXfQVxuQf13IYSwTE5FPOswLum9RYnTIeJBbMaqzyTAVnyA4gTCP
	 qXRn4wBaHxdYLxpWBuShx7wVNypLYF6kXnmHh8chB9fy9KZwtlenWvoqZTEk2ILKdz
	 y1/zGnupO4E7t0zQZ+5SejQ2OcT/rZQu9UatVHTg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mengbiao Xiong <xisme1998@gmail.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 188/369] crypto: ccp - Fix crash when rebind ccp device for ccp.ko
Date: Tue, 12 Aug 2025 19:28:05 +0200
Message-ID: <20250812173021.843120397@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mengbiao Xiong <xisme1998@gmail.com>

[ Upstream commit 181698af38d3f93381229ad89c09b5bd0496661a ]

When CONFIG_CRYPTO_DEV_CCP_DEBUGFS is enabled, rebinding
the ccp device causes the following crash:

$ echo '0000:0a:00.2' > /sys/bus/pci/drivers/ccp/unbind
$ echo '0000:0a:00.2' > /sys/bus/pci/drivers/ccp/bind

[  204.976930] BUG: kernel NULL pointer dereference, address: 0000000000000098
[  204.978026] #PF: supervisor write access in kernel mode
[  204.979126] #PF: error_code(0x0002) - not-present page
[  204.980226] PGD 0 P4D 0
[  204.981317] Oops: Oops: 0002 [#1] SMP NOPTI
...
[  204.997852] Call Trace:
[  204.999074]  <TASK>
[  205.000297]  start_creating+0x9f/0x1c0
[  205.001533]  debugfs_create_dir+0x1f/0x170
[  205.002769]  ? srso_return_thunk+0x5/0x5f
[  205.004000]  ccp5_debugfs_setup+0x87/0x170 [ccp]
[  205.005241]  ccp5_init+0x8b2/0x960 [ccp]
[  205.006469]  ccp_dev_init+0xd4/0x150 [ccp]
[  205.007709]  sp_init+0x5f/0x80 [ccp]
[  205.008942]  sp_pci_probe+0x283/0x2e0 [ccp]
[  205.010165]  ? srso_return_thunk+0x5/0x5f
[  205.011376]  local_pci_probe+0x4f/0xb0
[  205.012584]  pci_device_probe+0xdb/0x230
[  205.013810]  really_probe+0xed/0x380
[  205.015024]  __driver_probe_device+0x7e/0x160
[  205.016240]  device_driver_attach+0x2f/0x60
[  205.017457]  bind_store+0x7c/0xb0
[  205.018663]  drv_attr_store+0x28/0x40
[  205.019868]  sysfs_kf_write+0x5f/0x70
[  205.021065]  kernfs_fop_write_iter+0x145/0x1d0
[  205.022267]  vfs_write+0x308/0x440
[  205.023453]  ksys_write+0x6d/0xe0
[  205.024616]  __x64_sys_write+0x1e/0x30
[  205.025778]  x64_sys_call+0x16ba/0x2150
[  205.026942]  do_syscall_64+0x56/0x1e0
[  205.028108]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  205.029276] RIP: 0033:0x7fbc36f10104
[  205.030420] Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8d 05 e1 08 2e 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53 48 89 f5

This patch sets ccp_debugfs_dir to NULL after destroying it in
ccp5_debugfs_destroy, allowing the directory dentry to be
recreated when rebinding the ccp device.

Tested on AMD Ryzen 7 1700X.

Fixes: 3cdbe346ed3f ("crypto: ccp - Add debugfs entries for CCP information")
Signed-off-by: Mengbiao Xiong <xisme1998@gmail.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccp/ccp-debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/ccp/ccp-debugfs.c b/drivers/crypto/ccp/ccp-debugfs.c
index a1055554b47a..dc26bc22c91d 100644
--- a/drivers/crypto/ccp/ccp-debugfs.c
+++ b/drivers/crypto/ccp/ccp-debugfs.c
@@ -319,5 +319,8 @@ void ccp5_debugfs_setup(struct ccp_device *ccp)
 
 void ccp5_debugfs_destroy(void)
 {
+	mutex_lock(&ccp_debugfs_lock);
 	debugfs_remove_recursive(ccp_debugfs_dir);
+	ccp_debugfs_dir = NULL;
+	mutex_unlock(&ccp_debugfs_lock);
 }
-- 
2.39.5




