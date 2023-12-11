Return-Path: <stable+bounces-5421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E185C80CBF6
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F92281838
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7E847A69;
	Mon, 11 Dec 2023 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMDtTmrZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4093A47A67
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 13:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702A3C43391;
	Mon, 11 Dec 2023 13:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302967;
	bh=7FWLRc1p6rU6lBfjPN3MpBMeNXSUTIig4nLI3YeSsPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HMDtTmrZdRo54xdeGELIEYyXlyCPWGvTXl6Vl320flODlruS9ce+NtOYct/wAWxOj
	 WdUieECt9yZV+82SRFBDsIBvL0fe5WSxIkxxAYMklpI5pe/otBR8Ld+FCtKOvcFkri
	 j+pY9F+1C7lqU0YDsWolZPt8iUFlWinPKdfhfbUZ1D9lmqug7Dm34QBeV1sJtfW3oG
	 MSaDRHlVVtRkkTdOjRK2CL/cmfWawbUdVmTyBuWhCPyLHipCEo4HOkVsK1ggHmewbC
	 cyIXDfaTkhk6GPOgfDnV5ZtLXdwKp0be2tv2wRKV30R8VpQKHGRaYfsFkQ62lsAi2f
	 W2YMJ12yAmvSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 19/29] nvme: introduce helper function to get ctrl state
Date: Mon, 11 Dec 2023 08:54:03 -0500
Message-ID: <20231211135457.381397-19-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135457.381397-1-sashal@kernel.org>
References: <20231211135457.381397-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.66
Content-Transfer-Encoding: 8bit

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 5c687c287c46fadb14644091823298875a5216aa ]

The controller state is typically written by another CPU, so reading it
should ensure no optimizations are taken. This is a repeated pattern in
the driver, so start with adding a convenience function that returns the
controller state with READ_ONCE().

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/nvme.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 69f9e69208f68..8b50b56b8ee31 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -377,6 +377,11 @@ struct nvme_ctrl {
 	enum nvme_dctype dctype;
 };
 
+static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
+{
+	return READ_ONCE(ctrl->state);
+}
+
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
-- 
2.42.0


