Return-Path: <stable+bounces-255326-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFRNOPmgGGqblggAu9opvQ
	(envelope-from <stable+bounces-255326-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:09:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 781115F7EDC
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C761D313F5FF
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0280E27A476;
	Thu, 28 May 2026 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hF4Bn+iL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FF6335566;
	Thu, 28 May 2026 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998594; cv=none; b=Xu+pn71vKbr/IDjY8gkK1vmq5HCKC0287hzAvZ2i/t9ceUiSm1CqijEiNGLB/L/UomiEZ7lVYB4CsWwmFVVfxT1PwCiadxku/U3iWmrWq54cHN7nq6EOVeFB43go2R5nLGu8RG7f+pu1zi8Pat4lXsC/onvanhjR9WAnxRAiWTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998594; c=relaxed/simple;
	bh=sbnBCSxTU4OXu1epT0FH4YtrJW41z6qhHzmsHgtp6cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OK3hPRtyeSaykQq5hj2mbmO6ErHVZcKgflLaBtbBPSgXXBE5rT7XbD8JDVHOpidbI30tnTWFVKbgvwLQLsr+8KtLknsDOmZet26bddnZzan3kp+juXeriNKMWl8l21ZdMXpSfG/S5Q8DznB9LtjuPkL3IxJjHYooLEXUAVGbtIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hF4Bn+iL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FAF1F000E9;
	Thu, 28 May 2026 20:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998593;
	bh=Hi5fEHCQf0u27AbB/AZbKYkbX1ou2uzSTFOQ0ovrZno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hF4Bn+iLDmxb+3rdo0gquabClDOBlAuTTXEqKpsYXXtmS285zCTgQY1EOcgraVb1V
	 DNiaFe4TberNu3repsEJEebET3DwjP0pWrgL0lf08rEfBnO4FXmsHRgQu8LMnInK8t
	 ufx+CEIrPh2Lf9tGwpF5tW1QFXXkuL8Pfc8Oy8dQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 228/461] net: ti: icssm-prueth: fix eth_ports_node leak in probe
Date: Thu, 28 May 2026 21:45:57 +0200
Message-ID: <20260528194653.734596466@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255326-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cambiumnetworks.com:email]
X-Rspamd-Queue-Id: 781115F7EDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>

[ Upstream commit 6635fa84403c3a59455b66007c019a7cc632db30 ]

The error path on of_property_read_u32() failure inside
icssm_prueth_probe() returns without putting eth_ports_node,
which was acquired before the for_each_child_of_node() loop.

Drop it before returning.

Fixes: 511f6c1ae093 ("net: ti: icssm-prueth: Adds ICSSM Ethernet driver")
Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Link: https://patch.msgid.link/20260506195813.641610-1-shitalkumar.gandhi@cambiumnetworks.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/icssm/icssm_prueth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
index 53bbd92909042..b7e94244355a3 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
@@ -1825,6 +1825,7 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 			dev_err(dev, "%pOF error reading port_id %d\n",
 				eth_node, ret);
 			of_node_put(eth_node);
+			of_node_put(eth_ports_node);
 			return ret;
 		}
 
-- 
2.53.0




