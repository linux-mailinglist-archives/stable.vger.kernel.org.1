Return-Path: <stable+bounces-55480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB5A9163C7
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEEAFB27847
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC4F149E0A;
	Tue, 25 Jun 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DDF1Yxnj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8E7149E03;
	Tue, 25 Jun 2024 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309028; cv=none; b=bgjOFGFIoygRN4OqR9YgKga8UVsGXQRCj7M/2aEblNGtVJPBMxEOdKGD2CfmCsAVgrcnDAIryV7GvkkjciIakB0ZxCtm7l6dtQCIWHJid+c+lRkN32GE3xIxvVFSNLDGj2H8gbwCVlt2V5qW188cj0Z2iaonBUJE2u9HKHqJKi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309028; c=relaxed/simple;
	bh=WYCO1Qoym6r2HIP3rQzTenTO7F5NabJ5De0MhWwdiIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URnhNeO3rbUdYrZJljxwrchMLuoj9lGTj3SWh+TV/HFM8vzk7wJ57NM7S8YoZC1k/TD1vhKjWyQzjuXMxFaBYkm+c7Atapfy6w/lmBV1wnh+dKLSlPeFO1bZ2YBv1Y00EhYJ+Vnq240SHBzEteNuStp7Tg6UnyGma6e8AMupKqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DDF1Yxnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F9DC32781;
	Tue, 25 Jun 2024 09:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719309027;
	bh=WYCO1Qoym6r2HIP3rQzTenTO7F5NabJ5De0MhWwdiIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDF1YxnjKJPBBpiORuowy4X1LvWP60eon4z4/cJ8gcl6w8Y3klzBTOgP5XLEWpk93
	 y8mDzDghheQaPa49Q7p3i0dcPhGBQrOEoBYpow/USzKGkddqHZWMRP5O4Rba7gy/k9
	 buTNwzE3clFGOoFhG4cUeVbvFsdLq54rHetQxYpk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cyrus Lien <cyrus.lien@canonical.com>,
	En-Wei Wu <en-wei.wu@canonical.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 6.6 070/192] ice: avoid IRQ collision to fix init failure on ACPI S3 resume
Date: Tue, 25 Jun 2024 11:32:22 +0200
Message-ID: <20240625085539.861118946@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
References: <20240625085537.150087723@linuxfoundation.org>
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

From: En-Wei Wu <en-wei.wu@canonical.com>

[ Upstream commit bc69ad74867dba1377abe14356c94a946d9837a3 ]

A bug in https://bugzilla.kernel.org/show_bug.cgi?id=218906 describes
that irdma would break and report hardware initialization failed after
suspend/resume with Intel E810 NIC (tested on 6.9.0-rc5).

The problem is caused due to the collision between the irq numbers
requested in irdma and the irq numbers requested in other drivers
after suspend/resume.

The irq numbers used by irdma are derived from ice's ice_pf->msix_entries
which stores mappings between MSI-X index and Linux interrupt number.
It's supposed to be cleaned up when suspend and rebuilt in resume but
it's not, causing irdma using the old irq numbers stored in the old
ice_pf->msix_entries to request_irq() when resume. And eventually
collide with other drivers.

This patch fixes this problem. On suspend, we call ice_deinit_rdma() to
clean up the ice_pf->msix_entries (and free the MSI-X vectors used by
irdma if we've dynamically allocated them). On resume, we call
ice_init_rdma() to rebuild the ice_pf->msix_entries (and allocate the
MSI-X vectors if we would like to dynamically allocate them).

Fixes: f9f5301e7e2d ("ice: Register auxiliary device to provide RDMA")
Tested-by: Cyrus Lien <cyrus.lien@canonical.com>
Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 5d71febdcd4dd..26ef8aec4cfdf 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5348,7 +5348,7 @@ static int __maybe_unused ice_suspend(struct device *dev)
 	 */
 	disabled = ice_service_task_stop(pf);
 
-	ice_unplug_aux_dev(pf);
+	ice_deinit_rdma(pf);
 
 	/* Already suspended?, then there is nothing to do */
 	if (test_and_set_bit(ICE_SUSPENDED, pf->state)) {
@@ -5428,6 +5428,11 @@ static int __maybe_unused ice_resume(struct device *dev)
 	if (ret)
 		dev_err(dev, "Cannot restore interrupt scheme: %d\n", ret);
 
+	ret = ice_init_rdma(pf);
+	if (ret)
+		dev_err(dev, "Reinitialize RDMA during resume failed: %d\n",
+			ret);
+
 	clear_bit(ICE_DOWN, pf->state);
 	/* Now perform PF reset and rebuild */
 	reset_type = ICE_RESET_PFR;
-- 
2.43.0




