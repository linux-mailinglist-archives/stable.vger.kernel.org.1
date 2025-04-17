Return-Path: <stable+bounces-133983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E57A92904
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256AE3A9E1B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA312627FC;
	Thu, 17 Apr 2025 18:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xQpz//lJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A46E2627E9;
	Thu, 17 Apr 2025 18:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914737; cv=none; b=expD4dhbOV3aWa1ZzknghUOYRgKFS8w0hFRfcdOjG7yiDsvTWkpvZN+n/qcZv8V55ftpajM43HjLt6kVJUDrsrycGZ+BGxgFDrbXDwNWPZL839KkxaxTQ41YRQKp6/Lpufh2BBvc5kJ7HwRck5GxpnnsMPz7fdxaP9okjnh0pFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914737; c=relaxed/simple;
	bh=qfWGYuS5MDXRdwxnmHsCJBX76C+MfM1S1IUQtRdm9vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0Fxio4540ZN8jo9Nu04nzYk5Z/8QSQtFCsWgDDMpcN2ssipxOModjH3f14lUqCPaqFvujF3TveqZt+hkaPV/aOSJNmlhzIOpX6JiQ4p4pEorD0XCv541T7s9LpX5cjz7wF6cdTe2jZy3KA5moQegBW14s0AfUCao0gZtB4GRfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xQpz//lJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE91FC4CEE4;
	Thu, 17 Apr 2025 18:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914737;
	bh=qfWGYuS5MDXRdwxnmHsCJBX76C+MfM1S1IUQtRdm9vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xQpz//lJQfla9JPVNsP4zRPl7sTeYHzS8zdfZ1x4UcYuh0uhvMIbDXJbHc3vSQ+s+
	 NjHiGEqrosUln71wMMJeo4KJyQgr+qUXfscTMHZRRn63FrPsKQKWZlhjCgFi27isvT
	 Tq1KMFtoCBVIle9S40+bLxZ95QAk9Uc2ACt5IDZE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH 6.13 274/414] accel/ivpu: Fix warning in ivpu_ipc_send_receive_internal()
Date: Thu, 17 Apr 2025 19:50:32 +0200
Message-ID: <20250417175122.446064103@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

commit 6b4568b675b14cf890c0c21779773c3e08e80ce5 upstream.

Warn if device is suspended only when runtime PM is enabled.
Runtime PM is disabled during reset/recovery and it is not an error
to use ivpu_ipc_send_receive_internal() in such cases.

Fixes: 5eaa49741119 ("accel/ivpu: Prevent recovery invocation during probe and resume")
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Link: https://lore.kernel.org/r/20250325114219.3739951-1-maciej.falkowski@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accel/ivpu/ivpu_ipc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -302,7 +302,8 @@ ivpu_ipc_send_receive_internal(struct iv
 	struct ivpu_ipc_consumer cons;
 	int ret;
 
-	drm_WARN_ON(&vdev->drm, pm_runtime_status_suspended(vdev->drm.dev));
+	drm_WARN_ON(&vdev->drm, pm_runtime_status_suspended(vdev->drm.dev) &&
+		    pm_runtime_enabled(vdev->drm.dev));
 
 	ivpu_ipc_consumer_add(vdev, &cons, channel, NULL);
 



