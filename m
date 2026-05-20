Return-Path: <stable+bounces-250274-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AC+yI6rlDWpz4gUAu9opvQ
	(envelope-from <stable+bounces-250274-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:47:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 207F3592731
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55D1730BB535
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4ECB369999;
	Wed, 20 May 2026 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Te7uU1MW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418E02673AA;
	Wed, 20 May 2026 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294983; cv=none; b=B6UNELgIaxKaZMJLda631XqzQC8qDWj3VQWGTn8uqOu/JTqoEWqhEWGNn2ig/DcyMeOjg4BdXzh+HH5LeCk/VikDIoauzMnEDsgbBUCjIiSnJ0LFb16SJaMs3FFZ92W3pzgh14RhiFZNLQZEavSYYyVvF56AN16Rzs8KRrkm6fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294983; c=relaxed/simple;
	bh=sTKyjxMsjmDsYmL8Ff5z/0MGp7y/IXAKO94S3l2MJmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbRUdMwMrzsBrhRkoSSAHVh73piYvuiDynj9eXXnWryoCSKReurzAYigg4YfaIYm7Oagvd5ih4aOY9xBS/B0m+wgunZUrgBTXF191O8hOSdwIBOFiQtayN8sDiKdWnS+eDN2GxYMH/dIG76k6kHZ2cbTdLRdsQb0USecKRgdKVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Te7uU1MW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07AC1F00893;
	Wed, 20 May 2026 16:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294982;
	bh=ie1qFGKpMnni145PAisIldDTPnKNCfKSBLV9EW5H/aY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Te7uU1MW+bolE3oaAMSxAAqIotvJ2Fck1rOnmd/Vlnu1ete3ZCP3f/1tnmsWLe6EJ
	 D9RMoCprA1VOkhmQnsR0x+tAn6oEa640UwiiEqpzt2EkMvjaKFJj6zKYl55VacQY/L
	 CTHUAqZ5TSzpvrtL3f1fE6dvk8IjAlg43nV06gis=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0245/1146] ASoC: SDCA: Add default value for mipi-sdca-function-reset-max-delay
Date: Wed, 20 May 2026 18:08:15 +0200
Message-ID: <20260520162153.783647788@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250274-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,cirrus.com:email]
X-Rspamd-Queue-Id: 207F3592731
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 1bbbda5b178a1399339139eb3c326300008b72d6 ]

Add a default value for the function reset timeout since version 1.0
of the SDCA specification doesn't actually include this property, it
was added later.

Fixes: 7b6be935e7ef ("ASoC: SDCA: Parse Function Reset max delay")
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://patch.msgid.link/20260225140118.402695-2-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sdca/sdca_fdl.c       | 5 -----
 sound/soc/sdca/sdca_functions.c | 6 +++++-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sdca/sdca_fdl.c b/sound/soc/sdca/sdca_fdl.c
index 07892bc3a44e6..994821a6df617 100644
--- a/sound/soc/sdca/sdca_fdl.c
+++ b/sound/soc/sdca/sdca_fdl.c
@@ -46,11 +46,6 @@ int sdca_reset_function(struct device *dev, struct sdca_function_data *function,
 	if (ret) // Allowed for function reset to not be implemented
 		return 0;
 
-	if (!function->reset_max_delay) {
-		dev_err(dev, "No reset delay specified in DisCo\n");
-		return -EINVAL;
-	}
-
 	/*
 	 * Poll up to 16 times but no more than once per ms, these are just
 	 * arbitrarily selected values, so may be fine tuned in future.
diff --git a/sound/soc/sdca/sdca_functions.c b/sound/soc/sdca/sdca_functions.c
index dca60ee8e62c3..fd6a254c95305 100644
--- a/sound/soc/sdca/sdca_functions.c
+++ b/sound/soc/sdca/sdca_functions.c
@@ -2176,8 +2176,12 @@ int sdca_parse_function(struct device *dev, struct sdw_slave *sdw,
 
 	ret = fwnode_property_read_u32(function_desc->node,
 				       "mipi-sdca-function-reset-max-delay", &tmp);
-	if (!ret)
+	if (ret || tmp == 0) {
+		dev_dbg(dev, "reset delay missing, defaulting to 100mS\n");
+		function->reset_max_delay = 100000;
+	} else {
 		function->reset_max_delay = tmp;
+	}
 
 	dev_dbg(dev, "%pfwP: name %s busy delay %dus reset delay %dus\n",
 		function->desc->node, function->desc->name,
-- 
2.53.0




