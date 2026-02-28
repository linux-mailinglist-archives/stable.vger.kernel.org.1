Return-Path: <stable+bounces-220692-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPYvFpI/o2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220692-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:18:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F16A31C6D03
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABB9431240BA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1023F8B0A;
	Sat, 28 Feb 2026 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPZogpyt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39C93F8AFB;
	Sat, 28 Feb 2026 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300573; cv=none; b=QM8p+kuOiIHk/G5nCiXVvbo8XGCYefA7JWyburZAR5rfhqPyZ0uI9TbcK8Dltbak8fh37m0C6kc/Tl071ybfKZ49ouMpM9nK3G65DAU1s1/3PblKck81XPPo07bT+Ca4BFo7mGSOOd6hQLBLd5zEGFohqBNhdO0R2iQNKC71RPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300573; c=relaxed/simple;
	bh=OeBiOH2MaUBz2DQS4qmVwqoVgLtnGrd+D6Gji32gUUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMZQoXjWVbcPPkXxAgC3L/dS+wB0X4kZe57rtmYk3BCStO3iH8qzv9TuoTNDEiIfYg7gaGcJKoR0rBlMOvhc2n2PJxCvl1/hc6PcSA58vqidds4SqODJnrcPzqwoSqmcW6E8Q744OWyZK4l2I/lo+TIqfFS6Qa349Lbzkt6e22E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPZogpyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116AAC116D0;
	Sat, 28 Feb 2026 17:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300572;
	bh=OeBiOH2MaUBz2DQS4qmVwqoVgLtnGrd+D6Gji32gUUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cPZogpytS9nfPmIkXntRWjzSjJUkxtTLiFdsqgXPBziMRGoPzCZmm0OOCSfJOMFM6
	 /fSo+L5ECT9dr0D+5hRBFRC414aK2K5pD4DTlt/s4xhO65ngN9MtaYZ2yUmC+mWqiT
	 FSvB6OC37GKcBGM0ieGugYYUAkiAM3cH+OnodoETuYqtqPUPso3YUzlv3TbNDdoUUm
	 wTUY1WGF05JJTwcQ8sIAw86VhTgyAbEsKQsu7CR8KxqmEZOQrFxHDsRxX3cr7T1A0p
	 Xynsw1bz4sdaSSaKjrbWHZZ4M5bUy+0EtiZpFcbnH192ricU8v+UtdA1qrgm3UcSpq
	 HVgU2vLr+jJoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Stable@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 613/844] media: stm32: dcmipp: avoid naming clock if only one is needed
Date: Sat, 28 Feb 2026 12:28:46 -0500
Message-ID: <20260228173244.1509663-614-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-220692-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F16A31C6D03
X-Rspamd-Action: no action

From: Alain Volmat <alain.volmat@foss.st.com>

[ Upstream commit 2f130245f2143fa8f4da77071f844911d2c69319 ]

When DCMIPP requires only a single clock (kclk), avoid relying on its
name to obtain it. The introduction of MP25 support added the mclk,
which necessitated naming the first clock kclk. However, this breaks
backward compatibility with existing MP13 device trees that do not
specify clock names.

Fixes: 686f27f7ea37 ("media: stm32: dcmipp: add core support for the stm32mp25")
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Cc: Stable@vger.kernel.org # 6.14.x: 7f487562af49 media: stm32: dcmipp: correct ret type in dcmipp_graph_notify_bound
Cc: Stable@vger.kernel.org # 6.14.x: c715dd62da30 media: stm32: dcmipp: add has_csi2 & needs_mclk in match data
Cc: Stable@vger.kernel.org # 6.14.x:
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
index 1b7bae3266c8d..49398d0777646 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
@@ -526,7 +526,12 @@ static int dcmipp_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	kclk = devm_clk_get(&pdev->dev, "kclk");
+	/*
+	 * In case of the DCMIPP has only 1 clock (such as on MP13), the
+	 * clock might not be named.
+	 */
+	kclk = devm_clk_get(&pdev->dev,
+			    dcmipp->pipe_cfg->needs_mclk ? "kclk" : NULL);
 	if (IS_ERR(kclk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(kclk),
 				     "Unable to get kclk\n");
-- 
2.51.0


