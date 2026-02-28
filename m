Return-Path: <stable+bounces-220709-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGCOAfhTo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220709-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:45:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB22F1C8837
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03E9231B4D6E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5573FB059;
	Sat, 28 Feb 2026 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSHOAQpx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69813FB89A;
	Sat, 28 Feb 2026 17:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300589; cv=none; b=nnAMlWUuZQ1mxwxmtWgXyIxO8MTPLrCc80y+wHNuG6dK4c8olvlncKCFSug098oa88h0zEwfCDSza6YoYIgvghnThkiJepG6uhB8TQweTOyvy8BQ0HYWiizsgtw9z8HXUCnRs3v7oEYJFei6SQcHT6LvisiQnK+wYPNEBAifX5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300589; c=relaxed/simple;
	bh=9LQK53S+1C7Ho18RH8m/6mkNYbAiFBoP0Vq87CYjD9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoI6Zv9SCzb0iRQXoUhr5RuIC2uANujnCGqWFYcbV8o8THbGqUxHocNrBxZMsKrX3kI8Js0+QOw1Vn39g5aheC7ZNxGItchmQ8nvZIO0rNP6IH/uyjLhxlC5g9GaCgsXjuf+0gBk4WEs+khQkScVOWsEffEizYbQKjcx+B13rxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSHOAQpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2632C19424;
	Sat, 28 Feb 2026 17:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300588;
	bh=9LQK53S+1C7Ho18RH8m/6mkNYbAiFBoP0Vq87CYjD9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VSHOAQpxxHUaT4fTOfV4KUIenLga3tqIA+hl31o6OIW0S8o0P+twa5CkV7chE1wIJ
	 l4uLCEt/nGK1A1opDo22wzyjDfM8aih5MbrsSmBv7b5C3gdkbGcIdjYp4aF0dSboi2
	 Lv4zewwt/blXKwKQhFCFyopfX9olNdO8VeKeApBtE7pHKBC/YKXEAmXz9GwHiVUduO
	 12vLYD10y9PmVoyNm5zq6GVxdjB3y8Y0LjtAUUM9wSo1KUTsxTqFRZP94EM2KBNDeO
	 b5oszirahVTwS7OoWSOt6+3T3nd1NuasllLYY5Qod13OgGCmQCPm7C82npjrQIHwop
	 0uWpim+GCAj2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Renjiang Han <renjiang.han@oss.qualcomm.com>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 630/844] media: venus: vdec: fix error state assignment for zero bytesused
Date: Sat, 28 Feb 2026 12:29:03 -0500
Message-ID: <20260228173244.1509663-631-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220709-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB22F1C8837
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
index 4a6641fdffcf7..d0bd2d86a31f9 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1440,10 +1440,10 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
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


