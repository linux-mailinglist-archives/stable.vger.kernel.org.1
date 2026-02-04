Return-Path: <stable+bounces-213773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG1bFDZlg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:26:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C06C8E8934
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A04B316D788
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667CF421F01;
	Wed,  4 Feb 2026 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x0UEG+kg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E0518871F;
	Wed,  4 Feb 2026 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217464; cv=none; b=lmRycDDcYJxaOdBKJ+5TrBOETtZ+HULdTxuZDqkgua4GARmKkX4EBOXWhMS5GbLoOLBpjRCl1OUhp9bqdbaYN/nmOZepC2h++a/pkbDOkt8kWIOftWb3YvIGcGbCGxSoK2WmrQyl55syChO4oO4f1FNbKXy/j/tUlz06IvgJEFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217464; c=relaxed/simple;
	bh=uKQrg53avu4S6muhDBP8Qiyl8BwHa6sWawk9ewIpNjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyWaDCw5xHT/evz+4V16MLYuo86txerThHEnbagZa3iy6UiXyGCA7OJdFCcHpub8wLeBAqAy3SOqyYyj7X64XgPSzuxVYavxAn+5vKFzc1oXHT8PRLJqwRMClB6WpMNZIIWdqdaj6yx6s/gB7LPNJ2z3P1Dt8FXi+qDEZw8uYvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x0UEG+kg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573C3C4CEF7;
	Wed,  4 Feb 2026 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217464;
	bh=uKQrg53avu4S6muhDBP8Qiyl8BwHa6sWawk9ewIpNjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x0UEG+kgNolxAubqftMI9J98pCkdj4iZCjP3uMax13CbenXxvH2gN3OmD9wvjeVdL
	 8PanHW82leNalnN2JyMF5LUZNSy/+bCp68hKdElIRiq8mwORbkZCXDks3ixoF1Yvcu
	 xbSv8E0I7z7wwGnoXZ7kooLIQBiGxEgxzw7J3iZM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 023/280] net: hv_netvsc: reject RSS hash key programming without RX indirection table
Date: Wed,  4 Feb 2026 15:36:37 +0100
Message-ID: <20260204143910.466919545@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-213773-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C06C8E8934
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aditya Garg <gargaditya@linux.microsoft.com>

[ Upstream commit d23564955811da493f34412d7de60fa268c8cb50 ]

RSS configuration requires a valid RX indirection table. When the device
reports a single receive queue, rndis_filter_device_add() does not
allocate an indirection table, accepting RSS hash key updates in this
state leads to a hang.

Fix this by gating netvsc_set_rxfh() on ndc->rx_table_sz and return
-EOPNOTSUPP when the table is absent. This aligns set_rxfh with the device
capabilities and prevents incorrect behavior.

Fixes: 962f3fee83a4 ("netvsc: add ethtool ops to get/set RSS key")
Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Link: https://patch.msgid.link/1768212093-1594-1-git-send-email-gargaditya@linux.microsoft.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/netvsc_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 68dfe77a6bbfe..20c584f46ec01 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1762,6 +1762,9 @@ static int netvsc_set_rxfh(struct net_device *dev, const u32 *indir,
 	if (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
 
+	if (!ndc->rx_table_sz)
+		return -EOPNOTSUPP;
+
 	rndis_dev = ndev->extension;
 	if (indir) {
 		for (i = 0; i < ndc->rx_table_sz; i++)
-- 
2.51.0




