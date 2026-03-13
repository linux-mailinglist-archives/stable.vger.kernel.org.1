Return-Path: <stable+bounces-225264-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAO7MuzFs2kqawAAu9opvQ
	(envelope-from <stable+bounces-225264-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 09:08:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9279C27F52B
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 09:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A387F3010BB6
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 08:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069B736604A;
	Fri, 13 Mar 2026 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="y0IuLOD+"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163F7370D73
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773389274; cv=none; b=H7UigLk0Ff7aL9tD75Da/NMYQp9/0Thtg/hv188PBP9yBVgZHCTaSMwyUTDO6vFkGCpzAG6sqMcA+SmBvU7YozBwzbBZt1FAWr2WvLYQ8fsLb8k6nBwPoRbtFiw3k1Bq1Tns2tsZV71EoZ/7+bRbH6EhA5PChH8AyLGLMMJ4jaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773389274; c=relaxed/simple;
	bh=+O1Gnzo/mk9QyPu3GofOBNkxrV7AJ7kC1feydHQhK+I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dm7qFWxKbBflbSqwDBfOivYYV+yDUrOhRRMBmvGiMAzkQKucs95/jRl5Gp1f5MyMNnGHZugfLFI92PtqN+ttXcmw+FYJC/Ev2orXwsl3Utml9uuwNMa6d7uduM9Kdmxvy4As3X27DEsxd1T+6FIJOzeQDgD7qVbcqzrZymwEWpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=y0IuLOD+; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=y0IuLOD+/ZeqPk57XHoB2IS/9GkWdQVI0itXO+Lrm14X2Vbw7kXgrXvcHH2BtO2UrOEZVCrNxw0Ju
	 U3tIwx+Puv8IhnddwBGXpJot4fdoK3VqdWZieBDyBYxd1MMHmtrXHtR2E7ugNpjMxg9u7uX+cvor3L
	 4y3oN22QSs7kUc/g=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[117.129.7.78])
	by rmsmtp-lg-appmail-01-12079 (RichMail) with SMTP id 2f2f69b3c5ca082-e3aef;
	Fri, 13 Mar 2026 16:07:40 +0800 (CST)
X-RM-TRANSID:2f2f69b3c5ca082-e3aef
From: Rajani Kantha <681739313@139.com>
To: alexander.sverdlin@siemens.com,
	vladimir.oltean@nxp.com,
	pabeni@redhat.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.1.y] net: dsa: improve shutdown sequence
Date: Fri, 13 Mar 2026 16:07:32 +0800
Message-Id: <20260313080732.1743-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225264-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[139.com];
	NEURAL_SPAM(0.00)[0.756];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[681739313@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[139.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 9279C27F52B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 6c24a03a61a245fe34d47582898331fa034b6ccd ]

Alexander Sverdlin presents 2 problems during shutdown with the
lan9303 driver. One is specific to lan9303 and the other just happens
to reproduce there.

The first problem is that lan9303 is unique among DSA drivers in that it
calls dev_get_drvdata() at "arbitrary runtime" (not probe, not shutdown,
not remove):

phy_state_machine()
-> ...
   -> dsa_user_phy_read()
      -> ds->ops->phy_read()
         -> lan9303_phy_read()
            -> chip->ops->phy_read()
               -> lan9303_mdio_phy_read()
                  -> dev_get_drvdata()

But we never stop the phy_state_machine(), so it may continue to run
after dsa_switch_shutdown(). Our common pattern in all DSA drivers is
to set drvdata to NULL to suppress the remove() method that may come
afterwards. But in this case it will result in an NPD.

The second problem is that the way in which we set
dp->master->dsa_ptr = NULL; is concurrent with receive packet
processing. dsa_switch_rcv() checks once whether dev->dsa_ptr is NULL,
but afterwards, rather than continuing to use that non-NULL value,
dev->dsa_ptr is dereferenced again and again without NULL checks:
dsa_master_find_slave() and many other places. In between dereferences,
there is no locking to ensure that what was valid once continues to be
valid.

Both problems have the common aspect that closing the master interface
solves them.

In the first case, dev_close(master) triggers the NETDEV_GOING_DOWN
event in dsa_slave_netdevice_event() which closes slave ports as well.
dsa_port_disable_rt() calls phylink_stop(), which synchronously stops
the phylink state machine, and ds->ops->phy_read() will thus no longer
call into the driver after this point.

In the second case, dev_close(master) should do this, as per
Documentation/networking/driver.rst:

| Quiescence
| ----------
|
| After the ndo_stop routine has been called, the hardware must
| not receive or transmit any data.  All in flight packets must
| be aborted. If necessary, poll or wait for completion of
| any reset commands.

So it should be sufficient to ensure that later, when we zeroize
master->dsa_ptr, there will be no concurrent dsa_switch_rcv() call
on this master.

The addition of the netif_device_detach() function is to ensure that
ioctls, rtnetlinks and ethtool requests on the slave ports no longer
propagate down to the driver - we're no longer prepared to handle them.

The race condition actually did not exist when commit 0650bf52b31f
("net: dsa: be compatible with masters which unregister on shutdown")
first introduced dsa_switch_shutdown(). It was created later, when we
stopped unregistering the slave interfaces from a bad spot, and we just
replaced that sequence with a racy zeroization of master->dsa_ptr
(one which doesn't ensure that the interfaces aren't up).

Reported-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Closes: https://lore.kernel.org/netdev/2d2e3bba17203c14a5ffdabc174e3b6bbb9ad438.camel@siemens.com/
Closes: https://lore.kernel.org/netdev/c1bf4de54e829111e0e4a70e7bd1cf523c9550ff.camel@siemens.com/
Fixes: ee534378f005 ("net: dsa: fix panic when DSA master device unbinds on shutdown")
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Tested-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/20240913203549.3081071-1-vladimir.oltean@nxp.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Modification: dsa.c -> dsa2.c to line up the source path in kernel 6.1
Using dp->master and dp->slave instead of dp->conduit and dp->user ]
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 net/dsa/dsa2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index 668699d7b0b7..415e856ba0ac 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -1829,6 +1829,7 @@ EXPORT_SYMBOL_GPL(dsa_unregister_switch);
 void dsa_switch_shutdown(struct dsa_switch *ds)
 {
 	struct net_device *master, *slave_dev;
+	LIST_HEAD(close_list);
 	struct dsa_port *dp;
 
 	mutex_lock(&dsa2_mutex);
@@ -1838,10 +1839,16 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
 
 	rtnl_lock();
 
+	dsa_switch_for_each_cpu_port(dp, ds)
+		list_add(&dp->master->close_list, &close_list);
+
+	dev_close_many(&close_list, true);
+
 	dsa_switch_for_each_user_port(dp, ds) {
 		master = dsa_port_to_master(dp);
 		slave_dev = dp->slave;
 
+		netif_device_detach(slave_dev);
 		netdev_upper_dev_unlink(master, slave_dev);
 	}
 
-- 
2.17.1



