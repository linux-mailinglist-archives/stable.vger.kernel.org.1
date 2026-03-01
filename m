Return-Path: <stable+bounces-221472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL5FNC2Wo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:28:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0061CAB00
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF132303C594
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EFB280CD5;
	Sun,  1 Mar 2026 01:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnYbxyoH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375CB274B42
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328349; cv=none; b=rVUmxzZe8fLpXpjtMyLyjLSSnNOWmS1YMqJl1cvW7QSkbtdf22//gNKF6o91KLSw08hgp36jpJ30coDn5PVED0gT8uvmj2EVOVU6PrCHl4BHChiRx8F186hHjUZTJPX9pfCgvUDURo13jBOsQGHWMnLlC5QAgY+ALLtIh1ISTI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328349; c=relaxed/simple;
	bh=HPpjGWucnDddhJ0OXqI2c/a3wxC3VfGazekaTwKVfXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K5WeiETH5Q2xXyg+kgQH47CnH04kVTuTPlUeQlsJrTdSePcWRkGm0OXNzWPizLSKliqQwAwl+N+2MTgk+KFw01v00LZhoHx7EjnWBZ4NDZKydOk14ucvt70l/Us+pirg6umuhIjzQ+JLAAfeMfSZ/J759P9Sb6TnG+bcxhGRbW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnYbxyoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739FCC19421;
	Sun,  1 Mar 2026 01:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328349;
	bh=HPpjGWucnDddhJ0OXqI2c/a3wxC3VfGazekaTwKVfXM=;
	h=From:To:Cc:Subject:Date:From;
	b=bnYbxyoHvHNaXStXJlu8CsiMMUaTJ+fR7HZwmAzirm2h6vEQutct+II7Hqn1OoMS/
	 0TczjtR00D7O5qwu3xBd3Qb0vy5qw1KniuA3vdpydQrMPmLhVbJCxB/lmIap4rlR8m
	 REyqVWmo2dFTBSghANm/LrE+VG+jMRnfl5kStUgV4K27DB4SDAlztaIdAi1iu+Iy9D
	 nhdOQM3UiSbNaVUZPwULK0HyD2NkFMNo2AisBaO7JHhYTMCbR+xgSneRrIFG5EcY+X
	 5N2ZUsUWhCl+D2r8USaqcV/lvV2iLmgtte4w0nU13BRT8PoKKTwmbu0gygN4bDbAiI
	 FMhGO5nbzQp/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Sunday.Clement@amd.com
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "drm/amdkfd: Fix out-of-bounds write in kfd_event_page_set()" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:25:47 -0500
Message-ID: <20260301012547.1683022-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-221472-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 2C0061CAB00
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
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





