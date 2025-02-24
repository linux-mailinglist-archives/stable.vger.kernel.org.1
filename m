Return-Path: <stable+bounces-118890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8521BA41D6B
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D718417D0F7
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6719724DD47;
	Mon, 24 Feb 2025 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/ro2FgA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF1324DD39;
	Mon, 24 Feb 2025 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396072; cv=none; b=Z8V0D9cZVy/CgXWs3oqLslMOsXaHNB76gJ0X9CvGD++KSeyu3e8vuyC3Kqlgu0RNYvoodPF1Vs/t6DVNxCQ/85QvvaGLppJxERNjJkKcVx6nLmxRDE2rdfqjhTSI3lIBJFtBxacWCwaxkU0tm4FLm6vk4/PydM+SU7PmNSM4hWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396072; c=relaxed/simple;
	bh=UPus0+ZeUvqXhZx/PdDail0k2XtlufLXZJTSFurCQD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tvvzh1dXcUP9z8eO5iAz+z2V+T31fyYZAe0YLBbC0bEkqkV+1lTyYlxQ69RdNoTns9fBmkz8oEZAlp02TDs9TdTEn+f43EHh/ESqQePoZRvD3lD9YLOIfY+/ljLtSc0krzspss8lAV7BljANVuRFOrDl/uIXMWknrjH6XeAIbIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/ro2FgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1182EC4CEE6;
	Mon, 24 Feb 2025 11:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396071;
	bh=UPus0+ZeUvqXhZx/PdDail0k2XtlufLXZJTSFurCQD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P/ro2FgAPF4T2r+0MKudRtmMjzJ/0z9E3/0To1KEhBMBqpq0E2MJhb26811NGEvIP
	 MZBHwH709ovoUzxVnjyZpzF/56TTOdusmBWBOCSOt5FLFH4dB8hGoPonhJFKUrwFNd
	 c4QLN9Jh/2YEJg25/KjP1eHrqxOTEKCfhPE2GVp4VhubV7XBCfmSVn8Uqzm8TO1Oys
	 bE4IqTp0Sdj7pDzUjheuqGVEfYt9UKpqFj54t9Xso1DIXUINUXymMjYFfUoBiOVDly
	 OyVpnqbHXaEpwCQWxTZp7K5L8zH/mE8hPgql8LBRKp9ME2XueJ4fLxmW3oI4S/972F
	 kMPS6TOG47otA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 7/7] nvme: only allow entering LIVE from CONNECTING state
Date: Mon, 24 Feb 2025 06:20:50 -0500
Message-Id: <20250224112051.2215017-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112051.2215017-1-sashal@kernel.org>
References: <20250224112051.2215017-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
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
index c739ac1761ba6..975d8ef514e80 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -384,8 +384,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
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


