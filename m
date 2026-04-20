Return-Path: <stable+bounces-238810-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDnoKW4q5mkDswEAu9opvQ
	(envelope-from <stable+bounces-238810-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:30:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D3142BD90
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 721E631C6896
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2273AE6F5;
	Mon, 20 Apr 2026 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXW0tIyd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DC93A9632;
	Mon, 20 Apr 2026 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690992; cv=none; b=esld1STfSPLTUFFsgcJIgePiYstO/WhlvUw1Ewn1kByMtepSZMVeYQeHuXUgjnPpJn31s5lbWZcD2iRgyAeBcHpk3W5Vkyq7HgtKkaPunBjgtmhcpyzkdGE3RaSuQojf9mYfgABsTW9Br0slETuivVV1JFiJ5U4LdqRMmB8xA18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690992; c=relaxed/simple;
	bh=G3vgPIuJyGHx+pbP3p2kYDmPMMfVxfTRLcgSZFSeSI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zdm2nC4XtsEyX4uwPntNs3sSkG2vkhc2I+UZl+gBkGb2DvNXH0AJk+sNpdP6mwWsrR/8yyEeRdO6ya09rn9DLsrdYv3mAuglSa/gEfrW5Tn/35lOKeFMcffBIaf1+6Y5NljjMybFN8obw7PhqGd+vkCGz8fGiLSy/CENpTiV9Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXW0tIyd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0EEC2BCC4;
	Mon, 20 Apr 2026 13:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776690992;
	bh=G3vgPIuJyGHx+pbP3p2kYDmPMMfVxfTRLcgSZFSeSI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qXW0tIydUgfh1ruzH5eVppKeYoI++XCokx+j8azGHd3ZFeVMz6upiivvNyFlicus/
	 IikFbQdSuFAqWrlb8NkMw3CHQxYlZEmeke1mEKcB4WNhe970nwOUJfLK24YkoFA4j1
	 Mjw8Jldvs1Arm2UxW8WOeLo3cya3ax2QVEtqn0tdb739ut/IPGKB6f32AjYOgu3Xi3
	 FesnJ71JKXv2LFwlHspiBqmBZv/K5zojHZJBtVBjnImBCZmHvi7avRnA7VkF+JB6Cs
	 ud6JUnmmI0oH90oRRRuA+vFkbgeNlNAD/oyvgPd6uwEwe1zLgBn+T6GI3AJnbuh6hc
	 v6ecs43FI9Geg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pierre-louis.bossart@linux.intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] ASoC: Intel: avs: Fix memory leak in avs_register_i2s_test_boards()
Date: Mon, 20 Apr 2026 09:08:17 -0400
Message-ID: <20260420131539.986432-31-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420131539.986432-1-sashal@kernel.org>
References: <20260420131539.986432-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238810-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 05D3142BD90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit c5408d818316061d6063c11a4f47f1ba25a3a708 ]

Caller is responsible for freeing array allocated with
parse_int_array().

Found out by Coverity.

Fixes: 7d859189de13 ("ASoC: Intel: avs: Allow to specify custom configurations with i2s_test")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://patch.msgid.link/20260407085459.400628-1-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 sound/soc/intel/avs/board_selection.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/avs/board_selection.c b/sound/soc/intel/avs/board_selection.c
index 52e6266a7cb86..96dc637ccb20c 100644
--- a/sound/soc/intel/avs/board_selection.c
+++ b/sound/soc/intel/avs/board_selection.c
@@ -520,7 +520,8 @@ static int avs_register_i2s_test_boards(struct avs_dev *adev)
 	if (num_elems > max_ssps) {
 		dev_err(adev->dev, "board supports only %d SSP, %d specified\n",
 			max_ssps, num_elems);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto exit;
 	}
 
 	for (ssp_port = 0; ssp_port < num_elems; ssp_port++) {
@@ -528,11 +529,13 @@ static int avs_register_i2s_test_boards(struct avs_dev *adev)
 		for_each_set_bit(tdm_slot, &tdm_slots, 16) {
 			ret = avs_register_i2s_test_board(adev, ssp_port, tdm_slot);
 			if (ret)
-				return ret;
+				goto exit;
 		}
 	}
 
-	return 0;
+exit:
+	kfree(array);
+	return ret;
 }
 
 static int avs_register_i2s_board(struct avs_dev *adev, struct snd_soc_acpi_mach *mach)
-- 
2.53.0


