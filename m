Return-Path: <stable+bounces-223903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDKGNA79r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:14:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BE524A31D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 741F430C2BCA
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBF1387363;
	Tue, 10 Mar 2026 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6xtjPT0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2817386454;
	Tue, 10 Mar 2026 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140801; cv=none; b=jdXD5GBLzwiImCMxZ5z1m8/D27H8GxuRiQf4S081M2iXhmwmrASBxrpsu1emKRavLZUNpo1sbA2QpiXN9l9n5ZBoz0JsRtKZVO/WZ89IOlZiBaAUov2d2IpO5uH4hf6XRo6nBLA1R8jlLErY3USOeiwJI81BjuJ9159rf5JmTv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140801; c=relaxed/simple;
	bh=bhxoSojcSM7YXcD3Ol3IJ+Qy1YgCrzWixgyDTu+VSN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hadz/61oB5L1G9GTeM0yrBz+rtJbYAhgDYqKUzYIq0NzYMe58vD8OvlRb8M7Kh+FLeSxQ6uAG6sym7Jhepah5+1Yddxpl6br1Ti0wpqlsNzN6ZptSXjTEVJ0/ofYqiwU+jNLVAN8WG/3AEc35Wz5ZIQI8KHSOpwvz4fc+hG+7VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6xtjPT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E7AC19423;
	Tue, 10 Mar 2026 11:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773140801;
	bh=bhxoSojcSM7YXcD3Ol3IJ+Qy1YgCrzWixgyDTu+VSN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6xtjPT0m7p0N3kX1Zem4QWIsdCshnHe9zhsgyhygV22oAIgV7lZ7LJ++AlyiCSbl
	 wbs6SN/7GC5Kdjmrtj0SqHNxvFaV1Jxwe/siVgP3n/ArRwva1Cj25VqNTSOfaUFYP0
	 Mqhi2D9WcFfTou3OhzElYxtwRaAG1XruVbkayhz7bL9xnYNZ60CD6iSfxC08J81R23
	 9+oxG1XjbbfR61RtZSCPwiIj5NJ4HZ5IlyAADbpfCXyjujpGXR6I86DjrhGnNEIJg5
	 8R0Hpg3Z1xAATam/lguJdszt8gzVJ1+9T2YMHR5cq71oxUdD8oByHEToXc3qcS50Od
	 e82rbSpFOW0mA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lizhi Hou <lizhi.hou@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 039/311] accel/amdxdna: Fix out-of-bounds memset in command slot handling
Date: Tue, 10 Mar 2026 07:01:26 -0400
Message-ID: <426a56037508d51dc3d8c7d5ce607028ceeb6a57.1773140655.git.sashal@kernel.org>
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
X-Rspamd-Queue-Id: 87BE524A31D
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
	TAGGED_FROM(0.00)[bounces-223903-lists,stable=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Lizhi Hou <lizhi.hou@amd.com>

[ Upstream commit 1110a949675ebd56b3f0286e664ea543f745801c ]

The remaining space in a command slot may be smaller than the size of
the command header. Clearing the command header with memset() before
verifying the available slot space can result in an out-of-bounds write
and memory corruption.

Fix this by moving the memset() call after the size validation.

Fixes: 3d32eb7a5ecf ("accel/amdxdna: Fix cu_idx being cleared by memset() during command setup")
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://patch.msgid.link/20260217185415.1781908-1-lizhi.hou@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/amdxdna/aie2_message.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
index d69d3afcfb748..a758c11a05a9c 100644
--- a/drivers/accel/amdxdna/aie2_message.c
+++ b/drivers/accel/amdxdna/aie2_message.c
@@ -656,11 +656,11 @@ aie2_cmdlist_fill_npu_cf(struct amdxdna_gem_obj *cmd_bo, void *slot, size_t *siz
 	u32 cmd_len;
 	void *cmd;
 
-	memset(npu_slot, 0, sizeof(*npu_slot));
 	cmd = amdxdna_cmd_get_payload(cmd_bo, &cmd_len);
 	if (*size < sizeof(*npu_slot) + cmd_len)
 		return -EINVAL;
 
+	memset(npu_slot, 0, sizeof(*npu_slot));
 	npu_slot->cu_idx = amdxdna_cmd_get_cu_idx(cmd_bo);
 	if (npu_slot->cu_idx == INVALID_CU_IDX)
 		return -EINVAL;
@@ -681,7 +681,6 @@ aie2_cmdlist_fill_npu_dpu(struct amdxdna_gem_obj *cmd_bo, void *slot, size_t *si
 	u32 cmd_len;
 	u32 arg_sz;
 
-	memset(npu_slot, 0, sizeof(*npu_slot));
 	sn = amdxdna_cmd_get_payload(cmd_bo, &cmd_len);
 	arg_sz = cmd_len - sizeof(*sn);
 	if (cmd_len < sizeof(*sn) || arg_sz > MAX_NPU_ARGS_SIZE)
@@ -690,6 +689,7 @@ aie2_cmdlist_fill_npu_dpu(struct amdxdna_gem_obj *cmd_bo, void *slot, size_t *si
 	if (*size < sizeof(*npu_slot) + arg_sz)
 		return -EINVAL;
 
+	memset(npu_slot, 0, sizeof(*npu_slot));
 	npu_slot->cu_idx = amdxdna_cmd_get_cu_idx(cmd_bo);
 	if (npu_slot->cu_idx == INVALID_CU_IDX)
 		return -EINVAL;
@@ -713,7 +713,6 @@ aie2_cmdlist_fill_npu_preempt(struct amdxdna_gem_obj *cmd_bo, void *slot, size_t
 	u32 cmd_len;
 	u32 arg_sz;
 
-	memset(npu_slot, 0, sizeof(*npu_slot));
 	pd = amdxdna_cmd_get_payload(cmd_bo, &cmd_len);
 	arg_sz = cmd_len - sizeof(*pd);
 	if (cmd_len < sizeof(*pd) || arg_sz > MAX_NPU_ARGS_SIZE)
@@ -722,6 +721,7 @@ aie2_cmdlist_fill_npu_preempt(struct amdxdna_gem_obj *cmd_bo, void *slot, size_t
 	if (*size < sizeof(*npu_slot) + arg_sz)
 		return -EINVAL;
 
+	memset(npu_slot, 0, sizeof(*npu_slot));
 	npu_slot->cu_idx = amdxdna_cmd_get_cu_idx(cmd_bo);
 	if (npu_slot->cu_idx == INVALID_CU_IDX)
 		return -EINVAL;
@@ -749,7 +749,6 @@ aie2_cmdlist_fill_npu_elf(struct amdxdna_gem_obj *cmd_bo, void *slot, size_t *si
 	u32 cmd_len;
 	u32 arg_sz;
 
-	memset(npu_slot, 0, sizeof(*npu_slot));
 	pd = amdxdna_cmd_get_payload(cmd_bo, &cmd_len);
 	arg_sz = cmd_len - sizeof(*pd);
 	if (cmd_len < sizeof(*pd) || arg_sz > MAX_NPU_ARGS_SIZE)
@@ -758,6 +757,7 @@ aie2_cmdlist_fill_npu_elf(struct amdxdna_gem_obj *cmd_bo, void *slot, size_t *si
 	if (*size < sizeof(*npu_slot) + arg_sz)
 		return -EINVAL;
 
+	memset(npu_slot, 0, sizeof(*npu_slot));
 	npu_slot->type = EXEC_NPU_TYPE_ELF;
 	npu_slot->inst_buf_addr = pd->inst_buf;
 	npu_slot->save_buf_addr = pd->save_buf;
-- 
2.51.0


