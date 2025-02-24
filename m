Return-Path: <stable+bounces-118843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23351A41CE4
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB31A177761
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2C3267F66;
	Mon, 24 Feb 2025 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXbbKFXB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A19B267F5C;
	Mon, 24 Feb 2025 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395952; cv=none; b=R0Sa3ilR6KB16K+Rh9kkeJJJoFFAk5kY4GliZQDGphR+eIomgeve+ZIjx+nh7cxYhO3ffRzowXJHttSZAxOWmbJPkdYZmnwnma5Ne/Lyz3ns3qrT0z30alZTsxnL4b1JkZPFm5VYQVl+rmP+3N8GtqSVyLKIrPHpvFfbUDa01p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395952; c=relaxed/simple;
	bh=5BLqzVlb9eFt0vtMm48SFNFPZzl7igeCN/Q8L6MB0E4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Df5pXAWh1r+JG+lYUXj3LvKK6p0ivdQgcMl2T1MRdT2UaDM0/+HVkiQjP6So44elwhsBTEZF1nmuvT0z3OE1f3R09peZzBu5xtzFPkVbWUk+1FwrYEWKvRjrfi5aOglzB6etywS1J9OBvjgUHfu7c5hfW/WlaeToD2GAhymPpT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXbbKFXB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27566C4CED6;
	Mon, 24 Feb 2025 11:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395952;
	bh=5BLqzVlb9eFt0vtMm48SFNFPZzl7igeCN/Q8L6MB0E4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uXbbKFXBhUQ28QNOH9K8lUnEWjhLfntoZ/nyHoKEjzQe7h2rweUHAvvTQyaY2oYW/
	 XT2R5XlAwiYY3+VoMymX9PO6Bxe1dTFbmykuPm4TI6xsyx+ioUNySypdrWAdhLHDFO
	 LpxbntwhHoFFAvTxH/RkyRrohSmSj/RQdWWxXYXuhQg/3+RrL9osp8HFkKaSwb+UWM
	 lFeVQNOpb5oIyY1sSD9tgb1BkFYK91xPzRI/Qt1kgLRqv2Si4bg6xMUtEr0f9ObaOK
	 w6Im3592R0kb/NRsARpUcujd1PEiS0PxMiAluzPcKI0dRAggGo9vL1aBTPpAed6CbS
	 hqRzbeqFtix3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 27/28] nvme: only allow entering LIVE from CONNECTING state
Date: Mon, 24 Feb 2025 06:17:58 -0500
Message-Id: <20250224111759.2213772-27-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111759.2213772-1-sashal@kernel.org>
References: <20250224111759.2213772-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.16
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
index 8da50df56b079..a950aa780d1f6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -562,8 +562,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
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


