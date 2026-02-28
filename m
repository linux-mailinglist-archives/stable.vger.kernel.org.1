Return-Path: <stable+bounces-220718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCMIDFFUo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:47:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5934F1C886A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B3D331A5BC7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B485C3FD8CF;
	Sat, 28 Feb 2026 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJrlSx02"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783493FD8C7;
	Sat, 28 Feb 2026 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300598; cv=none; b=TDOabG9G0d8kc3IN+acvmQvzHsCQY2EAIHHgh9uxW5WuC9WWnEr5IetT5cQ0zxvTI/+/NgrYO/Ql8AUwgB/t/uOr5R9hDOxcy8FDDz83oc2bGPX+h4hw2E8EPe+vJtPDjq9WDQ2YHVSJnGiGwVWM3p7AL1yTLnMc1+xkPdOI2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300598; c=relaxed/simple;
	bh=n0PXaKyAqNUZPAHd67/QmjvwzkMs1oyIMBBXVPbsPcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixF3HyncCzvxSHFh4+FdE+9aYZ6s1KiHbRS7UShItg6XSDiMd0pCUjP745pL+ert/zz1ujVmKPdrP9PTxNRnUY0DGhAfF8LeAE0Yzg6GG2FmryVRhfkAqEK+Mdx19VvZCJ3OMzXgWDESHllXwksHq7j6NaTCUOSd9bjjVL96qUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJrlSx02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EB3C19424;
	Sat, 28 Feb 2026 17:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300598;
	bh=n0PXaKyAqNUZPAHd67/QmjvwzkMs1oyIMBBXVPbsPcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJrlSx02tXOapJ43fFgpB5jfcl0VlgX108aMvHXtrqQGJxUMf7ezaM5M8YiDQVAWf
	 0xwKlskZ0FsfHfLzVYvuc0QOWN80BcLqWfovqZ+Oq6WFZT5oQ6CFKW1t7pYd4sgeoo
	 v0ZXYni+8xKGi4o+LuWTy8R9qG95ytbMpUEnBiZ9PM/uUf7DSS+I+lFLOkx8HRa2a+
	 GB5+yUAYGkCysSSO/dO7VC/3eDsd8gBlfsLnf3hayy8ot5eKBZa7PowczFR7TJgiHA
	 ZPevrAK1f0U2PaVbg7zsitWRTgFmW+I7K1ZyLWOT/q1Dm9hj4BjRoINZ7vgXUShvRS
	 BYe/UCbvxstHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 639/844] media: iris: Skip resolution set on first IPSC
Date: Sat, 28 Feb 2026 12:29:12 -0500
Message-ID: <20260228173244.1509663-640-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220718-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5934F1C886A
X-Rspamd-Action: no action

From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

[ Upstream commit 811dbc546f47559dc9d2098c612acfd47e32479e ]

The resolution property is not supposed to be set during reconfig.
Existing iris_drc_pending(inst) check is insufficient, as it doesn't
cover the first port setting change.

Extend the conditional check to also skip resolution setting when
the instance is in IRIS_INST_SUB_FIRST_IPSC.

Fixes: caf205548769 ("media: iris: Avoid updating frame size to firmware during reconfig")
Reviewed-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
index b6261d186d215..1c107daca9e89 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
@@ -733,7 +733,7 @@ static int iris_hfi_gen1_set_resolution(struct iris_inst *inst, u32 plane)
 	struct hfi_framesize fs;
 	int ret;
 
-	if (!iris_drc_pending(inst)) {
+	if (!iris_drc_pending(inst) && !(inst->sub_state & IRIS_INST_SUB_FIRST_IPSC)) {
 		fs.buffer_type = HFI_BUFFER_INPUT;
 		fs.width = inst->fmt_src->fmt.pix_mp.width;
 		fs.height = inst->fmt_src->fmt.pix_mp.height;
-- 
2.51.0


