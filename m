Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4FE72C032
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjFLKuj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbjFLKuG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:50:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F858C9
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:34:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E351C623DC
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052CBC433EF;
        Mon, 12 Jun 2023 10:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566093;
        bh=iqCpe1mLOD8pYHFRrbycRXXwBc0e60eWxTBwRl15On8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=luAQNiniFgnCBmLZPlqo/+UCkMLPnMI417utR4yTsFpayA4DO6nBaMzP1PpYvasyM
         alqP7IBlHR0a0cgNT7dgNgDGbkgfchaMQNMVEQbAJ+ARZ4kdpX79MEfwG/AwxC2tvM
         qXhE+heJ968C8WQst5jX4jgGyz7E1Moc7EKFuWCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.10 62/68] tcp: fix tcp_min_tso_segs sysctl
Date:   Mon, 12 Jun 2023 12:26:54 +0200
Message-ID: <20230612101701.028282799@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101658.437327280@linuxfoundation.org>
References: <20230612101658.437327280@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

commit d24f511b04b8b159b705ec32a3b8782667d1b06a upstream.

tcp_min_tso_segs is now stored in u8, so max value is 255.

255 limit is enforced by proc_dou8vec_minmax().

We can therefore remove the gso_max_segs variable.

Fixes: 47996b489bdc ("tcp: convert elligible sysctls to u8")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/sysctl_net_ipv4.c |    2 --
 1 file changed, 2 deletions(-)

--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -31,7 +31,6 @@
 static int two = 2;
 static int four = 4;
 static int thousand = 1000;
-static int gso_max_segs = GSO_MAX_SEGS;
 static int tcp_retr1_max = 255;
 static int ip_local_port_range_min[] = { 1, 1 };
 static int ip_local_port_range_max[] = { 65535, 65535 };
@@ -1193,7 +1192,6 @@ static struct ctl_table ipv4_net_table[]
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
 		.extra1		= SYSCTL_ONE,
-		.extra2		= &gso_max_segs,
 	},
 	{
 		.procname	= "tcp_min_rtt_wlen",


