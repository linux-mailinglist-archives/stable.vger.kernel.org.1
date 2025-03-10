Return-Path: <stable+bounces-122719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C348AA5A0E4
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1D53ACAFD
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F06231A2A;
	Mon, 10 Mar 2025 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UC34VZTs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40C92D023;
	Mon, 10 Mar 2025 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629302; cv=none; b=h32IwkDIB7T7SwwNXFPwk2M/9rMghTMVOf8BF1tdDFQfHBv524plkoyUrELmN/Qi6CZSoIBegmawwG0gTbcKOUV5pYqUQfOPoJ9ZBuHn/DDP5G4ITYECb70140y6HvKKGSiTJwQW7yJuWA89n/U/pb4HY6tZCPuYlYXybdVuOp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629302; c=relaxed/simple;
	bh=Tr6TOysNNrze2Kvwm2IWimsi0AbqRoU7N8L5uF/w93A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9KbWHpzw2X02jlZ7kmotMisfUiBODQsvwvOOJ/3NLab7LGDJbQvu8ZkvAfejN1InVBI3w/ikmdN1eBljK0VbV4kh1i1FaMhuWF6u6J8I0ehnw7ag2If+IOHVZUOxn/wSEhAj70cXmIPmyVrR7NaK7IHXKLavy2qbyj3z9r/8RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UC34VZTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6634BC4CEE5;
	Mon, 10 Mar 2025 17:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741629301;
	bh=Tr6TOysNNrze2Kvwm2IWimsi0AbqRoU7N8L5uF/w93A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UC34VZTsa00yApFM0VW3WlTo7MLvFoIujoYrLGn6iy4wI7dJriAjNDN4bJlzscABk
	 5ahoR/+YYR5Hp91M1LLSrT1q0NfjYC7uPe7irosZgwVh2SPzHMvxBMLcpGjOQjviCo
	 lwKdAt8B6Cd7BBwOx+vT65DPS5s3FS8IzR33MhSg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacob Moroni <mail@jakemoroni.com>,
	Igor Russkikh <irusskikh@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 246/620] net: atlantic: fix warning during hot unplug
Date: Mon, 10 Mar 2025 18:01:32 +0100
Message-ID: <20250310170555.340909249@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Moroni <mail@jakemoroni.com>

[ Upstream commit 028676bb189ed6d1b550a0fc570a9d695b6acfd3 ]

Firmware deinitialization performs MMIO accesses which are not
necessary if the device has already been removed. In some cases,
these accesses happen via readx_poll_timeout_atomic which ends up
timing out, resulting in a warning at hw_atl2_utils_fw.c:112:

[  104.595913] Call Trace:
[  104.595915]  <TASK>
[  104.595918]  ? show_regs+0x6c/0x80
[  104.595923]  ? __warn+0x8d/0x150
[  104.595925]  ? aq_a2_fw_deinit+0xcf/0xe0 [atlantic]
[  104.595934]  ? report_bug+0x182/0x1b0
[  104.595938]  ? handle_bug+0x6e/0xb0
[  104.595940]  ? exc_invalid_op+0x18/0x80
[  104.595942]  ? asm_exc_invalid_op+0x1b/0x20
[  104.595944]  ? aq_a2_fw_deinit+0xcf/0xe0 [atlantic]
[  104.595952]  ? aq_a2_fw_deinit+0xcf/0xe0 [atlantic]
[  104.595959]  aq_nic_deinit.part.0+0xbd/0xf0 [atlantic]
[  104.595964]  aq_nic_deinit+0x17/0x30 [atlantic]
[  104.595970]  aq_ndev_close+0x2b/0x40 [atlantic]
[  104.595975]  __dev_close_many+0xad/0x160
[  104.595978]  dev_close_many+0x99/0x170
[  104.595979]  unregister_netdevice_many_notify+0x18b/0xb20
[  104.595981]  ? __call_rcu_common+0xcd/0x700
[  104.595984]  unregister_netdevice_queue+0xc6/0x110
[  104.595986]  unregister_netdev+0x1c/0x30
[  104.595988]  aq_pci_remove+0xb1/0xc0 [atlantic]

Fix this by skipping firmware deinitialization altogether if the
PCI device is no longer present.

Tested with an AQC113 attached via Thunderbolt by performing
repeated unplug cycles while traffic was running via iperf.

Fixes: 97bde5c4f909 ("net: ethernet: aquantia: Support for NIC-specific code")
Signed-off-by: Jacob Moroni <mail@jakemoroni.com>
Reviewed-by: Igor Russkikh <irusskikh@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250203143604.24930-3-mail@jakemoroni.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index c52093589d7cf..25349a2ae5cfe 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -1294,7 +1294,9 @@ void aq_nic_deinit(struct aq_nic_s *self, bool link_down)
 	aq_ptp_ring_free(self);
 	aq_ptp_free(self);
 
-	if (likely(self->aq_fw_ops->deinit) && link_down) {
+	/* May be invoked during hot unplug. */
+	if (pci_device_is_present(self->pdev) &&
+	    likely(self->aq_fw_ops->deinit) && link_down) {
 		mutex_lock(&self->fwreq_mutex);
 		self->aq_fw_ops->deinit(self->aq_hw);
 		mutex_unlock(&self->fwreq_mutex);
-- 
2.39.5




