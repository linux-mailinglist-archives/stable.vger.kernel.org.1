Return-Path: <stable+bounces-271082-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3iMBJLyaRmqoZwsAu9opvQ
	(envelope-from <stable+bounces-271082-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:07:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 772866FB010
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:07:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="Az/bNV7V";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271082-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-271082-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3C0F32F68FC
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66533A254B;
	Thu,  2 Jul 2026 16:43:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B116039B972;
	Thu,  2 Jul 2026 16:43:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010622; cv=none; b=LIoDrMxmEmSUQRPcW31zN5d7RdFUl8V8cfU+40+kyeB/Jn0cCW1K2KJwxBlzXTSHc/+2SYD7QQZCtl4CX8n0QDBRi98RuABwfmPfgHLcE9bMeLeYV/DfxCmOcYLm3tbR8Oo6x1pSO79e8RNTowrV1NgJgmsTxPBOJKQ+gzmcuWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010622; c=relaxed/simple;
	bh=TL4hVHrnYcuysNMHhObljMw+ElenEhnBQC1BDapI2pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ngdh6H6pCyQtp61Ow/7UQ6txR7Rh4uH7sBe8371asTrI39eaKpeAT+DlI0tZHBedovB+pHIMtxQ6XXdwDVMS72BGqOyyhbA1FOzZYlacX736+vazr2Xnfntj1Qp/87aQmNrtHMBVuMPsdCwX+VbSGDrVX8OwRCZoLoGC1xXWbhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Az/bNV7V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2355C1F000E9;
	Thu,  2 Jul 2026 16:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010621;
	bh=dv46do1+GhlzsmyDMBAZJ6iTxuo7QXUwmeVfyK1En2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Az/bNV7VHZOS2ViAYIZfR0SmmjMenneqHHrgEsk6pyNmnAXhwgMV266MVReSFnY+R
	 0TVEcg8grDDfb/mk3InJB8ed3sGzg5oTXMVIc8c8Mu0sbSIcAxyMdgCPcoP3E2X4AF
	 ShX10zwnwJ8vxUl532anAFUqrXB80zXgPQdpebvU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 6.12 179/204] power: reset: linkstation-poweroff: fix use-after-free in the linkstation_poweroff_init()
Date: Thu,  2 Jul 2026 18:20:36 +0200
Message-ID: <20260702155122.405838803@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:vulab@iscas.ac.cn,m:sebastian.reichel@collabora.com,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271082-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,collabora.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 772866FB010

6.12-stable review patch.  If anyone has any objections, please let me know.

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



