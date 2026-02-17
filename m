Return-Path: <stable+bounces-217031-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGQLFKfTlGnHIAIAu9opvQ
	(envelope-from <stable+bounces-217031-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:46:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AB8150410
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D49D3007A6E
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69335284B3B;
	Tue, 17 Feb 2026 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sV2g33SZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C11E29A1;
	Tue, 17 Feb 2026 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361186; cv=none; b=OqJZNeUr2szypqI90yDguCYY/AqbGfRuBTveDJsLyJOSoDpM9wS6B0aH2BLFQV9+B72Z6WTLDPtwpQubOmksTodKGurhTsuoS81E5DmcPm58BtUXfgigSosGp9IZPTaMON685+FDsCjIO8GkgIT00atSbEvP4i0SWd+ra0cAsc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361186; c=relaxed/simple;
	bh=MZqO1/+mwq6XJeH2nNektev/8SM54y28sq95r+m538Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEgTThZ5guZzLB7N4AmIx6QSPyzwalpS24TWK+luttvpycZvbSqPZywFfCTUBaXxuWpanOo41mA+qgBEGQnch/is8uWgG6ix1Dua7YNGNCrU9+ELVbLSEkq7nAfoUIbWre1a+tjbn6bhXnCoD0lHpdVGKpwOTHKJY0Q+ANvgswA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sV2g33SZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CF2C4CEF7;
	Tue, 17 Feb 2026 20:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361186;
	bh=MZqO1/+mwq6XJeH2nNektev/8SM54y28sq95r+m538Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sV2g33SZ2BrpceBSYPRp4NNGT7iEjwrUWG0FLTSCgPcqXJYg34k7+BWf2li/RyzK6
	 Z4Txau0IQfPoWeEURM+etF7+7Fya3odgodLDRFkmEtYSyMK8mla7AVmK3JDeC8llK8
	 hfOTHGL1x181AhpoeqM61zrnXDd/p0Yoo3IzZsmQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pierre Gondois <pierre.gondois@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 6.1 26/64] cacheinfo: Decrement refcount in cache_setup_of_node()
Date: Tue, 17 Feb 2026 21:31:22 +0100
Message-ID: <20260217200008.504716328@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200007.505931165@linuxfoundation.org>
References: <20260217200007.505931165@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217031-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,broadcom.com:email]
X-Rspamd-Queue-Id: 89AB8150410
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre Gondois <pierre.gondois@arm.com>

commit 3da72e18371c41a6f6f96b594854b178168c7757 upstream

Refcounts to DT nodes are only incremented in the function
and never decremented. Decrease the refcounts when necessary.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Link: https://lore.kernel.org/r/20221026185954.991547-1-pierre.gondois@arm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/cacheinfo.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -195,7 +195,7 @@ static void cache_of_set_props(struct ca
 
 static int cache_setup_of_node(unsigned int cpu)
 {
-	struct device_node *np;
+	struct device_node *np, *prev;
 	struct cacheinfo *this_leaf;
 	unsigned int index = 0;
 
@@ -205,19 +205,24 @@ static int cache_setup_of_node(unsigned
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
 



