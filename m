Return-Path: <stable+bounces-216287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJqHGDVnj2k+QwEAu9opvQ
	(envelope-from <stable+bounces-216287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 19:02:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 497A9138CA5
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 19:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5659030131F9
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 18:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614BB23ED5B;
	Fri, 13 Feb 2026 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T96aE1OE"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0830E3C2F;
	Fri, 13 Feb 2026 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771005740; cv=none; b=DWq8M96t3F9aniOoEIRVh4Bg1bDY6hhXRrjtenu8rn7iZvvxOwnQb6WkPLlc0w0Kb43bl3IIbza4msY9sCbJQhNH8z41jxHfc9Ay01O9NuvtiEv6RtVFzrOVvP/rgKY9eFMejb2B5uFG/rJIrcNvRvLDcAzKLf/CI1s4CCCa/9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771005740; c=relaxed/simple;
	bh=mXqi+ihoqe8CrKNDfS9EP0qg1F41n7FGyjapR79FGdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=spv7yTPtIGwDhAtFpK5SHNE6Q/oPy+I4WGjENgDRqdu0tDIqHeA8Py20culOZglWpTv71oTwvGjpcqc3OPyb5NivQnVXaqKP1AIVA1M3xfPu4cq/DqnGNzllO5Dyf+DfA8piORSIzUuGEZfWdGOXcF/DdWz4RD52EBQGamBy8Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T96aE1OE; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id AE09DC0009C5;
	Fri, 13 Feb 2026 09:57:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com AE09DC0009C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1771005423;
	bh=mXqi+ihoqe8CrKNDfS9EP0qg1F41n7FGyjapR79FGdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T96aE1OEksIGTDIZkOu+yI/C7Gy7OZHtM4Bwea/9fyK5Ek8oZEKDCglZ6sfDtdihy
	 xG2JiTcLa+Cb8Wk2OiWlB1hUGZtbxlc9ltHl6HDJcr5EDRm8O6T249V33u17rOHsfP
	 gUsEClHi8THt6rr9/o7RUnbZoOJQHzXBL50XXeWg=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 10B59AE94;
	Fri, 13 Feb 2026 12:57:02 -0500 (EST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Pierre Gondois <pierre.gondois@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH stable 6.1 1/2] cacheinfo: Decrement refcount in cache_setup_of_node()
Date: Fri, 13 Feb 2026 09:56:59 -0800
Message-Id: <20260213175700.1964980-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213175700.1964980-1-florian.fainelli@broadcom.com>
References: <20260213175700.1964980-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=dkimrelay];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216287-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 497A9138CA5
X-Rspamd-Action: no action

From: Pierre Gondois <pierre.gondois@arm.com>

commit 3da72e18371c41a6f6f96b594854b178168c7757 upstream

Refcounts to DT nodes are only incremented in the function
and never decremented. Decrease the refcounts when necessary.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Link: https://lore.kernel.org/r/20221026185954.991547-1-pierre.gondois@arm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/base/cacheinfo.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 9e11d42b0d64..54a66e4a3460 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -195,7 +195,7 @@ static void cache_of_set_props(struct cacheinfo *this_leaf,
 
 static int cache_setup_of_node(unsigned int cpu)
 {
-	struct device_node *np;
+	struct device_node *np, *prev;
 	struct cacheinfo *this_leaf;
 	unsigned int index = 0;
 
@@ -205,19 +205,24 @@ static int cache_setup_of_node(unsigned int cpu)
 		return -ENOENT;
 	}
 
+	prev = np;
+
 	while (index < cache_leaves(cpu)) {
 		this_leaf = per_cpu_cacheinfo_idx(cpu, index);
-		if (this_leaf->level != 1)
+		if (this_leaf->level != 1) {
 			np = of_find_next_cache_node(np);
-		else
-			np = of_node_get(np);/* cpu node itself */
-		if (!np)
-			break;
+			of_node_put(prev);
+			prev = np;
+			if (!np)
+				break;
+		}
 		cache_of_set_props(this_leaf, np);
 		this_leaf->fw_token = np;
 		index++;
 	}
 
+	of_node_put(np);
+
 	if (index != cache_leaves(cpu)) /* not all OF nodes populated */
 		return -ENOENT;
 
-- 
2.34.1


