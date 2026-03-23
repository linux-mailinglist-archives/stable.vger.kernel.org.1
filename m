Return-Path: <stable+bounces-229133-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPvJG+JXwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-229133-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:10:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 069472F5E84
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 215723050203
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEA2250BEC;
	Mon, 23 Mar 2026 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cABkO9IP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B89248896;
	Mon, 23 Mar 2026 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278165; cv=none; b=ArN5dHTVyLzwzP2jTCFoT/60iy/q0H9oTJL/jIxC+g8+XeRW1h7chM9us4KjIIMEhHkxU3OJl90cNl/BXNADEDYsGYHAducMKUhTqaYEaRPO6TfSGS8lPcpahnHsXOSUL4keBLoUUOgXYfZ1iRyhtO0GWHXXjhSGojNfJZLwa0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278165; c=relaxed/simple;
	bh=XiebRwaXb2GXSQvTD+Kdeh7j/wUGDxlcMtdOXSAeTLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzhjUMEui6XNc217WZf9Zsh8ifg3YEInRDtVs6R/OHDxcqFLLPJkpO+j+uTLcJGV466e1wbl2M7Oe8gfHDTt53dhAW9ttKH/pQeE0YR47hbeHOHlsgiaeX+T8gAv+obybzb42vEtOZfll/iusR+F6k8haBkEAAVx3xOxDPsJlXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cABkO9IP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8071BC4CEF7;
	Mon, 23 Mar 2026 15:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278164;
	bh=XiebRwaXb2GXSQvTD+Kdeh7j/wUGDxlcMtdOXSAeTLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cABkO9IPPKx8JNaYC+UCcMmzqiR+4J2+f7e3ygPzoYAOqI7ap8L+YK3pk5+VPtQPr
	 laXm63oApvwrXHVpyDSrin8/gnjwkf4CBrs5U/VrRaepQdUp1EaGKdVgwzgGB8yHau
	 Aat223CqiTqNAjJTk98G3/vBkSSeIGpObCqFs+z0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 220/567] bonding: handle BOND_LINK_FAIL, BOND_LINK_BACK as valid link states
Date: Mon, 23 Mar 2026 14:42:20 +0100
Message-ID: <20260323134539.273607436@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229133-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 069472F5E84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 3348be7978f450ede0c308a4e8416ac716cf1015 ]

Before the fixed commit, we check slave->new_link during commit
state, which values are only BOND_LINK_{NOCHANGE, UP, DOWN}. After
the commit, we start using slave->link_new_state, which state also could
be BOND_LINK_{FAIL, BACK}.

For example, when we set updelay/downdelay, after a failover,
the slave->link_new_state could be set to BOND_LINK_{FAIL, BACK} in
bond_miimon_inspect(). And later in bond_miimon_commit(), it will treat
it as invalid and print an error, which would cause confusion for users.

[  106.440254] bond0: (slave veth2): link status down for interface, disabling it in 200 ms
[  106.440265] bond0: (slave veth2): invalid new link 1 on slave
[  106.648276] bond0: (slave veth2): link status definitely down, disabling slave
[  107.480271] bond0: (slave veth2): link status up, enabling it in 200 ms
[  107.480288] bond0: (slave veth2): invalid new link 3 on slave
[  107.688302] bond0: (slave veth2): link status definitely up, 10000 Mbps full duplex

Let's handle BOND_LINK_{FAIL, BACK} as valid link states.

Fixes: 1899bb325149 ("bonding: fix state transition issue in link monitoring")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://patch.msgid.link/20260304-b4-bond_updelay-v1-2-f72eb2e454d0@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index a2bf7bb12ff7c..b36d1781d8463 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2859,8 +2859,14 @@ static void bond_miimon_commit(struct bonding *bond)
 
 			continue;
 
+		case BOND_LINK_FAIL:
+		case BOND_LINK_BACK:
+			slave_dbg(bond->dev, slave->dev, "link_new_state %d on slave\n",
+				  slave->link_new_state);
+			continue;
+
 		default:
-			slave_err(bond->dev, slave->dev, "invalid new link %d on slave\n",
+			slave_err(bond->dev, slave->dev, "invalid link_new_state %d on slave\n",
 				  slave->link_new_state);
 			bond_propose_link_state(slave, BOND_LINK_NOCHANGE);
 
-- 
2.51.0




