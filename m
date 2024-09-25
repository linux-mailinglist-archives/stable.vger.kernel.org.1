Return-Path: <stable+bounces-77489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A07C985E93
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6ECEB2D9D7
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4410418C35C;
	Wed, 25 Sep 2024 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7/9b88/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33741B3F31;
	Wed, 25 Sep 2024 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266003; cv=none; b=lmFNEO8tq41oXCzZOjusXkAjSNSvyOZicqS5n+wum5vCDlwl5bUi0xduG5wiYWMGA4N6IrgfCn0eT4WemxLJs0TDgSYw/T4Tlz1ka2E6WLccsBxIPR1svUFm9wKlo+8lIAFIHFbOYGTS6vILPLeItK6FzQDkV6VH1yKW4o93D68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266003; c=relaxed/simple;
	bh=L8nbUujUq+HFXFK4TqUUUqoehFOYDd3DuS5WzfrqGYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alWIo9n0JZ9dkiqZ1SigvM2wMg3jwxyr9LXTpG06lSC7tVJ+NfADCveQxltEzv5HnR+hee3/alMGK37gGnu+WvOans+nIjglsqo+4fojKeAoLf2B1X1bIpP61mnDEm42kVksxIJCXr4mYT3LNjocqZFZyP5eR/XPih1ZjgeX5ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7/9b88/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C7CC4CECE;
	Wed, 25 Sep 2024 12:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266001;
	bh=L8nbUujUq+HFXFK4TqUUUqoehFOYDd3DuS5WzfrqGYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n7/9b88/HdXy4WRE7IvOOiPegpFMtutZFbqBHtWJBPGAiSmbpDm0bUvIZ7p78HSDB
	 wHSzJRrwohgeeWw9qBfzkb6a3+bezQTtK64bqMkaMYCkcnZjQGawW7i7IQ0+GQLtsR
	 2Rmzaz4n1rrq531pBGzHQEvdmEPXySSd5ZZ3C+tsTiYAOWUOnsRAU9E3J3yFSCzH6+
	 iO5NHNdG2fbEhK7faJDomCBBMP6J1BRdYXLMvPmKZkQn84h0yXLnXOrQa/3DgvniZJ
	 qIAaelCxmr7akFj/kFrB2Wrob6owMDgPJ+gDdF2btBGVtDhynH7YazyIhJlfiUMiLJ
	 ydz0QXsLRsBKQ==
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
Subject: [PATCH AUTOSEL 6.10 144/197] drm/amdkfd: Fix resource leak in criu restore queue
Date: Wed, 25 Sep 2024 07:52:43 -0400
Message-ID: <20240925115823.1303019-144-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index c97b4fc44859d..db2b71f7226f4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -984,6 +984,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 		pr_debug("Queue id %d was restored successfully\n", queue_id);
 
 	kfree(q_data);
+	kfree(q_extra_data);
 
 	return ret;
 }
-- 
2.43.0


