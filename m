Return-Path: <stable+bounces-223935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKOSCZz8r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:12:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C4E24A143
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAF7F31485F6
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE213859CF;
	Tue, 10 Mar 2026 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnMgA5go"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB5238423F;
	Tue, 10 Mar 2026 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141071; cv=none; b=BBpjYezKvHlWKvz0mFR9QF6EOl8475Xf+aCRtwdjQGdIS2V969ABJlNRZT1NWBF2GNGUu2LCtx0CjCPqjZsUc8CmgEjTRMkMlMTRoWe83ITKBa6iAYjc6YYqQjtdIpU+iEfluiYYRpb1PVJE7cpwMRf8Gh/qPVc30jhGcYkYdhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141071; c=relaxed/simple;
	bh=PAjhTulSp+4tQ8o81yYQl4Z1FI0qI1eEO5x0HltSE3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gl7b7x7rZZEUWhj1Oruum32tDEzEvtl7d5xOzVeLiE+CbH4d2ntrpuAtB/5/d3KkpZBFCe9TBZ/tzTO7znMJdFZz1bTTzAtINdcYn4xEG25ThbcaoOPxuOhQYjdRPIH3YzPHZhIPtve2IVgnvAoPevb5PPOjVsLTFre7pmz9cIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnMgA5go; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43469C19423;
	Tue, 10 Mar 2026 11:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141070;
	bh=PAjhTulSp+4tQ8o81yYQl4Z1FI0qI1eEO5x0HltSE3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VnMgA5goicP+F9U7KrRks2YUZInU06C6Ul4f6IVpUY9I+vxM+CNwx8eO7uZOq+6po
	 jTL5rSrq2uXQI8SstiLhUmDW+g8jHckGw10sO7v+QtkZi8HewMaIJaCXN7FiU43qtk
	 6YsS4IXUePkaL5ezihSxcG/kH5WdLw22MNcDNBU0KSOKSwC0C/K3LZbBu+eUnAR33C
	 VsdBkr8+H+++I38ytxEgzB+zJGWWoS7kmwGwiiZ2w/uBfc72MRUb04I4vVSO2WGzN5
	 IzQeIIwc0OdKV15E4QMmcscg3cG1iD8c3cJ893Wfb+BtoKEwXjB+EVldSm8u3e3z92
	 /IVO3c97Y5m6w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lijo Lazar <lijo.lazar@amd.com>,
	Ce Sun <cesun102@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 070/311] drm/amdgpu: Fix error handling in slot reset
Date: Tue, 10 Mar 2026 07:01:57 -0400
Message-ID: <8777a2c225f4f5b11a80470a4bca13ae08bb7790.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A8C4E24A143
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223935-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Action: no action

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit b57c4ec98c17789136a4db948aec6daadceb5024 ]

If the device has not recovered after slot reset is called, it goes to
out label for error handling. There it could make decision based on
uninitialized hive pointer and could result in accessing an uninitialized
list.

Initialize the list and hive properly so that it handles the error
situation and also releases the reset domain lock which is acquired
during error_detected callback.

Fixes: 732c6cefc1ec ("drm/amdgpu: Replace tmp_adev with hive in amdgpu_pci_slot_reset")
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Ce Sun <cesun102@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit bb71362182e59caa227e4192da5a612b09349696)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 09f9d82e572da..ad5a3235a75f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -7203,6 +7203,15 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	dev_info(adev->dev, "PCI error: slot reset callback!!\n");
 
 	memset(&reset_context, 0, sizeof(reset_context));
+	INIT_LIST_HEAD(&device_list);
+	hive = amdgpu_get_xgmi_hive(adev);
+	if (hive) {
+		mutex_lock(&hive->hive_lock);
+		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
+			list_add_tail(&tmp_adev->reset_list, &device_list);
+	} else {
+		list_add_tail(&adev->reset_list, &device_list);
+	}
 
 	if (adev->pcie_reset_ctx.swus)
 		link_dev = adev->pcie_reset_ctx.swus;
@@ -7243,19 +7252,13 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	reset_context.reset_req_dev = adev;
 	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 	set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
-	INIT_LIST_HEAD(&device_list);
 
-	hive = amdgpu_get_xgmi_hive(adev);
 	if (hive) {
-		mutex_lock(&hive->hive_lock);
 		reset_context.hive = hive;
-		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
+		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
 			tmp_adev->pcie_reset_ctx.in_link_reset = true;
-			list_add_tail(&tmp_adev->reset_list, &device_list);
-		}
 	} else {
 		set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
-		list_add_tail(&adev->reset_list, &device_list);
 	}
 
 	r = amdgpu_device_asic_reset(adev, &device_list, &reset_context);
-- 
2.51.0


