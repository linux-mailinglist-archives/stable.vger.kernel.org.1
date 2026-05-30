Return-Path: <stable+bounces-259022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBLVLwkvG2qU/wgAu9opvQ
	(envelope-from <stable+bounces-259022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:40:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B059612351
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FC63304DA90
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1B53AEB26;
	Sat, 30 May 2026 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ANAQ6zvc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693A13BE175;
	Sat, 30 May 2026 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166329; cv=none; b=QZrFSyEl7u99KlO7+zpE8aJqWq7QyPr1Hn8UzXbu/WQAEYG3HVznKZZJU8q5jIuBhuOvWb3xRVi/2uVeWSjLlqEpoDUWqdNpPU5xLdemfj1YgP9eX6upFW0hndNO5AEel4Ldblun7EtE85A9uI8gPOTXpHzBjIsWu+pU5LrIWVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166329; c=relaxed/simple;
	bh=filUg6dzog9nPQeSZaKprQfby1sqnFqwmcHzzPhBVQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYt+6AS+Mpo8y5wCsLQJnQ4nzfKZYiqOSm9g1ZlDtyWXyjSwNmg8aVOlzkmMJQwRqyDXuYRnkNnDzeyuJigEJ8zJ099RYkBy+ysqn4M2FSMD+8qyu0KhpRPNtDniEIj0LZ9HN0OyFBFir124PwQb4Nhz4xAa9vZYo1a5Chv6J6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ANAQ6zvc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFF01F00893;
	Sat, 30 May 2026 18:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780166327;
	bh=QuHBeht4Nskp18DOb5qb/i+aIe4NDZ5MUFRc1mhLq6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ANAQ6zvc/dQTCK6fBGFNH9avYQmEum/bb54mFiIh0Q9tkAVscHIDCgl1TtQLP0WSx
	 SuEKjvV6WI4Cer9awEz7KE4G32SImY+1xjX5wjrNyZG41jDeOUNn6bfPSYjaEJhZLb
	 emlZm3yu61OebAli/zcolcLgIXI6p5gEGwX3BJqM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 340/589] drm/amd/pm/ci: Clear EnabledForActivity field for memory levels
Date: Sat, 30 May 2026 18:03:41 +0200
Message-ID: <20260530160233.830977642@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259022-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,amd.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 8B059612351
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 5facfd4c4c67e8500116ffec0d9da35d92b9c787 ]

Follow what radeon did and what amdgpu does for other GPUs with SMU7.

Fixes: 9f4b35411cfe ("drm/amd/powerplay: add CI asics support to smumgr (v3)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index 04e2e7e44e7ce..fbca5e798b851 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -1216,7 +1216,7 @@ static int ci_populate_single_memory_level(
 	}
 
 	memory_level->EnabledForThrottle = 1;
-	memory_level->EnabledForActivity = 1;
+	memory_level->EnabledForActivity = 0;
 	memory_level->UpH = data->current_profile_setting.mclk_up_hyst;
 	memory_level->DownH = data->current_profile_setting.mclk_down_hyst;
 	memory_level->VoltageDownH = 0;
-- 
2.53.0




