Return-Path: <stable+bounces-228504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qORdGiFPwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:33:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BD72F4B5A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC96130BA786
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7313B19CA;
	Mon, 23 Mar 2026 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tRWN1UDu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EDF3AC0C2;
	Mon, 23 Mar 2026 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275307; cv=none; b=GXr3zXN6jWKoz8vt9Z59K0fpfsZDLH7D/A9rqYrWoObcONzEQXOBg4n8aQKkhMZL9WaGqgsvWh71oCyVt7AWw2/a60SdSbH1keVZWUNUEby3VzpXp3W4wv1p/B/ctATabSfZ96izuK4jodpjH7m2WAeXT3qklMvR8uKSlIeDa+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275307; c=relaxed/simple;
	bh=blvQ16c+QKeOWG9X0pMrmwCh4V+KLrl0ZtTJjSmPGPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uplywkl4tH+bf+pzo6Tcaauxmo6k3McsAbbz1iRVHxz2se8wd6gvpAyNeOezOt0KN/Xr0aw6nKA5USPxiDl3Dj2tUd207wOueyJTzyrUbOcqpNQD+RmCWPKOe5o2fla72V1bBVRl9x9RwdKGDyOs4meNl19gSX45cvpw7yRAlMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tRWN1UDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317FAC4CEF7;
	Mon, 23 Mar 2026 14:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275307;
	bh=blvQ16c+QKeOWG9X0pMrmwCh4V+KLrl0ZtTJjSmPGPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tRWN1UDuNG6/n2hXKwB9YmoAmKZ+iYHqOBPeczZviZY3q+Tdy7CBphdtLQMfwIFZl
	 BkK2/FUUdCUZ5TSezvkZ1Efs6Oj01IRjQZld2jzb+gEq8r9D8qI2qKbng1EVuQCZbc
	 H6Sg4H8FMakiY0H5RLotHrBCdYxc1a5Cjv+Jmbp0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 048/460] bnxt_en: Fix RSS table size check when changing ethtool channels
Date: Mon, 23 Mar 2026 14:40:44 +0100
Message-ID: <20260323134527.892382359@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_FROM(0.00)[bounces-228504-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 95BD72F4B5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

[ Upstream commit 0d9a60a0618d255530ca56072c5f39eb58e1ed4a ]

When changing channels, the current check in bnxt_set_channels()
is not checking for non-default RSS contexts when the RSS table size
changes. The current check for IFF_RXFH_CONFIGURED is only sufficient
for the default RSS context. Expand the check to include the presence
of any non-default RSS contexts.

Allowing such change will result in incorrect configuration of the
context's RSS table when the table size changes.

Fixes: b3d0083caf9a ("bnxt_en: Support RSS contexts in ethtool .{get|set}_rxfh()")
Reported-by: Björn Töpel <bjorn@kernel.org>
Link: https://lore.kernel.org/netdev/20260303181535.2671734-1-bjorn@kernel.org/
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Link: https://patch.msgid.link/20260306225854.3575672-1-michael.chan@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 0a8f3dc3c2f01..0be9c64ae2fad 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -958,8 +958,8 @@ static int bnxt_set_channels(struct net_device *dev,
 
 	if (bnxt_get_nr_rss_ctxs(bp, req_rx_rings) !=
 	    bnxt_get_nr_rss_ctxs(bp, bp->rx_nr_rings) &&
-	    netif_is_rxfh_configured(dev)) {
-		netdev_warn(dev, "RSS table size change required, RSS table entries must be default to proceed\n");
+	    (netif_is_rxfh_configured(dev) || bp->num_rss_ctx)) {
+		netdev_warn(dev, "RSS table size change required, RSS table entries must be default (with no additional RSS contexts present) to proceed\n");
 		return -EINVAL;
 	}
 
-- 
2.51.0




