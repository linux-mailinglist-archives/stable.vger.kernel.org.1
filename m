Return-Path: <stable+bounces-264288-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0NREDN1yMWp8jgUAu9opvQ
	(envelope-from <stable+bounces-264288-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:59:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EB369198D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:59:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Y+EWWIBS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264288-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264288-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4EE0630320A3
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D343044B68E;
	Tue, 16 Jun 2026 15:52:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75F915B998;
	Tue, 16 Jun 2026 15:52:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625174; cv=none; b=YpHyc9Tx37pGMyoOA429oByZAp6mw59Pfk2GZjRoSxay8OaWNFLgLXgtAhpAtZ4Ec/Dfqs09P58ndUIWyH63fI2cGDntcVvPNqZ+BpDWZpmM5RRfj0ZB+k/yn9J482Kl40oMuFRqVNdMznGX5nLLgYraa+ldAMeqsqNcaCkRef4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625174; c=relaxed/simple;
	bh=Tb41KxDta9HnrxK0wTXK5yHXZoXIKmElBTWDwlTYRBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiiRxPgUBOjNDWjGIodcplIbGJrWgzidMF7HIO8vl8fLZcnU+SLT32hMXmCqRYYUHgzKq4vk/Hvzg/+ZURrWgvZn5SIXDmXsND73BdJBEETe6n6BC2utBbs0ZC8rqRrx9qNEeYrsQVhE6v0wwL7FRSJS0LBlPFxO/p9NL3bM3Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y+EWWIBS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82BA1F000E9;
	Tue, 16 Jun 2026 15:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625173;
	bh=1A6ZFK4hj8Tjfjait4uoKKsodPuO9xXeoY6wdLpLMT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y+EWWIBSI8Hu4FYZnXul/TKX0ZHON/IZ5yQM9Gab3sGFYq+/jFRr/jy51ls1JGjw3
	 jQGL6fIQ58O9iK31tETiARzvQiJrbGLB3vTtJwPeItZHs7JXQk9LIJPmtHU4rp0m3p
	 ap9pBdCqFWO830GFyBaBoKAV4BOvwniYsxE8qCQ0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 092/325] net: ena: PHC: Add missing barrier
Date: Tue, 16 Jun 2026 20:28:08 +0530
Message-ID: <20260616145102.284976709@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264288-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:akiyano@amazon.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2EB369198D

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arthur Kiyanovski <akiyano@amazon.com>

[ Upstream commit 954981dbbfbd78f21d2fbac1ac0742dbf38b4e69 ]

Add dma_rmb() barrier after req_id completion check in
ena_com_phc_get_timestamp(). On weakly-ordered architectures,
payload fields may be read before req_id is observed as updated.

Fixes: e0ea34158ee8 ("net: ena: Add PHC support in the ENA driver")
Closes: https://sashiko.dev/#/patchset/20260430032507.11586-1-akiyano%40amazon.com
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 8c86789d867a5f..297fb36ab8c16f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -1880,6 +1880,11 @@ int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
 			continue;
 		}
 
+		/* Ensure PHC payload (timestamp, error_flags) is read
+		 * after req_id update is observed
+		 */
+		dma_rmb();
+
 		/* req_id was updated by the device which indicates that
 		 * PHC timestamp and error_flags are updated too,
 		 * checking errors before retrieving timestamp
-- 
2.53.0




