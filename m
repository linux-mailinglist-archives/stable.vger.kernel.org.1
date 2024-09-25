Return-Path: <stable+bounces-77650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0E4985F7F
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8EB1C2134D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0138F19048D;
	Wed, 25 Sep 2024 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jpthn2xb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B339319046E;
	Wed, 25 Sep 2024 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266583; cv=none; b=rWmzXaBy9LBSWOqv7zdscEkWeWTvZYyPLwKaos1I3EwGJjFE7vqGtNSRSzxkuAklIV/AkSAM0m9+iw/pGnLL3g97IkNNijQTUb2DzuoT5iwN9GH6EecYnIIKpv8EZGo+95Bw/BSmPJgq/CE5Nl8M+rybZ2wNvZH2nFB6VEGodTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266583; c=relaxed/simple;
	bh=WVbg0f0njlEu1mtGwAixfC3leEq04t5oI9+Nz38LmmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AU61ELTwr5HPnCUU7l786XeQr+OQQBTusBOTYhRMOr/+0mTjduz7iGFBJFqq2nlDI/NZ3RMzVsV+e9wLhBlc2sA54dY7gczb2nq7ywcG8rjUaW862MoFDLJVulvO3wKb6S+B9aflyR9ZNbYL7T66oJQgYgVjKB3x3rQfJhR0+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jpthn2xb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C7EC4CEC7;
	Wed, 25 Sep 2024 12:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266583;
	bh=WVbg0f0njlEu1mtGwAixfC3leEq04t5oI9+Nz38LmmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jpthn2xbzoe6dwT9DZ+wfsl3YMzZBTCmU8qQQNvLffiCAi0+FLVB+tPQfc96ChO4m
	 MinWuvibyMcafLifLfRKFQilUX7EQT+i2/CQtQK/nL7WyHQ2HmfQY0crlSb6jYBqnL
	 YJlecGh4PUqj/odTIKiDurohB7qg8w8eeBEw0LNCNj18vq/WfSaUqq0LCSnGYXxHNe
	 bOYl9mlqtOvuQYrcJXLlOqt3ozxiT4N2N3txK2v0EwYzD+KshYzK6texbI+8p1WXJP
	 2lhUlGVKfeR0eZ+tiInMgnCbTsdiscai0D95IiHh5tmN5a/y6Rcaozvllxfm2RPCyv
	 MVFp+2t/l+tag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jesse Zhang <jesse.zhang@amd.com>,
	Tim Huang <tim.huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 103/139] drm/amdkfd: Fix resource leak in criu restore queue
Date: Wed, 25 Sep 2024 08:08:43 -0400
Message-ID: <20240925121137.1307574-103-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Jesse Zhang <jesse.zhang@amd.com>

[ Upstream commit aa47fe8d3595365a935921a90d00bc33ee374728 ]

To avoid memory leaks, release q_extra_data when exiting the restore queue.
v2: Correct the proto (Alex)

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index dbc75ca84375a..0583af4e84fa3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -982,6 +982,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 		pr_debug("Queue id %d was restored successfully\n", queue_id);
 
 	kfree(q_data);
+	kfree(q_extra_data);
 
 	return ret;
 }
-- 
2.43.0


