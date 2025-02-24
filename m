Return-Path: <stable+bounces-118863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924D0A41D16
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50147178B7C
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0DC26E64D;
	Mon, 24 Feb 2025 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2DPlssd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2966126E639;
	Mon, 24 Feb 2025 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395999; cv=none; b=QokjhcsMIY/59ilNpgfF8e40gyVOXuhW26jcu3EvcpOcIGIxrxOhSRcKxlc4pr42DPPs0f1DE0b5vAwEgvtVjRDCL3EG0+YE5vd4reGOamWileejBgmtolwTx7qlzTYOb8oO0RF/scxTpQr9gE6wVZyZzNraj2A0Vd73XiEj4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395999; c=relaxed/simple;
	bh=RHx50UWp9P4Yws0Mg6XUcmjMYIw2REcQXVpiCmQ0bv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=umZ4lAQ7Fd1c/ZdAFfguQpm1Q2lbymtRoKe/ql6t6clVImrD4eoMprQQmzR8LrYzydNKANs+HpLkJBXM8SrX1SgYfHqpIGAhLs252TDxvbjzQ4DxxDiZT9Imc8mvgXM2HXDuDq8FkrgLeQFgVdtHqF3xs4z8ODmP1ddCNnuG8Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2DPlssd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B72C4CED6;
	Mon, 24 Feb 2025 11:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395998;
	bh=RHx50UWp9P4Yws0Mg6XUcmjMYIw2REcQXVpiCmQ0bv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2DPlssdew+TRWmyAgFHY6pMkZ5FG25lAGDt/LgdwQF7Ot+yeGUlEIj1kMLIypPne
	 6TEolfuyYEskoWxOa46kBUhEAeoCWB7ltLjmlkZCEu1CHvVHnaRmmtP/a9Id3ps8JL
	 RiYynPGnTuQLNUfBvzAR8yDKGP7NcD5zGnEjkvPW5wpiZMb2VahmMBggqbxh/hFLKV
	 Phj7MH2DHSVUtqabMorDrgeEroXJQxfWVc50rLIKOGdUCVZqtPnX9i7T04i6Z9rXwv
	 /4qII2bChAX+Urmxve84Jkn+z3chcMHFmW4O/JL7an0u+hm6HIt5tHYSEZ5XQGj+mU
	 ny9CvK26irchg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 19/20] nvme: only allow entering LIVE from CONNECTING state
Date: Mon, 24 Feb 2025 06:19:12 -0500
Message-Id: <20250224111914.2214326-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111914.2214326-1-sashal@kernel.org>
References: <20250224111914.2214326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.79
Content-Transfer-Encoding: 8bit

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit d2fe192348f93fe3a0cb1e33e4aba58e646397f4 ]

The fabric transports and also the PCI transport are not entering the
LIVE state from NEW or RESETTING. This makes the state machine more
restrictive and allows to catch not supported state transitions, e.g.
directly switching from RESETTING to LIVE.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8a200931bc297..f00665ad0c11a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -503,8 +503,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	switch (new_state) {
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
-		case NVME_CTRL_NEW:
-		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
 			changed = true;
 			fallthrough;
-- 
2.39.5


