Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591F6713EBB
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjE1TiR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjE1TiQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:38:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81EEAB
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:38:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DD6261E78
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1B3C433D2;
        Sun, 28 May 2023 19:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302694;
        bh=oyyn4KZunJtb3sLgatkDof/E/uxkqjH/c3QQBwEkKa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3qzPHS9bd+qc3amRQfHgoY6vSIkOdfaTJgnYXVppnzSWCmDJIcRnLJzekoXLh2uW
         rnf1/pXoBwcr2doo294I6/m+/8fhTZ4Ghy9kIa3Ss+r4h3JeelQfQB6qly1kVnpPnm
         Q/ZBoPySYXK/FGA3LNq+0uZFdVO9+Z3FZjhvucss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 100/119] sctp: fix an issue that plpmtu can never go to complete state
Date:   Sun, 28 May 2023 20:11:40 +0100
Message-Id: <20230528190838.839695717@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Xin Long <lucien.xin@gmail.com>

commit 6ca328e985cd995dfd1d5de44046e6074f853fbb upstream.

When doing plpmtu probe, the probe size is growing every time when it
receives the ACK during the Search state until the probe fails. When
the failure occurs, pl.probe_high is set and it goes to the Complete
state.

However, if the link pmtu is huge, like 65535 in loopback_dev, the probe
eventually keeps using SCTP_MAX_PLPMTU as the probe size and never fails.
Because of that, pl.probe_high can not be set, and the plpmtu probe can
never go to the Complete state.

Fix it by setting pl.probe_high to SCTP_MAX_PLPMTU when the probe size
grows to SCTP_MAX_PLPMTU in sctp_transport_pl_recv(). Also, not allow
the probe size greater than SCTP_MAX_PLPMTU in the Complete state.

Fixes: b87641aff9e7 ("sctp: do state transition when a probe succeeds on HB ACK recv path")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/transport.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -324,9 +324,12 @@ bool sctp_transport_pl_recv(struct sctp_
 		t->pl.probe_size += SCTP_PL_BIG_STEP;
 	} else if (t->pl.state == SCTP_PL_SEARCH) {
 		if (!t->pl.probe_high) {
-			t->pl.probe_size = min(t->pl.probe_size + SCTP_PL_BIG_STEP,
-					       SCTP_MAX_PLPMTU);
-			return false;
+			if (t->pl.probe_size < SCTP_MAX_PLPMTU) {
+				t->pl.probe_size = min(t->pl.probe_size + SCTP_PL_BIG_STEP,
+						       SCTP_MAX_PLPMTU);
+				return false;
+			}
+			t->pl.probe_high = SCTP_MAX_PLPMTU;
 		}
 		t->pl.probe_size += SCTP_PL_MIN_STEP;
 		if (t->pl.probe_size >= t->pl.probe_high) {
@@ -341,7 +344,7 @@ bool sctp_transport_pl_recv(struct sctp_
 	} else if (t->pl.state == SCTP_PL_COMPLETE) {
 		/* Raise probe_size again after 30 * interval in Search Complete */
 		t->pl.state = SCTP_PL_SEARCH; /* Search Complete -> Search */
-		t->pl.probe_size += SCTP_PL_MIN_STEP;
+		t->pl.probe_size = min(t->pl.probe_size + SCTP_PL_MIN_STEP, SCTP_MAX_PLPMTU);
 	}
 
 	return t->pl.state == SCTP_PL_COMPLETE;


