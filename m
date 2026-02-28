Return-Path: <stable+bounces-221042-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FhqJ31Jo2nx/AQAu9opvQ
	(envelope-from <stable+bounces-221042-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:01:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F551C7C07
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80C4D3150D57
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130E0175A84;
	Sat, 28 Feb 2026 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tx0mDMrL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC20175A60;
	Sat, 28 Feb 2026 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301384; cv=none; b=dAhJG3w65Jg0Jp/O7VsMKuYNwC8LhxANmoukU6lvw6sNU/d/2Oot9XisrKlA8Ym4qJNWNvez2fRt01ytoXQg1gSvjKc4/aKMUDSZQ6bgZcd5Yegsue3Okf9tu5DkycwkEdqJ8bGdlV/jauIhraJa5bcVujWWHUzAPNDi8oVQvcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301384; c=relaxed/simple;
	bh=qV7v9kS6m/6P8WMSZtxiz2ZUxQi/5k/g8YN3QHnzPus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5oLkKtvFxj2VL5yGClZ5Y4rZQHIHV7NR7H8IH+cdx+TM7A7kkiiDydTQSomYFoczWuYQzc5qkThXJnGJh/RchNdLBTFbA/SprKhpwa9IY6uSRVqe2npQR0+J8bRgIviMzLRPpYo3xfJS3n4GtozCkgx6S058hFnDn5uxQ4wThc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tx0mDMrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0283C19423;
	Sat, 28 Feb 2026 17:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301384;
	bh=qV7v9kS6m/6P8WMSZtxiz2ZUxQi/5k/g8YN3QHnzPus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tx0mDMrLl/kcyJqpUd0v9o/qLZbLLrkvl54wm3IScDiGJjjDj8v2wd34L0zl6WWXY
	 dd4YU6fQeWOYSDQomX3O2T7wqBUxubP9bEavwDRY42ww4KoVzSq22dVP+Slx2aQIll
	 jR896tcb5ZM35nZtxsQA6+BpjvsRpXoMDnagdLd/tUEeZfnaN7U/t6stKDPn80Blk0
	 7YnxTgF5MAIrBneNnt5F3tEF6kWYlEFJCzFBkrN2eNmEc+YuxO9uTiI3+x4NNUb5gh
	 fF4/4KS7Ff7bpnNuLkfeSaAnZsqb6xNOFQHCfSgR2FwraTj9+oJOxLyQI6JHhAt0KL
	 04AAR9ojGKNdg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 573/752] media: iris: gen2: Add sanity check for session stop
Date: Sat, 28 Feb 2026 12:44:44 -0500
Message-ID: <20260228174750.1542406-573-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221042-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26F551C7C07
X-Rspamd-Action: no action

From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

[ Upstream commit 9aa8d63d09cfc44d879427cc5ba308012ca4ab8e ]

In iris_kill_session, inst->state is set to IRIS_INST_ERROR and
session_close is executed, which will kfree(inst_hfi_gen2->packet).
If stop_streaming is called afterward, it will cause a crash.

Add a NULL check for inst_hfi_gen2->packet before sendling STOP packet
to firmware to fix that.

Fixes: 11712ce70f8e ("media: iris: implement vb2 streaming ops")
Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
index 4ce71a1425083..5f6e2c9407e67 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
@@ -946,6 +946,9 @@ static int iris_hfi_gen2_session_stop(struct iris_inst *inst, u32 plane)
 	struct iris_inst_hfi_gen2 *inst_hfi_gen2 = to_iris_inst_hfi_gen2(inst);
 	int ret = 0;
 
+	if (!inst_hfi_gen2->packet)
+		return -EINVAL;
+
 	reinit_completion(&inst->completion);
 
 	iris_hfi_gen2_packet_session_command(inst,
-- 
2.51.0


