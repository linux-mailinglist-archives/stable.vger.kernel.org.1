Return-Path: <stable+bounces-259274-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JQgOxsyG2qqAAkAu9opvQ
	(envelope-from <stable+bounces-259274-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:53:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B94612BC7
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DEF3D30004F9
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFA0242D67;
	Sat, 30 May 2026 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OC9gHyIc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690062E7389;
	Sat, 30 May 2026 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780167193; cv=none; b=iiaphfPMdNoKRRyk4kSBgibAiHwyKAA5LtUXPhBNluCgtcRTilibiJvcdllLei2vPRyD3fiF8RkBzrzfUXgJMYKXAM3ZgaMi8T3FIx4rAubNLQ3oLaUdi+pK+L5CinjRBPDeNig6OfLWccEsOHjv6De+LNbaB4sU+JxRRxWpE4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780167193; c=relaxed/simple;
	bh=T11FWqIN+YW1HLs5Ju+fiZ1cjt8twpeb0sbN0GpVbcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJ0h1P+xVLhiEgvlb6x2J3hDHesoAF47yzqtNXQbfdy0RzamJzSqe4WYgJFaOrY5kKkWWpLL0czQFnWkWiyQZCHEmdqJe8NFou6CiPHDDxjEIP3PFKJ+H2KOgSaEKSfSxUais8Oer8Hp1f57gJG6lJ6mYZk4azrLmvP3BHg9QL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OC9gHyIc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709D71F00893;
	Sat, 30 May 2026 18:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780167192;
	bh=OS7KxnuOLu5AejDWjJIubTSK+oKHCh+hYQ5EnAh4iw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OC9gHyIcWFPUGBKpNTgXKh/6tKfilXsKxv389p+zS6SH4HhWyRP4BtTPbL2PE69TK
	 EastQZTzN3z9xaJVCD69zsq14rogQleBdYuji5tJbWVnwDIWy4b5aXHWTme3eSUqPh
	 kjircoL9tK5Eu3FWqvPLaPXRxFjY+1osV88jCdwo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 578/589] net: ethernet: cs89x0: remove stale CONFIG_MACH_MX31ADS reference
Date: Sat, 30 May 2026 18:07:39 +0200
Message-ID: <20260530160239.794105045@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259274-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,redhat.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 99B94612BC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 33ace33070593..77af8ace4d7b1 100644
--- a/drivers/net/ethernet/cirrus/cs89x0.c
+++ b/drivers/net/ethernet/cirrus/cs89x0.c
@@ -1270,7 +1270,6 @@ static const struct net_device_ops net_ops = {
 
 static void __init reset_chip(struct net_device *dev)
 {
-#if !defined(CONFIG_MACH_MX31ADS)
 	struct net_local *lp = netdev_priv(dev);
 	unsigned long reset_start_time;
 
@@ -1297,7 +1296,6 @@ static void __init reset_chip(struct net_device *dev)
 	while ((readreg(dev, PP_SelfST) & INIT_DONE) == 0 &&
 	       time_before(jiffies, reset_start_time + 2))
 		;
-#endif /* !CONFIG_MACH_MX31ADS */
 }
 
 /* This is the real probe routine.
-- 
2.53.0




