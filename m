Return-Path: <stable+bounces-192672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B80C3E51E
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 04:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2418D4E6179
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 03:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBC6263F5E;
	Fri,  7 Nov 2025 03:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="YMLzOiBj"
X-Original-To: stable@vger.kernel.org
Received: from n169-113.mail.139.com (n169-113.mail.139.com [120.232.169.113])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8104A41
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 03:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762485314; cv=none; b=mhVynXa0qqMqsjjAmBMMo30K446ThknJlzvkTkPSZwLIUcn1GTd4JNqckeH089Tp1zvrT8aNcGKjm5AQQfTQNLdjmoHe9kZtc6kJyC8tbuBW7KNJgsslIEsEAbyZZLkPoGOifK9s9ivix7CFBdyJSgvNkszUn0bZGZDP3tOIph8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762485314; c=relaxed/simple;
	bh=pv7c1nfQH6OTTNMK54BI8Ty3uchRho7vh6jVSBQAWr8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QjKwGtqFSnU2ybeRTpVXGTRKQU/jV/8VZVncjuI3LzLi0+znBTaQ662HYQ0b60deIsmlg8g708h7bc+/Ei/5UBoR3KB7vOEzKEd43Rc+LGz/YBglzRbE/1QcQXUQciC4Z9pJt8Wq6Wa+cP0GZDfiaVm7G0LCn4q9601vvws397w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=YMLzOiBj; arc=none smtp.client-ip=120.232.169.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=YMLzOiBjS3+Fokff/jeNWPh0qnoqI7TV6Hgpl1SE0FB5sR8TfqcsYLHPcKFAhAC+K7Q03img8E177
	 t9JI5P8GcUVUpBwjHXP2GQpALfZPVSOUYj/qs6qVciUjIisWSqj9TwaqUKRx6DRlKgOoLkgfNIPxU0
	 6zZfQ7Y19LdnYix8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[117.129.7.61])
	by rmsmtp-lg-appmail-29-12034 (RichMail) with SMTP id 2f02690d637a273-46591;
	Fri, 07 Nov 2025 11:11:57 +0800 (CST)
X-RM-TRANSID:2f02690d637a273-46591
From: Rajani Kantha <681739313@139.com>
To: alexander.sverdlin@siemens.com,
	vladimir.oltean@nxp.com,
	pabeni@redhat.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6.y] net: dsa: improve shutdown sequence
Date: Fri,  7 Nov 2025 11:11:55 +0800
Message-Id: <20251107031155.3026-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

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
[ Modification: Using dp->master and dp->slave instead of dp->conduit and dp->user ]
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 net/dsa/dsa.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 07736edc8b6a..c9bf1a9a6c99 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1613,6 +1613,7 @@ EXPORT_SYMBOL_GPL(dsa_unregister_switch);
 void dsa_switch_shutdown(struct dsa_switch *ds)
 {
 	struct net_device *master, *slave_dev;
+	LIST_HEAD(close_list);
 	struct dsa_port *dp;
 
 	mutex_lock(&dsa2_mutex);
@@ -1622,10 +1623,16 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
 
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



