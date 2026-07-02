Return-Path: <stable+bounces-271270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +kx0DESaRmppZwsAu9opvQ
	(envelope-from <stable+bounces-271270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:05:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D7B6FAF51
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:05:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=AJbLZbG7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271270-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271270-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7E9533A11B1
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94F1349CEF;
	Thu,  2 Jul 2026 16:51:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B8319049B;
	Thu,  2 Jul 2026 16:51:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011108; cv=none; b=MmAFcv4OpdGtX12vn80POPBH8f455eG4JnYoy/yJTXwzu8896eWMj+aGpvHEpnSObpuREN8cYDd/MMsWGN1NOc1xawLzLCIyVgQnPQZ7fdqskHKDU0m6ycwsYtprvQy7YrN83S7FRXzYdiAtull9sQSb1y6SSVmtnrk1N/J23m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011108; c=relaxed/simple;
	bh=bjJ0QcRUsz+AXIbf4qIbNf6YvS2bLTWCZYR64thKzLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMfwzz9iO1pZyyghZOmP3Ef4nJuY2R8TuI+AwRbnh1Gst6DvqhL9pu7ROqoZ63a3uN72oMRZk98gG8uuS2oE790eSJRd8lmJEYb1RWCbMmP8QtTI6AKuWQVf4izQJ0fa/L8ALVmPlFg9xkRpLxvdJYdByGKN2vZ4sTtaOo3ze50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AJbLZbG7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C921F00A3A;
	Thu,  2 Jul 2026 16:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011107;
	bh=41xR6js+O8sEQa6DNbxCqcalwNnx4SPIAigs7U2btNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AJbLZbG7ADyXlWtwasTX4lM3eEP+6NKg7lF1CNtNxnj3NaxKjDrMSPo7zMAdMUVL8
	 EEfeq5vtDgcvk9e8eA3BIEKcMB8yHYC0tkJUEc/pJQDbLM3+nFdn9EOzkHIzK0ttyI
	 YNQHCmkSZ9gqGIUyM2RMxe1ZY6NicReye6qV35jM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 6.6 159/175] power: reset: linkstation-poweroff: fix use-after-free in the linkstation_poweroff_init()
Date: Thu,  2 Jul 2026 18:21:00 +0200
Message-ID: <20260702155119.143000117@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>
References: <20260702155115.766838875@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271270-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:vulab@iscas.ac.cn,m:sebastian.reichel@collabora.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68D7B6FAF51

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentao Liang <vulab@iscas.ac.cn>

commit 8eec545cde69e46e9a1d2b7d915ce4f5df85b3bd upstream.

Move of_node_put(dn) after the of_match_node() call, which still needs
the node pointer. The node reference is correctly released after use.

Fixes: e2f471efe1d6 ("power: reset: linkstation-poweroff: prepare for new devices")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260407073025.271865-1-vulab@iscas.ac.cn
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/reset/linkstation-poweroff.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/power/reset/linkstation-poweroff.c
+++ b/drivers/power/reset/linkstation-poweroff.c
@@ -163,10 +163,10 @@ static int __init linkstation_poweroff_i
 	dn = of_find_matching_node(NULL, ls_poweroff_of_match);
 	if (!dn)
 		return -ENODEV;
-	of_node_put(dn);
 
 	match = of_match_node(ls_poweroff_of_match, dn);
 	cfg = match->data;
+	of_node_put(dn);
 
 	dn = of_find_node_by_name(NULL, cfg->mdio_node_name);
 	if (!dn)



