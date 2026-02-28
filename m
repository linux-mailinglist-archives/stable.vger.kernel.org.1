Return-Path: <stable+bounces-220714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOM1EMNAo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:23:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D38A21C6EDE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE7BC30EFB3F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B823FC0CB;
	Sat, 28 Feb 2026 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVsPykAi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1D03FC8D8;
	Sat, 28 Feb 2026 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300594; cv=none; b=SOPJQpu7VL09XZ+P3K/yVuZixizvN+3ZDT6AoulGEmeryAPVGx2EbxWjyL6VrmnlRECm0PBEGDu5J4lThr5x408Iuvot9wrMQSU0MAUw+ziBBb9rWp1HNT9Y2JrXEg5B+caEZEHTN9eiRamkvgo83y033NHYvDL+gCh2lG+oxAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300594; c=relaxed/simple;
	bh=pJq8t6Ws/PvBHxR7cZl+uRcxF+RXoBmnA2nHyPPEK2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZ+p/klDI5rWsclrJ75lcKzuUzqKPqdkii/xm+0gzqRskFkPv4rsYBcRWqExxgK/4icb2z3IuKnOvdNtjAIVabokHAmAEKHZ4d7Ho/IIF88noapvmN1WImce2E7HzBPeyPCKmMHzKtb1YySwUHkqq+kn9XP9BozCkGCFnh68P/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVsPykAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4B2C19423;
	Sat, 28 Feb 2026 17:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300594;
	bh=pJq8t6Ws/PvBHxR7cZl+uRcxF+RXoBmnA2nHyPPEK2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HVsPykAihacylnuduqv0BWIpD6Yw3a06rT3BgREeuSkxYovoiQCkZbtnHVK5eBCoR
	 cbQTR/7t8ULdpgcSEPREwHbWoELVpy7dOvDg3n6G05gLd0sOIOUNDXy83ADO/RpC4b
	 ZNi5GF9Sbpj6fBb2crmRf+Q5rVpEFIKWBz2jyTerf74dZQhRrKLdvhCo5mywnqKEQF
	 NFBYjS/IlMd4g4toiYaneyFNyyH2mOAaBEeOooXC15LttOEr+0HSr55jZnKFiNl/N9
	 tcBtAmyyrQqgs1Q4PpmHd7P7QEnEEl8QaUkPRQcQTvEhkyg6avhiONWfHBswY1sq9I
	 BrU7dYRRXCy+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Val Packett <val@packett.cool>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 635/844] media: iris: use fallback size when S_FMT is called without width/height
Date: Sat, 28 Feb 2026 12:29:08 -0500
Message-ID: <20260228173244.1509663-636-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220714-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,packett.cool:email]
X-Rspamd-Queue-Id: D38A21C6EDE
X-Rspamd-Action: no action

From: Val Packett <val@packett.cool>

[ Upstream commit 4980721cb97d6c47700ab61a048ac8819cfeec87 ]

According to 4.5.1.5 of the M2M stateful decoder UAPI documentation,
providing the width and the height to S_FMT is "required only if it
cannot be parsed from the stream", otherwise they can be left as 0
and the S_FMT implementation is expected to return a valid placeholder
resolution that would let REQBUFS succeed.

iris was missing the fallback, so clients like rpi-ffmpeg wouldn't work.
Fix by adding an explicit fallback to defaults.

Fixes: b530b95de22c ("media: iris: implement s_fmt, g_fmt and try_fmt ioctls")
Link: https://github.com/jc-kynesim/rpi-ffmpeg/issues/103
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Signed-off-by: Val Packett <val@packett.cool>
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/iris/iris_vdec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_vdec.c b/drivers/media/platform/qcom/iris/iris_vdec.c
index 69ffe52590d3a..227e4e5a326fd 100644
--- a/drivers/media/platform/qcom/iris/iris_vdec.c
+++ b/drivers/media/platform/qcom/iris/iris_vdec.c
@@ -231,6 +231,14 @@ int iris_vdec_s_fmt(struct iris_inst *inst, struct v4l2_format *f)
 	if (vb2_is_busy(q))
 		return -EBUSY;
 
+	/* Width and height are optional, so fall back to a valid placeholder
+	 * resolution until the real one is decoded from the bitstream.
+	 */
+	if (f->fmt.pix_mp.width == 0 && f->fmt.pix_mp.height == 0) {
+		f->fmt.pix_mp.width = DEFAULT_WIDTH;
+		f->fmt.pix_mp.height = DEFAULT_HEIGHT;
+	}
+
 	iris_vdec_try_fmt(inst, f);
 
 	switch (f->type) {
-- 
2.51.0


