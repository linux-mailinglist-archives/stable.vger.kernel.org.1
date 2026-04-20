Return-Path: <stable+bounces-239602-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPBDLGVZ5mmtvAEAu9opvQ
	(envelope-from <stable+bounces-239602-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:50:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B9743018C
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 474B0313C982
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E067233D6FC;
	Mon, 20 Apr 2026 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lt4/H3cC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F69322749;
	Mon, 20 Apr 2026 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700677; cv=none; b=BFeECe6qQb80vSNj9AJfSDwaN6kJERMcmudGdjzflLJhH8hoC4WIiJDIRnxRgakRJbML2z0jmD8i/D9WwtCoaOX1+DhrOCqbEJ7RUMESzyD7+JB2M2YFB24bXrEN3fedofaG9ZJ2XlIFIqwex33Oave0rIyCfz19ZpfXVUA22hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700677; c=relaxed/simple;
	bh=TPi22R44xO568q+Uygf+kYA5OOEL8WcbWzmA810CJ7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fgw9CyuFmQPGH+hA+2kJjMpReuarIiJ6vc7n8XZeaKMPSXUwUE7rKwgVSM2Ah7CLTEqVQ1xU1sW3JItGrWolI4avPydukMnMZHDWzfeyZDdd6uULFSuyrcuKmvPMwfWY2pcOSr3GZhacPVR2tbViEJhaYGz0cfbwOpsb+2RGa3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lt4/H3cC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F46C19425;
	Mon, 20 Apr 2026 15:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700677;
	bh=TPi22R44xO568q+Uygf+kYA5OOEL8WcbWzmA810CJ7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lt4/H3cCCtq0qpJLV0m9gGueKKCF1dTsOwLBnGbtmdqV+0D4q3A5j3BsRL7tPYgJG
	 5PTZ8iT7iltB2bJtKBvvPlCVrLRGTRmkKTvf58ce6fsi8FHRWJeDjJwPcqN8IvmIfG
	 uuF5HNQYPAI7tQdppzMAQT/yh9zReb+hak1zNB94=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tomasz Merta <tommerta@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 045/198] ASoC: stm32_sai: fix incorrect BCLK polarity for DSP_A/B, LEFT_J
Date: Mon, 20 Apr 2026 17:40:24 +0200
Message-ID: <20260420153937.239661336@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239602-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: 28B9743018C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomasz Merta <tomasz.merta@arrow.com>

[ Upstream commit 0669631dbccd41cf3ca7aa70213fcd8bb41c4b38 ]

The STM32 SAI driver do not set the clock strobing bit (CKSTR) for DSP_A,
DSP_B and LEFT_J formats, causing data to be sampled on the wrong BCLK
edge when SND_SOC_DAIFMT_NB_NF is used.

Per ALSA convention, NB_NF requires sampling on the rising BCLK edge.
The STM32MP25 SAI reference manual states that CKSTR=1 is required for
signals received by the SAI to be sampled on the SCK rising edge.
Without setting CKSTR=1, the SAI samples on the falling edge, violating
the NB_NF convention. For comparison, the NXP FSL SAI driver correctly
sets FSL_SAI_CR2_BCP for DSP_A, DSP_B and LEFT_J, consistent with its
I2S handling.

This patch adds SAI_XCR1_CKSTR for DSP_A, DSP_B and LEFT_J in
stm32_sai_set_dai_fmt which was verified empirically with a cs47l35 codec.
RIGHT_J (LSB) is not investigated and addressed by this patch.

Note: the STM32 I2S driver (stm32_i2s_set_dai_fmt) may have the same issue
for DSP_A mode, as I2S_CGFR_CKPOL is not set. This has not been verified
and is left for a separate investigation.

Signed-off-by: Tomasz Merta <tommerta@gmail.com>
Link: https://patch.msgid.link/20260408084056.20588-1-tommerta@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 5ae4d2577f28b..c2540383ab86f 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -802,6 +802,7 @@ static int stm32_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		break;
 	/* Left justified */
 	case SND_SOC_DAIFMT_MSB:
+		cr1 |= SAI_XCR1_CKSTR;
 		frcr |= SAI_XFRCR_FSPOL | SAI_XFRCR_FSDEF;
 		break;
 	/* Right justified */
@@ -809,9 +810,11 @@ static int stm32_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		frcr |= SAI_XFRCR_FSPOL | SAI_XFRCR_FSDEF;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
+		cr1 |= SAI_XCR1_CKSTR;
 		frcr |= SAI_XFRCR_FSPOL | SAI_XFRCR_FSOFF;
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
+		cr1 |= SAI_XCR1_CKSTR;
 		frcr |= SAI_XFRCR_FSPOL;
 		break;
 	default:
-- 
2.53.0




