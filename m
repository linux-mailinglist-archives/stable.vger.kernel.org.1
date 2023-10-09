Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1C87BDDDF
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376707AbjJINOG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376930AbjJINNm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:13:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87A5BA
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:13:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 237E6C433C9;
        Mon,  9 Oct 2023 13:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857193;
        bh=PsXWdq1VqnxExxb/O/jgCKy372DS1pwN9Ucpqft8kco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9+csVSqLmN2i4iKeazfoogs3c/bVN96kNADrBM62KprM3vsLStt3JIT5KMqPnyEf
         wycPS8/qUxPDrxhHa7sdaLhipxtCtpTYhIXL/jd2QmWGpW52jFp+p+9mITed3HKhfq
         ZaLCp1hkps/LLMpXfXH5NG6/qEMjZdoVi4ngn4ew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xin Long <lucien.xin@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 128/163] sctp: update transport state when processing a dupcook packet
Date:   Mon,  9 Oct 2023 15:01:32 +0200
Message-ID: <20231009130127.576865754@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 2222a78075f0c19ca18db53fd6623afb4aff602d ]

During the 4-way handshake, the transport's state is set to ACTIVE in
sctp_process_init() when processing INIT_ACK chunk on client or
COOKIE_ECHO chunk on server.

In the collision scenario below:

  192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
    192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
    192.168.1.2 > 192.168.1.1: sctp (1) [INIT ACK] [init tag: 3922216408]
    192.168.1.1 > 192.168.1.2: sctp (1) [COOKIE ECHO]
    192.168.1.2 > 192.168.1.1: sctp (1) [COOKIE ACK]
  192.168.1.1 > 192.168.1.2: sctp (1) [INIT ACK] [init tag: 3914796021]

when processing COOKIE_ECHO on 192.168.1.2, as it's in COOKIE_WAIT state,
sctp_sf_do_dupcook_b() is called by sctp_sf_do_5_2_4_dupcook() where it
creates a new association and sets its transport to ACTIVE then updates
to the old association in sctp_assoc_update().

However, in sctp_assoc_update(), it will skip the transport update if it
finds a transport with the same ipaddr already existing in the old asoc,
and this causes the old asoc's transport state not to move to ACTIVE
after the handshake.

This means if DATA retransmission happens at this moment, it won't be able
to enter PF state because of the check 'transport->state == SCTP_ACTIVE'
in sctp_do_8_2_transport_strike().

This patch fixes it by updating the transport in sctp_assoc_update() with
sctp_assoc_add_peer() where it updates the transport state if there is
already a transport with the same ipaddr exists in the old asoc.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/r/fd17356abe49713ded425250cc1ae51e9f5846c6.1696172325.git.lucien.xin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/associola.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/sctp/associola.c b/net/sctp/associola.c
index 796529167e8d2..c45c192b78787 100644
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -1159,8 +1159,7 @@ int sctp_assoc_update(struct sctp_association *asoc,
 		/* Add any peer addresses from the new association. */
 		list_for_each_entry(trans, &new->peer.transport_addr_list,
 				    transports)
-			if (!sctp_assoc_lookup_paddr(asoc, &trans->ipaddr) &&
-			    !sctp_assoc_add_peer(asoc, &trans->ipaddr,
+			if (!sctp_assoc_add_peer(asoc, &trans->ipaddr,
 						 GFP_ATOMIC, trans->state))
 				return -ENOMEM;
 
-- 
2.40.1



