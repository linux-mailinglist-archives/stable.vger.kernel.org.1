Return-Path: <stable+bounces-140644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2D2AAAA72
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC3E9836D8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC44B379409;
	Mon,  5 May 2025 23:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofOanrv3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52FE365709;
	Mon,  5 May 2025 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485714; cv=none; b=pVe+EF257Oaxbae73h7cNQdT4jbfS5wm8upfA7mhZQsTbkFKdeWm/mfMUbZfxMmIv+BQy43sjZ8dW+dHr5IuVbaVzOO4Gn2ix74wzIpaxqRGVJjak9eLu86Mk00fIgvjK8ta9o6htCDkw9uk3GuTJrlBbDvM794hxar5dgmJdMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485714; c=relaxed/simple;
	bh=QfzK3qyAlNt3rNQwwtvAXu5oLER/vfNYNL3KtQqHp0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pbO6XOthMQW/fx7q9Llk2WF/LbiTTQQceuiHXlDOiYSur+AG6eKrxakPyS6U1bCeompHVmjZm43F4axpTvP2a0Zp99O+gNCoLN0a1O5FAqVBs4lVRLSpM5Hd/+TEH+lhc4qMHeRa+QrrDtqdaTxts2EVAwPHdr3DUrJHlDl4dw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofOanrv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7C2C4CEED;
	Mon,  5 May 2025 22:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485713;
	bh=QfzK3qyAlNt3rNQwwtvAXu5oLER/vfNYNL3KtQqHp0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ofOanrv3bMxlR1ALy+coLSfd5qUfcCVZ+gVoNdV8QnyZwFELF9J6lfsFd81ax5CdQ
	 r0qkBv/hJdmbLTKXVFPbL25muKEkCdiHdN2mV6RSVO/dJifetl6lMyxKyfbNZNjuON
	 hg2befnIQoxmpK1hTQvTaAL1FHZfUJpNVQZJwCT5qJ/8ZzAx7eG3XrL7+vveNXiUfW
	 vjRyx9Qbg45dzFdVS6amHXECGDzn1Wp0ktL7j3IOL+YpOlN8OxbvRmlJviFj/IyonL
	 FCAw2aAhzil2WH3TXcWGu1HJgUnmDqi5KOKPL/rPNzsFvygGjCg/sFv/ndsibuX4GT
	 tstAihzVpZ/FA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Marcin Bernatowicz <marcin.bernatowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 439/486] drm/xe/relay: Don't use GFP_KERNEL for new transactions
Date: Mon,  5 May 2025 18:38:35 -0400
Message-Id: <20250505223922.2682012-439-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Michal Wajdeczko <michal.wajdeczko@intel.com>

[ Upstream commit 78d5d1e20d1de9422f013338a0f2311448588ba7 ]

VFs use a relay transaction during the resume/reset flow and use
of the GFP_KERNEL flag may conflict with the reclaim:

     -> #0 (fs_reclaim){+.+.}-{0:0}:
 [ ]        __lock_acquire+0x1874/0x2bc0
 [ ]        lock_acquire+0xd2/0x310
 [ ]        fs_reclaim_acquire+0xc5/0x100
 [ ]        mempool_alloc_noprof+0x5c/0x1b0
 [ ]        __relay_get_transaction+0xdc/0xa10 [xe]
 [ ]        relay_send_to+0x251/0xe50 [xe]
 [ ]        xe_guc_relay_send_to_pf+0x79/0x3a0 [xe]
 [ ]        xe_gt_sriov_vf_connect+0x90/0x4d0 [xe]
 [ ]        xe_uc_init_hw+0x157/0x3b0 [xe]
 [ ]        do_gt_restart+0x1ae/0x650 [xe]
 [ ]        xe_gt_resume+0xb6/0x120 [xe]
 [ ]        xe_pm_runtime_resume+0x15b/0x370 [xe]
 [ ]        xe_pci_runtime_resume+0x73/0x90 [xe]
 [ ]        pci_pm_runtime_resume+0xa0/0x100
 [ ]        __rpm_callback+0x4d/0x170
 [ ]        rpm_callback+0x64/0x70
 [ ]        rpm_resume+0x594/0x790
 [ ]        __pm_runtime_resume+0x4e/0x90
 [ ]        xe_pm_runtime_get_ioctl+0x9c/0x160 [xe]

Since we have a preallocated pool of relay transactions, which
should cover all our normal relay use cases, we may use the
GFP_NOWAIT flag when allocating new outgoing transactions.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Tested-by: Marcin Bernatowicz <marcin.bernatowicz@linux.intel.com>
Reviewed-by: Marcin Bernatowicz <marcin.bernatowicz@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250131153713.808-1-michal.wajdeczko@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_guc_relay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_relay.c b/drivers/gpu/drm/xe/xe_guc_relay.c
index ade6162dc2598..0e5b43e1518ea 100644
--- a/drivers/gpu/drm/xe/xe_guc_relay.c
+++ b/drivers/gpu/drm/xe/xe_guc_relay.c
@@ -224,7 +224,7 @@ __relay_get_transaction(struct xe_guc_relay *relay, bool incoming, u32 remote, u
 	 * with CTB lock held which is marked as used in the reclaim path.
 	 * Btw, that's one of the reason why we use mempool here!
 	 */
-	txn = mempool_alloc(&relay->pool, incoming ? GFP_ATOMIC : GFP_KERNEL);
+	txn = mempool_alloc(&relay->pool, incoming ? GFP_ATOMIC : GFP_NOWAIT);
 	if (!txn)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.39.5


