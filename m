Return-Path: <stable+bounces-118815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 915ACA41C99
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D5D7A982C
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A962641D8;
	Mon, 24 Feb 2025 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRv/rhdf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDC0263C9E;
	Mon, 24 Feb 2025 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395878; cv=none; b=EdJ8S2uN/Qn9Sar8E9/Kd+QhT2jrlOFbAaI2EoBtE/x4OtNCENs7386DTx96TpCXu8UrS5d31EqhmtpyiKjbJ946/p1v6POczlr/sHsYhDsDQsTQPsP16KoIH8HhlRSfMBj5dkATY/5kbuN7KTzqZTN1N7Mnm7y/F4ZrpiwL9IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395878; c=relaxed/simple;
	bh=dqPuA9v4dNcw/imLKMmpcyLGTWuXEGp8WqzvpE77BxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=joSRac+wCjhlAr1jsV/RO8nHwx65/BiNCjA41XpMeysao02xs/OeYh2v2M8PTRSMpaYqWCMnwaymyWiFjSIDgNmkhRiZXWljaJ0YrYo6ff4hSxNwq2Kxn+LxZADE6kFv8hfwuZEN8uMGChN9bqwWZUGqkwyuf8DIkdJMgGWNY00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRv/rhdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71B2C4CEE6;
	Mon, 24 Feb 2025 11:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395877;
	bh=dqPuA9v4dNcw/imLKMmpcyLGTWuXEGp8WqzvpE77BxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gRv/rhdf1SjMeTipnptVZsT96UQQuylA/QxkXecCo78d9SyV6oMCeTdRNrLt8Mext
	 Vhzjd1iDwy2o1508FBfrA7Nka+Kgdl9vvs9rrx7hR326mxdYwyONfvQRK6O3uvo6mH
	 YexruldfFLUORhF1K2NZwU2Ulvx9lLwNPHjT16Fwz3y3OOVkn2xYYbSlj/133IlhEo
	 g5tDFdNTZb1GJT+gC69kAQ0Y/7ODxhdom1ttjafaqCewXXMPHf3WdaSvvUZeuOeBbn
	 QnDmGkmDtNaIxhyrneSp9b9i2TfZa8m+2h0UMdjVcs+5EJCyLZUunn0WpATdwvxRzm
	 or808WViWnLiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 31/32] nvme: only allow entering LIVE from CONNECTING state
Date: Mon, 24 Feb 2025 06:16:37 -0500
Message-Id: <20250224111638.2212832-31-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111638.2212832-1-sashal@kernel.org>
References: <20250224111638.2212832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.4
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
index 46e04b30f6425..cf0e7c6d5502b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -564,8 +564,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
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


