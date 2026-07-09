Return-Path: <stable+bounces-272844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0L+oEIRcT2rLfAIAu9opvQ
	(envelope-from <stable+bounces-272844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 10:32:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C2872E50C
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 10:32:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="NbR8fW/U";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272844-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272844-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BC0830488C7
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 08:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023623ED5B2;
	Thu,  9 Jul 2026 08:28:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64DA3E8343;
	Thu,  9 Jul 2026 08:28:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585702; cv=none; b=AFwYxOdBeqgZPC8E8Sebpx1FsT1IewIWSw7Oujw5ebm++EQU/IT2jWJ8arjAtiIwx8YnRHdtRx/TBcQxZaCKpGj+LWw7ex5R3WreSzHNzLgIaxZovIuI64ik4DSwCuTOkzTDDzQcCJombZkax3eELx4Q8sc9OkOjrdySNO1J5k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585702; c=relaxed/simple;
	bh=W8aJmWsDCYzrglo4hW4OCZU5ACiR5TWfwBS1+eul67Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FlsRFIMKN/mLrMGdUwDUS0Lg+dQFDctAetWZtLEODlhSJUFrvQ3gxZFEts9bbJ6hHtIBSUoMRdL/vRbj/3pbtYfZ3yfl6/DGylBav8JXE3C8NwCi3VHN/4W/Eyi3YLuTZ2iTi0E3yX0N0/IRgCAo3CJKkLXBwosnPxqlIc9JH5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbR8fW/U; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639181F000E9;
	Thu,  9 Jul 2026 08:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783585701;
	bh=Cmoq6VMbPVy85en+8zJIIsm8Vs79+cKUgRAaAO2MN30=;
	h=From:To:Cc:Subject:Date;
	b=NbR8fW/UUNrdd+NqJi7VrAoPQap66t0KZK3vCV0OP8i/q06gq1TEOYXqXpUjUw7ja
	 t8IKu9tnGZyrfS/gg5YMHntuh9poH1gG1xtg4igjyqVKe73FPQ/Pz3PRhVUQ43fyog
	 V0vsmMt/10CKSf4aX5ojVmlZ4k6QCpra0zsSexK9YUqDAvCX+hDvY9h99Rxluj8Gvx
	 Vmn3Om7ga7t2nrE5KHD9PDv2H2BOVS56kxh8qDe9dkGONfX+aJfVSz3NVHe9Qhh+bM
	 6E8D+zauIZ8U4NomtuQYd+cVyWm+kSAE4ZuwuHRpB3MPSNcFUAgoJcDe+UO17u2L0/
	 QAnoFxY+Rtlmg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1whk7G-00000003TnL-3esa;
	Thu, 09 Jul 2026 10:28:18 +0200
From: Johan Hovold <johan@kernel.org>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David S Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
	netdev@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] net: mvneta: bm: fix device reference leak on failed lookup
Date: Thu,  9 Jul 2026 10:27:13 +0200
Message-ID: <20260709082713.829446-1-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:gregory.clement@bootlin.com,m:netdev@vger.kernel.org,m:johan@kernel.org,m:stable@vger.kernel.org,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-272844-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85C2872E50C

Make sure to drop the reference taken to the buffer manager device when
attempting to look up its driver data before the driver has been bound.

Note that holding a reference to a device does not prevent its driver
data from going away.

Fixes: 965cbbec7f20 ("net: mvneta: remove data pointer usage from device_node structure")
Cc: stable@vger.kernel.org	# 4.19
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/ethernet/marvell/mvneta_bm.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta_bm.c b/drivers/net/ethernet/marvell/mvneta_bm.c
index 6bb380494919..128fe1f512b4 100644
--- a/drivers/net/ethernet/marvell/mvneta_bm.c
+++ b/drivers/net/ethernet/marvell/mvneta_bm.c
@@ -395,9 +395,20 @@ static void mvneta_bm_put_sram(struct mvneta_bm *priv)
 
 struct mvneta_bm *mvneta_bm_get(struct device_node *node)
 {
-	struct platform_device *pdev = of_find_device_by_node(node);
+	struct platform_device *pdev;
+	struct mvneta_bm *priv;
+
+	pdev = of_find_device_by_node(node);
+	if (!pdev)
+		return NULL;
+
+	priv = platform_get_drvdata(pdev);
+	if (!priv) {
+		platform_device_put(pdev);
+		return NULL;
+	}
 
-	return pdev ? platform_get_drvdata(pdev) : NULL;
+	return priv;
 }
 EXPORT_SYMBOL_GPL(mvneta_bm_get);
 
-- 
2.54.0


