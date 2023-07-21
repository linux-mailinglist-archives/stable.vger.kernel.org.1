Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCDA75D336
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjGUTIK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjGUTIH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:08:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10662FD
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:08:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6980B61D76
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F4EC433C7;
        Fri, 21 Jul 2023 19:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966484;
        bh=PdVtJUaHa3Drk5Mew/Yk8w70V32OPhXvOfdVLBN6Lzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YKui2eTr2OsdS88Rw9jYmGeFnw15G7aPhVCQ+vfS8q5npHcoIco1MaIx2lHMMRitc
         VfPStlf1wS9VIo8GcM+l1JLc2qnqK/70MHgP/Chw9HLNpbjeKQbuSPHG6ZDmY9y00c
         mwi7gheU0KSY5E1HPMVrcoCpdHuNDlB4N8XrI3WQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Abhijeet Rastogi <abhijeet.1989@gmail.com>,
        Julian Anastasov <ja@ssi.bg>, Simon Horman <horms@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Allen Pais <apais@linux.microsoft.com>
Subject: [PATCH 5.15 361/532] ipvs: increase ip_vs_conn_tab_bits range for 64BIT
Date:   Fri, 21 Jul 2023 18:04:25 +0200
Message-ID: <20230721160634.040084429@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Abhijeet Rastogi <abhijeet.1989@gmail.com>

commit 04292c695f82b6cf0d25dd5ae494f16ddbb621f6 upstream.

Current range [8, 20] is set purely due to historical reasons
because at the time, ~1M (2^20) was considered sufficient.
With this change, 27 is the upper limit for 64-bit, 20 otherwise.

Previous change regarding this limit is here.

Link: https://lore.kernel.org/all/86eabeb9dd62aebf1e2533926fdd13fed48bab1f.1631289960.git.aclaudi@redhat.com/T/#u

Signed-off-by: Abhijeet Rastogi <abhijeet.1989@gmail.com>
Acked-by: Julian Anastasov <ja@ssi.bg>
Acked-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Allen Pais <apais@linux.microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/ipvs/Kconfig      |   27 ++++++++++++++-------------
 net/netfilter/ipvs/ip_vs_conn.c |    4 ++--
 2 files changed, 16 insertions(+), 15 deletions(-)

--- a/net/netfilter/ipvs/Kconfig
+++ b/net/netfilter/ipvs/Kconfig
@@ -44,7 +44,8 @@ config	IP_VS_DEBUG
 
 config	IP_VS_TAB_BITS
 	int "IPVS connection table size (the Nth power of 2)"
-	range 8 20
+	range 8 20 if !64BIT
+	range 8 27 if 64BIT
 	default 12
 	help
 	  The IPVS connection hash table uses the chaining scheme to handle
@@ -54,24 +55,24 @@ config	IP_VS_TAB_BITS
 
 	  Note the table size must be power of 2. The table size will be the
 	  value of 2 to the your input number power. The number to choose is
-	  from 8 to 20, the default number is 12, which means the table size
-	  is 4096. Don't input the number too small, otherwise you will lose
-	  performance on it. You can adapt the table size yourself, according
-	  to your virtual server application. It is good to set the table size
-	  not far less than the number of connections per second multiplying
-	  average lasting time of connection in the table.  For example, your
-	  virtual server gets 200 connections per second, the connection lasts
-	  for 200 seconds in average in the connection table, the table size
-	  should be not far less than 200x200, it is good to set the table
-	  size 32768 (2**15).
+	  from 8 to 27 for 64BIT(20 otherwise), the default number is 12,
+	  which means the table size is 4096. Don't input the number too
+	  small, otherwise you will lose performance on it. You can adapt the
+	  table size yourself, according to your virtual server application.
+	  It is good to set the table size not far less than the number of
+	  connections per second multiplying average lasting time of
+	  connection in the table.  For example, your virtual server gets 200
+	  connections per second, the connection lasts for 200 seconds in
+	  average in the connection table, the table size should be not far
+	  less than 200x200, it is good to set the table size 32768 (2**15).
 
 	  Another note that each connection occupies 128 bytes effectively and
 	  each hash entry uses 8 bytes, so you can estimate how much memory is
 	  needed for your box.
 
 	  You can overwrite this number setting conn_tab_bits module parameter
-	  or by appending ip_vs.conn_tab_bits=? to the kernel command line
-	  if IP VS was compiled built-in.
+	  or by appending ip_vs.conn_tab_bits=? to the kernel command line if
+	  IP VS was compiled built-in.
 
 comment "IPVS transport protocol load balancing support"
 
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -1484,8 +1484,8 @@ int __init ip_vs_conn_init(void)
 	int idx;
 
 	/* Compute size and mask */
-	if (ip_vs_conn_tab_bits < 8 || ip_vs_conn_tab_bits > 20) {
-		pr_info("conn_tab_bits not in [8, 20]. Using default value\n");
+	if (ip_vs_conn_tab_bits < 8 || ip_vs_conn_tab_bits > 27) {
+		pr_info("conn_tab_bits not in [8, 27]. Using default value\n");
 		ip_vs_conn_tab_bits = CONFIG_IP_VS_TAB_BITS;
 	}
 	ip_vs_conn_tab_size = 1 << ip_vs_conn_tab_bits;


