Return-Path: <stable+bounces-220316-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0D1hGPcwo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220316-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:16:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA151C59A7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE5513445914
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D4D47ECE1;
	Sat, 28 Feb 2026 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIDVg9bY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194AF390F9E;
	Sat, 28 Feb 2026 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300218; cv=none; b=TqBRtsMP4J4t3vgBRRd9st9YuXvHtKodsCAySc2IaMtnaE8O4Aro+NJgZk0JyuNUewKCbI+YZrbBWNLE5fBkRzWi3MLLiUspkwQBN3fxGycwXNX1VJiL6eWklsyWebKUNTh0KT3CjpmvOITZ0aFNk8YLjnl9WN9fn+j2aSDQhpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300218; c=relaxed/simple;
	bh=VOUULQOwwW+FhF7aXxZ7sghdhXsSCejxAEKrmsOSmFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yg4n6oAvcnBVG/6bdkY6GoTC7rk8ozvTcaPU9n76ySmTknl5UpAUpOvjdpuiLdaqepECA3nb1E4oqH16SKEFacBwcNGdsvG/Vi4feFYXmn6j5mDvBgFzTnsx5/cQQJi2uiGKzd+6nCi8bw9FlR3vKZMh/ttYgqySMR1NU1WBrYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIDVg9bY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644E8C116D0;
	Sat, 28 Feb 2026 17:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300218;
	bh=VOUULQOwwW+FhF7aXxZ7sghdhXsSCejxAEKrmsOSmFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TIDVg9bYoUsR2WvnwSV7fRdwBaB7r2653JSXdXJmu/NNsNNaFqmFaKRnZyBLla/+3
	 0Actd7ciiTt49tcJ41YNfQdeASYsFmoTKkL5v+l9FITjXAPfp/LQi1bVIYAxbxYhrn
	 uG0aW0hRm/rpCfSaWuu2Z/4cSxhCF4CWvuQ6OC/3eZYzHjDfWC5GaZDwkoXEzOTNGj
	 XqAwJ6avlztbadNP7d8bcmJ66WStFrj9YFUjzbIkEf7kqiykXHOyNckccdM+NZzEbp
	 +CPy0eDUcEHksSCUZjlNPkSWIOSGQCVv044I7uBhL3lw57vf3YDbNK1jBpkJKxf+s8
	 1qN9OAVNEldkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A9dric=20Bellegarde?= <cedric.bellegarde@adishatz.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 238/844] ASoC: qcom: q6asm: drop DSP responses for closed data streams
Date: Sat, 28 Feb 2026 12:22:31 -0500
Message-ID: <20260228173244.1509663-239-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220316-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: BCA151C59A7
X-Rspamd-Action: no action

From: Cédric Bellegarde <cedric.bellegarde@adishatz.org>

[ Upstream commit 8a066a81ee0c1b6cdbd81393536c3b2d19ccef25 ]

'Commit a354f030dbce ("ASoC: qcom: q6asm: handle the responses
after closing")' attempted to ignore DSP responses arriving
after a stream had been closed.

However, those responses were still handled, causing lockups.

Fix this by unconditionally dropping all DSP responses associated with
closed data streams.

Signed-off-by: Cédric Bellegarde <cedric.bellegarde@adishatz.org>
Link: https://patch.msgid.link/20260102215225.609166-1-cedric.bellegarde@adishatz.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index e7295b7b24610..3c4a24c9dba22 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -638,7 +638,6 @@ static int32_t q6asm_stream_callback(struct apr_device *adev,
 			client_event = ASM_CLIENT_EVENT_CMD_OUT_FLUSH_DONE;
 			break;
 		case ASM_STREAM_CMD_OPEN_WRITE_V3:
-		case ASM_DATA_CMD_WRITE_V2:
 		case ASM_STREAM_CMD_OPEN_READ_V3:
 		case ASM_STREAM_CMD_OPEN_READWRITE_V2:
 		case ASM_STREAM_CMD_SET_ENCDEC_PARAM:
@@ -657,8 +656,9 @@ static int32_t q6asm_stream_callback(struct apr_device *adev,
 			break;
 		case ASM_DATA_CMD_EOS:
 		case ASM_DATA_CMD_READ_V2:
+		case ASM_DATA_CMD_WRITE_V2:
 			/* response as result of close stream */
-			break;
+			goto done;
 		default:
 			dev_err(ac->dev, "command[0x%x] not expecting rsp\n",
 				result->opcode);
-- 
2.51.0


