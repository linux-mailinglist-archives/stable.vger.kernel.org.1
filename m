Return-Path: <stable+bounces-236923-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKnqGGUb3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236923-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:35:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B28B3EF56B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8E2730181B7
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF0B311C2D;
	Mon, 13 Apr 2026 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="en3rAsrD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB25030DEB5;
	Mon, 13 Apr 2026 16:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098138; cv=none; b=hukuMcmElNC6k9/a/7TpNNtKv+HnhfxzD1GxClN85iF8dt+bhkqVQvjS+6u8KzFg/Ua3hm6mtX/du0IL59MmWvIP1EBsibim6pgjolwbdiW18W5m1Xi9GthNQg6l51KE4pS3MPOO0FEaD6o9VUymqEE9EpgqTLlOMWFiQzTHpSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098138; c=relaxed/simple;
	bh=+5akIcFXDa0yd/qqYMSfqYw+PYBUmBVpQct/b/iz3IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzTRR4mr25XARCUlR2ou1+Lb0sTRvSNvHWR2jjk8SFX6Sz/vTh6g3dQOi+G1z8B2ZewcRL7Q3VwGJ6LZda/njAb5FkKRGMUU8vqi/Pxs65zTJSRPie86HCLgc6/0KqFF7AnLvN+col9kkpOHHQNmZmY4rHRjK4td+K0Am3IaWlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=en3rAsrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6A0C2BCAF;
	Mon, 13 Apr 2026 16:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098138;
	bh=+5akIcFXDa0yd/qqYMSfqYw+PYBUmBVpQct/b/iz3IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=en3rAsrDsL5gcgTZtDQAgbGxwhJsnAS5fwSTGtlj3m5pi8gN3ArsnbWZux5aGREOB
	 8FIELdOH6Mn+YOaiyjkaOeuRLQiqsAXz5QjocDiMNHo77r/bPM71MwqvcuWMLGeLsJ
	 CpL2c1fEYGWcn+kBvQqvs3x8HtiBoCchRZyU3ask=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jihed Chaibi <jihed.chaibi.dev@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 366/570] ASoC: adau1372: Fix clock leak on PLL lock failure
Date: Mon, 13 Apr 2026 17:58:17 +0200
Message-ID: <20260413155844.191065270@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,analog.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-236923-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Queue-Id: 1B28B3EF56B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

[ Upstream commit bfe6a264effcb6fe99ad7ceaf9e8c7439fc9555b ]

adau1372_enable_pll() was a void function that logged a dev_err() on
PLL lock timeout but did not propagate the error. As a result,
adau1372_set_power() would continue with adau1372->enabled set to true
despite the PLL being unlocked, and the mclk left enabled with no
corresponding disable on the error path.

Convert adau1372_enable_pll() to return int, using -ETIMEDOUT on lock
timeout and propagating regmap errors directly. In adau1372_set_power(),
check the return value and unwind in reverse order: restore regcache to
cache-only mode, reassert GPIO power-down, and disable the clock before
returning the error.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Fixes: 6cd4c6459e47 ("ASoC: Add ADAU1372 audio CODEC support")
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20260325210704.76847-3-jihed.chaibi.dev@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/adau1372.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/adau1372.c b/sound/soc/codecs/adau1372.c
index 0997d5f3e4039..e20145812f12b 100644
--- a/sound/soc/codecs/adau1372.c
+++ b/sound/soc/codecs/adau1372.c
@@ -761,7 +761,7 @@ static int adau1372_startup(struct snd_pcm_substream *substream, struct snd_soc_
 	return 0;
 }
 
-static void adau1372_enable_pll(struct adau1372 *adau1372)
+static int adau1372_enable_pll(struct adau1372 *adau1372)
 {
 	unsigned int val, timeout = 0;
 	int ret;
@@ -777,8 +777,12 @@ static void adau1372_enable_pll(struct adau1372 *adau1372)
 		timeout++;
 	} while (!(val & 1) && timeout < 3);
 
-	if (ret < 0 || !(val & 1))
+	if (ret < 0 || !(val & 1)) {
 		dev_err(adau1372->dev, "Failed to lock PLL\n");
+		return ret < 0 ? ret : -ETIMEDOUT;
+	}
+
+	return 0;
 }
 
 static int adau1372_set_power(struct adau1372 *adau1372, bool enable)
@@ -806,7 +810,14 @@ static int adau1372_set_power(struct adau1372 *adau1372, bool enable)
 		 * accessed.
 		 */
 		if (adau1372->use_pll) {
-			adau1372_enable_pll(adau1372);
+			ret = adau1372_enable_pll(adau1372);
+			if (ret) {
+				regcache_cache_only(adau1372->regmap, true);
+				if (adau1372->pd_gpio)
+					gpiod_set_value(adau1372->pd_gpio, 1);
+				clk_disable_unprepare(adau1372->mclk);
+				return ret;
+			}
 			clk_ctrl |= ADAU1372_CLK_CTRL_CLKSRC;
 		}
 
-- 
2.53.0




