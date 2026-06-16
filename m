Return-Path: <stable+bounces-265316-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cTM2M22IMWp9lwUAu9opvQ
	(envelope-from <stable+bounces-265316-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:31:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C31693377
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:31:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=lsp3kd9Z;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265316-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-265316-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7F913015617
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E211144BCBE;
	Tue, 16 Jun 2026 17:23:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FE01A6803;
	Tue, 16 Jun 2026 17:23:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630585; cv=none; b=jrm9Y9yXvIArDeqOpcHCJ7BEdo0zjqnvJgtDmEl2wNJr5Qm52wxTicMptigvyS1O8W3ntU1sK24ATXqm8HORXG83cnk6kJmh+RsWrkuhD3GUSvQ+UDSsriUTx75OoiOHyLynu7Yz9EeG9HhYmkTKmh1U1XnQj4yQmxpxHiD4XAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630585; c=relaxed/simple;
	bh=RQFaTx/AQhGdIiJgBNtxwrUDiidbGqMUWDCfejVeoxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcMSM/FlCmOZWBKP8UJNkGjuBvHCoM49RdIl3aBPJRkGZsCFYzcmMZs/bFNK48XnF2GeYKXngHS6cBV5bqKi+tL0zJr69EQejkbkkXe5j4MaAlMlmbA4fvkJkRv1SkyJI9BLBS13zxCnIdNtHPEBHd7Hu0a+IFP05PyHiFIW6Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lsp3kd9Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B778A1F000E9;
	Tue, 16 Jun 2026 17:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781630584;
	bh=1wYvXTXrJb15JdkWPG4FWbQhFpZ2HlE+oJTimrx+1ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lsp3kd9Z4qSWUZ9RzalEBrqRPcCC+9aLrsomZ6km4yeEPwBYhcra9QeGZV6jw+q4H
	 DDwkUIkhY4w6H/6utE8Fp4JCLLOoVVXGVH60esy4SueKm431nkfp6uvXC6yY/ky9ns
	 9CxKDVF6lMk23UH1Z5KobdnbKXhFAxkuBexwJz28=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 030/522] bonding: refuse to enslave CAN devices
Date: Tue, 16 Jun 2026 20:22:57 +0530
Message-ID: <20260616145127.060289281@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265316-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com,m:socketcan@hartkopp.net,m:jv@jvosburgh.net,m:kuba@kernel.org,m:sashal@kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,8ed98cbd0161632bce95];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,syzkaller.appspot.com:url,hartkopp.net:email,jvosburgh.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7C31693377

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Hartkopp <socketcan@hartkopp.net>

[ Upstream commit 8ba68464e4787b6a7ec938826e16124df20fd23d ]

syzbot reported a kernel paging request crash in
can_rx_unregister() inside net/can/af_can.c. The crash occurs
because a virtual CAN device (vxcan) is being enslaved to a
bonding master.

During the enslavement process, the bonding driver mutates
and modifies the network device states to fit an Ethernet-like
aggregation model. However, CAN devices operate on a completely
different Layer 2 architecture, relying on the CAN mid-layer
private data structure (can_ml_priv) instead of standard
Ethernet structures. Since bonding does not initialize or
maintain these CAN structures, subsequent operations on the
half-enslaved interface (such as closing associated sockets
via isotp_release) lead to a null-pointer dereference when
accessing the CAN receiver lists.

Bonding CAN interfaces is architecturally invalid as CAN lacks
MAC addresses, ARP capabilities, and standard Ethernet
link-layer mechanisms. While generic loopback devices are
blocked globally in net/core/dev.c, virtual CAN devices
bypass this check because they do not carry the IFF_LOOPBACK
flag, despite acting as local software-loopbacks.

Fix this by explicitly blocking network devices of type
ARPHRD_CAN from being enslaved at the very beginning of
bond_enslave(). This prevents illegal state mutations,
eliminates the resulting KASAN crashes, and avoids potential
memory leaks from incomplete socket cleanups.

As the CAN support has been added a long time after bonding
the Fixes-tag points to the introduction of ARPHRD_CAN that
would have needed a specific handling in bonding_main.c.

Fixes: cd05acfe65ed ("[CAN]: Allocate protocol numbers for PF_CAN")
Reported-by: syzbot+8ed98cbd0161632bce95@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8ed98cbd0161632bce95
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Jay Vosburgh <jv@jvosburgh.net>
Link: https://patch.msgid.link/20260526-bonding-candev-v1-1-ba1df400918a@hartkopp.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e9e2dec1dcb131..0e078252b52a98 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1848,6 +1848,12 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	int link_reporting;
 	int res = 0, i;
 
+	if (slave_dev->type == ARPHRD_CAN) {
+		BOND_NL_ERR(bond_dev, extack,
+			    "CAN devices cannot be enslaved");
+		return -EPERM;
+	}
+
 	if (slave_dev->flags & IFF_MASTER &&
 	    !netif_is_bond_master(slave_dev)) {
 		BOND_NL_ERR(bond_dev, extack,
-- 
2.53.0




