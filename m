Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A8175CDA8
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjGUQNv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjGUQNb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:13:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D368422A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:13:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7935D61D40
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D1DC433C9;
        Fri, 21 Jul 2023 16:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955981;
        bh=zhTXA1Xv7tGlYLYz13x98c08ZeGZI4qjcSs/S4P/M6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fS2dPWwqbZaD6H9oDmFywTeL/CggKtBndGJSHBtAbdnJ5pJWA2UrKNtQiIWKD0Wtv
         /umwQfBRCpwgXlLjQVJS3L0ONE4Tqv00LS15iTrpg5p1CEoIlw3aBPznzN58d9FjfZ
         cdkvjhDMlsRTe6vM/opEq69OsI84ZIvyWFH3vpK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Florian Kauer <florian.kauer@linutronix.de>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Naama Meir <naamax.meir@linux.intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 075/292] igc: No strict mode in pure launchtime/CBS offload
Date:   Fri, 21 Jul 2023 18:03:04 +0200
Message-ID: <20230721160532.025773965@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Kauer <florian.kauer@linutronix.de>

[ Upstream commit 8b86f10ab64eca0287ea8f7c94e9ad8b2e101c01 ]

The flags IGC_TXQCTL_STRICT_CYCLE and IGC_TXQCTL_STRICT_END
prevent the packet transmission over slot and cycle boundaries.
This is important for taprio offload where the slots and
cycles correspond to the slots and cycles configured for the
network.

However, the Qbv offload feature of the i225 is also used for
enabling TX launchtime / ETF offload. In that case, however,
the cycle has no meaning for the network and is only used
internally to adapt the base time register after a second has
passed.

Enabling strict mode in this case would unnecessarily prevent
the transmission of certain packets (i.e. at the boundary of a
second) and thus interferes with the ETF qdisc that promises
transmission at a certain point in time.

Similar to ETF, this also applies to CBS offload that also should
not be influenced by strict mode unless taprio offload would be
enabled at the same time.

This fully reverts
commit d8f45be01dd9 ("igc: Use strict cycles for Qbv scheduling")
but its commit message only describes what was already implemented
before that commit. The difference to a plain revert of that commit
is that it now copes with the base_time = 0 case that was fixed with
commit e17090eb2494 ("igc: allow BaseTime 0 enrollment for Qbv")

In particular, enabling strict mode leads to TX hang situations
under high traffic if taprio is applied WITHOUT taprio offload
but WITH ETF offload, e.g. as in

    sudo tc qdisc replace dev enp1s0 parent root handle 100 taprio \
	    num_tc 1 \
	    map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \
	    queues 1@0 \
	    base-time 0 \
	    sched-entry S 01 300000 \
	    flags 0x1 \
	    txtime-delay 500000 \
	    clockid CLOCK_TAI
    sudo tc qdisc replace dev enp1s0 parent 100:1 etf \
	    clockid CLOCK_TAI \
	    delta 500000 \
	    offload \
	    skip_sock_check

and traffic generator

    sudo trafgen -i traffic.cfg -o enp1s0 --cpp -n0 -q -t1400ns

with traffic.cfg

    #define ETH_P_IP        0x0800

    {
      /* Ethernet Header */
      0x30, 0x1f, 0x9a, 0xd0, 0xf0, 0x0e,  # MAC Dest - adapt as needed
      0x24, 0x5e, 0xbe, 0x57, 0x2e, 0x36,  # MAC Src  - adapt as needed
      const16(ETH_P_IP),

      /* IPv4 Header */
      0b01000101, 0,   # IPv4 version, IHL, TOS
      const16(1028),   # IPv4 total length (UDP length + 20 bytes (IP header))
      const16(2),      # IPv4 ident
      0b01000000, 0,   # IPv4 flags, fragmentation off
      64,              # IPv4 TTL
      17,              # Protocol UDP
      csumip(14, 33),  # IPv4 checksum

      /* UDP Header */
      10,  0, 48, 1,   # IP Src - adapt as needed
      10,  0, 48, 10,  # IP Dest - adapt as needed
      const16(5555),   # UDP Src Port
      const16(6666),   # UDP Dest Port
      const16(1008),   # UDP length (UDP header 8 bytes + payload length)
      csumudp(14, 34), # UDP checksum

      /* Payload */
      fill('W', 1000),
    }

and the observed message with that is for example

 igc 0000:01:00.0 enp1s0: Detected Tx Unit Hang
   Tx Queue             <0>
   TDH                  <d0>
   TDT                  <f0>
   next_to_use          <f0>
   next_to_clean        <d0>
 buffer_info[next_to_clean]
   time_stamp           <ffff661f>
   next_to_watch        <00000000245a4efb>
   jiffies              <ffff6e48>
   desc.status          <1048000>

Fixes: d8f45be01dd9 ("igc: Use strict cycles for Qbv scheduling")
Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_tsn.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index b76ebfc10b1d5..a9c08321aca90 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -132,8 +132,28 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 		wr32(IGC_STQT(i), ring->start_time);
 		wr32(IGC_ENDQT(i), ring->end_time);
 
-		txqctl |= IGC_TXQCTL_STRICT_CYCLE |
-			IGC_TXQCTL_STRICT_END;
+		if (adapter->taprio_offload_enable) {
+			/* If taprio_offload_enable is set we are in "taprio"
+			 * mode and we need to be strict about the
+			 * cycles: only transmit a packet if it can be
+			 * completed during that cycle.
+			 *
+			 * If taprio_offload_enable is NOT true when
+			 * enabling TSN offload, the cycle should have
+			 * no external effects, but is only used internally
+			 * to adapt the base time register after a second
+			 * has passed.
+			 *
+			 * Enabling strict mode in this case would
+			 * unnecessarily prevent the transmission of
+			 * certain packets (i.e. at the boundary of a
+			 * second) and thus interfere with the launchtime
+			 * feature that promises transmission at a
+			 * certain point in time.
+			 */
+			txqctl |= IGC_TXQCTL_STRICT_CYCLE |
+				IGC_TXQCTL_STRICT_END;
+		}
 
 		if (ring->launchtime_enable)
 			txqctl |= IGC_TXQCTL_QUEUE_MODE_LAUNCHT;
-- 
2.39.2



