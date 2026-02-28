Return-Path: <stable+bounces-220250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKsjBq8uo2me+AQAu9opvQ
	(envelope-from <stable+bounces-220250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:06:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFE31C56AD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 465AB3184631
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAB8375AB3;
	Sat, 28 Feb 2026 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVltmFnV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE02375AAA;
	Sat, 28 Feb 2026 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300154; cv=none; b=WS+oe9YXndhrG4/FNWC5PZKUrAGCMOqa2llcnOnEUCGjvnwkx48xCdD5r0UujyBomAIgaajTYvsgrKRFWRhECoRXBNaAWSlqiM8Hc0Iy0gqGt8qrQFFb1vU3QAj5ACCr0DBFeqB1jWIanep0FUzG4CJ+YLq8jA47rQNdnkSIfPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300154; c=relaxed/simple;
	bh=yoEPFfcmHdxtqhQ2El/9+sUZcm49FKqpE3/YUqjqnsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Um4bav9odRQkscvoN0hx4QpXsdfBIv/eoV5ug4jPtNXcTSol1I4tRdzbj+1yrxiDbnE2/reeskLpE8hkd1wUvI8rY8p8oY24CyYE40OUVAlI9KlsGdeYPUf6Sak00UForjigaSJVnp+hJEd+YRYxWZDwGvQIWOpT/UUIThyb3bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVltmFnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64ECDC19424;
	Sat, 28 Feb 2026 17:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300154;
	bh=yoEPFfcmHdxtqhQ2El/9+sUZcm49FKqpE3/YUqjqnsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lVltmFnV+0Lv606/SoPb8CvShIE4mH/OrLaYoct4Ki6gKZFI4Lp9+Xfhiqxjg2zBt
	 cRElWdSezErtJ+S9gq4QHuvvjdoyConX8JPLWPHYfS1VVxHIG4f+FZb9pVqVY2zVke
	 Z2OioDurSRjTepB+qGALTs/p7yliOlY5CB7Fy6ZBG2fISt0AyQYTAcDm35qBdKkegf
	 /7LADzKjK8WQC1eQnTRbY3WdBQSjMsVoDbf3DhmzjHqoZ9V/SUBWSuMV1pm1Yw0hmB
	 WZQazaLoSZYNw/WxlJSLOe3cgBjVDthncInFzRCYxRitfjDLShKTdKTuFJnf1Uujhz
	 IQZtM9+r18l9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 172/844] ASoC: wm8962: Add WM8962_ADC_MONOMIX to "3D Coefficients" mask
Date: Sat, 28 Feb 2026 12:21:25 -0500
Message-ID: <20260228173244.1509663-173-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220250-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CFE31C56AD
X-Rspamd-Action: no action

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

[ Upstream commit 66c26346ae30c883eef70acf9cf9054dfdb4fb2f ]

This bit is handled by a separate control.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://patch.msgid.link/20260105-wm8962-l5-fixes-v1-1-f4f4eeacf089@puri.sm
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8962.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index e9e317ce68982..1040740fc80f8 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1760,7 +1760,7 @@ SND_SOC_BYTES("EQR Coefficients", WM8962_EQ24, 18),
 
 
 SOC_SINGLE("3D Switch", WM8962_THREED1, 0, 1, 0),
-SND_SOC_BYTES_MASK("3D Coefficients", WM8962_THREED1, 4, WM8962_THREED_ENA),
+SND_SOC_BYTES_MASK("3D Coefficients", WM8962_THREED1, 4, WM8962_THREED_ENA | WM8962_ADC_MONOMIX),
 
 SOC_SINGLE("DF1 Switch", WM8962_DF1, 0, 1, 0),
 SND_SOC_BYTES_MASK("DF1 Coefficients", WM8962_DF1, 7, WM8962_DF1_ENA),
-- 
2.51.0


