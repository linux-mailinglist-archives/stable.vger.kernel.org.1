Return-Path: <stable+bounces-141457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4CCAAB3A3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826CA3AD5A4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F24F29825E;
	Tue,  6 May 2025 00:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgOXEa+c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB8239E72;
	Mon,  5 May 2025 23:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486356; cv=none; b=PrtkXC0xUZJLubUa+rHpw+AW5qT9qAMi4Z62Hg8QtPyWA8tNTAzEBbSwW9/LwBsNNilx2a921caY3dVaLxJvxZIwtOfKMyLkUWi5A2TCwzi3SHqHOinIj2PZY1MN6AHP1OftxVIrAH53f3jBmVnM0CSEq2TDxoulVK1hxcCjNDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486356; c=relaxed/simple;
	bh=o3fek8CovNQudAwcjM9tbEogmSdp5XotgQ0/JnUDR4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RrqVApm5AZvpDEmSVxEyZrOCZxG+MCIPikxj9sl1n9RcbAdu0L+O4RWRu23yP0ypzGr0sFWtNFEC1C6PFiRNZa7Hf3IXMJRqHWBhDuXy47K7vZBSdaE+aINR77SOYPsHnoskkYk1VBPjsR/1K+0D0vaiq1+yHaOccY2wSj0uEYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgOXEa+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69A4C4CEED;
	Mon,  5 May 2025 23:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486356;
	bh=o3fek8CovNQudAwcjM9tbEogmSdp5XotgQ0/JnUDR4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lgOXEa+c4TNh/fcZw1DM0dmgRYqCHfwahA1DSZ78WqKMdq7GQgeyaD7xfpUgvpzwU
	 aAgObJJ+Uel3iokgXE2vR7hDzmL2a9eJPyDGedszhJFmo9VAxXmjWTyabaN+bmw45+
	 uTUztDRpy0iKNkTHdri45RaaPpMPQ+kQ+c3M/brfwdo2FLdEja12VG+yogJrYgoWq0
	 0DjSv7czb1lHoxYXUTMC1qxAGRQqMTbLAv8HkfUUS9i+N8cbD4VZ83kQxMR+TXKRSi
	 V/Kc+GipyY5eJGytIkWMURZ0a7nAXEgKS6vMgcgbi4BVmE3yPiosB4yU0Y+x73r4uv
	 RwrrTOSVos9Qg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Dhruva Gole <d-gole@ti.com>,
	Peng Fan <peng.fan@nxp.com>,
	Sasha Levin <sashal@kernel.org>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 278/294] firmware: arm_scmi: Relax duplicate name constraint across protocol ids
Date: Mon,  5 May 2025 18:56:18 -0400
Message-Id: <20250505225634.2688578-278-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit 21ee965267bcbdd733be0f35344fa0f0226d7861 ]

Currently in scmi_protocol_device_request(), no duplicate scmi device
name is allowed across any protocol. However scmi_dev_match_id() first
matches the protocol id and then the name. So, there is no strict
requirement to keep this scmi device name unique across all the protocols.

Relax the constraint on the duplicate name across the protocols and
inhibit only within the same protocol id.

Message-Id: <20250131141822.514342-1-sudeep.holla@arm.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_scmi/bus.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index dcf774d3edfe4..0d61f84691d85 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -42,7 +42,7 @@ static atomic_t scmi_syspower_registered = ATOMIC_INIT(0);
  * This helper let an SCMI driver request specific devices identified by the
  * @id_table to be created for each active SCMI instance.
  *
- * The requested device name MUST NOT be already existent for any protocol;
+ * The requested device name MUST NOT be already existent for this protocol;
  * at first the freshly requested @id_table is annotated in the IDR table
  * @scmi_requested_devices and then the requested device is advertised to any
  * registered party via the @scmi_requested_devices_nh notification chain.
@@ -52,7 +52,6 @@ static atomic_t scmi_syspower_registered = ATOMIC_INIT(0);
 static int scmi_protocol_device_request(const struct scmi_device_id *id_table)
 {
 	int ret = 0;
-	unsigned int id = 0;
 	struct list_head *head, *phead = NULL;
 	struct scmi_requested_dev *rdev;
 
@@ -67,19 +66,13 @@ static int scmi_protocol_device_request(const struct scmi_device_id *id_table)
 	}
 
 	/*
-	 * Search for the matching protocol rdev list and then search
-	 * of any existent equally named device...fails if any duplicate found.
+	 * Find the matching protocol rdev list and then search of any
+	 * existent equally named device...fails if any duplicate found.
 	 */
 	mutex_lock(&scmi_requested_devices_mtx);
-	idr_for_each_entry(&scmi_requested_devices, head, id) {
-		if (!phead) {
-			/* A list found registered in the IDR is never empty */
-			rdev = list_first_entry(head, struct scmi_requested_dev,
-						node);
-			if (rdev->id_table->protocol_id ==
-			    id_table->protocol_id)
-				phead = head;
-		}
+	phead = idr_find(&scmi_requested_devices, id_table->protocol_id);
+	if (phead) {
+		head = phead;
 		list_for_each_entry(rdev, head, node) {
 			if (!strcmp(rdev->id_table->name, id_table->name)) {
 				pr_err("Ignoring duplicate request [%d] %s\n",
-- 
2.39.5


