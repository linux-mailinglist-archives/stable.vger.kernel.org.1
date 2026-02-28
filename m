Return-Path: <stable+bounces-220277-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPDuBNUuo2me+AQAu9opvQ
	(envelope-from <stable+bounces-220277-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:07:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B841C56D1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 114983097E18
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75727383C60;
	Sat, 28 Feb 2026 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlGXbYh9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346023824F2;
	Sat, 28 Feb 2026 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300181; cv=none; b=EBvbt6q1ar1M1g7zRR+uI9giXFE9kT92CWh3Qc18KUK5HmtW/irETAH7Vtvyve0GoOqgStFm6jf9Mhzzbh6UBKFslsrYlPHh6a1KMEzt8xbyMsQ/O5xLvBHAb/XmnIy24XimT//H0xmuQjtcHvXm+c6V6GDWRijcnGerg8mYu7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300181; c=relaxed/simple;
	bh=NVcdXUyZAGeiHyWCwEX/200rlonoP5QqXLbrmsrer9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljCIPbvZcFHcPuf/BifDBPbcgxgM17idScSye5rIpMiikfja9UJAWZNk2+H+L74wPxMAaByjFTvtGhwz7LDZFijDU7aB1kUz5ZZaXA+cNe8/m2nRJJz9ODdx+TDyQRu4L3+LfgYdPHwpu7IMjqr5MzlUCmCxKNOg/izKtRm671k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlGXbYh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED5AC116D0;
	Sat, 28 Feb 2026 17:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300181;
	bh=NVcdXUyZAGeiHyWCwEX/200rlonoP5QqXLbrmsrer9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jlGXbYh9smEOfMaTYib3TiS9hqLFqFDUTf5rVHaKc4QbRFCAbF6Ws+egF64OkbTho
	 ymmXu1OEcQg7aTLUSYFOEaICApeDndLQqdtRNjh0om9AOJ0mCHC7mLHb2OP40tCmLk
	 xRYXdUKl7kOMc7FFJY/8pFQ9QErJLIgDLIu9YJ5S5Bc8LZ7UJN97/hUt6Tq83RG8oM
	 7YnV1rzDAE4BoB+WdwQYMAEfrJMFgDIdkgZ3ZmmB6EGHHVmak/JKnmF5EJ6cw5YJpq
	 nKfIHuoncS7nceb8RtoU5anfbjIF5Am6ThuGpHT2YjzWYSlTUA95COD/U4432zNaD8
	 EdvqX949WiLEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 199/844] ASoC: sdw_utils: remove dai registered check
Date: Sat, 28 Feb 2026 12:21:52 -0500
Message-ID: <20260228173244.1509663-200-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220277-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: A7B841C56D1
X-Rspamd-Action: no action

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit 8d38c275f7ffe257d21bea224d4288eef183817d ]

Checking for a registered DAI for non-existing endpoints causes the
following error. The driver will always return -EPROBE_DEFER if the
codec driver doesn't register the DAI of the unexist endpoint.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://patch.msgid.link/20260120065658.1806027-1-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sdw_utils/soc_sdw_utils.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/soc/sdw_utils/soc_sdw_utils.c b/sound/soc/sdw_utils/soc_sdw_utils.c
index ccf149f949e8f..d03072cd13cb9 100644
--- a/sound/soc/sdw_utils/soc_sdw_utils.c
+++ b/sound/soc/sdw_utils/soc_sdw_utils.c
@@ -1421,29 +1421,14 @@ static int is_sdca_endpoint_present(struct device *dev,
 	const struct snd_soc_acpi_adr_device *adr_dev = &adr_link->adr_d[adr_index];
 	const struct snd_soc_acpi_endpoint *adr_end;
 	const struct asoc_sdw_dai_info *dai_info;
-	struct snd_soc_dai_link_component *dlc;
-	struct snd_soc_dai *codec_dai;
 	struct sdw_slave *slave;
 	struct device *sdw_dev;
 	const char *sdw_codec_name;
 	int ret, i;
 
-	dlc = kzalloc(sizeof(*dlc), GFP_KERNEL);
-	if (!dlc)
-		return -ENOMEM;
-
 	adr_end = &adr_dev->endpoints[end_index];
 	dai_info = &codec_info->dais[adr_end->num];
 
-	dlc->dai_name = dai_info->dai_name;
-	codec_dai = snd_soc_find_dai_with_mutex(dlc);
-	if (!codec_dai) {
-		dev_warn(dev, "codec dai %s not registered yet\n", dlc->dai_name);
-		kfree(dlc);
-		return -EPROBE_DEFER;
-	}
-	kfree(dlc);
-
 	sdw_codec_name = _asoc_sdw_get_codec_name(dev, adr_link, adr_index);
 	if (!sdw_codec_name)
 		return -ENOMEM;
-- 
2.51.0


