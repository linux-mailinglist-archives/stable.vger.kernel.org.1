Return-Path: <stable+bounces-221041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKekIjJdo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:25:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B8B1C9056
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EA1231E151B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FCD175A7F;
	Sat, 28 Feb 2026 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GG/WA7IN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90AC175A7E;
	Sat, 28 Feb 2026 17:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301383; cv=none; b=pfUvJfrIbdxycgM3lIqYpHbEUCNB7eMfJrbV+EN2glaHlRdjVY0YttILXu/e7zvElyrzngbNn7r9f+9hwM2GHdtJ8zdLVQJdnOt+iGEc7C4YpVbLUK0FbzhHjoFQVO7UNkJFkOIfg3Bh0t8bF23D8DCBMUzfo8DLppSXj8HTJmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301383; c=relaxed/simple;
	bh=i589gfgfJLmsXeK/N8kpsojyVtoYUm60syTWxpmyJMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8XNkrPI0g+/HVQ2mD3BJVAUg30j+9eV7DWNSqeXHwiQM4nM5Wf62XelIrG2jyw22c94gY/8bINNJl0w4zsdSekkKcp+tnmnaSn5odfvhS1O+2v2yRZA/lkGxxWbbXPr8IcYq1Gc1DTO00KUBmm6RbxZWs5Xh1C/yV+VO79wK6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GG/WA7IN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A2CC19425;
	Sat, 28 Feb 2026 17:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301383;
	bh=i589gfgfJLmsXeK/N8kpsojyVtoYUm60syTWxpmyJMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GG/WA7IND84TEWTtsIHMtxgWWtCoI4bcY9q3TLiheNfZ6GFlsQqsR8M9W8p1z89EV
	 RSHWjGF+WV3DB6uNuCZyKHToQPBrqU/TFhml9n46qA+oTHvtFCm1h3f8xHl1Vb8CnJ
	 yFPaIqpYFqrdzgEE71+pqVQYS8qF2SRVV9eir6M33QOWGhd6F2vhKX5zgmCgQNhzzf
	 KptbSum7W/GplmD/KGM+SKtK51YcOj2HRVDD52UvRDFFmMdtB9C1h1oUaJfHEaz/6u
	 O8TRzqISFS1EE7AdKMwYXZGQIXRttLpqOBA1VH8rNpvJ2ScUUX6UqjzY7K98ECX0QI
	 Ca+07pyx/VWgQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 572/752] media: iris: gen1: Destroy internal buffers after FW releases
Date: Sat, 28 Feb 2026 12:44:43 -0500
Message-ID: <20260228174750.1542406-572-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221041-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,linaro.org:email]
X-Rspamd-Queue-Id: D1B8B1C9056
X-Rspamd-Action: no action

From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

[ Upstream commit 1dabf00ee206eceb0f08a1fe5d1ce635f9064338 ]

After the firmware releases internal buffers, the driver was not
destroying them. This left stale allocations that were no longer used,
especially across resolution changes where new buffers are allocated per
the updated requirements. As a result, memory was wasted until session
close.

Destroy internal buffers once the release response is received from the
firmware.

Fixes: 73702f45db81 ("media: iris: allocate, initialize and queue internal buffers")
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
index ffb50c98a5b6f..aca8f540b0520 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
@@ -441,6 +441,8 @@ static int iris_hfi_gen1_session_unset_buffers(struct iris_inst *inst, struct ir
 		goto exit;
 
 	ret = iris_wait_for_session_response(inst, false);
+	if (!ret)
+		ret = iris_destroy_internal_buffer(inst, buf);
 
 exit:
 	kfree(pkt);
-- 
2.51.0


