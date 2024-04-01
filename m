Return-Path: <stable+bounces-34047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFE1893DA3
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5D0283183
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 15:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D87351C59;
	Mon,  1 Apr 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R1b80sC/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C71B22301;
	Mon,  1 Apr 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986832; cv=none; b=BR0htpks+6+Lc9h0EXUHREBFGc07m09ehvY6zfJhbTYpg8f0yiGibbY+rcXPQ1vgvrDHZRI9HMGe3g/IKemRAKn8XB5QDEasrXTORDpQq8ta+pWEcXUOt+Y1vzlU4AMH/+6Bi59wRg4INTYmtYd4Q7R+sygjGUTFvSYyn+cGmE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986832; c=relaxed/simple;
	bh=OSKWZOqFBVdq8Qr5q5Y1TBnjdGWpB2QmMl1TBkCBF20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSCU/TUFVA/U26Xp1Whaej78TqVm91PpP0ub585QbfiDj3EdB/67VZJ3fQnOKxg7RZ68TpwAWSb6/gDet6LNNmeYoT4Cb5TFOFnZg7GlzBaZOia19cQM/ofxZtbfosb84lV9ZhNlJJbN9+UW4DO5erCMqhO0/jjjQgYQ2X55BLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R1b80sC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8679C433C7;
	Mon,  1 Apr 2024 15:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711986832;
	bh=OSKWZOqFBVdq8Qr5q5Y1TBnjdGWpB2QmMl1TBkCBF20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R1b80sC/06+ivnarYeIpQt45xEkflZT2xtY4Hb2UPE1YjBLfxhZdpCQpsg/70a62k
	 /Nli4e8ucnusKCm4vfgIGVFT9168QDDjWpU1deP3E22FY3vu26Ov5eCcLt3ctPZ12I
	 kn9j2TSw3FhuF+JHxd3P1UmZxzt0z4rSXTvlhv7o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brett Creeley <brett.creeley@amd.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 069/399] vfio/pds: Always clear the save/restore FDs on reset
Date: Mon,  1 Apr 2024 17:40:35 +0200
Message-ID: <20240401152551.246823402@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brett Creeley <brett.creeley@amd.com>

[ Upstream commit 8512ed256334f6637fc0699ce794792c357544ec ]

After reset the VFIO device state will always be put in
VFIO_DEVICE_STATE_RUNNING, but the save/restore files will only be
cleared if the previous state was VFIO_DEVICE_STATE_ERROR. This
can/will cause the restore/save files to be leaked if/when the
migration state machine transitions through the states that
re-allocates these files. Fix this by always clearing the
restore/save files for resets.

Fixes: 7dabb1bcd177 ("vfio/pds: Add support for firmware recovery")
Cc: stable@vger.kernel.org
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240228003205.47311-2-brett.creeley@amd.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/pds/vfio_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/pds/vfio_dev.c b/drivers/vfio/pci/pds/vfio_dev.c
index 4c351c59d05a9..a286ebcc71126 100644
--- a/drivers/vfio/pci/pds/vfio_dev.c
+++ b/drivers/vfio/pci/pds/vfio_dev.c
@@ -32,9 +32,9 @@ void pds_vfio_state_mutex_unlock(struct pds_vfio_pci_device *pds_vfio)
 	mutex_lock(&pds_vfio->reset_mutex);
 	if (pds_vfio->deferred_reset) {
 		pds_vfio->deferred_reset = false;
+		pds_vfio_put_restore_file(pds_vfio);
+		pds_vfio_put_save_file(pds_vfio);
 		if (pds_vfio->state == VFIO_DEVICE_STATE_ERROR) {
-			pds_vfio_put_restore_file(pds_vfio);
-			pds_vfio_put_save_file(pds_vfio);
 			pds_vfio_dirty_disable(pds_vfio, false);
 		}
 		pds_vfio->state = pds_vfio->deferred_reset_state;
-- 
2.43.0




