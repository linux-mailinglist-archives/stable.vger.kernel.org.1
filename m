Return-Path: <stable+bounces-114745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09493A3000B
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58F387A14CF
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 01:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01401ADC68;
	Tue, 11 Feb 2025 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAnlS7yf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5AF5223;
	Tue, 11 Feb 2025 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237397; cv=none; b=RQpP0bb98N6DFOeMNLUR6JLb7uuFmP2AF21h0D0ZdsnTR1g5IZXENMCOdZIe2xqOrY8EhOWm4hvP8RlotdvYxn1214CJiFxgqxqbmpLkRK9PcJN4dk1UjqmLovJKQKnA7DffcLmdWC/dq0fIcaM0Bvcm1UjqMylOL/LuS+2VYdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237397; c=relaxed/simple;
	bh=WFxr/y9LJF0Ox1+qtFw5ab55rZwBdjgkMAZy8r9P928=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H3C126Uu3j7jC+6XTG9wK3NQQ8xVO7ZTkze6VUUjRbP239WKjJlaSNM56kK2PoaCyguNjqgigs20V11XiAKGOpr+hiatV4LD/WmGP72s7wRZoWWGl6y7wKGRm8thDkg3J3iBeGoqDphH2gtOZ7y3RSkn4IQWBI0EIAiV4DXO/DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAnlS7yf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23EFC4CED1;
	Tue, 11 Feb 2025 01:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739237397;
	bh=WFxr/y9LJF0Ox1+qtFw5ab55rZwBdjgkMAZy8r9P928=;
	h=From:To:Cc:Subject:Date:From;
	b=GAnlS7yfmwbl8AyrDqVrzU8T78BAouRQEMBCdH6okFpB5Wz9BT7zNO/frGthPVAAx
	 OaXtdeUtlmN6V8cZkfs7GxNn4eu4jUNfea+15pYVgPZ6ydqv0w4009PI4t2XxtRpNq
	 2fI4S/3JBUsMCyhQw5vlcFTDacMpeApTYhhAmvEo2GEET9yCsyf+tO8luf1s9kqVPk
	 0Zvf0UuvSB5vR6XXGDUMdplD+7z8uOa56ICr8gOcpZ49a/LSZYEg+xvMYvNdgL9hjX
	 8cJq8YIfCJXUC7B1WynpCZrEnUS59t4XAMctMLfAnw8F4nF0kBBRjy31YVPAAXAVoJ
	 fpOVLnVhD5YWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 01/21] nvme-fc: go straight to connecting state when initializing
Date: Mon, 10 Feb 2025 20:29:34 -0500
Message-Id: <20250211012954.4096433-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.2
Content-Transfer-Encoding: 8bit

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit d3d380eded7ee5fc2fc53b3b0e72365ded025c4a ]

The initial controller initialization mimiks the reconnect loop
behavior by switching from NEW to RESETTING and then to CONNECTING.

The transition from NEW to CONNECTING is a valid transition, so there is
no point entering the RESETTING state. TCP and RDMA also transition
directly to CONNECTING state.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b81af7919e94c..d45ab530ff9b7 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3579,8 +3579,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING) ||
-	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: failed to init ctrl state\n", ctrl->cnum);
 		goto fail_ctrl;
-- 
2.39.5


