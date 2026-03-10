Return-Path: <stable+bounces-224124-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPYuDxYAsGmoeQIAu9opvQ
	(envelope-from <stable+bounces-224124-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:27:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B9424AB8C
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C97E3239863
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F349A3876A9;
	Tue, 10 Mar 2026 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDDYwd5g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E2A387571;
	Tue, 10 Mar 2026 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141256; cv=none; b=Gi6HSU8DLJFVMx/2Zmwq8g32UVCGWOcKN+anzYFI5ikGhUA5NA2IsR+Do3YdllHYl0O1yd69xbJEfcc7Lg5MLrkPAMEgj2ca/BZ5PC5ZrFQl3lCRwmCmIhxNayGilt+M+CH3P3o1deV3kvMbDs9YSaGf8kpkJTzlnV6KUxWgteo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141256; c=relaxed/simple;
	bh=F2OXlaNFb4iRdy4F8EX9khhWAkCfnZ+AYQq25AHg4eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoNTPclaURbQlpuL82BT6zF+2tTKHWs/hO1pflzuWa1kxmNTVSBoHbALW8SNnZ/a+/4NBqDkw8y5AB02HBRhalU71NOjLh8zcpDYzkHRjFarJsLnPFcQlLNZgKsnxGIiYwlkYsz/HwDT09+OmBxiXj4NKj3owTutVUnwsJJ2zXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDDYwd5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2D3C2BC86;
	Tue, 10 Mar 2026 11:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141256;
	bh=F2OXlaNFb4iRdy4F8EX9khhWAkCfnZ+AYQq25AHg4eQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KDDYwd5gOGy5Pzlpw5IncAqwrK2TH4Eqkfpu2Hj/hd2UOzcyIChj13chSWeSwSybt
	 +lz6aB+//cYqI1OWdnhABvTSu379zQ6iFfy5haXE4UHeia+/TsWV6f3YVItxoiLTGt
	 f8qN5OUaiA+PJ+7ufV4R6i/MtW8sLZoIQoX/tEKjKwxd2Cw6w6YjWdwLrNkAKYhwe6
	 NDCL/HPYAyvhhoPTBaEldWArwtqJTm++9IhPn4DU/Rj34eu81o8+318lG72uM027dM
	 z6bcNX7L1GuNuQViXnQt1E6+GLTbxCenNZEtXvO9PhOtUAd4W344NdpaKyc6YuYAJD
	 Ts6QBBKsOF4Aw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yujie Liu <yujie.liu@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 259/311] drm/sched: Fix kernel-doc warning for drm_sched_job_done()
Date: Tue, 10 Mar 2026 07:05:06 -0400
Message-ID: <8c73dda86566abd54b5b46b185fb91927e780106.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B4B9424AB8C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224124-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
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
index 1d4f1b822e7b7..2d70c06113cfe 100644
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


