Return-Path: <stable+bounces-221033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLDwIRtIo2mm/AQAu9opvQ
	(envelope-from <stable+bounces-221033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:55:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2FA1C789A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64012323D341
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C984BCADB;
	Sat, 28 Feb 2026 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFsH2c4m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FB2175A66;
	Sat, 28 Feb 2026 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301375; cv=none; b=ZSr2OWxVLVDxSmeQnaKNhQaHwtStvOUIKnLqxIJWLK/8oBhfmoZAZAObHIXJ7OI1d8ucN7gTHGiIMthk+dRAPAWapoY6HgqPjBDLgDcwyOiCXTdOtM3QxLFAaRk7MTtKB7hKTE0/fs8Ql5RVovSbpUDj9s3SndtGqZmpk9RuxJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301375; c=relaxed/simple;
	bh=3NghqsS5OpVK0C7E29HYkyKv7cngY4P93owtSeXWf7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwqjswN1rtQLpuNiR+wS2Mmq9NZquqFJdYenMFC1pdeJhdyJnmn6Z3K9W3tZNomZddPEwUNVxAyQ8Kap1OSo2lluEQEf+LdLM3mMxDnPNOl3cAxiZuRiyBZDUeEr8DPSQhMPXRw1jGUMvObhaFtH+SqqqRAiPsrCy/1gRf1SaU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFsH2c4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D85C19424;
	Sat, 28 Feb 2026 17:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301375;
	bh=3NghqsS5OpVK0C7E29HYkyKv7cngY4P93owtSeXWf7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GFsH2c4mYGSb4uZRK/vwqJcWOncmyFP0Iy7sREq5PMlLY2Nz8j2H3E/ugCBbfKKFC
	 pD9jWG2dsPLnxjzFx7GnaV/xtklOZFovHi8hlXCtjRYitGOmQvthDpTvvNBJCx7mPS
	 uB3YLJMyVPmsUDZFzc8mZhuZby+58v67TzaPif9TcZcouHjhBSbkUTg5TOyvM25j2T
	 nWgSrdsbAZ8vQmEdiR8JXNnZF1hpJY3jVkvg4avMgnT6wJD9mbg//gdSASQi9xyuAA
	 AxPuE5EbWgD9egH6qZl57+34u4Elc2W44FVNmUvagIxXfUZQARiDmxL0XEIT5AndIn
	 49riVfHfGotqQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Renjiang Han <renjiang.han@oss.qualcomm.com>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 564/752] media: venus: vdec: fix error state assignment for zero bytesused
Date: Sat, 28 Feb 2026 12:44:35 -0500
Message-ID: <20260228174750.1542406-564-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-221033-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C2FA1C789A
X-Rspamd-Action: no action

From: Renjiang Han <renjiang.han@oss.qualcomm.com>

[ Upstream commit 93ecd6ee95c38cb533fa25f48d3c1c8cb69f410f ]

When hfi_session_flush is issued, all queued buffers are returned to
the V4L2 driver. Some of these buffers are not processed and have
bytesused = 0. Currently, the driver marks such buffers as error even
during drain operations, which can incorrectly flag EOS buffers.

Only capture buffers with zero payload (and not EOS) should be marked
with VB2_BUF_STATE_ERROR. The check is performed inside the non-EOS
branch to ensure correct handling.

Fixes: 51df3c81ba10b ("media: venus: vdec: Mark flushed buffers with error state")
Signed-off-by: Renjiang Han <renjiang.han@oss.qualcomm.com>
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 55c27345b7d89..ba4d9087bff5d 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1442,10 +1442,10 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
 				inst->drain_active = false;
 				inst->codec_state = VENUS_DEC_STATE_STOPPED;
 			}
+		} else {
+			if (!bytesused)
+				state = VB2_BUF_STATE_ERROR;
 		}
-
-		if (!bytesused)
-			state = VB2_BUF_STATE_ERROR;
 	} else {
 		vbuf->sequence = inst->sequence_out++;
 	}
-- 
2.51.0


