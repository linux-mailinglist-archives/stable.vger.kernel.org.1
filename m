Return-Path: <stable+bounces-86050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 250F999EB6B
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A44B8B22A9A
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1345C1AF0AD;
	Tue, 15 Oct 2024 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rpjTz8nj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E161C07E5;
	Tue, 15 Oct 2024 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997602; cv=none; b=H5Mg2yh0brUZdqm92oNvMtL0J0+THTU/lEJsR7h/sKfAfUwEuaGR8VBGO7Pp3tFxEpZ1B9l5U0seNhsJaWvWss6y9awT7n1eS51md3uChFxEymifP+NxQ3xu15HQH9RSa35/eCjEjZeMmDEOXbQFhX1Rlw8Esxq8e/esT+MdmnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997602; c=relaxed/simple;
	bh=6taNoQ+mdRiTCCe3ue1JQmFrz8UiRZIhQ9J52AoIX1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQQ1fPqhAAL4PgrvVY8zfVaDtQAIamFXoGSG/jDAzSRf4kqJjic8lX2WAuO+LPhz/WHtj9dN5X/7Dg0unLepunKjqy7YZhsdfXAAQi1ZrfEwBPkkYFSyMAHhtnCMGMOnQ1MPg+d+yijsKPIuwj4f9y8HzGI+YqzGDPKyzRemklY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rpjTz8nj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA2BC4CEC6;
	Tue, 15 Oct 2024 13:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728997602;
	bh=6taNoQ+mdRiTCCe3ue1JQmFrz8UiRZIhQ9J52AoIX1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rpjTz8njDvPJ9vJ78tLfHcTASfox3YsUmRZTmWs0tg1OKqnO6PxtKi5jaUrrwe9N6
	 EiYQu4pW2/bUA6BE9PEpvXvJmnRD75pDwaZ0hkUgTW+PZhiDAu4qpmSvsdbYEUtz/5
	 AJQcKf/FFjnskJ86oXI15dU5hTwiQjbLsXia9OQk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavan Kumar Paluri <papaluri@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.10 230/518] crypto: ccp - Properly unregister /dev/sev on sev PLATFORM_STATUS failure
Date: Tue, 15 Oct 2024 14:42:14 +0200
Message-ID: <20241015123925.871463568@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavan Kumar Paluri <papaluri@amd.com>

commit ce3d2d6b150ba8528f3218ebf0cee2c2c572662d upstream.

In case of sev PLATFORM_STATUS failure, sev_get_api_version() fails
resulting in sev_data field of psp_master nulled out. This later becomes
a problem when unloading the ccp module because the device has not been
unregistered (via misc_deregister()) before clearing the sev_data field
of psp_master. As a result, on reloading the ccp module, a duplicate
device issue is encountered as can be seen from the dmesg log below.

on reloading ccp module via modprobe ccp

Call Trace:
  <TASK>
  dump_stack_lvl+0xd7/0xf0
  dump_stack+0x10/0x20
  sysfs_warn_dup+0x5c/0x70
  sysfs_create_dir_ns+0xbc/0xd
  kobject_add_internal+0xb1/0x2f0
  kobject_add+0x7a/0xe0
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? get_device_parent+0xd4/0x1e0
  ? __pfx_klist_children_get+0x10/0x10
  device_add+0x121/0x870
  ? srso_alias_return_thunk+0x5/0xfbef5
  device_create_groups_vargs+0xdc/0x100
  device_create_with_groups+0x3f/0x60
  misc_register+0x13b/0x1c0
  sev_dev_init+0x1d4/0x290 [ccp]
  psp_dev_init+0x136/0x300 [ccp]
  sp_init+0x6f/0x80 [ccp]
  sp_pci_probe+0x2a6/0x310 [ccp]
  ? srso_alias_return_thunk+0x5/0xfbef5
  local_pci_probe+0x4b/0xb0
  work_for_cpu_fn+0x1a/0x30
  process_one_work+0x203/0x600
  worker_thread+0x19e/0x350
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xeb/0x120
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x3c/0x60
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
  kobject: kobject_add_internal failed for sev with -EEXIST, don't try to register things with the same name in the same directory.
  ccp 0000:22:00.1: sev initialization failed
  ccp 0000:22:00.1: psp initialization failed
  ccp 0000:a2:00.1: no command queues available
  ccp 0000:a2:00.1: psp enabled

Address this issue by unregistering the /dev/sev before clearing out
sev_data in case of PLATFORM_STATUS failure.

Fixes: 200664d5237f ("crypto: ccp: Add Secure Encrypted Virtualization (SEV) command support")
Cc: stable@vger.kernel.org
Signed-off-by: Pavan Kumar Paluri <papaluri@amd.com>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/ccp/sev-dev.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1129,6 +1129,8 @@ void sev_pci_init(void)
 	return;
 
 err:
+	sev_dev_destroy(psp_master);
+
 	psp_master->sev_data = NULL;
 }
 



