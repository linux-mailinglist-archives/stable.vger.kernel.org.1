Return-Path: <stable+bounces-224450-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCu4ORgDsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224450-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:40:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8F824B419
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52EEB30952E0
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E0538B7A3;
	Tue, 10 Mar 2026 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pavh6vhQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8965B425CC7;
	Tue, 10 Mar 2026 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142182; cv=none; b=tx5rp5R1j6j2EDwAz7AnbSXvKqB6ceh/I/GLGTDDlFNjdLkEmyn1RF6wS7e76iRMsL1zR1yFvgULOiUJKnGajomYjfh7qvTqg0H8YDPYfQYeNsvm0OmCmS7WpKHJ6VAorQwihTxUc4QPvLguQB9yf2rPI5d6UglFGAJ6Q46jOB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142182; c=relaxed/simple;
	bh=R3vuIlyIF6i6VmvwVzzJLIqHcBAaW6MPUvYXMmb1Aok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdwKF3lDWevNryykmr3bmNqt1ro4exZpLrkFP8HuEWktsyBu5vniC0e6wKGa2fPxe8Ii6QEb4vXKPhP1r4IQPHvvVRSKD9UcAspLxtScANQrth23qwBF6Mwj8ZAJdEU+apsNup0xhptnaVhlDI8Wk9lpNFVaCfzHtZS2CXs6H6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pavh6vhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B74C2BCB0;
	Tue, 10 Mar 2026 11:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142182;
	bh=R3vuIlyIF6i6VmvwVzzJLIqHcBAaW6MPUvYXMmb1Aok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pavh6vhQBDEG0hY+BDHOaSVpLajrpSq0Zsat+L/6J6u0W4potw4Nh6/M04D7ptAS7
	 nm0H4+6MQbGKJFME0mwMD4yNBMzUSbUrQ9bgPKPhK95Cb7s/4OcrbSJSogQ1g66JTf
	 kuFPXid4V9EWHmX3idyIB+VruT14WXlxR7p5AYwLshhPcxZMtCVm1030zjPZupQWeV
	 xPS0C3t1egUek5we0wFbIz8EBSO7ABkAitTonc3zJi1bcI1EGDIWiMQBXZaxeUOQrG
	 V26lPFWSb/SsgymkSqDKoat5AwcSULVrM37WpSztrkz+SxrSWsX2xtsFUkiXrc8sOx
	 H0GgBAH9LIGXg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yujie Liu <yujie.liu@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 271/314] drm/sched: Fix kernel-doc warning for drm_sched_job_done()
Date: Tue, 10 Mar 2026 07:18:50 -0400
Message-ID: <fde6ad6ff7a39c515e252c9d037ef4120be0c0d9.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8C8F824B419
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224450-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Yujie Liu <yujie.liu@intel.com>

[ Upstream commit 61ded1083b264ff67ca8c2de822c66b6febaf9a8 ]

There is a kernel-doc warning for the scheduler:

Warning: drivers/gpu/drm/scheduler/sched_main.c:367 function parameter 'result' not described in 'drm_sched_job_done'

Fix the warning by describing the undocumented error code.

Fixes: 539f9ee4b52a ("drm/scheduler: properly forward fence errors")
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
[phasta: Flesh out commit message]
Signed-off-by: Philipp Stanner <phasta@kernel.org>
Link: https://patch.msgid.link/20260227082452.1802922-1-yujie.liu@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index c39f0245e3a97..3f138776d35fb 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -361,6 +361,7 @@ static void drm_sched_run_free_queue(struct drm_gpu_scheduler *sched)
 /**
  * drm_sched_job_done - complete a job
  * @s_job: pointer to the job which is done
+ * @result: 0 on success, -ERRNO on error
  *
  * Finish the job's fence and resubmit the work items.
  */
-- 
2.51.0


