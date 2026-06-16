Return-Path: <stable+bounces-263970-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Vl7mIYltMWpQjAUAu9opvQ
	(envelope-from <stable+bounces-263970-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:36:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DBD691343
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:36:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=fZa9qTkZ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263970-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263970-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F17FB30A625B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3D844A71B;
	Tue, 16 Jun 2026 15:24:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B80544B66E;
	Tue, 16 Jun 2026 15:24:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623450; cv=none; b=Mo2Nn2M1C/XYXg7m3NqMJ1XXtpQIkGQXhmz4J+P4+SO/SrbZX+C1Ba//wzHKGl4sb24YJFm9auRMphu7HmwLYVwKPs+z+AuzqV0bozGKb9D0KtmPGGPrFAOeDyjRj2EHG81wanWoW254XEye3+rRb6p3GqNtdofQqQmeDPv3z6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623450; c=relaxed/simple;
	bh=TCYywJd5oiyrITkL0XnmrSQ+/KsmxpVjHIZXykrY7eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2pRL1xrk4iTjF+/HsZZnrtLfKIbOy4CXAjOZK0o9eTMNJw07d2vgsFBrxd8H304oT2to3Rf3beiGqv18ZQW7k8bB8cv7jpy+aTyjRcSD/DE1jvHU8xODKw6VQqmZZKfUA4rDkXgj6k69so2e8Dm9esx62My0C3BBWQMejyZS9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fZa9qTkZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634E71F000E9;
	Tue, 16 Jun 2026 15:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623449;
	bh=wFJCg2nZe3lj5pu76n/amKYyq58vHQgYZO46YwSwRj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fZa9qTkZNbcQnXg7MjYbypwDmLHhXclQmAepX0k9aU49TfuKYvIxylqBesbYDrzeB
	 99TgKwIJv+Zli38gE/PXaoBXrHtaIP3VmQcfpHQGLc8VMvveWTtEJru85qwRV9n9Nl
	 vCjDx/E8HHJnzZJ470IuSkOCnT8fIYvRquV1Fozc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 151/378] net: txgbe: distinguish module types by checking identifier
Date: Tue, 16 Jun 2026 20:26:22 +0530
Message-ID: <20260616145118.198163439@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263970-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jiawenwu@trustnetic.com,m:pabeni@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,trustnetic.com:email,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9DBD691343

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiawen Wu <jiawenwu@trustnetic.com>

[ Upstream commit f2df54ddbfb04a006ee326a5d8270434a414e0af ]

Rework txgbe_identify_module() to validate module identifiers through
explicit type checks instead of relying on transceiver_type heuristics.
When using the SFP module, transceiver_type could be a random value,
because it was read from an invalid register.

Fixes: 57d39faed4c9 ("net: txgbe: improve functions of AML 40G devices")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Link: https://patch.msgid.link/20260608070842.36504-3-jiawenwu@trustnetic.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
index a7e81f9e1be148..bdac654a236465 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
@@ -357,18 +357,16 @@ int txgbe_identify_module(struct wx *wx)
 	}
 
 	id = &buffer.id;
-	if (id->identifier != TXGBE_SFF_IDENTIFIER_SFP &&
-	    id->identifier != TXGBE_SFF_IDENTIFIER_QSFP &&
-	    id->identifier != TXGBE_SFF_IDENTIFIER_QSFP_PLUS &&
-	    id->identifier != TXGBE_SFF_IDENTIFIER_QSFP28) {
-		wx_err(wx, "Invalid module\n");
-		return -ENODEV;
-	}
-
-	if (id->transceiver_type == 0xFF)
+	if (id->identifier == TXGBE_SFF_IDENTIFIER_SFP)
 		return txgbe_sfp_to_linkmodes(wx, id);
 
-	return txgbe_qsfp_to_linkmodes(wx, id);
+	if (id->identifier == TXGBE_SFF_IDENTIFIER_QSFP ||
+	    id->identifier == TXGBE_SFF_IDENTIFIER_QSFP_PLUS ||
+	    id->identifier == TXGBE_SFF_IDENTIFIER_QSFP28)
+		return txgbe_qsfp_to_linkmodes(wx, id);
+
+	wx_err(wx, "Invalid module\n");
+	return -EINVAL;
 }
 
 void txgbe_setup_link(struct wx *wx)
-- 
2.53.0




