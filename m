Return-Path: <stable+bounces-231820-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLFrHUwBzGkoNQYAu9opvQ
	(envelope-from <stable+bounces-231820-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:15:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D088F36E55C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 723AB3128251
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6097442E01F;
	Tue, 31 Mar 2026 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ng6fhdXu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223AA428472;
	Tue, 31 Mar 2026 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975154; cv=none; b=oBl5vqP4oIsn9tv8azZO8ksSzIUsRab+X9U4fE5UCIlZsHcq/MPlvVtuXrDSKuqrLsHRi6iFgKX/rfpulQROD9IMxSDDOiLJBHl7HVHbrzf6LyC56+wQs+g5YW3qdMTJ0zSHTZqWRkvbHWH2UgEJoO+H3bYooxszb3iNehMFjyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975154; c=relaxed/simple;
	bh=4sHqNmihLZtFAfcFUc+wLST4vJUH52DZMKnNl6JHhAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nw/6ZuErJysEzo8VfLCN+FrPQgdJv8sG8EPFq6QLXxM7PwT855x3CphD3Zjv8VOH3fIdpAl2zzN7rq5EEONA2Mno1XZ2R6ysmYnAa64BXqopGrBChYKdyblFKUIvpamRnpYGxhgUvc3ZllAp20yRizpcal8Of0iemo//wewIrsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ng6fhdXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7625FC19423;
	Tue, 31 Mar 2026 16:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975153;
	bh=4sHqNmihLZtFAfcFUc+wLST4vJUH52DZMKnNl6JHhAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ng6fhdXu4A/AT4mTgJglDY5swQLid9Z6RcG0O0ZQT5lA9Nq0bgsLU7nH4e8DBA2SY
	 YDrCqW7QIICxleEuWPEnlDkl3Hxix4YTpirnrpyaH2xoAQEXO4p3aKJvIBfbEhBbFs
	 eAk7/YPzYQhUUUn8oWTbNGxaIwbjudI1wJ8lr0cs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Shuming Fan <shumingf@realtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 184/342] ASoC: SDCA: fix finding wrong entity
Date: Tue, 31 Mar 2026 18:20:17 +0200
Message-ID: <20260331161805.772733591@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231820-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,realtek.com:email,cirrus.com:email]
X-Rspamd-Queue-Id: D088F36E55C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuming Fan <shumingf@realtek.com>

[ Upstream commit c673efd5db2223c2e8b885025bcd96bca6cdb171 ]

This patch fixes an issue like:
where searching for the entity 'FU 11' could incorrectly match 'FU 113' first.
The driver should first perform an exact match on the full string name.
If no exact match is found, it can then fall back to a partial match.

Fixes: 48fa77af2f4a ("ASoC: SDCA: Add terminal type into input/output widget name")
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Shuming Fan <shumingf@realtek.com>
Link: https://patch.msgid.link/20260325110406.3232420-1-shumingf@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sdca/sdca_functions.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sdca/sdca_functions.c b/sound/soc/sdca/sdca_functions.c
index d2de9e81b4f9f..a1f6f931a8081 100644
--- a/sound/soc/sdca/sdca_functions.c
+++ b/sound/soc/sdca/sdca_functions.c
@@ -1568,10 +1568,19 @@ static int find_sdca_entities(struct device *dev, struct sdw_slave *sdw,
 static struct sdca_entity *find_sdca_entity_by_label(struct sdca_function_data *function,
 						     const char *entity_label)
 {
+	struct sdca_entity *entity = NULL;
 	int i;
 
 	for (i = 0; i < function->num_entities; i++) {
-		struct sdca_entity *entity = &function->entities[i];
+		entity = &function->entities[i];
+
+		/* check whole string first*/
+		if (!strcmp(entity->label, entity_label))
+			return entity;
+	}
+
+	for (i = 0; i < function->num_entities; i++) {
+		entity = &function->entities[i];
 
 		if (!strncmp(entity->label, entity_label, strlen(entity_label)))
 			return entity;
-- 
2.53.0




