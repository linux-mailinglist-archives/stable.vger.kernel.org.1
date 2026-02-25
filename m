Return-Path: <stable+bounces-218346-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yByFIulSnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218346-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:39:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A2B18F5C2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D0D13056B3C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0252520C012;
	Wed, 25 Feb 2026 01:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0d9LFagd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC3518DB2A;
	Wed, 25 Feb 2026 01:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983155; cv=none; b=EYI6HuanzVp9yroEepztaLcDKZikJkNyJmzhF/Mmb3cBiKBGxmIlTgbFyYsgQg/0wG5+4UTfnYqVPAsY9ivDirFI8gnpX6df+wGSnsxtDNsuDUA7uk64xY8nLi45jRPgH2k04vvap91s7fDI8X8IFkakX+flhlquGEknZmzrrBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983155; c=relaxed/simple;
	bh=2gGFIjn0RBVcjQcAR8CNoxu6TixVvlxYG5pvUkrtgQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNRJQxVqjod0sxCt2H86jO8Sf5aIKqPhAQnjAomeNYHXG/9vwUT6hkmSusufzGt7lTom/hJAf6TgCxM+QQLaOhGpWwJMqTwuUbfot0K9yrTTVzSVHONycJkXiVeUcwLyem/np19mYY60OqTWddkDtixwVjG8I2nswtEkQvcWeAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0d9LFagd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EAAC116D0;
	Wed, 25 Feb 2026 01:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983155;
	bh=2gGFIjn0RBVcjQcAR8CNoxu6TixVvlxYG5pvUkrtgQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0d9LFagdhqQB3iGwz8y2XiTH/f5cpVQRf93tA+Is1UaCNq6DtyzksQPFGyKFegpUZ
	 xORQ2cFfTq/NRAK/eKwfX9oVi0LgkTH63gYKKCq6R2JDrUM0AjezQX5txhDx4mE5dS
	 TqDU+WXafJmv/ovkKnCgyW7alx+LKpFw/UkvzyVE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 309/781] ASoC: cs4271: Fix resource leak in cs4271_soc_resume()
Date: Tue, 24 Feb 2026 17:16:58 -0800
Message-ID: <20260225012407.284599101@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-218346-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,oracle.com,opensource.cirrus.com,bootlin.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,cirrus.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,bootlin.com:email]
X-Rspamd-Queue-Id: B2A2B18F5C2
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

[ Upstream commit fef1f756155c30511397bbcd9d55640ab2e44d99 ]

Smatch detects this resource leak:

sound/soc/codecs/cs4271.c:548 cs4271_soc_resume() warn:
 'cs4271->clk' from clk_prepare_enable() not released on lines: 540,546.

Instead of direct returns, unprepare the clock and disable regulators on
the error paths.

Fixes: cf6bf51b5325 ("ASoC: cs4271: Add support for the external mclk")
Fixes: 9a397f473657 ("ASoC: cs4271: add regulator consumer support")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Link: https://patch.msgid.link/20260110195337.2522347-1-harshit.m.mogalapalli@oracle.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs4271.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 77dfc83a3c013..d8cdd37e9112b 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -528,7 +528,7 @@ static int cs4271_soc_resume(struct snd_soc_component *component)
 	ret = clk_prepare_enable(cs4271->clk);
 	if (ret) {
 		dev_err(component->dev, "Failed to enable clk: %d\n", ret);
-		return ret;
+		goto err_disable_regulators;
 	}
 
 	/* Do a proper reset after power up */
@@ -537,15 +537,21 @@ static int cs4271_soc_resume(struct snd_soc_component *component)
 	/* Restore codec state */
 	ret = regcache_sync(cs4271->regmap);
 	if (ret < 0)
-		return ret;
+		goto err_disable_clk;
 
 	/* then disable the power-down bit */
 	ret = regmap_update_bits(cs4271->regmap, CS4271_MODE2,
 				 CS4271_MODE2_PDN, 0);
 	if (ret < 0)
-		return ret;
+		goto err_disable_clk;
 
 	return 0;
+
+err_disable_clk:
+	clk_disable_unprepare(cs4271->clk);
+err_disable_regulators:
+	regulator_bulk_disable(ARRAY_SIZE(cs4271->supplies), cs4271->supplies);
+	return ret;
 }
 #else
 #define cs4271_soc_suspend	NULL
-- 
2.51.0




