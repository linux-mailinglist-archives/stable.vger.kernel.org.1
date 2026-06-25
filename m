Return-Path: <stable+bounces-268405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LirTFxsoPWpWyAgAu9opvQ
	(envelope-from <stable+bounces-268405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:07:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B270D6C5E99
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:07:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=pqDMNCFc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268405-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268405-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7920300C585
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A052BE026;
	Thu, 25 Jun 2026 13:05:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A2623E25B;
	Thu, 25 Jun 2026 13:05:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392744; cv=none; b=ZBR2LLcqgSdtejQnKBSSbvSg8JfWrcca+YwrrchTUNFF5f2U+0g1OoiBIJqQvXoHNsh5oI/lb+OGx7CpZyIovetlTt3dLs2n47W/6SWrFmantrvPus87KIuxvcgI4mtlbDPdSymdNX78P+2MiFPmxhKLFa8+mEueZRz3xEmRUG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392744; c=relaxed/simple;
	bh=jhGJ6RfD1Zl2Hq/4VIWyXwmiA+fQDMhbpMVcAeF5j/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LM5N6to7iIQr1lYk+aszh2jaH1LOy8tA+qjOFEOrkKAYHBdHjkvm6zIVWgtUEkk1JLbuJU2rir5HGqSq9bLlLBBOkhOMChvh1/gLsaGd5VLCunqWlsUR0W/wUdzUVf0n2dB9Cwd24ilcmRJ3SZtDlSIpQPxZixVB6+tcQ54NHvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pqDMNCFc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4D81F000E9;
	Thu, 25 Jun 2026 13:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782392743;
	bh=ioZmiBSnDzO2/00hq+XTmM/2W5C1cxaznbbjYeuwCTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pqDMNCFcidNY15sH/SqdVImBRRt1EJCxID30R2IBkuROy0vj0Y5WaH4sk77Dw5FpB
	 ZmV4roPuyfA69fk8iiWZIrtdfDQxxmkvTmL4ijwwTFsBYB9viv0k3a5TKeD7UK8BKo
	 0/78ffXJQyXpRC3IIUyukb0VuxhtPQxb+qWWXFbA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Vasut <marex@nabladev.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 02/60] net: stmmac: fix stm32 (and potentially others) resume regression
Date: Thu, 25 Jun 2026 14:02:47 +0100
Message-ID: <20260625125645.893991929@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625125645.554579168@linuxfoundation.org>
References: <20260625125645.554579168@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268405-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:marex@nabladev.com,m:rmk+kernel@armlinux.org.uk,m:kuba@kernel.org,m:sashal@kernel.org,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B270D6C5E99

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

[ Upstream commit dbbec8c5a79f4c7aa8d07da8c0b5a34d76c50699 ]

Marek reported that suspending stm32 causes the following errors when
the interface is administratively down:

	$ echo devices > /sys/power/pm_test
	$ echo mem > /sys/power/state
	...
	ck_ker_eth2stp already disabled
	...
	ck_ker_eth2stp already unprepared
	...

On suspend, stm32 starts the eth2stp clock in its suspend method, and
stops it in the resume method. This is because the blamed commit omits
the call to the platform glue ->suspend() method, but does make the
call to the platform glue ->resume() method.

This problem affects all other converted drivers as well - e.g. looking
at the PCIe drivers, pci_save_state() will not be called, but
pci_restore_state() will be. Similar issues affect all other drivers.

Fix this by always calling the ->suspend() method, even when the network
interface is down. This fixes all the conversions to the platform glue
->suspend() and ->resume() methods.

Link: https://lore.kernel.org/r/20260114081809.12758-1-marex@nabladev.com
Fixes: 07bbbfe7addf ("net: stmmac: add suspend()/resume() platform ops")
Reported-by: Marek Vasut <marex@nabladev.com>
Tested-by: Marek Vasut <marex@nabladev.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://patch.msgid.link/E1vlujh-00000007Hkw-2p6r@rmk-PC.armlinux.org.uk
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 41b270a486308a..1ceedd74e42908 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7760,7 +7760,7 @@ int stmmac_suspend(struct device *dev)
 	u32 chan;
 
 	if (!ndev || !netif_running(ndev))
-		return 0;
+		goto suspend_bsp;
 
 	mutex_lock(&priv->lock);
 
@@ -7803,6 +7803,7 @@ int stmmac_suspend(struct device *dev)
 	if (stmmac_fpe_supported(priv))
 		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
 
+suspend_bsp:
 	if (priv->plat->suspend)
 		return priv->plat->suspend(dev, priv->plat->bsp_priv);
 
-- 
2.53.0




