Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7692D7BF461
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 09:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442324AbjJJHfg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 03:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442480AbjJJHff (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 03:35:35 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA0592
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 00:35:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1qq7H9-000649-Jg
        for stable@vger.kernel.org; Tue, 10 Oct 2023 09:35:31 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mkl@pengutronix.de>)
        id 1qq7H9-000bft-6L
        for stable@vger.kernel.org; Tue, 10 Oct 2023 09:35:31 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id E3F712332CC
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 07:35:30 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 40D2E2332C1;
        Tue, 10 Oct 2023 07:35:28 +0000 (UTC)
Received: from [192.168.178.131] (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 78e5d358;
        Tue, 10 Oct 2023 07:35:27 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Tue, 10 Oct 2023 09:35:19 +0200
Subject: [PATCH net] net: davicom: dm9000: dm9000_phy_write(): fix deadlock
 during netdev watchdog handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231010-dm9000-fix-deadlock-v1-1-b1f4396f83dd@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIALb+JGUC/x2MwQqDMBAFf0X27MJuigf7K+JBzYsubaMkIgXJv
 zf0OAwzN2UkQ6Znc1PCZdn2WEHbhpZtiivYfGVy4h4qKuw/vYhwsC97TP69Ly8OYVZ0ru8ApVo
 eCdX/rwNFnDSW8gPBJWmzagAAAA==
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Francois Romieu <romieu@fr.zoreil.com>,
        Kalle Valo <kvalo@kernel.org>, Wei Fang <wei.fang@nxp.com>,
        kernel@pengutronix.de, stable@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3626; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Sc3mftr2UYUUpxpiNhGPdSKwphIb/Sb4YKKDRrkV5lY=;
 b=owEBbQGS/pANAwAKAb5QHEoqigToAcsmYgBlJP69zW8mCp5xaHlF81Y9JlWZTPP/4tyQ8283p
 mfgMTQCHnSJATMEAAEKAB0WIQQOzYG9qPI0qV/1MlC+UBxKKooE6AUCZST+vQAKCRC+UBxKKooE
 6EvpB/94Hgr3DSceqXXj+mXSkxYlpzRYu1ajV/vR2TU3grQAdaSrqHQFRIfE5gjqh5Wq/yFvo3O
 iok9eMK+cW7l8jycBLhysbVDt0HNRNllTuOA8+JI1jN9A62zwqtdKMzhMU7saO33B4rm3BszZh/
 EidFVPW3J4ETxN9vK91M/2JrKwPtWCxFRlpBCYtWZlKgp5t0L77NY0HIERURFEBjBVebIklmBWc
 vpo2Oahw8ZfXdF8c96J+O5SZ8rI9YdbO2QTGkha8liRmJS6onQjvLCMyRMcX5l3bpqDiLIKOga6
 8SLPMr85LKHVclnEXK14JWwc+51bkibpq1DkgcHGK2cKFArR
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The dm9000 takes the db->lock spin lock in dm9000_timeout() and calls
into dm9000_init_dm9000(). For the DM9000B the PHY is reset with
dm9000_phy_write(). That function again takes the db->lock spin lock,
which results in a deadlock. For reference the backtrace:

| [<c0425050>] (rt_spin_lock_slowlock_locked) from [<c0425100>] (rt_spin_lock_slowlock+0x60/0xc4)
| [<c0425100>] (rt_spin_lock_slowlock) from [<c02e1174>] (dm9000_phy_write+0x2c/0x1a4)
| [<c02e1174>] (dm9000_phy_write) from [<c02e16b0>] (dm9000_init_dm9000+0x288/0x2a4)
| [<c02e16b0>] (dm9000_init_dm9000) from [<c02e1724>] (dm9000_timeout+0x58/0xd4)
| [<c02e1724>] (dm9000_timeout) from [<c036f298>] (dev_watchdog+0x258/0x2a8)
| [<c036f298>] (dev_watchdog) from [<c0068168>] (call_timer_fn+0x20/0x88)
| [<c0068168>] (call_timer_fn) from [<c00687c8>] (expire_timers+0xf0/0x194)
| [<c00687c8>] (expire_timers) from [<c0068920>] (run_timer_softirq+0xb4/0x25c)
| [<c0068920>] (run_timer_softirq) from [<c0021a30>] (do_current_softirqs+0x16c/0x228)
| [<c0021a30>] (do_current_softirqs) from [<c0021b14>] (run_ksoftirqd+0x28/0x4c)
| [<c0021b14>] (run_ksoftirqd) from [<c0040488>] (smpboot_thread_fn+0x278/0x290)
| [<c0040488>] (smpboot_thread_fn) from [<c003c28c>] (kthread+0x124/0x164)
| [<c003c28c>] (kthread) from [<c00090f0>] (ret_from_fork+0x14/0x24)

To workaround similar problem (take mutex inside spin lock ) , a
"in_timeout" variable was added in 582379839bbd ("dm9000: avoid
sleeping in dm9000_timeout callback"). Use this variable and not take
the spin lock inside dm9000_phy_write() if in_timeout is true.

Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
During the netdev watchdog handling the dm9000 driver takes the same
spin lock twice. Avoid this by extending an existing workaround.
---
 drivers/net/ethernet/davicom/dm9000.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
index 05a89ab6766c..3a056a54aaf9 100644
--- a/drivers/net/ethernet/davicom/dm9000.c
+++ b/drivers/net/ethernet/davicom/dm9000.c
@@ -325,10 +325,10 @@ dm9000_phy_write(struct net_device *dev,
 	unsigned long reg_save;
 
 	dm9000_dbg(db, 5, "phy_write[%02x] = %04x\n", reg, value);
-	if (!db->in_timeout)
+	if (!db->in_timeout) {
 		mutex_lock(&db->addr_lock);
-
-	spin_lock_irqsave(&db->lock, flags);
+		spin_lock_irqsave(&db->lock, flags);
+	}
 
 	/* Save previous register address */
 	reg_save = readb(db->io_addr);
@@ -344,11 +344,13 @@ dm9000_phy_write(struct net_device *dev,
 	iow(db, DM9000_EPCR, EPCR_EPOS | EPCR_ERPRW);
 
 	writeb(reg_save, db->io_addr);
-	spin_unlock_irqrestore(&db->lock, flags);
+	if (!db->in_timeout)
+		spin_unlock_irqrestore(&db->lock, flags);
 
 	dm9000_msleep(db, 1);		/* Wait write complete */
 
-	spin_lock_irqsave(&db->lock, flags);
+	if (!db->in_timeout)
+		spin_lock_irqsave(&db->lock, flags);
 	reg_save = readb(db->io_addr);
 
 	iow(db, DM9000_EPCR, 0x0);	/* Clear phyxcer write command */
@@ -356,9 +358,10 @@ dm9000_phy_write(struct net_device *dev,
 	/* restore the previous address */
 	writeb(reg_save, db->io_addr);
 
-	spin_unlock_irqrestore(&db->lock, flags);
-	if (!db->in_timeout)
+	if (!db->in_timeout) {
+		spin_unlock_irqrestore(&db->lock, flags);
 		mutex_unlock(&db->addr_lock);
+	}
 }
 
 /* dm9000_set_io

---
base-commit: 776fe19953b0e0af00399e50fb3b205101d4b3c1
change-id: 20231010-dm9000-fix-deadlock-ffb1e5295ee1

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>


