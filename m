Return-Path: <stable+bounces-208576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CB5D25F1F
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B2C7301513E
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 16:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DD139C624;
	Thu, 15 Jan 2026 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dQWs/Q8y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A879F2FDC4D;
	Thu, 15 Jan 2026 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768496242; cv=none; b=BBTWRGVqXmMDfPs7Wxs/XtPAW1wyBrF0+NSxE/edHcOMj9oW/svyZx4XuC3hbml0eKG06yu8NICEV7jHSY8GdfvSdToSpHmxcobq4veneDpOuSfar/rUVXukHoqSSC45VFeJ0WEXm1/hNHlkfNDLwPnVPv+0RSeobf5OcPSMDuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768496242; c=relaxed/simple;
	bh=c5chWPWGNaM3lxgQwZveYmrwLtvRxAwRFInRqsDPgGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f99VFdlUSBSR7y3NbXtrugOfgYQm4hpfhEs3jV6zv8fY0eSIKilykbgpkbC8btcVdSmOYpdZe7JTUlLLq9rQgiD1A5y7PU/X4Fe6jgAo1uSZFtyByUYZHsI+2o6sRvWptwbzyPm7uYOrARUp1vjrvOo9SehvSkwUHw7wAcVjwss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dQWs/Q8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3789AC19421;
	Thu, 15 Jan 2026 16:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768496242;
	bh=c5chWPWGNaM3lxgQwZveYmrwLtvRxAwRFInRqsDPgGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQWs/Q8ypT0L6wtALDVXBNgRxYwyhtGCjnRWNzhQMih/klHQRdr26D2ARjE0nGxU2
	 URv6L9rK1gCALnnrPYTslKL2G/ugj51Z5Ntt5iRvZeS2UINBomr8C3F1Ko1XidSLBs
	 jwGmc6pw8VQgPbecMUzXMIKLY4c2G1SK+D3ClhYY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 127/181] idpf: fix memory leak in idpf_vc_core_deinit()
Date: Thu, 15 Jan 2026 17:47:44 +0100
Message-ID: <20260115164206.900910284@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164202.305475649@linuxfoundation.org>
References: <20260115164202.305475649@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emil Tantilov <emil.s.tantilov@intel.com>

[ Upstream commit e111cbc4adf9f9974eed040aeece7e17460f6bff ]

Make sure to free hw->lan_regs. Reported by kmemleak during reset:

unreferenced object 0xff1b913d02a936c0 (size 96):
  comm "kworker/u258:14", pid 2174, jiffies 4294958305
  hex dump (first 32 bytes):
    00 00 00 c0 a8 ba 2d ff 00 00 00 00 00 00 00 00  ......-.........
    00 00 40 08 00 00 00 00 00 00 25 b3 a8 ba 2d ff  ..@.......%...-.
  backtrace (crc 36063c4f):
    __kmalloc_noprof+0x48f/0x890
    idpf_vc_core_init+0x6ce/0x9b0 [idpf]
    idpf_vc_event_task+0x1fb/0x350 [idpf]
    process_one_work+0x226/0x6d0
    worker_thread+0x19e/0x340
    kthread+0x10f/0x250
    ret_from_fork+0x251/0x2b0
    ret_from_fork_asm+0x1a/0x30

Fixes: 6aa53e861c1a ("idpf: implement get LAN MMIO memory regions")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Joshua Hay <joshua.a.hay@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 5bbe7d9294c14..01bbd12a642a0 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3570,6 +3570,7 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
  */
 void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 {
+	struct idpf_hw *hw = &adapter->hw;
 	bool remove_in_prog;
 
 	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
@@ -3593,6 +3594,9 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 
 	idpf_vport_params_buf_rel(adapter);
 
+	kfree(hw->lan_regs);
+	hw->lan_regs = NULL;
+
 	kfree(adapter->vports);
 	adapter->vports = NULL;
 
-- 
2.51.0




