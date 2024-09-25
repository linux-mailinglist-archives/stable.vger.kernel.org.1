Return-Path: <stable+bounces-77270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A66F985B4C
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B619286D86
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C358E1BC085;
	Wed, 25 Sep 2024 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoQyoMVY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAD01BC078;
	Wed, 25 Sep 2024 11:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264888; cv=none; b=ZXF2lVxwjeRFu534SE+Q4OLKplFNfcgvGBxMuXrRyJVdd7PaNLy1g3KXkOSwyQFzMxRVLOKeVyQpTlV1I0c+v2KsyH61GHQJUaeJQv5Qe09x07KSnr5LYIuZSeXjysvG06Wr4RecgsqceeO9Zj06eof9AtuJT9JmIiTIb4hYNvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264888; c=relaxed/simple;
	bh=ARkVUnORyoSpvvi/osT4jVUA26xo6uc7NC7M7vXNZhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usa2K4uKXRvpGd2f306C5QbHmz9YdXNuXQu2wY1JU4uSc35Vu2ZVVpt/+vVueMcM5tQwvdR9EfI0UgzaBbemmnhRGjH7jUk3bGwkc7oSr/TT4yyFKSDvHNs8l29Uy1eROjRyqqoBpYiRc+SzCBX2Dre0K8xDgj6N7EuBqgjIrkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoQyoMVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA4FC4CEC7;
	Wed, 25 Sep 2024 11:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264887;
	bh=ARkVUnORyoSpvvi/osT4jVUA26xo6uc7NC7M7vXNZhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AoQyoMVYZNn4J39X69YkObNyaqMfPOCLP5uPuSmmStSD2WQcMQ72CW8FnZpaJ/Y6W
	 6A62kPGH0b9TGnzooWAQuzdJCBuL2G0QB9PAWJjUTZzX/0MJkCKSIvK89E2n08aXth
	 /eudl/IinpxFqHi99QrMO+gf8iG2m/cKcBh0o8nwB4B4JIeMeWdVZYz3T4U8qYOoi0
	 3LOvprOoLNMSf8sBMTCQkQbVsWBhS4l5unRZNenreildNOQkF9GB9ihXt6QtV8piF0
	 Z2a1U5gKO9RXio9ZdMKgp9IaZbPrDz+RVg2/mNCFFZ9Bl0H6eRKyLGIX+4ouUAC/9w
	 k/hN2jtUm0srA==
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
Subject: [PATCH AUTOSEL 6.11 172/244] drm/amdkfd: Fix resource leak in criu restore queue
Date: Wed, 25 Sep 2024 07:26:33 -0400
Message-ID: <20240925113641.1297102-172-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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
index 36f0460cbffe6..e0f19f3ae2207 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -988,6 +988,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 		pr_debug("Queue id %d was restored successfully\n", queue_id);
 
 	kfree(q_data);
+	kfree(q_extra_data);
 
 	return ret;
 }
-- 
2.43.0


