Return-Path: <stable+bounces-140157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05706AAA5C6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930F73B5781
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6542E290DBA;
	Mon,  5 May 2025 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRTDC86w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F70290DB4;
	Mon,  5 May 2025 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484248; cv=none; b=N8UB8DtxYjbLe3GQwaOGJ2/6fyyBPolhD03z3tKdx9bs3Nka5GtoC6/3RzK23Amy+l4QzC3JPeo6WWkvdQ5DtGI192LYYdOY2p8kSU1T2x0wc2Zs+CRQMo7QOGHlT8SwXugIu5kP2pS3rgLMsVUC1sa7az25xnEFt+7nq+itGYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484248; c=relaxed/simple;
	bh=7hdEuE2KD3dDhGOix5o8Un11LfpTnYgXsJqdKHqbTm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I6ZSqtB6kIK+Dbk7cEhsk2pavvlc9dHfaK+EhM6TivEkkvoL3N13jNOnfbL7EUA9z9LpR4FVXqNwJPNh8gDyLEAv3rVpah8SNW02eZHQoHJwhu9eHREQyCRG+LDC85T4FJqkgeD2JQT2oFCCPnkIxRPTTOzkNdTk2faYbPWGqTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRTDC86w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309E5C4CEEE;
	Mon,  5 May 2025 22:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484247;
	bh=7hdEuE2KD3dDhGOix5o8Un11LfpTnYgXsJqdKHqbTm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRTDC86wwmhVPBPUnvOqnC8V4+jUxD1WFnH6mCKFHGQ+b09jaACy7iDuCa6VqrYwg
	 NK0R2MJdsCJB0bgdXZMlDDMljifPBzXys/euV6xv/wUSYJPgEGE49+adu5iHFfR/z1
	 7u9ejod6cxqKQBAnV9C5EnNdKu9yFdesD3HmMQ4CdQ0gybizzPZYfrBzK1gQsuFQvr
	 9ZeBYh3IzCg700deS8Uw1V/hlAtIyP2rN4g78qoJe2CRncDTPLEFpQy5sG3Wq/wF5X
	 K0MUccp/KAIa9DDcUSjuPL1PaVmk+/cds4wokJ7x4IiLa2gUDCx7f2kxqrP5Wp5wNZ
	 GuwhXaKYWH0hA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 410/642] firmware: arm_ffa: Handle the presence of host partition in the partition info
Date: Mon,  5 May 2025 18:10:26 -0400
Message-Id: <20250505221419.2672473-410-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit 2f622a8b0722d332a2a149794a3add47bc9bdcf3 ]

Currently it is assumed that the firmware doesn't present the host
partition in the list of partitions presented as part of the response
to PARTITION_INFO_GET from the firmware. However, there are few
platforms that prefer to present the same in the list of partitions.
It is not manadatory but not restricted as well.

So handle the same by making sure to check the presence of the host
VM ID in the XArray partition information maintained/managed in the
driver before attempting to add it.

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
Message-Id: <20250217-ffa_updates-v3-7-bd1d9de615e7@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index f14aedde365bd..640d214f9594d 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1457,6 +1457,10 @@ static int ffa_setup_partitions(void)
 
 	kfree(pbuf);
 
+	/* Check if the host is already added as part of partition info */
+	if (xa_load(&drv_info->partition_info, drv_info->vm_id))
+		return 0;
+
 	/* Allocate for the host */
 	ret = ffa_xa_add_partition_info(drv_info->vm_id);
 	if (ret)
-- 
2.39.5


