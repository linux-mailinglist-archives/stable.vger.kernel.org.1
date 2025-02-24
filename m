Return-Path: <stable+bounces-118894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C14E5A41D79
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BCE3B5B57
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07922561D9;
	Mon, 24 Feb 2025 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWCiVebP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D002561CF;
	Mon, 24 Feb 2025 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396082; cv=none; b=soHO1WIycAagb9N93xOkHu7ozUc7qpetpDoiDbU6RJEJy4b9uI6/zOL/kk+1R71reKdm1wQrzC62ssqf6PwCc152X5FEmzj7nNrvDLurDTYpsEAgoDtOKQ0uvFHDeBUPVWbLDFijrsojQdhQ8+NViq1YnxgHr+i2o00E7noJr6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396082; c=relaxed/simple;
	bh=XgZyEzzciGjy60AFUBlWPe47W/YLjQPWkEQxUW590gM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GLQNEQIygO+crhl5z48kJp+wZjZbXZ23o8dvvVa93h47SFdzYZw0yOQIXjXpbWX6rpM1X4ubiJVzWLBGGE7VOjqdSWHpv7P1WAXLeGq+7Xj2+GK3Gln3VdTB55OWIb76aAHkYH/APozOqnljqFMNIySzPhOrx9xtFgvehEPttNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWCiVebP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F26C4CEE6;
	Mon, 24 Feb 2025 11:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396082;
	bh=XgZyEzzciGjy60AFUBlWPe47W/YLjQPWkEQxUW590gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KWCiVebP2DF5IQXLs0tH7/X8UX45ulS0t8KPZ/oGnRYOBcV9oUcd2V0D3AzTQnFGm
	 XvOOAsQ72T8PdM/torTuWT6ukc7nTI8l7alqgB3pNieKNxfWSXZDK9rPtfd8xO1+Y4
	 qjB2mTHXfC3nz9gJ5CbLc+1keebXcLYTww9wDYQvErrdK1LLLOjgM4zF5mkcpUZKp0
	 d4JkIO6dz6MFcvQP241QNoZjsWgl9xnFfth4p3IB+pG8Pm5pxYEbqbv8JViRUxhHob
	 T9lWqMHZYWRGvnySEaglzjbMo8Rzyy5M5RcRX2Oeg1+cR0dvKAtBQxcSOz8pr2+Psd
	 pcJWTl/IbKN5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 4/4] nvme: only allow entering LIVE from CONNECTING state
Date: Mon, 24 Feb 2025 06:21:12 -0500
Message-Id: <20250224112115.2215137-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112115.2215137-1-sashal@kernel.org>
References: <20250224112115.2215137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.290
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
index a841fd4929adc..1ba0c25a7c5b6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -351,8 +351,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	switch (new_state) {
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
-		case NVME_CTRL_NEW:
-		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
 			changed = true;
 			/* FALLTHRU */
-- 
2.39.5


