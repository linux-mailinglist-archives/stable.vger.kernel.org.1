Return-Path: <stable+bounces-5385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FA680CB99
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3FDE1C20BDD
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868A347789;
	Mon, 11 Dec 2023 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRCc1b2W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F8F4776B
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 13:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778F4C433D9;
	Mon, 11 Dec 2023 13:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302796;
	bh=1FGXzOaZOzxS1ldc+LzGNkdq2ud1cBYt+XVVjU4funE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRCc1b2WPQgue2UgbIoR8NQ6YnRdj/VliRRRNP8S/xFAyVG1PEqO84kTrgzov3IAc
	 9dVFLIouJ2GkAUVoD0sB/AGfh/yClZ5Z9xK9evDdpZgwibFcNRnbV69k1kIQ2FQrog
	 uxcmYCxZMGVF0dMhMUQDuorGxeyjXjP3fFVEO1xbrMUTwujvLQkrjGdVv6JruXp4Vj
	 Bfg4VJDk6fD2OfC8UZi2ZGfzwGAIaHgZvlepFfBgNeLsY+MGJKc2U6FzX2bbjeGRYa
	 2TkOfTYk1Rr8H+GLsVBsTf6JObBh3/+FrJMX285iXT+fPd9jntPIgPFbk1bUrzPHuU
	 IS9thvHb7/8GA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 30/47] nvme: introduce helper function to get ctrl state
Date: Mon, 11 Dec 2023 08:50:31 -0500
Message-ID: <20231211135147.380223-30-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
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
index f35647c470afa..68313148e6ed5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -386,6 +386,11 @@ struct nvme_ctrl {
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


