Return-Path: <stable+bounces-118876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 557E8A41D35
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 740F17A4E52
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C50280A46;
	Mon, 24 Feb 2025 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bE7vv9+4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81EA280A45;
	Mon, 24 Feb 2025 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396030; cv=none; b=XulnaVHkswzReJX2ec24BDgDLNZtO45T2YCS3QZrlOEwdHW6FiLpH/CXHZKzAvehmBs4lEvU+tfWucFHlCWv9gO1ie+dJ93H0sIR6eBD/gyE2Irlwvs/KoLPjUfUygXeqLio0M6DkVpG7pVNvQQn3BEc0aUDvItLW9INhU56+Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396030; c=relaxed/simple;
	bh=ouh81ZkBVvqfkj5b9xjg61LO6S8TmpATsTX1w6fHr/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YvZDPZuAtPNQITZjX108B4MYAZwSch2UFwmYwmW8ycDaIFZk1oMLa556kMBbz6mk3FMcQpvbQSy3WMIQvVsXS75ryFIMZhKvUnpaNAMzVfwwWXGBKKjVk7apa4ZSW5Kwqphq8PfMKQw1DLX6u9tFxAzMxt2gVjaGcaTelvAD91E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bE7vv9+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664C5C4CEE6;
	Mon, 24 Feb 2025 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396030;
	bh=ouh81ZkBVvqfkj5b9xjg61LO6S8TmpATsTX1w6fHr/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bE7vv9+4Ajs1jHuoWse+qhpyOLVgkdfMyb9CmDEuKFy8CLI37JxhIkbo28dGdc9+y
	 20hUImwKzSOtbThVUhGjjCysZVofkgtiRBsjdlB3O7s7Ag7u1G/0DtD5PRsOJ2aWRD
	 Ov0A/5sYzlWYcOSR78QQvX2GCc/kYyP/ckfD2eQRU878gu3F3pMFZOUzcA+VMIUkK+
	 AN0ZHgZTsSMk/zj1wtCbrxcTC+HRSIepRWU0gnk8AA2PYSB5M2b4pd6Gp0LW0h+rdY
	 n0QrQ6fiC5WKJHiSut7DUY4YXkYdv69yGbvCD9mYhj0zfbpjx4Jz1W4kKC02VeA/E8
	 MIf/zgB5/VUlg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 12/12] nvme: only allow entering LIVE from CONNECTING state
Date: Mon, 24 Feb 2025 06:20:00 -0500
Message-Id: <20250224112002.2214613-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112002.2214613-1-sashal@kernel.org>
References: <20250224112002.2214613-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.129
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
index ba76cd3b5f852..6a636fe6506b4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -501,8 +501,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
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


