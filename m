Return-Path: <stable+bounces-220500-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLS9EKI5o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220500-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:53:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CBB1C65DD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DA67317127B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566143C8F62;
	Sat, 28 Feb 2026 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfWBLxB3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1900F3C8F59;
	Sat, 28 Feb 2026 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300385; cv=none; b=HkKqfCzZAaQAgdW92YEUXcWXx5c7VgkZATgAdn9go8tS9z/yp5A6fH8BA2cvEWqvZcKZCp3g5JStOvKXnuzzgo6x/cVT6tijb+PxWEeKt4DJv9hAkzDjJej/GsTUtZ6esVNSVn7d++3egUe9I9plEN+3lPitCSStl2MyxyNkqBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300385; c=relaxed/simple;
	bh=XZc44cBv0slfjRfWU5Sg3CT6rJjxxRymbEQGtCUh0eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TedA9yEkxASx+vgWLqZSCInGYaQtBnty3vLZx1TUK5fd4BJV1WKWv/+XDZbimfN302L42Akel+8DbOkK3tKhQnWplaI5EkzpxonLtlwdE/8Txcx7WKEJA/8hAgCEQOkhKcihRqdgOGrH2r8vdWqyUtJnjqhiz7KkUdwq00gKngY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfWBLxB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EA4C19423;
	Sat, 28 Feb 2026 17:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300385;
	bh=XZc44cBv0slfjRfWU5Sg3CT6rJjxxRymbEQGtCUh0eQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZfWBLxB3MzqculhVQ7gVAT3iMD0Bf+ewxlCc0Rhkt656UvjpPVTqgm4OtpXoaQBJU
	 l8LKFz8xiAwcekjCMYWNjTe51VR70n6uH7nsuGfGbDf8RukK600eOCfYjOreKozGFn
	 36LmGQ+EBm7ioiD54F3vU8A/poJlRCaxbWkBwUI9sBJWaklG6dvUpZebtK/BzdInP5
	 uZFbTG+IZa+MpLHCCiPmpEml0fxjpQxkCP8q1HnCORM5+YDEOttroD7jXbMPShBUTX
	 +QC1gQ4z5lkZCDLIZXWqfFmEzpXI36OwmjseoDRPF1BZ0tKwULWRnhL9ZkdVC44JCy
	 Q3t7lZh97PSOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jack Yu <jack.yu@realtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 421/844] ASoC: rt721-sdca: Fix issue of fail to detect OMTP jack type
Date: Sat, 28 Feb 2026 12:25:34 -0500
Message-ID: <20260228173244.1509663-422-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220500-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E3CBB1C65DD
X-Rspamd-Action: no action

From: Jack Yu <jack.yu@realtek.com>

[ Upstream commit 5578da7d957fbaf91f6c39ba2363c2d2e4273183 ]

Add related HP-JD settings to fix issue of fail to detect
OMTP jack type.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
Link: https://patch.msgid.link/20260210074335.2337830-1-jack.yu@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt721-sdca.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt721-sdca.c b/sound/soc/codecs/rt721-sdca.c
index 8233532a1752a..35960c2252249 100644
--- a/sound/soc/codecs/rt721-sdca.c
+++ b/sound/soc/codecs/rt721-sdca.c
@@ -245,12 +245,12 @@ static void rt721_sdca_jack_preset(struct rt721_sdca_priv *rt721)
 	regmap_write(rt721->mbq_regmap, 0x5b10007, 0x2000);
 	regmap_write(rt721->mbq_regmap, 0x5B10017, 0x1b0f);
 	rt_sdca_index_write(rt721->mbq_regmap, RT721_CBJ_CTRL,
-		RT721_CBJ_A0_GAT_CTRL1, 0x2a02);
+		RT721_CBJ_A0_GAT_CTRL1, 0x2205);
 	rt_sdca_index_write(rt721->mbq_regmap, RT721_CAP_PORT_CTRL,
 		RT721_HP_AMP_2CH_CAL4, 0xa105);
 	rt_sdca_index_write(rt721->mbq_regmap, RT721_VENDOR_ANA_CTL,
 		RT721_UAJ_TOP_TCON14, 0x3b33);
-	regmap_write(rt721->mbq_regmap, 0x310400, 0x3023);
+	regmap_write(rt721->mbq_regmap, 0x310400, 0x3043);
 	rt_sdca_index_write(rt721->mbq_regmap, RT721_VENDOR_ANA_CTL,
 		RT721_UAJ_TOP_TCON14, 0x3f33);
 	rt_sdca_index_write(rt721->mbq_regmap, RT721_VENDOR_ANA_CTL,
-- 
2.51.0


