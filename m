Return-Path: <stable+bounces-256350-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IInhBmOsGGphmAgAu9opvQ
	(envelope-from <stable+bounces-256350-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:58:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF0C5F9F02
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31E53300614D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5AB328B7B;
	Thu, 28 May 2026 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j6mr6yiT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE2731159C;
	Thu, 28 May 2026 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001455; cv=none; b=ZYv2dJFb3IbFaMotcuXMJHtp7KYuxqMq8lvU9fZ6CbEeua3CNFgImyyKKU5lO0KXOadyxt85awOBZFlH1Zy9kRZnrKHUqImmT4qDg0NrbbUJzeroibU8THgG4m1eJXiRpk+1MonA6YxNyNrQW1lqc2Y5DwlvbcTavzmrkXl+gD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001455; c=relaxed/simple;
	bh=/SH8na6lU4bvYFhsNdMgH+QQtLgw72Rg+h9dDLS0hj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiTdCYSm7eXlRmEp/lp6H4m5jr88P7BTtbHQjDhXS1yB36GRTkxc26AEall8rgYaFDk99mgzqkK2SEs7oX8fIfZtBsKtkgBEG2+FaR3eOOOQjN3cQbNh3Do45NiNloZpMrEF8pGCk44dJaAorUsvp7f6dFJajIsJmvxVN9DQdcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j6mr6yiT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FF61F000E9;
	Thu, 28 May 2026 20:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001453;
	bh=/lnf+fHSDW79CM7uR1ZeFuymmOowo5cz1GbWZgAuQTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j6mr6yiT50+KaxuOKu8GWJTubYDf7eQY4+17mrIb3wRVg1dyQpUgHRLN4Ro62QK4n
	 01z+Vf6beplTMgPHJVh7+3SBempmC5m/PJJ3xHfx8lOHsMLxKDtJdp+XHkxPkshKyp
	 Fr93wszVW7Rxi5qbdrqz0GegbDvtthiam9WcNImU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 133/186] net: ethernet: cs89x0: remove stale CONFIG_MACH_MX31ADS reference
Date: Thu, 28 May 2026 21:50:13 +0200
Message-ID: <20260528194932.540472710@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256350-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,redhat.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: ECF0C5F9F02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ethan Nelson-Moore <enelsonmoore@gmail.com>

[ Upstream commit 36a8d04a8293afcb9304cf0cd3741f67698f2a1a ]

The legacy ARM board file for MACH_MX31ADS was removed in commit
c93197b0041d ("ARM: imx: Remove i.MX31 board files"), but a reference
to it remained in the cs89x0 driver. Drop this unused code.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Fixes: c93197b0041d ("ARM: imx: Remove i.MX31 board files")
Link: https://patch.msgid.link/20260509023732.42256-1-enelsonmoore@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cirrus/cs89x0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/cirrus/cs89x0.c b/drivers/net/ethernet/cirrus/cs89x0.c
index d323c5c23521f..e6e9c8a576af4 100644
--- a/drivers/net/ethernet/cirrus/cs89x0.c
+++ b/drivers/net/ethernet/cirrus/cs89x0.c
@@ -1271,7 +1271,6 @@ static const struct net_device_ops net_ops = {
 
 static void __init reset_chip(struct net_device *dev)
 {
-#if !defined(CONFIG_MACH_MX31ADS)
 	struct net_local *lp = netdev_priv(dev);
 	unsigned long reset_start_time;
 
@@ -1298,7 +1297,6 @@ static void __init reset_chip(struct net_device *dev)
 	while ((readreg(dev, PP_SelfST) & INIT_DONE) == 0 &&
 	       time_before(jiffies, reset_start_time + 2))
 		;
-#endif /* !CONFIG_MACH_MX31ADS */
 }
 
 /* This is the real probe routine.
-- 
2.53.0




