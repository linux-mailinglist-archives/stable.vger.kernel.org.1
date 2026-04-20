Return-Path: <stable+bounces-239087-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACD5Iic95mlutgEAu9opvQ
	(envelope-from <stable+bounces-239087-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:50:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCDB42D858
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F2DA31DD406
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7328543D504;
	Mon, 20 Apr 2026 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1ymmVcf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CF143D4E3;
	Mon, 20 Apr 2026 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691797; cv=none; b=j52rI1q63vm+oi8Ckt41z/QZuQCp+y4PqZyEm1DMzfIxx91spU1Rw1f4gYbsHiuZ0kzXY8B9oeAGIHXNdxUtrtzg41rtB+SdJxRlNFjocZu/EtEO6dmemlmIDHqs09AdoOY9Wy3oMZxZSzyzcFEaqrNvQ0sW3bWC7SWMBUlSDKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691797; c=relaxed/simple;
	bh=bayKu25Lw6g0OLNSh41kpkBBpdp1Kk40gGr80cFvE40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dU5JEFWO7eutm8OlVqnsqGwoS7PD67wEDeQd3T0NneeGlEKU6jPONFxFGRIvZe5v1HHVfABF8ywixMoqIXaIdgZRUFl5O9yNEOdfNKaswkwpgAYZLAaVbXvYFcUgkZKl2Bl40GCRioFSjDYHelz2BR6UFtVYCxjShF1ZGgY07os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1ymmVcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734D6C19425;
	Mon, 20 Apr 2026 13:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691797;
	bh=bayKu25Lw6g0OLNSh41kpkBBpdp1Kk40gGr80cFvE40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i1ymmVcfK6DsJyd2NT2eaJmaUgeOCxJEp9TnJBFLdJsKhBqOcghcUl90aDDUAaZUx
	 Ba2VaNU3VYKuH5V79a6gMLtH5Ev3QZ5VYzNywkJR+j8J6Z22J+4/9HztE6gSxPLIQ1
	 8+x/0d110G85DBZR6nNpQKC193Cg7QkCbw036NyMluxQSSmTUnzGNY7GX073Yg0KZH
	 399HFKzMBBbrDGzBWh1dHocgx2q4ABT8E83k0xzUYCfmT81+8PwQcuxUnrp6lucD7n
	 btdjdH/9hSenVzp1ntDvWqleU5Xn3luRJZOsWaLDFOOOw+5u2GTzGl/ILk+7WGG8KO
	 ZAPOt94XusK8g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Tomasz Merta <tomasz.merta@arrow.com>,
	Tomasz Merta <tommerta@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	olivier.moysan@foss.st.com,
	arnaud.pouliquen@foss.st.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] ASoC: stm32_sai: fix incorrect BCLK polarity for DSP_A/B, LEFT_J
Date: Mon, 20 Apr 2026 09:19:53 -0400
Message-ID: <20260420132314.1023554-199-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[arrow.com,gmail.com,kernel.org,foss.st.com,perex.cz,suse.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-239087-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arrow.com:email]
X-Rspamd-Queue-Id: 0CCDB42D858
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

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


