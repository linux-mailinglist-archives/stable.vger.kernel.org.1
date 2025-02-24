Return-Path: <stable+bounces-118883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE0DA41D43
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF072188A532
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A40221F3B;
	Mon, 24 Feb 2025 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/oRhE62"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B189221F31;
	Mon, 24 Feb 2025 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396050; cv=none; b=em/uiN+SzBLg8df2UfWPQ+fgl5gCoyLTiYAUAoqOBBtLnConzhtZGu/OJoHCeKaxByv+WjcbSYLXBzZFqy1Pv0NnCq7pTrDVKaaDBrGGDGQBUg9gZmxcTxpw6dhdmBJBppUoLHE0oxF6gnZ9otbdsipH3YnwI2gdu7ooF1GWpMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396050; c=relaxed/simple;
	bh=tVJjRg9ubQDrUmifk852LmaOIyncW3ntt0T+jOsIDhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LcKhaQFkgidrIuoPpDVnHQimZwzhCL2JnCIocyXvzCJ2+/QmZgBBXLdTohTfqXSHiEdn5BmeVygParXOnUt9kzcL/6Ak6VxWrPS+Cdk6V3VnkhL4m2SPBacJFkm89OEEwb7PYL9ZLHuMQOhoqxinf7UmgqaJX8TwR4jIHss9NjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/oRhE62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7686FC4CED6;
	Mon, 24 Feb 2025 11:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396050;
	bh=tVJjRg9ubQDrUmifk852LmaOIyncW3ntt0T+jOsIDhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/oRhE62Z+ou/Bgju7cZnKX24qJzu3ob0kNOXuDExIQkN2NBVYdk9OtJ7Oqd2NGPc
	 FzHTguYOh8Ary4HFkjDQZlPNDxU/muqcKBhekd2aGRibs5s7jDm/CYN2Ydudegol61
	 kjBwqyzaH2me0/1+YNrclmU1ikePtTXqMW91dz4d3QKLFror6GHnxFMR/a67IjD5xc
	 dqnya9bAD79YiLNFCPdL/Yn2KQutdS1P/A0XGAuE0pM8aIEKlDSC0Dz8IcO1LKtlSk
	 CUlOOg1tEl3ItbRKDrAizekY9Txsf8RTZDWoV5NPef0mt+6ZEzU9l3XXCdRXh4U+3F
	 jJmNRCfoOHyFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 7/7] nvme: only allow entering LIVE from CONNECTING state
Date: Mon, 24 Feb 2025 06:20:30 -0500
Message-Id: <20250224112033.2214818-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112033.2214818-1-sashal@kernel.org>
References: <20250224112033.2214818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
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
index 93a19588ae92a..a3293d12d8841 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -444,8 +444,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
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


