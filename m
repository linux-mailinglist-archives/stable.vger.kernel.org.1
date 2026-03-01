Return-Path: <stable+bounces-222148-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGmLB52eo2k3IQUAu9opvQ
	(envelope-from <stable+bounces-222148-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:04:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 956E61CCCB9
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B0BB30FDBF8
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92550309DD2;
	Sun,  1 Mar 2026 01:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psnmTdVg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B6E3090C6
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330020; cv=none; b=ABIsvlQUxCbLITQByyYCyn3DsCICJ6PypLoxaQxkJ9aaicVaTnqIzjRSJW9Beex8ZNt6+/ZnjzvUuqPMKlC8wCpxb2xXF2gpeTfpqqh+o+0Bg2QXCfHZtXBrkE/lK+/H2M4hHStb+rn/CzLt0yxjinseR2LBIm7JLjYbvtkNPsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330020; c=relaxed/simple;
	bh=xin4LD1zkcTUk3xfa5v9+DBki7RWsCYixy+PVV9CGZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dehCiqMsAGoNlib6LY52Bz/f3d+/C43M4T3nWwFyb/SKKhmKx8TzGQW80+0SmmaPr2WHV6/jz4yH2qkR2h954CbWcGmnIBoDhLWWOynqLmdNsaOGVbq374Pee8YGvjOOh+YYlPu4DN/vepeiS4Gz4KD1B3EWzVp0G+fCE0R7Rhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psnmTdVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FB8C19421;
	Sun,  1 Mar 2026 01:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330020;
	bh=xin4LD1zkcTUk3xfa5v9+DBki7RWsCYixy+PVV9CGZo=;
	h=From:To:Cc:Subject:Date:From;
	b=psnmTdVghd7fgVBnGTUmeID2sKs0dnSkdXicoffOBIpCxLoMBDPibfhyKbOYhMahK
	 DZwsKduTehduGvTOq6bSMB65dV1A9JvJdr//vq54ley2rIY+D4ADAeAAVsO0t194Xy
	 o2HA/RsgZ+RW3PC0wFg0UhkERUmtkP8fLMG4cfOj/YM4jVdgrDoMFAJyku0zvFbfmt
	 bI3b4Jzm5uFtk2+9msCeulul9/AbQfV1GDoGuHuz30HovIw59XPAB2WnKgRq3kIiaQ
	 wLxi8BQ+j7pOcWHNg4V/o53tFe4dL0yUyQUxohiIhqPmlgP3DK8PIYZwmXfcX4bYD/
	 Z2ztvnfv87PIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Sunday.Clement@amd.com
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "drm/amdkfd: Fix out-of-bounds write in kfd_event_page_set()" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:53:38 -0500
Message-ID: <20260301015338.1720466-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222148-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 956E61CCCB9
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8a70a26c9f34baea6c3199a9862ddaff4554a96d Mon Sep 17 00:00:00 2001
From: Sunday Clement <Sunday.Clement@amd.com>
Date: Mon, 2 Feb 2026 12:41:39 -0500
Subject: [PATCH] drm/amdkfd: Fix out-of-bounds write in kfd_event_page_set()

The kfd_event_page_set() function writes KFD_SIGNAL_EVENT_LIMIT * 8
bytes via memset without checking the buffer size parameter. This allows
unprivileged userspace to trigger an out-of bounds kernel memory write
by passing a small buffer, leading to  potential privilege
escalation.

Signed-off-by: Sunday Clement <Sunday.Clement@amd.com>
Reviewed-by: Alexander Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 1ad312af8ff0c..13416bff77636 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -331,6 +331,12 @@ static int kfd_event_page_set(struct kfd_process *p, void *kernel_address,
 	if (p->signal_page)
 		return -EBUSY;
 
+	if (size < KFD_SIGNAL_EVENT_LIMIT * 8) {
+		pr_err("Event page size %llu is too small, need at least %lu bytes\n",
+				size, (unsigned long)(KFD_SIGNAL_EVENT_LIMIT * 8));
+		return -EINVAL;
+	}
+
 	page = kzalloc(sizeof(*page), GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
-- 
2.51.0





