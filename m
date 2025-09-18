Return-Path: <stable+bounces-173725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C89CDB35E09
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4653A60FE
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489F32BE7A7;
	Tue, 26 Aug 2025 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X6MeE5r3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC02283FDF;
	Tue, 26 Aug 2025 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208995; cv=none; b=k6jktn+LVG8BPZiZC7nC8IgM7JOnpmwA3PYW1ZXOtfnefzLCXwJdKyIEk7iKyJ7Y5n78qv5H4SajLTVQPoLM/gHA2T8IM2ddqmdnRiIwpZOgzqLedCjAPf5v+LXmjtZ4kbOUk0yzHn6KYAN8aVyc3OYDoIDHv+4PFw40X/Sehjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208995; c=relaxed/simple;
	bh=ndCmgxChmYn6/pzaKCVhQL3xveSv3/ULTstG/GjbAGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVJEavQuztZAX0hja+JzH3UbJ52B4rPTaOUNHRHWmXPC64Z6ZQusmyquBSTDaH0EonMVu5Xw+FDcAQMkphD0VJeGRv+jpgPOV+t9tRqXEAfFCqdubt5uYI2O1L528dysiGFvjAPmcIZ2xNu9zE7gITBVr2AwHaHRawbtTHy27n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X6MeE5r3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828E2C4CEF1;
	Tue, 26 Aug 2025 11:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208994;
	bh=ndCmgxChmYn6/pzaKCVhQL3xveSv3/ULTstG/GjbAGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X6MeE5r3NsaS9WrB4hix/eUbVmYNYah9XKJJhlSzMvjxpzKHqNjinM4AlzztD/mmq
	 yy2azLsjyAFy18JUTVqGW2nuUvd4ALEyePHRWWIsgaretDcfJG+cOdHiGNBpC7ckMz
	 VPBJ5PEYkjX1wgzI6ZGfQQ/nVPm7iaLnBHytZ38I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hangbin Liu <liuhangbin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 310/322] bonding: update LACP activity flag after setting lacp_active
Date: Tue, 26 Aug 2025 13:12:05 +0200
Message-ID: <20250826110923.547165092@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit b64d035f77b1f02ab449393342264b44950a75ae ]

The port's actor_oper_port_state activity flag should be updated immediately
after changing the lacp_active option to reflect the current mode correctly.

Fixes: 3a755cd8b7c6 ("bonding: add new option lacp_active")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://patch.msgid.link/20250815062000.22220-2-liuhangbin@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_3ad.c     | 25 +++++++++++++++++++++++++
 drivers/net/bonding/bond_options.c |  1 +
 include/net/bond_3ad.h             |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index c6807e473ab7..a51305423d28 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -2869,6 +2869,31 @@ void bond_3ad_update_lacp_rate(struct bonding *bond)
 	spin_unlock_bh(&bond->mode_lock);
 }
 
+/**
+ * bond_3ad_update_lacp_active - change the lacp active
+ * @bond: bonding struct
+ *
+ * Update actor_oper_port_state when lacp_active is modified.
+ */
+void bond_3ad_update_lacp_active(struct bonding *bond)
+{
+	struct port *port = NULL;
+	struct list_head *iter;
+	struct slave *slave;
+	int lacp_active;
+
+	lacp_active = bond->params.lacp_active;
+	spin_lock_bh(&bond->mode_lock);
+	bond_for_each_slave(bond, slave, iter) {
+		port = &(SLAVE_AD_INFO(slave)->port);
+		if (lacp_active)
+			port->actor_oper_port_state |= LACP_STATE_LACP_ACTIVITY;
+		else
+			port->actor_oper_port_state &= ~LACP_STATE_LACP_ACTIVITY;
+	}
+	spin_unlock_bh(&bond->mode_lock);
+}
+
 size_t bond_3ad_stats_size(void)
 {
 	return nla_total_size_64bit(sizeof(u64)) + /* BOND_3AD_STAT_LACPDU_RX */
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index d1b095af253b..e27d913b487b 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1634,6 +1634,7 @@ static int bond_option_lacp_active_set(struct bonding *bond,
 	netdev_dbg(bond->dev, "Setting LACP active to %s (%llu)\n",
 		   newval->string, newval->value);
 	bond->params.lacp_active = newval->value;
+	bond_3ad_update_lacp_active(bond);
 
 	return 0;
 }
diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
index 2053cd8e788a..dba369a2cf27 100644
--- a/include/net/bond_3ad.h
+++ b/include/net/bond_3ad.h
@@ -307,6 +307,7 @@ int bond_3ad_lacpdu_recv(const struct sk_buff *skb, struct bonding *bond,
 			 struct slave *slave);
 int bond_3ad_set_carrier(struct bonding *bond);
 void bond_3ad_update_lacp_rate(struct bonding *bond);
+void bond_3ad_update_lacp_active(struct bonding *bond);
 void bond_3ad_update_ad_actor_settings(struct bonding *bond);
 int bond_3ad_stats_fill(struct sk_buff *skb, struct bond_3ad_stats *stats);
 size_t bond_3ad_stats_size(void);
-- 
2.50.1




