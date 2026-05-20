Return-Path: <stable+bounces-252010-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id p8THMyz+DWpV5QUAu9opvQ
	(envelope-from <stable+bounces-252010-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:32:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3D759678F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD7EF32E1029
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FF33F54D4;
	Wed, 20 May 2026 17:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b8B8PCT/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1CD3F44D9;
	Wed, 20 May 2026 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299509; cv=none; b=RwRuZrjxPpJjXeC6eS5ZMyKgUOEgcnYU1zx7ZFByTct5fXMlwwaO7pQYAOEi9fClyxwDzbSVK0lPBaVY4p6fI/IJgzdr1AcsPdn5YhYSOnBEMv354rrumfUuQK4UebWCpDcBbZ0Id5yLfUt0PPHOmT3ntzocWrduVMcx2+xZeTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299509; c=relaxed/simple;
	bh=wQXOG1dLEzjZtTPszMQULsQ8z3MRk720UNvsMx82TD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQBJi+2Yq6ylRpbsEjbqtF+vY0qWjJEd30LqGQrPTurMS8ZFr0rtkAHakGz6mb0H5YjWJHU9YTCUQFs/CYMR32m+TUj9ar9SdV3tp8ixOEiiKb/bCM6FSn+W96LgLlFh3x9AT/1jTH3fKdGaLObVDFAXeVIF+5KgFdE42b2nYZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b8B8PCT/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13DC1F000E9;
	Wed, 20 May 2026 17:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299508;
	bh=Tf3FoQd7phewb17z1+zUIOh2zT0WWsQmrb3aoi5A9sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b8B8PCT/BW3ACPEUtHlES05sqb++zaxjZrrOFh+soGMBAR+yIRS29C0EhMIDicyRv
	 8kkmUsjhx5yMnacObCxf1X3cTsWrwc9r4ZoFiP8ISgu38CcX3JiciA8iIwFq41IITE
	 E4fKBAG0YO8sHZyXCIPIYdG75ajT2a5hyZlseWyE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	James Calligeros <jcalligeros99@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 757/957] ASoC: tas2770: Fix order of operations for temperature calculation
Date: Wed, 20 May 2026 18:20:40 +0200
Message-ID: <20260520162150.981996103@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252010-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1C3D759678F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Calligeros <jcalligeros99@gmail.com>

[ Upstream commit c7ecb6a61908c2604dda6e42da66724d256de7b9 ]

The order of operations to derive the temperature from the temp
register values was wrong, since 1000 / 16 is not an integer. This
resulted in the calculated temperature value deviating from the
value represented by the registers slightly, which was most obvious
when the registers were zeroed (-92.265 *C vs the expected -93.000 *C).

Scale the reading before dividing the whole thing by 16 to correct
this.

Fixes: ff73e2780169 ("ASoC: tas2770: expose die temp to hwmon")
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
Link: https://patch.msgid.link/20260425-tas27xx-hwmon-fixes-v1-3-83c13b8e8f54@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2770.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 6f878b01716f7..2ce3011119bdb 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -549,7 +549,7 @@ static int tas2770_read_die_temp(struct tas2770_priv *tas2770, long *result)
 	/*
 	 * As per datasheet: divide register by 16 and subtract 93 to get
 	 * degrees Celsius. hwmon requires millidegrees. Let's avoid rounding
-	 * errors by subtracting 93 * 16 then multiplying by 1000 / 16.
+	 * errors by subtracting 93 * 16 and scaling before dividing.
 	 *
 	 * NOTE: The ADC registers are initialised to 0 on reset. This means
 	 * that the temperature will read -93 *C until the chip is brought out
@@ -558,7 +558,7 @@ static int tas2770_read_die_temp(struct tas2770_priv *tas2770, long *result)
 	 * value read back from its registers will be the last value sampled
 	 * before entering software shutdown.
 	 */
-	*result = (reading - (93 * 16)) * (1000 / 16);
+	*result = (reading - (93 * 16)) * 1000 / 16;
 	return 0;
 }
 
-- 
2.53.0




